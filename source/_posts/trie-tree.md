---
title: 字典树的Go语言实现
date: 2017-02-23 16:07:42
categories: 工具
tags: [Go, 工具, 敏感词]
---

刚学Go语言练手,用于敏感词匹配
字典树的Go语言实现

<!-- more -->

```go
package triecheck

import (
	"strings"
)

// 参考( http://blog.csdn.net/workwithwebis3w/article/details/38294889 )
// 敏感词字典树
type TrieTree struct {
	root map[string]interface{}
}

// 获取字典树
func (t *TrieTree) GetRoot() map[string]interface{} {
	return t.root
}

/*
 * 添加单词到字典树(Trie Tree)
 */
func (t *TrieTree) AddWord(word string) {
	if len(word) == 0 {
		return
	}
	if t.root == nil {
		t.root = make(map[string]interface{})
	}
	var wordArray = strings.Split(word, "")
	var wordLen = len(wordArray)
	var current = t.root
	for i := 0; i < wordLen; i++ {
		if current[wordArray[i]] == nil {
			current[wordArray[i]] = make(map[string]interface{})
		}
		current = (current[wordArray[i]]).(map[string]interface{})
		if i == (wordLen - 1) {
			current["END"] = true
		}
	}
}

/*
 * 替换敏感词(尽量匹配最长敏感词)
 * input: 输入字符串
 * mask: 敏感词替换字符
 *
 * 返回: 替换后的字符串, 是否有敏感词
 */
func (t *TrieTree) MaxReplaceWith(input string, mask string) (string, bool) {
	if len(input) == 0 || t.root == nil {
		return input, false
	}
	var textArray = strings.Split(input, "")
	var textLen = len(textArray)
	var modified = false
	for i := 0; i < textLen; i++ {
		var charLen = 0
		var current = t.root
		var pos = i
		var lastI = -1
		var lastLen = -1
		for current[textArray[pos]] != nil {
			current = (current[textArray[pos]]).(map[string]interface{})
			charLen += 1
			if current["END"] == true {
				lastI = i
				lastLen = charLen
			}
			if pos == (textLen - 1) {
				break
			}
			pos++
		}
		if lastLen > 0 {
			for j := 0; j < lastLen; j++ {
				textArray[lastI+j] = mask
			}
			i = lastI + lastLen - 1
			modified = true
		}
	}
	if modified {
		return strings.Join(textArray, ""), modified
	} else {
		return input, false
	}
}

/*
 * 替换敏感词(匹配到最短的立即替换)
 * input: 输入字符串
 * mask: 敏感词替换字符
 *
 * 返回: 替换后的字符串, 是否有敏感词
 */
func (t *TrieTree) MinReplaceWith(input string, mask string) (string, bool) {
	if len(input) == 0 || t.root == nil {
		return input, false
	}
	var textArray = strings.Split(input, "")
	var textLen = len(textArray)
	var modified = false
	for i := 0; i < textLen; i++ {
		var charLen = 0
		var current = t.root
		var pos = i
		for current[textArray[pos]] != nil {
			current = (current[textArray[pos]]).(map[string]interface{})
			charLen += 1
			if current["END"] == true {
				for j := 0; j < charLen; j++ {
					textArray[i+j] = mask
				}
				i = i + charLen - 1
				modified = true
				break
			}
			if pos == (textLen - 1) {
				break
			}
			pos++
		}
	}
	if modified {
		return strings.Join(textArray, ""), modified
	} else {
		return input, false
	}
}
```

测试程序
```go
package main

import (
	. "./trie_check"
	"bufio"
	"fmt"
	"io"
	"io/ioutil"
	"os"
	"time"
)

var tc = new(TrieTree)

func processLine(line []byte) {
	tc.AddWord(string(line))
}

func ReadLine(filePth string, hookfn func([]byte)) error {
	f, err := os.Open(filePth)
	if err != nil {
		return err
	}
	defer f.Close()

	bfRd := bufio.NewReader(f)
	for {
		line, _, err := bfRd.ReadLine()
		hookfn(line)
		if err != nil {
			if err == io.EOF {
				return nil
			}
			return err
		}
	}
	return nil
}

func main() {
	var start_time = time.Now().UnixNano()
	//敏感词存在out6.txt中,每行一个词
	ReadLine("out6.txt", processLine)
	var end_time = time.Now().UnixNano()
	fmt.Println("Create trie tree:", float64(end_time-start_time)/1000000, "ms")
	//需要过滤敏感词的文件在out_test.txt中
	fi, err := os.Open("out_test.txt")
	if err != nil {
		panic(err)
	}
	defer fi.Close()
	fd, err := ioutil.ReadAll(fi)
	start_time = time.Now().UnixNano()
	for i := 1; i < 100; i++ {
		tc.MinReplaceWith(string(fd), "*")
	}
	out, changed := tc.MinReplaceWith("fuckfUCKfucao 操蛋 啊啊会CKFu##Ck昂送伞", "*")
	end_time = time.Now().UnixNano()
	fmt.Println(out, changed)
	fmt.Println(float64(end_time-start_time)/1000000, "ms")
	start_time = time.Now().UnixNano()
	for i := 1; i < 100; i++ {
		tc.MaxReplaceWith(string(fd), "*")
	}
	out3, changed := tc.MaxReplaceWith("fuckfUCKfucao 操蛋 啊啊会CKFu##Ck 昂送伞", "*")
	end_time = time.Now().UnixNano()
	fmt.Println(out3, changed)
	fmt.Println(float64(end_time-start_time)/1000000, "ms")
}

```
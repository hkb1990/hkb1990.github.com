---
title: Go中Json解析遇到的问题
date: 2017-03-07 17:56:54
categories: 学习
tags: [Go, 学习]
---

最近用到Go解析Json字符串，本来没仔细看，结果定义结构体的时候忽略了成员名的大小写问题，导致变量赋值始终不成功。折腾了一会，写个测试程序看看Json转化的一些规则。

<!-- more -->

```go
package main

import (
	"encoding/json"
	"fmt"
)

type Test1 struct {
	Va1 int
	Va2 int
}

type Test2 struct {
	va1 int
	va2 int
}

type Test3 struct {
	Va1 int `json:"te1"`
	Va2 int `json:"va1"`
}

func main() {
	var test1 Test1
	err := json.Unmarshal([]byte(`{"Va1":1,"Va2":2}`), &test1)
	if err != nil {
		fmt.Println(err)
		return
	}
	fmt.Printf("test1: %+v\n", test1)

	// 大小写不敏感
	var test11 Test1
	err = json.Unmarshal([]byte(`{"va1":1,"vA2":2}`), &test11)
	if err != nil {
		fmt.Println(err)
		return
	}
	fmt.Printf("test11: %+v\n", test11)

	// 如果字段重复则后面的会覆盖前面的
	var test12 Test1
	err = json.Unmarshal([]byte(`{"va1":1,"vA2":2,"Va2":3}`), &test12)
	if err != nil {
		fmt.Println(err)
		return
	}
	fmt.Printf("test13: %+v\n", test12)

	// 结构体里面的成员名如果是小写,是无法赋值成功的
	// 这与Go的变量命名规则有关,首字母大写的是可以导出的
	var test2 Test2
	err = json.Unmarshal([]byte(`{"va1":1,"va2":2}`), &test2)
	if err != nil {
		fmt.Println(err)
		return
	}
	fmt.Printf("test2: %+v\n", test2)

	// 如果设置了标签,则以标签为准,忽略成员名
	var test3 Test3
	err = json.Unmarshal([]byte(`{"va1":1,"te1":2}`), &test3)
	if err != nil {
		fmt.Println(err)
		return
	}
	fmt.Printf("test3: %+v\n", test3)

	// 如果设置了标签,则以标签为准,忽略成员名
	var test31 Test3
	err = json.Unmarshal([]byte(`{"te1":2,"va1":1,"va2":3}`), &test31)
	if err != nil {
		fmt.Println(err)
		return
	}
	fmt.Printf("test31: %+v\n", test31)
}

```

最终结果
```
test1: {Va1:1 Va2:2}
test11: {Va1:1 Va2:2}
test13: {Va1:1 Va2:3}
test2: {va1:0 va2:0}
test3: {Va1:2 Va2:1}
test31: {Va1:2 Va2:1}

```
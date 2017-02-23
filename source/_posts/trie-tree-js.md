---
title: 字典树的Node.js语言实现
date: 2017-02-23 16:34:59
categories: 工具
tags: [Node, 工具, 敏感词]
---
敏感词处理最开始本来是用Node写了一遍实现,
这里也顺便贴出来吧。

<!-- more -->

```js
/*
 * 敏感词处理
 */

var fs = require('fs');
var readline = require('readline');
// 敏感词树
var root = {};

var start_time = new Date();
// 添加敏感词
function addWord(word) {
  if (word == null || word.length == 0) return;
  var wordArray = Array.from(word);
  var wordLen = wordArray.length - 1;
  var current = root;
  for (var i in wordArray) {
    if (current[wordArray[i]] == null) {
      current[wordArray[i]] = {};
    }
    current = current[wordArray[i]];
    if (i == wordLen) {
      current["END"] = 1;
    }
  }
}

//敏感词存在out6.txt中,每行一个词
var rl = readline.createInterface({
  input: fs.createReadStream('out6.txt'),
  output: process.stdout,
  terminal: false
});

rl.on('line', function(line) {
  addWord(line);
});

rl.on('close', function(line) {
  //需要过滤敏感词的文件在out_test.txt中
  fs.readFile('out_test.txt', (err, data) => {
    if (err) throw err;
    start_time = new Date();
    //console.log(JSON.stringify(root));
    replaceWith(data.toString(), "*");
    var end_time = new Date();
    console.log(end_time.getTime() - start_time.getTime());
  });
});

// 替换敏感词
function replaceWith(text, mask) {
  if (text == null || text.length == 0) return;
  var textArray = Array.from(text);
  var textLen = textArray.length - 1;
  for (var i = 0; i <= textLen; i++) {
    var charLen = 0;
    var current = root;
    var k = i;
    while ((current = current[textArray[k]]) != null) {
      charLen += 1;
      if (current["END"] == 1) {
        for (var j = 0; j < charLen; j++) {
          textArray[i + j] = mask;
        }
        i = i + charLen - 1;
        break;
      }
      if (k == textLen) {
        break;
      }
      k++;
    }
  }
  return textArray.join('');
}

```
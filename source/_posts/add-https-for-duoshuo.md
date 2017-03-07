---
title: 为多说增加https支持
date: 2017-03-07 20:38:40
categories: 分享
tags: [https, 分享]
---
给全站弄完https，发现打开带评论的文章小绿锁就会消失，打开浏览器的开发者工具一看，主要是多说的头像，以及表情全部使用的是http链接。
去[多说官方论坛](https://dev.duoshuo.com/threads/541d4e8cf220120330054749)，快三年了还没解决。
不过解决方法还是有的，
* [https://github.com/rainwsy/duoshuo-https](https://github.com/rainwsy/duoshuo-https)
* [https://www.cacher.cc/2016/12/31/duoshuo-https.html](https://www.cacher.cc/2016/12/31/duoshuo-https.html)

我采用的是后一种，不过这些方法的缺点是如果多说更新了脚本，没法保持最新的版本，出了错误还要下载最新的js脚本文件，重新修改，压缩，替换。

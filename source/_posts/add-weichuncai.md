---
title: 添加伪春菜
date: 2017-02-09 20:18:23
categories: 分享
tags: [伪春菜, 分享]
---
在浏览别人的博客的时候偶然间看到[伪春菜](http://baike.baidu.com/item/%E4%BC%AA%E6%98%A5%E8%8F%9C)，![](/images/screenshots/screen-shot-weichuncai .png)萌萌的一只，还可以调戏，正好想要搭建自己的个人主页，于是就决定也要去捉一只。然后在[最新通用版伪春菜下载](http://www.lmyoaoa.com/inn/archives/4504/)找到了网页版的。但是这个是Word Press的插件，而且需要配置后台。我既然选了用Github Page搭建个人主页，那么就只能自己动手修改，弄个静态页面的伪春菜，虽然功能上可能会差点，但后期可以慢慢完善。

<!-- more -->

## 下载伪春菜UTF8版

[下载链接](http://www.lmyoaoa.com/downloads/weichuncai_utf8.zip)

## 解压

发现其实东西不多，有用的几个文件及文件夹如下：
> imgs : 对话框的图片
> skin : 皮肤或者称外貌，有三款，也可以自己添加，命名为face1.gif，face2.gif，face3.gif
> css/style.css : 样式，有些需要调整
> js/common.js : 核心程序

## 开始帮运

* 进入next主题的source文件夹下
* 复制`imgs`文件夹下的图片到`images`目录下
* 复制`skins`文件夹下的文件夹到`images`目录下
* 复制`style.css`到`css`目录下，并修改图片的url指向
* 复制`common.js`到`lib/weichuncai/`目录下，重命名为`weichuncai.js`
* 修改`weichuncai.js`，去除后台相关的代码，并增加手机端触摸拖动的功能，具体参考[weichuncai.js](/lib/weichuncai/weichuncai.js)
* 进入`../layout`文件夹
* 添加css，修改`_partials/head.swig`文件,添加下面的代码：
``` js
{% if theme.weichuncai %}
    <link href="{{ url_for(theme.css) }}/weichuncai.css?v={{ theme.version }}" rel="stylesheet" type="text/css" />
{% endif %}
```
* 添加js，修改`_scripts/vendors.swig`，添加下面的代码：
``` js
{% if theme.weichuncai %}
  {% set js_vendors.weichuncai  = 'weichuncai/weichuncai.js?v=1.0.1' %}
{% endif %}
```
* 添加伪春菜到页面，修改`_layout.swig`,添加下面的代码到`body`标签中：
``` js
{% if theme.weichuncai %}
<script>
var imagewidth = "85";
var imageheight = "152";
createFace("/images/rakutori/face1.gif", "/images/rakutori/face2.gif", "/images/rakutori/face3.gif");
</script>
{% endif %}
```
* 最后修改主题下面的`_config.yml`，用于控制伪春菜的开启与否，添加：
```
# weichuncai
weichuncai: true
```
OK，到这里伪春菜就添加好了，重新`hexo s -g`就能看到效果了，之后更多的功能还要修改`weichuncai.js`，代码很简单，完全可以自己改。我也会时不时地进行更新。

## 感谢

最后还是要感谢[最初作者](http://www.lmyoaoa.com/inn/)的开源代码,以及皮肤的[画师](https://zh.moegirl.org/zh-hans/%E6%B7%B1%E6%B8%8A%E8%90%BD%E9%B8%9F)。

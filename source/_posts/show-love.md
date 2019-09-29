---
title: 献给最最爱的老婆
date: 2019-09-30 13:14:20
categories: 恩爱
tags: [秀恩爱, 表白]
---

🇭​ 🇰 🇧❤🇿 🇾 🇯​ 
🇫 🇴 🇷 🇪 🇻 🇪 🇷

<!-- more -->

{% raw %}
<style type="text/css">
.digit{font-family:"Times New Roman";font-size:30px}
#words{font-family:"sans-serif";font-size:20px;color:#666}"
</style>
<script type="text/javascript" src="/js/src/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="/js/src/garden.js"></script>
<script type="text/javascript" src="/js/src/lovefunc.js"></script>
<div id="loveHeart" style="position:relative">
	<canvas id="garden" width="670" height="625" style="margin-left:-20px"></canvas>
	<div id="words" style="position:absolute;margin-top:226.5px;width:100%;text-align:center;top:0;">
		<div id="messages" style="display:none;">
		亲爱的，这是我们相遇后的时间：
			<div id="elapseClock"><span class="digit">2376</span> 天 <span class="digit">03</span> 时 <span class="digit">55</span> 分 <span class="digit">59</span> 秒
			</div>
		</div>
		<div id="messages2" style="display:none;">
		这是我们结婚后的时间：
			<div id="elapseClock2"><span class="digit">2376</span> 天 <span class="digit">03</span> 时 <span class="digit">55</span> 分 <span class="digit">59</span> 秒
			</div>
		</div>
		<div id="loveu" style="padding:5px;font-size:22px;margin-top:30px;text-align:center;display:none">
					爱你直到永远。<br>
			<div class="signature" style="text-align:center;margin-top:10px;font-size:20px;font-style:italic">- HKB</div>
		</div>
	</div>
</div>
<div id="code" style="text-align:center;display:none">
	<span>我可能不够高大也不够英俊，</span>
	<br/>
	<span>我可能也不够富有，</span>
	<br/>
	<span>但遇见你，</span>
	<br/>
	<span>是我生命里最大的幸运，</span>
	<br/>
	<span>我的余生，只陪着你！</span>
	<br/>
	<br/>
	<span>最后给我亲爱的老婆献上玫瑰花~~</span>
	<br/>
</div>
<script type="text/javascript">
$("#loveHeart").css("width", $(".post-body").width() - 20);
$("#loveHeart").css("height", $(".post-body").height() - 20);
//$("#loveHeart").css("margin-left", 10);
var offsetX = $(".post-body").width() / 2 + 20;
var offsetY = $(".post-body").height() / 2 - 55;
var together = new Date();
together.setFullYear(2018, 4, 19);
together.setHours(12);
together.setMinutes(0);
together.setSeconds(0);
together.setMilliseconds(0);
var marry = new Date();
marry.setFullYear(2018, 8, 30);
marry.setHours(10);
marry.setMinutes(0);
marry.setSeconds(0);
marry.setMilliseconds(0);
if (!document.createElement('canvas').getContext) {
	var msg = document.createElement("div");
	msg.id = "errorMsg";
	msg.innerHTML = "Your browser doesn't support HTML5!<br/>Recommend use Chrome 14+/IE 9+/Firefox 7+/Safari 4+"; 
	document.body.appendChild(msg);
	$("#code").css("display", "none")
	$("#copyright").css("position", "absolute");
	$("#copyright").css("bottom", "10px");
	document.execCommand("stop");
} else {
	startHeartAnimation();
	timeElapse(together);
	timeElapse2(marry);
	setInterval(function () {
		timeElapse(together);
		timeElapse2(marry);
	}, 500);
	//adjustCodePosition();
	// setTimeout(function() {
	// 	typeCode()
	// 	//$("#code").typewriter();
	// }, 5000);
}
</script>
{% endraw %}

{% if page.path and page.path.indexOf('show-love') > -1 %}
<script type="text/javascript">
(function() {
  function initLovePage() {
    loadDependencies();
  }

  function loadDependencies() {
    // 首先加载 jQuery
    loadScript('/lib/jquery.min.js', function() {
      // 确保 jQuery 加载完成后再加载 garden.js
      loadScript('/js/garden.js', function() {
        // 等待 garden.js 加载完成后再加载并执行 lovefunc.js
        loadScript('/js/lovefunc.js', function() {
          // 确保所有依赖都加载完成后再初始化
          setTimeout(function() {
            if (typeof Garden !== 'undefined') {
              startLove();
            } else {
              console.error('Garden still not defined');
            }
          }, 100);
        });
      });
    });
  }

  function loadScript(url, callback) {
    var script = document.createElement('script');
    script.type = 'text/javascript';
    script.src = url;
    script.onload = callback;
    document.head.appendChild(script);
  }

  var heartInterval; // 存储定时器引用

  function startLove() {
    // 计算并定义全局变量
    window.offsetX = $(".post-body").width() / 2 + 20;
    window.offsetY = $(".post-body").height() / 2 - 55;
    
    $("#loveHeart").css("width", $(".post-body").width() - 20);
    $("#loveHeart").css("height", $(".post-body").height() - 20);

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

    if (typeof startHeartAnimation === 'function') {
      startHeartAnimation();
      timeElapse(together);
      timeElapse2(marry);
      // 保存定时器引用
      heartInterval = setInterval(function () {
        timeElapse(together);
        timeElapse2(marry);
      }, 500);
    }
  }

  // 清理函数
  function cleanup() {
    console.log('Cleaning up love page...');
    if (heartInterval) {
      clearInterval(heartInterval);
    }
    // 清理 canvas
    var garden = document.getElementById('garden');
    if (garden) {
      var ctx = garden.getContext('2d');
      ctx.clearRect(0, 0, garden.width, garden.height);
    }
    
    // 移除所有事件监听器
    window.removeEventListener('beforeunload', cleanup);
    
    // 延迟执行 NexT 的刷新，确保所有资源都加载完毕
    setTimeout(function() {
      if (window.NexT && window.NexT.boot) {
        try {
          window.NexT.boot.refresh();
        } catch (e) {
          console.log('NexT refresh error:', e);
        }
      }
    }, 500);
  }

  // 移除事件监听，直接执行
  initLovePage();

  // 为 pjax 重新加载添加监听
  if (window.NexT && window.NexT.events) {
    window.NexT.events.on('pjax:success', function() {
      if (window.location.pathname.indexOf('show-love') > -1) {
        setTimeout(initLovePage, 100);
      } else {
        cleanup();
      }
    });
  }

  // 页面卸载时清理
  window.addEventListener('beforeunload', cleanup);
})();
</script>
{% endif %}

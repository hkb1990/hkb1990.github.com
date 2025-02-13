(function() {
  function loadChangyan() {
    if (typeof SOHUCS !== 'undefined') {
      if (typeof SOHUCS.reset === 'function') {
        SOHUCS.reset();
      } else {
        setTimeout(loadChangyan, 100);
      }
    } else {
      var script = document.createElement('script');
      script.src = 'https://cy-cdn.kuaizhan.com/upload/changyan.js';
      script.onload = function() {
        setTimeout(function() {
          if (typeof SOHUCS !== 'undefined') {
            SOHUCS.reset();
          }
        }, 100);
      };
      document.head.appendChild(script);
    }
  }

  // 监听 pjax 完成事件
  document.addEventListener('pjax:complete', loadChangyan);
})();

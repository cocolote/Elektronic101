// HOME FUNCTION ========================================

$('#start-button a').hover(handelerIn, handelerOut);

function handelerIn() {
  $('.light-up').css({ 'color': '#d1423a',
                       'text-shadow': '0 0 2px white, 0 0 20px #d1423a' });
}

function handelerOut() {
  $('.light-up').css({ 'color': '#000',
                       'text-shadow': 'none' });

  $('#start-button a').css({ 'color': '#111',
                             'text-shadow': 'none' });
}

// SETUP SOUND MANAGER ==================================

var mySound;
var bridge = {}

soundManager.setup({
  flashVersion: 9,
  debugMode: false,
  usePeakData: true,

  onready: function() {
    soundManager.defaultOptions.usePeakData = true;
    mySound = soundManager.createSound();
  }
});


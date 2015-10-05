// HOVER FUNCTION =======================================

$('#start-button a').on('mouseenter', function() {
  $('.light-up').css({ 'text-shadow': '0 0 2px white, 0 0 20px #f4511e' });                       
});

$('#start-button a').on('mouseleave', function() {
  $('.light-up').css({ 'text-shadow': 'none' });
});


$('#playlist').on('mouseenter', '.pl-row', function() {
  this.children[0].children[0]
                  .style.borderColor = '#f4511e';
});

$('#playlist').on('mouseleave', '.pl-row', function() {
    this.children[0].children[0]
                    .style.borderColor = 'transparent';
});

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


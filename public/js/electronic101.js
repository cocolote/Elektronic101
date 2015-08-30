// The canvas for your awesome JS code
$('#start-button a').mouseover(function() {
  var i = 0;
  setInterval(function() {
    $('.light-up').css({'color': 'rgb('+i+','+i+','+i+')'});
    i++;
  }, 5);
});

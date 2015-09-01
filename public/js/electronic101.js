// The canvas for your awesome JS code

/* ===================== HOME FUNCT ===================== */

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

var myApp = angular.module('myApp', ['ngResource','angular-svg-round-progress']);

myApp.controller('UsersCtrl',['$scope','$resource',function($scope, $resource) {

  $scope.User  = $resource('/me.json');

  $scope.me    = $scope.User.get();
  
}]);

myApp.controller('LikesCtrl',['$scope','$resource'
                 ,function($scope, $resource) {

  var Likes    = $resource('/likes.json');

  $scope.likes = Likes.get(); 

  $scope.playpauseSM = function(index) {

    if (mySound.id == index) {
      if (mySound.paused) {
        mySound.resume();

        $('#element-'+index+' img').addClass('spin');
        $('#playpause-'+index).removeClass('glyphicon-play')
                              .addClass('glyphicon-pause');
      } else {
        mySound.pause();

        $('#element-'+index+' img').removeClass('spin');
        $('#playpause-'+index).removeClass('glyphicon-pause')
                              .addClass('glyphicon-play');
      }

    } else {

      mySound.id     = index;
      mySound.url    = $scope.likes.likes[index].stream_url+
                       '?client_id='+
                       $scope.likes.clientId; 
      mySound.stream = true;

      mySound.play({
        onfinish: function() {
          index += 1;
          $scope.playpauseSM(index);
        }
      });

      bridge.onPlaying();

      $('.play-art').removeClass('glyphicon-pause')
                    .addClass('glyphicon-play');

      $('#playpause-'+index).removeClass('glyphicon-play')
                            .addClass('glyphicon-pause');

      $('.song-artwork').removeClass('spin');
      $('#element-'+index+' img').addClass('spin');
    }
  }

}]);

myApp.controller('RoundProgressCtrl',['$scope','$interval','roundProgressService'
                 ,function($scope,$interval,roundProgressService) {

  $scope.max     = 0;
  $scope.current = 0;
  $scope.time    = 0;

  bridge.onPlaying = function() {
    $interval(function() {
      if ($scope.max != mySound.duration) {
        $scope.max = mySound.duration;
      }

      $scope.time    = mySound.position; 
      $scope.current = mySound.position;
      console.log('left: '+mySound.peakData.left);
      console.log('right: '+mySound.peakData.right);
    },1000);
  }

}]);

myApp.filter('msecToTime', function() {
  return function(msec) {
    var hh = Math.floor((msec / 1000) / 3600);
    var mm = Math.floor(((msec / 1000) % 3600) / 60);
    var ss = Math.floor((msec / 1000) % 60);

    if (hh < 10) var HH = '0' + hh;
    if (mm < 10) var MM = '0' + mm;
    if (ss < 10) var SS = '0' + ss;
    
    return (HH || hh)+':'+(MM || mm)+':'+(SS || ss);
  }
});

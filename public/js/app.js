var myApp = angular.module('myApp', ['ngResource','angular-svg-round-progress']);

myApp.controller('UsersCtrl',['$scope','$resource',function($scope, $resource) {

  $scope.User  = $resource('/me.json');

  $scope.me    = $scope.User.get();
  
}]);

myApp.controller('LikesCtrl',['$scope','$resource',function($scope, $resource) {
  
  var Likes    = $resource('/likes.json');

  $scope.likes = Likes.get(); 
  

  $scope.play  = function(idx) {
    
    if (! window.AudioContext) {
      if (! window.webkitAudioContext) {
        alert('no audiocontext foun');
      }
      window.AudioContext = window.webkitAudioContext;
    }

    var context = new AudioContext();
    var audioBuffer;
    var sourceNode;

    console.log($scope.likes.likes[idx].stream_url);

    setupAudioNodes();
    loadSound($scope.likes.likes[idx].stream_url+'?client_id='+$scope.likes.clientId);

    function setupAudioNodes() {
      sourceNode = context.createBufferSource();
      sourceNode.connect(context.destination);
    }

    function loadSound(url) {
      var request = new XMLHttpRequest();
      request.addEventListener('progress', updateProgress);
      request.open('GET', url, true);
      request.responseType = 'arraybuffer';
      
      request.onload = function() {
        context.decodeAudioData(request.response, function(buffer) {
          playSound(buffer);
        }, onError);
      }

      function updateProgress(event) {
        if (event.lengthComputable) {
          console.log(event.loaded / event.total);
        } else {
          console.log("this isn't working");
        }
      }
      request.send();
    }

    function playSound(buffer) {
      sourceNode.buffer = buffer;
      sourceNode.start(0);
    }

    function onError(e) {
      console.log(e);
    }
  }

}]);

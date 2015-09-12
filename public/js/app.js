var myApp = angular.module('myApp', ['ngResource']);

// myApp.config(['$resourceProvider', function($resourceProvider) {
//   $resourceProvider.defaults.stripTrailingSlashes = false;
// }

myApp.controller('UsersCtrl', function($scope, $resource) {

  $scope.User  = $resource('/me.json');

  $scope.me    = $scope.User.get();

});

myApp.controller('LikesCtrl', function($scope, $resource) {
  
  var Likes       = $resource('/likes.json');

  $scope.Likes = Likes.query(); 

});

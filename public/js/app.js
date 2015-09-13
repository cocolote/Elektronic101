var myApp = angular.module('myApp', ['ngResource','angular-svg-round-progress']);


myApp.controller('UsersCtrl',['$scope','$resource',function($scope, $resource) {

  $scope.User  = $resource('/me.json');

  $scope.me    = $scope.User.get();

}]);

myApp.controller('LikesCtrl',['$scope','$resource', function($scope, $resource) {
  
  //var Likes       = $resource('/likes.json');

  $scope.Likes = Likes.query(); 

}]);

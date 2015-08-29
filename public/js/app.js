var myApp = angular.module('myApp', []);

myApp.controller('mainController', function($scope) {

  $scope.person = {
    fname: 'Ezequiel',
    lname: 'Lopez' 
  };

});

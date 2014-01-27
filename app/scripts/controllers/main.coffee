'use strict'

angular.module('vimPiApp')
  .controller 'MainCtrl', (DBFetcher, $scope, $window) ->

    $scope.limit = 50

    $scope.scroll = ->
      $scope.limit += 100

    DBFetcher.fetchAll().then (plugins) ->
      console.log arguments.length, plugins.length
      $scope.pluginCollection = plugins


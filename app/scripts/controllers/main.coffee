'use strict'

angular.module('vimPiApp')
  .controller 'MainCtrl', (DBFetcher, $scope, $window) ->

    $scope.pluginCollection = [{name: 'yeah'}]

    #url = [
    #  'https://bitbucket.org/vimcommunity/vim-pi/raw/master/db/script-id-to-name-log.json',
    #  'https://bitbucket.org/vimcommunity/vim-pi/raw/master/db/scm_generated.json'
    #]

    DBFetcher.fetchAll().then (plugins) ->
      console.log arguments.length, plugins.length
      $scope.pluginCollection = plugins


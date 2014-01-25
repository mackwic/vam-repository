'use strict'

angular.module('vimPiApp')
  .controller 'MainCtrl', (Sources, $scope, $http, $q) ->

    $scope.pluginCollection = [{name: 'yeah'}]

    #url = [
    #  'https://bitbucket.org/vimcommunity/vim-pi/raw/master/db/script-id-to-name-log.json',
    #  'https://bitbucket.org/vimcommunity/vim-pi/raw/master/db/scm_generated.json'
    #]

    url = [
      'public/script-id-to-name-log.json',
      'public/scm_generated.json'
    ]

    $q.all(
      #url.map($http.get)
      [$http.get(url[0]), $http.get(url[1])]

    ).then(([names, sources]) ->
      names = names.data
      sources = sources.data
      $scope.pluginCollection = for key, value of sources
        {name: names[key][0], type: value.type, url: value.url}

    ).then(Sources.flagAll).then((flaggedPlugins) ->
      $scope.pluginCollection = flaggedPlugins
      console.log flaggedPlugins
    )

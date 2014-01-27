'use strict'

angular.module('vimPiApp')
  .service 'DBFetcher', (Sources, $q, $http) ->
    #url = [
    #  'https://bitbucket.org/vimcommunity/vim-pi/raw/master/db/script-id-to-name-log.json',
    #  'https://bitbucket.org/vimcommunity/vim-pi/raw/master/db/scm_generated.json'
    #]

    url = [
      'public/script-id-to-name-log.json',
      'public/scm_generated.json',
      'public/vimorgsources.json'
    ]

    treatSources = (promise) ->
      promise.then ([names, sources]) ->
        for key, value of sources
          {name: names[key][0], type: value.type, url: value.url}
      .then(Sources.flagAll)

    treatVimOrg = (promise) ->
      promise.then ((vimorg) ->
        Sources.flagAllVim vimorg
      )

    {
      fetchAll: -> $q.all(url.map((e) -> $http.get e))
        .then ([names, sources, vimorg]) ->
          names = names.data
          sources = sources.data
          vimorg = vimorg.data
          [[names, sources], vimorg]
        .then ([sources, vimorg]) ->
          $q.all [
            treatSources($q.when(sources))
            treatVimOrg($q.when(vimorg))
          ]
        .then ([sources, vimscript]) ->
          sorter = (p1, p2) -> p1.name.localeCompare p2.name
          sources.concat(vimscript).sort sorter
    }

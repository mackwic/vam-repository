'use strict'

angular.module('vimPiApp')
  .service 'Sources', () ->
    sources = {
      vimorg: 0
      github: 1
      bitbucket: 2
      googlecode: 3
      sourceforge: 4
      codeplex: 5
    }

    hosters = [
      {name: 'github', matcher: 'github.com', regexp: /github.com\/(\w+)\/(\w+)/, to: ['owner', 'repo']},
      {name: 'bitbucket', matcher: 'bitbucket.org', regexp: /bitbucket.org\/(\w+)\/(\w+)/, to: ['owner', 'repo']},
      {name: 'googlecode', matcher: 'googlecode.com', regexp: /(\w+).googlecode.com/, to: ['repo']},
      {name: 'googlecode', matcher: 'code.google.com', regexp: /google.com\/p\/(\w+)$/, to: ['repo']}
    ]

    @flagPlugin = (plugin) ->
      for host in hosters
        continue if -1 == plugin.url.indexOf host.matcher

        plugin.host = host.name
        matches = host.regexp.exec plugin.url
        continue if matches == null

        for i in [1..matches.length]
          plugin[host.to[i - 1]] = matches[i]
      plugin

    @flagAll = (collection) => collection.map @flagPlugin

    angular.extend this, sources

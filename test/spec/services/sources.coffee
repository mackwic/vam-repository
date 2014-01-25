'use strict'

describe 'Service: Sources', () ->

  # load the service's module
  beforeEach module 'vimPiApp'

  # instantiate service
  Sources = {}
  beforeEach inject (_Sources_) ->
    Sources = _Sources_

  it 'should do something', () ->
    expect(!!Sources).toBe true

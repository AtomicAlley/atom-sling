SlingView = require './sling-view'
fs = require 'fs'
david = require 'david'

module.exports =
  slingView: null

  activate: (state) ->
    # @slingView = new SlingView(state.slingViewState)
    # someJSON = { 'name': 'hello', 'dependencies': { 'david': '~3.1.0' }}
    # @parseNPMDependencies(someJSON, alert)


  deactivate: ->
    @slingView.destroy()

  serialize: ->
    slingViewState: @slingView.serialize()

  # given manifest, the json contents of package.json,
  # invoke the callback with the david dependency object
  parseNPMDependencies: (manifest, callback) ->
    david.getDependencies manifest, ((er,deps) =>
      if er
        console.log er
        callback(er)
      else
        console.log deps
        callback(deps)
    )
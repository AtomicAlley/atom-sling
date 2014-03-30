SlingView = require './sling-view'
fs = require 'fs'
david = require 'david'

module.exports =
  slingView: null

  activate: (state) ->
    # @slingView = new SlingView(state.slingViewState)
    # someJSON = { 'name': 'hello', 'dependencies': { 'david': '~3.1.0' }, 'devDependencies': { 'grunt': '0.4.4' }}
    # @parseNPMDependencies(someJSON, alert)
    # @parseNPMDevDependencies(someJSON, alert)


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

  # given manifest, the json contents of package.json,
  # get NPM dev dependencies and pass them as the argument
  # to the given callback function
  parseNPMDevDependencies: (manifest, callback) ->
    david.getDependencies manifest, { dev: true }, ((er, deps) =>
      if er
        console.log er
        callback(er)
      else
        console.log "Dev Dependencies: #{JSON.stringify deps}"
        callback(deps)
    )
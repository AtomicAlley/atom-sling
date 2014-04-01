SlingView = require './sling-view'
fs = require 'fs'
david = require 'david'

module.exports =
  slingView: null

  activate: (state) ->
    # @slingView = new SlingView(state.slingViewState)
    # someJSON = { 'name': 'hello', 'dependencies': { 'david': '~3.1.0', 'natural': '0.1.19' }, 'devDependencies': { 'grunt': '0.4.1' }}
    # @parseUpdatedNPMDependencies(someJSON, alert)
    # @parseUpdatedNPMDevDependencies(someJSON, alert)
    # @parseNPMDependencies(someJSON, alert)
    # @parseNPMDevDependencies(someJSON, alert)
    projectManifest = require @getPackagePath()
    if projectManifest
      @parseUpdatedNPMDependencies projectManifest, alert
      @parseUpdatedNPMDevDependencies projectManifest, alert
    else
      console.log 'there is no package.json, bye'


  deactivate: ->
    @slingView.destroy()

  serialize: ->
    slingViewState: @slingView.serialize()

  # given manifest, the json contents of package.json,
  # get NPM dependencies and pass them as the argument
  # to the given callback function
  parseNPMDependencies: (manifest, callback) ->
    david.getDependencies manifest, ((er,deps) =>
      if er
        console.log er
        callback(er)
      else
        console.log "Dependencies: #{JSON.stringify deps}"
        callback(deps)
    )

  # given manifest, the json contents of package.json,
  # get the NPM dependencies that are outdated and pass them
  # as the argument to the given callback function
  parseUpdatedNPMDependencies: (manifest, callback) ->
    david.getUpdatedDependencies manifest, ((er,deps) =>
      if er
        console.log er
        callback(er)
      else
        console.log "Dependencies: #{JSON.stringify deps}"
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

  # given manifest, the json contents of package.json, get
  # the NPM dev dependencies that are outdated and pass them
  # as the argument to the given callback function
  parseUpdatedNPMDevDependencies: (manifest, callback) ->
    david.getUpdatedDependencies manifest, { dev: true }, ((er, deps) =>
      if er
        console.log er
        callback(er)
      else
        console.log "Dev Dependencies: #{JSON.stringify deps}"
        callback(deps)
    )

  # find path of package.json for the project of the atom window
  getPackagePath: ->
    projectPath = atom.project.getPath()
    # assuming for now that package.json is either in the top-level
    # directory or else it simply doesn't exist, make this more robust later
    packagePath = projectPath + '/package.json'
{View} = require 'atom'

module.exports =
class SlingView extends View
  @content: ->
    @div class: 'sling overlay from-top', =>
      @div "The Sling package is Alive! It's ALIVE!", class: "message"

  initialize: (serializeState) ->
    atom.workspaceView.command "sling:toggle", => @toggle()

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @detach()

  toggle: ->
    console.log "SlingView was toggled!"
    if @hasParent()
      @detach()
    else
      atom.workspaceView.append(this)

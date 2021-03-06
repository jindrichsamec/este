###*
  @fileoverview este.demos.app.simple.start.
###

goog.provide 'este.demos.app.simple.start'

goog.require 'este.app.create'
goog.require 'este.demos.app.simple.product.View'
goog.require 'este.demos.app.simple.products.View'
goog.require 'este.dev.Monitor.create'

###*
  @param {Object} data JSON from server
###
este.demos.app.simple.start = (data) ->
  if goog.DEBUG
    este.dev.Monitor.create()

  appEl = document.getElementById 'app'
  progressEl = document.getElementById 'progress'
  timer = null

  # app definition
  myApp = este.app.create appEl, [
    este.demos.app.simple.products.View
    este.demos.app.simple.product.View
  ]
  myApp.data = data
  # false to disable url projection
  myApp.urlEnabled = true

  # progress bar
  goog.events.listen myApp, 'beforeload', (e) ->
    goog.dom.classes.add progressEl, 'loading'
    progressEl.innerHTML = 'loading'
    progressEl.innerHTML += ' ' + e.request.params.id if e.request.params?.id
    clearInterval timer
    timer = setInterval ->
      progressEl.innerHTML += '.'
    , 250

  goog.events.listen myApp, 'beforeshow', (e) ->
    clearInterval timer
    goog.dom.classes.remove progressEl, 'loading'
    progressEl.innerHTML = 'loaded'

  # dispose
  goog.events.listen document.body, 'click', (e) ->
    return if e.target.id != 'dispose'
    myApp.dispose()

  # start app
  myApp.start()

# ensures the symbol will be visible after compiler renaming
goog.exportSymbol 'este.demos.app.simple.start', este.demos.app.simple.start
"""
HTML

<p id='status'>
  <span class='hp'></span>
  <span class='x'></span>
  <span class='y'></span>
</p>
"""


window.onload = ->
  window.player_status = hp: 10, x: 3, y: 0
  renderer = new StatusView $('#status'), player_status
  console.log renderer

class View
  binding: {}
  hook: {}

  constructor: (@$el, @model, restrict = {}) ->
    Object.observe @model, @_handler
    @_initialize()

  _initialize: ->
    for key, val of @model
      if typeof val in ['string', 'number']
        @_update_value(key)

  _handler: (events) =>
    for e in events when e.type in ['updated', 'new']
      @_update_value e.name
      for method_name, values of @hook
        for v in values when v is e.name
          @[method_name](events)
          break

  _update_value: (value_name) ->
    selector = @binding[value_name] or '.'+value_name
    @$el.find(selector).text @model[value_name]

class StatusView extends View
  binding:
    hp: '.hp' # "default binding is '.' prefix"

  hook:
    render: ['x', 'y']

  render: (events) =>
    console.log 'called by hook', events


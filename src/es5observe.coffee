prefix = '__'

update = (obj, key, nextVal) ->
  oldValue = obj._last_[key]
  if nextVal isnt oldValue
    obj._last_[key] = nextVal
    event_type =
      if oldValue is undefined then 'new'
      else if nextVal is undefined then 'deleted'
      else 'updated'
    e =
      type: event_type
      name: key
      object: obj
      oldValue: oldValue
    for f in obj._notice_
      f(e)

define = (obj, key) ->
  Object.defineProperty obj, key,
    get: ->
      @[prefix+key]
    set: (val) ->
      @[prefix+key] = val
      update(obj, key, val)

es5observe = (obj, f) ->
  if obj._observe_
    obj._notice_.push f
    return obj

  Object.defineProperties obj,
    '_observe_':
      value: true
      enumerable : false

    '_last_':
      value: {}
      enumerable : false

    '_notice_':
      value: [f]
      enumerable : false

  for key, val of obj
    if typeof val in ['number', 'string'] and key.indexOf(prefix) is -1
      real_key =  prefix+ key
      obj[real_key] = obj._last_[real_key] = val
      define obj, key
  return obj

es5unobserve = (obj, f) ->
  delete obj._notice_[obj._notice_.indexOf(f)]

unless Object.observe
  Object.defineProperties Object,
    observe:
      value: es5observe
      enumerable: false
    unobserve:
      value: es5unobserve
      enumerable: false


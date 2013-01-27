# What's this?

This is Object.observe Porting to es5 for MVC implements.

I want to use Object.observe and 'updated' event, mainly.

So, Other Events doesn't work correctly.


## How To Use

```javascript
var f = function(e){
  console.log(e[0].type);
};

var obj = Object.observe({x: 1}, f);
obj.x = 2; //=> 'updated'
obj.x = 2; //=> not fire
obj.x = undefined; //=> 'deleted'

Object.unobserve(obj, f); // delete callback
```


## Support

- Object.observe
- Object.unobserve

## Not Support

- Custom Event Type
- reconfigured Event

## Notice

if you want to use 'new' event type,
you must initialize as any value when call observe.
it extends some properties for update checking.


I checked only Chrome.

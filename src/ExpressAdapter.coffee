class ExpressAdapter
  required:['app']
  constructor:(@params)->
  addRoute:(route, method, handler)->
    @params.app[method]? route, handler || @responseHandler
  responseHandler:(res, data, headers)->
    if !headers
      res.setHeader 'Content-Type', 'application/json'
    else
      for header,value of headers
        res.setHeader header, value
    res.send data.status, data.content
  requestHandler:->
    # not implemented
    false
module.exports = ExpressAdapter
module.exports.use = (express)=>
  new ExpressAdapter app:express

fs                = require 'fs'
path              = require 'path'
(chai             = require 'chai').should()
API               = require 'rikki-tikki'
{AbstractRoute}   = API.base_classes
express           = require 'express'
# cookieParser      = require 'cookie-parser'
# bodyParser        = require 'body-parser'
# methodOverride    = require 'method-override'
# errorhandler      = require 'errorhandler'
# session           = require 'express-session'
Adapter           = require '../src/ExpressAdapter'
describe 'ExpressAdapter Test Suite', ->
  clazz   = class Tester extends Adapter
  API.CONFIG_PATH = "#{__dirname}/configs"
  API.SCHEMA_PATH = "#{__dirname}/schemas"  
  describe 'ExpressAdapter Instantiation', =>
    it 'should create an Adapter Instance', =>
      app    = express()
      router = express.Router()
      console.log Adapter.use router
      (@adapter = Adapter.use router).params.app.should.equal router
    it 'should register with an API Instance', (done)=>
      (api = new API
        config_path: API.CONFIG_PATH
        adapter:@adapter   
      ).on 'open', (e,s)=>
        api.__adapter.should.equal @adapter
        done()
  describe 'ExpressAdapter Routing', =>
    app     = express()
    router  = express.Router()
    adapter = Adapter.use router
    it 'should create a route', =>
      class IndexRoute extends AbstractRoute
        handler:->
          false
      indexRoute = (-> false) #new IndexRoute
      adapter.addRoute '/', 'get', indexRoute
      adapter.addRoute '/View1', 'get', indexRoute
      console.log adapter.params.app.stack[1].route

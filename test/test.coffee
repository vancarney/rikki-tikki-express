fs                = require 'fs'
path              = require 'path'
(chai             = require 'chai').should()
express           = require 'express'
API               = require 'rikki-tikki'
Adapter           = require '../src/ExpressAdapter'
describe 'ExpressAdapter Test Suite', ->
  it 'should be registered', ->
    console.log API.listAdapters()
    API.listAdapters().length.should.equal 1

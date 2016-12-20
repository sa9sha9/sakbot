Helper = require('hubot-test-helper')
chai = require 'chai'

expect = chai.expect

helper = new Helper('../scripts/tenki2.coffee')

describe 'tenki2', ->
  beforeEach ->
    @room = helper.createRoom()

  afterEach ->
    @room.destroy()

  #  it 'responds to she ex with d', ->
  #    @room.user.say('alice', '@hubot she examine with doctor').then =>
  #      expect(@room.messages).to.eql [
  #        ['alice', '@hubot she examine with doctor']
  #        ['hubot', 'added 0: http://yahoo.co.jp, 200']
  #      ]

  it 'responds to she list', ->
    @room.user.say('alice', '@hubot tenki').then =>
      expect(@room.messages).to.eql [
        ['alice', '@hubot she ls']
        ['hubot', '']
#        ['hubot', "0 : 'https://developer.ce/Global_Objects/Array/map' 200"]
#        ['hubot', "1 : 'http://go.com' 200"]
#        ['hubot', "2 : 'http://yahoo.co.jp' 200"]
      ]

Helper = require('hubot-test-helper')
chai = require 'chai'

expect = chai.expect

helper = new Helper('../scripts/test.coffee')

describe 'all', ->
  beforeEach ->
    @room = helper.createRoom()

  afterEach ->
    @room.destroy()

  it 'responds to all', ->
    @room.user.say('alice', '@hubot test').then =>
      expect(@room.messages).to.eql [
        ['alice', '@hubot test']
      ]

#  it 'responds to ts in', ->
#    @room.user.say('alice', '@hubot ts in').then =>
#      expect(@room.messages).to.eql [
#        ['alice', '@hubot ts in']
#        ['hubot', '@alice \'alice\' comes in TS']
#      ]
#
#  it 'responds to ts out', ->
#    @room.user.say('alice', '@hubot ts out').then =>
#      expect(@room.messages).to.eql [
#        ['alice', '@hubot ts out']
#        ['hubot', '@alice \'alice\' left in TS']
#      ]
#
#  it 'responds to hello', ->
#    @room.user.say('Shell', '@l2-t2 ping').then =>
#      expect(@room.messages).to.eql [
#        ['Shell', '@l2-t2 ping']
#        ['l2-t2', 'PONG']
#
#      ]
#
#  it 'hears orly', ->
#    @room.user.say('bob', 'just wanted to say orly').then =>
#      expect(@room.messages).to.eql [
#        ['bob', 'just wanted to say orly']
#        ['hubot', 'yarly']
#      ]

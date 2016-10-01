# Description
#  User Local Inc.の自動会話APIを使った会話スクリプト
#
# Commands:
#  d3-g0 (whatever you want to talk)
#
# Author:
#  @sak39
#
# Thanks:
#  https://github.com/l2tporg/hubot-site-health-examine.git

request = require 'request'

module.exports = (robot) ->
#  robot.hear /location (.*)/, (msg) ->
#    request = robot.http("https://maps.googleapis.com/maps/api/geocode/json")
#    .query(address: msg.match[1])
#    .get()
#    request (err, res, body) ->
#      json = JSON.parse body
#      location = json['results'][0]['geometry']['location']
#      msg.send "#{location['lat']}, #{location['lng']}"

  USER_LOCAL_API_KEY = process.env.USER_LOCAL_API_KEY
  robot.respond /(.*)$/, (msg) ->
    robot.http("https://chatbot-api.userlocal.jp/api/chat")
    .query(message: msg.match[1], key:USER_LOCAL_API_KEY, bot_name: 'L2-T2', platform: 'slack', user_name: msg.message.user.name)
    .get() (err, res, body) ->
#            console.log res
#            console.log body
      if err
        console.log err
        return
      data = JSON.parse body
      msg.send data.result


  ### echo ###
  robot.hear /echo random (.*)/i , (msg) ->
    envelope = {room: process.env.SEND_ROOM}
    robot.send envelope, "#{msg.match[1]}"

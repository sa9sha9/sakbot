# Description
#  TSにログインしたことを自分の代わりにそっと通知してあげるコマンド
#
# Commands:
#  (d3-g0) ts in : 'username' comes in TS
#  (d3-g0) ts out : 'username' left from TS
#  (d3-g0) ts chroom (.*) : change a room at which bot sends a message
#
# Author:
#  @sak39
#
# Thanks:
#  https://github.com/l2tporg/hubot-site-health-examine.git

module.exports = (robot) ->
  roomName = {room: "ts"}

  robot.respond /ts chroom (.*)/i, (msg) ->
    roomName.room = msg.match[1]
    msg.send "SUCCESS: renamed to '#{roomName}'"

  robot.hear /ts in/i, (msg) ->
    userName = msg.envelope.user.name
    return if typeof robot?.send isnt 'function'
    robot.send roomName, "'#{userName}' comes in TS"


  robot.hear /ts out/i, (msg) ->
    userName = msg.envelope.user.name
    return if typeof robot?.send isnt 'function'
    robot.send roomName, "'#{userName} left from TS"




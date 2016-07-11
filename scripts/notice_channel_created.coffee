# Description:
#   notify create channel on Slack in #new_channels
#
# Notes:
#   required hubot-slack@3.0.0+
#
# Author:
#   kiris

module.exports = (robot) ->

  slack = robot.adapter.client
  slack.on 'raw_message', (message) ->
    if message?.type == 'channel_created'
      return if typeof robot?.send isnt 'function'
      robot.send message
      robot.send {room: "general"}, "新しいチャンネル <##{message.channel.id}> が作られたぜ！ ひゃっふーうっ！！"
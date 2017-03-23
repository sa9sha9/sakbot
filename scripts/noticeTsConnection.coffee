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

Alfred = require('alfred-teamspeak');
tunnel = require('tunnel-ssh')

# localで動かす場合にはこれを読み込む
# local_env = require('../private/env.json')

env = {
  SSH_HOST:           process.env.SSH_HOST,
  SSH_USER:           process.env.SSH_USER,
  SSH_KEY:            process.env.SSH_KEY,
  SSH_KEY_PASSPHRASE: process.env.SSH_KEY_PASSPHRASE
  TS_HOST:            process.env.TS_HOST,
  TS_ADMIN:           process.env.TS_ADMIN,
  TS_ADMIN_PASSWORD:  process.env.TS_ADMIN_PASSWORD,
}

module.exports = (robot) ->

  ### slack channel ###
  roomName = {room: "ts"}

  ### slack ts command ###
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
    robot.send roomName, "'#{userName}' left from TS"

  ### ts auto monitoring ###
  ### ローカルで動かす場合にはprivate/envをexportすべし ###
  config = {
    username: env.SSH_USER
    port: 22,
    host: env.SSH_HOST
#    privateKey:require('fs').readFileSync('/Users/hoge/.ssh/id_rsa'),
    privateKey: env.SSH_KEY,
    passphrase: env.SSH_KEY_PASSPHRASE
    dstPort: 10011,
#    dstHost: 'ts3.l2tp.org', # target hostname
    dstHost: env.TS_HOST, # target hostname
    localHost: 'localhost',
    localPort: 10011
  }

  console.log config #@@

  server = tunnel(config, (err, res) ->
    if err
      console.error err

    console.log('SSH Tunnel Connected!!')

    #これ以降にlocalhostに対する10011ポートはaet05へ流れる
    bot = new Alfred({host: 'localhost'});

    bot.login(env.TS_ADMIN, env.TS_ADMIN_PASSWORD)
    .then(() ->
      console.log 'Login successfull!!'
      bot.get('port')
      bot.send('servernotifyregister', {'event': 'server'})
    )
    .catch((err) -> console.error(err))

    ### notice when any client logged in ###
    bot.on 'cliententerview', (data) ->
      robot.send roomName, "'#{data.client_nickname}' comes in TS"
      console.log data.client_nickname, 'connected!'
  )

# port:10011がssh越しでないと接続できないため以下では不可能
#  do () ->
#    bot.login('serveradmin', '7VPTgL8Y')
#      .then(() ->
#      console.log 'Connected!'
#      bot.send('servernotifyregister', {'event': 'server'})
#    )
#      .catch((err) -> console.error(err))
#
#    ### notice when any client logged in ###
#    bot.on 'cliententerview', (data) ->
#      console.log data.client_nickname, 'connected!'




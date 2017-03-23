# Description
#   A Hubot script that responds 'World!'
#
# Configuration:
#   None
#
# Commands:
#   hubot tenki - responds 'World!'
#
# Author:
#   yousan <yousan@gmail.com>
#
# Thanks:
#   hubot bouzuya <m@bouzuya.net>
#   weather http://qiita.com/kingpanda/items/ad745ba567b4524e132f
#   cron http://qiita.com/mats116/items/0164b37ffaa90f03f2a0

# ts-bot
#Alfred = require('alfred-teamspeak')

#module.exports = (robot) ->
  ### with 'tunnel-ssh' ###
#  tunnel = require('tunnel-ssh')
#
#  config = {
#    username: 'pncity',
#    port: 22,
#    host: 'aet05.l2tp.org',
#    privateKey:require('fs').readFileSync('/Users/sa9sha9/.ssh/id_rsa'),
#    passphrase: 'anc=pns39',
#    dstPort: 10011,
#    dstHost: '172.17.0.2',
#    localHost: 'localhost',
#    localPort: 10011
#  }
#
#  server = tunnel(config, (err, res) ->
#    if err
#      console.error err
#
#    console.log('SSH Tunnel Connected!!')
#
#    #これ以降にlocalhostに対する10011ポートはaet05へ流れる
#    bot = new Alfred({host: 'localhost'});
#
#    bot.login('serveradmin', '7VPTgL8Y')
#    .then(() ->
#      console.log 'Login successfull!!'
#      bot.get('port')
#      bot.send('servernotifyregister', {'event': 'server'})
#    )
#    .catch((err) -> console.error(err))
#
#    ### notice when any client logged in ###
#    bot.on 'cliententerview', (data) ->
#      console.log data.client_nickname, 'connected!'
#  )



  ### with 'node-ssh2' ###
#  Client = require('ssh2').Client

#  conn = new Client()
#  conn.on('ready', () ->
#    # ready
#    console.log('ready ssh...')


#    do () ->
#      bot.login('serveradmin', '7VPTgL8Y')
#      .then(() ->
#        console.log 'Connected!'
#        bot.get('port')
#        bot.send('servernotifyregister', {'event': 'server'})
#      )
#      .catch((err) -> console.error(err))
#
#      ### notice when any client logged in ###
#      bot.on 'cliententerview', (data) ->
#        console.log data.client_nickname, 'connected!'

#   # ssh exec
#    conn.exec 'ls', (err, stream) ->
#      if err
#        throw err
#      stream.on('close', (code, signal) ->
#        console.log 'Stream :: close :: code: ' + code + ', signal: ' + signal
#        conn.end()
#        return
#      ).on('data', (data) ->
#        console.log 'STDOUT: \n' + data
#        return
#      ).stderr.on 'data', (data) ->
#        console.log 'STDERR: ' + data
#        return
#  )
#  .connect({
#    host: 'aet05.l2tp.org',
#    port: 22,
#    username: 'pncity',
#    privateKey: require('fs').readFileSync('/Users/sa9sha9/.ssh/id_rsa'),
#    passphrase: 'anc=pns39'
#  });

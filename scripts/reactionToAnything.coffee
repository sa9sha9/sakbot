# Description
#  チャンネルにURLを貼ると何かしら反応してくれる機能
#
# Commands
#  (d3-g0) add reaction (.*) : adding new reaction
#  (d3-g0) del reaction (.*) : delete reaction
#  (d3-g0) ls reaction       : reaction list
#   d3-g0  bother us         : d3-g0 will bother us
#   d3-g0  shut up           : d3-g0 will be quiet
#
# Author:
#  @sak39
#
# Thanks:
#  https://github.com/sak39/sacbot.git
cheerio = require 'cheerio-httpcli'
request = require 'request'
redis = require 'redis'
url   = require "url"


module.exports = (robot) ->
  key = 'reactions'
  quietFlag = 0
  envelope = {room: process.env.SEND_ROOM}

  ### REDIS Setting ###
  if process.env.REDISTOGO_URL
    rtg    = url.parse process.env.REDISTOGO_URL
    client = redis.createClient rtg.port, rtg.hostname
    client.auth rtg.auth.split(":")[1]
  else
    client = redis.createClient()

  client.on("error", (err) ->
    console.log("Error " + err)
  )


  ### REDIS Functions ###
  #get
  getReactions = (callback) ->
    client.lrange(key, 0, -1, callback)

  #add
  addReaction = (reaction, callback) ->
    client.rpush(key, reaction, callback)

  #remove
  removeReaction = (str, callback) ->
    client.lrem(key, 1, str, callback)
  #    index指定できるようになったら,以下を追加
  #    client.lindex(key, index, (err, value) ->
  #      if err?
  #        client.lrem(key, 1, value, callback)
  #    )

  ### フロントエンド ###
  # http(s)://
  robot.hear /http(?:s)?:\/\/(.*)$/i, (msg) ->
    if /(.*)wikipedia(.*)/.test(msg.match[1]) # wikipediaの時のみ
      getTitleOfWikipedia(msg.match[0], msg)
    else if quietFlag is 0 and msg.message.user.name is 'saku'
      getReactions((err, res) ->
        console.log Math.random()
#        msg.send "@#{msg.message.user.name}: #{msg.random(res)}" if Math.random() > 0.5
        msg.send "@#{msg.message.user.name}: #{msg.random(res)}"
      )

  # wikipediaのリンクが貼られた時に発火
  getTitleOfWikipedia = (url, msg) ->
    cheerio.fetch(url, (err, $, header) ->
      msg.send "#{$('title').text()} っすね"
    )

  # 任意off
  robot.respond /(?:.*)shut up(?:.*)/i, (msg) ->
    quietFlag = 1
    msg.send "かしこまりました。 静かにしてます。"
    console.log quietFlag

  robot.respond /(?:.*)bother us(?:.*)/i, (msg) ->
    quietFlag = 0
    msg.send "かしこまりました！ しゃべります！"
    console.log quietFlag

  ### データベース操作 ###
  # Initial add (万が一のとき用)
  robot.hear /initial add reaction/i, (msg) ->
    reactions = [
      "なんすかコレ！めっちゃ面白いっすね！！",
      "これは一見の価値ありですね！！",
      "ためになります！",
      "また一つ私は賢くなりました。ためになります。",
      "なんという良記事！！",
      "これ以前に読んだことがあります。何度見ても勉強になるっす！",
      "私もこんな理路整然とした文章書いてみたいです..",
      "初めて読みました！",
      "あとで読んでみますね",
    ]
    reactions.map((el) ->
      addReaction(el, (err, res) ->
        if err
          console.log("Initial Adding ERROR: Unexpected Error")
        else
          console.log("Initial Adding: SUCCESS")
      )
    )

  # add
  robot.hear /add reaction(?:\s)?(.*)?/i, (msg) ->
    if msg.match[1] is undefined
      msg.send "?"
    else
      addReaction(msg.match[1], (err, res) ->
        if err
          console.log("Adding ERROR: " + "Unexpected Error")
        else
          console.log("Adding: SUCCESS")
          msg.send "記憶しました！"
          # res.send envelope, hogeだと、envelopeも発言してしまう
      )

  # delete
  robot.hear /del reaction(?:\s)?(.*)?/i, (msg) ->
    if msg.match[1] is undefined
      msg.send '?'
    else
      removeReaction(msg.match[1], (err, res) ->
        if err
          console.log("Removing ERROR: " + err)
        else
          console.log("Removing: " + res)
          if res > 0
            robot.send {room: msg.message.user.name}, "I forget it. '#{msg.match[1]}'" #個人チャットに発言
          else
            robot.send {room: msg.message.user.name}, "I don't know such a reaction."  #個人チャットに発言
      )

  # list
  robot.hear /l(?:i)?s(?:t)? reaction/i, (msg) ->
    getReactions((err, res) ->
      if err
        console.log("Getting ERROR: " + err)
      else if res.length is 0
        console.log("Getting ERROR: " + "empty")
        robot.send {room: msg.message.user.name}, "empty" #個人チャットに送信
      else
        res.map( (el, index, array) ->
          robot.send {room: msg.message.user.name}, el #個人チャットに送信
        )
    )



  ### Test ###
#  getCallback = (err, res) ->
#    if err
#      console.log("Getting ERROR: " + err)
#    else if res.length is 0
#      console.log("Getting ERROR: " + "empty")
#    else
#      console.dir(res)
#
#  addCallback = (err, res) ->
#    if res > 0  #この条件がSUCCESSであるとは限らない
#      console.log("Adding: SUCCESS")
#    else
#      console.log("Adding ERROR: " + "Unexpected Error")
#
#  removeTarget = 'aaa'
#  removeCallback = (err, res) ->
#    if err
#      console.log("Removing ERROR: " + err)
#    else
#      console.log("Removing: " + res)

  ### calling ###
#  data = 'bbb'
#  getReactions(getCallback)
#  addReaction(data, addCallback)
#  removeReaction(removeTarget, removeCallback)
#  getReactions(getCallback)

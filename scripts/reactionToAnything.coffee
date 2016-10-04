# Description
#  チャンネルにURLを貼ると何かしら反応してくれる機能
#
# Commands
#  (d3-g0) add reaction (.*) : adding new reaction
#  (d3-g0) del reaction (.*) : delete reaction
#  (d3-g0) ls reaction       : reaction list
#
# Author:
#  @sak39
#
# Thanks:
#  https://github.com/sak39/sacbot.git
cheerio = require 'cheerio-httpcli'
request = require 'request'

module.exports = (robot) ->
  envelope = {room: process.env.SEND_ROOM}

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

  # フロントエンド
  robot.hear /http(?:s)?:\/\/(.*)$/i, (res) ->
    # res.random ->
    # function (items) {
    #   return items[Math.floor(Math.random() * items.length)];
    # }
    if /(.*)wikipedia(.*)/.test(res.match[1]) # wikipediaの時のみ
      getTitleOfWikipedia(res.match[0], res)
    else
      res.send "@#{res.message.user.name}: #{res.random(reactions)}"

  getTitleOfWikipedia = (url, res) ->
    cheerio.fetch(url, (err, $, header) ->
      res.send $('title').text()}
    )






  ### データベース操作 ###
  # add
  robot.hear /add reaction(?:\s)?(.*)?/i, (res) ->
    if res.match[1] is undefined
      res.send "?"
    else
      reactions.push res.match[1]
      res.send "記憶しました！"
      # res.send envelope, hogeだと、envelopeも発言してしまう
      robot.send {room: res.message.user.name}, reactions #追加した本人のDMへ一覧を送信

  # delete
  robot.hear /del reaction(?:\s)?(.*)?/i, (res) ->
    if res.match[1] is undefined
      res.send '?'
    else
      resultIndex = reactions.indexOf(res.match[1])
      if resultIndex > 0
        reactions.splice(resultIndex, 1)
        robot.send {room: res.message.user.name}, "I forget it. '#{res.match[1]}'"
      else
        robot.send {room: res.message.user.name}, "I don't know such a reaction."

  # list
  robot.hear /l(?:i)?s(?:t)? reaction/i, (res) ->
    reactions.map( (el, index, array) ->
      robot.send {room: res.message.user.name}, el
    )


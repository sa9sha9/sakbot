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


module.exports = (robot) ->
  envelope = room: process.env.SEND_ROOM
# Seconds: 0-59
# Minutes: 0-59
# Hours: 0-23
# Day of Month: 1-31
# Months: 0-11
# Day of Week: 0-6
#  new cronJob('0 45 7 * * * ', () =>
#    envelope = room: "sak39_times" # 発言する部屋の名前
#    # robot.send envelope, '[http://hoge.com|hoge] yahooo'
#    # robot.emit 'slack.attachment', {room: 'times_yousan', text: '<https://github.com/link/to/a/PR|myrepo #42> fix some broken>'}
#
#    # 地点定義表: http://weather.livedoor.com/forecast/rss/primary_area.xml
#    # city=160010 : 富山市
#    # city=230010 : 愛知県
#    # city=070030 : 会津若松
#    # city=100010 : 前橋市
#    tenki(robot, envelope, '100010')
## console.log msg
#  , null, true, 'Asia/Tokyo'
#  ).start()

  robot.listen(
    (msg) ->
      msg.user.name is 'uran' and (new Date().getHours()) is 7
#      msg.user.name is 'Shell' and msg.text is 'emit'
    (res) ->
      tenki(robot, envelope, '100010')
  )

tenki = (robot, envelope, city) ->
  request = robot.http('http://weather.livedoor.com/forecast/webservice/json/v1?city='+city).get()
  request (err, res, body) ->
    json = JSON.parse body
    console.log json
    # how to make a link at slack
    # @link https://api.slack.com/docs/formatting#linking_to_urls
    # #{json['link']}
    msgs ="""
           ちなみに、#{json['location']['prefecture']} #{json['location']['city']}市の天気は「#{json['forecasts'][0]['telop']}」最高気温は #{json['forecasts'][1]['temperature']['max']['celsius']}度, 最低気温 #{json['forecasts'][1]['temperature']['min']['celsius']}度です。
      """
    robot.send envelope, msgs

    ### more detail ###
#    robot.send envelope, 'もっと詳しく聞きたいですか？'
#    flag = 0
#    robot.hear '/yes/i', (msg) ->
#      console.log 'らじゃー'
#      robot.emit 'moreDetailTenki', robot, envelope
#
#    robot.on 'moreDetailTenki', (robot, envelope) ->
#      robot.send envelope, "${json['description']['text']}"
#      flag = 1
#
#    console.log 'robot: ', robot.listeners
#
#    setTimeout( () ->
#      console.log 'enter'
#      robot.events.removeListener 'moreDetailTenki', (robot, envelope) ->
#        if flag == 0
#          robot.send envelope, "必要ないようですね。"
#        else
#          robot.send envelope, "今日も１日頑張りましょう！"
#      console.log 'robot: ', robot.listeners
#    , 5000)




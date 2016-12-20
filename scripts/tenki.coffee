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


#module.exports = (robot) ->
#  envelope = room: process.env.SEND_ROOM
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

# @@@
  #robot.listen(
  #  (msg) ->
      # Dateインスタンスを生成(時差を考慮)
      #offset = 9
      #d = new Date();
      #nd = new Date(d.getTime() + (3600000 * offset))

      #regex = /名古屋(.*)/
      #ユーザ名が'uran'でAM7時台に発言して、なおかつその発言に'名古屋'が含まれているもの
      #msg.user.name is 'uran' and (nd.getHours()) is 7 and regex.test(msg.text)
#     # msg.user.name is 'saku' and (nd.getHours()) is 13
#     # pattern = /(.*)emit(.*)/
#     # msg.user.name is 'Shell' and pattern.test(msg.text)
    #(res) ->
    #  console.log 'tenki emit'
    #  tenki(robot, envelope, '100010')
  #)

#tenki = (robot, envelope, city) ->
#  request = robot.http('http://weather.livedoor.com/forecast/webservice/json/v1?city='+city).get()
#  request (err, res, body) ->
#    json = JSON.parse body
#    console.log json
#    # how to make a link at slack
#    # @link https://api.slack.com/docs/formatting#linking_to_urls
#    # #{json['link']}
#    msgs ="""
#           ちなみに、#{json['location']['prefecture']} #{json['location']['city']}市の天気は「#{json['forecasts'][0]['telop']}」最高気温は #{json['forecasts'][1]['temperature']['max']['celsius']}度, 最低気温 #{json['forecasts'][1]['temperature']['min']['celsius']}度です。
#      """
#    robot.send envelope, msgs
#    starwarsTenki(robot)

#starwarsTenki(robot) ->
#  key = 'starwars_planet';
#  planets = [
#    {name: 'ナブー',}
#  ];


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




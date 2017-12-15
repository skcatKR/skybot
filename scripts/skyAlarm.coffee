# Description
#  テストモジュール
# 
# Dependencies:
#  "モジュール名": "モジュールのバージョン" // 依存関係を書いておく
#
# Configuration:
#  HUBOT_ALARM_MESSAGES:アラームメッセージリスト
#
# Commands:
#  自動
#
# Notes:
#  メモ書き, その他
#
# Author:
#  githubのusernameを書く
#   Remind @channel "テストメッセージです。"

cronJob = require('cron').CronJob

config =
  msg: JSON.parse(process.env.HUBOT_ALARM_MESSAGES ? '[]')

module.exports = (robot) ->
  # 投稿時間
  sendTime = "0 55 17 * * 1-5"
  
  # 投稿対象部屋
  room = "general"
  #room = "channelcreationnews"

  messageFunc = () ->

    # メッセージをランダムで選択する
    message = config.msg[Math.floor(Math.random() * config.msg.length)]
    message = "@channel #{ message }"

    robot.send {room: "#" + room}, message

  # 送信
  new cronJob sendTime, messageFunc, null, true, 'Asia/Tokyo'
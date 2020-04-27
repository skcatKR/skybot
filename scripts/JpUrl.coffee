# Description:
#   encodeされたURLを日本語に戻す

module.exports = (robot) ->

  robot.hear /(https?:\/\/(?!172.30.10.145)[^ ]+)/i, (msg) ->

    who = msg.message.user.name
    url = msg.match[1]
    return if url is decodeURI url
    url = decodeURI(url).replace /[ <>]/g, (c) -> encodeURI c
    msg.send "@#{who} 日本語でおｋ\n#{url}"
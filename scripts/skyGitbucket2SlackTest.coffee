# Description
#  テストモジュール
# 
# Dependencies:
#  "モジュール名": "モジュールのバージョン" // 依存関係を書いておく
#
# Configuration:
#
#
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

module.exports = (robot) ->
  robot.router.post "/gitbucket-to-slack-test/:room", (req, res) ->
    { room } = req.params
    { body } = req

    try

      if body.payload
        json = JSON.parse body.payload
        repoUrl = json.repository.html_url
        repoName = json.repository.full_name
        action = json.action
        comment = json.comment
        issue = json.issue
        pr = json.pull_request
        commits = json.commits
        userName = ""
        title = ""
        url = ""
        body = ""

        if action is "created"
          # Comment
          if comment
            console.log("comment")
            message = "==== #{comment.user.login} のこめんと！！ ====\n"
            message += "##{issue.number}: #{issue.title}\n"
            message += "#{comment.body}\n"
            message += "#{comment.html_url}"

        if action in ["opened", "closed", "reopened"]
          console.log("issue")
          # Issue
          if issue
            message = "==== #{issue.user.login} のいしゅー！！ ====\n"
            message += "##{issue.number}: #{issue.title}\n"
            message += if action is "opened" then "#{issue.body}\n" else "#{action}\n"
            message += "#{issue.html_url}"

          # Pull Request
          if pr
            console.log("pull requ")
            message = "==== #{pr.user.login} がつくったプルリクみつけたよ！！ ====\n"
            message += "##{pr.number}: #{pr.title}\n"
            message += "#{pr.body}\n"
            message += "#{pr.html_url}"

          # Push
          if commits
            console.log("commits")
            message = "==== こみっと！！ ====\n"
            message += "author: #{commits[0].author.name}<#{commits[0].author.email}>\n"
            message += "message: #{commits[0].message}\n"
            message += "url: #{commits[0].url}"

        if message?
            robot.messageRoom room, message
            res.end "OK"
        else
            robot.messageRoom room, "gitbucket integration error."
            res.end "Error"
    catch error
      robot.send
      res.end "Error"
require "slack-ruby-client"
require "logger"

# rubocop:disable Rails/TimeZone
class CommitStore
  class << self
    def diff(prev_commit, commit)
      if prev_commit
        `git log --pretty="%h - %<(15,trunc)%an : %<(30,trunc)%s (%cr)" #{prev_commit}..#{commit}`
      else
        `git log --pretty="%h - %<(15,trunc)%an : %<(30,trunc)%s (%cr)"`
      end
    end
  end
end

Slack.configure do |config|
  config.token = "smU39ACkZv5q8iO9M8RXRNzH"
end

# env = ARGV[0]
branch = ARGV[1]
application = ARGV[2]
commit = ARGV[3]
prev_commit = ARGV[4]

diff_commits = if commit != prev_commit
  CommitStore.diff(prev_commit, commit)
else
  "nothing"
end

message = %(
<!channel>

_*[#{application} staging]*_

*Datetime*: #{Time.now}
*Branch  *: #{branch}
*Commit  *: #{commit}
*Diffs   *:
```
#{diff_commits.strip}
```
)

logger = Logger.new("log/slack.log")
logger.formatter = proc do |severity, datetime, _progname, msg|
  "#{severity} - #{datetime}: #{msg}\n"
end
logger.debug message

client = Slack::Web::Client.new
client.chat_postMessage(channel: "#general", text: message, as_user: true)
# rubocop:enable Rails/TimeZone

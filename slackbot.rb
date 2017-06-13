require 'slack-ruby-bot'

class RavenBot < SlackRubyBot::Bot
  command 'ping' do |client, data, _match|
    client.say(text: 'pong', channel: data.channel)
  end

  command 'about' do |client, data, _match|
    client.say(text: '#DreamTeam - EarlBird 2017 (github.com/earlyravens) - Max Peiros - (github.com/mpeiros), Mina Melosh (github.com/minamelosh), Earl Sabal (github.com/earlsabal), Helen Khumthong (github.com/tamietta), Patrick Tangphao (github.com/ptangphao)', channel: data.channel)
  end
end

SlackRubyBot::Client.logger.level = Logger::WARN

RavenBot.run

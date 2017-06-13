require 'slack-ruby-bot'
require 'httparty'

class RavenBot < SlackRubyBot::Bot
  command 'ping' do |client, data, _match|
    client.say(text: 'pong', channel: data.channel)
  end

  command 'search' do |client, data, _match|
    # results = HTTParty.get("https://earlybirdsearch.herokuapp.com/?business=#{expression}&location=94105")
    results = HTTParty.get("https://earlybirdsearch.herokuapp.com/?business=sushi&location=94105")
    results.each do |business|
      client.say(text: "#{business["name"]}", channel: data.channel)
    end
  end

  command 'about' do |client, data, _match|
    client.say(text: '#DreamTeam - EarlyBird 2017 (github.com/earlyravens) - Max Peiros - (github.com/mpeiros), Mina Melosh (github.com/minamelosh), Earl Sabal (github.com/earlsabal), Helen Khumthong (github.com/tamietta), Patrick Tangphao (github.com/ptangphao)', channel: data.channel)
  end
end

SlackRubyBot::Client.logger.level = Logger::WARN

RavenBot.run

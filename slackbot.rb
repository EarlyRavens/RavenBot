require 'slack-ruby-bot'

class Raven < SlackRubyBot::Bot
  command 'ping' do |client, data, match|
    client.say(text: "I will rain down an ungodly firestorm.", channel: data.channel)
  end

  command 'about' do |client, data, match|
    client.say(text: "#DreamTeam - Max Peiros(Model), Helen Khumthong(Controller), Mina Melosh(View), Earl Sabal(Helpers), Patrick Tangphao(Schema)")
  end
end

Raven.run

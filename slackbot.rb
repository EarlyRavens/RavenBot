require 'slack-ruby-bot'
require 'httparty'

class RavenBot < SlackRubyBot::Bot
  command 'help' do |client, data, _match|
    command_list = "Type 'search' followed by a term to search for potential clients based on your search criteria. Raven limits searches to the '94105' zipcode. \n Additional commands: 'about' , 'quote' "
    client.say(text: command_list, channel: data.channel)
  end

  command 'quote' do |client, data, _match|
    results = HTTParty.get("https://earlybirdsearch.herokuapp.com/")
    client.say(text: results["quote"], channel: data.channel)
  end

  command 'search' do |client, data, _match|
    # results = HTTParty.get("https://earlybirdsearch.herokuapp.com/?business=#{expression}&location=94105")
    client.say(text: "Searching for potential clients related to: sushi", channel: data.channel)
    results = HTTParty.get("https://earlybirdsearch.herokuapp.com/?business=sushi&location=94105")
    results["data"].each do |business|
      business_name = business["name"]
      business_url = business["url"].split('?').first
      client.say(text: "#{business_name} : #{business_url}", channel: data.channel)
    end
  end

  command 'about' do |client, data, _match|
    client.say(text: '#DreamTeam - EarlyBird 2017 (github.com/earlyravens) - Max Peiros - (github.com/mpeiros), Mina Melosh (github.com/minamelosh), Earl Sabal (github.com/earlsabal), Helen Khumthong (github.com/tamietta), Patrick Tangphao (github.com/ptangphao)', channel: data.channel)
  end
end

SlackRubyBot::Client.logger.level = Logger::WARN

RavenBot.run

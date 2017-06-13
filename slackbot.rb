require 'slack-ruby-bot'
require 'httparty'

 QUOTES = ["The early bird gets the worm! - Mina", "There is an art to the process of problem solving - Mike Tarkington", "Efficiency Focused - it's always important to work smart in addition to working hard - Mike Tarkington", "Creative Solutions - even the most difficult challenges can be overcome with creativity and cleverness - Mike Tarkington", "You miss all the shots you don't take - Wayne Gretzky - Michael Scott", "Fart - Omar Cameron", "They Don't Think It Be Like It Is But It Do - Max Peiros", "Has Anyone Really Been Far Even as Decided to Use Even Go Want to do Look More Like? - Patrick Tangphao", "We did the thing - Earl Sabal", "That's Amazing! - Helen Khumthong"]


COMMAND_LIST = "Type 'search' followed by a term to search for potential clients based on your search criteria. Raven limits searches to the '94105' zipcode. \n Additional commands: 'about' , 'quote' "

class RavenBot < SlackRubyBot::Bot
  command 'help' do |client, data, _match|
    client.say(text: COMMAND_LIST, channel: data.channel)
  end

  command 'quote' do |client, data, _match|
    client.say(text: QUOTES.sample, channel: data.channel)
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

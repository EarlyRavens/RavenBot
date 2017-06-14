require 'slack-ruby-bot'
require 'httparty'
require_relative 'slackbot_helper'

class RavenBot < SlackRubyBot::Bot
  command 'help' do |client, data, _match|
    help_display(client,data)
  end

  command 'quote' do |client, data, _match|
    generate_random_quote(client,data)
  end

  command 'search' do |client, data, _match|
    begin
      search_term = extract_search_term(_match)
      if invalid_search(search_term)
        invalid_input_message(client,data)
      else
        begin_search_message(search_term,client,data)
        results = HTTParty.get("#{API_END_POINT}?business=#{search_term}}&location=94105")
        if results["data"].empty?
          client.say(text: "No results found.", channel: data.channel)
        else
          results["data"].each_with_index do |business, ranking|
            business_name = business["name"]
            business_url = business["url"].split('?').first
            client.say(text: "Result #{ranking + 1}: #{business_name} : #{business_url}", channel: data.channel)
          end
        end
      end
    rescue
      client.say(text: "An error occurred, please try again later.", channel: data.channel)
    end
  end

  command 'about' do |client, data, _match|
    client.say(text: '#DreamTeam - EarlyBird 2017 (github.com/earlyravens) - Max Peiros - (github.com/mpeiros), Mina Melosh (github.com/minamelosh), Earl Sabal (github.com/earlsabal), Helen Khumthong (github.com/tamietta), Patrick Tangphao (github.com/ptangphao). Created June 13, 2017.', channel: data.channel)
  end
end

SlackRubyBot::Client.logger.level = Logger::WARN

RavenBot.run

require 'slack-ruby-bot'
require 'httparty'
require_relative 'slackbot_helper'
require_relative 'poe'
require_relative 'slackbot_variables'

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
        results = query_earlybird_api(search_term)
        if no_results(results)
          no_results_message(client,data)
        else
          display_results(results,client,data)
        end
      end
    rescue
      error_message(client,data)
    end
  end

  command 'about' do |client, data, _match|
    about_message(client,data)
  end

  command 'nevermore' do |client, data, _match|
    nevermore(client,data)
  end

  command 'more' do |client, data, _match|
    more(client,data)
  end
end

SlackRubyBot::Client.logger.level = Logger::WARN

RavenBot.run

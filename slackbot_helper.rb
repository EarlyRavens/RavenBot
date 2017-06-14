def help_display(client,data)
  client.say(text: COMMAND_LIST, channel: data.channel)
end

def generate_random_quote(client,data)
  client.say(text: QUOTES.sample, channel: data.channel)
end

def extract_search_term(input)
  input.to_s.downcase.split("search").last
end

def invalid_search(input)
  input == "#{BOT_NAME} "
end

def invalid_input_message(client,data)
  client.say(text: "Please enter a valid input (e.g. 'search sushi')", channel: data.channel)
end

def begin_search_message(search_term,client,data)
  client.say(text: "Searching for potential clients related to: #{search_term}\n Please wait 10-15 seconds", channel: data.channel)
end

def query_earlybird_api(search_term)
  HTTParty.get("#{API_END_POINT}?business=#{search_term}}&location=94105")
end

def no_results(search_results)
  search_results["data"].empty?
end

def no_results_message(client,data)
  client.say(text: "No results found.", channel: data.channel)
end

def display_results(results,client,data)
  result_data = results["data"]
  result_data.each_with_index do |business, ranking|
    business_name = business["name"]
    business_url = business["url"].split('?').first
    client.say(text: "*Result #{ranking + 1}:* #{business_name} : #{business_url}", channel: data.channel)
  end
end

def error_message(client,data)
  client.say(text: "An error occurred, please try again later.", channel: data.channel)
end

def about_message(client,data)
  client.say(text: ABOUT_MESSAGE, mrkdwn: true, channel: data.channel)
end

def nevermore(client,data)
  client.say(text: THE_RAVEN, channel: data.channel)
end

def more(client,data)
  client.say(text: MORE_MESSAGE, channel: data.channel)
end


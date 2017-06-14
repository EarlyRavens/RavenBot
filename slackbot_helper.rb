#Set Constants

QUOTES = ["The early bird gets the worm! - Mina", "There is an art to the process of problem solving - Mike Tarkington", "Efficiency Focused - it's always important to work smart in addition to working hard - Mike Tarkington", "Creative Solutions - even the most difficult challenges can be overcome with creativity and cleverness - Mike Tarkington", "You miss all the shots you don't take - Wayne Gretzky - Michael Scott", "Fart - Omar Cameron", "They Don't Think It Be Like It Is But It Do - Max Peiros", "Has Anyone Really Been Far Even as Decided to Use Even Go Want to do Look More Like? - Patrick Tangphao", "We did the thing - Earl Sabal", "That's Amazing! - Helen Khumthong", "Only you can prevent forest fires - Smokey the Bear"]

COMMAND_LIST = "Type 'search' followed by a term to search for potential clients based on your search criteria. Raven limits searches to the '94105' zipcode. \n Additional commands: 'about', 'help', 'quote' "

API_END_POINT = "https://earlybirdsearch.herokuapp.com/"

BOT_NAME = "raven"

def help_display(client,data)
  client.say(text: COMMAND_LIST, channel: data.channel)
end

def generate_random_quote(client,data)
  client.say(text: QUOTES.sample, channel: data.channel)
end

def extract_search_term(input)
  input.to_s.split("search").last
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
    client.say(text: "Result #{ranking + 1}: #{business_name} : #{business_url}", channel: data.channel)
  end
end

def error_message(client,data)
  client.say(text: "An error occurred, please try again later.", channel: data.channel)
end

def about_message(client,data)
  client.say(text: '#DreamTeam - EarlyBird 2017 (github.com/earlyravens) - Max Peiros - (github.com/mpeiros), Mina Melosh (github.com/minamelosh), Earl Sabal (github.com/earlsabal), Helen Khumthong (github.com/tamietta), Patrick Tangphao (github.com/ptangphao). Created June 13, 2017.', channel: data.channel)
end

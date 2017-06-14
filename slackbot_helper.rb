#Set Constants

QUOTES = ["The early bird gets the worm! - Mina", "There is an art to the process of problem solving - Mike Tarkington", "Efficiency Focused - it's always important to work smart in addition to working hard - Mike Tarkington", "Creative Solutions - even the most difficult challenges can be overcome with creativity and cleverness - Mike Tarkington", "You miss all the shots you don't take - Wayne Gretzky - Michael Scott", "Fart - Omar Cameron", "They Don't Think It Be Like It Is But It Do - Max Peiros", "Has Anyone Really Been Far Even as Decided to Use Even Go Want to do Look More Like? - Patrick Tangphao", "We did the thing - Earl Sabal", "That's Amazing! - Helen Khumthong", "Only you can prevent forest fires - Smokey the Bear"]

COMMAND_LIST = "Type 'search' followed by a term to search for potential clients based on your search criteria. Raven limits searches to the '94105' zipcode. \n Additional commands: 'about', 'help', 'quote' "

API_END_POINT = "https://earlybirdsearch.herokuapp.com/"

BOT_NAME = "raven"

def help_display
  client.say(text: COMMAND_LIST, channel: data.channel)
end

def generate_random_quote
  client.say(text: QUOTES.sample, channel: data.channel)
end

def extract_search_term(input)
  input.to_s.split("search").last
end

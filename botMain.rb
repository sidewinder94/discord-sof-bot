require 'discordrb'

bot = Discordrb::Bot.new(token: ENV['BOT_TOKEN'], client_id: ENV['BOT_CLIENT_ID'])
#To make the bot join a guild https://discordapp.com/oauth2/authorize?&client_id=369566094731771914&scope=bot

bot.message(content: 'Ping!') do |event|
  event.respond 'Pong!'
end

bot.run

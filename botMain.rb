require 'discordrb'

bot = Discordrb::Bot.new(token: 'MzY5NTY2MDk0NzMxNzcxOTE0.DMaYww.QNVz7fFQLcq60F-jWHdI2XrdoUA', client_id: 369566094731771914)
#To make the bot join a guild https://discordapp.com/oauth2/authorize?&client_id=369566094731771914&scope=bot 
bot.message(content: 'Ping!') do |event|
  event.respond 'Pong!'
end

bot.run

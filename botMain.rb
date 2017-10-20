require 'discordrb'
require 'open-uri'
require_relative 'Commands/BaseCommands'

#To make the bot join a guild https://discordapp.com/oauth2/authorize?&client_id=369566094731771914&scope=bot
bot = Discordrb::Commands::CommandBot.new(token: ENV['BOT_TOKEN'], client_id: ENV['BOT_CLIENT_ID'], prefix: '!')

Commands::BaseCommands.addAllCommands(bot)

bot.run

require 'discordrb'
require 'open-uri'
require_relative 'Commands/BaseCommands'
require_relative 'Commands/RolePlayCommands'

#To make the bot join a guild https://discordapp.com/oauth2/authorize?&client_id=369566094731771914&scope=bot
bot = Discordrb::Commands::CommandBot.new(token: ENV['BOT_TOKEN'], client_id: ENV['BOT_CLIENT_ID'], prefix: '!')

Commands::BaseCommands.addAllCommands(bot)
Commands::RolePlayCommands.addAllCommands(bot)

bot.run

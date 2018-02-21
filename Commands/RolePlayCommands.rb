require 'discordrb'
require 'open-uri'
require_relative 'Common'

module Commands
  class RolePlayCommands
    class << self
      # @param [Discordrb::Commands::CommandContainer] container
      def addAllCommands(container)
        unless container.respond_to?(:command)
          raise 'Expected a type possessing commands'
        end
        roll(container)
      end

      private
      # @param [Discordrb::Commands::CommandContainer] container
      def roll(container)
        container.command :roll do |event, toRoll|
          deleteMessageSafely(event)
          begin
            if /^\d+d\d+/ === toRoll
              values = toRoll.split('d')
              if values[0].to_i == 0 || values[1].to_i == 0
                event.send_message('Invalid parameters, dice number or type equals 0 or can\'t be parsed')
              else
                die_number = values[0].to_i
                die_faces = values[1].to_i

                result = (1 + SecureRandom.random_number(die_faces))
                iterator = 1
                stringResults = "#{result}"
                while iterator < die_number
                  rdmResult = (1 + SecureRandom.random_number(die_faces))
                  result += rdmResult
                  iterator += 1
                  stringResults = stringResults + " + #{rdmResult}"
                end
                event.send_message("Asked : #{toRoll} \nRolled : #{result}\nRolls : #{stringResults}")
              end
            else
              event.send_message('Invalid parameter')
            end
          rescue Exception => detail
            event.send_message(detail)
          end
        end
      end


      # @param [Discordrb::Events::MessageEvent] event
      # @param [bool] displayError
      def deleteMessageSafely(event, displayError: false)
        begin
          event.channel.delete_message(event.message)
        rescue
          if displayError
            event.send_message('I don\'t have the rights to delete messages in this channel')
          end
        end
      end
    end
  end
end
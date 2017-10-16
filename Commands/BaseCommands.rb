require 'discordrb'

module Commands
  class BaseCommands
    class << self
      def addAllCommands(container)
        unless(container.respond_to?(:command))
          raise 'Expected a type possessing commands'
        end
        cantWaitForStatic(container)
      end

      private
      def cantWaitForStatic(container)
        container.command :wwcntw8 do |event|
          event.respond('Wow can\'t even wait to do it with your own static....')
          #container.send_file(event.channel, file,'toto')
        end
      end
    end
  end
end
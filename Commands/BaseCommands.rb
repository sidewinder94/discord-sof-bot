require 'discordrb'
require 'open-uri'

module Commands
  class BaseCommands
    class << self
      def addAllCommands(container)
        unless container.respond_to?(:command)
          raise 'Expected a type possessing commands'
        end
        cantWaitForStatic(container)
        manifestTest(container)
      end

      private
      def cantWaitForStatic(container)
        container.command :wwcntw8 do |event|
          open('https://data.zarrouk.eu/sof-discord-resources/images/gifs/cantwait.gif', 'rb') do |read_file|
            Dir.mktmpdir {|dir|
              filePath = "#{dir}/#{File.basename(read_file.base_uri.path)}"
              File.open(filePath, 'wb') do |save_file|
                save_file.write(read_file.read)
              end

              File.open(filePath, 'rb') do |f|
                event.send_file(f, caption:'Wow can\'t even wait to do it with your own static...')
              end
              File.delete(filePath)
             return
            }
          end
        end
      end

      def manifestTest(container)
        container.command :manifest do |event|
          unless event.message.author.id == 168053850664599553
            return
          end

          open('https://data.zarrouk.eu/lol-animation-changer/manifest.json', 'rb') do |read_file|
            Dir.mktmpdir {|dir|
              filePath = "#{dir}/#{File.basename(read_file.base_uri.path)}"
              File.open(filePath, 'wb') do |save_file|
                save_file.write(read_file.read)
              end

              File.open(filePath, 'rb') do |f|
                event.send_file(f, caption:'Here it comes !')
              end
              File.delete(filePath)
              return
            }
          end
        end
      end
    end
  end
end
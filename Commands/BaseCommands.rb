require 'discordrb'
require 'open-uri'

module Commands
  class BaseCommands
    class << self
      # @param [Discordrb::Commands::CommandContainer] container
      def addAllCommands(container)
        unless container.respond_to?(:command)
          raise 'Expected a type possessing commands'
        end
        cantWaitForStatic(container)
        uploadRemoteFile(container)


        manifestTest(container)
      end

      private
      # @param [Discordrb::Commands::CommandContainer] container
      def cantWaitForStatic(container)
        container.command :wwcntw8 do |event|
          deleteMessageSafely(event)
          begin
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
          rescue Exception => detail
            unless detail.is_a? LocalJumpError
              event.send_message('Couldn\'t download the required resource')
            end
          end
        end
      end

      # @param [Discordrb::Commands::CommandContainer] container
      def uploadRemoteFile(container)
        container.command :upload do |event, url, *text|
          deleteMessageSafely(event)
          begin
            open(url, 'rb') do |read_file|
              Dir.mktmpdir {|dir|
                filePath = "#{dir}/#{File.basename(read_file.base_uri.path)}"
                File.open(filePath, 'wb') do |save_file|
                  save_file.write(read_file.read)
                end

                File.open(filePath, 'rb') do |f|
                  event.send_file(f, caption: text.join(' '))
                end
                File.delete(filePath)
                return
              }
            end
          rescue Exception => detail
            unless detail.is_a? LocalJumpError
              event.send_message('Can\'t download the required resource')
            end
          end
        end

      end


      # @param [Discordrb::Commands::CommandContainer] container
      def manifestTest(container)
        container.command :manifest do |event|
          deleteMessageSafely(event)
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
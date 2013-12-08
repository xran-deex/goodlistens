class ChatController < WebsocketRails::BaseController
    def message
        broadcast_message :message, data
    end

    def initiate

    end

    def client_connected
        puts 'Client connected'
        controller_store[:id] = controller_store[:id] + 1
    end

    def set_id
        puts data
        u = User.find(data[:id])
        send_message :id, {:id => controller_store[:id], :name => u.name }
        data = { name: u.name }
        broadcast_message :joined, data
    end

    def initialize_session
        # perform application setup here
        controller_store[:id] = 0;
        controller_store[:message_count] = 0
    end

    def controls
        puts data[:id]
        if data[:message] == 'play'
            # puts data
            # broadcast_message :controls, {:message => 'play', :id => controller_store[:id]}
            WebsocketRails[data[:channelName]].trigger(:controls, {:message => 'play', :id => data[:id]})
        end
        if data[:message] == 'seek'
            # if data[:id] != controller_store[:id]
                WebsocketRails[data[:channelName]].trigger(:controls, {:message => 'seek', :time => data[:time], :id => data[:id]})
            # end
        end
        if data[:message] == 'pause'
            WebsocketRails[data[:channelName]].trigger(:controls, {:message => 'pause', :id => data[:id]})
        end
        if data[:message] == 'switchSrc'
            WebsocketRails[data[:channelName]].trigger(:controls, {:message => 'switchSrc', :src => data[:src], :id => data[:id]})
            # broadcast_message :controls, {:message => 'switchSrc', :id => data[:id], :src => data[:src]}
        end
    end
end
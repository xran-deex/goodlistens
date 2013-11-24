class ChatController < WebsocketRails::BaseController
    def message
        broadcast_message :message, data
    end

    def client_connected
        puts 'Client connected'
        controller_store[:id] = controller_store[:id] + 1
        send_message :id, {:id => controller_store[:id], :name => current_user.name}
        broadcast_message :joined, { :name => current_user.name}
    end

    def initialize_session
        # perform application setup here
        controller_store[:id] = 0;
        controller_store[:message_count] = 0
    end

    def controls
        puts data[:id]
        puts controller_store[:id]
        if data[:data] == 'play'
            broadcast_message :controls, {:message => 'play', :id => controller_store[:id]}
        end
        if data[:data] == 'seek'
            if data[:id] != controller_store[:id]
                broadcast_message :controls, {:message => 'seek', :time => data[:time], :id => data[:id]}
                #broadcast_message :controls, {:message => 'play'}
            end
        end
        if data[:data] == 'pause'
            broadcast_message :controls, {:message => 'pause', :id => data[:id]}
        end
    end
end
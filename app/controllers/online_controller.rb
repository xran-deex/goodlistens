class OnlineController < WebsocketRails::BaseController
    def send_status
        if data[:status] == 'update'
            broadcast_message :updateStatus, {id: data[:id], online: true, name: data[:name]}
        end
        if data[:status] == 'idle'
            puts data
            broadcast_message :updateStatus, {id: data[:id], online: false, name: data[:name]}
        end
    end
end
class AuthorizationController < WebsocketRails::BaseController
    def authorize_channels
        channel = WebsocketRails[message[:channel]]
        puts message
        accept_channel current_user
    end
end
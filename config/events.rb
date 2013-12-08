WebsocketRails::EventMap.describe do
  # You can use this file to map incoming events to controller actions.
  # One event can be mapped to any number of controller actions. The
  # actions will be executed in the order they were subscribed.
  #
  # Uncomment and edit the next line to handle the client connected event:
  #   subscribe :client_connected, :to => Controller, :with_method => :method_name
  subscribe :client_connected, :to => ChatController, :with_method => :client_connected
  subscribe :message, :to => ChatController, :with_method => :message
  subscribe :controls, :to => ChatController, :with_method => :controls
  subscribe :set_id, :to => ChatController, :with_method => :set_id
  subscribe :send_status, :to => OnlineController, :with_method => :send_status
  private_channel :private_chat
  
  namespace :websocket_rails do
    subscribe :subscribe_private, :to => AuthorizationController, :with_method => :authorize_channels
  end
end

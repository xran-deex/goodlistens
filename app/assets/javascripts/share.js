 $(function(){  
    var dispatcher = new WebSocketRails('localhost:3000/websocket');
    var channel_name = window.location.pathname.split('/')[2];
    var channel = null;
    var private_chat = dispatcher.subscribe(''+channel_name);
    if (channel_name == ''){
        channel = dispatcher;
    } else {
        channel = private_chat;
    }
    
    //alert();
    var context;
    dispatcher.on_open = function(data) {
      console.log('Connection has been established: ' + data);
      // private_chat.trigger('id', {id: currentUser.id, name: currentUser.name});
      channel.trigger('joined', {name: currentUser.name});

    }

    var audio = null;
    audio = document.getElementsByTagName("audio")[0];
    var track_num = 0;

    audio.addEventListener('seeked', function(e){
        if(sender == null || currentUser.id == sender.id ){
            var data = {message: "seek", time: e.srcElement.currentTime, id: currentUser.id, channelName: channel_name};
            channel.trigger('controls', data);
        }
    });

    audio.addEventListener('pause', function(e){
        var data = {message: "pause", id: currentUser.id, channelName: channel_name};
        channel.trigger('controls', data);
    }); 

    audio.addEventListener('play', function(e){
        var data = {message: "play", id: currentUser.id, channelName: channel_name};

        channel.trigger('controls', data);
    }); 

    audio.addEventListener('ended', function(e){
        //$('audio').attr('src', )
    });

    var triggered = false;
    var sender = null;
    // var user_name = null;

    channel.bind('id', function(e){
        id = e.id;
        user_name = e.name;
    });

    channel.bind('joined', function(e){
        $('#message').append('<p style="" id="joined">'+e.name+' has joined the chat</p>');
    });

    channel.bind('controls', function(e){
        
        if(e.message === 'play'){
            audio.play();
        }
        else if (currentUser.id != e.id && e.message == 'seek') {
            sender = e;
            audio.currentTime = e.time;
        }
        else if (currentUser.id != e.id && e.message == 'pause'){
            audio.pause();
        }
        else if (e.message == 'switchSrc'){
            $('audio').attr('src', e.src);
        }
    });

    channel.bind('message', function(e){
        $('#joined').remove();
        $('#message').prepend('<p style="padding:0px;">'+e.name+': '+e.data+'</p>');
    });

    $('#link').click(function(e){
        e.preventDefault();
        channel.trigger('message', {data: {data: $('textarea').val(), name: user_name, id: id}});
        $('textarea').val('');
        $('textarea').focus();
    });

    $('#messageBox').keypress(function(e){
        if(e.which == 13){
            channel.trigger('message', {data: $('#messageBox').val(), name: currentUser.name, id: currentUser.id});
            $('#messageBox').val('');
            $('#messageBox').focus();
        }
    });
    
    $('#load').click(function(e){
    	e.preventDefault();
    	var data = {message: 'switchSrc', id: currentUser.id, src: $('select option:selected').val(), channelName: channel_name};
    	channel.trigger('controls', data);
    });
});

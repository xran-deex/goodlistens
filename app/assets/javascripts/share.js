 $(function(){  
    var dispatcher = new WebSocketRails('192.168.1.11:3000/websocket');
    var context;
    dispatcher.on_open = function(data) {
      console.log('Connection has been established: ' + data);
    }

    var audio = null;
    audio = document.getElementsByTagName("audio")[0];
    //audio.setAttribute('src', '<%= root_path %>uploads/2/Test.mp3');

    audio.addEventListener('seeked', function(e){
        //$('#message').append('<p>'+e.srcElement.currentTime+'</p>');
        var data = {data: "seek", time: e.srcElement.currentTime, id: id};
        dispatcher.trigger('controls', {data: data});
    });

    audio.addEventListener('pause', function(e){
        //$('#message').append('<p>'+e.srcElement.currentTime+'</p>');
        var data = {data: "pause", id: id};
        dispatcher.trigger('controls', {data: data});
    }); 

    audio.addEventListener('play', function(e){
        //$('#message').append('<p>'+e.srcElement.currentTime+'</p>');
        var data = {data: "play", id: id};
        dispatcher.trigger('controls', {data: data});
    }); 

    var id = null;
    var user_name = null;

    dispatcher.bind('id', function(e){
        id = e.id;
        user_name = e.name;
        //$('#message').append('<p class="" id="joined">'+user_name+' has joined the chat</p>');
    });

    dispatcher.bind('joined', function(e){
        $('#message').append('<p style="" id="joined">'+e.name+' has joined the chat</p>');
    });

    dispatcher.bind('controls', function(e){

        if(e.message === 'play'){
            //$('#message').append('<p>'+e.id+': initiated play</p>');
            audio.play();
        }
        else if (id != e.id && e.message == 'seek') {
            //$('#message').append('<p>'+e.id+': initiated skip</p>');
            audio.currentTime = e.time;
            audio.play();
        }
        else if (id != e.id && e.message == 'pause'){
            audio.pause();
        }
    });

    dispatcher.bind('message', function(e){
        $('#joined').remove();
        $('#message').prepend('<p style="padding:0px;">'+e.name+': '+e.data+'</p>');
    });

    $('#link').click(function(e){
        e.preventDefault();
        dispatcher.trigger('message', {data: {data: $('textarea').val(), name: user_name, id: id}});
        $('textarea').val('');
        $('textarea').focus();
    });
});
 $(function(){  
    var dispatcher = new WebSocketRails('valis.strangled.net:8080/websocket');
    var context;
    dispatcher.on_open = function(data) {
      console.log('Connection has been established: ' + data);
      dispatcher.trigger('set_id', {data: currentUserId});
    }

    var audio = null;
    audio = document.getElementsByTagName("audio")[0];
    var track_num = 0;
    //audio.setAttribute('src', '<%= root_path %>uploads/2/Test.mp3');

    audio.addEventListener('seeked', function(e){
        var data = {data: "seek", time: e.srcElement.currentTime, id: id};
        dispatcher.trigger('controls', {data: data});
    });

    audio.addEventListener('pause', function(e){
        var data = {data: "pause", id: id};
        dispatcher.trigger('controls', {data: data});
    }); 

    audio.addEventListener('play', function(e){
        var data = {data: "play", id: id};
        dispatcher.trigger('controls', {data: data});
    }); 

    audio.addEventListener('ended', function(e){
        //$('audio').attr('src', )
    });

    var id = null;
    var user_name = null;

    dispatcher.bind('id', function(e){
        id = e.id;
        user_name = e.name;
    });

    dispatcher.bind('joined', function(e){
        $('#message').append('<p style="" id="joined">'+e.name+' has joined the chat</p>');
    });

    dispatcher.bind('controls', function(e){

        if(e.message === 'play'){
            audio.play();
        }
        else if (id != e.id && e.message == 'seek') {
            audio.currentTime = e.time;
            audio.play();
        }
        else if (id != e.id && e.message == 'pause'){
            audio.pause();
        }
        else if (e.message == 'switchSrc'){
            $('audio').attr('src', e.src);
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

    $('#messageBox').keypress(function(e){
        if(e.which == 13){
            dispatcher.trigger('message', {data: {data: $('#messageBox').val(), name: user_name, id: id}});
            $('#messageBox').val('');
            $('#messageBox').focus();
        }
    });
    
    $('#load').click(function(e){
    	e.preventDefault();
    	var data = {data: 'switchSrc', id: id, src: $('select option:selected').val()};
    	dispatcher.trigger('controls', {data: data});
    });
});

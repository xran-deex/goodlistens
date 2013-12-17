$(function(){

    $('#image').popover({
        title: 'Recommend this!', 
        html: true,
        container: 'body',
        content:"<a href='#' id='recommend'>Recommend</a> this to a friend of yours.",
        placement: 'auto top'
    });

    var hidePopover = function(){
        $('#image').popover('hide');
    };

    $('#image').mouseleave(function(){
        window.setTimeout(hidePopover, 4000);
    }); 

    $('body').on('click', '#recommend', function(){
        $('#recommendation_dialog').modal('show');
    });

    $('.popover').mouseover(function(){
        $('#image').popover('show');
    });

    $('#image').mouseenter(function(){
        $('#image').popover('show');
    });

    $('body').on('click', '.submit-btn', function(e){
        e.preventDefault();
        $.ajax({
            url: '/album/review',
            data: {format: 'js', review: $('textarea').val(), album: $('#album_id').val(), title: $('#reviewTitle').val() }, 
            success: function(data){
                $('.form-group').remove();
                $('.submit-btn').remove();
                $('#review_header').after(data);
            },
            method: 'post'
        });
    });

    $('body').on('click', '.edit', function(e){
        e.preventDefault();
        var title = $('#users_review_title').text();
        var text = $('#users_review').text();
        $('#users_review_title').replaceWith("<div class='form-group'><label for='reviewTitle'>Title:</label><input type='text' class='form-control' name='title' id='reviewTitle'/></div>");
        $('#users_review').replaceWith("<div class='form-group'><label for='reviewText'>Review:</label><textarea name='review' class='form-control' id='reviewText' cols='80' rows='4'></textarea></div>");
        $('#reviewTitle').val(title);
        $('#reviewText').val(text);
        $('.edit').text('Update');
        $('.edit').attr('class', 'btn btn-default update');
    });

    $('body').on('click', '.update', function(e){
        e.preventDefault();
        $.ajax({
            url: '/album/review',
            method: 'put',
            data: {review: $('textarea').val(), review_id: $('#review_id').val(), title: $('#reviewTitle').val()},
            success: function(data){
                $('.form-group').remove();
                $('#user_review').prepend(data);
                $('.update').text('Edit');
                $('.update').attr('class', 'btn btn-default edit');
            }
        });
    });

    $('body').on('click', '.delete_review', function(e){
        e.preventDefault();
        $('#confirm_delete_dialog').modal('show');
    });

    $('#delete_btn').click(function(e){
        $.ajax({
            url: '/album/review',
            method: 'delete',
            data: {review_id: $('#review_id').val(), album: $('#album_id').val()},
            success: function(data){
                $('#users_review_title').remove();
                $('#users_review').remove();
                $('#user_review').remove();
                $('#reviews').before("<div class='form-group'><label for='reviewTitle'>Title:</label><input type='text' class='form-control' name='title' id='reviewTitle'/></div>");
                $('#reviews').before("<div class='form-group'><label for='reviewText'>Review:</label><textarea name='review' class='form-control' id='reviewText' cols='80' rows='4'></textarea></div>");
                $('#reviews').before("<button class='btn btn-primary submit-btn'>Submit</button> ");
                $('#confirm_delete_dialog').modal('hide');
            }
        });
    });
    
    


    $('#send-recommend').click(function(){
        var friends_list = [];
        $('input:checkbox:checked').each(function(){
            friends_list.push($(this).val());
        })
        $.ajax({
            url: '/recommend',
            method: 'post',
            data: {user_id: currentUser.id, message: $('#message').val(), friends: friends_list, album: $('#album_id').val()},
            success: function(data){
                friends_list.forEach(function(el, index, array){
                    channel.trigger('recommendation', {id: el});
                });
                
                $('#recommendation_dialog').modal('hide');
                $('.tracks').append("<div class='alert alert-success recommendation_sent alert-dismissable'><button type='button' class='close' data-dismiss='alert' aria-hidden='true'>&times;</button><p>Recommendation sent!</p></div>");
            }
        });
    });

});
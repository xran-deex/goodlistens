$(function(){
    $('#review_form').submit(function(e){
        e.preventDefault();
        $.ajax({
            url: '/album/review',
            data: {format: 'js', review: $('textarea').val(), album: $('#album_id').val() }, 
            success: function(data){
                $('#review_header').after(data);
            },
            method: 'post'
        });
    });
});
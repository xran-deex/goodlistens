$(function(){
    $('#first_name').click(function(){
        $(this).val('');
    })
    $('#last_name').click(function(){
        $(this).val('');
    });
    $('#authorize').click(function(){
        var finalize = $('#authorize').attr('id');
        if(finalize == undefined){
            return true;
        }
        window.open(this.href, 'Lastfm', 'left=50,top=50,width=500,height=500,toolbar=1,resizable=0');
        $('#authorize').html('Finalize');
        $('#authorize').attr('href', '/lastfm_auth');
        $('#authorize').attr('id', 'finalize');
        return false;
    });
});
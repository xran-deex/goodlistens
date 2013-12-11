$(function(){
    $('.progress').hide();

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

    var oldFileName = null;
    var liElement = null;

    $('.panel-body').on('click', '.rename', function(e){
        if(e.target.id == ''){
            oldFileName = $(this).text();
            $('#newFileName').val(oldFileName);
            liElement = $(this);
            $('#rename_file_dialog').modal('show');
        } else {
            $('.file_delete').trigger('click');
        }
    });

    $('.panel-body').on('DOMNodeInserted', function(){
        $('.rename').tooltip();
        $('.file_delete').tooltip({'placement': 'left'});
    })

    $('.rename').tooltip();
    $('.file_delete').tooltip({'placement': 'left'});

    $('#newFileName').keypress(function(e){
        if(e.which == 13){
            $('#rename_btn').trigger('click');
        }
    });

    $('#rename_btn').click(function(){
        postRename(oldFileName);
        $('#rename_file_dialog').modal('hide');
    })

    function postRename(fileName){
        var newFile = $('#newFileName').val();
        $.ajax({
            url: '/upload/rename',
            type: 'post',
            data: {newFileName: newFile, oldFileName: fileName},
            success: function(data){
                liElement.html(newFile);
                oldFileName = null;
            }
        });
    }

    var file_to_delete = null;

    $('.panel-body').on('click', '.file_delete', function(e){
        $('#confirm_delete_dialog').modal('show');
        file_to_delete = $(this);
    });

    $('#delete_btn').click(function(e){
        $('#confirm_delete_dialog').modal('hide');
        delete_file(); 
    });

    function delete_file(){
        $.ajax({
            url: '/upload/delete',
            type: 'post',
            data: {file: file_to_delete.attr('id')},
            success: function(data){
                file_to_delete.alert('close');
            }
        });
    };

    $('.file_delete').bind('close.bs.alert', function(e){alert('deleted');});

    $(document)
        .on('change', '.btn-file :file', function() {
            var input = $(this),
                numFiles = input.get(0).files ? input.get(0).files.length : 1,
                label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
            input.trigger('fileselect', [numFiles, label]);
        });

    $('.btn-file :file').on('fileselect', function(event, numFiles, label) {
        var fileList = $('#files');
        fileList.val(label);
        fileList.after('<span id="submitGroup" class="input-group-btn"><span class="btn btn-primary" id="uploadSubmit">Submit</span></span>');
        $('#uploadSubmit').click(function(e){
            $('.progress').show();
            doUpload();
        });

    });

    function doUpload(){
        var formData = new FormData(    );
        formData.append( 'file', $( '#file' )[0].files[0] );
        $.ajax({
            url: '/upload/uploadFile',  //Server script to process data
            type: 'POST',
            xhr: function() {  // Custom XMLHttpRequest
                var myXhr = $.ajaxSettings.xhr();
                if(myXhr.upload){ // Check if upload property exists
                    myXhr.upload.addEventListener('progress',progressHandlingFunction, false); // For handling the progress of the upload
                }
                return myXhr;
            },
            success: function(data){
                $('.progress').hide();
                $('.progress-bar').attr('style', 'width: 0%').attr('aria-valuenow', '0');
                $('#submitGroup').remove();
                $('#fileList').replaceWith(data);
                $('#files').val('');
            },
            // Form data
            data: formData,
            //Options to tell jQuery not to process data or worry about content-type.
            cache: false,
            contentType: false,
            processData: false
        });
    }

    function progressHandlingFunction(e){
        if(e.lengthComputable){
            var value = Math.floor(e.loaded / e.total) * 100;
            $('.progress-bar').attr('style', 'width: '+value+'%');
            $('.progress-bar').attr('aria-valuenow', value);
        }
    }

});
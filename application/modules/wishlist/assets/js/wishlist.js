function addToWL(varId) {
    var checkedList = $('#wishCart input[type=radio]:checked');
    if (checkedList.length) {
        var listID = checkedList.data('id');
        var listName = false;
        var commentProduct = $('.wishProductComment').val();

        if (checkedList.hasClass('newWishList')) {
            listID = false;
            listName = $('.wish_list_name').val();
        }

        $.ajax({
            type: 'POST',
            data: {
                varId: varId,
                listID: listID,
                listName: listName,
                commentProduct: commentProduct
            },
            url: '/wishlist/wishlistAJAX/addItem',
            success: function(data) {
                if (data) {
                    $('.overlayDrop').remove();
                    $('#wishCart').remove();
                    obj = JSON.parse(data);
                    if (obj.answer === 'sucesfull') {
                        $('#' + varId).val('Уже в Списке Желания');
                        $('#' + varId).addClass('inWL');
                        $('#' + varId).bind('click');
                        $('#' + varId).die('click').on("click", function() {
                            document.location.href = '/wishlist';
                        });
                    }
                }
            }
        });
    }
}

function delFromWL($this, varID, WLID) {
    $.ajax({
        type: 'POST',
        data: {
            varID: varID,
            WLID: WLID
        },
        url: '/wishlist/wishlistAJAX/deleteItem',
        success: function(data) {
            obj = JSON.parse(data);
            if (obj.answer === 'sucesfull')
                $($this).closest('tr').remove();
            else {
                $($this).closest('body').find('.error_text').html('');
                $($this).closest('body').find('.error_text').append('<div class="msg"><div class="error">' + obj.errors + '</div></div>');
            }
        }
    });
}

function delWL($this, WLID) {
    $.ajax({
        type: 'POST',
        data: {
            WLID: WLID
        },
        url: '/wishlist/wishlistAJAX/deleteWL',
        success: function(data) {
            obj = JSON.parse(data);
            console.log(obj.errors);
            if (obj.answer === 'sucesfull')
                $($this).closest('.table').remove();
            else {
                $($this).closest('body').find('.error_text').html('');
                $($this).closest('body').find('.error_text').append('<div class="msg"><div class="error">' + obj.errors + '</div></div>');
            }
        }
    });
}

function editWL() {
    var title = $('.wishListTitle').text();
}

function ajaxFileUpload(upload_field)
{
    // Checking file type
    var re_text = /\.jpg|\.gif|\.jpeg/i;
    var filename = upload_field.value;
    if (filename.search(re_text) == -1) {
        alert("File should be either jpg or gif or jpeg");
        upload_field.form.reset();
        return false;
    }
    document.getElementById('picture_preview').innerHTML = '<div><img src="images/progressbar.gif" border="0" /></div>';
    upload_field.form.action = '/wishlist/do_upload';
    upload_field.form.target = 'upload_iframe';
    upload_field.form.submit();
    upload_field.form.action = '';
    upload_field.form.target = '';
    return true;
}

function renderPopup(varId, wlBtn) {
    if (!$('#' + varId).hasClass('inWL')) {
        var popupTemplate = '';
        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: '/wishlist/renderPopup/' + varId,
            success: function(data) {
                if (data) {
                    if (!$('.wishTMP').length) {
                        body.append(data.popup);
                    }
                    body.append('<div class="overlayDrop drop_overlay_fixed" style="position: fixed; width: 100%; height: 100%; left: 0px; top: 0px; z-index: 1001; background-color: rgb(0, 0, 0); opacity: 0.6;"></div>')
                    $('#wishCart').css('display', 'block');
                }
            }
        });
    } else
        document.location.href = '/wishlist';
}

function removePopup() {
    $('.overlayDrop').remove();
    $('#wishCart').remove();
}

$('.overlayDrop').live('click', function() {

    this.remove();
    $('#wishCart').remove();

});
$('.newWishList').live('click', function() {
    var listCount = $(this).data('listscount');
    if (listCount >= 10) {
        if (!$('.listsLimit').length) {
            $('.newWishListLable').append('<div class="listsLimit">Лимит вишлистов закончен</div>');
        }

        $(this).removeAttr('checked');
        $('.wish_list_name').blur();
        return false;
    }
});

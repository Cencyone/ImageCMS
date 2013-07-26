function get_discount(discTpl) {
    var _discount = 0;
    $.ajax({
        url: '/mod_discount/discount_api/get_discount_api',
        type: "POST",
        success: function(data) {
            if (data != '') {
                _discount = JSON.parse(data);
                if (discTpl)
                    $.post('/mod_discount/discount_api/get_discount_tpl_from_json_api', {json: data}, function(tpl) {
                        displayInfoDiscount(tpl);
                    })
            }
            else {
                displayInfoDiscount('');
            }
            displayDiscount(_discount);
            Shop.Cart.discount = _discount;
        }
    })
}

function load_certificat() {
    var gift = 0;
    if (Shop.Cart.gift == undefined)
        $.post('/mod_discount/gift/render_gift_input', function(tpl) {
            renderGiftInput(tpl);
        });
    else {
        gift = Shop.Cart.gift;
        if (gift.error) {
            giftError(gift.mes);
        } else {
            $.post('/mod_discount/gift/render_gift_succes', {json: JSON.stringify(gift)}, function(tpl) {
                renderGiftSucces(tpl, gift);
            })
        }
    }
}
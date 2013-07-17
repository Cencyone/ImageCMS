<!-- floating elements-->
<div id="popupCart" style="display: none;" class="drop drop-bask drop-style"></div>
<a href="#" data-drop="#popupCart" id="showCart" style="display: none;"></a>

<script type="text/template" id="cartPopupTemplate">
    {literal}   
        <div class="frame-bask">
        <button type="button" class="icon_times_drop" data-closed="closed-js" onclick="togglePopupCart()"></button>
        <div class="no-empty">
        <div class="drop-header">
        <div class="title bask"><span>В вашей корзине</span> <span class="add-info"><span class="topCartCount"><%- Shop.Cart.totalCount %></span></span> <span class="plurProd"><%- pluralStr(Shop.Cart.totalCount, plurProd) %></span> <span>на сумму</span> <span class="add-info"><span class="topCartTotalPrice"><%- parseFloat(Shop.Cart.totalPrice).toFixed(pricePrecision) %></span></span> <%-curr%></div>
        </div>
        </div>
        <div class="drop-content">
        <div class="no-empty">
        <div class="frame-bask-scroll">
        <div class="frame-bask-main">
        <div class="inside-padd">
        <table class="table-order">
        <tbody>
        <% _.each(Shop.Cart.getAllItems(), function(item){ %>

        <!-- for single product -->
        <% if (!item.kit) { %>
        <tr data-prodid="<%- item.id %>" data-varid="<%- item.vId %>" data-id="popupProduct_<%- item.id+'_'+item.vId %>" class="items items-bask cartProduct">
        <td class="frame-remove-bask-btn"><button class="icon_times_cart" onclick="rmFromPopupCart(this);"></button></td>
        <td class="frame-items">
        <a href="<%-item.url%>" class="frame-photo-title">
        <span class="photo-block">
        <span class="helper"></span>
        <img src="<%- item.img%>" alt="<%- '('+item.vname+')'%>">
        <% _.each(item.prodStatus, function(item, i){%>
        <%= productStatus[i]%>
        <%})%>
        </span>
        <span class="title"><%- item.name %>
        </a>
        <div class="description">
        <%if(item.vname){ %><span class="frame-variant-name">{/literal}{lang(s_variant)} {literal} <span class="code">(<%- item.vname%>)</span></span> <% } %>
        <%if (item.number) { %><span class="frame-variant-code">{/literal}{lang(s_article)} {literal} <span class="code">(<%-item.number %>)</span></span> <% } %>
        <div class="frame-prices f-s_0">
        <span class="current-prices f-s_0">
        <span class="price-new">
        <span>
        <span class="price"><%- parseFloat(item.price).toFixed(pricePrecision) %></span>
        <span class="curr"><%-curr%></span>
        </span>
        </span>
        <span class="price-add">
        <span>
        <span class="price"><%- parseFloat(item.addprice).toFixed(pricePrecision) %></span>
        <span class="curr-add"><%-currNext%></span>
        </span>
        </span>
        </span>
        </div>
        </div>
        </td>
        <td class="frame-count">
        <span class="countOrCompl"><%-pcs%></span>
        <div class="number" data-title="количество на складе <%-item.maxcount%>">
        <div class="frame-change-count" data-prodid="<%- item.id %>" data-varid="<%- item.vId %>" data-price="<%- item.price %>" data-addprice="<%- item.addprice %>">
        <div class="btn-plus">
        <button type="button">
        <span class="icon-plus"></span>
        </button>
        </div>
        <div class="btn-minus">
        <button type="button">
        <span class="icon-minus"></span>
        </button>
        </div>
        </div>
        <input type="text" value="<%- item.count %>" data-rel="plusminus" data-title="только цифры" data-min="1" <% if (item.maxcount) { %> data-max="<%-item.maxcount%>" <% } %> />
        </div>
        </td>
        <td class="frame-cur-sum-price">
        <span class="title">Сумма: </span>
        <div class="frame-cur-sum-price">
        <div class="frame-prices f-s_0">
        <span class="current-prices f-s_0">
        <span class="price-new">
        <span>
        <span class="price" data-rel="priceOrder"><%- parseFloat(item.count*item.price).toFixed(pricePrecision) %></span>
        <span class="curr"><%-curr%></span>
        </span>
        </span>
        <span class="price-add">
        <span>
        <span class="price addCurrPrice"><%- parseFloat(item.count*item.addprice).toFixed(pricePrecision) %></span>
        <span class="curr-add"><%-currNext%></span>
        </span>
        </span>
        </span>
        </div>
        </div>
        </td>
        </tr>
        <% } else { %>
        <!-- for product kit -->
        <% var i=0 %>
        <% var names = item.name %>
        <% var ids = item.id %>
        <% var prices = item.prices %>
        <% var images = item.img %>
        <% var urls = item.url %>

        <tr class="row-kits" data-prodid="<%- item.id %>" data-varid="<%- item.vId %>" data-id="popupKit_<%- item.kitId %>">
        <td colspan="4">
        <table>
        <tbody>
        <tr>
        <td class="frame-remove-bask-btn"><button class="icon_times_cart" onclick="rmFromPopupCart(this, true);"></button></td>
        <td class="frame-items frame-items-kit">
        <ul class="items items-bask">
        <% var idsL = ids.length; _.each(ids, function(id){  %>
        <li>
        <% if (i != 0){ %>
        <div class="next-kit">+</div>
        <% } %>
        <div class="frame-kit <% if (i == 0){%> main-product <% } %>">
        <% if (0==i) { %>
        <a class="frame-photo-title" href="<%- urls[i]%>">
        <span class="photo-block">
        <span class="helper"></span>
        <img src="<%- images[i]%>" alt="<%- '('+item.vname+')'%>">
        </span>
        <span class="title"><%- names[i] %></span>
        </a>
        <div class="description">
        <%if(item.vname){ %><span class="frame-variant-name">{/literal}{lang(s_variant)} {literal} <span class="code">(<%- item.vname%>)</span></span> <% } %>
        <%if (item.number) { %><span class="frame-variant-code">{/literal}{lang(s_article)} {literal} <span class="code">(<%-item.number %>)</span></span> <% } %>
        <div class="frame-prices f-s_0">
        <span class="current-prices f-s_0">
        <span class="price-new">
        <span>
        <span class="price"><%-prices[i].toFixed(pricePrecision)%></span>
        <span class="curr"><%-curr%></span>
        </span>
        </span>
        <span class="price-add">
        <span>
        <span class="price"><%- parseFloat(0).toFixed(pricePrecision) %></span>
        <span class="curr-add"><%-currNext%></span>
        </span>
        </span>
        </span>
        </div>
        </div>
        <% } else { %>

        <a class="frame-photo-title" href="<%- urls[i]%>">
        <span class="photo-block">
        <span class="helper"></span>
        <img src="<%- images[i]%>" alt="<%- '('+item.vname+')'%>">
        </span>
        <span class="title"><%-names[i]%></span>
        </a>
        <div class="description">
        <%if(item.vname){ %><span class="frame-variant-name">{/literal}{lang(s_variant)} {literal} <span class="code">(<%- item.vname%>)</span></span> <% } %>
        <%if (item.number) { %><span class="frame-variant-code">{/literal}{lang(s_article)} {literal} <span class="code">(<%-item.number %>)</span></span> <% } %>
        <div class="frame-prices f-s_0">
        <span class="current-prices f-s_0">
        <span class="price-new">
        <span>
        <span class="price"><%-prices[i].toFixed(pricePrecision)%></span>
        <span class="curr"><%-curr%></span>
        </span>
        </span>
        <span class="price-add">
        <span>
        <span class="price"><%- (0).toFixed(pricePrecision)%></span>
        <span class="curr-add"><%-currNext%></span>
        </span>
        </span>
        </span>
        </div>
        </div>
        <% } %>
        </div>
        </li>
        <% i++;  }); %>
        </ul>
        </td>
        <td class="frame-count">
        <span class="countOrCompl"><%-kits%></span>
        <div class="number" data-title="количество на складе <%-item.maxcount%>">
        <div class="frame-change-count" data-prodid="<%- item.id %>" data-varid="<%- item.vId %>" data-price="<%- item.price %>" data-kit="<%-item.kit %>">
        <div class="btn-plus">
        <button type="button">
        <span class="icon-plus"></span>
        </button>
        </div>
        <div class="btn-minus">
        <button type="button">
        <span class="icon-minus"></span>
        </button>
        </div>
        </div>
        <input type="text" value="<%- item.count %>" data-rel="plusminus" data-title="только цифры" data-min="1" <% if (item.maxcount) { %> data-max="<%-item.maxcount%>" <% } %> />
        </div>
        </td>
        <td class="frame-cur-sum-price">
        <span class="title">Сумма: </span>
        <div class="frame-prices f-s_0">
        <span class="current-prices f-s_0">
        <span class="price-new">
        <span>
        <span class="price" data-rel="priceOrder"><%- parseFloat(item.count*item.price).toFixed(pricePrecision) %></span>
        <span class="curr"><%-curr%></span>
        </span>
        </span>
        <span class="price-add">
        <span>
        <span class="price" data-rel="priceaddOrder"><%- parseFloat(item.count*item.addprice).toFixed(pricePrecision) %></span>
        <span class="curr"><%-curr%></span>
        </span>
        </span>
        </span>
        </div>
        </td>
        </tr>
        </tbody>
        </table>
        </td>
        </tr>

        <% } %>

        <% }); %>
        </tbody>
        </table>
        </div>
        </div>
        </div>
        <div class="frame-foot">
        <div class="header-frame-foot">
        <div class="inside-padd">
        <span class="s-t">Ваша текущая скидка:</span>
        <span class="text-discount current-discount">bla-bla</span>
        <span class="s-t">Всего:</span>
        <span class="frame-cur-sum-price">
        <span class="frame-prices f-s_0">
        <span class="price-discount">
        <span>
        <span class="price">500</span>
        <span class="curr">RUR</span>
        </span>
        </span>
        <span class="current-prices f-s_0">
        <span class="price-new">
        <span>
        <span class="price" id="popupCartTotal"><%- parseFloat(Shop.Cart.getTotalPrice()).toFixed(pricePrecision) %></span>
        <span class="curr"><%-curr%></span>
        </span>
        </span>
        </span>
        <span class="price-add">
        <span>
        <span class="price" id="popupCartTotaladdprice"><%- parseFloat(Shop.Cart.getTotalAddPrice()).toFixed(pricePrecision) %></span>
        <span class="curr-add"><%-currNext%></span>
        </span>
        </span>
        </span>
        </span>
        </div>
        <% if (!document.getElementById('orderDetails')) { %>
        <div class="content-frame-foot">
        <div class="clearfix inside-padd">
        <div class="btn-form f_l">
        <button type="button" onclick="togglePopupCart()">
        
        <span class="text-el"><span class="f-s_14">←</span> Вернуться к покупкам</span>
        </button>
        </div>
        <div class="btn-cart btn-cart-p f_r">
        <a href="/shop/cart">
        <span class="icon_cart_p"></span>
        <span class="text-el">Оформить заказ</span>
        </a>
        </div>
        </div>
        </div>
        <% } %>
        </div>
        </div>
        </div>
        <div class="empty">
        <div class="drop-header">
        <div class="title">В вашей корзине <span class="add-info">пусто</span></div>
        </div>
        <div class="drop-content">
        <div class="inside-padd">
        <div class="msg f-s_0">
        <div class="success"><span class="icon_info"></span><span class="text-el">Вы удалили все товары с корзины</span></div>
        </div>
        <div class="btn-form">
        <button type="button" onclick="togglePopupCart()">
        
        <span class="text-el"><span class="f-s_14">←</span> Вернуться к покупкам</span>
        </button>
        </div>
        </div>
        </div>
        </div>
        </div>
        </div>
    {/literal}  
</script>

<script type="text/template" id="orderDetailsTemplate">
    {literal}   
        <div class="frame-bask frame-bask-order">
        <div class="no-empty">
        <div class="frame-bask-scroll">
        <div class="frame-bask-main">
        <div class="inside-padd">
        <table class="table-order">
        <tbody>
        <% _.each(Shop.Cart.getAllItems(), function(item){ %>

        <!-- for single product -->
        <% if (!item.kit) { %>
        <tr data-prodid="<%- item.id %>" data-varid="<%- item.vId %>" data-id="popupProduct_<%- item.id+'_'+item.vId %>" class="items items-bask cartProduct">
        <td class="frame-items">
        <a href="<%-item.url%>" class="frame-photo-title">
        <span class="photo-block">
        <span class="helper"></span>
        <img src="<%- item.img%>" alt="<%- '('+item.vname+')'%>">
        </span>
        <span class="title"><%- item.name %>
        </a>
        <div class="description">
        <%if(item.vname){ %><span class="frame-variant-name">{/literal}{lang(s_variant)} {literal} <span class="code">(<%- item.vname%>)</span></span> <% } %>
        <%if (item.number) { %><span class="frame-variant-code">{/literal}{lang(s_article)} {literal} <span class="code">(<%-item.number %>)</span></span> <% } %>
        <div class="frame-prices f-s_0">
        <span class="current-prices f-s_0">
        <span class="price-new">
        <span>
        <span class="price"><%- parseFloat(item.price).toFixed(pricePrecision) %></span>
        <span class="curr"><%-curr%></span>
        </span>
        </span>
        </span>
        </div>
        <div class="frame-frame-count">
        <div class="frame-count">
        <div class="number d_i-b" data-title="количество на складе <%-item.maxcount%>">
        <div class="frame-change-count" data-prodid="<%- item.id %>" data-varid="<%- item.vId %>" data-price="<%- item.price %>">
        <div class="btn-plus">
        <button type="button">
        <span class="icon-plus"></span>
        </button>
        </div>
        <div class="btn-minus">
        <button type="button">
        <span class="icon-minus"></span>
        </button>
        </div>
        </div>
        <input type="text" value="<%- item.count %>" data-rel="plusminus" data-title="только цифры" data-min="1" <% if (item.maxcount) { %> data-max="<%-item.maxcount%>" <% } %> />
        </div>
        <span class="countOrCompl"><%-pluralStr(item.count, plurProd)%></span>
        </div>
        </div>
        <div class="frame-cur-sum-price">
        <span class="title">На сумму: </span>
        <div class="frame-prices f-s_0">
        <span class="current-prices f-s_0">
        <span class="price-new">
        <span>
        <span class="price" data-rel="priceOrder"><%- parseFloat(item.count*item.price).toFixed(pricePrecision) %></span>
        <span class="curr"><%-curr%></span>
        </span>
        </span>
        </span>
        </div>
        </div>
        </div>
        </td>

        </tr>
        <% } else { %>
        <!-- for product kit -->
        <% var i=0 %>
        <% var names = item.name %>
        <% var ids = item.id %>
        <% var prices = item.prices %>
        <% var images = item.img %>
        <% var urls = item.url %>

        <tr class="row-kits" data-prodid="<%- item.id %>" data-varid="<%- item.vId %>" data-id="popupKit_<%- item.kitId %>">
        <td class="frame-items frame-items-kit">
        <ul class="items items-bask">
        <% var idsL = ids.length; _.each(ids, function(id){  %>
        <li>
        <% if (i != 0){ %>
        <div class="next-kit">+</div>
        <% } %>
        <div class="frame-kit <% if (i == 0){%> main-product <% } %>">
        <% if (0==i) { %>
        <a class="frame-photo-title" href="<%- urls[i]%>">
        <span class="photo-block">
        <span class="helper"></span>
        <img src="<%- images[i]%>" alt="<%- '('+item.vname+')'%>">
        </span>
        <span class="title"><%- names[i] %></span>
        </a>
        <div class="description">
        <%if(item.vname){ %><span class="frame-variant-name">{/literal}{lang(s_variant)} {literal} <span class="code">(<%- item.vname%>)</span></span> <% } %>
        <%if (item.number) { %><span class="frame-variant-code">{/literal}{lang(s_article)} {literal} <span class="code">(<%-item.number %>)</span></span> <% } %>
        <div class="frame-prices f-s_0">
        <span class="current-prices f-s_0">
        <span class="price-new">
        <span>
        <span class="price"><%-prices[i]%></span>
        <span class="curr"><%-curr%></span>
        </span>
        </span>
        </span>
        </div>
        </div>
        <% } else { %>

        <a class="frame-photo-title" href="<%- urls[i]%>">
        <span class="photo-block">
        <span class="helper"></span>
        <img src="<%- images[i]%>" alt="<%- '('+item.vname+')'%>">
        </span>
        <span class="title"><%-names[i]%></span>
        </a>
        <div class="description">
        <%if(item.vname){ %><span class="frame-variant-name">{/literal}{lang(s_variant)} {literal} <span class="code">(<%- item.vname%>)</span></span> <% } %>
        <%if (item.number) { %><span class="frame-variant-code">{/literal}{lang(s_article)} {literal} <span class="code">(<%-item.number %>)</span></span> <% } %>
        <div class="frame-prices f-s_0">
        <span class="current-prices f-s_0">
        <span class="price-new">
        <span>
        <span class="price"><%-prices[i]%></span>
        <span class="curr"><%-curr%></span>
        </span>
        </span>
        </span>
        </div>
        </div>
        <% } %>
        </div>
        </li>
        <% i++;  }); %>
        </ul>
        </td>
        </tr>
        <tr>
        <td class="frame-kits-gen-sum">
        <div class="kits-gen-sum">
        <img src="<%-theme%>/images/kits_sum.png" />
        </div>
        <div class="frame-frame-count">
        <div class="frame-count">
        <div class="number" data-title="количество на складе <%-item.maxcount%>">
        <div class="frame-change-count" data-prodid="<%- item.id %>" data-varid="<%- item.vId %>" data-price="<%- item.price %>" data-kit="<%-item.kit %>">
        <div class="btn-plus">
        <button type="button">
        <span class="icon-plus"></span>
        </button>
        </div>
        <div class="btn-minus">
        <button type="button">
        <span class="icon-minus"></span>
        </button>
        </div>
        </div>
        <input type="text" value="<%- item.count %>" data-rel="plusminus" data-title="только цифры" data-min="1" <% if (item.maxcount) { %> data-max="<%-item.maxcount%>" <% } %> />
        </div>
        <span class="countOrCompl"><%-pluralStr(item.count, plurKits)%></span>
        </div>
        </div>
        </div>
        <div class="frame-cur-sum-price">
        <span class="title">На сумму: </span>
        <div class="frame-prices f-s_0">
        <span class="current-prices f-s_0">
        <span class="price-new">
        <span>
        <span class="price" data-rel="priceOrder"><%- parseFloat(item.count*item.price).toFixed(pricePrecision) %></span>
        <span class="curr"><%-curr%></span>
        </span>
        </span>
        </span>
        </div>
        </div>
        </tr>
        <% } %>

        <% }); %>
        </tbody>
        </table>
        </div>
        </div>
        </div>
        <div class="frame-foot">
        <div class="header-frame-foot">
        <div class="inside-padd">
        <span class="s-t">Ваша текущая скидка:</span>
        <span class="text-discount current-discount">bla-bla</span>
        <span class="s-t">Всего:</span>
        <span class="frame-cur-sum-price">
        <span class="frame-prices f-s_0">
        <span class="price-discount">
        <span>
        <span class="price">500</span>
        <span class="curr">RUR</span>
        </span>
        </span>
        <span class="current-prices f-s_0">
        <span class="price-new">
        <span>
        <span class="price" id="popupCartTotal"><%- parseFloat(Shop.Cart.getTotalPrice()).toFixed(pricePrecision) %></span>
        <span class="curr"><%-curr%></span>
        </span>
        </span>
        </span>
        </span>
        </span>
        </div>
        <% if (!document.getElementById('orderDetails')) { %>
        <div class="content-frame-foot">
        <div class="clearfix inside-padd">
        <div class="btn-form f_l">
        <button type="button" onclick="togglePopupCart()">
        
        <span class="text-el"><span class="f-s_14">←</span> Вернуться к покупкам</span>
        </button>
        </div>
        <div class="btn-cart btn-cart-p f_r">
        <a href="/shop/cart">
        <span class="icon_cart_p"></span>
        <span class="text-el">Оформить заказ</span>
        </a>
        </div>
        </div>
        </div>
        <% } %>
        </div>
        </div>
        </div>
        <div class="empty">
        <div class="drop-header">
        <div class="title">В вашей корзине <span class="add-info">пусто</span></div>
        </div>
        <div class="drop-content">
        <div class="inside-padd">
        <div class="msg f-s_0">
        <div class="success"><span class="icon_info"></span><span class="text-el">Вы удалили все товары с корзины</span></div>
        </div>
        </div>
        </div>
        </div>
        </div>
    {/literal}
</script>

{#
/**
* @file Render autocomplete results
* @partof main.tpl
* @updated 25 February 2013;
* Variables
*   items : (object javascript) Contain found products
*/
#}
{literal}
    <script type="text/template" id="searchResultsTemplate">
        <div class="inside-padd">
        <% var ids=[] %>
        <% if (_.keys(items).length > 1) { %>
        <ul class="items items-search-autocomplete">
        <% _.each(items, function(item){

        if (item.name != null && ids.indexOf(item.product_id)){%>
        <% ids.push(item.product_id) %>
        <li>{/literal}
        <!-- Start. Photo Block and name  -->
        <a href="{shop_url('product')}/{literal}<%- item.url %>" class="frame-photo-title">
        <span class="photo-block">
        <span class="helper"></span>
        <img src="<%- item.smallImage %>">
        </span>
        <span class="title"><% print( item.name)  %></span>
        <!-- End. Photo Block and name -->

        <span class="description">
        <!-- Start. Product price  -->
        <span class="frame-prices f-s_0">
        <span class="current-prices var_price_{echo $p->firstVariant->getId()} prod_price_{echo $p->getId()}">
        <span class="price-new">
        <span>
        <span class="price"><%- Math.round(item.price) %></span>{/literal}
        <span class="curr">{$CS}</span>{literal}
        </span>
        </span>
        </span>
        </span>
        </span>
        <!-- End. Product price  -->
        </a>
        </li>
        <% }
        }) %>
        </ul>
        <!-- Start. Show link see all results if amount products >0  -->
        <div>
        <div class="btn-autocomplete">{/literal}
        <a href="{shop_url('search')}?text={literal}<%- items.queryString %>" {/literal} class="f-s_0 t-d_u">
        <span class="icon_show_all"></span><span class="text-el">{lang('s_all_result')} →</span>
        </a>
        </div>{literal}
        <!-- End. Show link  -->
        <% } else {%>    
    {/literal}<div class="msg f-s_0">
    <div class="success"><span class="icon_info"></span><span class="text-el">{echo ShopCore::t(lang('s_not_found'))}</span></div>
    </div>{literal}
    <% }%>
    </div>
    </div>
</script>
{/literal}
    <span class="tooltip"></span>
    <div class="apply">
        <div class="content-apply">
            <a href="#">Фильтровать</a>
            <div class="description">Найдено <span class="f-s_0"><span id="apply-count">5</span><span class="text-el">&nbsp;</span><span class="plurProd"></span></span></div>
        </div>
        <button type="button" class="icon_times_drop icon_times_apply"></button>
    </div>

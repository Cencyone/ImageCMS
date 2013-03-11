
{/*}
<div class="center content">
    <h1>{lang('orderind_shop_sg')}</h1>
    {if count($items) > 0}
        <form method="post" action="{site_url(uri_string())}" id="cartForm">
            <div class="order-cleaner">
                <table class="cleaner_table forCartProducts" cellspacing="0">
<!--                    <caption>{lang('s_cart')}</caption>-->
                    <colgroup>
                        <col span="1" width="120">
                        <col span="1" width="390">
                        <col span="1" width="160">
                        <col span="1" width="140">
                        <col span="1" width="160">
                        <col span="1" width="25">
                    </colgroup>
                    <tbody>
                        {foreach $items as $key=>$item}
                            {if $item.model instanceof SProducts}
                                {$variants = $item.model->getProductVariants()}
                                {foreach $variants as $v}
                                    {if $v->getId() == $item.variantId}
                                        {$variant = $v}
                                    {/if}
                                {/foreach}
                                <tr>
                                    <td>
                                        <a href="{shop_url('product/' . $item.model->getUrl())}" class="photo_block">
                                            <img src="{if count($variants)>1 && $variant->getSmallImage() != ''}{productImageUrl($variant->getsmallimage())}{else:}{productImageUrl($item.model->getMainModimage())}{/if}" alt="{echo ShopCore::encode($item.model->getName())}{if count($variants)>1} - {echo ShopCore::encode($variant->name)}{/if}"/>
                                        </a>
                                    </td>
                                    <td>
                                        <a href="{shop_url('product/' . $item.model->getUrl())}">{echo ShopCore::encode($item.model->getName())}{if count($variants)>1} - {echo ShopCore::encode($variant->name)}{/if}</a>
                                    </td>
                                    <td>
                                        <div class="price f-s_16 f_l">{echo $variant->getPrice()} <sub>{$CS}</sub>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="count">
                                            <input name="products[{$key}]" type="text" value="{$item.quantity}"/>
                                            <span class="plus_minus">
                                                <button class="count_up inCartProducts">&#9650;</button>
                                                <button class="count_down inCartProducts">&#9660;</button>
                                            </span>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="price f-s_18 f_l">{$summary = $variant->getPrice() * $item.quantity}
                                            {echo $summary}
                                            <sub>{$CS}</sub>
                                            
                                        </div>
                                    </td>
                                    <td>
                                        <a href="{shop_url('cart/delete/'.$key)}" class="delete_text inCartProducts">&times;</a>
                                    </td>
                                </tr>
                            {elseif($item.model instanceof ShopKit):}
                                <tr>
                                    <td style="width:90px;padding:2px;">

                                        {if $item.model->getMainProduct()->getMainImage()}
                                            <a href="{shop_url('product/' . $item.model->getProductId())}" class="photo_block">
                                                <img src="{productImageUrl($item.model->getMainProduct()->getId() . '_main.jpg')}" border="0"  width="100" />
                                            </a>                                        
                                        {/if}                                   
                                    </td>
                                    <td>
                                        <a href="{shop_url('product/' . $item.model->getMainProduct()->getUrl())}">{echo ShopCore::encode($item.model->getMainProduct()->getName())}</a> {echo ShopCore::encode($item.model->getMainProduct()->firstVariant->getName())}
                                        <br /><span style="font-size:16px;">{echo $item.model->getMainProduct()->firstVariant->toCurrency()} {$CS}</span>
                                    </td>
                                    <td rowspan="{echo $item.model->countProducts()}">
                                        {//echo ShopCore::app()->SCurrencyHelper->convert($item.price)} {//$CS}                              
                                        {echo $item.price} {$CS}                              
                                    </td>
                                    <td rowspan="{echo $item.model->countProducts()}">
                                        <div class="count">
                                            <input type="text" name="products[{$key}]" value="{$item.quantity}">
                                            <span class="plus_minus">
                                                <button class="count_up inCartProducts">&#9650;</button>
                                                <button class="count_down inCartProducts">&#9660;</button>
                                            </span>
                                        </div>
                                    </td>
                                    <td rowspan="{echo $item.model->countProducts()}">
                                        {echo $summary = ShopCore::app()->SCurrencyHelper->convert($item.totalAmount)} {$CS}
                                    </td>
                                    <td rowspan="{echo $item.model->countProducts()}"><a href="{shop_url('cart/delete/' . $key)}" rel="nofollow" class="delete_text inCartProducts">&times;</a></td>
                                </tr>
                                {foreach $item.model->getShopKitProducts() as $shopKitProduct}
                                    {$ap = $shopKitProduct->getSProducts()}
                                    {$ap->setLocale(ShopController::getCurrentLocale())}
                                    {$kitFirstVariant = $ap->getKitFirstVariant($shopKitProduct)}
                                    <tr>
                                        <td style="width:90px;padding:2px;">
                                            {if $ap->getMainImage()}
                                                <a href="{shop_url('product/' . $ap->getId())}" class="photo_block">
                                                    <img src="{productImageUrl($ap->getId() . '_main.jpg')}" border="0" width="100" alt="{echo ShopCore::encode($ap->getName())}" />                                                
                                                </a>
                                            {/if}                      
                                        </td>
                                        <td>
                                            <a href="{shop_url('product/' . $ap->getUrl())}">{echo ShopCore::encode($ap->getName())}</a> 
                                            {echo ShopCore::encode($kitFirstVariant->getName())}
                                            {if $kitFirstVariant->getEconomy() > 0}
                                    <br /><s style="font-size:14px;">{echo $kitFirstVariant->toCurrency('origPrice')} {$CS}</s>
                                    <span style="font-size:16px;">{echo $kitFirstVariant->toCurrency()} {$CS}</span>
                                {else:}
                                    <span style="font-size:16px;">{echo $kitFirstVariant->toCurrency()} {$CS}</span>
                                {/if}
                                </td>
                                </tr>
                                {$i++}
                            {/foreach}
                        {/if}
                        {$total += $summary}
                        {$total_nc += $summary_nextc}
                    {/foreach}
                    </tbody>
                    <tfoot>
                        <tr>
                            <td colspan="6">
                                <div class="foot_cleaner">
                                    <div class="f_r">
                                        <div class="price f-s_26 f_l">
                                            {//echo $total}
                                            <sub>{//$CS}</sub>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </tfoot>
                    <input type="hidden" name="forCart" value ="1"/>

                </table>
            </div>
            <div class="order-cleaner clearfix">
                <div class="f_l method_deliver_buy">
                    {if ShopCore::app()->SSettings->__get('usegifts') == 1}
                        <div class="block_title_18"><span class="title_18">{lang('s_do_you_have')}</span></div>
                        <label>
                            <input type="text" name="giftcert" id="giftcertkey"/>
                            <input type="button" name="giftcert" value="{lang('s_apply_sertif')}" class="giftcertcheck"/>
                        </label>
                    {/if}
                    <div class="block_title_18"><span class="title_18">{lang('s_sdm')}</span></div>
                        {$counter = true}
                        {foreach $deliveryMethods as $deliveryMethod}
                            {$del_id = $deliveryMethod->getId()}
                        <label>
                            <input type="radio" 
                                   {if $counter} checked="checked" 
                                       {$del_id = $deliveryMethod->getId()} 
                                       {$counter = false}
                                       {$del_price = ceil($deliveryMethod->getPrice())}
                                       {$del_freefrom = ceil($deliveryMethod->getFreeFrom())}
                                   {/if} 
                                   name="met_del" 
                                   class="met_del" 
                                   value="{echo $del_id}" 
                                   data-price="{echo ceil($deliveryMethod->getPrice())}" 
                                   data-freefrom="{echo ceil($deliveryMethod->getFreeFrom())}"/>
                            {echo $deliveryMethod->getName()}
                        </label>
                    {/foreach}

                    <!--    Show payment methods    -->
                    {if sizeof($paymentMethods) > 0}
                        <div class="block_title_18"><span class="title_18">{lang('s_spm')}</span></div>
                        <div id="paymentMethods">
                            {$counter = true}
                            {foreach $paymentMethods as $paymentMethod}
                                <label>
                                    <input type="radio"
                                           {if $counter} checked="checked"
                                               {$counter = false}
                                               {$pay_id = $paymentMethod->getId()}
                                           {/if} 
                                           name="met_buy" 
                                           class="met_buy" 
                                           value="{echo $pay_id}" />
                                    {echo $paymentMethod->getName()}
                                </label>                        
                            {/foreach}
                        </div>
                    {/if}            
                    <!--    Show payment methods    -->
                </div>
                <div class="addres_recip f_r">
                    <div class="block_title_18">
                        {if validation_errors()}
                            <div class="foot_cleaner red" style="background-color: #FFBFBF;border: 1px solid #FF0400;padding: 0 7px">{validation_errors()}</div>
                        {/if}
                        <span class="title_18">{lang('s_addresrec')}</span>
                    </div>
                    <div class="label_block">
                        <label class="f_l">
                            {if $isRequired['userInfo[fullName]']}
                                <span class="red">*</span>
                            {/if}
                            {lang('s_c_uoy_name_u')}
                            <input type="text"{if $isRequired['userInfo[fullName]']} class="required"{/if} name="userInfo[fullName]" value="{$profile.name}">
                        </label>
                        <label class="f_l">
                            {if $isRequired['userInfo[email]']}
                                <span class="red">*</span>
                            {/if}
                            {lang('s_c_uoy_user_el')}
                            <input type="text" {if $isRequired['userInfo[email]']} class="required email"{/if} name="userInfo[email]" value="{$profile.email}">
                        </label>
                        <label class="f_l">
                            {if $isRequired['userInfo[phone]']}
                                <span class="red">*</span>
                            {/if}
                            {lang('s_phone')}
                            <input type="text"{if $isRequired['userInfo[phone]']} class="required"{/if} name="userInfo[phone]" value="{$profile.phone}">
                        </label>
                        <label class="f_l">
                            {if $isRequired['userInfo[deliverTo]']}
                                <span class="red">*</span>
                            {/if}
                            {lang('s_addresrec')}
                            <input type="text"{if $isRequired['userInfo[deliverTo]']} class="required"{/if} name="userInfo[deliverTo]" value="{echo $profile.address}">
                        </label>
                    </div>  
                    <label class="c_b d_b">
                        {if $isRequired['userInfo[commentText]']}
                            <span class="red">*</span>
                        {/if}
                        {lang('s_comment')}
                        <textarea{if $isRequired['userInfo[commentText]']} class="required"{/if} name="userInfo[commentText]"></textarea> 
                    </label>
                    <div class="label_block">
                        {echo ShopCore::app()->CustomFieldsHelper->setPattern($pattern)->getCustomFields('order')->asHtml() }
                    </div>  
                </div>
            </div>

            <div class="foot_cleaner c_b result">
                <span class="v-a_m">
                    <span class="c_9 f-s_16">(Сумма товаров: <span class="b" id="price1">{echo $total}</span> {$CS} +   Доставка: <span class="b" id="price2">{echo (int)$item.delivery_price}</span> {$CS})</span>
                    <span class="c_3 f-s_18">&nbsp;&nbsp;Сумма товаров: <span class="f-s_26 b" id="price3">{echo $total + $deliveryMethod->getPrice()}</span> {$CS}</span>
                </span>
                <div class="buttons button_big_blue v-a_m">
                    <input type="submit" value="{lang('s_c_of_z_')}" id="orderSubmit" data-logged="{if ShopCore::$ci->dx_auth->is_logged_in()===true}1{else:}0{/if}"/>
                </div>
            </div>
            <input type="hidden" name="deliveryMethodId" id="deliveryMethodId" value="{echo $del_id}" />
            <input type="hidden" name="deliveryMethod" value="1" />
            <input type="hidden" name="paymentMethodId" id="paymentMethodId" value="{echo $pay_id}" />
            <input type="hidden" name="paymentMethod" value="5" />
            <input type="hidden" name="makeOrder" value="1" />
            {form_csrf()}
        </form>
    {else:}
        <div class="comparison_slider">
            <div class="f-s_18 m-t_29 t-a_c">{echo ShopCore::t(lang('s_cart_empty'))}</div>
        </div>
    {/if}
</div>

{ */}


<article>
    {if count($items) <= 0}
    <div class="form_alert">
        <p>
            Ваша корзина пуста
        </p>
        {literal}<script>$(document).ready(function(){Shop.Cart.clear()}); setTimeout("window.location.href='/'");</script>{/literal}
    </div>
    {else:}
                        <h1>Оформление заказа</h1>
                        <div class="row">
                            <div class="span6">
                                <div class="frameGroupsForm">
                                    <div class="header_title">Данные заказа</div>
                                    <div class="standart_form horizontal_form">
                                        <form method="post" action="{$BASE_URL}shop/cart">
                                            {if $errors}
                                                <div class="groups_form">
                                                    <div class="msg">
                                                        <div class="error">{echo $errors}</div>
                                                    </div>
                                                </div>
                                                {}
                                            {/if}
                                            <div class="groups_form">
                                                <label>
                                                    <span class="title">{lang('s_c_uoy_name_u')}</span>
                                                    <span class="frame_form_field">
                                                        {if $isRequired['userInfo[fullName]']}<span class="must">*</span>{/if}
                                                        <span class="icon-person"></span>
                                                        <input type="text" value="{$profile.name}" name="userInfo[fullName]">
                                                    </span>
                                                </label>
                                                <label>
                                                    <span class="title">{lang('s_c_uoy_user_el')}</span>
                                                    <span class="frame_form_field">
                                                    {if $isRequired['userInfo[email]']}<span class="must">*</span>{/if}
                                                        <span class="icon-email"></span>
                                                        <input type="text" value="{$profile.email}" name="userInfo[email]">
                                                    </span>
                                                </label>
                                                <label>
                                                    <span class="title">{lang('s_phone')}</span>
                                                    {if $isRequired['userInfo[phone]']}<span class="must">*</span>{/if}
                                                    <span class="frame_form_field">
                                                        <span class="icon-phone"></span>
                                                        <input type="text" name="userInfo[phone]" value="{$profile.phone}">
                                                    </span>
                                                </label>
                                                <label>
                                                    <span class="title">{lang('s_addresrec')}</span>
                                                    <span class="frame_form_field">
                                                        {if $isRequired['userInfo[deliverTo]']}<span class="must">*</span>{/if}
                                                        <span class="icon-address"></span>
                                                        <input type="text" name="userInfo[deliverTo]" value="{echo $profile.address}"></span>
                                                </label>
                                            </div>
                                            <div class="groups_form">
                                                <div class="frameLabel" style="position: relative; z-index: 6;">
                                                    <span class="title">Способ доставки</span>
                                                    <div class="frame_form_field">
                                                        <div class="row-fluid">
                                                            <div class="lineForm">
                                                                <select id="method_deliv" name="deliveryMethodId">
                                                                    
                                                                    {foreach $deliveryMethods as $deliveryMethod}
                                                                        {$del_id = $deliveryMethod->getId()}
                                                                        <option
                                                                               {if $counter} selected="selected" 
                                                                                   {$del_id = $deliveryMethod->getId()} 
                                                                                   {$counter = false}
                                                                                   {$del_price = ceil($deliveryMethod->getPrice())}
                                                                                   {$del_freefrom = ceil($deliveryMethod->getFreeFrom())}
                                                                               {/if} 
                                                                               name="met_del" 
                                                                               class="met_del" 
                                                                               value="{echo $del_id}" 
                                                                               data-price="{echo ceil($deliveryMethod->getPrice())}" 
                                                                               data-freefrom="{echo ceil($deliveryMethod->getFreeFrom())}"/>
                                                                        {echo $deliveryMethod->getName()}
                                                                        </option>
                                                                    {/foreach}
                                                                    
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                    
                                                {if count($paymentMethods)}
                                                <div class="frameLabel" style="position: relative; z-index: 5;">
                                                    <span class="title">Способ оплаты</span>
                                                    <div class="frame_form_field">
                                                        <div class="row-fluid">
                                                            <div class="lineForm pmDiv">
                                                                <select name="paymentMethodId"  id="paymentMethod">
                                                                {$counter = true}
                                                                {foreach $paymentMethods as $paymentMethod}
                                                                    <label>
                                                                        <option
                                                                               {if $counter} checked="checked"
                                                                                   {$counter = false}
                                                                                   {$pay_id = $paymentMethod->getId()}
                                                                               {/if} 
                                                                               value="{echo $pay_id}" />
                                                                        {echo $paymentMethod->getName()}</option>
                                                                {/foreach}
                                                                
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                {/if}
                                            </div>
                                            <div class="groups_form">
                                                <label>
                                                    <span class="title">{lang('s_comment')}</span>
                                                    <span class="frame_form_field"><textarea name="userInfo[commentText]" ></textarea></span>
                                                </label>
                                                <div class="frameLabel c_t" style="position: relative; z-index: 4;">
                                                    <span class="title">&nbsp;</span>
                                                    <div class="frame_form_field">
                                                        <div class="form_alert">
                                                            <div style="margin-bottom: 4px;" class="c_97">(Сумма товаров: <span class="f-w_b" id="totalPrice"></span> <span class="curr"></span> + Доставка: <span class="f-w_b" id="shipping"></span> <span class="curr"></span>)</div>
                                                            <span class="f-s_18">Сумма:</span> <span class="f-s_24" id="finalAmount"></span> <span class="f-s_14 curr"></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="frameLabel" style="position: relative; z-index: 3;">
                                                    <span class="title">&nbsp;</span>
                                                    <span class="frame_form_field">
                                                        <input type="submit" class="btn btn_cart" value="Подтверждаю заказ">
                                                    </span>
                                                </div>
                                            </div>
                                                    <input type="hidden" name="makeOrder" value="1">
                                           {form_csrf()}
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <div class="span6" id="orderDetails">

                            </div>
                        </div>
                    </article>
{/if}                                                    
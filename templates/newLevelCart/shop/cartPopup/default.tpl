{literal}
    <style>
        .cart .isCart{display: block;}
        .cart .noCart{display: none;}
    </style>
{/literal}
<div class="frame-bask frameBask">
    <button type="button" class="icon_times_drop" data-closed="closed-js"></button>
    {if $count > 0}
        <div class="drop-header">
            <div class="title bask"><span>{lang('В корзине','newLevel')}</span><span class="add-info"><span class="topCartCount"> {echo $count}</span></span> <span class="plurProd">{echo SStringHelper::Pluralize($count, array(lang('товар','newLevel'),lang('товара','newLevel'),lang('товаров','newLevel')))}</span> <span>{lang('Сумма','newLevel')}</span> <span class="add-info"><span class="topCartTotalPrice">{echo $cartPrice}</span></span> <span class="curr">{$CS}</span></div>
        </div>
        <div class="drop-content">
            <div class="frame-bask-main">
                <div class="inside-padd">
                    <table class="table-order">
                        <tbody>
                            {foreach $items as $item}
                                <!-- for single product -->
                                {if $item->instance === "SProducts"}
                                    <tr data-id="{echo $item->getId()}" class="items items-bask cart-product">
                                        <td class="frame-remove-bask-btn">
                                            <button type="button" class="icon_times_cart" onclick="Shop.Cart.remove({echo $item->getId()})"></button>
                                        </td>
                                        <td class="frame-items">
                                            <a href="{echo shop_url('product/'.$item->getSProducts()->getUrl())}" title="{echo $item->getName()}" class="frame-photo-title">
                                                <span class="photo-block">
                                                    <span class="helper"></span>
                                                    <img src="{echo $item->getSmallPhoto()}" alt="{echo $item->getName()}"/>
                                                </span>
                                                <span class="title">{echo $item->getSProducts()->getName()} {if $item->getName()}{echo $item->getName()}{/if}</span>
                                            </a>
                                            <div class="description">
                                                {if $item->getName()}
                                                    <span class="frame-variant-name">
                                                        <span class="text-el">{lang('Вариант','newLevel')}</span>
                                                        <span class="code">({echo $item->getName()})</span>
                                                    </span>
                                                {/if}
                                                {if $item->getNumber()}
                                                    <span class="frame-variant-code">{lang('Артикул','newLevel')} <span class="code">({echo $item->getNumber()})</span></span>
                                                {/if}
                                            </div>
                                        </td>
                                        <td class="frame-count frameCount">
                                            <span class="countOrCompl">{lang('Количество', 'newLevel')}:</span>
                                            <div class="number js-number" data-title="{lang('Количество на складе','newLevel')} {echo $item->getStock()}">
                                                <div class="frame-change-count frameChangeCount" data-id="{echo $item->getId()}">
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
                                                <input type="text" value="{echo $item->quantity}" class="plusMinus plus-minus" id="inputChange{echo $item->getId()}" data-id="{echo $item->getId()}" data-title="{lang('Только цифры','newLevel')}" data-min="1" data-max="{echo $item->getStock()}"/>
                                            </div>
                                        </td>

                                        <td class="frame-cur-sum-price">
                                            <span class="title">{lang('Сумма','newLevel')}: </span>
                                            <div class="frame-cur-sum-price">
                                                <div class="frame-prices f-s_0">
                                                    {if ShopCore::app()->SCurrencyHelper->convert($item->originPrice) != ShopCore::app()->SCurrencyHelper->convert($item->price)}
                                                        <span class="price-discount">
                                                            <span>
                                                                <span class="price">{echo ShopCore::app()->SCurrencyHelper->convert($item->originPrice) * $item->quantity}</span>
                                                                <span class="curr">{$CS}</span>
                                                            </span>
                                                        </span>
                                                    {/if}
                                                    <span class="current-prices f-s_0">
                                                        <span class="price-new">
                                                            <span>
                                                                <span class="price">{echo ShopCore::app()->SCurrencyHelper->convert($item->price * $item->quantity)}</span>
                                                                <span class="curr">{$CS}</span>
                                                            </span>
                                                        </span>
                                                        {if $NextCSId}
                                                            <span class="price-add">
                                                                <span>
                                                                    <span class="price">{echo ShopCore::app()->SCurrencyHelper->convert($item->price * $item->quantity, $NextCSId)}</span>
                                                                    <span class="curr">{$NextCS}</span>
                                                                </span>
                                                            </span>
                                                        {/if}
                                                    </span>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                {else:}
                                    <tr class="row-kits" data-id="{echo $item->getId()}">
                                        <td class="frame-remove-bask-btn">
                                            <button type="button" class="icon_times_cart" onclick="Shop.Cart.remove({echo $item->getId()}, true)"></button></button>
                                        </td>
                                        <td class="frame-items frame-items-kit">
                                            <ul class="items items-bask">
                                                {foreach $item->items as $k => $kitItem}
                                                    <li>
                                                        {if $k != 0}
                                                            <div class="next-kit">+</div>
                                                        {/if}
                                                        <div class="frame-kit{if $k === 0} main-product{/if}">
                                                            <a class="frame-photo-title" href="{echo shop_url('product/'.$kitItem->getSProducts()->getUrl())}">
                                                                <span class="photo-block">
                                                                    <span class="helper"></span>
                                                                    <img src="{echo $kitItem->getSmallPhoto()}">
                                                                </span>
                                                                <span class="title">{echo $kitItem->getSProducts()->getName()} {if $kitItem->getName()}{echo $kitItem->getName()}{/if}</span>
                                                            </a>
                                                            <div class="description">
                                                                {if $kitItem->getSProducts()->getNumber()}
                                                                    <span class="frame-variant-code">
                                                                        <span class="text-el">{lang('Артикул','newLevel')}</span>
                                                                        <span class="code">({echo $kitItem->getSProducts()->getNumber()})</span>
                                                                    </span> 
                                                                {/if}
                                                            </div>
                                                        </div>
                                                    </li>
                                                {/foreach}
                                            </ul>
                                        </td>
                                        <td class="frame-count">
                                            <span class="countOrCompl">{lang('Количество', 'newLevel')}:</span>
                                            <div class="number js-number" data-title="{lang('Количество на складе','newLevel')} {echo $item->getStock()}">
                                                <div class="frame-change-count frameChangeCount" data-id="{echo $item->getId()}">
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
                                                <input type="text" value="{echo $item->quantity}" class="plusMinus plus-minus" id="inputChange{echo $item->getId()}" data-title="{lang('Только цифры','newLevel')}" data-min="1" data-max="{echo $item->getStock()}"/>
                                            </div>
                                        </td>
                                        <td class="frame-cur-sum-price">
                                            <span class="title">{lang('Сумма','newLevel')}: </span>
                                            <div class="frame-prices f-s_0">
                                                {if ShopCore::app()->SCurrencyHelper->convert($item->originPrice) != ShopCore::app()->SCurrencyHelper->convert($item->price)}
                                                    <span class="price-discount">
                                                        <span>
                                                            <span class="price">{echo ShopCore::app()->SCurrencyHelper->convert($item->originPrice * $item->quantity)}</span>
                                                            <span class="curr">{$CS}</span>
                                                        </span>
                                                    </span>
                                                {/if}
                                                <span class="current-prices f-s_0">
                                                    <span class="price-new">
                                                        <span>
                                                            <span class="price">{echo ShopCore::app()->SCurrencyHelper->convert($item->price)}</span>
                                                            <span class="curr">{$CS}</span>
                                                        </span>
                                                    </span>
                                                    {if $NextCSId}
                                                        <span class="price-add">
                                                            <span>
                                                                <span class="price">{echo ShopCore::app()->SCurrencyHelper->convert($item->price * $item->quantity, $NextCSId)}</span>
                                                                <span class="curr">{$NextCS}</span>
                                                            </span>
                                                        </span>
                                                    {/if}
                                                </span>
                                            </div>
                                        </td>
                                    </tr>
                                {/if}
                            {/foreach}
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="frame-foot drop-footer">
            <div class="header-frame-foot">
                <div class="inside-padd">
                    <div class="clearfix">
                        {if $cartOriginPrice - $cartPrice > 0}
                            <span class="frame-discount">
                                <span class="s-t">{lang('Ваша текущая скидка','newLevel')}:</span>
                                <span class="text-discount current-discount"><span class="text-el">{echo ShopCore::app()->SCurrencyHelper->convert($cartOriginPrice - $cartPrice)}</span> <span class="curr">{$CS}</span></span>
                            </span>
                        {/if}
                        <div class="btn-form f_l isCart">
                            <button type="button" data-closed="closed-js">
                                <span class="text-el"><span class="f-s_14">←</span> {lang('Вернуться к оформлению','newLevel')}</span>
                            </button>
                        </div>
                        <span class="s-t">{lang('Всего','newLevel')}:</span>
                        <span class="frame-cur-sum-price">
                            <span class="frame-prices f-s_0">
                                {if $cartOriginPrice - $cartPrice > 0}
                                    <span class="price-discount">
                                        <span class="frame-discount">
                                            <span class="price">{echo ShopCore::app()->SCurrencyHelper->convert($cartOriginPrice)}</span>
                                            <span class="curr">{$CS}</span>
                                        </span>
                                    </span>
                                {/if}
                                <span class="current-prices f-s_0">
                                    <span class="price-new">
                                        <span>
                                            <span class="price">{echo ShopCore::app()->SCurrencyHelper->convert($cartPrice)}</span>
                                            <span class="curr">{$CS}</span>
                                        </span>
                                    </span>
                                    {if $NextCSId}
                                        <span class="price-add">
                                            <span>
                                                <span class="price">{echo ShopCore::app()->SCurrencyHelper->convert($cartPrice, $NextCSId)}</span>
                                                <span class="curr-add">{$NextCS}</span>
                                            </span>
                                        </span>
                                    {/if}
                                </span>
                            </span>
                        </span>
                    </div>
                </div>
                <div class="content-frame-foot noCart">
                    <div class="clearfix inside-padd">
                        <div class="btn-form f_l">
                            <button type="button" data-closed="closed-js">

                                <span class="text-el"><span class="f-s_14">←</span> {lang('Вернуться к покупкам','newLevel')}</span>
                            </button>
                        </div>
                        <div class="btn-cart btn-cart-p f_r">
                            <a href="/shop/cart">
                                <span class="icon_cart_p"></span>
                                <span class="text-el">{lang('Оформить заказ','newLevel')}</span>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    {else:}
        <div class="drop-header">
            <div class="title">{lang('Ваша корзина','newLevel')} <span class="add-info">{lang('пуста','newLevel')}</span></div>
        </div>
        <div class="drop-content">
            <div class="inside-padd">
                <div class="msg f-s_0">
                    <div class="success"><span class="icon_info"></span><span class="text-el">{lang('Вы удалили все элементы из корзины','newLevel')}</span></div>
                </div>
                <div class="btn-form noCart">
                    <button type="button" data-closed="closed-js">
                        <span class="text-el"><span class="f-s_14">←</span> {lang('Вернуться к покупкам','newLevel')}</span>
                    </button>
                </div>
            </div>
        </div>
    {/if}
</div>
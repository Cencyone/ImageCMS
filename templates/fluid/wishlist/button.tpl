{$condBtn = $class != 'btn inWL'}
<div class="btnWish btn-wish {if !$condBtn}btn-wish-in{/if}" data-id="{echo $varId}">
    <button 
        class="toWishlist"
        type="button"
        data-rel="tooltip"
        data-title="{lang('В избранные','newLevel')}"

        {if $is_logged_in}
            data-drop="#wishListPopup"
            data-source="{site_url('/wishlist/renderPopup/'. $varId)}"
        {else:}
            data-drop="#dropAuth"
        {/if}
        {if !$condBtn}
            style="display: none;"
        {/if}
        >
        <span class="icon_wish"></span>
        <span class="text-el d_l">{lang('В избранные','newLevel')}</span>
    </button>
    <button class="inWishlist" type="button" data-rel="tooltip" data-title="{lang('В избранныx','newLevel')}" {if $condBtn}style="display: none;"{/if}>
        <span class="icon_wish"></span>
        <span class="text-el d_l">{lang('В избранныx','newLevel')}</span>
    </button>
</div>
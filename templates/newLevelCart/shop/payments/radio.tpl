{$counter = true}
<div class="frame-radio">
    {foreach $payments as $paymentMethod}
        <div class="frame-label">
            <span class="niceRadio b_n">
                <input type="radio"
                       {if $counter}
                           checked="checked"
                           {$counter = false}
                       {/if}
                       value="{echo $paymentMethod->getId()}"
                       name="paymentMethodId"
                       />
            </span>
            <div class="name-count">
                <span class="text-el">{echo $paymentMethod->getName()}</span>
            </div>
            {if $paymentMethod->getDescription()}
                <div class="help-block">{echo $paymentMethod->getDescription()}</div>
            {/if}
        </div>
    {/foreach}
</div>
<link rel="stylesheet" type="text/css" href="/application/modules/star_rating/assets/css/style.css">
{if $data['id_type'] != null}
<div class="star_rating">
    <div id="star_rating_{echo $data['id_type']}" class="rating_nohover {if $data['votes'] != null}{echo count_star(round($data['rating']/$data['votes']))}{/if} star_rait">
        <div id="1" class="rate one">
            <span title="1" class="">1</span>
        </div>
        <div id="2" class="rate two">
		<span title="2" class="">2</span>
        </div>
        <div id="3" class="rate three">
		<span title="3" class="">3</span>
        </div>
	<div id="4" class="rate four">
            <span title="4" class="">4</span>
        </div>
        <div id="5" class="rate five">
            <span title="5" class="">5</span>
        </div>
    </div>
</div>
{if $star_rating['type'] == 'product'}
<span itemscope="" itemtype="http://data-vocabulary.org/Review-aggregate" id="pageRatingData"> 
<meta itemprop="rating" content="4"> Оставило <span id="count_votes" itemprop="count">{if $data['votes'] != null}{echo $data['votes']}{else:} 0 {/if}</span> человек(а).
</span>
{/if}
{/if}
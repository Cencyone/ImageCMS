<?php

function promoLabel($action, $hot, $hit, $disc) {
    $pricePrecision = ShopCore::app()->SSettings->pricePrecision;
    $out = "";
 
    if ($action && (int) $action > 0)
        $out .= '<span class="product-status action"></span>';
    if ($hot && (int) $hot > 0)
        $out .= '<span class="product-status nowelty"></span>';
    if ($hit && (int) $hit > 0)
        $out .= '<span class="product-status hit"></span>';
    if ($disc && (float) $disc > 0)
        $out .= '<span class="product-status discount"><span class="text-el">' . round($disc, 0) . '%</span></span>';
    return $out;
    
    
}

function promoLabelBtn($action, $hot, $hit, $disc) {
    $out = array();
    if ($action && (int) $action > 0)
        $out['action'] = $action;
    if ($hot && (int) $hot > 0)
        $out['hot'] = $hot;
    if ($hit && (int) $hit > 0)
        $out['hit'] = $hit;
    if ($disc && (float) $disc > 0)
        $out['disc'] = round($disc, 0);

    return $out;
}
?>
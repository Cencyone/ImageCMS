<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>{$site_title}</title>
        <meta name="description" content="{$site_description}" />
        <meta name="keywords" content="{$site_keywords}" />
        <meta name="generator" content="ImageCMS" />
        <link rel="icon" type="image/x-icon" href="{$SHOP_THEME}images/favicon.png"/>
        <link rel="stylesheet" type="text/css" href="{$SHOP_THEME}css/style.css"/>
        <link href='http://fonts.googleapis.com/css?family=PT+Sans&subset=latin,cyrillic' rel='stylesheet' type='text/css'>
        <script src="{$SHOP_THEME}js/jquery-1.8.2.min.js" type="text/javascript"></script>
        <!--[if lt IE 9]><script type="text/javascript" src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script><script src="js/css3-mediaqueries.js"></script><![endif]-->
        {literal}
            <style>
                /*!
                    * Bootstrap Responsive v2.1.1
                    *
                    * Copyright 2012 Twitter, Inc
                    * Licensed under the Apache License v2.0
                    * http://www.apache.org/licenses/LICENSE-2.0
                    *
                    * Designed and built with all the love in the world @twitter by @mdo and @fat.
                */.clearfix{*zoom:1}.clearfix:before,.clearfix:after{display:table;line-height:0;content:""}.clearfix:after{clear:both}.hide-text{font:0/0 a;color:transparent;text-shadow:none;background-color:transparent;border:0}.input-block-level{display:block;width:100%;min-height:30px;-webkit-box-sizing:border-box;-moz-box-sizing:border-box;box-sizing:border-box}.hidden{display:none;visibility:hidden}.visible-phone{display:none!important}.visible-tablet{display:none!important}.hidden-desktop{display:none!important}.visible-desktop{display:inherit!important}@media screen and (max-width:320px){.items_catalog>.span9>.description{margin-left:0;clear:both}}@media screen and (max-width:380px){.frameHeaderMenu{overflow:visible}}@media screen and (min-width:768px) and (max-width:979px){.hidden-desktop{display:inherit!important}.visible-desktop{display:none!important}.visible-tablet{display:inherit!important}.hidden-tablet{display:none!important}}@media screen and (max-width:767px){.hidden-desktop{display:inherit!important}.visible-desktop{display:none!important}.visible-phone{display:inherit!important}.hidden-phone{display:none!important}.items_catalog{margin:0 15px}}@media screen and (min-width:1200px){.row{margin-left:-30px;*zoom:1}.row:before,.row:after{display:table;line-height:0;content:""}.row:after{clear:both}[class*="span"]{float:left;min-height:1px;margin-left:30px}.container,.navbar-static-top .container,.navbar-fixed-top .container,.navbar-fixed-bottom .container{width:1170px}.span12{width:1170px}.span11{width:1070px}.span10{width:970px}.span9{width:870px}.span8{width:770px}.span7{width:670px}.span6{width:570px}.span5{width:470px}.span4{width:370px}.span3{width:270px}.span2{width:170px}.span1{width:70px}.offset12{margin-left:1230px}.offset11{margin-left:1130px}.offset10{margin-left:1030px}.offset9{margin-left:930px}.offset8{margin-left:830px}.offset7{margin-left:730px}.offset6{margin-left:630px}.offset5{margin-left:530px}.offset4{margin-left:430px}.offset3{margin-left:330px}.offset2{margin-left:230px}.offset1{margin-left:130px}.row-fluid{width:100%;*zoom:1}.row-fluid:before,.row-fluid:after{display:table;line-height:0;content:""}.row-fluid:after{clear:both}.row-fluid [class*="span"]{display:block;float:left;width:100%;min-height:30px;margin-left:2.564102564102564%;*margin-left:2.5109110747408616%;-webkit-box-sizing:border-box;-moz-box-sizing:border-box;box-sizing:border-box}.row-fluid [class*="span"]:first-child{margin-left:0}.row-fluid .span12{width:100%;*width:99.94680851063829%}.row-fluid .span11{width:91.45299145299145%;*width:91.39979996362975%}.row-fluid .span10{width:82.90598290598291%;*width:82.8527914166212%}.row-fluid .span9{width:74.35897435897436%;*width:74.30578286961266%}.row-fluid .span8{width:65.81196581196582%;*width:65.75877432260411%}.row-fluid .span7{width:57.26495726495726%;*width:57.21176577559556%}.row-fluid .span6{width:48.717948717948715%;*width:48.664757228587014%}.row-fluid .span5{width:40.17094017094017%;*width:40.11774868157847%}.row-fluid .span4{width:31.623931623931625%;*width:31.570740134569924%}.row-fluid .span3{width:23.076923076923077%;*width:23.023731587561375%}.row-fluid .span2{width:14.52991452991453%;*width:14.476723040552828%}.row-fluid .span1{width:5.982905982905983%;*width:5.929714493544281%}.row-fluid .offset12{margin-left:105.12820512820512%;*margin-left:105.02182214948171%}.row-fluid .offset12:first-child{margin-left:102.56410256410257%;*margin-left:102.45771958537915%}.row-fluid .offset11{margin-left:96.58119658119658%;*margin-left:96.47481360247316%}.row-fluid .offset11:first-child{margin-left:94.01709401709402%;*margin-left:93.91071103837061%}.row-fluid .offset10{margin-left:88.03418803418803%;*margin-left:87.92780505546462%}.row-fluid .offset10:first-child{margin-left:85.47008547008548%;*margin-left:85.36370249136206%}.row-fluid .offset9{margin-left:79.48717948717949%;*margin-left:79.38079650845607%}.row-fluid .offset9:first-child{margin-left:76.92307692307693%;*margin-left:76.81669394435352%}.row-fluid .offset8{margin-left:70.94017094017094%;*margin-left:70.83378796144753%}.row-fluid .offset8:first-child{margin-left:68.37606837606839%;*margin-left:68.26968539734497%}.row-fluid .offset7{margin-left:62.393162393162385%;*margin-left:62.28677941443899%}.row-fluid .offset7:first-child{margin-left:59.82905982905982%;*margin-left:59.72267685033642%}.row-fluid .offset6{margin-left:53.84615384615384%;*margin-left:53.739770867430444%}.row-fluid .offset6:first-child{margin-left:51.28205128205128%;*margin-left:51.175668303327875%}.row-fluid .offset5{margin-left:45.299145299145295%;*margin-left:45.1927623204219%}.row-fluid .offset5:first-child{margin-left:42.73504273504273%;*margin-left:42.62865975631933%}.row-fluid .offset4{margin-left:36.75213675213675%;*margin-left:36.645753773413354%}.row-fluid .offset4:first-child{margin-left:34.18803418803419%;*margin-left:34.081651209310785%}.row-fluid .offset3{margin-left:28.205128205128204%;*margin-left:28.0987452264048%}.row-fluid .offset3:first-child{margin-left:25.641025641025642%;*margin-left:25.53464266230224%}.row-fluid .offset2{margin-left:19.65811965811966%;*margin-left:19.551736679396257%}.row-fluid .offset2:first-child{margin-left:17.094017094017094%;*margin-left:16.98763411529369%}.row-fluid .offset1{margin-left:11.11111111111111%;*margin-left:11.004728132387708%}.row-fluid .offset1:first-child{margin-left:8.547008547008547%;*margin-left:8.440625568285142%}.thumbnails{margin-left:-30px}.thumbnails>li{margin-left:30px}.row-fluid .thumbnails{margin-left:0}}@media screen and (min-width:768px) and (max-width:979px){.row{margin-left:-20px;*zoom:1}.row:before,.row:after{display:table;line-height:0;content:""}.row:after{clear:both}[class*="span"]{float:left;min-height:1px;margin-left:20px}.container,.navbar-static-top .container,.navbar-fixed-top .container,.navbar-fixed-bottom .container{width:724px}.span12{width:724px}.span11{width:662px}.span10{width:600px}.span9{width:538px}.span8{width:476px}.span7{width:414px}.span6{width:352px}.span5{width:290px}.span4{width:228px}.span3{width:166px}.span2{width:104px}.span1{width:42px}.offset12{margin-left:764px}.offset11{margin-left:702px}.offset10{margin-left:640px}.offset9{margin-left:578px}.offset8{margin-left:516px}.offset7{margin-left:454px}.offset6{margin-left:392px}.offset5{margin-left:330px}.offset4{margin-left:268px}.offset3{margin-left:206px}.offset2{margin-left:144px}.offset1{margin-left:82px}.row-fluid{width:100%;*zoom:1}.row-fluid:before,.row-fluid:after{display:table;line-height:0;content:""}.row-fluid:after{clear:both}.row-fluid [class*="span"]{display:block;float:left;width:100%;min-height:30px;margin-left:2.7624309392265194%;*margin-left:2.709239449864817%;-webkit-box-sizing:border-box;-moz-box-sizing:border-box;box-sizing:border-box}.row-fluid [class*="span"]:first-child{margin-left:0}.row-fluid .span12{width:100%;*width:99.94680851063829%}.row-fluid .span11{width:91.43646408839778%;*width:91.38327259903608%}.row-fluid .span10{width:82.87292817679558%;*width:82.81973668743387%}.row-fluid .span9{width:74.30939226519337%;*width:74.25620077583166%}.row-fluid .span8{width:65.74585635359117%;*width:65.69266486422946%}.row-fluid .span7{width:57.18232044198895%;*width:57.12912895262725%}.row-fluid .span6{width:48.61878453038674%;*width:48.56559304102504%}.row-fluid .span5{width:40.05524861878453%;*width:40.00205712942283%}.row-fluid .span4{width:31.491712707182323%;*width:31.43852121782062%}.row-fluid .span3{width:22.92817679558011%;*width:22.87498530621841%}.row-fluid .span2{width:14.3646408839779%;*width:14.311449394616199%}.row-fluid .span1{width:5.801104972375691%;*width:5.747913483013988%}.row-fluid .offset12{margin-left:105.52486187845304%;*margin-left:105.41847889972962%}.row-fluid .offset12:first-child{margin-left:102.76243093922652%;*margin-left:102.6560479605031%}.row-fluid .offset11{margin-left:96.96132596685082%;*margin-left:96.8549429881274%}.row-fluid .offset11:first-child{margin-left:94.1988950276243%;*margin-left:94.09251204890089%}.row-fluid .offset10{margin-left:88.39779005524862%;*margin-left:88.2914070765252%}.row-fluid .offset10:first-child{margin-left:85.6353591160221%;*margin-left:85.52897613729868%}.row-fluid .offset9{margin-left:79.8342541436464%;*margin-left:79.72787116492299%}.row-fluid .offset9:first-child{margin-left:77.07182320441989%;*margin-left:76.96544022569647%}.row-fluid .offset8{margin-left:71.2707182320442%;*margin-left:71.16433525332079%}.row-fluid .offset8:first-child{margin-left:68.50828729281768%;*margin-left:68.40190431409427%}.row-fluid .offset7{margin-left:62.70718232044199%;*margin-left:62.600799341718584%}.row-fluid .offset7:first-child{margin-left:59.94475138121547%;*margin-left:59.838368402492065%}.row-fluid .offset6{margin-left:54.14364640883978%;*margin-left:54.037263430116376%}.row-fluid .offset6:first-child{margin-left:51.38121546961326%;*margin-left:51.27483249088986%}.row-fluid .offset5{margin-left:45.58011049723757%;*margin-left:45.47372751851417%}.row-fluid .offset5:first-child{margin-left:42.81767955801105%;*margin-left:42.71129657928765%}.row-fluid .offset4{margin-left:37.01657458563536%;*margin-left:36.91019160691196%}.row-fluid .offset4:first-child{margin-left:34.25414364640884%;*margin-left:34.14776066768544%}.row-fluid .offset3{margin-left:28.45303867403315%;*margin-left:28.346655695309746%}.row-fluid .offset3:first-child{margin-left:25.69060773480663%;*margin-left:25.584224756083227%}.row-fluid .offset2{margin-left:19.88950276243094%;*margin-left:19.783119783707537%}.row-fluid .offset2:first-child{margin-left:17.12707182320442%;*margin-left:17.02068884448102%}.row-fluid .offset1{margin-left:11.32596685082873%;*margin-left:11.219583872105325%}.row-fluid .offset1:first-child{margin-left:8.56353591160221%;*margin-left:8.457152932878806%}}@media screen and (max-width:767px){.navbar-fixed-top,.navbar-fixed-bottom,.navbar-static-top{margin-right:-20px;margin-left:-20px}.container-fluid{padding:0}.dl-horizontal dt{float:none;width:auto;clear:none;text-align:left}.dl-horizontal dd{margin-left:0}.container{width:auto}.row-fluid{width:100%}.row,.thumbnails{margin-left:0}.thumbnails>li{float:none;margin-left:0}[class*="span"],.row-fluid [class*="span"]{display:block;float:none;width:100%;margin-left:0;-webkit-box-sizing:border-box;-moz-box-sizing:border-box;box-sizing:border-box}.span12,.row-fluid .span12{width:100%;-webkit-box-sizing:border-box;-moz-box-sizing:border-box;box-sizing:border-box}}
            </style>
        {/literal}
        {$meta_noindex}
        {$canonical}

        <script src="{$SHOP_THEME}js/jquery-1.8.2.min.js" type="text/javascript"></script>
        <script src="{$SHOP_THEME}js/underscore-min.js" type="text/javascript"></script>
    </head>
    <body>
        <div class="mainBody">
            <div class="header">
                <header>
                    <div class="container">
                        <section class="row-fluid">
                            <div class="f_r m-l_25">
                                <nav class="f_l">
                                    <ul class="nav navHorizontal frameEnterReg">
                                        {if !$CI->dx_auth->is_logged_in()}
                                            <li>
                                                <span class="f-s_0">
                                                    <span class="helper"></span>
                                                    <button type="button" data-drop=".drop-enter" data-effect-on="fadeIn" data-effect-off="fadeOut" data-duration="300" data-place="noinherit" data-placement="top right"><span class="icon-enter"></span><span class="d_l_g">Вход</span></button>
                                                </span>
                                            </li>
                                            <li>
                                                <span class="f-s_0">
                                                    <span class="helper"></span>
                                                    <span>
                                                        <a href="/auth/register" class="t-d_u c_5c"><span class="icon-registration"></span><span class="text-el">Регистрация</span></a>
                                                    </span>
                                                </span>
                                            </li>
                                        {else:}
                                            <li>
                                                <span class="f-s_0">
                                                    <span class="helper"></span>
                                                    <a href="#" onclick="ImageCMSApi.formAction('/auth/authapi/logout', '');
                                                                return false;">Выход</a>
                                                </span>
                                            </li>
                                            <li>
                                                <span class="f-s_0">
                                                    <span class="helper"></span>
                                                    <span>
                                                        <a href="/shop/profile" class="t-d_u c_5c"><span class="text-el">Личный кабинет</span></a>
                                                    </span>
                                                </span>
                                            </li>
                                        {/if}
                                    </ul>
                                </nav>
                                        <div class="cleaner f_l f-s_0 isAvail" onclick="window.location='/shop/cart'">
                                    <span class="helper"></span>
                                    <span class="f-s_0">
                                        <span class="icon-bask"></span>
                                        <span class="d_l">Корзина</span>
                                        <span>&nbsp;(0)</span>
                                    </span>
                                </div>
                            </div>
                            <nav class="frameHeaderMenu">
                                {load_menu('top_menu')}
                            </nav>
                        </section>
                    </div>
                </header>
                <section class="container">
                    <section class="headerContent row-fluid">
                        <div class="span3">
                            <a href="{site_url()}" class="logo">
                                <img src="{$SHOP_THEME}images/logo.png" />
                            </a>
                        </div>
                        <div class="span9 f-s_0">
                            <span class="helper"></span>
                            <div class="w_100 f-s_0 frameUndef_1">
                                <div class="span6">
                                    <div class="frameSearch">
                                        <form name="search" class="clearfix" action="{shop_url('search')}" method="get" id="autocomlete">
                                            <button class="f_r btn" type="submit"><span class="icon-search"></span><span class="text-el">{lang('search_find')}</span></button>
                                            <div class="o_h">
                                                <input type="text" name="text" placeholder="Поиск по сайту"/>
                                            </div>
                                            <div id="suggestions" class="drop-search d_n">
                                                <div class="inside-padd">
                                                    <ul class="frame-search-thumbail">
                                                        <li>
                                                            <a href="#">
                                                                <span class="photo">
                                                                    <span class="helper"></span>
                                                                    <img src="{$SHOP_THEME}images/temp/item_thumb.png">
                                                                </span>
                                                                <span>Оригинальный Phone 4S Black</span>
                                                            </a>
                                                            <div class="price price_f-s_16"><span class="f-w_b">99999</span> грн.</div>
                                                        </li>
                                                    </ul>
                                                    <div class="btn-form">
                                                        <a href="#" class="f-s_0"><span class="icon-show-all"></span><span class="text-el">Показать все результаты</span></a>
                                                    </div>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                                <div class="span3">
                                    {include_tpl('compare_data')}
                                    {include_tpl('wish_list_data')}
                                </div>
                                <div class="span3">
                                    <div class="headerPhone"><span class="c_67">+8 (097)</span><span class="d_n">&minus;</span> 572-58-18</div>
                                    <div style="margin-top: 7px;">
                                        <ul class="tabs">
                                            <li>
                                                <a class="t-d_n f-s_0" href="#a" data-drop=".drop-order-call" data-effect-on="fadeIn" data-effect-off="fadeOut" data-duration="300" data-place="center"><span class="icon-order-call"></span><span class="d_l_b">{lang('s_coll_order')}</span></a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>
                </section>
            </div>
            <div class="">

                <!-- Start. Render Category Tree. Menu frame -->
                <div class="mainFrameMenu">
                    <section class="container">
                        {\Category\RenderMenu::create()->load('category_menu')}
                    </section>
                </div>
                <!-- End. Render Category Tree. Menu frame -->

                <div class="">
                    <section class="container">
                        <!--                     class="span9"-->
                        {$shop_content}
                    </section>
                </div>
            </div>
            <!-- brands widget -->
                {widget('brands')}
                <!-- *** -->
            <div class="hFooter"></div>
        </div>
        <footer>
            <div class="container">
                <div class="row-fluid">
                    <div class="span5">
                        <nav>
                            {load_menu('footer_menu')}
                        </nav>
                    </div>
                    <div class="span4">
                        <ul class="contacts_info">
                            <li><span class="icon-foot-phone"></span><span class="f-w_b">{lang('s_tel')}:</span> +8 (067)<span class="d_n">&minus;</span> 572-58-18, +8 (067)<span class="d_n">&minus;</span> 572-58-18</li>
                            <li><span class="icon-foot-email"></span><span class="f-w_b">{lang('s_email')}:</span> SiteImageCMS@gmail.com</li>
                            <li><span class="icon-foot-skype"></span><span class="f-w_b">{lang('s_skype')}:</span> SiteImageCMS</li>
                            {$CI->load->module('star_rating')->show_star_rating()}
                        </ul>
                    </div>
                    <div class="span3 t-a_r">
                        <div class="copy_right">© SiteImage CMS, 2012</div>
                        <div class="footer_social">
                            <img src="{$SHOP_THEME}images/temp/social_footer.png"/>
                        </div>
                        <a href="http://siteimage.com.ua">{lang('s_footer_create')}</a><br/>
                        {lang('s_footer_seo')}
                    </div>
                </div>
            </div>
        </footer>
        <div class="headerFon"></div>
        <div class="drop-enter drop">
            <div class="icon-times-enter" data-closed="closed-js"></div>
            <div class="drop-content">
                <div class="header_title">
                    Вход для клиентов
                </div>
                <div class="inside_padd">
                    <div class="horizontal_form standart_form">
                        <form method="post" id="login_form">
                            <label>
                                <span class="title">E-mail</span>
                                <span class="frame_form_field">
                                    <span class="icon-email"></span>
                                    <input type="text" name="email"/>
                                    <div id="for_email" class="for_validations"></div>
                                </span>
                            </label>
                            <label>
                                <span class="title">Пароль</span>
                                <span class="frame_form_field">
                                    <span class="icon-password"></span>
                                    <input type="password" name="password"/>
                                    <div id="for_password" class="for_validations"></div>
                                </span>
                            </label>
                            <div class="frameLabel">
                                <span class="title">&nbsp;</span>
                                <span class="frame_form_field c_n">
                                    <a href="/auth/forgot_password" class="f_l neigh_btn">Забыли пароль?</a>
                                    <input type="button" value="Войти" class="btn btn_cart f_r" onclick="ImageCMSApi.formAction('/auth/authapi/login', 'login_form');
                                                                return false;"/>
                                </span>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="drop-footer"></div>
        </div>
        <div class="drop-order-call drop" id="a">
            <div class="icon-times-enter" data-closed="closed-js"></div>
            <div class="drop-content">
                <div class="header_title">
                    Заказ звонка
                </div>
                <div class="inside_padd">
                    <div class="horizontal_form standart_form">
                        <form method="post">
                            <label>
                                <span class="title">Ваше имя</span>
                                <span class="frame_form_field">
                                    <span class="icon-person"></span>
                                    <input type="text"/>
                                </span>
                            </label>
                            <label>
                                <span class="title">Номер телефона</span>
                                <span class="frame_form_field">
                                    <span class="icon-phone"></span>
                                    <input type="text"/>
                                </span>
                            </label>
                            <label>
                                <span class="title">Примерное время</span>
                                <span class="frame_form_field">
                                    <input type="text"/>
                                    <span class="icon-clock"></span>
                                </span>
                            </label>
                            <label>
                                <span class="title">Комментарий</span>
                                <span class="frame_form_field">
                                    <textarea></textarea>
                                </span>
                            </label>
                            <div class="frameLabel">
                                <span class="title">&nbsp;</span>
                                <span class="frame_form_field c_n">
                                    <input type="submit" value="Позвоните мне" class="btn btn_cart f_r"/>
                                </span>

                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="drop-footer"></div>
        </div>
        <div class="drop drop-report">
            <div class="drop-content">
                <div class="title_h2">Сообщить когда появится</div>
                <div class="icon-times-enter" data-closed="closed-js"></div>
            </div>
            <div class="drop-footer"></div>
        </div>
        <div class="d_n" data-clone="data-report">
            <form method="post" action="" id="data-report">
                <div class="standart_form">
                    <label>
                        <span class="title">Ваше имя</span>
                        <span class="frame_form_field">
                            <input type="text" id="" name="UserName"/>
                            <div id="for_UserName" class="for_validations"></div>
                            <span class="must">*</span>
                        </span>
                    </label>
                    <label>
                        <span class="title">E-mail</span>
                        <span class="frame_form_field">
                            <input type="text" id="" name="UserEmail"/>
                            <div id="for_UserEmail" class="for_validations"></div>
                            <input type="hidden" name="ProductId" value=""/>
                            <input type="hidden" name="notifme" value="true"/>
                            <span class="must">*</span>
                            <span class="help_inline">На почту придет уведомление о появлении данного товара</span>
                        </span>
                    </label>
                    <label>
                        <span class="title">Телефон</span>
                        <span class="frame_form_field">
                            <input type="text" id="" name="UserPhone"/>
                            <div id="for_UserPhone" class="for_validations"></div>
                            <span class="must">*</span>
                        </span>
                    </label>
                </div>
                <div class="t-a_r">
                    <input type="submit" value="Отправить" onclick="ImageCMSApi.formAction('/shop/ajax/getApiNotifyingRequest', 'data-report');
                                                                return false;" class="btn btn_cart"/>
                </div>
            </form>
        </div>
        <script src="{$SHOP_THEME}js/jquery.cycle.all.js" type="text/javascript"></script>
        <script src="{$SHOP_THEME}js/jquery.jcarousel.min.js" type="text/javascript"></script>
        <script src="{$SHOP_THEME}js/jquery.ui-slider.js" type="text/javascript"></script>
        <script src="{$SHOP_THEME}js/cusel-min-2.5.js" type="text/javascript"></script>
        <script src="{$SHOP_THEME}js/fancybox/jquery.fancybox.pack.js" type="text/javascript"></script>
        <script src="{$SHOP_THEME}js/scripts.js" type="text/javascript"></script>
        <script src="{$SHOP_THEME}js/shop.js" type="text/javascript"></script>
        <!-- Dev. scripts -->
        <script src="{$SHOP_THEME}js/imagecms.api.js" type="text/javascript"></script>


        {include_tpl('js_templates')}


        <!-- floating elements-->
        <div id="popupCart" style="display: none;" class="drop"></div>
        <a href="#" data-drop="#popupCart" data-place="center" data-effect-on="fadeIn" data-effect-off="fadeOut" data-duration="300" id="showCart" style="display: none;"   >Show cart</a>
    </body>
</html>

<!--Start. Top menu and authentication data block-->
<div class="menu-header">
    <div class="container">
        <nav class="left-header f_l">
            <ul class="nav">
                {load_menu('top_menu')}
            </ul>
        </nav>
        <div class="right-header f_r">
            {include_shop_tpl('auth_data')}
        </div>
        <ul class="social-head items f_l">
            <li>
                <a href="#" class="icon-vk"></a>
            </li>
            <li>
                <a href="#" class="icon-fb"></a>
            </li>
            <li>
                <a href="#" class="icon-gp"></a>
            </li>
        </ul>
    </div>
</div>
<!--End. Top menu and authentication data block-->
<div class="content-header">
    <div class="container">
        <!--        Logo-->
        {if  $CI->uri->uri_string() == ''}
            <span class="logo">
                <img src="{echo siteinfo('siteinfo_logo_url')}" alt="logo.png"/>
            </span>
        {else:}
            <a href="{site_url('')}" class="logo">
                <img src="{echo siteinfo('siteinfo_logo_url')}" alt="logo.png"/>
            </a>
        {/if}
        <div class="left-content-header">
            <div class="header-left-content-header t-a_j">
                <!--                Start. contacts block-->
                <div class="phones-header">
                    <span class="f-s_0 d_b">
                        <span class="icon_phone_header"></span>
                        <span class="phone">
                            <span class="phone-number">{echo siteinfo('siteinfo_mainphone')}</span>
                        </span>
                    </span>
                    <div class="btn-order-call">
                        <button data-tab="true" data-href="#ordercall" data-drop="#ordercall" data-source="{site_url('shop/callback')}">
                            <span class="icon_order_call"></span>
                            <span class="text-el d_l">{lang('Заказать звонок','newLevel')}</span>
                        </button>
                    </div>
                </div>
                <div class="head-work">
                    <span class="c_b">Работаем:</span> <span class="s-t">Пн–Пт 09:00–20:00,<br/>Сб 09:00–17:00, Вс выходной</span>
                </div>
                <!--                End. Contacts block-->
                <div class="frame-search-cleaner">
                    <!--                Start. Include cart data template-->

                    <!--                    End. Include cart data template-->
                    <!--                Start. Show search form-->
                    <div class="frame-search-form">
                        <div class="p_r">
                            <form name="search" method="get" action="{shop_url('search')}">
                                <span class="btn-search">
                                    <button type="submit"><span class="icon_search"></span><span class="text-el">{lang('Найти','newLevel')}</span></button>
                                </span>
                                <div class="frame-search-input">
                                    <input type="text" class="input-search" id="inputString" name="text" autocomplete="off" value="{if strpos($CI->uri->uri_string, 'search') !== false}{htmlspecialchars($_GET['text'])}{/if}"  placeholder="{lang('Я ищу', 'newLevel')}&hellip;"/>
                                    <div id="suggestions" class="drop drop-search"></div>
                                </div>
                            </form>
                        </div>
                    </div>
                    <!--                End. Show search form-->
                </div>
            </div>
        </div>
    </div>
</div>
{if strpos($CI->uri->uri_string, 'search') !== false}
    {literal}
        <script>
            $(document).on('scriptDefer', function() {
                var input = $('#inputString');
                input.setCursorPosition(input.val().length);
            });
        </script>
    {/literal}
{/if}
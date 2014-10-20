<div class="page-main">
    {$CI->load->module('banners')->render()}
    <div class="container">
        <div class="clearfix">
            <div class="left-start-page">
                <div id="popular_products">
                    {widget('popular_products', TRUE)}
                </div>
                {widget('brands')}
            </div>
            <div class="right-start-page">
                <div id="action_products">
                    {widget('action_products', TRUE)}
                </div>
                <div id="new_products">
                    {widget('new_products', TRUE)}
                </div>
                {widget('latest_news', TRUE)}
            </div>
        </div>
        <div class="frame-seotext-news">
            <div class="frame-seo-text">
                <div class="container">
                    <div class="text seo-text">
                        {widget('start_page_seo_text')}
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
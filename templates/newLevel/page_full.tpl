<div class="frame-crumbs">
    {widget('path')}
</div>
<div class="frame-inside page-text">
    <div class="container">
        <div class="text-left">{load_menu('left_menu')}</div>
        <div class="text-right">
            <div class="text">
                <h1>{$page.title}</h1>
                {$page.full_text}
                {echo $CI->load->module('mailer')->getForm()}
                <br>
                ddddddddddddddddddddddddddddddddddddddd2
                
                {//$Comments = $CI->load->module('comments')->init($page)}
                {//$c=$CI->load->module('comments/commentsapi')->renderAsArray($CI->uri->uri_string())}
                <div class="forComments">
                    {echo $c['comments']}
                </div>
            </div>
        </div>
    </div>
</div>
<section class="mini-layout mod_stats">
    <div class="frame_title clearfix">
        <div class="pull-left">
            <span class="help-inline"></span>
            <span class="title">{lang('Stats', 'mod_stats')}</span>
        </div>
        <div class="pull-right">
            <div class="d-i_b">
                <a href="" class="t-d_n m-r_15"><span class="f-s_14">←</span> <span class="t-d_u">{lang('Back', 'admin')}</span></a>
            </div>
        </div>
    </div>
    <div class="row-fluid">
        {include_tpl('../left_block')}
        <div class="clearfix span9">
            {include_tpl('../time_and_filter_block_without_groupby')}
            <div class="fixedTableWithLeftScroll" style="">
                <table class="table table-striped table-bordered table-condensed content_big_td">
                    <thead>
                        <tr>
                            <th>{lang('Key','mod_stats')}</th>
                            <th>{lang('Count','mod_stats')}</th>
                            <th>{lang('Date','mod_stats')}</th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach $data as $word}
                            <tr>
                                <td>{$word.key}</td>
                                <td>{$word.key_count}</td>
                                <td>{$word.date_search}</td>
                            </tr>
                        {/foreach}
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</section>


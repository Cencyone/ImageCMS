<section class="mini-layout">
    <div class="frame_title clearfix">
        <div class="pull-left">
            <span class="help-inline"></span>
            <span class="title">{lang('amt_gallery')}</span>
        </div>
        <div class="pull-right">
            <div class="d-i_b">
                <a href="/admin/components/cp/gallery" class="t-d_n m-r_15"><span class="f-s_14">←</span> <span class="t-d_u">{lang('a_back')}</span></a>
                <button type="button" class="btn btn-small action_on formSubmit" data-form="create_category_form" data-action="close"><i class="icon-ok"></i>Сохранить</button>
            </div>
        </div>
    </div>
    <table class="table table-striped table-bordered table-hover table-condensed">
        <thead>
            <tr>
                <th colspan="6">{lang('amt_create_cat')}</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td colspan="6">
                    <div class="inside_padd">
                        <div class="form-horizontal row-fluid">
                            <div class="span6">
                                <form method="post" action="{site_url('admin/components/cp/gallery/create_category')}" id="create_category_form">
                                    <div class="control-group">
                                        <label class="control-label" for="name">{lang('amt_name')}:</label>
                                        <div class="controls">
                                            <input type="text" name="name" id="name" value=""/>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label" for="g_c_desc">{lang('amt_description')}:</label>
                                        <div class="controls">
                                            <textarea name="description" id="g_c_desc">{htmlspecialchars($category.description)}</textarea>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label" for="tpl_file">{lang('amt_template_file')}:</label>
                                        <div class="controls">
                                            <div class="pull-right help-block">.tpl</div>
                                            <div class="o_h">
                                                <input type="text" name="tpl_file" id="tpl_file" value="{$album.tpl_file}"/>
                                                <span class="help-block">{lang('amt_by_default')}: album.tpl</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label" for="position">{lang('amt_position')}:</label>
                                        <div class="controls">
                                            <input type="text" name="position" id="position" value=""/>
                                        </div>
                                    </div>
                                    {form_csrf()}
                                </form>
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
        </tbody>
    </table>
</section>
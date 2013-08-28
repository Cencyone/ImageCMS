<section class="mini-layout">
    <div class="frame_title clearfix">
        <div class="pull-left">
            <span class="help-inline"></span>
            <span class="title">{lang("Sending emails")}</span>
        </div>
        <div class="pull-right">
            <div class="d-i_b">
                <a href="/admin/components/modules_table/" class="t-d_n m-r_15"><span class="f-s_14">←</span> <span class="t-d_u">Вернуться</span></a>
                <button type="button" class="btn btn-small formSubmit" data-form="#send" ><i class="icon-list-alt"></i>{lang("Send a letter")}</button>                   
            </div>
        </div>                            
    </div>               
    <div class="tab-content">
        <!-----------------------------------------------------SETTINGS MAIL-------------------------------------------------------------->
        <div class="tab-pane active" id="mail">
            <table class="table table-striped table-bordered table-hover table-condensed content_big_td">
                <thead>
                    <tr>
                        <th colspan="6">
                            {lang("Properties")}
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td colspan="6">
                            <div class="inside_padd">
                                <div class="form-horizontal">
                                    <form id="send" method="post" action="{$BASE_URL}admin/components/cp/group_mailer/send_email">
                                        <div class="span9">
                                            <div class="control-group">
                                                <label class="control-label" for="subject">{lang("Theme")}</label>
                                                <div class="controls">
                                                    <input type="text" name="subject" id="subject" value="" required/>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="name">{lang("Your name")}</label>
                                                <div class="controls">
                                                    <input type="text" name="name" id="name" value="" required/>
                                                </div>
                                            </div>
                                            <div class="control-group">
                                                <label class="control-label" for="email">{lang("Your e-mail")}</label>
                                                <div class="controls">
                                                    <input type="text" id="email" name="email" value="{$admin_mail}" class="required email"/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label" for="message">{lang("Message")}</label>
                                            <div class="controls">
                                                <textarea name="message" id="message" class="elRTE">{lang("Hello")}, %username%.
--------------------------------
                                                    {lang("best regards, administration")} {$site_settings.site_title}

                                                    {site_url()}

                                                </textarea> 
                                            </div>
                                        </div>

                                        <div class="span9">
                                            <div class="control-group">
                                                <div class="control-label">{lang("Send to groups")}</div>
                                                <div class="controls">
                                                    {foreach $roles as $role}
                                                        <div class="frame_label m-b_15 d_b no_connection">
                                                            <span class="niceCheck">
                                                                <input type="checkbox" name="roles[]" value="{$role.id}" />
                                                            </span>
                                                            {$role.name}
                                                        </div>
                                                    {/foreach}
                                                </div>
                                            </div>


                                            <div class="control-group">
                                                <label class="control-label" for="mailtype">{lang("Formatting")}</label>
                                                <div class="controls">
                                                    <select name="mailtype" id="mailtype">
                                                        <option value="html" selected="selected">{lang("HTML")}</option>
                                                        <option value="text">{lang("Plain Text")}</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table> 
        </div>

</section>
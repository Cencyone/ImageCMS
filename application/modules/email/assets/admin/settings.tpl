<div class="container">
    <section class="mini-layout">
        <div class="frame_title clearfix">
            <div class="pull-left">
                <span class="help-inline"></span>
                <span class="title">{lang('Settings')}</span>
            </div>
            <div class="pull-right">
                <div class="d-i_b">
                    <a href="{$BASE_URL}admin/components/init_window/email"
                       class="t-d_n m-r_15 pjax">
                        <span class="f-s_14">←</span>
                        <span class="t-d_u">{lang('a_back')}</span>
                    </a>
                    <button type="button"
                            class="btn btn-small btn-primary action_on formSubmit"
                            data-form="#wishlist_settings_form"
                            data-action="tomain">
                        <i class="icon-ok"></i>{lang('a_save')}
                    </button>
                </div>
            </div>
        </div>
        <form method="post" action="{site_url('admin/components/cp/email/update_settings')}" class="form-horizontal" id="wishlist_settings_form">
            <table class="table table-striped table-bordered table-hover table-condensed">
                <thead>
                    <tr>
                        <th colspan="6">
                            {lang('Settings')}
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td colspan="6">
                            <div class="inside_padd">

                                <div class="control-group">
                                    <div class="controls">
                                        <a href="{site_url('admin/components/cp/email/import_templates')}" style="float:right">Установить стандартние шаблони</a>
                                    </div>
                                </div>
                                
                                <div class="control-group">
                                    <label class="control-label" for="settings[from]">{lang('From')}</label>
                                    <div class="controls">
                                        <input type = "text" name = "settings[from]" class="textbox_short" value="{$settings['from']}" id="from"/>
                                    </div>
                                </div>

                                <div class="control-group">
                                    <label class="control-label" for="settings[from_email]">{lang('From_email')}</label>
                                    <div class="controls">
                                        <input type = "text" name = "settings[from_email]" class="textbox_short" value="{$settings['from_email']}" id="from_email"/>
                                    </div>
                                </div>

                                <div class="control-group">
                                    <label class="control-label" for="settings[admin_email]">{lang('Admin_email')}</label>
                                    <div class="controls">
                                        <input type = "text" name = "settings[admin_email]" class="textbox_short" value="{$settings['admin_email']}" id="admin_email"/>
                                    </div>
                                </div>

                                <div class="control-group">
                                    <label class="control-label" for="settings[theme]">{lang('Theme')}</label>
                                    <div class="controls">
                                        <input type = "text" name = "settings[theme]" class="textbox_short" value="{$settings['theme']}" id="theme"/>
                                    </div>
                                </div>

                                <div class="control-group">
                                    <label class="control-label" for="settings[wraper_activ]">{lang('Use_wraper')}</label>
                                    <div class="controls">
                                        <span class="frame_label no_connection active">
                                            <span class="niceCheck" style="background-position: -46px -17px;">
                                                <input type = "checkbox" name = "settings[wraper_activ]" class="textbox_short wraper_activSettings" {if $settings['wraper_activ']}checked{/if}   id="wraper_activ"/>
                                            </span>
                                        </span>
                                    </div>
                                </div>

                                <div class="control-group wraperControlGroup" {if !$settings['wraper_activ']} style="display: none" {/if}>
                                    <label class="control-label" for="settings[wraper]">{lang('Wraper')}</label>
                                    <div class="controls">
                                        <textarea name='settings[wraper]' class="elRTE"  id="wraper">{$settings['wraper']}</textarea>
                                    </div>
                                </div>

                                <div class="control-group">
                                    <label class="control-label" for="settings[mailpath]">{lang('Server_path_to_sendmail')}</label>
                                    <div class="controls">
                                        <input type = "text" name = "settings[mailpath]" class="textbox_short" value="{$settings['mailpath']}" id="mailpath"/>
                                    </div>
                                </div>

                                <div class="control-group">
                                    <label class="control-label" for="settings[protocol]">{lang('Protocol')}</label>
                                    <div class="controls">
                                        <select name = "settings[protocol]" class="protocolSettings" id="protocol">
                                            <option {if $settings['protocol'] == "SMTP"} selected {/if} value="SMTP" >SMTP</option>
                                            <option {if $settings['protocol'] == "sendmail"} selected {/if} value="sendmail">sendmail</option>
                                            <option {if $settings['protocol'] == "mail"} selected {/if} value="mail">mail</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="control-group portControlGroup span4" {if $settings['protocol'] != "SMTP"} style="display: none"  {/if} >
                                    <label class="control-label" for="settings[port]">{lang('Port')}</label>
                                    <div class="controls ">
                                        <input type = "text" name = "settings[port]" class=" textbox_short portSettings"  value="{$settings['port']}"  id="port"/>
                                    </div>
                                </div>

                                <br>

                                <div class="control-group" >
                                    <div class="controls ">
                                        <button type="button" class="btn" onclick="mailTest()" >
                                            <i class="icon-envelope"></i>
                                            {lang('Check_email_sending')}
                                        </button>
                                    </div>
                                    <br>
                                    <div class="controls ">
                                        <button type="button" class="btn delete_image mailTestResultsHide">
                                            <i class="icon-remove"></i>
                                        </button>
                                        <div class="mailTestResults">
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
            {form_csrf()}
        </form>
    </section>
</div>
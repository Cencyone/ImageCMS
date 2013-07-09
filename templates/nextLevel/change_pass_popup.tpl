<div class="horizontal-form">
    <form method="post" id="form_change_pass">
        <label>
            <span class="title">{lang('lang_old_password')}:</span>
            <span class="frame-form-field">
                <input type="password" name="old_password"/>
            </span>
        </label>
        <label>
            <span class="title">{lang('lang_new_password')}:</span>
            <span class="frame-form-field">
                <input type="password" name="new_password"/>
            </span>
        </label>
        <label>
            <span class="title">{lang('s_newpassword')}:</span>
            <span class="frame-form-field">
                <input type="password" name="confirm_new_password"/>
            </span>
        </label>
        <div class="frame-label">
            <span class="title">&nbsp;</span>
            <span class="frame-form-field">
                <span class="btn-form">
                    <input type="submit" value="Сменить пароль" onclick="ImageCMSApi.formAction('/auth/authapi/change_password', '#form_change_pass', {literal}{hideForm: false, durationHideForm: 1000}{/literal});return false;"/>
                </span>
            </span>
        </div>
        {form_csrf()}
    </form>
</div>
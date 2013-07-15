<div class="drop-forgot drop drop-style">
    <button type="button" class="icon_times_drop" data-closed="closed-js"></button>
    <div class="drop-header">
        <div class="title">
            {lang('lang_forgot_password')}
        </div>
    </div>
    <div class="drop-content">
        <div class="inside-padd">
            <div class="horizontal-form">
                  <form method="post" id="forgot_password_form" onsubmit="ImageCMSApi.formAction('/auth/authapi/forgot_password', 'forgot_password_form');
                    return false;">
                    <div class="horizontal-form">
                        <label>
                            <span class="title">E-mail:</span>
                            <span class="frame-form-field">
                                <input type="text" name="email" id="login" />
                                <span class="help-block">На Вашу почту будет отправлен пароль</span>
                                <span class="must">*</span>
                                <label id="for_email" class="for_validations error"></label>
                            </span>
                        </label>
                        <div class="frame-label">
                            <span class="title">&nbsp;</span>
                            <div class="btn-form">
                                <button type="submit">
                                    <span class="icon_forgot_password"></span>
                                    <span class="text-el">Отправить</span>
                                </button>
                            </div>
                        </div>
                        <div class="frame-label">
                            <span class="title">&nbsp;</span>
                            <div class="frame-form-field">
                                <div class="help-block">Я еще не зарегистрирован</div>
                                <a href="/auth/register">Перейти к регистрации</a>
                            </div>
                        </div>
                    </div>
                    {form_csrf()}
                </form>
            </div>
        </div>
    </div>
</div>
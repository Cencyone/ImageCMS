<div class="container">

    <section class="mini-layout">


        <div class="frame_title clearfix" style="top: 179px; width: 1168px;">
            <div class="pull-left">
                <span class="help-inline"></span>
                <span class="title">Модуль вспомогательного меню</span>
            </div>
            <div class="pull-right">
                <div class="d-i_b">
                    <a href="/admin/dashboard" class="t-d_n m-r_15"><span class="f-s_14">←</span> <span class="t-d_u">{lang('a_return')}</span></a>
                    <button type="button" class="btn btn-small btn-primary action_on formSubmit" data-form="#saveMenu" data-action="edit" data-submit><i class="icon-ok icon-white"></i>{lang('a_save')}</button>
                </div>
            </div> 
        </div>
        <table id="tickets_table" class="table table-striped table-bordered table-hover table-condensed" style="clear:both;">
            <thead>
            <th class="span1">Настройки меню</th>
            </thead>
            <tbody>

                <tr id="">
                    <td>
                    <form method="post" class="form-horizontal" id="saveMenu">
                        <div class="inside_padd">
                            <div class="form-horizontal">
                                <div class="row-fluid">


                                    <div class="control-group">
                                        <label class="control-label" for="menu_del">Доставка:</label>
                                        <div class="controls">                                           
                                            <select style="width:25% !important" name="del[href]" id="menu_del">
                                                <option {if !$menu->del->href} selected="selected"{/if} value="0">--не определено--</option>
                                                {foreach $pages as $p}
                                                    <option value="{$p.id}" {if $menu->del->href == $p.id} selected="selected" {/if} >{$p.title}</option>
                                                {/foreach}
                                            </select> 

                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label" for="menu_pay">Оплата:</label>
                                        <div class="controls">                                            
                                            <select style="width:25% !important" name="pay[href]" id="menu_pay">
                                                <option {if !$menu->pay->href} selected="selected"{/if} value="0">--не определено--</option>
                                                {foreach $pages as $p}
                                                    <option value="{$p.id}" {if $menu->pay->href == $p.id} selected="selected" {/if} >{$p.title}</option>
                                                {/foreach}
                                            </select> 

                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label" for="menu_cont">Контакти:</label>
                                        <div class="controls">                                            
                                            <select style="width:25% !important" name="cont[href]" id="menu_cont">
                                                <option {if !$menu->cont->href} selected="selected"{/if} value="0">--не определено--</option>
                                                {foreach $pages as $p}
                                                    <option value="{$p.id}" {if $menu->cont->href == $p.id} selected="selected" {/if} >{$p.title}</option>
                                                {/foreach}
                                            </select> 
                                        </div>
                                    </div>

                                    <div class="control-group">
                                        <label class="control-label" for="menu_cont">Редектор меню:</label>
                                        <div class="controls">
                                                <textarea style="height: 400px; width: 70% !important" name="menu_template">
{if !$menu->menu_template}
&lt;div class="menu_additional"&gt;
        #menu_contacts
        #menu_delivery
        #menu_payment
        &lt;span class="f_l telephones"&gt;
                +38-063-333-33-00
        &lt;/span&gt;
        #cart_data
        #wish_data
        #compare_data
&lt;/div&gt;
&lt;div class="c_b"&gt;&lt;/div&gt;
{else:}{echo $menu->menu_template}{/if}
                                                </textarea>
                                            <span class="help-block">
                                                <strong> #menu_contacts</strong> - Контакты 
                                            </span>
                                            <span class="help-block">
                                                <strong> #menu_delivery</strong> - Доставка
                                            </span>
                                            <span class="help-block">
                                                <strong> #menu_payment</strong> - Оплата
                                            </span>
                                            <span class="help-block">
                                                <strong> #cart_data</strong> - Данные о корзине
                                            </span>
                                            <span class="help-block">
                                                <strong> #wish_data</strong> - Данные о списке желаний
                                            </span>
                                            <span class="help-block">
                                                <strong> #compare_data</strong> - <span class="">Данные о сравнение товаров</span>
                                            </span>
                                            <span class="help-block">
                                                <strong> #tel_block</strong> - Шаблон с номером телефона
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    {form_csrf()}
                    </form>
                    </td>
                </tr>
            </tbody>
        </table>

    </section>
</div>
<section class="mini-layout">
    <div class="frame_title clearfix">
        <div class="pull-left">
            <span class="help-inline"></span>
            <span class="title">{lang("Edit menu item")}</span>
        </div>
        <div class="pull-right">
            <div class="d-i_b">
                <a href="/admin/components/cp/menu/menu_item/{$menu.name}" class="t-d_n m-r_15 pjax"><span class="f-s_14"></span>←<span class="t-d_u">{lang("Go back")}</span></a>
                <button type="button" class="btn btn-small btn-primary formSubmit submit_link" data-form="#{$item.item_type}_form" data-submit><i class="icon-ok"></i>{lang("Have been saved")}</button>
                <button type="button" class="btn btn-small formSubmit submit_link" data-form="#{$item.item_type}_form" data-action="tomain"><i class="icon-ok"></i>{lang("Save and go back")}</button>
            </div>
        </div>                            
    </div>
    <div class="row">
        <div class="span5">
            <ul class="btn-group myTab m-t_10 nav-tabs horiz link_type">
                <li class="btn btn-small {if $item.item_type == 'page'} active{/if}"><a href="#page">{lang("Page")}</a></li>
                <li class="btn btn-small {if $item.item_type == 'category'}active{/if}"><a href="#category">{lang("Categories")}</a></li>
                <li class="btn btn-small {if $item.item_type == 'module'}active{/if}"><a href="#module">{lang("Module")}</a></li>
                <li class="btn btn-small {if $item.item_type == 'url'}active{/if}"><a href="#url">{lang("Link")}</a></li>
            </ul>
        </div>
    </div>
    <div class="tab-content content_big_td form-horizontal">
        <div id="page" class="tab-pane {if $item.item_type == 'page'}active{/if}">
            <form method="post" action="/admin/components/cp/menu/edit_item/{$item.id}" id="page_form">
                {$data = unserialize($item.add_data)}
                <input type="hidden" name="menu_id" value="{$menu.id}"/>
                <input type="hidden" name="item_id" value="{$item.item_id}" id="item_page_id"/>
                <input type="hidden" name="page_item_type" value="page"/>
                <table class="table table-striped table-bordered table-hover table-condensed">
                    <thead>
                        <tr>
                            <th colspan="6">
                                {lang("Pages")}
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td colspan="6">
                                <div class="inside_padd">
                                    <div class="span12">
                                        <div class="control-group">
                                            <label class="control-label">{lang("Categories")}:</label>
                                            <div class="controls">
                                                <select id="category_sel">
                                                    <option value="0">{lang("Root")}</option>
                                                    {$sel = array()}
                                                    {echo build_cats_tree($cats, $sel)}
                                                </select>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label">На страницу:</label>
                                            <div class="controls">
                                                <select id="per_page">
                                                    <option value="10" selected="selected">10</option>
                                                    <option value="15">15</option>
                                                    <option value="20">20</option>
                                                    <option value="30">30</option>
                                                    <option value="40">40</option>
                                                    <option value="50">50</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label">Список страниц:</label>
                                            <div class="controls">
                                                <div id="pages_list_holder" class="span3">
                                                    <ul class="nav myTab nav-tabs nav-stacked">
                                                        {foreach $pages.pages_list as $p}
                                                            <li {if $item.item_id == $p.id}class="active"{/if}>
                                                                <a class="page_title" data-url="{$p.cat_url}/{$p.url}" data-title="{$p.title}" data-id="{$p.id}">{echo $p.title}</a>
                                                            </li>
                                                        {/foreach}
                                                    </ul>
                                                </div>
                                            </div>        
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <input type="hidden" id="owner_id" value="{$insert_id}" />
                <table class="table table-striped table-bordered table-hover table-condensed">
                    <thead>
                        <tr>
                            <th colspan="6">
                                Параметры:
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td colspan="6">
                                <div class="inside_padd">
                                    <div class="span12">
                                        <div class="control-group">
                                            <label class="control-label">{lang("Type")}:</label>
                                            <div class="controls">
                                                <span class="help-block">{lang("Page")}</span>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label">{lang("ID")}:</label>
                                            <div class="controls">
                                                <span id="page_id_holder" class="help-block">{$item.id}</span>
                                            </div>
                                        </div>    
                                        <div class="control-group">
                                            <label class="control-label">{lang("Title")}:</label>
                                            <div class="controls">
                                                <input type="text" value="{$item.title}" name="title"  id="item_title" />
                                            </div>
                                        </div>        
                                        <div class="control-group">
                                            <label class="control-label">{lang("Parent")}:</label>
                                            <div class="controls">
                                                <select name="page_parent_id" id="item_parent_id">
                                                    <option value="0">{lang("No")}</option>
                                                    {foreach $parents as $par}
                                                        <option value="{$par.id}" {if $item.parent_id != 0 AND $item.parent_id == $par.id}selected="selected"{/if}> - {$par.title}</option>
                                                    {/foreach}
                                                </select>
                                            </div>
                                        </div>            
                                        <div class="control-group">
                                            <label class="control-label">{lang("Position after")}:</label>
                                            <div class="controls">
                                                <select name="position_after" id="position_after">
                                                    <option value="0">{lang("No")}</option>
                                                    <option value="first">{lang("First")}</option>
                                                    {foreach $parents as $p}
                                                        <option value="{$p.id}" {if $item.position != 0 AND $item.postion == $p.postion}selected="selected"{/if}> - {$p.title}</option>
                                                    {/foreach}
                                                </select>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label" for="Img">
                                                {lang("Image")}:
                                            </label>
                                            <div class="controls">
                                                <div class="group_icon pull-right">            
                                                    <button class="btn btn-small" onclick="elFinderPopup('image', 'Img');return false;"><i class="icon-picture"></i>  {lang("Choose an image ")}</button>
                                                </div>
                                                <div class="o_h">		            
                                                    <input type="text" name="page_item_image" id="Img" value="{$item.item_image}">					
                                                </div>
                                            </div>
                                        </div>  
                                        <div class="control-group">
                                            <label class="control-label">{lang("Access level")}:</label>
                                            <div class="controls">
                                                {$r  = unserialize($item.roles)}
                                                {if !is_array($r)}
                                                    {$r = array()}
                                                {/if}
                                                <select id="item_roles" name="item_roles[]" multiple="multiple">
                                                    <option value="0">{lang("All")}</option>
                                                    {foreach $roles as $role}
                                                        <option value ="{$role.id}" {if in_array($role.id, $r)}selected="selected"{/if}>{$role.alt_name}</option>
                                                    {/foreach}
                                                </select>
                                            </div>
                                        </div>    
                                        <div class="control-group">
                                            <label class="control-label">{lang("Hide")}:</label>
                                            <div class="controls">
                                                <span class="frame_label no_connection m-r_15">
                                                    <span class="niceRadio">
                                                        <input type="radio" name="page_hidden" value="1" {if $item.hidden == 1}checked="checked"{/if}/>
                                                    </span> {lang("Yes")}
                                                </span>
                                                <span class="frame_label no_connection">
                                                    <span class="niceRadio">
                                                        <input type="radio" name="page_hidden" value="0" {if $item.hidden == 0}checked="checked"{/if}/>
                                                    </span>
                                                    {lang("No")}
                                                </span>
                                            </div>
                                        </div>            
                                        <div class="control-group">
                                            <label class="control-label">{lang("Open in the new window")}:</label>
                                            <div class="controls">
                                                <span class="m-r_15 frame_label no_connection">
                                                    <span class="niceRadio">
                                                        <input type="radio" name="page_newpage" value="1" {if $data.newpage == 1}checked="checked"{/if}/>
                                                    </span> {lang("Yes")}
                                                </span>
                                                <span class="frame_label no_connection">
                                                    <span class="niceRadio">
                                                        <input type="radio" name="page_newpage" value="0" {if $data.newpage == 0}checked="checked"{/if}/>
                                                    </span> {lang("No")}
                                                </span>
                                            </div>
                                        </div>    
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </form>
        </div>
        <div id="category" class="tab-pane {if $item.item_type == 'category'}active{/if}">
            <form method="post" action="/admin/components/cp/menu/edit_item/{$item.id}" id="category_form" >
                {$data = unserialize($item.add_data)}
                <input type="hidden" name="menu_id" value="{$menu.id}"/>
                <input type="hidden" name="item_id" value="{$item.item_id}" id="cat_input"/>
                <input type="hidden" name="cat_item_type" value="category"/>
                <table class="table table-striped table-bordered table-hover table-condensed">
                    <thead>
                        <tr>
                            <th colspan="6">
                                {lang("Pages")}
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td colspan="6">
                                <div class="inside_padd">
                                    <div class="span12">
                                        <div class="control-group">
                                            <label class="control-label">{lang("Choose a category")}:</label>
                                            <div class="controls">
                                                <ul>
                                                    {build_cats_tree_ul_li($cats, $item.item_id)}  
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <table class="table table-striped table-bordered table-hover table-condensed">
                    <thead>
                        <tr>
                            <th colspan="6">
                                Параметры:
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td colspan="6">
                                <div class="inside_padd">
                                    <div class="span12">
                                        <div class="control-group">
                                            <label class="control-label">{lang("Type")}:</label>
                                            <div class="controls">
                                                <span class="help-block">{lang("Categories")}</span>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label">{lang("ID")}:</label>
                                            <div class="controls">
                                                <span id="cat_id_holder" class="help-block">{$item.item_id}</span>
                                            </div>
                                        </div>    
                                        <div class="control-group">
                                            <label class="control-label">{lang("Title")}:</label>
                                            <div class="controls">
                                                <input type="text" value="{$item.title}" name="title"  id="item_cat_title" />
                                            </div>
                                        </div>        
                                        <div class="control-group">
                                            <label class="control-label">{lang("Parent")}:</label>
                                            <div class="controls">
                                                <select name="cat_parent_id" id="item_parent_id">
                                                    <option value="0">{lang("No")}</option>
                                                    {foreach $parents as $p}
                                                        <option value="{$p.id}" {if $item.parent_id != 0 AND $item.parent_id == $p.id}selected="selected"{/if}> - {$p.title}</option>
                                                    {/foreach}
                                                </select>
                                            </div>
                                        </div>            
                                        <div class="control-group">
                                            <label class="control-label">{lang("Position after")}:</label>
                                            <div class="controls">
                                                <select name="position_after" id="position_after">
                                                    <option value="0">{lang("No")}</option>
                                                    <option value="first">{lang("First")}</option>
                                                    {foreach $parents as $p}
                                                        <option value="{$p.id}" {if $item.position != 0 AND $item.postion == $p.postion}selected="selected"{/if}> - {$p.title}</option>
                                                    {/foreach}
                                                </select>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label" for="Img">
                                                {lang("Image")}:
                                            </label>
                                            <div class="controls">
                                                <div class="group_icon pull-right">            
                                                    <button class="btn btn-small" onclick="elFinderPopup('image', 'Img');return false;"><i class="icon-picture"></i>  {lang("Choose an image ")}</button>
                                                </div>
                                                <div class="o_h">		            
                                                    <input type="text" name="cat_item_image" id="Img" value="{$item.item_image}">					
                                                </div>
                                            </div>
                                        </div>  
                                        <div class="control-group">
                                            <label class="control-label">{lang("Access level")}:</label>
                                            <div class="controls">
                                                <select id="item_roles" name="item_roles[]" multiple="multiple">
                                                    <option value="0">{lang("All")}</option>
                                                    {foreach $roles as $role}
                                                        <option value ="{$role.id}" {if in_array($role.id, $r)}selected="selected"{/if}>{$role.alt_name}</option>
                                                    {/foreach}
                                                </select>
                                            </div>
                                        </div>    
                                        <div class="control-group">
                                            <label class="control-label">{lang("Hide")}:</label>
                                            <div class="controls">
                                                <span class="m-r_15 frame_label no_connection">
                                                    <span class="niceRadio">
                                                        <input type="radio" name="cat_hidden" value="1" {if $item.hidden == 1}checked="checked"{/if}/>
                                                    </span>
                                                    {lang("Yes")}
                                                </span>
                                                <span class="frame_label no_connection">
                                                    <span class="niceRadio">
                                                        <input type="radio" name="cat_hidden" value="0" {if $item.hidden == 0}checked="checked"{/if}/>
                                                    </span>
                                                    {lang("No")}
                                                </span>
                                            </div>
                                        </div>            
                                        <div class="control-group">
                                            <label class="control-label">{lang("Open in the new window")}:</label>
                                            <div class="controls">
                                                <span class="m-r_15">
                                                    <span class="frame_label no_connection">
                                                        <span class="niceRadio">
                                                            <input type="radio" name="cat_newpage" value="1" {if $data.newpage == 1}checked="checked"{/if}/>
                                                        </span>
                                                        {lang("Yes")}
                                                    </span>
                                                </span>
                                                <span class="frame_label no_connection">
                                                    <span class="niceRadio">
                                                        <input type="radio" name="cat_newpage" value="0" {if $data.newpage == 0}checked="checked"{/if}/>
                                                    </span>
                                                    {lang("No")}
                                                </span>
                                            </div>
                                        </div>    
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </form>
        </div>
        <div id="module" class="tab-pane {if $item.item_type == 'module'}active{/if}">
            <form method="post" action="/admin/components/cp/menu/edit_item/{$item.id}" id="module_form">
                <div class="m-t_20"><h4>{lang("Select or choose a module")}:</h4></div>
                <div class="row-fluid">
                    <div class="span3">
                        <input type="hidden" name="menu_id" value="{$menu.id}"/>
                        <input type="hidden" name="item_id" value="0" />
                        <input type="hidden" name="module_item_type" value="module"/>
                        <input type="hidden" name="mod_name" value="{$data.mod_name}"/>
                        <ul class="nav myTab nav-tabs nav-stacked">
                            {foreach $modules as $module}
                                <li><a href="#" class="module_item" data-mname="{$module.name}" id="module_{$module.name}" title="{$module.description}">{$module.menu_name}</a></li>
                            {/foreach}   
                        </ul>
                    </div>
                    <div class="span9">
                        <table class="table table-striped table-bordered table-hover table-condensed">
                            <thead>
                                <tr>
                                    <th colspan="6">
                                        Параметры:
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td colspan="6">
                                        <div class="inside_padd">
                                            <div class="span12">
                                                <div class="control-group">
                                                    <label class="control-label">{lang("Type")}:</label>
                                                    <div class="controls">
                                                        <span class="help-block">
                                                            {lang("Module")}
                                                        </span>
                                                    </div>
                                                </div>
                                                <div class="control-group">
                                                    <label class="control-label">{lang("Name")}:</label>
                                                    <div class="controls">
                                                        <span id="module_name_holder" class="help-block">{$data.mod_name}</span>
                                                    </div>
                                                </div>    
                                                <div class="control-group">
                                                    <label class="control-label">{lang("Title")}:</label>
                                                    <div class="controls">
                                                        <input type="text" value="{$item.title}" name="title"  id="module_item_title" />
                                                    </div>
                                                </div>
                                                <div class="control-group">
                                                    <label class="control-label">Функция:</label>
                                                    <div class="controls">
                                                        <input type="text" value="{$data.method}" name="mod_method"/>
                                                        <span class="help-inline">Например: func_name/param1/param2</span>
                                                    </div>
                                                </div>    
                                                <div class="control-group">
                                                    <label class="control-label">{lang("Parent")}:</label>
                                                    <div class="controls">
                                                        <select name="module_parent_id" id="item_parent_id">
                                                            <option value="0">{lang("No")}</option>
                                                            {foreach $parents as $p}
                                                                <option value="{$p.id}" {if $item.parent_id != 0 AND $item.parent_id == $p.id}selected="selected"{/if}> - {$p.title}</option>
                                                            {/foreach}
                                                        </select>
                                                    </div>
                                                </div>            
                                                <div class="control-group">
                                                    <label class="control-label">{lang("Position after")}:</label>
                                                    <div class="controls">
                                                        <select name="position_after" id="position_after">
                                                            <option value="0">{lang("No")}</option>
                                                            <option value="first">{lang("First")}</option>
                                                            {foreach $parents as $p}
                                                                <option value="{$p.id}" {if $item.position != 0 AND $item.postion == $p.postion}selected="selected"{/if}> - {$p.title}</option>
                                                            {/foreach}
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="control-group">
                                                    <label class="control-label" for="Img">
                                                        {lang("Image")}:
                                                    </label>
                                                    <div class="controls">
                                                        <div class="group_icon pull-right">            
                                                            <button class="btn btn-small" onclick="elFinderPopup('image', 'Img');return false;"><i class="icon-picture"></i>  {lang("Choose an image ")}</button>
                                                        </div>
                                                        <div class="o_h">		            
                                                            <input type="text" name="module_item_image" id="Img" value="{$item.item_image}">					
                                                        </div>
                                                    </div>
                                                </div>  
                                                <div class="control-group">
                                                    <label class="control-label">{lang("Access level")}:</label>
                                                    <div class="controls">
                                                        <select id="item_roles" name="item_roles[]" multiple="multiple">
                                                            <option value="0">{lang("All")}</option>
                                                            {foreach $roles as $role}
                                                                <option value ="{$role.id}" {if in_array($role.id, $r)}selected="selected"le{/if}>{$role.alt_name}</option>
                                                            {/foreach}
                                                        </select>
                                                    </div>
                                                </div>    
                                                <div class="control-group">
                                                    <label class="control-label">{lang("Hide")}:</label>
                                                    <div class="controls">
                                                        <span class="m-r_15">
                                                            <span class="frame_label no_connection">
                                                                <span class="niceRadio">
                                                                    <input type="radio" name="module_hidden" value="1" {if $item.hidden == 1}checked="checked"{/if}/>
                                                                </span>
                                                            </span>
                                                            {lang("Yes")}
                                                        </span>
                                                        <span class="frame_label no_connection">
                                                            <span class="niceRadio">
                                                                <input type="radio" name="module_hidden" value="0" {if $item.hidden == 0}checked="checked"{/if}/>
                                                            </span>
                                                            {lang("No")}
                                                        </span>
                                                    </div>
                                                </div>            
                                                <div class="control-group">
                                                    <label class="control-label">{lang("Open in the new window")}:</label>
                                                    <div class="controls">
                                                        <span class="m-r_15">
                                                            <span class="frame_label no_connection">
                                                                <span class="niceRadio">
                                                                    <input type="radio" name="module_newpage" value="1" {if $data.newpage == 1}checked="checked"{/if}/>
                                                                </span>
                                                                {lang("Yes")}
                                                            </span>
                                                        </span>
                                                        <span class="frame_label no_connection">
                                                            <span class="niceRadio">
                                                                <input type="radio" name="module_newpage" value="0" {if $data.newpage == 0}checked="checked"{/if}/>
                                                            </span>
                                                            {lang("No")}
                                                        </span>
                                                    </div>
                                                </div>    
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </form>
        </div>
        <div id="url" class="tab-pane {if $item.item_type == 'url'}active{/if}">
            <form method="post" action="/admin/components/cp/menu/edit_item/{$item.id}" id="url_form" >
                <input type="hidden" name="menu_id" value="{$menu.id}">
                <input type="hidden" name="item_id" value="0"/>
                <input type="hidden" name="url_item_type" value="url"/>
                <table class="table table-striped table-bordered table-hover table-condensed">
                    <thead>
                        <tr>
                            <th colspan="6">
                                {lang("URL")}
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td colspan="6">
                                <div class="inside_padd">
                                    <div class="span12">
                                        <div class="control-group">
                                            <label class="control-label">{lang("Specify or select a link to the page")}:</label>
                                            <div class="controls">
                                                <input type="text" id="url_to_page" value="{echo $data.url}" name="item_url"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <table class="table table-striped table-bordered table-hover table-condensed">
                    <thead>
                        <tr>
                            <th colspan="6">
                                {lang("Settings")}:
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td colspan="6">
                                {$r = unserialize($item.roles)}
                                <div class="inside_padd">
                                    <div class="span12">
                                        <div class="control-group">
                                            <label class="control-label">{lang("Title")}:</label>
                                            <div class="controls">
                                                <input type="text" value="{$item.title}" name="title"  id="item_title" />
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label">{lang("Parent")}:</label>
                                            <div class="controls">
                                                <select name="url_parent_id" id="item_parent_id">
                                                    <option value="0">{lang("No")}</option>
                                                    {foreach $parents as $p}
                                                        <option value="{$p.id}" {if $item.parent_id != 0 AND $item.parent_id == $p.parent_id}selected="selected"{/if}> - {$p.title}</option>
                                                    {/foreach}
                                                </select>
                                            </div>
                                        </div>            
                                        <div class="control-group">
                                            <label class="control-label">{lang("Position after")}:</label>
                                            <div class="controls">
                                                <select name="position_after" id="position_after">
                                                    <option value="0">{lang("No")}</option>
                                                    <option value="first">{lang("First")}</option>
                                                    {foreach $parents as $p}
                                                        <option value="{$p.id}" {if $item.position != 0 AND $item.postion == $p.postion}selected="selected"{/if}> - {$p.title}</option>
                                                    {/foreach}
                                                </select>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label class="control-label" for="Img">
                                                {lang("Image")}:
                                            </label>
                                            <div class="controls">
                                                <div class="group_icon pull-right">            
                                                    <button class="btn btn-small" onclick="elFinderPopup('image', 'Img');return false;"><i class="icon-picture"></i>  {lang("Choose an image ")}</button>
                                                </div>
                                                <div class="o_h">		            
                                                    <input type="text" name="url_item_image" id="Img" value="{$item.item_image}">					
                                                </div>
                                            </div>
                                        </div>  
                                        <div class="control-group">
                                            <label class="control-label">{lang("Access level")}:</label>
                                            <div class="controls">
                                                <select id="item_roles" name="item_roles[]" multiple="multiple">
                                                    <option value="0">{lang("All")}</option>
                                                    {foreach $roles as $role}
                                                        <option value ="{$role.id}" {if @in_array($role.id, $r)}selected="selected"{/if}>{$role.alt_name}</option>
                                                    {/foreach}
                                                </select>
                                            </div>
                                        </div>    
                                        <div class="control-group">
                                            <label class="control-label">{lang("Hide")}:</label>
                                            <div class="controls">
                                                <span class="m-r_15">
                                                    <span class="frame_label no_connection">
                                                        <span class="niceRadio">
                                                            <input type="radio" name="url_hidden" value="1" {if $item.hidden == 1}checked="checked"{/if}/>
                                                        </span>
                                                        {lang("Yes")}
                                                    </span>
                                                </span>
                                                <span class="frame_label no_connection">
                                                    <span class="niceRadio">
                                                        <input type="radio" name="url_hidden" value="0" {if $item.hidden == 0}checked="checked"{/if}/>
                                                    </span>
                                                    {lang("No")}
                                                </span>
                                            </div>
                                        </div>            
                                        <div class="control-group">
                                            <label class="control-label">{lang("Open in the new window")}:</label>
                                            <div class="controls">
                                                <span class="m-r_15">
                                                    <span class="frame_label no_connection">
                                                        <span class="niceRadio">
                                                            <input type="radio" name="url_newpage" value="1" {if $data.newpage == 1}checked="checked"{/if}/>
                                                        </span>
                                                        {lang("Yes")}
                                                    </span>
                                                </span>
                                                <span class="frame_label no_connection">
                                                    <span class="niceRadio">
                                                        <input type="radio" name="url_newpage" value="0" {if $data.newpage == 0}checked="checked"{/if}/>
                                                    </span>
                                                    {lang("No")}
                                                </span>
                                            </div>
                                        </div>    
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </form>
        </div>
    </div> 
</section>
<div id="elFinder"></div>
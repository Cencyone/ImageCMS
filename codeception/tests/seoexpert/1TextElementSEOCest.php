<?php

use \SeoExpertTester;
class TextElementSEOCest

{
    
//---------------------------AUTORIZATION--------------------------------------- 
    /**
     * @group a
     */
    public function Login(SeoExpertTester $I){
        InitTest::Login($I);
    }
    
    
    /**
     * @group a
     */
    public function VerifyTextBasePage (SeoExpertTester $I){
       $I->amOnPage(seoexpertPage::$SeoUrl);
       $I->see('SEO эксперт', seoexpertPage::$SeoTitle);
       $I->see('Вернуться', seoexpertPage::$SeoButtBack);
       $I->see('Сохранить', seoexpertPage::$SeoButtSave);
       $I->see('Основные', seoexpertPage::$SeoButtBase);
       $I->see('Магазин', seoexpertPage::$SeoButtShop);
       $I->see('Мета-теги', '//div[1]/div[5]/section/form/div[2]/div[1]/table[1]/thead/tr/th');
       $I->see('Название сайта:', '//table[1]/tbody/tr/td/div/div/div/div[1]/label');
       $I->see('Будет ли отображаться название сайта в заголовке страницы', '//table[1]/tbody/tr/td/div/div/div/div[1]/div/span');
       $I->see('Да', '//table[1]/tbody/tr/td/div/div/div/div[1]/div/div/span[1]');
       $I->see('Нет', '//tbody/tr/td/div/div/div/div[1]/div/div/span[2]');
       $I->see('Добавить название категории страницы:', '//table[1]/tbody/tr/td/div/div/div/div[2]/label');
       $I->see('Да', '//tbody/tr/td/div/div/div/div[2]/div/div/span[1]');
       $I->see('Нет', '//tbody/tr/td/div/div/div/div[2]/div/div/span[2]');
       $I->see('Будет ли отображаться название категории страницы в title страницы', '//table[1]/tbody/tr/td/div/div/div/div[2]/div/span');
       $I->see('Разделительный знак:', '//table[1]/tbody/tr/td/div/div/div/div[3]/label');
       $I->see('Meta Keywords:', '//table[1]/tbody/tr/td/div/div/div/div[4]/label');
       $I->see('Если не указаны', '//table[1]/tbody/tr/td/div/div/div/div[4]/div/span');
       $I->see('Meta Description:', '//table[1]/tbody/tr/td/div/div/div/div[5]/label');
       $I->see('Если не указано', '//table[1]/tbody/tr/td/div/div/div/div[5]/div/span');
       $I->see('Название сайта:', '//table[2]/tbody/tr/td/div/div/div/div/div[1]/label');
       $I->see('Краткое название сайта:', '//tbody/tr/td/div/div/div/div/div[2]/label');
       $I->see('Описание:', '//tbody/tr/td/div/div/div/div/div[3]/label');
       $I->see('Ключевые слова:', '//tbody/tr/td/div/div/div/div/div[4]/label');
    }
    
    
    
    /**
     * @group a
     */
    public function VerifyTextShopProductPage (SeoExpertTester $I){
        $I->amOnPage(seoexpertPage::$SeoUrl);
        $I->wait('1');
        $I->click(seoexpertPage::$SeoButtShop);
        $I->wait('1');
        $I->see('Страница продукта [ru]', seoexpertPage::$SeoProductBlockTitle);
        $I->see('Meta-title:', '//table/tbody/tr[1]/td/div/div/label[1]/span[1]');
        $I->see('Meta-description:', '//table/tbody/tr[1]/td/div/div/label[2]/span[1]');
        $I->see('Длина описания:', '//tbody/tr[1]/td/div/div/label[3]/span[1]');
        $I->see('Meta-keywords:', '//tbody/tr[1]/td/div/div/label[4]/span[1]');
        $I->see('Активный:', '//section/form/div[2]/div[2]/table[1]/tbody/tr/td/div/div/div[1]/div/span[1]');
        $I->see('Использовать только для пустых метаданных:', '//section/form/div[2]/div[2]/table[1]/tbody/tr/td/div/div/div[2]/div/span[1]');
        $I->see('Дополнительные настройки для товаров в категории', seoexpertPage::$SeoProductButtAdvanced);
    }
    
    

    
    /**
     * @group a
     */
    public function VerifyTextShopCategoryPage (SeoExpertTester $I){
        $I->amOnPage(seoexpertPage::$SeoUrl);
        $I->wait('1');
        $I->click(seoexpertPage::$SeoButtShop);
        $I->wait('1');
        $I->see('Категория [ru]', seoexpertPage::$SeoCategoryBlockTitle);
        $I->see('Meta-title:', '//section/form/div[2]/div[2]/table[2]/tbody/tr/td/div/div/label[1]/span[1]');
        $I->see('Meta-description:', '//section/form/div[2]/div[2]/table[2]/tbody/tr/td/div/div/label[2]/span[1]');
        $I->see('Длина описания:', '//section/form/div[2]/div[2]/table[2]/tbody/tr/td/div/div/label[3]/span[1]');
        $I->see('Количество брендов:', '//section/form/div[2]/div[2]/table[2]/tbody/tr/td/div/div/label[4]/span[1]');
        $I->see('Meta-keywords:', '//section/form/div[2]/div[2]/table[2]/tbody/tr/td/div/div/label[5]/span[1]');
        $I->see('Уникализация страниц пагинации:', '//section/form/div[2]/div[2]/table[2]/tbody/tr/td/div/div/label[6]/span[1]');
        $I->see('Активный:', '//section/form/div[2]/div[2]/table[2]/tbody/tr/td/div/div/div[1]/div/span[1]');
        $I->see('Использовать только для пустых метаданных:', '//section/form/div[2]/div[2]/table[2]/tbody/tr/td/div/div/div[2]/div/span[1]');
    }
    
    
    /**
     * @group a
     */
    public function VerifyTextShopSubcategoryPage (SeoExpertTester $I){
        $I->amOnPage(seoexpertPage::$SeoUrl);
        $I->wait('1');
        $I->click(seoexpertPage::$SeoButtShop);
        $I->wait('1');
        $I->see('Подкатегория [ru]', seoexpertPage::$SeoSubCatBlockTitle);
        $I->see('Meta-title:', '//section/form/div[2]/div[2]/table[3]/tbody/tr/td/div/div/label[1]/span[1]');
        $I->see('Meta-description:', '//section/form/div[2]/div[2]/table[3]/tbody/tr/td/div/div/label[2]/span[1]');
        $I->see('Длина описания:', '//section/form/div[2]/div[2]/table[3]/tbody/tr/td/div/div/label[3]/span[1]');
        $I->see('Количество брендов:', '//section/form/div[2]/div[2]/table[3]/tbody/tr/td/div/div/label[4]/span[1]');
        $I->see('Meta-keywords:', '//section/form/div[2]/div[2]/table[3]/tbody/tr/td/div/div/label[5]/span[1]');
        $I->see('Уникализация страниц пагинации:', '//section/form/div[2]/div[2]/table[3]/tbody/tr/td/div/div/label[6]/span[1]');
        $I->see('Активный:', '//section/form/div[2]/div[2]/table[3]/tbody/tr/td/div/div/div[1]/div/span[1]');
        $I->see('Использовать только для пустых метаданных:', '//section/form/div[2]/div[2]/table[3]/tbody/tr/td/div/div/div[2]/div/span[1]');
    }    
    
    
    
    /**
     * @group a
     */
    public function VerifyTextShopBrandsPage (SeoExpertTester $I){
        $I->amOnPage(seoexpertPage::$SeoUrl);
        $I->wait('1');
        $I->click(seoexpertPage::$SeoButtShop);
        $I->wait('1');
        $I->see('Бренды [ru]', seoexpertPage::$SeoBrandBlockTitle);
        $I->see('Meta-title:', '//section/form/div[2]/div[2]/table[4]/tbody/tr/td/div/div/label[1]/span[1]');
        $I->see('Meta-description:', '//section/form/div[2]/div[2]/table[4]/tbody/tr/td/div/div/label[2]/span[1]');
        $I->see('Уникализация страниц пагинации:', '//section/form/div[2]/div[2]/table[4]/tbody/tr/td/div/div/label[3]/span[1]');
        $I->see('Длина описания:', '//section/form/div[2]/div[2]/table[4]/tbody/tr/td/div/div/label[4]/span[1]');
        $I->see('Meta-keywords:', '//section/form/div[2]/div[2]/table[4]/tbody/tr/td/div/div/label[5]/span[1]');
        $I->see('Активный:', '//section/form/div[2]/div[2]/table[4]/tbody/tr/td/div/div/div[1]/div/span[1]');
        $I->see('Использовать только для пустых метаданных:', '//section/form/div[2]/div[2]/table[4]/tbody/tr/td/div/div/div[2]/div/span[1]');       
    }
    
    
    /**
     * @group a
     */
    public function VerifyTextShopSearchPage (SeoExpertTester $I){
        $I->amOnPage(seoexpertPage::$SeoUrl);
        $I->wait('1');
        $I->click(seoexpertPage::$SeoButtShop);
        $I->wait('1');
        $I->see('Поиск [ru]', seoexpertPage::$SeoSearchBlockTitle);
        $I->see('Meta-title:', '//section/form/div[2]/div[2]/table[5]/tbody/tr/td/div/div/label[1]/span[1]');
        $I->see('Meta-description:', '//section/form/div[2]/div[2]/table[5]/tbody/tr/td/div/div/label[2]/span[1]');
        $I->see('Meta-keywords:', '//section/form/div[2]/div[2]/table[5]/tbody/tr/td/div/div/label[3]/span[1]');
        $I->see('Активный:', '//section/form/div[2]/div[2]/table[5]/tbody/tr/td/div/div/div/div/span[1]');
    }
    
    
    
    
    /**
     * @group a
     */
    public function VerifyTextAdvancedCreatePage (SeoExpertTester $I){
        $I->amOnPage(seoexpertPage::$SeoUrl);
        $I->wait('1');
        $I->click(seoexpertPage::$SeoButtShop);
        $I->wait('1');
        $I->click(seoexpertPage::$SeoProductButtAdvanced);
        $I->wait('1');
        $I->click(seoexpertPage::$SeoAdvencedButtAddCategory);
        $I->wait('1');
        $I->see('Создание метаданных для категории', '//body/div[1]/div[5]/section/div/div[1]/span[2]');
        $I->see('Вернуться', '//body/div[1]/div[5]/section/div/div[2]/div/a/span[2]');
        $I->see('Сохранить', '//body/div[1]/div[5]/section/div/div[2]/div/button');
        $I->see('Выбрать категорию:', '//body/div[1]/div[5]/section/form/table/tbody/tr/td/div/div/label[1]/span[1]');
        $I->see('Meta-title:', '//body/div[1]/div[5]/section/form/table/tbody/tr/td/div/div/label[2]/span[1]');
        $I->see('Meta-description:', '//body/div[1]/div[5]/section/form/table/tbody/tr/td/div/div/label[3]/span[1]');
        $I->see('Длина описания:', '//body/div[1]/div[5]/section/form/table/tbody/tr/td/div/div/label[4]/span[1]');
        $I->see('Meta-keywords:', '//tbody/tr/td/div/div/label[5]/span[1]');
        $I->see('Активный:', '//tbody/tr/td/div/div/div[1]/div/span[1]');
        $I->see('Использовать только для пустых метаданных:', '//table/tbody/tr/td/div/div/div[2]/div/span[1]');
    }
    
    
    
    
    /**
     * @group a
     * @guy SeoExpertTester\seoexpertSteps 
     */
    public function VerifyTextAdvancedEditPage(SeoExpertTester\seoexpertSteps $I) {
        $NameCategory = 'Для Сео Експерта';
        $I->SeoCreateCategoryProduct($createNameCategory ='Для Експерта');
        $I->amOnPage(seoexpertPage::$SeoUrl);
        $I->wait('1');
        $I->click(seoexpertPage::$SeoButtShop);
        $I->wait('1');
        $I->click(seoexpertPage::$SeoProductButtAdvanced);
        $I->wait('1');
        $I->click(seoexpertPage::$SeoAdvencedButtAddCategory);
        $I->wait('1');
        $I->fillField(seoexpertPage::$SeoCreatePageFieldCategory, 'Для Експерта');
        $I->wait('2');
        $I->click(seoexpertPage::$SeoCreatePageSelectCategory);
        $I->click(seoexpertPage::$SeoCreatePageButtSave);
        $I->wait('1');
        $ListNameCategory = $I->grabTextFrom(seoexpertPage::$SeoAdvencedLinkCategory);
        $I->comment("Такое название первой категории $ListNameCategory");
        $I->wait('3');
        $AmountRows = $I->grabTagCount($I, 'tbody tr');
         $I->comment("Количество строк $AmountRows");
        if($ListNameCategory == $NameCategory){
            $I->click(seoexpertPage::$SeoAdvencedLinkCategory);
            $I->see("Редактирование метаданных категории $NameCategory", seoexpertPage::$SeoEditPageTitle);  
            $I->see('Вернуться', seoexpertPage::$SeoEditPageButtBack);    
            $I->see('Сохранить и выйти', seoexpertPage::$SeoEditPageButtSaveAndBack);            
        }
        elseif($ListNameCategory != $NameCategory) {
            for($j = 1;$j < $AmountRows;$j++){
                $a = $I->grabTextFrom("//body/div[1]/div[5]/section/table/tbody/tr[$j]/td[2]/a"); 
                $I->comment(" вот вот вот $a");
                    if($a == $NameCategory){
                    $I->click("//body/div[1]/div[5]/section/table/tbody/tr[$j]/td[2]/a");
                    $I->wait('1');
                    $I->see("Редактирование метаданных категории $NameCategory", seoexpertPage::$SeoEditPageTitle);  
                    $I->see('Вернуться', seoexpertPage::$SeoEditPageButtBack);
                    $I->see('Сохранить и выйти', seoexpertPage::$SeoEditPageButtSaveAndBack);
                    break;
                    } 
            }
        }
    }
    
    
    
    
    /**
     * @group a
     */
    public function VerifyTextAdvancedPage (SeoExpertTester $I){
        $I->amOnPage(seoexpertPage::$SeoUrl);
        $I->wait('1');
        $I->click(seoexpertPage::$SeoButtShop);
        $I->wait('1');
        $I->click(seoexpertPage::$SeoProductButtAdvanced);
        $I->wait('1');
        $I->see('Вернуться', seoexpertPage::$SeoAdvencedButtBack);
//        $I->see('Удалить', '//body/div[1]/div[5]/section/div/div[2]/div/a[2]');
        $I->see('Добавить новую категорию', '//body/div[1]/div[5]/section/div/div[2]/div/a[3]');
        $I->see('Имя категории', '//body/div[1]/div[5]/section/table/thead/tr/th[2]');
        $I->see('Активный', '//body/div[1]/div[5]/section/table/thead/tr/th[3]');
        $I->see('Использовать только для пустых метаданных', '//body/div[1]/div[5]/section/table/thead/tr/th[4]');
    }
    
    
    /**
     * @group a
     */
    public function VerifyTextDeleteWindow(SeoExpertTester $I) {
        $I->amOnPage(seoexpertPage::$SeoUrl);
        $I->wait('1');
        $I->click(seoexpertPage::$SeoButtShop);
        $I->wait('1');
        $I->click(seoexpertPage::$SeoProductButtAdvanced);
        $I->wait('1');
        $I->click(seoexpertPage::$SeoAdvencedChekBoxMain);
        $I->click(seoexpertPage::$SeoAdvencedButtDelete);
        $I->wait('1');
        $I->see('Удалить категории', seoexpertPage::$SeoAdvencedDeleteWindowTitle);
        $I->see('Действительно хотите удалить выбранные категории?', seoexpertPage::$SeoAdvencedDeleteWindowMessage);
        $I->see('Удалить', seoexpertPage::$SeoAdvencedDeleteWindowButtDelete);
        $I->see('Отменить', seoexpertPage::$SeoAdvencedDeleteWindowButtCancel);
        $I->see('×', seoexpertPage::$SeoAdvencedDeleteWindowButtX);
        $I->click(seoexpertPage::$SeoAdvencedDeleteWindowButtX);
        $I->wait('1');
        $I->seeInCurrentUrl('/admin/components/init_window/mod_seo/productsCategories');
        $I->click(seoexpertPage::$SeoAdvencedButtDelete);
        $I->wait('1');
        $I->click(seoexpertPage::$SeoAdvencedDeleteWindowButtCancel);
        $I->wait('1');
        $I->dontSeeElement('//body/div[1]/div[5]/div');
    }
    
    
    /**
     * @group a
     */
    public function VerifytDeletingCategory(SeoExpertTester $I) {
        $I->amOnPage(seoexpertPage::$SeoUrl);
        $I->wait('1');
        $I->click(seoexpertPage::$SeoButtShop);
        $I->wait('1');
        $I->click(seoexpertPage::$SeoProductButtAdvanced);
        $I->wait('1');
        $I->click(seoexpertPage::$SeoAdvencedChekBoxMain);
        $I->click(seoexpertPage::$SeoAdvencedButtDelete);
        $I->wait('1');
        $I->click(seoexpertPage::$SeoAdvencedDeleteWindowButtDelete);
        $I->wait('1');
        $I->dontSee('Для Експерта');
        $I->see('Список пуст', '//body/div[1]/div[5]/section/div[2]');
    }
          
   /**
     * @group a
     * @guy SeoExpertTester\seoexpertSteps 
     */
    public function DeleteCategoryForTests(SeoExpertTester\seoexpertSteps $I) {
        $I->DeleteProductCategorys();
    }
    
    
    
    
}
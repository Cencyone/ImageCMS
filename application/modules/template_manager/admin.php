<?php

(defined('BASEPATH')) OR exit('No direct script access allowed');

/**
 * Image CMS 
 * tenplate Manager Module Admin
 */
class Admin extends BaseAdminController {

    public $errors = array();

    public function __construct() {
        parent::__construct();
    }

    public function index() {
        if ($_POST) {
            $error = '';
            if (isset($_POST['upload_template'])) { // UPLOAD TEMPLATE FROM PC OR BY URL
                try {
                    $this->upload();
                } catch (\Exception $e) {
                    $error = $e->getMessage();
                }
            } elseif (isset($_POST['install_template'])) { // INSTALL TEMPLATE
                $template = new \template_manager\classes\Template($_POST['template_name']);
                if ($template->isValid()) {
                    return \template_manager\classes\TemplateManager::getInstance()->setTemplate($template);
                } else {
                    $error = 'Template is broken';
                }
            } else { // SETTING SOME PARAMS
                $handlerComponent = $this->input->post('handler');
                $template->getComponent($handlerComponent)->setParams();
            }
        }

        $templateName = $this->db->get('settings')->row()->site_template;
        $template = new \template_manager\classes\Template($templateName);
        \CMSFactory\assetManager::create()
                ->registerStyle('style_admin')
                ->registerScript('script_admin')
                ->setData(array('template' => $template, 'error' => $error))
                ->renderAdmin('main');
    }

    public function templates() {
        $templates = \template_manager\classes\TemplateManager::getInstance()->listLocal();
        \CMSFactory\assetManager::create()->setData(array('template' => $templates))->renderAdmin('list');
    }

    public function install() {
        $templateToInstall = 'newLevelCart';
        $template = new \template_manager\classes\Template($templateToInstall);
        $status = FALSE;
        if ($template->isValid()) {
            $status = \template_manager\classes\TemplateManager::getInstance()->setTemplate($template);
            $this->cache->delete_all();
        } else {
            $status = 'Template is broken';
        }
        var_dump($status);
    }

    /**
     * 
     * @param string $url
     * @return boolan|string хиба якщо помилка, назва шаблону якшо все ок
     */
    private function upload() {
        if (!empty($_POST['template_url']) || !empty($_FILES['template_file'])) {
            if (!empty($_POST['template_url'])) {
                $zipPath = $this->uploadByUrl($_POST['template_url']);
            } else {
                $zipPath = $this->uploadFromPc('template_file');
            }
            // розпакувати шаблон
            if (TRUE == \template_manager\classes\TemplateManager::getInstance()->unpack($zipPath)) {
                return TRUE;
            } else {
                throw new Exception('Error while unpacking');
            }
        }
        throw new Exception('No input data specified');
    }

    /**
     * 
     * @return boolean|string хиба, або шлях до файлу
     */
    private function uploadByUrl($url) {
        $fullName = array_pop(explode('/', $url));
        $nameArray = explode('.', $fullName);
        $ext = array_pop($nameArray);
        $name = count($nameArray) > 1 ? implode('.', $nameArray) : $nameArray[0];

        if ($ext == 'zip') {
            $fullPath = './uploads/templates/' . $name . '.zip';
            if (file_put_contents($fullPath, file_get_contents($url)) > 0) {
                return $fullPath;
            }
        } else {
            throw new Exception('Wrong file type');
        }
    }

    /**
     * 
     * @return boolean|string хиба, або шлях до файлу
     */
    private function uploadFromPc($fieldName) {
        $this->load->library('upload', array(
            'upload_path' => './uploads/templates/',
            'allowed_types' => 'zip',
            'max_size' => 1024 * 10, // 10 Mb
            'file_name' => $_FILES[$fieldName]['name'],
        ));
        $destination = './uploads/templates/' . $_FILES[$fieldName]['name'];
        if (file_exists($destination)) {
            unlink($destination);
        }
        if (!$this->upload->do_upload($fieldName)) {
            throw new Exception($this->upload->display_errors());
        } else {
            $data = $this->upload->data();
            return $data['full_path'];
        }
    }

}
<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

//error_reporting(0);

class Sys_update extends BaseAdminController {

    private $upgrade_server = 'http://imagecms.net/upgrades/';

    public function __construct() {
        parent::__construct();

        $this->load->library('lib_admin');
        $this->lib_admin->init_settings();
    }

    public function index() {
        // Show upgrade window;
        $a = new Update();
        $old = $a->getOldMD5File();
        $array = $a->parse_md5();
//        var_dump($array);
//        var_dump($old);
        $diff = array_diff($array, $old);
        var_dump($diff);
        $a->add_to_ZIP($diff);
//        var_dump(write_file('md5.txt', json_encode($a->parse_md5())));
//        echo json_encode($a->parse_md5());
//        $a->formXml();
//        $a->sendData();
        $this->template->show('sys_update', FALSE);
    }

}

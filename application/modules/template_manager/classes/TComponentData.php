<?php

namespace template_manager\classes;

(defined('BASEPATH')) OR exit('No direct script access allowed');

/**
 * 
 *
 * @author kolia
 */
class TComponentData { // TLicense

    const KEY_FILE_NAME = 'tlicense.key';
    const TYPE_NONE = -1;
    const TYPE_FREE = 0;
    const TYPE_PAID = 1;

    private $licenseType;

    public function __construct($templateName) {
        $keyPath = PUBPATH . "templates/$templateName/" . self::KEY_FILE_NAME;
        $keyPath = str_replace(array('\\', '//'), DIRECTORY_SEPARATOR, $keyPath);

        if (file_exists($keyPath)) {
            $this->licenseType = self::TYPE_NONE;
        }

        $curKey = file_get_contents($keyPath);

        if ($curKey == self::generateKey($templateName, $_SERVER['HTTP_HOST'], self::TYPE_FREE)) {
            $this->licenseType = self::TYPE_FREE;
            return;
        }

        if ($curKey == self::generateKey($templateName, $_SERVER['HTTP_HOST'], self::TYPE_PAID)) {
            $this->licenseType = self::TYPE_PAID;
            return;
        }

        $this->licenseType = self::TYPE_NONE;
    }

    public function checkLicense() {
//        if (self::isLocal()) {
//            return true;
//        }
        return $this->licenseType != self::TYPE_NONE ? true : false;
    }

    public function getLicenseType() {
        return $this->licenseType;
    }

    private static function isLocal() {
        switch (substr($_SERVER['SERVER_ADDR'], 0, strrpos($_SERVER['SERVER_ADDR'], '.'))) {
            case '127.0.0':
            case '127.0.1':
            case '10.0.0':
            case '172.16.0':
            case '192.168.0':
                return true;
        }

        if (strtolower(array_pop(explode('.', $_SERVER['HTTP_HOST']))) === 'loc') {
            return true;
        }

        return false;
    }

    private static function generateKey($templateName, $domain, $type) {
        if ($type == self::TYPE_PAID) { // paid
            $dummy = 'fpnsdg97f-p43279gr9g974';
        } else { // free
            $dummy = '0347y087fg0e87f4fgy9f7r';
        }
        $key = $templateName . $domain . $dummy;
        // changing some valid symbols to "unlawful" for domain names
        $key = str_replace(array('e', 'y', 'u', 'i', 'o', 'a'), array('@', '%', '$', '^', '&', '!'), $key);
        $key = sha1($key);
        $key = array_reverse(str_split($key));
        $key = base64_encode(implode("", $key));
        return $key;
    }

}

?>
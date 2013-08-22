<?php

/**
 * ImageCMS System Update Class
 * @copyright ImageCMS(c) 2013
 * @version 0.1 big start
 */
class Update {

    private $arr_files;
    private $files_dates = array();
    private $restore_files = array();

    /**
     * path to update server
     * @var string
     */
    private $pathUS = "http://pftest.imagecms.net/application/modules/shop/admin/UpdateService.wsdl";

    /**
     * шлях до сканування папок
     * @var string
     */
    public $path_parse;

    /**
     * назва папки з обновленням відносно корня сайту
     * @var string
     */
    public $update_directory = 'update';

    /**
     * папки, які не враховувати при обновлені
     * @var array
     */
    private $distinctDirs = array(
        '.',
        '..',
        '.git',
        'uploads',
        'cache',
        'templates',
        'tests',
        'captcha',
        'nbproject',
        'uploads_site',
        'backups',
    );

    /**
     * файли, які не враховувати при обновлені
     * @var array
     */
    private $distinctFiles = array(
        'product.php',
        'category.php',
        'brand.php',
        'cart.php',
        'md5.txt',
        '.htaccess',
        'config.php'
    );

    /**
     * назва архіву і папки з скачаним старим текущим релізом в оригіналі
     * @var string
     */
    public $old_reliz = 'old_relith';

    /**
     * назва архіву і папки з скачаним обновленням
     * @var string
     */
    public $update_file = 'update_file';

    /**
     * назва папки з обєднаними файлами
     * @var string
     */
    public $marge_file = 'marge_file';

    /**
     * шлях до архіву з обновленням
     * @var string
     */
    public $path_update = '';

    /**
     * шлях до архіву старого релізу
     * @var string
     */
    public $path_old_reliz = '';

    /**
     * instance of ci
     * @var CI
     */
    public $ci;

    public function __construct() {
        $this->ci = &get_instance();
    }

    /**
     * check for new version exist
     */
    public function checkForVersion($modulName = 'reliz') {

        $xml_data = json_encode(array('somevar' => 'data', 'anothervar' => 'data'));

        $url = 'http://pftest.imagecms.net/shop/test';

        $headers = array(
            "Content-type: text/xml;charset=\"utf-8\"",
            "Accept: text/xml",
            "Cache-Control: no-cache",
            "Pragma: no-cache",
            "Authorization: Basic " . base64_encode($credentials)
        );

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_TIMEOUT, 60);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
        curl_setopt($ch, CURLOPT_USERAGENT, $defined_vars['HTTP_USER_AGENT']);

        // Apply the XML to our curl call
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $xml_data);

        $data = curl_exec($ch);
        curl_close($ch);

        if (curl_errno($ch)) {
            print "Error: " . curl_error($ch);
        } else {
            // Show me the result
            var_dump($data);
        }
    }

    /**
     * send php auth data to server
     */
    public function sendData() {
        $credentials = "username1:password1";

        // Read the XML to send to the Web Service
//        $request_file = "./SampleRequest.xml";
//        $fh = fopen($request_file, 'r');
//        $xml_data = fread($fh, filesize($request_file));
        $xml_data = 'asdasdasgrant_type=authorization_code';
//        fclose($fh);

        $url = 'http://pftest.imagecms.net/shop/test';
        $page = "/services/calculation";
        $headers = array(
            "POST " . $page . " HTTP/1.0",
            "Content-type: text/xml/file;charset=\"utf-8\"",
            "Accept: text/xml",
            "Cache-Control: no-cache",
            "Pragma: no-cache",
//            "SOAPAction: \"run\"",
//            "Content-length: " . strlen($xml_data),
            "Authorization: Basic " . base64_encode($credentials)
        );

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_TIMEOUT, 60);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
        curl_setopt($ch, CURLOPT_USERAGENT, $defined_vars['HTTP_USER_AGENT']);

        // Apply the XML to our curl call
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $xml_data);

        $data = curl_exec($ch);
        curl_close($ch);

        if (curl_errno($ch)) {
            print "Error: " . curl_error($ch);
        } else {
            // Show me the result
            var_dump($data);
        }
    }

    /**
     * check for new version
     * @return array return info about new relise or 0 if version is actual
     */
    public function checkVersion() {
        $client = new SoapClient($this->pathUS);

        $domen = $_SERVER['SERVER_NAME'];

        $result = $client->getStatus($domen, BUILD_ID);

        if (time() >= ShopCore::app()->SSettings->__get("checkTime") + 60 * 60 * 10) {

//            ShopCore::app()->SSettings->set("newVersion", $ver);
//            ShopCore::app()->SSettings->set("checkTime", time());
        } else {
            ShopCore::app()->SSettings->__get("newVersion");
        }
        return unserialize($result);
    }

    /**
     * form XML doc
     */
    public function formXml() {
        $modules = get_dir_file_info('./application/modules/');
        $array = array();
        foreach ($modules as $key => $modul) {
            $ver = read_file("./application/modules/$key/module_info.php");
            preg_match("/'version'(\s*)=>(\s*)'(.*)',/", $ver, $find);
            $array[$key] = end($find);
        }

        $array['core'] = IMAGECMS_NUMBER;
        header('content-type: text/xml');
        $xml = "<?xml version='1.0' encoding='UTF-8'?>" . "\n" .
                "<КонтейнерСписков ВерсияСхемы='0.1'  ДатаФормирования='" . date('Y-m-d') . "'>" . "\n";
        foreach ($array as $key => $arr) {
            $xml.='<modul>';
            $xml.="<name>$key</name>";
            $xml.="<version>$arr</version>";
            $xml.='</modul>';
        }
        $xml .= "</КонтейнерСписков>\n";
        echo $xml;
        exit;
    }

    public function getOldMD5File() {
        return (array) json_decode(read_file('md5.txt'));
    }

    /**
     * zipping files
     * @param array $files
     */
    public function add_to_ZIP($files = array()) {
        if (empty($files))
            return FALSE;

        $zip = new ZipArchive();
        $time = time();
        $filename = "./application/backups/backup.zip";
        rename($filename, "./application/backups/$time.zip");

        if ($zip->open($filename, ZipArchive::CREATE) !== TRUE)
            exit("cannot open <$filename>\n");

        foreach ($files as $key => $value)
            $zip->addFile('.' . $key, $key);


//        echo "numfiles: " . $zip->numFiles . "\n";
//        echo "status:" . $zip->status . "\n";

        $zip->close();
    }

    public function createBackUp() {
        $old = $this->getOldMD5File();
        $array = $this->parse_md5();
        $diff = array_diff($array, $old);
        $this->add_to_ZIP($diff);

        $filename = "./application/backups/backup.zip";
        $zip = new ZipArchive();
        $zip->open($filename);
        $db = $this->db_backup();
        $zip->addFile('./application/backups/' . $db, $db);
        $zip->close();

        chmod('./application/backups/' . $db, 0777);
        unlink('./application/backups/' . $db);
    }

    /**
     * restore files from zip
     * @param string $file path to zip file
     * @param type $destination path to destination folder
     */
    public function restoreFromZIP($file = "./application/backups/backup.zip", $destination = '.') {
        $zip = new ZipArchive();
        $zip->open($file);
        $rez = $zip->extractTo($destination);
        $zip->close();

        if ($rez)
            $this->db_restore($destination . '/backup.sql');

        return $rez;
    }

    /**
     * Оприділення шляхів відносно настройок
     */
    public function paths() {
        // шлях до корня сайту /var/www
        $this->dir_curr = realpath('') . DIRECTORY_SEPARATOR;
        // шлях до папки з обновленням з "/" вкінці
        $this->dir_old_upd = realpath('') . DIRECTORY_SEPARATOR . $this->update_directory . DIRECTORY_SEPARATOR . $this->old_reliz . DIRECTORY_SEPARATOR;
        // шлях до папки з старим редізом з "/" вкінці
        $this->dir_upd = realpath('') . DIRECTORY_SEPARATOR . $this->update_directory . DIRECTORY_SEPARATOR . $this->update_file . DIRECTORY_SEPARATOR;
        // шлях до папки з обэднаними файлами з "/" вкінці
        $this->dir_marge = realpath('') . DIRECTORY_SEPARATOR . $this->update_directory . DIRECTORY_SEPARATOR . $this->marge_file . DIRECTORY_SEPARATOR;

        // шлях до файлу з масивом про дані текущих файлів
        $this->file_mass_curr = $this->update_directory . DIRECTORY_SEPARATOR . 'current_mas.txt';
        // шлях до файлу з масивом про дані старого релізу файлів
        $this->file_mass_old = $this->update_directory . DIRECTORY_SEPARATOR . $this->old_reliz . '_mas.txt';
        // шлях до файлу з масивом про дані файлів які різняться
        $this->file_mass_diff = $this->update_directory . DIRECTORY_SEPARATOR . 'diff_mas.txt';
        // шлях до файлу з масивом про дані файлів які не обєднюються
        $this->file_dont_marge = $this->update_directory . DIRECTORY_SEPARATOR . 'dont_marge_mas.txt';

        // шлях до файлу з архівом старого релізу
        $this->file_zip_old = $this->update_directory . DIRECTORY_SEPARATOR . $this->old_reliz . '.zip';
        // шлях до файлу з архівом обновлення
        $this->file_zip_upd = $this->update_directory . DIRECTORY_SEPARATOR . $this->update_file . '.zip';
    }

    /**
     *  Вказуються папки, як пропускаються в обновленні
     */
    public function set_distinct($array) {

        $this->distinctDirs = array_merge($this->distinctDirs, $array);
        return $this;
    }

    /**
     * Скачує і розархівовує архіви обновлення і архів старої теперішньої версії.
     * Записує і розпаковує у відповідні файли і папки які вказуються в настройках
     * Доробити розархівування
     */
    public function download_and_unzip() {

        copy($this->path_update, $this->file_zip_upd);
        copy($this->path_old_reliz, $this->file_zip_old);

        //unzip() to $this->update . DIRECTORY_SEPARATOR . $label
    }

    /**
     * Бере контрольні суми файлів текущих файлів і файлів старої теперішньої версії
     * Записує іх у відповідні файли з настройок, як серіалізований масив ключ - шлях до файлу, значення - контрольна сума
     * запускати два рази переоприділивши $this->path_parse
     * $this->path_parse = realpath('') текущі.
     * $this->path_parse = rtrim($this->dir_old_upd, '\')
     * @return Array
     */
    public function parse_md5($directory = null) {

        $dir = null === $directory ? realpath('') : $directory;

        $handle = opendir($dir);
        if ($handle)
            while (FALSE !== ($file = readdir($handle)))
                if (!in_array($file, $this->distinctDirs)) {
                    if (is_file($dir . DIRECTORY_SEPARATOR . $file) && !in_array($file, $this->distinctFiles)) {
                        $this->arr_files[str_replace(realpath(''), '', $dir) . DIRECTORY_SEPARATOR . $file] = md5_file($dir . DIRECTORY_SEPARATOR . $file);
                        $this->files_dates[str_replace(realpath(''), '', $dir) . DIRECTORY_SEPARATOR . $file] = filemtime($dir . DIRECTORY_SEPARATOR . $file);
                    }
                    if (is_dir($dir . DIRECTORY_SEPARATOR . $file))
                        $this->parse_md5($dir . DIRECTORY_SEPARATOR . $file);
                }

        return $this->arr_files;
    }

    /**
     * Аналізує які файли текущі відрізняються від старих текущих файлів версії
     * результат записується у відаповідний файл з настройок, як серіалізований масив значення якого - шлях до файлу від "application"
     */
    public function get_analiz_differents() {

        $arr_current = unserialize(file_get_contents($this->file_mass_curr));
        $arr_old = unserialize(file_get_contents($this->file_mass_old));
        $arr_diff = array();
        foreach ($arr_current as $file => $value) {
            $file_key = $this->dir_old_upd . str_replace($this->dir_curr, '', $file);
            if ($arr_current[$file] != $arr_old[$file_key])
                $arr_diff[] = str_replace($this->dir_curr, '', $file);
        }

        file_put_contents($this->file_mass_diff, serialize($arr_diff));
    }

    /**
     * Спроба обєднання файлів які різняться
     * записує файли які вдалося обєднати у відповідну з настройок деректорії,
     * та записується масив файлів у відповідний з настройок файл, фкі не вдалося обєднати, ключ масиву - шлях до файлу
     */
    public function parse_to_marge() {

        $arr_diff = unserialize(file_get_contents($this->file_mass_diff));
        foreach ($arr_diff as $file) {
            if ($marge = $this->marging($file)) {
                if (!$marge['dont_marge'])
                    file_put_contents($this->dir_marge . $file, implode("\n", $marge['marge_file']));
                else
                    $arr_dont_marge[] = $file;
            }
        }

        file_put_contents($this->file_dont_marge, serialize($arr_dont_marge));
    }

    /**
     * Порядкова система обєднання файлів, які різняться
     */
    public function marging($file = null) {

        $file_curr = file_get_contents($this->dir_curr . $file);
        $file_old = file_get_contents($this->dir_old_upd . $file);
        if (file_exists($this->dir_upd . $file)) { // якщо файл обновлення існує
            $file_upd = file_get_contents($this->dir_upd . $file);

            // видалення пустих рядків у файлах
            $file_curr_arr = $this->delete_baks($file_curr);
            $file_old_arr = $this->delete_baks($file_old);
            $file_upd_arr = $this->delete_baks($file_upd);

            $marge_file = array();

            foreach ($file_curr_arr as $line => $data) {
                if ($file_curr_arr[$line] == $file_old_arr[$line] and $file_curr_arr[$line] == $file_upd_arr[$line])
                    $marge_file[] = $file_curr_arr[$line]; // якщо рядки файлів збігаються
                if ($file_curr_arr[$line] != $file_old_arr[$line] and $file_old_arr[$line] == $file_upd_arr[$line])
                    $marge_file[] = $file_curr_arr[$line]; // якщо рядок обновлення збігається зі старим, а текущий інший
                if ($file_curr_arr[$line] == $file_old_arr[$line] and $file_old_arr[$line] != $file_upd_arr[$line])
                    $marge_file[] = $file_upd_arr[$line]; // якщо рядок старий і теперішній однакові, а обновлення інший
                if ($file_curr_arr[$line] != $file_old_arr[$line] and $file_old_arr[$line] != $file_upd_arr[$line]) {
                    $marge_dont = true; // якщо рядоки різні
                    break;
                }
            }

            return array('dont_marge' => $marge_dont, 'marge_file' => $marge_file);
        }
        else
            return false;
    }

    /**
     * Видалення пустих рядків у файлах ???????????
     */
    private function delete_baks($file) {

        $file_line_arr = explode("\n", $file);
        foreach ($file_line_arr as $line => $data) {
            if (trim($data) == '')
                unset($file_line_arr[$line]);
        }

        return $file_line_arr;
    }

    /**
     * Заміна файлів з обновлення
     * 1. Заміняються файли, які не відрізняються від старої текущої версії
     * 2. заміняються файли які вдалося обєднати
     * 3. Створюється файл з приставкою _update в текущій папці даного файлу (користувач сам обєднює такі файли або обєднює такі файли система, не несучи за це відповідальності)
     */
    public function replacement() {

        $arr_curr_file = unserialize(file_get_contents($this->file_mass_curr));
        $diff_arr_file = unserialize(file_get_contents($this->file_mass_diff));
        $dont_arr_marge_file = unserialize(file_get_contents($this->file_dont_marge));
        foreach ($arr_curr_file as $file => $data) {
            if (file_exists($this->dir_upd . $file)) {
                if (!in_array($this->dir_upd . $file, $diff_arr_file)) {
                    unlink($this->dir_curr . $file);
                    copy($this->dir_upd . $file, $this->dir_curr . $file);
                } else {
                    if (!in_array($this->dir_upd . $file, $dont_arr_marge_file)) {
                        unlink($this->dir_curr . $file);
                        copy($this->dir_marge . $file, $this->dir_curr . $file);
                    }
                    else
                        copy($this->dir_upd . $file . '_update', $this->dir_curr . $file);
                }
            }
        }
    }

    public function get_settings() {

    }

    public function set_settings() {

    }

    /**
     * database backup
     */
    public function db_backup() {
        if (is_really_writable('./application/backups')) {
            $this->ci->load->dbutil();
            $backup = & $this->ci->dbutil->backup(array('format' => 'sql'));
            $name = "backup.sql";
            write_file('./application/backups/' . $name, $backup);
        } else {
            showMessage('Невозможно создать снимок базы, проверте папку /application/backups на возможность записи');
        }

        return $name;
    }

    /**
     * database restore
     * @param string $file
     */
    public function db_restore($file) {
        if (empty($file))
            return FALSE;

        if (is_readable($file)) {
            $restore = file_get_contents($file);
            return $this->query_from_file($restore);
        } else {
            return FALSE;
        }
    }

    /**
     * Create restore files list
     */
    public function restore_files_list() {
        if (is_readable('./application/backups/')) {
            $dh = opendir('./application/backups/');
            while ($filename = readdir($dh)) {
                if (filetype($filename) != 'dir') {
                    $file_type = '';
                    preg_match('/\.[a-z]{2,3}/', $filename, $file_type);
                    if ($file_type[0] == '.zip') {
                        $zip = new ZipArchive();
                        $zip->open('./application/backups/' . $filename);
                        if ($zip->statName('backup.sql')) {
                            $this->restore_files[] = array(
                                'name' => $filename,
                                'size' => filesize('./application/backups/' . $filename),
                                'create_date' => filemtime('./application/backups/' . $filename)
                            );
                        }
                        $zip->close();
                    }
                }
            }
            return $this->restore_files;
        } else {
            return FALSE;
        }
    }

    /**
     * remove dir recursive
     * @param string $dir - path to directory
     */
    public function removeDirRec($dir) {
        if ($objs = glob($dir . "/*"))
            foreach ($objs as $obj)
                is_dir($obj) ? $this->removeDirRec($obj) : unlink($obj);
        if (is_dir($dir))
            rmdir($dir);
    }

    /**
     * db update
     * @param string $file_name
     */
    public function db_update($file_name = 'sql_19-08-2013_17.16.14.txt') {
        if (is_readable('./application/backups/' . $file_name)) {
            $restore = file_get_contents('./application/backups/' . $file_name);
            $this->query_from_file($restore);
        } else {
            return FALSE;
        }
    }

    /**
     * ganerate sql query from file
     * @param string $file
     */
    public function query_from_file($file) {
        $string_query = rtrim($file, "\n;");
        $array_query = explode(";\n", $string_query);

        foreach ($array_query as $query) {
            if ($query) {
                if (!$this->ci->db->query($query)) {
                    echo 'Невозможно виполнить запрос: <br>';
                    var_dumps($query);
                    return FALSE;
                } else {
                    return TRUE;
                }
            }
        }
    }

    public function get_files_dates() {
        if (!empty($this->files_dates)) {
            return $this->files_dates;
        } else {
            return FALSE;
        }
    }

}
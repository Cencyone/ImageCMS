<?php

namespace wishlist\classes;

/**
 * Image CMS
 * Module Wishlist
 * @property \Wishlist_model $wishlist_model
 * @property \DX_Auth $dx_auth
 * @property \CI_URI $uri
 * @property \CI_DB_active_record $db
 * @property \CI_Input $input
 */
class ParentWishlist extends \MY_Controller {

    public $settings = array();
    public $dataModel;
    public $errors = array();
    public $userWishProducts;

    public function __construct() {
        parent::__construct();

        $this->writeCookies();
        $this->load->model('wishlist_model');
        $this->load->helper(array('form', 'url'));
        $this->load->language('wishlist');
        $this->settings = $this->wishlist_model->getSettings();

        if ($this->settings)
            $this->userWishProducts = $this->wishlist_model->getUserWishProducts();
    }

    /**
     * set in cookie previous page url
     *
     * @access private
     * @author DevImageCms
     * @copyright (c) 2013, ImageCMS
     */
    private function writeCookies() {
        $this->load->helper('cookie');
        if (!strstr($this->uri->uri_string(), 'wishlist') && !strstr($this->uri->uri_string(), 'sync')) {
            $cookie = array(
                'name' => 'url',
                'value' => $this->uri->uri_string(),
                'expire' => '15000',
                'prefix' => ''
            );
            @$this->input->set_cookie($cookie);
        }
    }

    /**
     * check if user login
     *
     * @access private
     * @author DevImageCms
     * @copyright (c) 2013, ImageCMS
     * @return boolean
     */
    private function checkPerm() {
        $permAllow = TRUE;
        if (!$this->dx_auth->is_logged_in())
            $permAllow = FALSE;

        return $permAllow;
    }

    /**
     * get all users wish lists
     *
     * @access public
     * @param  array $access - list access
     * @author DevImageCms
     * @copyright (c) 2013, ImageCMS
     * @return boolean
     */
    public function all($access = array('public')) {
        if (!$users = $this->wishlist_model->getAllUsers()) {
            $this->errors[] = lang('error_no_user');
            return FALSE;
        }

        foreach ($users as $user) {
            $lists [] = array(
                'user' => $user,
                'lists' => $this->wishlist_model->getWLsByUserId($user['id'], $access)
            );
        }

        if ($lists) {
            $this->dataModel = $lists;
            return TRUE;
        } else {
            $this->errors[] = lang('error_no_lists');
            return FALSE;
        }
    }

    /**
     * get user wish list
     *
     * @access public
     * @param int $hash, array $access - list access
     * @author DevImageCms
     * @copyright (c) 2013, ImageCMS
     * @return boolean
     */
    public function show($hash, $access = array('public')) {
        if (!$hash)
            return FALSE;

        $wishlist = $this->wishlist_model->getUserWishListByHash($hash, $access);

        if ($wishlist) {
            self::addReview($hash);
            $this->dataModel = $wishlist;

            return TRUE;
        } else {
             $this->errors[] = lang('error_wrong_query');
            return FALSE;
        }
    }

    /**
     * add view point to list
     *
     * @access public
     * @param int $hash
     * @author DevImageCms
     * @copyright (c) 2013, ImageCMS
     * @return boolean
     */
    public static function addReview($hash) {
        $CI = & get_instance();
        $listsAdded = array();

        if ($CI->input->cookie('wishListViewer')) {
            $listsAdded = unserialize($CI->input->cookie('wishListViewer'));
        }

        if (!in_array($hash, $listsAdded)) {
            array_push($listsAdded, $hash);
            if ($CI->wishlist_model->addReview($hash)) {
                $cookie = array(
                    'name' => 'wishListViewer',
                    'value' => serialize($listsAdded),
                    'expire' => 60 * 60 * 24,
                    'prefix' => ''
                );
                @$CI->input->set_cookie($cookie);
                return TRUE;
            }
        }
        return FALSE;
    }

    /**
     * get most viewed wish list
     *
     * @access public
     * @param int $limit - count lists to get
     * @author DevImageCms
     * @copyright (c) 2013, ImageCMS
     * @return boolean
     */
    public function getMostViewedWishLists($limit = 10) {
        $views = $this->wishlist_model->getMostViewedWishLists($limit);
        if ($views) {
            $this->dataModel = $views;
            return TRUE;
        } else {
            $this->errors[] = lang('error_no_views');
            return FALSE;
        }
    }

    /**
     * render user list
     *
     * @access public
     * @param int $user_id, $access
     * @author DevImageCms
     * @copyright (c) 2013, ImageCMS
     * @return boolean
     */
    public function user($user_id, $access = array('public')) {
        if ($this->getUserWL($user_id, $access)) {
            $this->dataModel = $this->dataModel['wishlists'];
            return TRUE;
        } else {
            $this->errors[] = lang('error_wrong_query');
            return FALSE;
        }
    }

    /**
     * update user information
     *
     * @access public
     * @param $userID, $user_name, $user_birthday, $description
     * @author DevImageCms
     * @copyright (c) 2013, ImageCMS
     * @return boolean
     */
    public function userUpdate($userID, $user_name, $user_birthday, $description) {
        if (!$userID) {
            $userID = $this->dx_auth->get_user_id();
        }
        $this->wishlist_model->createUserIfNotExist($userID);

        if ($this->wishlist_model->updateUser($userID, $user_name, $user_birthday, $description)) {
            return TRUE;
        } else {
            return FALSE;
        }
    }

    /**
     * update wish list
     *
     * @access public
     * @param $id, $data, $comments
     * @author DevImageCms
     * @copyright (c) 2013, ImageCMS
     * @return -----
     */
    public function updateWL($id, $data, $comments) {
        $return = TRUE;
        $return = $this->wishlist_model->updateWishList($id, $data);
        if($comments){
            $this->wishlist_model->updateWishListItemsComments($id, $comments);
        }
        if($return){
            $this->dataModel[] = lang("updated");
        }else{
            $this->errors[] = lang('error_cant_update');
        }
        return $return;
    }

    /**
     * create wish list
     *
     * @access public
     * @param int $user_id,
     * @param string $listName
     * @author DevImageCms
     * @copyright (c) 2013, ImageCMS
     * @return boolean
     */
    public function createWishList($user_id, $listName) {
        if ($listName)
            $count_lists = $this->wishlist_model->getUserWishListCount($user_id);

        if ($count_lists >= $this->settings['maxListsCount']) {
            $this->errors[] = lang('error_list_limit_exhausted') . '. ' . lang('list_max_count') . ' - ' . $this->settings['maxListsCount'];
            return FALSE;
        }

        if ($listName) {
            if (iconv_strlen($listName, 'UTF-8') > $this->settings['maxListName']) {
                $listName = mb_substr($listName, 0, (int) $this->settings['maxListName'], 'utf-8');
                $this->errors[] = lang('error_listname_limit_exhausted') . '. ' . lang('listname_max_count') . ' - ' . $this->settings['maxListName'];
            }
            $this->wishlist_model->createWishList($listName, $user_id);
        } else {
            $this->errors[] = lang('error_listname_empty');
        }

        if (count($this->errors))
            return FALSE;
        else {
            $this->dataModel = lang('created');
            return TRUE;
        }
    }

    /**
     * delete full WL
     *
     * @access public
     * @param int $id - list id
     * @author DevImageCms
     * @copyright (c) 2013, ImageCMS
     * @return boolean
     */
    public function deleteWL($id) {
        $forReturn = TRUE;

        $forReturn = $this->wishlist_model->delWishListById($id);

        if ($forReturn) {
            $this->wishlist_model->delWishListProductsByWLId($id);
        }
        else
            $this->errors[] = lang('error_WL_delete');

        if (count($this->errors))
            return FALSE;
        else {
            $this->dataModel = lang('deleted');
            return TRUE;
        }
    }

    /**
     *
     * @param type $UserID
     * @return boolean
     */
    public function deleteAllWL($UserID) {
        $forReturn = TRUE;

        $WLs = $this->wishlist_model->getAllUserWLs($UserID);
        if ($forReturn) {
            foreach ($WLs as $wl) {
                $forReturn = $this->wishlist_model->delWishListById($wl);
                $forReturn = $this->wishlist_model->delWishListProductsByWLId($wl);

                if (!$forReturn)
                    $this->errors[] = lang('error_items_delete');
            }
        }
        else
            $this->errors[] = lang('error_WL_delete');

        if (count($this->errors))
            return FALSE;
        else {
            $this->dataModel = lang('deleted');
            return TRUE;
        }
    }

    /**
     * add item to wish list
     *
     * @access public
     * @param type $varId
     * @param string $listId
     * @param type $listName
     * @param type $userId
     * @author DevImageCms
     * @copyright (c) 2013, ImageCMS
     * @return boolean
     */
    public function _addItem($varId, $listId, $listName, $userId = null) {
        if (!$userId)
            $userId = $this->dx_auth->get_user_id();
        $count_lists = 0;
        $count_items = $this->wishlist_model->getUserWishListItemsCount($userId);

        if (!$this->settings) {
            $this->settings = $this->wishlist_model->getSettings();
        }

        if ($count_items >= $this->settings['maxItemsCount']) {
            $this->errors[] = lang('error_items_limit_exhausted');
            return FALSE;
        }

        if (!$this->dx_auth->is_logged_in()) {
            $this->errors[] = lang('error_user_not_autorized');
            return FALSE;
        }

        if (mb_strlen($listName, 'utf-8') > $this->settings['maxListName']) {
            $listName = mb_substr($listName, 0, (int) $this->settings['maxListName'], 'utf-8');
            $this->errors[] = lang('error_listname_limit_exhausted') . '. ' . lang('listname_max_count') . ' - ' . $this->settings['maxListName'];
        }

        if ($listName) {
            $listId = "";
            $count_lists = $this->wishlist_model->getUserWishListCount($userId);
        }

        if ($count_lists >= $this->settings['maxListsCount']) {
            $this->errors[] = lang('error_list_limit_exhausted') . '. ' . lang('list_max_count') . ' - ' . $this->settings['maxListsCount'];
            return FALSE;
        }

        if (!$this->wishlist_model->addItem($varId, $listId, $listName, $userId))
            $this->errors[] = lang('error_cant_add');

        if (count($this->errors))
            return FALSE;
        else {
            $this->dataModel = lang('added');
            return TRUE;
        }
    }

    /**
     * move item from one wish list to another
     *
     * @param type $varId
     * @param type $wish_list_id
     * @param type $to_listId
     * @param type $to_listName
     * @access public
     * @author DevImageCms
     * @copyright (c) 2013, ImageCMS
     * @return boolean
     */
    public function moveItem($varId, $wish_list_id, $to_listId = '', $to_listName = '', $user_id = null) {
        if(!$user_id)
            $user_id = $this->dx_auth->get_user_id ();

        if($to_listName){
            $this->wishlist_model->createWishList($to_listName, $user_id);
            $to_listId = $this->db->insert_id();
        }

        $data = array('wish_list_id' => $to_listId);
        return $this->wishlist_model->updateWishListItem($varId, $wish_list_id, $data);
    }

    /**
     * delete item from wish list
     *
     * @param type $variant_id
     * @param type $wish_list_id
     * @access public
     * @author DevImageCms
     * @copyright (c) 2013, ImageCMS
     * @return boolean
     */
    public function deleteItem($variant_id, $wish_list_id) {
        $forReturn = $this->wishlist_model->deleteItem($variant_id, $wish_list_id);
        if ($forReturn == 0)
            $this->errors[] = lang('error_items_delete');
        else
            $this->dataModel = lang('success');

        return $forReturn;
    }

    /**
     * get user info
     *
     * @param type $id
     * @access public
     * @author DevImageCms
     * @copyright (c) 2013, ImageCMS
     * @return boolean
     */
    public function getUserInfo($id) {
        return $this->wishlist_model->getUserByID($id);
    }

    /**
     * render user wish list
     *
     * @param $userId
     * @param array $access
     * @access public
     * @author DevImageCms
     * @copyright (c) 2013, ImageCMS
     * @return boolean
     */
    public function getUserWL($userId, $access = array('public', 'private', 'shared')) {
        $this->wishlist_model->createUserIfNotExist($userId);

        $wishlists = $this->wishlist_model->getUserWishListsByID($userId, $access);
        $userInfo = $this->getUserInfo($userId);
        $this->dataModel['user'] = $userInfo;

        if (!$wishlists) {
            return FALSE;
        }

        if (empty($userInfo)) {
            $this->errors[] = lang('error_no_user_data');
            return FALSE;
        }
        $w = array();

        foreach ($wishlists as $wishlist)
            $w[$wishlist['wish_list_id']][] = $wishlist;

        $this->dataModel['wishlists'] = $w;

        return TRUE;
    }

    /**
     * render user wish list edit page
     *
     * @param type $wish_list_id
     * @param type $userID
     * @access public
     * @author DevImageCms
     * @copyright (c) 2013, ImageCMS
     * @return boolean
     */
    public function renderUserWLEdit($wish_list_id, $userID = null) {
        if ($userID === null)
            $userID = $this->dx_auth->get_user_id();

        if ($wish_list_id) {
            $wishlists = $this->wishlist_model->getUserWishList($userID, $wish_list_id);
            if (empty($wishlists))
                return FALSE;

            $w = array();
            foreach ($wishlists as $wishlist)
                $w[$wishlist['title']][] = $wishlist;
            $this->dataModel = $w;
            return TRUE;
        }
        return FALSE;
    }

    /**
     * upload image for user
     *
     * @param type $userID
     * @access public
     * @author DevImageCms
     * @copyright (c) 2013, ImageCMS
     * @return boolean
     */
    function do_upload($userID = null) {

        if (!$userID)
            $userID = $this->dx_auth->get_user_id();

        $allowedFileFormats = array('image/gif', 'image/jpeg', 'image/png', 'image/jpg');

        list($width, $height, $type, $attr) = getimagesize($_FILES["userfile"]['tmp_name']);

        if ($this->settings['maxImageSize'] < $_FILES["userfile"]['size'])
            $this->errors[] = lang('error_max_image_size_exceeded');
        if ($this->settings['maxImageWidth'] < $width)
            $this->errors[] = lang('error_max_image_width_exceeded');
        if ($this->settings['maxImageHeight'] < $height)
            $this->errors[] = lang('error_max_image_height_exceeded');
        if (!in_array($_FILES["userfile"]['type'], $allowedFileFormats))
            $this->errors[] = lang('error_invalid_file_format');

        if ($this->errors)
            return FALSE;

        $config['upload_path'] = './uploads/mod_wishlist';
        $config['allowed_types'] = 'gif|jpg|png|jpeg';
        $config['max_size'] = $this->settings['maxImageSize'];
        $config['max_width'] = $this->settings['maxImageWidth'];
        $config['max_height'] = $this->settings['maxImageHeight'];

        $this->load->library('upload', $config);
        return TRUE;
    }

    /**
     * get most popular items by wish list usage
     *
     * @param type $limit
     * @access public
     * @author DevImageCms
     * @copyright (c) 2013, ImageCMS
     * @return boolean
     */
    public function getMostPopularItems($limit = 10) {
        $result = $this->wishlist_model->getMostPopularProducts();

        if ($result !== FALSE) {
            $this->dataModel = $result;
            return TRUE;
        } else {
            $this->error[] = lang('error_wrong_query');
            return FALSE;
        }
    }

    /**
     * get user wish list items count
     *
     * @param type $user_id
     * @access public
     * @author DevImageCms
     * @copyright (c) 2013, ImageCMS
     * @return boolean
     */
    public function getUserWishListItemsCount($user_id) {
        return $this->wishlist_model->getUserWishListItemsCount($user_id);
    }

    /**
     * delete list items by id's
     *
     * @param array $ids
     * @access public
     * @author DevImageCms
     * @copyright (c) 2013, ImageCMS
     * @return boolean
     */
    public function deleteItemsByIds($ids) {
        return $this->wishlist_model->deleteItemsByIDs($ids);
    }

    /**
     * delete  image
     *
     * @param string $image image name
     * @access public
     * @author DevImageCms
     * @copyright (c) 2013, ImageCMS
     * @return boolean
     */
    public function deleteImage($image) {
        $basePath = substr(dirname(__FILE__), 0, strpos(dirname(__FILE__), "application"));
        return unlink($basePath . "uploads/mod_wishlist/" . $image);
    }

    /**
     * get popup for adding or moving items
     *
     * @access public
     * @author DevImageCms
     * @copyright (c) 2013, ImageCMS
     * @return boolean
     */
    public function renderPopup($userID = null) {
        $wish_lists = $this->wishlist_model->getWishLists($userID);
        if ($wish_lists) {
            $this->dataModel = $wish_lists;
            return TRUE;
        } else {
            return FALSE;
        }
    }

    public function autoload() {

    }

    public static function adminAutoload() {
        parent::adminAutoload();
    }

    public function _install() {
        $this->wishlist_model->install();
    }

    public function _deinstall() {
        $this->wishlist_model->deinstall();
    }

}
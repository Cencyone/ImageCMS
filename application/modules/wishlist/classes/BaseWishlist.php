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
class BaseWishlist extends \wishlist\classes\ParentWishlist {

    public function __construct() {
        parent::__construct();
    }

    /**
     * get all user wishlists
     * @return mixed
     */
    public function all() {
        $parent = parent::all();
        if ($parent) {
            return $this->dataModel;
        } else {
            return $this->errors;
        }
    }

    /**
     * add item to wishlist
     * @param $varId
     * @param $listId
     * @param $listName
     * @return mixed
     */
    public function addItem($varId, $listId, $listName) {
        if (!$listId)
            $listId = $this->input->post('wishlist');
        if (!$listName)
            $listName = $this->input->post('wishListName');

        if (parent::_addItem($varId, $listId, $listName)) {
            return $this->dataModel;
        } else {
            return $this->errors;
        }
    }

    /**
     * move item
     * @param $varId
     * @param $wish_list_id
     * @return mixed
     */
    public function moveItem($varId, $wish_list_id) {
        $listId = $this->input->post('wishlist');
        $user_id = $this->input->post('user_id');
        $listName = $this->input->post('wishListName');

        if ((!$listId && !$listName)) {
            return $this->errors[] = lang('error_cant_move');
        }

        if (parent::moveItem($varId, $wish_list_id, $listId, $listName, $user_id)) {
            return $this->dataModel = lang('success');
        } else {
            return $this->errors[] = lang('error_cant_move');
        }
    }

    /**
     * show WL by hash
     * @param $hash
     * @return boolean
     */
    public function show($hash) {
        if (parent::show($hash)) {
            return $this->dataModel;
        } else {
            $this->errors;
            return false;
        }
    }

    /**
     * show most popular wishlist
     * @param $limit
     * @return mixed
     */
    public function getMostViewedWishLists($limit = 10) {
        if (parent::getMostViewedWishLists($limit)) {
            return $this->dataModel;
        } else {
            return $this->errors;
        }
    }

    /**
     * get user by id
     * @param $user_id
     * @return boolean
     */
    public function user($user_id) {
        if (parent::user($user_id)) {
            return $this->dataModel;
        } else {
            return false;
        }
    }

    /**
     * get most populars items
     * @param $limit
     * @return mixed
     */
    public function getMostPopularItems($limit = 10) {
        if (parent::getMostPopularItems($limit)) {
            return $this->dataModel;
        } else {
            return $this->errors;
        }
    }

    /**
     * create wishlist
     * @return mixed
     */
    public function createWishList() {
        $listName = $this->input->post('wishListName');
        $user_id = $this->input->post('user_id');
        $wlType = $this->input->post('wlTypes');
        $wlDescription = $this->input->post('wlDescription');

        if (parent::createWishList($user_id, $listName, $wlType, $wlDescription)) {
            return $this->dataModel = lang('created');
        } else {
            return $this->errors;
        }
    }

    /**
     * update user data
     * @return boolean
     */
    public function userUpdate() {

        if ($this->settings['maxDescLenght'] < iconv_strlen($this->input->post('description'), 'UTF-8'))
            $desc = mb_substr($this->input->post('description'), 0, $this->settings['maxDescLenght'], 'UTF-8');
        else
            $desc = $this->input->post('description');

        if (!(strtotime($this->input->post('user_birthday')) + 50000))
            return false;

        $userName = $this->input->post('user_name');

        if ($this->settings['maxUserName'] < iconv_strlen($userName, 'UTF-8'))
            $desc = mb_substr($userName, 0, $this->settings['maxUserName'], 'UTF-8');

        $updated = parent::userUpdate($this->input->post('user_id'), $userName, strtotime($this->input->post('user_birthday')) + 50000, $desc);
        if ($updated) {
            return $this->dataModel = lang('updated');
        } else {
            return $this->errors = lang('error_cant_update');
        }
    }

    /**
     * update user WL
     */
    public function updateWL() {

        $id = $this->input->post('WLID');
        $wlDescription = $this->input->post('description');

        if (iconv_strlen($wlDescription, 'UTF-8') > $this->settings['maxWLDescLenght']) {
            $wlDescription = mb_substr($wlDescription, 0, (int) $this->settings['maxWLDescLenght'], 'utf-8');
            $this->errors[] = lang('error_list_description_limit_exhausted') . '. ' . lang('list_description_max_count') . ' - ' . $this->settings['maxWLDescLenght'];
        }

        foreach ($this->input->post('comment') as $key => $comment) {
            if ($this->settings['maxCommentLenght'] < iconv_strlen($comment, 'UTF-8'))
                $desc[$key] = mb_substr($comment, 0, $this->settings['maxCommentLenght']);
            else
                $desc[$key] = $comment;
        }
        if ($this->settings['maxListName'] < iconv_strlen($this->input->post('title'), 'UTF-8'))
            $title = mb_substr($this->input->post('title'), 0, $this->settings['maxListName'], 'UTF-8');
        else
            $title = $this->input->post('title');

        $data = array(
            'access' => $this->input->post('access'),
            'description' => $wlDescription,
            'title' => $title,
        );

        parent::updateWL($id, $data, $desc);
    }

    /**
     * delete item from wishlist
     * @param $variant_id
     * @param $wish_list_id
     * @return mixed
     */
    public function deleteItem($variant_id, $wish_list_id) {
        if (parent::deleteItem($variant_id, $wish_list_id)) {
            return $this->dataModel;
        } else {
            return $this->errors;
        }
    }

    /**
     * delete items from wishlist by id
     * @return mixed
     */
    public function deleteItemsByIds() {
        $items = $this->input->post('listItem');
        if ($items) {
            if (parent::deleteItemsByIds($items)) {
                return $this->dataModel = lang('deleted');
            } else {
                return $this->errors[] = lang('error_cant_delete');
            }
        }
    }

    /**
     * delete image
     * @return mixed
     */
    public function deleteImage() {
        $image = $this->input->post('image');
        if (parent::deleteImage($image)) {
            return $this->dataModel[] = lang('deleted');
        } else {
            return $this->errors[] = lang('error_cant_delete');
        }
    }

    /**
     * render popup
     * @return mixed
     */
    public function renderPopup() {
        if (parent::renderPopup()) {
            return $this->dataModel;
        } else {
            return $this->errors;
        }
    }

    /**
     * upload user photo
     * @return boolean
     */
    public function do_upload() {
        if (parent::do_upload($this->input->post('userID'))) {
            if (!$this->upload->do_upload('file')) {
                
                $this->errors[] = $this->upload->display_errors();
                $f = fopen('/var/www/image.loc/baaaad.txt', "w+");
                fwrite($f, print_r($this->errors, TRUE));
                fclose($f);
                return FALSE;
            } else {
                $this->dataModel = array('upload_data' => $this->upload->data());
                $this->wishlist_model->setUserImage($this->input->post('userID'), $this->dataModel['upload_data']['file_name']);
                return TRUE;
            }
            return $this->dataModel[] = lang('picture_uploaded');
        } else {
            return $this->errors[] = lang('error_upload_photo');
        }
    }

}

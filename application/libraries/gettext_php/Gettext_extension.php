<?php
/*
 * Copyright (c) 2009 David Soria Parra
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

include_once('Gettext.php');
/**
 * Gettext implementation in PHP
 *
 * @copyright (c) 2009 David Soria Parra <sn_@gmx.net>
 * @author David Soria Parra <sn_@gmx.net>
 */
class Gettext_Extension extends Gettext
{
    /**
     * Initialize a new gettext class
     *
     * @param String $mofile The file to parse
     */
    public function __construct($params)
    {

        $locale = 'ru_RU';
        $lang = 'ru_RU';


        if (!setlocale (LC_ALL, $locale.'.utf8', $locale.'.utf-8', $locale.'.UTF8', $locale.'.UTF-8', $lang.'.utf-8', $lang.'.UTF-8', $lang)) {
            // Set current locale
            setlocale(LC_ALL, '');
        }

        putenv('LC_ALL='.$locale);
        putenv('LANG='.$locale);
        putenv('LANGUAGE='.$locale);



        $arr = array($params);
        //setlocale(LC_ALL, $params['locale']);
        //$td = bindtextdomain($params['domain'], $params['directory']);
        bindtextdomain($params['domain'], 'application/language/admin');

        var_dump($td);

        textdomain($params['domain']);


        var_dump($this->gettext('a_fail'));
    }

    /**
     * Return a translated string
     *
     * If the translation is not found, the original passed message
     * will be returned.
     *
     * @return Translated message
     */
    public function gettext($msg)
    {
        return gettext($msg);
    }

    /**
     * Return a translated string in it's plural form
     *
     * Returns the given $count (e.g second, third,...) plural form of the
     * given string. If the id is not found and $num == 1 $msg is returned,
     * otherwise $msg_plural
     *
     * @param String $msg The message to search for
     * @param String $msg_plural A fallback plural form
     * @param Integer $count Which plural form
     *
     * @return Translated string
     */
    public function ngettext($msg, $msg_plural, $count)
    {
        return ngettext($msg, $msg_plural, $count);
    }
}

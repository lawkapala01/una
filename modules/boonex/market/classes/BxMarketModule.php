<?php defined('BX_DOL') or die('hack attempt');
/**
 * Copyright (c) BoonEx Pty Limited - http://www.boonex.com/
 * CC-BY License - http://creativecommons.org/licenses/by/3.0/
 *
 * @defgroup    Market Market
 * @ingroup     TridentModules
 *
 * @{
 */

define('BX_MARKET_LICENSE_TYPE_SINGLE', 'single'); //--- one-time payment license
define('BX_MARKET_LICENSE_TYPE_RECURRING', 'recurring'); //--- recurring payment license

/**
 * Market module
 */
class BxMarketModule extends BxBaseModTextModule
{
    function __construct(&$aModule)
    {
        parent::__construct($aModule);
    }

    public function actionCheckName()
    {
    	$CNF = &$this->_oConfig->CNF;

    	$sTitle = strtolower(bx_process_input(bx_get('title')));
    	if(empty($sTitle))
    		return echoJson(array());

    	echoJson(array(
    		'title' => $sTitle,
    		'name' => uriGenerate($sTitle, $CNF['TABLE_ENTRIES'], $CNF['FIELD_NAME'])
    	));
    }

    public function serviceEntityCreate ()
    {
    	$this->_oTemplate->addJs(array('entry.js'));

    	return $this->_oTemplate->getJsCode('entry') . parent::serviceEntityCreate();
    }

    public function serviceEntityDownload ($iContentId = 0)
    {
    	$CNF = &$this->_oConfig->CNF;

    	if(!$iContentId)
            $iContentId = bx_process_input(bx_get('id'), BX_DATA_INT);

        if(!$iContentId)
            return false;

		$aContentInfo = $this->_oDb->getContentInfoById($iContentId);
		if(empty($aContentInfo) || !is_array($aContentInfo))
            return MsgBox(_t('_sys_txt_error_occured'));

    	if($this->checkAllowedDownload($aContentInfo) !== CHECK_ACTION_RESULT_ALLOWED)
    		return MsgBox(_t('_bx_market_err_access_denied'));

        return $this->_oTemplate->entryAttachmentsByStorage($CNF['OBJECT_STORAGE_FILES'], $aContentInfo);
    }

	public function serviceEntityInfo ($iContentId = 0)
    {
        return $this->_serviceTemplateFunc ('entryInfo', $iContentId);
    }

    public function serviceEntityRating($iContentId = 0)
    {
    	return $this->_serviceTemplateFunc ('entryRating', $iContentId);
    }

	public function serviceEntityAuthorEntities($iContentId = 0)
    {
    	$CNF = &$this->_oConfig->CNF;

    	$aContentInfo = $this->_getContentInfo($iContentId);
    	if($aContentInfo === false)
    		return false;

		$oProfile = BxDolProfile::getInstance($aContentInfo[$CNF['FIELD_AUTHOR']]);
        if (!$oProfile)
            $oProfile = BxDolProfileUndefined::getInstance();

		$aBlock = $this->_serviceBrowse ('author', array('author' => $aContentInfo[$CNF['FIELD_AUTHOR']], 'except' => array($iContentId), 'per_page' => 2), BX_DB_PADDING_DEF, true);
		$aBlock['title'] = _t('_bx_market_page_block_title_entry_author_entries', $oProfile->getDisplayName());

    	return $aBlock;
    }

    /**
     * Licenses 
     */
	public function serviceBlockLicenses() 
	{
		$sGrid = $this->_oConfig->getGridObject('licenses');
		$oGrid = BxDolGrid::getObjectInstance($sGrid);
        if(!$oGrid)
			return '';

		return array(
        	'content' => $this->_oTemplate->getJsCode('licenses', array('sObjNameGrid' => $sGrid)) . $oGrid->getCode(),
        );
	}
    /**
     * Get number of unused licenses for some profile
     * @param $iProfileId - profile to get unused licenses for, if omitted then currently logged in profile is used
     * @return integer
     */
    public function serviceGetUnusedLicensesNum ($iProfileId = 0)
    {
        if(!$iProfileId)
			$iProfileId = bx_get_logged_profile_id();

        $aLicenses = $this->_oDb->getLicense(array('type' => 'unused', 'profile_id' => (int)$iProfileId));
        return !empty($aLicenses) && is_array($aLicenses) ? count($aLicenses) : 0;
    }

    /**
     * Integration with Payment based modules.  
     */
	public function serviceGetPaymentData()
    {
        return $this->_aModule;
    }

    public function serviceGetCartItem($iItemId)
    {
    	$CNF = &$this->_oConfig->CNF;

        if(!$iItemId)
			return array();

		$aItem = $this->_oDb->getContentInfoById($iItemId);
        if(empty($aItem) || !is_array($aItem))
			return array();

		return array (
			'id' => $aItem[$CNF['FIELD_ID']],
			'author_id' => $aItem[$CNF['FIELD_AUTHOR']],
			'name' => $aItem[$CNF['FIELD_NAME']],
			'title' => $aItem[$CNF['FIELD_TITLE']],
			'description' => $aItem[$CNF['FIELD_TEXT']],
			'url' => BX_DOL_URL_ROOT . BxDolPermalinks::getInstance()->permalink('page.php?i=view-product&id=' . $aItem[$CNF['FIELD_ID']]),
			'price_single' => $aItem[$CNF['FIELD_PRICE_SINGLE']],
			'price_recurring' => $aItem[$CNF['FIELD_PRICE_RECURRING']],
        );
    }

    public function serviceGetCartItems($iSellerId)
    {
    	$CNF = &$this->_oConfig->CNF;

        $iSellerId = (int)$iSellerId;
        if(empty($iSellerId))
            return array();

        $aItems = $this->_oDb->getEntriesByAuthor($iSellerId);

        $aResult = array();
        foreach($aItems as $aItem)
            $aResult[] = array(
				'id' => $aItem[$CNF['FIELD_ID']],
				'author_id' => $aItem[$CNF['FIELD_AUTHOR']],
            	'name' => $aItem[$CNF['FIELD_NAME']],
				'title' => $aItem[$CNF['FIELD_TITLE']],
				'description' => $aItem[$CNF['FIELD_TEXT']],
				'url' => BX_DOL_URL_ROOT . BxDolPermalinks::getInstance()->permalink('page.php?i=view-product&id=' . $aItem[$CNF['FIELD_ID']]),
				'price' => $aItem[$CNF['FIELD_PRICE_SINGLE']],
           );

        return $aResult;
    }

    public function serviceRegisterCartItem($iClientId, $iSellerId, $iItemId, $iItemCount, $sOrder, $sLicense)
    {
        return $this->_serviceRegisterItem($iClientId, $iSellerId, $iItemId, $iItemCount, $sOrder, $sLicense, BX_MARKET_LICENSE_TYPE_SINGLE);
    }

    public function serviceRegisterSubscriptionItem($iClientId, $iSellerId, $iItemId, $iItemCount, $sOrder, $sLicense)
    {
		return $this->_serviceRegisterItem($iClientId, $iSellerId, $iItemId, $iItemCount, $sOrder, $sLicense, BX_MARKET_LICENSE_TYPE_RECURRING);
    }

    public function serviceUnregisterCartItem($iClientId, $iSellerId, $iItemId, $iItemCount, $sOrder, $sLicense)
    {
        return $this->_serviceUnregisterItem($iClientId, $iSellerId, $iItemId, $iItemCount, $sOrder, $sLicense, BX_MARKET_LICENSE_TYPE_SINGLE);
    }

    public function serviceUnregisterSubscriptionItem($iClientId, $iSellerId, $iItemId, $iItemCount, $sOrder, $sLicense)
    {
    	return $this->_serviceUnregisterItem($iClientId, $iSellerId, $iItemId, $iItemCount, $sOrder, $sLicense, BX_MARKET_LICENSE_TYPE_RECURRING); 
    }

	public function serviceCancelSubscriptionItem($iClientId, $iSellerId, $iItemId, $iItemCount, $sOrder)
    {
    	//TODO: Do something if it's necessary.
    }

    protected function _serviceRegisterItem($iClientId, $iSellerId, $iItemId, $iItemCount, $sOrder, $sLicense, $sType)
    {
    	$aItem = $this->serviceGetCartItem($iItemId);
        if(empty($aItem) || !is_array($aItem))
			return array();

		$sDuration = '';
		if($sType == BX_MARKET_LICENSE_TYPE_RECURRING) {
			$aProduct = $this->_oDb->getContentInfoById($iItemId);

			$sDuration = $aProduct[$this->_oConfig->CNF['FIELD_DURATION_RECURRING']];
		}

        if(!$this->_oDb->registerLicense($iClientId, $iItemId, $iItemCount, $sOrder, $sLicense, $sType, $sDuration))
            return array();

        return $aItem;
    }

    protected function _serviceUnregisterItem($iClientId, $iSellerId, $iItemId, $iItemCount, $sOrder, $sLicense, $sType)
    {
    	return $this->_oDb->unregisterLicense($iClientId, $iItemId, $sOrder, $sLicense, $sType);
    }

    public function getGhostTemplateVars($aFile, $iProfileId, $iContentId, $oStorage, $oImagesTranscoder)
    {
    	$CNF = &$this->_oConfig->CNF;

    	$sMethod = '';
    	$sStorage = $oStorage->getObject();
        switch($sStorage) {
        	case $CNF['OBJECT_STORAGE']:
        		$sMethod = 'getPhoto';
        		break;

			case $CNF['OBJECT_STORAGE_FILES']:
				$sMethod = 'getFile';
				break;
        }

		$aFileInfo = $this->_oDb->$sMethod(array('type' => 'file_id', 'file_id' => $aFile['id']));
        $bFileInfo = !empty($aFileInfo) && is_array($aFileInfo);

        $bFileInfoTitle = $bFileInfo && isset($aFileInfo['title']);
        $bFileInfoVersion = $bFileInfo && isset($aFileInfo['version']);

		return array(
			'file_title' => $bFileInfoTitle ? $aFileInfo['title'] : '',
			'file_title_attr' => $bFileInfoTitle ? bx_html_attribute($aFileInfo['title']) : '',

			'file_version' => $bFileInfoVersion ? $aFileInfo['version'] : '',
			'file_version_attr' => $bFileInfoVersion ? bx_html_attribute($aFileInfo['version']) : '',
		);
    }

    public function checkAllowedSetCover ()
    {
        $aCheck = checkActionModule($this->_iProfileId, 'set cover', $this->getName(), false);
        if($aCheck[CHECK_ACTION_RESULT] !== CHECK_ACTION_RESULT_ALLOWED)
            return $aCheck[CHECK_ACTION_MESSAGE];

        return CHECK_ACTION_RESULT_ALLOWED;
    }

	public function checkAllowedDownload($aDataEntry, $isPerformAction = false)
    {
        $CNF = &$this->_oConfig->CNF;

        // moderator and owner always have access
        if ($aDataEntry[$CNF['FIELD_AUTHOR']] == $this->_iProfileId || $this->_isModerator($isPerformAction))
            return CHECK_ACTION_RESULT_ALLOWED;

        // check ACL
        $aCheck = checkActionModule($this->_iProfileId, 'download entry', $this->getName(), $isPerformAction);
        if($aCheck[CHECK_ACTION_RESULT] !== CHECK_ACTION_RESULT_ALLOWED)
			return $aCheck[CHECK_ACTION_MESSAGE];

		if(!$this->_oDb->hasLicense($this->_iProfileId, $aDataEntry[$CNF['FIELD_ID']]))
            return true;

        return CHECK_ACTION_RESULT_ALLOWED;
    }

    protected function _getContentInfo($iContentId = 0)
    {
    	if(!$iContentId)
            $iContentId = bx_process_input(bx_get('id'), BX_DATA_INT);

        if(!$iContentId)
            return false;

        $aContentInfo = $this->_oDb->getContentInfoById($iContentId);
        if(!$aContentInfo)
            return false;

		return $aContentInfo;
    }
}

/** @} */
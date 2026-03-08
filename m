Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB1D2F12C6
	for <linux-input@vger.kernel.org>; Sun,  8 Mar 2026 16:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772985710; cv=none; b=BJKxA2to5C2eyJ5uNoDvg0v2l7OJe2ILtVAt6ZyoylxLW/3icb9nuJKNR++XbG8UOVRT9Q9wQMbp3yXPI9AX6diw23tCJXnPThE3oH8WAZkKtGsSWqL76qQ2D8PuH2zu3l4hZvwrAsz4srNn+4T/mqkK8l/SRTLW+YcJvbwsTz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772985710; c=relaxed/simple;
	bh=/cS2G3+sIItOr2DB4MwV8/D5D2UT1QE5NHeoxwdlTGU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=drJJ7hGW38q4WnLePYlvMiwo/rCILVwg3xTJkHVFAcIlfT4Pd11xYC1ckKNmTI+tGwU1N24I1OMYuyG7GtKsvW/SPZrRyH72lzsVTxtvdjuu7ma2hE1cp6iCbVu2GHCD/yibbjTGil/BrCsCxq3XUxwg7lpNZIfLqa1ETpffjCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eEJz6keq; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eEJz6keq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772985709; x=1804521709;
  h=date:from:to:cc:subject:message-id;
  bh=/cS2G3+sIItOr2DB4MwV8/D5D2UT1QE5NHeoxwdlTGU=;
  b=eEJz6keqfmxf96KAAbEMrePs5yfOjRE2o3cVGKKgC8UtU/auqCXrI/+h
   mcB3eUd9YyC8BMRm66NsyO3fwXDmKw+RVMDckylnHHgsQwEQsitKfDY/b
   vnMCWz/ISTikfav/8iHdV9sNn4BeLEMzwZvR2GZaAvFMb4g1s0rQ1NIEN
   yBIll1+ZIEKw6BYgAupmf26q5ptRZ8UwTp0EPoppyKFG1JhmGtYQ8NI65
   bcUF6LjWIA4dgHNffPRTMBWUhA1PeosP8MwnZLvTHYltNDsqYQZh3B5pa
   q9EXF21i62Sj/JrsSUaJefgcCuqzv8Q7Jv1CJrpf88aoq6WvIlvubKdth
   Q==;
X-CSE-ConnectionGUID: K/Jds5H5SfqOJFMnB/U49g==
X-CSE-MsgGUID: 8uTYc8wxQYOIG0MWfOxkHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="85112914"
X-IronPort-AV: E=Sophos;i="6.23,108,1770624000"; 
   d="scan'208";a="85112914"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 09:01:48 -0700
X-CSE-ConnectionGUID: 2ghMbztdQQauMVtGUTtu/g==
X-CSE-MsgGUID: GkJuKrqHTNuht6ZHtd1Yyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,108,1770624000"; 
   d="scan'208";a="219492016"
Received: from lkp-server01.sh.intel.com (HELO 058beb05654c) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 08 Mar 2026 09:01:43 -0700
Received: from kbuild by 058beb05654c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vzGZX-000000003E0-3OfP;
	Sun, 08 Mar 2026 16:01:39 +0000
Date: Mon, 09 Mar 2026 00:01:26 +0800
From: kernel test robot <lkp@intel.com>
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-input@vger.kernel.org,
 Jiri Kosina <jikos@kernel.org>,
 Mark Pearson <mpearson-lenovo@squebb.ca>
Subject: [hid:for-7.1/lenovo 2/16]
 drivers/hid/hid-lenovo-go.c:484:20: sparse: sparse: symbol
 'version_product_mcu' was not declared. Should it be static?
Message-ID: <202603082311.tPfUsIMR-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-7.1/lenovo
head:   d2c424e80caf8237bda4c94bc2e25398967243f9
commit: 3bb54f568ecc35be7675eef5303a47e14aba54bc [2/16] HID: hid-lenovo-go: Add Lenovo Legion Go Series HID Driver
config: loongarch-randconfig-r131-20260308 (https://download.01.org/0day-ci/archive/20260308/202603082311.tPfUsIMR-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260308/202603082311.tPfUsIMR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603082311.tPfUsIMR-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/hid/hid-lenovo-go.c:484:20: sparse: sparse: symbol 'version_product_mcu' was not declared. Should it be static?
>> drivers/hid/hid-lenovo-go.c:487:20: sparse: sparse: symbol 'version_protocol_mcu' was not declared. Should it be static?
>> drivers/hid/hid-lenovo-go.c:490:20: sparse: sparse: symbol 'version_firmware_mcu' was not declared. Should it be static?
>> drivers/hid/hid-lenovo-go.c:493:20: sparse: sparse: symbol 'version_hardware_mcu' was not declared. Should it be static?
>> drivers/hid/hid-lenovo-go.c:496:20: sparse: sparse: symbol 'version_gen_mcu' was not declared. Should it be static?
>> drivers/hid/hid-lenovo-go.c:513:20: sparse: sparse: symbol 'version_product_tx_dongle' was not declared. Should it be static?
>> drivers/hid/hid-lenovo-go.c:516:20: sparse: sparse: symbol 'version_protocol_tx_dongle' was not declared. Should it be static?
>> drivers/hid/hid-lenovo-go.c:519:20: sparse: sparse: symbol 'version_firmware_tx_dongle' was not declared. Should it be static?
>> drivers/hid/hid-lenovo-go.c:522:20: sparse: sparse: symbol 'version_hardware_tx_dongle' was not declared. Should it be static?
>> drivers/hid/hid-lenovo-go.c:525:20: sparse: sparse: symbol 'version_gen_tx_dongle' was not declared. Should it be static?
>> drivers/hid/hid-lenovo-go.c:543:20: sparse: sparse: symbol 'version_product_left' was not declared. Should it be static?
>> drivers/hid/hid-lenovo-go.c:546:20: sparse: sparse: symbol 'version_protocol_left' was not declared. Should it be static?
>> drivers/hid/hid-lenovo-go.c:549:20: sparse: sparse: symbol 'version_firmware_left' was not declared. Should it be static?
>> drivers/hid/hid-lenovo-go.c:552:20: sparse: sparse: symbol 'version_hardware_left' was not declared. Should it be static?
>> drivers/hid/hid-lenovo-go.c:555:20: sparse: sparse: symbol 'version_gen_left' was not declared. Should it be static?
>> drivers/hid/hid-lenovo-go.c:573:20: sparse: sparse: symbol 'version_product_right' was not declared. Should it be static?
>> drivers/hid/hid-lenovo-go.c:576:20: sparse: sparse: symbol 'version_protocol_right' was not declared. Should it be static?
>> drivers/hid/hid-lenovo-go.c:579:20: sparse: sparse: symbol 'version_firmware_right' was not declared. Should it be static?
>> drivers/hid/hid-lenovo-go.c:582:20: sparse: sparse: symbol 'version_hardware_right' was not declared. Should it be static?
>> drivers/hid/hid-lenovo-go.c:585:20: sparse: sparse: symbol 'version_gen_right' was not declared. Should it be static?
>> drivers/hid/hid-lenovo-go.c:624:58: sparse: sparse: Using plain integer as NULL pointer
   drivers/hid/hid-lenovo-go.c:632:59: sparse: sparse: Using plain integer as NULL pointer
   drivers/hid/hid-lenovo-go.c:640:59: sparse: sparse: Using plain integer as NULL pointer
   drivers/hid/hid-lenovo-go.c:648:59: sparse: sparse: Using plain integer as NULL pointer
   drivers/hid/hid-lenovo-go.c:656:62: sparse: sparse: Using plain integer as NULL pointer
   drivers/hid/hid-lenovo-go.c:665:60: sparse: sparse: Using plain integer as NULL pointer
   drivers/hid/hid-lenovo-go.c:673:61: sparse: sparse: Using plain integer as NULL pointer
   drivers/hid/hid-lenovo-go.c:681:61: sparse: sparse: Using plain integer as NULL pointer
   drivers/hid/hid-lenovo-go.c:689:61: sparse: sparse: Using plain integer as NULL pointer
   drivers/hid/hid-lenovo-go.c:697:64: sparse: sparse: Using plain integer as NULL pointer
   drivers/hid/hid-lenovo-go.c:706:66: sparse: sparse: Using plain integer as NULL pointer
   drivers/hid/hid-lenovo-go.c:714:67: sparse: sparse: Using plain integer as NULL pointer
   drivers/hid/hid-lenovo-go.c:722:67: sparse: sparse: Using plain integer as NULL pointer
   drivers/hid/hid-lenovo-go.c:730:67: sparse: sparse: Using plain integer as NULL pointer
   drivers/hid/hid-lenovo-go.c:738:70: sparse: sparse: Using plain integer as NULL pointer
   drivers/hid/hid-lenovo-go.c:747:67: sparse: sparse: Using plain integer as NULL pointer
   drivers/hid/hid-lenovo-go.c:755:68: sparse: sparse: Using plain integer as NULL pointer
   drivers/hid/hid-lenovo-go.c:763:68: sparse: sparse: Using plain integer as NULL pointer
   drivers/hid/hid-lenovo-go.c:771:68: sparse: sparse: Using plain integer as NULL pointer
   drivers/hid/hid-lenovo-go.c:779:71: sparse: sparse: Using plain integer as NULL pointer

vim +/version_product_mcu +484 drivers/hid/hid-lenovo-go.c

   444	
   445	#define LEGO_DEVICE_ATTR_RW(_name, _attrname, _dtype, _rtype, _group)         \
   446		static ssize_t _name##_store(struct device *dev,                      \
   447					     struct device_attribute *attr,           \
   448					     const char *buf, size_t count)           \
   449		{                                                                     \
   450			return _group##_store(dev, attr, buf, count, _name.index,     \
   451					      _dtype);                                \
   452		}                                                                     \
   453		static ssize_t _name##_show(struct device *dev,                       \
   454					    struct device_attribute *attr, char *buf) \
   455		{                                                                     \
   456			return _group##_show(dev, attr, buf, _name.index, _dtype);    \
   457		}                                                                     \
   458		static ssize_t _name##_##_rtype##_show(                               \
   459			struct device *dev, struct device_attribute *attr, char *buf) \
   460		{                                                                     \
   461			return _group##_options(dev, attr, buf, _name.index);         \
   462		}                                                                     \
   463		static DEVICE_ATTR_RW_NAMED(_name, _attrname)
   464	
   465	#define LEGO_DEVICE_ATTR_WO(_name, _attrname, _dtype, _group)             \
   466		static ssize_t _name##_store(struct device *dev,                  \
   467					     struct device_attribute *attr,       \
   468					     const char *buf, size_t count)       \
   469		{                                                                 \
   470			return _group##_store(dev, attr, buf, count, _name.index, \
   471					      _dtype);                            \
   472		}                                                                 \
   473		static DEVICE_ATTR_WO_NAMED(_name, _attrname)
   474	
   475	#define LEGO_DEVICE_ATTR_RO(_name, _attrname, _dtype, _group)                 \
   476		static ssize_t _name##_show(struct device *dev,                       \
   477					    struct device_attribute *attr, char *buf) \
   478		{                                                                     \
   479			return _group##_show(dev, attr, buf, _name.index, _dtype);    \
   480		}                                                                     \
   481		static DEVICE_ATTR_RO_NAMED(_name, _attrname)
   482	
   483	/* Gamepad - MCU */
 > 484	struct go_cfg_attr version_product_mcu = { PRODUCT_VERSION };
   485	LEGO_DEVICE_ATTR_RO(version_product_mcu, "product_version", USB_MCU, version);
   486	
 > 487	struct go_cfg_attr version_protocol_mcu = { PROTOCOL_VERSION };
   488	LEGO_DEVICE_ATTR_RO(version_protocol_mcu, "protocol_version", USB_MCU, version);
   489	
 > 490	struct go_cfg_attr version_firmware_mcu = { FIRMWARE_VERSION };
   491	LEGO_DEVICE_ATTR_RO(version_firmware_mcu, "firmware_version", USB_MCU, version);
   492	
 > 493	struct go_cfg_attr version_hardware_mcu = { HARDWARE_VERSION };
   494	LEGO_DEVICE_ATTR_RO(version_hardware_mcu, "hardware_version", USB_MCU, version);
   495	
 > 496	struct go_cfg_attr version_gen_mcu = { HARDWARE_GENERATION };
   497	LEGO_DEVICE_ATTR_RO(version_gen_mcu, "hardware_generation", USB_MCU, version);
   498	
   499	static struct attribute *mcu_attrs[] = {
   500		&dev_attr_version_firmware_mcu.attr,
   501		&dev_attr_version_gen_mcu.attr,
   502		&dev_attr_version_hardware_mcu.attr,
   503		&dev_attr_version_product_mcu.attr,
   504		&dev_attr_version_protocol_mcu.attr,
   505		NULL,
   506	};
   507	
   508	static const struct attribute_group mcu_attr_group = {
   509		.attrs = mcu_attrs,
   510	};
   511	
   512	/* Gamepad - TX Dongle */
 > 513	struct go_cfg_attr version_product_tx_dongle = { PRODUCT_VERSION };
   514	LEGO_DEVICE_ATTR_RO(version_product_tx_dongle, "product_version", TX_DONGLE, version);
   515	
 > 516	struct go_cfg_attr version_protocol_tx_dongle = { PROTOCOL_VERSION };
   517	LEGO_DEVICE_ATTR_RO(version_protocol_tx_dongle, "protocol_version", TX_DONGLE, version);
   518	
 > 519	struct go_cfg_attr version_firmware_tx_dongle = { FIRMWARE_VERSION };
   520	LEGO_DEVICE_ATTR_RO(version_firmware_tx_dongle, "firmware_version", TX_DONGLE, version);
   521	
 > 522	struct go_cfg_attr version_hardware_tx_dongle = { HARDWARE_VERSION };
   523	LEGO_DEVICE_ATTR_RO(version_hardware_tx_dongle, "hardware_version", TX_DONGLE, version);
   524	
 > 525	struct go_cfg_attr version_gen_tx_dongle = { HARDWARE_GENERATION };
   526	LEGO_DEVICE_ATTR_RO(version_gen_tx_dongle, "hardware_generation", TX_DONGLE, version);
   527	
   528	static struct attribute *tx_dongle_attrs[] = {
   529		&dev_attr_version_hardware_tx_dongle.attr,
   530		&dev_attr_version_firmware_tx_dongle.attr,
   531		&dev_attr_version_gen_tx_dongle.attr,
   532		&dev_attr_version_product_tx_dongle.attr,
   533		&dev_attr_version_protocol_tx_dongle.attr,
   534		NULL,
   535	};
   536	
   537	static const struct attribute_group tx_dongle_attr_group = {
   538		.name = "tx_dongle",
   539		.attrs = tx_dongle_attrs,
   540	};
   541	
   542	/* Gamepad - Left */
 > 543	struct go_cfg_attr version_product_left = { PRODUCT_VERSION };
   544	LEGO_DEVICE_ATTR_RO(version_product_left, "product_version", LEFT_CONTROLLER, version);
   545	
 > 546	struct go_cfg_attr version_protocol_left = { PROTOCOL_VERSION };
   547	LEGO_DEVICE_ATTR_RO(version_protocol_left, "protocol_version", LEFT_CONTROLLER, version);
   548	
 > 549	struct go_cfg_attr version_firmware_left = { FIRMWARE_VERSION };
   550	LEGO_DEVICE_ATTR_RO(version_firmware_left, "firmware_version", LEFT_CONTROLLER, version);
   551	
 > 552	struct go_cfg_attr version_hardware_left = { HARDWARE_VERSION };
   553	LEGO_DEVICE_ATTR_RO(version_hardware_left, "hardware_version", LEFT_CONTROLLER, version);
   554	
 > 555	struct go_cfg_attr version_gen_left = { HARDWARE_GENERATION };
   556	LEGO_DEVICE_ATTR_RO(version_gen_left, "hardware_generation", LEFT_CONTROLLER, version);
   557	
   558	static struct attribute *left_gamepad_attrs[] = {
   559		&dev_attr_version_hardware_left.attr,
   560		&dev_attr_version_firmware_left.attr,
   561		&dev_attr_version_gen_left.attr,
   562		&dev_attr_version_product_left.attr,
   563		&dev_attr_version_protocol_left.attr,
   564		NULL,
   565	};
   566	
   567	static const struct attribute_group left_gamepad_attr_group = {
   568		.name = "left_handle",
   569		.attrs = left_gamepad_attrs,
   570	};
   571	
   572	/* Gamepad - Right */
 > 573	struct go_cfg_attr version_product_right = { PRODUCT_VERSION };
   574	LEGO_DEVICE_ATTR_RO(version_product_right, "product_version", RIGHT_CONTROLLER, version);
   575	
 > 576	struct go_cfg_attr version_protocol_right = { PROTOCOL_VERSION };
   577	LEGO_DEVICE_ATTR_RO(version_protocol_right, "protocol_version", RIGHT_CONTROLLER, version);
   578	
 > 579	struct go_cfg_attr version_firmware_right = { FIRMWARE_VERSION };
   580	LEGO_DEVICE_ATTR_RO(version_firmware_right, "firmware_version", RIGHT_CONTROLLER, version);
   581	
 > 582	struct go_cfg_attr version_hardware_right = { HARDWARE_VERSION };
   583	LEGO_DEVICE_ATTR_RO(version_hardware_right, "hardware_version", RIGHT_CONTROLLER, version);
   584	
 > 585	struct go_cfg_attr version_gen_right = { HARDWARE_GENERATION };
   586	LEGO_DEVICE_ATTR_RO(version_gen_right, "hardware_generation", RIGHT_CONTROLLER, version);
   587	
   588	static struct attribute *right_gamepad_attrs[] = {
   589		&dev_attr_version_hardware_right.attr,
   590		&dev_attr_version_firmware_right.attr,
   591		&dev_attr_version_gen_right.attr,
   592		&dev_attr_version_product_right.attr,
   593		&dev_attr_version_protocol_right.attr,
   594		NULL,
   595	};
   596	
   597	static const struct attribute_group right_gamepad_attr_group = {
   598		.name = "right_handle",
   599		.attrs = right_gamepad_attrs,
   600	};
   601	
   602	/* Touchpad */
   603	static struct attribute *touchpad_attrs[] = {
   604		NULL,
   605	};
   606	
   607	static const struct attribute_group touchpad_attr_group = {
   608		.name = "touchpad",
   609		.attrs = touchpad_attrs,
   610	};
   611	
   612	static const struct attribute_group *top_level_attr_groups[] = {
   613		&mcu_attr_group,	  &tx_dongle_attr_group,
   614		&left_gamepad_attr_group, &right_gamepad_attr_group,
   615		&touchpad_attr_group,	  NULL,
   616	};
   617	
   618	static void cfg_setup(struct work_struct *work)
   619	{
   620		int ret;
   621	
   622		/* MCU Version Attrs */
   623		ret = mcu_property_out(drvdata.hdev, MCU_CONFIG_DATA, GET_VERSION_DATA,
 > 624				       PRODUCT_VERSION, USB_MCU, 0, 0);
   625		if (ret < 0) {
   626			dev_err(&drvdata.hdev->dev,
   627				"Failed to retrieve USB_MCU Product Version: %i\n", ret);
   628			return;
   629		}
   630	
   631		ret = mcu_property_out(drvdata.hdev, MCU_CONFIG_DATA, GET_VERSION_DATA,
   632				       PROTOCOL_VERSION, USB_MCU, 0, 0);
   633		if (ret < 0) {
   634			dev_err(&drvdata.hdev->dev,
   635				"Failed to retrieve USB_MCU Protocol Version: %i\n", ret);
   636			return;
   637		}
   638	
   639		ret = mcu_property_out(drvdata.hdev, MCU_CONFIG_DATA, GET_VERSION_DATA,
   640				       FIRMWARE_VERSION, USB_MCU, 0, 0);
   641		if (ret < 0) {
   642			dev_err(&drvdata.hdev->dev,
   643				"Failed to retrieve USB_MCU Firmware Version: %i\n", ret);
   644			return;
   645		}
   646	
   647		ret = mcu_property_out(drvdata.hdev, MCU_CONFIG_DATA, GET_VERSION_DATA,
   648				       HARDWARE_VERSION, USB_MCU, 0, 0);
   649		if (ret < 0) {
   650			dev_err(&drvdata.hdev->dev,
   651				"Failed to retrieve USB_MCU Hardware Version: %i\n", ret);
   652			return;
   653		}
   654	
   655		ret = mcu_property_out(drvdata.hdev, MCU_CONFIG_DATA, GET_VERSION_DATA,
   656				       HARDWARE_GENERATION, USB_MCU, 0, 0);
   657		if (ret < 0) {
   658			dev_err(&drvdata.hdev->dev,
   659				"Failed to retrieve USB_MCU Hardware Generation: %i\n", ret);
   660			return;
   661		}
   662	
   663		/* TX Dongle Version Attrs */
   664		ret = mcu_property_out(drvdata.hdev, MCU_CONFIG_DATA, GET_VERSION_DATA,
   665				       PRODUCT_VERSION, TX_DONGLE, 0, 0);
   666		if (ret < 0) {
   667			dev_err(&drvdata.hdev->dev,
   668				"Failed to retrieve TX_DONGLE Product Version: %i\n", ret);
   669			return;
   670		}
   671	
   672		ret = mcu_property_out(drvdata.hdev, MCU_CONFIG_DATA, GET_VERSION_DATA,
   673				       PROTOCOL_VERSION, TX_DONGLE, 0, 0);
   674		if (ret < 0) {
   675			dev_err(&drvdata.hdev->dev,
   676				"Failed to retrieve TX_DONGLE Protocol Version: %i\n", ret);
   677			return;
   678		}
   679	
   680		ret = mcu_property_out(drvdata.hdev, MCU_CONFIG_DATA, GET_VERSION_DATA,
   681				       FIRMWARE_VERSION, TX_DONGLE, 0, 0);
   682		if (ret < 0) {
   683			dev_err(&drvdata.hdev->dev,
   684				"Failed to retrieve TX_DONGLE Firmware Version: %i\n", ret);
   685			return;
   686		}
   687	
   688		ret = mcu_property_out(drvdata.hdev, MCU_CONFIG_DATA, GET_VERSION_DATA,
   689				       HARDWARE_VERSION, TX_DONGLE, 0, 0);
   690		if (ret < 0) {
   691			dev_err(&drvdata.hdev->dev,
   692				"Failed to retrieve TX_DONGLE Hardware Version: %i\n", ret);
   693			return;
   694		}
   695	
   696		ret = mcu_property_out(drvdata.hdev, MCU_CONFIG_DATA, GET_VERSION_DATA,
   697				       HARDWARE_GENERATION, TX_DONGLE, 0, 0);
   698		if (ret < 0) {
   699			dev_err(&drvdata.hdev->dev,
   700				"Failed to retrieve TX_DONGLE Hardware Generation: %i\n", ret);
   701			return;
   702		}
   703	
   704		/* Left Handle Version Attrs */
   705		ret = mcu_property_out(drvdata.hdev, MCU_CONFIG_DATA, GET_VERSION_DATA,
   706				       PRODUCT_VERSION, LEFT_CONTROLLER, 0, 0);
   707		if (ret < 0) {
   708			dev_err(&drvdata.hdev->dev,
   709				"Failed to retrieve LEFT_CONTROLLER Product Version: %i\n", ret);
   710			return;
   711		}
   712	
   713		ret = mcu_property_out(drvdata.hdev, MCU_CONFIG_DATA, GET_VERSION_DATA,
   714				       PROTOCOL_VERSION, LEFT_CONTROLLER, 0, 0);
   715		if (ret < 0) {
   716			dev_err(&drvdata.hdev->dev,
   717				"Failed to retrieve LEFT_CONTROLLER Protocol Version: %i\n", ret);
   718			return;
   719		}
   720	
   721		ret = mcu_property_out(drvdata.hdev, MCU_CONFIG_DATA, GET_VERSION_DATA,
   722				       FIRMWARE_VERSION, LEFT_CONTROLLER, 0, 0);
   723		if (ret < 0) {
   724			dev_err(&drvdata.hdev->dev,
   725				"Failed to retrieve LEFT_CONTROLLER Firmware Version: %i\n", ret);
   726			return;
   727		}
   728	
   729		ret = mcu_property_out(drvdata.hdev, MCU_CONFIG_DATA, GET_VERSION_DATA,
   730				       HARDWARE_VERSION, LEFT_CONTROLLER, 0, 0);
   731		if (ret < 0) {
   732			dev_err(&drvdata.hdev->dev,
   733				"Failed to retrieve LEFT_CONTROLLER Hardware Version: %i\n", ret);
   734			return;
   735		}
   736	
   737		ret = mcu_property_out(drvdata.hdev, MCU_CONFIG_DATA, GET_VERSION_DATA,
   738				       HARDWARE_GENERATION, LEFT_CONTROLLER, 0, 0);
   739		if (ret < 0) {
   740			dev_err(&drvdata.hdev->dev,
   741				"Failed to retrieve LEFT_CONTROLLER Hardware Generation: %i\n", ret);
   742			return;
   743		}
   744	
   745		/* Right Handle Version Attrs */
   746		ret = mcu_property_out(drvdata.hdev, MCU_CONFIG_DATA, GET_VERSION_DATA,
   747				       PRODUCT_VERSION, RIGHT_CONTROLLER, 0, 0);
   748		if (ret < 0) {
   749			dev_err(&drvdata.hdev->dev,
   750				"Failed to retrieve RIGHT_CONTROLLER Product Version: %i\n", ret);
   751			return;
   752		}
   753	
   754		ret = mcu_property_out(drvdata.hdev, MCU_CONFIG_DATA, GET_VERSION_DATA,
   755				       PROTOCOL_VERSION, RIGHT_CONTROLLER, 0, 0);
   756		if (ret < 0) {
   757			dev_err(&drvdata.hdev->dev,
   758				"Failed to retrieve RIGHT_CONTROLLER Protocol Version: %i\n", ret);
   759			return;
   760		}
   761	
   762		ret = mcu_property_out(drvdata.hdev, MCU_CONFIG_DATA, GET_VERSION_DATA,
   763				       FIRMWARE_VERSION, RIGHT_CONTROLLER, 0, 0);
   764		if (ret < 0) {
   765			dev_err(&drvdata.hdev->dev,
   766				"Failed to retrieve RIGHT_CONTROLLER Firmware Version: %i\n", ret);
   767			return;
   768		}
   769	
   770		ret = mcu_property_out(drvdata.hdev, MCU_CONFIG_DATA, GET_VERSION_DATA,
   771				       HARDWARE_VERSION, RIGHT_CONTROLLER, 0, 0);
   772		if (ret < 0) {
   773			dev_err(&drvdata.hdev->dev,
   774				"Failed to retrieve RIGHT_CONTROLLER Hardware Version: %i\n", ret);
   775			return;
   776		}
   777	
   778		ret = mcu_property_out(drvdata.hdev, MCU_CONFIG_DATA, GET_VERSION_DATA,
   779				       HARDWARE_GENERATION, RIGHT_CONTROLLER, 0, 0);
   780		if (ret < 0) {
   781			dev_err(&drvdata.hdev->dev,
   782				"Failed to retrieve RIGHT_CONTROLLER Hardware Generation: %i\n", ret);
   783			return;
   784		}
   785	}
   786	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C59A313E34
	for <linux-input@vger.kernel.org>; Sat,  7 Mar 2026 23:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772926646; cv=none; b=YbyFsCRidhXoABC3F9PfQpUFI82cw2QtzazKtYoS4+MuiKhYjJdGDPAT5Be7zX6UFrymI2rvh6hJqgNTWMkBe4AgUtIbtMRUBB2MTUWRMUt+5XdyR/BSqlYTz1OM4FHQ+4sU3xx7dOAA1d5icIsiL+HCDF6wyyrA93wTX1NlK6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772926646; c=relaxed/simple;
	bh=8vnqtUyW6fS9pCXWejiC337JSg9wi3l89WpSCEPzyZI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=TEBW/Js6khfB7XvQuHgTFmJ5E+wrX3Kt3IPaFoxd8G54k8+wjnj+tUcrueUr6LMsNKyxe+GFzx/szm0YZ5l6M2RlswjhTeKoJDM1tXdF1Sm+yUOFDSQH3a7oDHvsW8vqs+Q51G4r5oodxbz3Mj+FJLhMql/oU77CiYiK5jvqznQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VlTKQ9be; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VlTKQ9be"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772926645; x=1804462645;
  h=date:from:to:cc:subject:message-id;
  bh=8vnqtUyW6fS9pCXWejiC337JSg9wi3l89WpSCEPzyZI=;
  b=VlTKQ9bebgdPSD2vOTzFPV7z2h9hf0EblnwBmMcHxVjPsGMQzuZMBMoL
   nbn+7nkR6Q5RIE+aZwqXp2b6RJs8APmzoz1VtxhNRAUOOXIOJakwf3IFC
   367AXF29MGEX+Zu9LLbUfMEtZK20HO1ljvGLUS2LZotxwz1WOBKS6mAg4
   tNZGXsk+lLGfjRV/75KNuQCCb+RSrF6o4fOVupnXIXRL1d54LCkqDVV23
   udb8sQmZfG+tbG+v1EE6d0UHNLz6B/cX5EbxgIs6OWixs/Vvz/gqebtuC
   YNuA+WIIyfsM1Ww3k9WnqkIPbTzKCB+RLUQ4A4bK5Y7XUZwLKl1Wl+75I
   Q==;
X-CSE-ConnectionGUID: BTB0/mNXS2OOfA0jJr6Z0A==
X-CSE-MsgGUID: 3qOsyWnoTpadiIj6gO2m6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11722"; a="73912271"
X-IronPort-AV: E=Sophos;i="6.23,107,1770624000"; 
   d="scan'208";a="73912271"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2026 15:37:24 -0800
X-CSE-ConnectionGUID: wYHPBjzRQfqr7phjSGAhsA==
X-CSE-MsgGUID: 3Yv5IZNEQr+g4LQz60YPEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,107,1770624000"; 
   d="scan'208";a="218579932"
Received: from lkp-server01.sh.intel.com (HELO 058beb05654c) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 07 Mar 2026 15:37:23 -0800
Received: from kbuild by 058beb05654c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vz1Cx-000000002ip-1c7w;
	Sat, 07 Mar 2026 23:37:19 +0000
Date: Sun, 08 Mar 2026 07:36:28 +0800
From: kernel test robot <lkp@intel.com>
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-input@vger.kernel.org,
 Jiri Kosina <jikos@kernel.org>,
 Mark Pearson <mpearson-lenovo@squebb.ca>
Subject: [hid:for-7.1/lenovo 12/16]
 drivers/hid/hid-lenovo-go-s.c:583:21: sparse: sparse: symbol
 'gamepad_poll_rate' was not declared. Should it be static?
Message-ID: <202603080756.jqm0j0md-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-7.1/lenovo
head:   d2c424e80caf8237bda4c94bc2e25398967243f9
commit: 14651777fd67507d19574cd7e7835c16e6174853 [12/16] HID: hid-lenovo-go-s: Add Feature Status Attributes
config: arc-randconfig-r113-20260307 (https://download.01.org/0day-ci/archive/20260308/202603080756.jqm0j0md-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 13.4.0
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260308/202603080756.jqm0j0md-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603080756.jqm0j0md-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/hid/hid-lenovo-go-s.c:406:72: sparse: sparse: Using plain integer as NULL pointer
>> drivers/hid/hid-lenovo-go-s.c:583:21: sparse: sparse: symbol 'gamepad_poll_rate' was not declared. Should it be static?
>> drivers/hid/hid-lenovo-go-s.c:609:21: sparse: sparse: symbol 'imu_sensor_enabled' was not declared. Should it be static?
>> drivers/hid/hid-lenovo-go-s.c:645:21: sparse: sparse: symbol 'mouse_wheel_step' was not declared. Should it be static?
   drivers/hid/hid-lenovo-go-s.c:690:72: sparse: sparse: Using plain integer as NULL pointer
   drivers/hid/hid-lenovo-go-s.c:697:73: sparse: sparse: Using plain integer as NULL pointer
>> drivers/hid/hid-lenovo-go-s.c:407:21: sparse: sparse: unsigned value that used to be signed checked against zero?
   drivers/hid/hid-lenovo-go-s.c:406:33: sparse: signed value source

vim +/gamepad_poll_rate +583 drivers/hid/hid-lenovo-go-s.c

   398	
   399	static ssize_t gamepad_property_show(struct device *dev,
   400					     struct device_attribute *attr, char *buf,
   401					     enum feature_status_index index)
   402	{
   403		size_t count = 0;
   404		u8 i;
   405	
   406		count = mcu_property_out(drvdata.hdev, GET_GAMEPAD_CFG, index, 0, 0);
 > 407		if (count < 0)
   408			return count;
   409	
   410		switch (index) {
   411		case FEATURE_GAMEPAD_MODE:
   412			i = drvdata.gp_mode;
   413			if (i >= ARRAY_SIZE(gamepad_mode_text))
   414				return -EINVAL;
   415			count = sysfs_emit(buf, "%s\n", gamepad_mode_text[i]);
   416			break;
   417		case FEATURE_AUTO_SLEEP_TIME:
   418			count = sysfs_emit(buf, "%u\n", drvdata.gp_auto_sleep_time);
   419			break;
   420		case FEATURE_IMU_ENABLE:
   421			i = drvdata.imu_sensor_en;
   422			if (i >= ARRAY_SIZE(feature_enabled_text))
   423				return -EINVAL;
   424			count = sysfs_emit(buf, "%s\n", feature_enabled_text[i]);
   425			break;
   426		case FEATURE_IMU_BYPASS:
   427			i = drvdata.imu_bypass_en;
   428			if (i >= ARRAY_SIZE(feature_enabled_text))
   429				return -EINVAL;
   430			count = sysfs_emit(buf, "%s\n", feature_enabled_text[i]);
   431			break;
   432		case FEATURE_RGB_ENABLE:
   433			i = drvdata.rgb_en;
   434			if (i >= ARRAY_SIZE(feature_enabled_text))
   435				return -EINVAL;
   436			count = sysfs_emit(buf, "%s\n", feature_enabled_text[i]);
   437			break;
   438		case FEATURE_TOUCHPAD_ENABLE:
   439			i = drvdata.tp_en;
   440			if (i >= ARRAY_SIZE(feature_enabled_text))
   441				return -EINVAL;
   442			count = sysfs_emit(buf, "%s\n", feature_enabled_text[i]);
   443			break;
   444		case FEATURE_OS_MODE:
   445			i = drvdata.os_mode;
   446			if (i >= ARRAY_SIZE(os_type_text))
   447				return -EINVAL;
   448			count = sysfs_emit(buf, "%s\n", os_type_text[i]);
   449			break;
   450		case FEATURE_POLL_RATE:
   451			i = drvdata.gp_poll_rate;
   452			if (i >= ARRAY_SIZE(poll_rate_text))
   453				return -EINVAL;
   454			count = sysfs_emit(buf, "%s\n", poll_rate_text[i]);
   455			break;
   456		case FEATURE_DPAD_MODE:
   457			i = drvdata.gp_dpad_mode;
   458			if (i >= ARRAY_SIZE(dpad_mode_text))
   459				return -EINVAL;
   460			count = sysfs_emit(buf, "%s\n", dpad_mode_text[i]);
   461			break;
   462		case FEATURE_MOUSE_WHEEL_STEP:
   463			i = drvdata.mouse_step;
   464			if (i < 1 || i > 127)
   465				return -EINVAL;
   466			count = sysfs_emit(buf, "%u\n", i);
   467			break;
   468		default:
   469			return -EINVAL;
   470		}
   471	
   472		return count;
   473	}
   474	
   475	static ssize_t gamepad_property_options(struct device *dev,
   476						struct device_attribute *attr,
   477						char *buf,
   478						enum feature_status_index index)
   479	{
   480		size_t count = 0;
   481		unsigned int i;
   482	
   483		switch (index) {
   484		case FEATURE_GAMEPAD_MODE:
   485			for (i = 0; i < ARRAY_SIZE(gamepad_mode_text); i++) {
   486				count += sysfs_emit_at(buf, count, "%s ",
   487						       gamepad_mode_text[i]);
   488			}
   489			break;
   490		case FEATURE_AUTO_SLEEP_TIME:
   491			return sysfs_emit(buf, "0-255\n");
   492		case FEATURE_IMU_ENABLE:
   493			for (i = 0; i < ARRAY_SIZE(feature_enabled_text); i++) {
   494				count += sysfs_emit_at(buf, count, "%s ",
   495						       feature_enabled_text[i]);
   496			}
   497			break;
   498		case FEATURE_IMU_BYPASS:
   499		case FEATURE_RGB_ENABLE:
   500		case FEATURE_TOUCHPAD_ENABLE:
   501			for (i = 0; i < ARRAY_SIZE(feature_enabled_text); i++) {
   502				count += sysfs_emit_at(buf, count, "%s ",
   503						       feature_enabled_text[i]);
   504			}
   505			break;
   506		case FEATURE_OS_MODE:
   507			for (i = 0; i < ARRAY_SIZE(os_type_text); i++) {
   508				count += sysfs_emit_at(buf, count, "%s ",
   509						       os_type_text[i]);
   510			}
   511			break;
   512		case FEATURE_POLL_RATE:
   513			for (i = 0; i < ARRAY_SIZE(poll_rate_text); i++) {
   514				count += sysfs_emit_at(buf, count, "%s ",
   515						       poll_rate_text[i]);
   516			}
   517			break;
   518		case FEATURE_DPAD_MODE:
   519			for (i = 0; i < ARRAY_SIZE(dpad_mode_text); i++) {
   520				count += sysfs_emit_at(buf, count, "%s ",
   521						       dpad_mode_text[i]);
   522			}
   523			break;
   524		case FEATURE_MOUSE_WHEEL_STEP:
   525			return sysfs_emit(buf, "1-127\n");
   526		default:
   527			return count;
   528		}
   529	
   530		if (count)
   531			buf[count - 1] = '\n';
   532	
   533		return count;
   534	}
   535	
   536	static ssize_t mcu_id_show(struct device *dev, struct device_attribute *attr,
   537				   char *buf)
   538	{
   539		return sysfs_emit(buf, "%*phN\n", 12, &drvdata.mcu_id);
   540	}
   541	
   542	#define LEGOS_DEVICE_ATTR_RW(_name, _attrname, _rtype, _group)                 \
   543		static ssize_t _name##_store(struct device *dev,                       \
   544					     struct device_attribute *attr,            \
   545					     const char *buf, size_t count)            \
   546		{                                                                      \
   547			return _group##_property_store(dev, attr, buf, count,          \
   548						       _name.index);                   \
   549		}                                                                      \
   550		static ssize_t _name##_show(struct device *dev,                        \
   551					    struct device_attribute *attr, char *buf)  \
   552		{                                                                      \
   553			return _group##_property_show(dev, attr, buf, _name.index);    \
   554		}                                                                      \
   555		static ssize_t _name##_##_rtype##_show(                                \
   556			struct device *dev, struct device_attribute *attr, char *buf)  \
   557		{                                                                      \
   558			return _group##_property_options(dev, attr, buf, _name.index); \
   559		}                                                                      \
   560		static DEVICE_ATTR_RW_NAMED(_name, _attrname)
   561	
   562	#define LEGOS_DEVICE_ATTR_RO(_name, _attrname, _group)                        \
   563		static ssize_t _name##_show(struct device *dev,                       \
   564					    struct device_attribute *attr, char *buf) \
   565		{                                                                     \
   566			return _group##_property_show(dev, attr, buf, _name.index);   \
   567		}                                                                     \
   568		static DEVICE_ATTR_RO_NAMED(_name, _attrname)
   569	
   570	/* Gamepad */
   571	struct gos_cfg_attr auto_sleep_time = { FEATURE_AUTO_SLEEP_TIME };
   572	LEGOS_DEVICE_ATTR_RW(auto_sleep_time, "auto_sleep_time", range, gamepad);
   573	static DEVICE_ATTR_RO(auto_sleep_time_range);
   574	
   575	struct gos_cfg_attr dpad_mode = { FEATURE_DPAD_MODE };
   576	LEGOS_DEVICE_ATTR_RW(dpad_mode, "dpad_mode", index, gamepad);
   577	static DEVICE_ATTR_RO(dpad_mode_index);
   578	
   579	struct gos_cfg_attr gamepad_mode = { FEATURE_GAMEPAD_MODE };
   580	LEGOS_DEVICE_ATTR_RW(gamepad_mode, "mode", index, gamepad);
   581	static DEVICE_ATTR_RO_NAMED(gamepad_mode_index, "mode_index");
   582	
 > 583	struct gos_cfg_attr gamepad_poll_rate = { FEATURE_POLL_RATE };
   584	LEGOS_DEVICE_ATTR_RW(gamepad_poll_rate, "poll_rate", index, gamepad);
   585	static DEVICE_ATTR_RO_NAMED(gamepad_poll_rate_index, "poll_rate_index");
   586	
   587	static struct attribute *legos_gamepad_attrs[] = {
   588		&dev_attr_auto_sleep_time.attr,
   589		&dev_attr_auto_sleep_time_range.attr,
   590		&dev_attr_dpad_mode.attr,
   591		&dev_attr_dpad_mode_index.attr,
   592		&dev_attr_gamepad_mode.attr,
   593		&dev_attr_gamepad_mode_index.attr,
   594		&dev_attr_gamepad_poll_rate.attr,
   595		&dev_attr_gamepad_poll_rate_index.attr,
   596		NULL,
   597	};
   598	
   599	static const struct attribute_group gamepad_attr_group = {
   600		.name = "gamepad",
   601		.attrs = legos_gamepad_attrs,
   602	};
   603	
   604	/* IMU */
   605	struct gos_cfg_attr imu_bypass_enabled = { FEATURE_IMU_BYPASS };
   606	LEGOS_DEVICE_ATTR_RW(imu_bypass_enabled, "bypass_enabled", index, gamepad);
   607	static DEVICE_ATTR_RO_NAMED(imu_bypass_enabled_index, "bypass_enabled_index");
   608	
 > 609	struct gos_cfg_attr imu_sensor_enabled = { FEATURE_IMU_ENABLE };
   610	LEGOS_DEVICE_ATTR_RW(imu_sensor_enabled, "sensor_enabled", index, gamepad);
   611	static DEVICE_ATTR_RO_NAMED(imu_sensor_enabled_index, "sensor_enabled_index");
   612	
   613	static struct attribute *legos_imu_attrs[] = {
   614		&dev_attr_imu_bypass_enabled.attr,
   615		&dev_attr_imu_bypass_enabled_index.attr,
   616		&dev_attr_imu_sensor_enabled.attr,
   617		&dev_attr_imu_sensor_enabled_index.attr,
   618		NULL,
   619	};
   620	
   621	static const struct attribute_group imu_attr_group = {
   622		.name = "imu",
   623		.attrs = legos_imu_attrs,
   624	};
   625	
   626	/* MCU */
   627	static DEVICE_ATTR_RO(mcu_id);
   628	
   629	struct gos_cfg_attr os_mode = { FEATURE_OS_MODE };
   630	LEGOS_DEVICE_ATTR_RW(os_mode, "os_mode", index, gamepad);
   631	static DEVICE_ATTR_RO(os_mode_index);
   632	
   633	static struct attribute *legos_mcu_attrs[] = {
   634		&dev_attr_mcu_id.attr,
   635		&dev_attr_os_mode.attr,
   636		&dev_attr_os_mode_index.attr,
   637		NULL,
   638	};
   639	
   640	static const struct attribute_group mcu_attr_group = {
   641		.attrs = legos_mcu_attrs,
   642	};
   643	
   644	/* Mouse */
 > 645	struct gos_cfg_attr mouse_wheel_step = { FEATURE_MOUSE_WHEEL_STEP };
   646	LEGOS_DEVICE_ATTR_RW(mouse_wheel_step, "step", range, gamepad);
   647	static DEVICE_ATTR_RO_NAMED(mouse_wheel_step_range, "step_range");
   648	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

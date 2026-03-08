Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD90114A8E
	for <linux-input@vger.kernel.org>; Sun,  8 Mar 2026 08:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772960224; cv=none; b=KcPLX2piBfUXJPNeMKGQeb+oP/1OuIucdt9Sh7XaJhHIvUi86Yp4OgU9PsInX3Yh8JIyjsXPH+A3oISzqDzRTYjxgCJUzPfAYPQbkeT1lg5dDjGlv/k4qkv/ZAlQqnU8Maf1rJMHquTwMW6giIVtVuw1Ebe7eVRyzQUkoZztNjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772960224; c=relaxed/simple;
	bh=MZy+LCS88gKHIiB8EZ46afNGpOHcw9O+q166p9xrfVw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DPr0IRp1LuKMToNnEpmmHnulGC1+xBX/VGndL7A/hTciSUElFi/vVpHdObETTx2tKwsMMrQPfcrG9AwiXCqFZiteU89IuHn7wqqp7/x4ivgc103v825Y03Uj3iwGdj4pwgZSTFMghvq9VpqAwws8RNrmGbeEooPKh9eivLybK2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JC6khjbO; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JC6khjbO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772960223; x=1804496223;
  h=date:from:to:cc:subject:message-id;
  bh=MZy+LCS88gKHIiB8EZ46afNGpOHcw9O+q166p9xrfVw=;
  b=JC6khjbOfBuLVyeA9zpFtC1H45HpFuhXsZL8lQDeyeUlpGb/5Uu362Lc
   A0QVfVWjy/Qk6Xg68LKhhADBIID8SDtybOEupwWKE8l6h+liHyicY/XKj
   zP8ZZC801jBBH+985fCMvGjCJo4wWN8jrF4kBjjLOOY4D1QGHDUNpRi3c
   D2U/aROIc7ieI9raSlUerYCPknAAc6MTWfqavmDSWZ90rdBXM9wFthSgc
   mjlME5SeZTGBeFIEloCaW8+AjyEr3BZBQiJVAPYerFhppQ5ImRfa2iVrE
   ThHOeBYpMZ084CZfFVypIt9O3573/O26TIryhcQna9f8Hr1iiVTrsIjta
   w==;
X-CSE-ConnectionGUID: favD7ec0RMSv38fj0Et3ew==
X-CSE-MsgGUID: +0rPXafjSBa6mkp7FHCRzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11722"; a="74122029"
X-IronPort-AV: E=Sophos;i="6.23,108,1770624000"; 
   d="scan'208";a="74122029"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 00:57:02 -0800
X-CSE-ConnectionGUID: l8MG32PPQsSJw/DCMBJHPg==
X-CSE-MsgGUID: 9NZdZu38TZucrW1uJjy40g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,108,1770624000"; 
   d="scan'208";a="219420730"
Received: from lkp-server01.sh.intel.com (HELO 058beb05654c) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 08 Mar 2026 00:57:00 -0800
Received: from kbuild by 058beb05654c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vz9wX-00000000307-2gOP;
	Sun, 08 Mar 2026 08:56:57 +0000
Date: Sun, 08 Mar 2026 16:56:16 +0800
From: kernel test robot <lkp@intel.com>
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-input@vger.kernel.org,
 Jiri Kosina <jikos@kernel.org>,
 Mark Pearson <mpearson-lenovo@squebb.ca>
Subject: [hid:for-7.1/lenovo 15/16]
 drivers/hid/hid-lenovo-go-s.c:1175:21: sparse: sparse: symbol
 'imu_manufacturer' was not declared. Should it be static?
Message-ID: <202603081611.J61k8tIx-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-7.1/lenovo
head:   d2c424e80caf8237bda4c94bc2e25398967243f9
commit: 041eadd5f2d207dd1d286747d137a7d896dd7d5c [15/16] HID: hid-lenovo-go-s: Add IMU and Touchpad RO Attributes
config: arc-randconfig-r113-20260307 (https://download.01.org/0day-ci/archive/20260308/202603081611.J61k8tIx-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 13.4.0
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260308/202603081611.J61k8tIx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603081611.J61k8tIx-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/hid/hid-lenovo-go-s.c:582:72: sparse: sparse: Using plain integer as NULL pointer
   drivers/hid/hid-lenovo-go-s.c:754:67: sparse: sparse: Using plain integer as NULL pointer
   drivers/hid/hid-lenovo-go-s.c:856:63: sparse: sparse: Using plain integer as NULL pointer
   drivers/hid/hid-lenovo-go-s.c:1000:71: sparse: sparse: Using plain integer as NULL pointer
   drivers/hid/hid-lenovo-go-s.c:1055:74: sparse: sparse: Using plain integer as NULL pointer
   drivers/hid/hid-lenovo-go-s.c:1149:21: sparse: sparse: symbol 'gamepad_poll_rate' was not declared. Should it be static?
>> drivers/hid/hid-lenovo-go-s.c:1175:21: sparse: sparse: symbol 'imu_manufacturer' was not declared. Should it be static?
   drivers/hid/hid-lenovo-go-s.c:1178:21: sparse: sparse: symbol 'imu_sensor_enabled' was not declared. Should it be static?
   drivers/hid/hid-lenovo-go-s.c:1215:21: sparse: sparse: symbol 'mouse_wheel_step' was not declared. Should it be static?
   drivers/hid/hid-lenovo-go-s.c:1235:21: sparse: sparse: symbol 'touchpad_linux_mode' was not declared. Should it be static?
>> drivers/hid/hid-lenovo-go-s.c:1239:21: sparse: sparse: symbol 'touchpad_manufacturer' was not declared. Should it be static?
>> drivers/hid/hid-lenovo-go-s.c:1242:21: sparse: sparse: symbol 'touchpad_version' was not declared. Should it be static?
   drivers/hid/hid-lenovo-go-s.c:1245:21: sparse: sparse: symbol 'touchpad_windows_mode' was not declared. Should it be static?
   drivers/hid/hid-lenovo-go-s.c:1307:18: sparse: sparse: symbol 'gos_rgb_subled_info' was not declared. Should it be static?
   drivers/hid/hid-lenovo-go-s.c:1328:24: sparse: sparse: symbol 'gos_cdev_rgb' was not declared. Should it be static?
   drivers/hid/hid-lenovo-go-s.c:1344:72: sparse: sparse: Using plain integer as NULL pointer
   drivers/hid/hid-lenovo-go-s.c:1351:73: sparse: sparse: Using plain integer as NULL pointer
   drivers/hid/hid-lenovo-go-s.c:1357:72: sparse: sparse: Using plain integer as NULL pointer
   drivers/hid/hid-lenovo-go-s.c:1364:72: sparse: sparse: Using plain integer as NULL pointer
   drivers/hid/hid-lenovo-go-s.c:1371:73: sparse: sparse: Using plain integer as NULL pointer
   drivers/hid/hid-lenovo-go-s.c:583:21: sparse: sparse: unsigned value that used to be signed checked against zero?
   drivers/hid/hid-lenovo-go-s.c:582:33: sparse: signed value source

vim +/imu_manufacturer +1175 drivers/hid/hid-lenovo-go-s.c

  1174	
> 1175	struct gos_cfg_attr imu_manufacturer = { TEST_IMU_MFR };
  1176	LEGOS_DEVICE_ATTR_RO(imu_manufacturer, "manufacturer", test);
  1177	
  1178	struct gos_cfg_attr imu_sensor_enabled = { FEATURE_IMU_ENABLE };
  1179	LEGOS_DEVICE_ATTR_RW(imu_sensor_enabled, "sensor_enabled", index, gamepad);
  1180	static DEVICE_ATTR_RO_NAMED(imu_sensor_enabled_index, "sensor_enabled_index");
  1181	
  1182	static struct attribute *legos_imu_attrs[] = {
  1183		&dev_attr_imu_bypass_enabled.attr,
  1184		&dev_attr_imu_bypass_enabled_index.attr,
  1185		&dev_attr_imu_manufacturer.attr,
  1186		&dev_attr_imu_sensor_enabled.attr,
  1187		&dev_attr_imu_sensor_enabled_index.attr,
  1188		NULL,
  1189	};
  1190	
  1191	static const struct attribute_group imu_attr_group = {
  1192		.name = "imu",
  1193		.attrs = legos_imu_attrs,
  1194	};
  1195	
  1196	/* MCU */
  1197	static DEVICE_ATTR_RO(mcu_id);
  1198	
  1199	struct gos_cfg_attr os_mode = { FEATURE_OS_MODE };
  1200	LEGOS_DEVICE_ATTR_RW(os_mode, "os_mode", index, gamepad);
  1201	static DEVICE_ATTR_RO(os_mode_index);
  1202	
  1203	static struct attribute *legos_mcu_attrs[] = {
  1204		&dev_attr_mcu_id.attr,
  1205		&dev_attr_os_mode.attr,
  1206		&dev_attr_os_mode_index.attr,
  1207		NULL,
  1208	};
  1209	
  1210	static const struct attribute_group mcu_attr_group = {
  1211		.attrs = legos_mcu_attrs,
  1212	};
  1213	
  1214	/* Mouse */
  1215	struct gos_cfg_attr mouse_wheel_step = { FEATURE_MOUSE_WHEEL_STEP };
  1216	LEGOS_DEVICE_ATTR_RW(mouse_wheel_step, "step", range, gamepad);
  1217	static DEVICE_ATTR_RO_NAMED(mouse_wheel_step_range, "step_range");
  1218	
  1219	static struct attribute *legos_mouse_attrs[] = {
  1220		&dev_attr_mouse_wheel_step.attr,
  1221		&dev_attr_mouse_wheel_step_range.attr,
  1222		NULL,
  1223	};
  1224	
  1225	static const struct attribute_group mouse_attr_group = {
  1226		.name = "mouse",
  1227		.attrs = legos_mouse_attrs,
  1228	};
  1229	
  1230	/* Touchpad */
  1231	struct gos_cfg_attr touchpad_enabled = { FEATURE_TOUCHPAD_ENABLE };
  1232	LEGOS_DEVICE_ATTR_RW(touchpad_enabled, "enabled", index, gamepad);
  1233	static DEVICE_ATTR_RO_NAMED(touchpad_enabled_index, "enabled_index");
  1234	
  1235	struct gos_cfg_attr touchpad_linux_mode = { CFG_LINUX_MODE };
  1236	LEGOS_DEVICE_ATTR_RW(touchpad_linux_mode, "linux_mode", index, touchpad);
  1237	static DEVICE_ATTR_RO_NAMED(touchpad_linux_mode_index, "linux_mode_index");
  1238	
> 1239	struct gos_cfg_attr touchpad_manufacturer = { TEST_TP_MFR };
  1240	LEGOS_DEVICE_ATTR_RO(touchpad_manufacturer, "manufacturer", test);
  1241	
> 1242	struct gos_cfg_attr touchpad_version = { TEST_TP_VER };
  1243	LEGOS_DEVICE_ATTR_RO(touchpad_version, "version", test);
  1244	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

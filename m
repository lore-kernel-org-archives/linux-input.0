Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5231F0E29
	for <linux-input@vger.kernel.org>; Sun,  8 Mar 2026 05:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772948218; cv=none; b=Cq+RzoVldnI0wg7smLHB73i0oiQePHt5ZDAoUoNWdYMVN1b0gESNjlGAyWK2uflk0jOWGgAX6yhQu9HjUp7eozMRAa8yt4TqmWWLgaiCl3ikNUn5tW+n7KqDbB9birP00NiTaiLsIT//CYlyYzAM89/Docb+93MIbYZtrj7mVXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772948218; c=relaxed/simple;
	bh=IhDFq/wwmoPNZKnRkO9286+FIGY4T9EwGWiSkMp03jw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=lPGyz+J/050D+guNCmvIvJFIoyXI1EsolxAeZA2LeB/TK4llZy/iQCq4NSy7t22GA29t3kVVZCE3rRxABL9/6wKVkuQdReiBjwuBvnimtwFjBbTvHt6IAE+utvjksXVVcWjLkatHj7AkpA/m9Ax53iDU+IlnM+D+n14MU67L0ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cq1kIn5t; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cq1kIn5t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772948216; x=1804484216;
  h=date:from:to:cc:subject:message-id;
  bh=IhDFq/wwmoPNZKnRkO9286+FIGY4T9EwGWiSkMp03jw=;
  b=cq1kIn5tnPMESyuIlFu0YCQ2xHc9AMZI5zrZIg/nKAMiTK/sy93O3Ixf
   dOhHrJolPxuaBpGPdAt7BuFeq5+nZFWYomV4J1aPdznpuzKzejUUX2yEq
   EOotP3C1m2s7pchtBAW+D0ugjTwRLuPqIGxI7jAqJjyWOaadgfV3Bts/T
   8hLUIYyp1pxzzAaJfqdmcR0OGqorlwbWD3JHpw50n0f6DyqTnwWglXK4o
   hEKbeRiDBP4Lk7rFilLaSu6gv+0zvr4GSM8TQYuhnixuHH0uMNXOtS1nK
   t5lrFSKi/KyjTWVfNeC4LDHzpc/UmzrTysbjIKFXOI7ghYXqaQQpjdbZ5
   Q==;
X-CSE-ConnectionGUID: aRDiwjpZRV2E1fnYZJZQaQ==
X-CSE-MsgGUID: MEa8Zp2ZQaGIYG48TkhD5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11722"; a="85357655"
X-IronPort-AV: E=Sophos;i="6.23,108,1770624000"; 
   d="scan'208";a="85357655"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2026 21:36:56 -0800
X-CSE-ConnectionGUID: Ufs+jFVAT0amYRejGCXUPw==
X-CSE-MsgGUID: HhQLYUNiRVmhLXL8cY0I2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,108,1770624000"; 
   d="scan'208";a="219524562"
Received: from lkp-server01.sh.intel.com (HELO 058beb05654c) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 07 Mar 2026 21:36:54 -0800
Received: from kbuild by 058beb05654c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vz6os-000000002vz-3QgA;
	Sun, 08 Mar 2026 05:36:50 +0000
Date: Sun, 08 Mar 2026 13:36:14 +0800
From: kernel test robot <lkp@intel.com>
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-input@vger.kernel.org,
 Jiri Kosina <jikos@kernel.org>,
 Mark Pearson <mpearson-lenovo@squebb.ca>
Subject: [hid:for-7.1/lenovo 14/16]
 drivers/hid/hid-lenovo-go-s.c:1204:18: sparse: sparse: symbol
 'gos_rgb_subled_info' was not declared. Should it be static?
Message-ID: <202603081333.9m9vOhOR-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-7.1/lenovo
head:   d2c424e80caf8237bda4c94bc2e25398967243f9
commit: 550752e2c153663c3a374b048535654073007c90 [14/16] HID: hid-lenovo-go-s: Add RGB LED control interface
config: arc-randconfig-r113-20260307 (https://download.01.org/0day-ci/archive/20260308/202603081333.9m9vOhOR-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 13.4.0
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260308/202603081333.9m9vOhOR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603081333.9m9vOhOR-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/hid/hid-lenovo-go-s.c:522:72: sparse: sparse: Using plain integer as NULL pointer
   drivers/hid/hid-lenovo-go-s.c:694:67: sparse: sparse: Using plain integer as NULL pointer
   drivers/hid/hid-lenovo-go-s.c:765:63: sparse: sparse: Using plain integer as NULL pointer
   drivers/hid/hid-lenovo-go-s.c:909:71: sparse: sparse: Using plain integer as NULL pointer
   drivers/hid/hid-lenovo-go-s.c:964:74: sparse: sparse: Using plain integer as NULL pointer
   drivers/hid/hid-lenovo-go-s.c:1058:21: sparse: sparse: symbol 'gamepad_poll_rate' was not declared. Should it be static?
   drivers/hid/hid-lenovo-go-s.c:1084:21: sparse: sparse: symbol 'imu_sensor_enabled' was not declared. Should it be static?
   drivers/hid/hid-lenovo-go-s.c:1120:21: sparse: sparse: symbol 'mouse_wheel_step' was not declared. Should it be static?
   drivers/hid/hid-lenovo-go-s.c:1140:21: sparse: sparse: symbol 'touchpad_linux_mode' was not declared. Should it be static?
   drivers/hid/hid-lenovo-go-s.c:1144:21: sparse: sparse: symbol 'touchpad_windows_mode' was not declared. Should it be static?
>> drivers/hid/hid-lenovo-go-s.c:1204:18: sparse: sparse: symbol 'gos_rgb_subled_info' was not declared. Should it be static?
>> drivers/hid/hid-lenovo-go-s.c:1225:24: sparse: sparse: symbol 'gos_cdev_rgb' was not declared. Should it be static?
   drivers/hid/hid-lenovo-go-s.c:1241:72: sparse: sparse: Using plain integer as NULL pointer
   drivers/hid/hid-lenovo-go-s.c:1248:73: sparse: sparse: Using plain integer as NULL pointer
   drivers/hid/hid-lenovo-go-s.c:523:21: sparse: sparse: unsigned value that used to be signed checked against zero?
   drivers/hid/hid-lenovo-go-s.c:522:33: sparse: signed value source

vim +/gos_rgb_subled_info +1204 drivers/hid/hid-lenovo-go-s.c

  1203	
> 1204	struct mc_subled gos_rgb_subled_info[] = {
  1205		{
  1206			.color_index = LED_COLOR_ID_RED,
  1207			.brightness = 0x50,
  1208			.intensity = 0x24,
  1209			.channel = 0x1,
  1210		},
  1211		{
  1212			.color_index = LED_COLOR_ID_GREEN,
  1213			.brightness = 0x50,
  1214			.intensity = 0x22,
  1215			.channel = 0x2,
  1216		},
  1217		{
  1218			.color_index = LED_COLOR_ID_BLUE,
  1219			.brightness = 0x50,
  1220			.intensity = 0x99,
  1221			.channel = 0x3,
  1222		},
  1223	};
  1224	
> 1225	struct led_classdev_mc gos_cdev_rgb = {
  1226		.led_cdev = {
  1227			.name = "go_s:rgb:joystick_rings",
  1228			.brightness = 0x50,
  1229			.max_brightness = 0x64,
  1230			.brightness_set = hid_gos_brightness_set,
  1231		},
  1232		.num_colors = ARRAY_SIZE(gos_rgb_subled_info),
  1233		.subled_info = gos_rgb_subled_info,
  1234	};
  1235	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884E4221F03
	for <linux-input@vger.kernel.org>; Sun,  8 Mar 2026 02:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772937460; cv=none; b=rxGk5AsPDg2D7R5XTf/5Jh/vjMB4agaLM7sibOZjh/B62BcLS78mMsHdsMi5F3lR5eysKAy039TyqJ1r6lVHCnGxBh6JGGvLpYfdCioKo0C6zoe5LwEYHQeVJ4WK6PRV9AYAq/US6TSYrkOBWaubhwU7hX2NlOuDC1HH/SMMLJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772937460; c=relaxed/simple;
	bh=0/q0iz8B03RaU9USCuiioHgEj9qaf9h6pqPz+VE7jLc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=b3jKgsdvAOHNmkFnL8aiyELquWw13Vrx7uj0o/q6PlWf49spdAonbwHge0hdZrEdQqFZfXpCyR7EXHXon13KuYhlAtNHDWRr4+lobzlzcrfVI0ET/ZuECobvB+bahhMn3M8ueSHcttjidl4VeBFgoiCVfD2LwAl/7MMqCwWsDRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AC9tBzeK; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AC9tBzeK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772937458; x=1804473458;
  h=date:from:to:cc:subject:message-id;
  bh=0/q0iz8B03RaU9USCuiioHgEj9qaf9h6pqPz+VE7jLc=;
  b=AC9tBzeKTP0sa4pPq4vM9l4slqqzJHju8KYnMgWuLmH5Vji+l5uYaf6A
   Pg43SjPUUzNBrwcsgsTT3Fe22NA9WE9bM+jGfyTGw9G3jCUHiRL4nikdA
   ODfo04lQvCOzbzoJabHcFARHKyoUVl4GYfteP3Nh/Upib4TW2iQodMF9x
   o0kM1kizxEpec2G248cRfD/+R5fHmvRmwvG06+YM3fnMV2ykCv2jsQUND
   Ro3OtvsMunBC2dUpgKUzsPNSmYox90O2GRpxYgP4UgPzA/dAvUtOQS2wQ
   NR2Pz4NnHkeVnW6Cu6DnKsr+gsWk9CNbNfRjn6Bb9ZfxXdmKG+rDWVJCs
   A==;
X-CSE-ConnectionGUID: QxoTqZK2SNWPWViIfeu9rQ==
X-CSE-MsgGUID: hm5DP7PlSCilF66DZGSBOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11722"; a="61572691"
X-IronPort-AV: E=Sophos;i="6.23,107,1770624000"; 
   d="scan'208";a="61572691"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2026 18:37:38 -0800
X-CSE-ConnectionGUID: pMbxf3ZRR6ewkw+I+tw+Og==
X-CSE-MsgGUID: IAqaNfrXTt2o+nSw7Xt+Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,107,1770624000"; 
   d="scan'208";a="216421824"
Received: from lkp-server01.sh.intel.com (HELO 058beb05654c) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 07 Mar 2026 18:37:36 -0800
Received: from kbuild by 058beb05654c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vz41N-000000002qB-1kQz;
	Sun, 08 Mar 2026 02:37:33 +0000
Date: Sun, 08 Mar 2026 10:37:10 +0800
From: kernel test robot <lkp@intel.com>
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-input@vger.kernel.org,
 Jiri Kosina <jikos@kernel.org>,
 Mark Pearson <mpearson-lenovo@squebb.ca>
Subject: [hid:for-7.1/lenovo 13/16]
 drivers/hid/hid-lenovo-go-s.c:795:21: sparse: sparse: symbol
 'touchpad_linux_mode' was not declared. Should it be static?
Message-ID: <202603081041.UgxXYvsF-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-7.1/lenovo
head:   d2c424e80caf8237bda4c94bc2e25398967243f9
commit: f3ac4e11aaf3cd334d7f2cb205851bd157a2535f [13/16] HID: hid-lenovo-go-s: Add Touchpad Mode Attributes
config: arc-randconfig-r113-20260307 (https://download.01.org/0day-ci/archive/20260308/202603081041.UgxXYvsF-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 13.4.0
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260308/202603081041.UgxXYvsF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603081041.UgxXYvsF-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/hid/hid-lenovo-go-s.c:447:72: sparse: sparse: Using plain integer as NULL pointer
   drivers/hid/hid-lenovo-go-s.c:619:67: sparse: sparse: Using plain integer as NULL pointer
   drivers/hid/hid-lenovo-go-s.c:713:21: sparse: sparse: symbol 'gamepad_poll_rate' was not declared. Should it be static?
   drivers/hid/hid-lenovo-go-s.c:739:21: sparse: sparse: symbol 'imu_sensor_enabled' was not declared. Should it be static?
   drivers/hid/hid-lenovo-go-s.c:775:21: sparse: sparse: symbol 'mouse_wheel_step' was not declared. Should it be static?
>> drivers/hid/hid-lenovo-go-s.c:795:21: sparse: sparse: symbol 'touchpad_linux_mode' was not declared. Should it be static?
>> drivers/hid/hid-lenovo-go-s.c:799:21: sparse: sparse: symbol 'touchpad_windows_mode' was not declared. Should it be static?
   drivers/hid/hid-lenovo-go-s.c:832:72: sparse: sparse: Using plain integer as NULL pointer
   drivers/hid/hid-lenovo-go-s.c:839:73: sparse: sparse: Using plain integer as NULL pointer
   drivers/hid/hid-lenovo-go-s.c:448:21: sparse: sparse: unsigned value that used to be signed checked against zero?
   drivers/hid/hid-lenovo-go-s.c:447:33: sparse: signed value source

vim +/touchpad_linux_mode +795 drivers/hid/hid-lenovo-go-s.c

   794	
 > 795	struct gos_cfg_attr touchpad_linux_mode = { CFG_LINUX_MODE };
   796	LEGOS_DEVICE_ATTR_RW(touchpad_linux_mode, "linux_mode", index, touchpad);
   797	static DEVICE_ATTR_RO_NAMED(touchpad_linux_mode_index, "linux_mode_index");
   798	
 > 799	struct gos_cfg_attr touchpad_windows_mode = { CFG_WINDOWS_MODE };
   800	LEGOS_DEVICE_ATTR_RW(touchpad_windows_mode, "windows_mode", index, touchpad);
   801	static DEVICE_ATTR_RO_NAMED(touchpad_windows_mode_index, "windows_mode_index");
   802	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

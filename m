Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEC330148B
	for <linux-input@vger.kernel.org>; Mon,  2 Mar 2026 16:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772469539; cv=none; b=gdiLRRVGg75zsoW7qn2//dy3TCuK6MOCVYIcG5PzgTX0dQXpHUI1EM2kxvJsrf/9eH4/qlcZh8uZi1YXqUH1cKdDd0zFHoIN6UqjMDhKMK73JhpyFXKy3pG/ay1CkIEHhkgLgIKgvht4geNdFuGYmhZhkcvKlww6rsP8BXZLNFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772469539; c=relaxed/simple;
	bh=BnD41J9EWWnNSBcvlI67/jPU7UvAJtU1+n6dboqp8V8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=JJUY7AolmWehN4AgC7oyesSU8wruOHWwcnmNaKR+LmUhZTfmgfM5Vip8Z9QkQ1IdZ6H7q0UCB0wGFEo9vOancggFNh4x7VE5nPTSFGHQcWLS68smI9JADFYhVm8YfBO2ym+6Z+Q/S91SGjSc7L6X1l3dF7zc0HLYXsHCSf/JAqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e/YaWOdS; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e/YaWOdS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772469537; x=1804005537;
  h=date:from:to:cc:subject:message-id;
  bh=BnD41J9EWWnNSBcvlI67/jPU7UvAJtU1+n6dboqp8V8=;
  b=e/YaWOdSKvUrGQ2TfXBX2Rqkywpi1u25It0Vi6wiI300CBjdn4CMFHcp
   FXMvYUpE80LSP5DsgUyrzQAB6bWOrIjVdWKKdBf2K+3HuQm/gL/uGQNqs
   /9MmgXOVj+NibgWM6WN9tkU29f3442wrIQCeP85yvnFyuQPajYhuE+GTw
   GcHBFcMTdMuBwQw2YhcyWwv/sPQlQXghFihfMVIrS96qVmI0ZIJCtKLwo
   NNK2M6ZPCHour6UpRUgw3MSpOO97r1HKI/Cz22+E2qHLwqOk2QrP2bgXY
   G08ZnPKdcEsBJl5gcyVO10+JQgoBIag5VcD51G2wXWoeTm2S4z760TIPM
   w==;
X-CSE-ConnectionGUID: w2HGFxPGQlG5T3tp0jiqZA==
X-CSE-MsgGUID: lgGYiG4nS3+AI+EY0iJGCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="98953628"
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="98953628"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 08:38:56 -0800
X-CSE-ConnectionGUID: CyG3q93BRhmJQyRBYiVCmA==
X-CSE-MsgGUID: kppEJWKNQu6xs0TzytrWww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="244733810"
Received: from lkp-server01.sh.intel.com (HELO f27a57aa7a36) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 02 Mar 2026 08:38:54 -0800
Received: from kbuild by f27a57aa7a36 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vx6IF-0000000018r-3PcG;
	Mon, 02 Mar 2026 16:38:51 +0000
Date: Tue, 03 Mar 2026 00:38:00 +0800
From: kernel test robot <lkp@intel.com>
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-input@vger.kernel.org,
 Jiri Kosina <jikos@kernel.org>,
 Mark Pearson <mpearson-lenovo@squebb.ca>
Subject: [hid:for-7.1/lenovo 14/16]
 drivers/hid/hid-lenovo-go-s.c:1173: multiple definition of `rgb_enabled';
 drivers/hid/hid-lenovo-go.o:drivers/hid/hid-lenovo-go.c:2122: first defined
 here
Message-ID: <202603030044.qd0XVpQ5-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-7.1/lenovo
head:   d2c424e80caf8237bda4c94bc2e25398967243f9
commit: 550752e2c153663c3a374b048535654073007c90 [14/16] HID: hid-lenovo-go-s: Add RGB LED control interface
config: loongarch-randconfig-r053-20260301 (https://download.01.org/0day-ci/archive/20260303/202603030044.qd0XVpQ5-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260303/202603030044.qd0XVpQ5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603030044.qd0XVpQ5-lkp@intel.com/

All errors (new ones prefixed by >>):

   loongarch64-linux-ld: drivers/hid/hid-lenovo-go-s.o: in function `.LANCHOR4':
>> drivers/hid/hid-lenovo-go-s.c:1173: multiple definition of `rgb_enabled'; drivers/hid/hid-lenovo-go.o:drivers/hid/hid-lenovo-go.c:2122: first defined here
   loongarch64-linux-ld: drivers/hid/hid-lenovo-go-s.o: in function `.LANCHOR4':
   drivers/hid/hid-lenovo-go-s.c:1136: multiple definition of `touchpad_enabled'; drivers/hid/hid-lenovo-go.o:drivers/hid/hid-lenovo-go.c:2083: first defined here
   loongarch64-linux-ld: drivers/hid/hid-lenovo-go-s.o: in function `.LANCHOR4':
   drivers/hid/hid-lenovo-go-s.c:1054: multiple definition of `gamepad_mode'; drivers/hid/hid-lenovo-go.o:drivers/hid/hid-lenovo-go.c:1792: first defined here
   loongarch64-linux-ld: drivers/hid/hid-lenovo-go-s.o: in function `.LANCHOR2':
   drivers/hid/hid-lenovo-go-s.c:58: multiple definition of `drvdata'; drivers/hid/hid-lenovo-go.o:drivers/hid/hid-lenovo-go.c:93: first defined here


vim +1173 drivers/hid/hid-lenovo-go-s.c

  1171	
  1172	/* RGB */
> 1173	struct gos_cfg_attr rgb_enabled = { FEATURE_RGB_ENABLE };
  1174	LEGOS_DEVICE_ATTR_RW(rgb_enabled, "enabled", index, gamepad);
  1175	static DEVICE_ATTR_RO_NAMED(rgb_enabled_index, "enabled_index");
  1176	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B042031814F;
	Wed,  4 Feb 2026 21:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770239319; cv=none; b=eEMr24hFaP9MxY+j8YdNvlUH30d9iQcecczZzEMS1eS3Zh88MRm8GO3m4ItwrE+blRSQa5VTYrBQ/G1R9NBExE4w73Ft6PuVA/j70ztqhckS5lmcOvHm5KzNKMZlhMr+2FLFcXVfZ6pTjQGw8UziLeNc+kJx1F55w2ri5qpe+90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770239319; c=relaxed/simple;
	bh=ykZMW0n/OymBHp4Vhbjxh3NXA724SdAeQAxdcV/9Jl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dF6JJoorZm9w0LSAnCYjzSteTxqUnU2XVTTjaxgedKsALo9sv4mpZbPMVGWTCTe44isI29Hjhvlm/qL2S/1GUWz06c62EJRLTrrCcK2nn5iJFOW7wWxdhxmHfn9r2HM1RdLW11cWqqm/asDPWJwzKcMtr+nR6q+FVTgh5/2DKP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fA3Q1R38; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fA3Q1R38"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770239319; x=1801775319;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ykZMW0n/OymBHp4Vhbjxh3NXA724SdAeQAxdcV/9Jl8=;
  b=fA3Q1R38rXOmqWUimUO0hC9A1a2CfwQ0gh3VQlxOY3mi6YVRySokH3W3
   BkeSioUV0bSOieq9ryk6uOQkjVbEJk/XBwGJTYbRfg4Jn5mSiDSx3hjAv
   PLXZOMoXtcNyGcKWTS5aQbN4krRIAK9rLX5g27p71wBBE2KD1wAWY9aJD
   t5bkgH7XkIUciKU8pJ8zrivO6XDG7t95uJ/OYuO4BqLEh4VSBo5PzX7fe
   KY/TmGDOTCuOZTgba0+SpissByeb0iBZnTXnGAneWr2jG1IvjNLVnoxnY
   SQzuJRCwSxQBreFmaonLI1cPlaAGMJSeETOeBPemHMjf0ewrXqvecKOMI
   A==;
X-CSE-ConnectionGUID: R8pMUwKjSzetQQ+uHB6jgQ==
X-CSE-MsgGUID: hv9sbVSzQb+LWyqiiYikVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71163732"
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; 
   d="scan'208";a="71163732"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 13:08:39 -0800
X-CSE-ConnectionGUID: eloDUkoTT361vrMnJFHHRg==
X-CSE-MsgGUID: 5vO55lB4Sz6ut1vF9qqyNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; 
   d="scan'208";a="210375458"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 04 Feb 2026 13:08:36 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vnk6z-00000000jAm-2oW6;
	Wed, 04 Feb 2026 21:08:33 +0000
Date: Thu, 5 Feb 2026 05:07:56 +0800
From: kernel test robot <lkp@intel.com>
To: Tomasz =?utf-8?Q?Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>,
	jikos@kernel.org, bentiss@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, oleg@makarenk.ooo,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	tomasz.pakula.oficjalny@gmail.com
Subject: Re: [PATCH v2] HID: pidff: Fix condition effect bit clearing
Message-ID: <202602050440.e5LEMod6-lkp@intel.com>
References: <20260204133138.475880-1-tomasz.pakula.oficjalny@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204133138.475880-1-tomasz.pakula.oficjalny@gmail.com>

Hi Tomasz,

kernel test robot noticed the following build warnings:

[auto build test WARNING on hid/for-next]
[also build test WARNING on linus/master v6.19-rc8 next-20260204]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tomasz-Paku-a/HID-pidff-Fix-condition-effect-bit-clearing/20260204-213418
base:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-next
patch link:    https://lore.kernel.org/r/20260204133138.475880-1-tomasz.pakula.oficjalny%40gmail.com
patch subject: [PATCH v2] HID: pidff: Fix condition effect bit clearing
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20260205/202602050440.e5LEMod6-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260205/202602050440.e5LEMod6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602050440.e5LEMod6-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/hid/usbhid/hid-pidff.c:1456:7: warning: use of bitwise '|' with boolean operands [-Wbitwise-instead-of-logical]
    1456 |                 if (test_and_clear_bit(FF_SPRING, dev->ffbit)   |
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1457 |                     test_and_clear_bit(FF_DAMPER, dev->ffbit)   |
         |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1458 |                     test_and_clear_bit(FF_FRICTION, dev->ffbit) |
         |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                                                 ||
    1459 |                     test_and_clear_bit(FF_INERTIA, dev->ffbit))
         |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hid/usbhid/hid-pidff.c:1456:7: note: cast one or both operands to int to silence this warning
>> drivers/hid/usbhid/hid-pidff.c:1456:7: warning: use of bitwise '|' with boolean operands [-Wbitwise-instead-of-logical]
    1456 |                 if (test_and_clear_bit(FF_SPRING, dev->ffbit)   |
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1457 |                     test_and_clear_bit(FF_DAMPER, dev->ffbit)   |
         |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                                                 ||
    1458 |                     test_and_clear_bit(FF_FRICTION, dev->ffbit) |
         |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hid/usbhid/hid-pidff.c:1456:7: note: cast one or both operands to int to silence this warning
>> drivers/hid/usbhid/hid-pidff.c:1456:7: warning: use of bitwise '|' with boolean operands [-Wbitwise-instead-of-logical]
    1456 |                 if (test_and_clear_bit(FF_SPRING, dev->ffbit)   |
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                                                 ||
    1457 |                     test_and_clear_bit(FF_DAMPER, dev->ffbit)   |
         |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hid/usbhid/hid-pidff.c:1456:7: note: cast one or both operands to int to silence this warning
   3 warnings generated.


vim +1456 drivers/hid/usbhid/hid-pidff.c

  1398	
  1399	#define PIDFF_FIND_FIELDS(name, report, strict) \
  1400		pidff_find_fields(pidff->name, pidff_ ## name, \
  1401			pidff->reports[report], \
  1402			ARRAY_SIZE(pidff_ ## name), strict, &pidff->quirks)
  1403	
  1404	/*
  1405	 * Fill and check the pidff_usages
  1406	 */
  1407	static int pidff_init_fields(struct pidff_device *pidff, struct input_dev *dev)
  1408	{
  1409		if (PIDFF_FIND_FIELDS(set_effect, PID_SET_EFFECT, 1)) {
  1410			hid_err(pidff->hid, "unknown set_effect report layout\n");
  1411			return -ENODEV;
  1412		}
  1413	
  1414		PIDFF_FIND_FIELDS(block_load, PID_BLOCK_LOAD, 0);
  1415		if (!pidff->block_load[PID_EFFECT_BLOCK_INDEX].value) {
  1416			hid_err(pidff->hid, "unknown pid_block_load report layout\n");
  1417			return -ENODEV;
  1418		}
  1419	
  1420		if (PIDFF_FIND_FIELDS(effect_operation, PID_EFFECT_OPERATION, 1)) {
  1421			hid_err(pidff->hid, "unknown effect_operation report layout\n");
  1422			return -ENODEV;
  1423		}
  1424	
  1425		if (PIDFF_FIND_FIELDS(block_free, PID_BLOCK_FREE, 1)) {
  1426			hid_err(pidff->hid, "unknown pid_block_free report layout\n");
  1427			return -ENODEV;
  1428		}
  1429	
  1430		if (pidff_find_special_fields(pidff) || pidff_find_effects(pidff, dev))
  1431			return -ENODEV;
  1432	
  1433		if (PIDFF_FIND_FIELDS(set_envelope, PID_SET_ENVELOPE, 1)) {
  1434			if (test_and_clear_bit(FF_CONSTANT, dev->ffbit))
  1435				hid_warn(pidff->hid,
  1436					 "has constant effect but no envelope\n");
  1437			if (test_and_clear_bit(FF_RAMP, dev->ffbit))
  1438				hid_warn(pidff->hid,
  1439					 "has ramp effect but no envelope\n");
  1440	
  1441			if (test_and_clear_bit(FF_PERIODIC, dev->ffbit))
  1442				hid_warn(pidff->hid,
  1443					 "has periodic effect but no envelope\n");
  1444		}
  1445	
  1446		if (PIDFF_FIND_FIELDS(set_constant, PID_SET_CONSTANT, 1) &&
  1447		    test_and_clear_bit(FF_CONSTANT, dev->ffbit))
  1448			hid_warn(pidff->hid, "unknown constant effect layout\n");
  1449	
  1450		if (PIDFF_FIND_FIELDS(set_ramp, PID_SET_RAMP, 1) &&
  1451		    test_and_clear_bit(FF_RAMP, dev->ffbit))
  1452			hid_warn(pidff->hid, "unknown ramp effect layout\n");
  1453	
  1454		if (PIDFF_FIND_FIELDS(set_condition, PID_SET_CONDITION, 1)) {
  1455			/* Bitwise to ensure all the bits will be cleared */
> 1456			if (test_and_clear_bit(FF_SPRING, dev->ffbit)   |
  1457			    test_and_clear_bit(FF_DAMPER, dev->ffbit)   |
  1458			    test_and_clear_bit(FF_FRICTION, dev->ffbit) |
  1459			    test_and_clear_bit(FF_INERTIA, dev->ffbit))
  1460				hid_warn(pidff->hid, "unknown condition effect layout\n");
  1461		}
  1462	
  1463		if (PIDFF_FIND_FIELDS(set_periodic, PID_SET_PERIODIC, 1) &&
  1464		    test_and_clear_bit(FF_PERIODIC, dev->ffbit))
  1465			hid_warn(pidff->hid, "unknown periodic effect layout\n");
  1466	
  1467		PIDFF_FIND_FIELDS(pool, PID_POOL, 0);
  1468	
  1469		if (!PIDFF_FIND_FIELDS(device_gain, PID_DEVICE_GAIN, 1))
  1470			set_bit(FF_GAIN, dev->ffbit);
  1471	
  1472		return 0;
  1473	}
  1474	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

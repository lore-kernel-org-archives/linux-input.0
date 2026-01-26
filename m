Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B441AC44D
	for <linux-input@vger.kernel.org>; Mon, 26 Jan 2026 02:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769393120; cv=none; b=ajqNpbRB4gewV8T4G//8SsGF8Y7vJg8CuhRJ08PVRoJUNBNlPxXf1Ms/MMe0311a6FJDz+tMjcjfB3XTFzsMQWHfVbG6XyF7fRSl8JX1Y6C3IsmHxomBWChtwHtR3fz/lVt1+oWWoAjKop5Px0ZM9Jium3Uomx6sVDtqK91y49M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769393120; c=relaxed/simple;
	bh=GXtdJel1eUo3aIj4hiUu8GuQI8Z1AaGYsOJcqinsUVA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=irhZeRRlEjZBIEpu/rOkLLfvdU28l7T5L1b6lsY/LERapOMG3vzBoNWSQctydbFbh60rEvc3x4ZTRh+VKKAkPAgzi3eGbmmzuug+E6wNaLQMuJ6q9afSL6Qwd8otM2qGgffGA7+St6Vo6lRr5Cwxvg+pyYiueDQy1pd7tHio0Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f8GMWdb/; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f8GMWdb/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769393118; x=1800929118;
  h=date:from:to:cc:subject:message-id;
  bh=GXtdJel1eUo3aIj4hiUu8GuQI8Z1AaGYsOJcqinsUVA=;
  b=f8GMWdb/EQK89IiCx3XX/PAY5BlN1AHTm865IL2LfEM5pI9fwp0LLR76
   54cafMA9xV50QV4EpfWXdxXlRg5yc65oWqBfbeSVWMYRqqQ3RkrFrBkXu
   qWjG8T0EZj+Mx3ux1sMRaJeHtNaF5S5ZOsHMTh0YdxU2O5SRoP8PfXl5P
   J64WHcP1UfyykLgSkR9iPc7SmY2GVGLJ5Zxhxw8s64lAWtdzJ64ZLi0Tf
   kVCBAEjwK7pjP/IH4+cbYlxGHibfpaO1tU9OXwlrPNCfj4BAXTRHcFhbi
   vlePGNqYDyXPmLqGFPC2FUGdIhANNBSmRn9+XNgfv4hnEydkkv8pkeUtd
   Q==;
X-CSE-ConnectionGUID: cHKKZ6TNS2Kus+pc1VShyg==
X-CSE-MsgGUID: AekmixGITFGrnjRUufl2lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11682"; a="96038860"
X-IronPort-AV: E=Sophos;i="6.21,254,1763452800"; 
   d="scan'208";a="96038860"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2026 18:05:17 -0800
X-CSE-ConnectionGUID: aCrYD861Tv6pw8v/rNlpzw==
X-CSE-MsgGUID: 9GkTIftXRv6tS38RxVhTmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,254,1763452800"; 
   d="scan'208";a="212545621"
Received: from igk-lkp-server01.igk.intel.com (HELO afc5bfd7f602) ([10.211.93.152])
  by orviesa005.jf.intel.com with ESMTP; 25 Jan 2026 18:05:16 -0800
Received: from kbuild by afc5bfd7f602 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vkBya-000000001PB-3pA6;
	Mon, 26 Jan 2026 02:05:12 +0000
Date: Mon, 26 Jan 2026 03:04:21 +0100
From: kernel test robot <lkp@intel.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-input@vger.kernel.org,
 Jiri Kosina <jikos@kernel.org>
Subject: [hid:for-6.20/pm_ptr 7/12]
 drivers/hid/hid-picolcd_core.c:651:33: error: 'picolcd_suspend' undeclared
 here (not in a function); did you mean 'picolcd_reset'?
Message-ID: <202601260353.Dk5ekiee-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-6.20/pm_ptr
head:   d68a5fd939f460a7db76d127005af51cb13c69fa
commit: 318f7b0f1bea13d3aa0506fe6f40399f11c4ae52 [7/12] HID: picolcd_core: Use pm_ptr instead of #ifdef CONFIG_PM
config: i386-randconfig-2006-20250804 (https://download.01.org/0day-ci/archive/20260126/202601260353.Dk5ekiee-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260126/202601260353.Dk5ekiee-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601260353.Dk5ekiee-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/kernel.h:36,
                    from include/linux/random.h:7,
                    from include/linux/nodemask.h:94,
                    from include/linux/numa.h:6,
                    from include/linux/cpumask.h:15,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:63,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:16,
                    from include/linux/hid.h:19,
                    from drivers/hid/hid-picolcd_core.c:10:
>> drivers/hid/hid-picolcd_core.c:651:33: error: 'picolcd_suspend' undeclared here (not in a function); did you mean 'picolcd_reset'?
     651 |         .suspend =       pm_ptr(picolcd_suspend),
         |                                 ^~~~~~~~~~~~~~~
   include/linux/util_macros.h:136:44: note: in definition of macro 'PTR_IF'
     136 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                            ^~~
   drivers/hid/hid-picolcd_core.c:651:26: note: in expansion of macro 'pm_ptr'
     651 |         .suspend =       pm_ptr(picolcd_suspend),
         |                          ^~~~~~
>> drivers/hid/hid-picolcd_core.c:652:33: error: 'picolcd_resume' undeclared here (not in a function); did you mean 'picolcd_remove'?
     652 |         .resume =        pm_ptr(picolcd_resume),
         |                                 ^~~~~~~~~~~~~~
   include/linux/util_macros.h:136:44: note: in definition of macro 'PTR_IF'
     136 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                            ^~~
   drivers/hid/hid-picolcd_core.c:652:26: note: in expansion of macro 'pm_ptr'
     652 |         .resume =        pm_ptr(picolcd_resume),
         |                          ^~~~~~
>> drivers/hid/hid-picolcd_core.c:653:33: error: 'picolcd_reset_resume' undeclared here (not in a function); did you mean 'picolcd_reset'?
     653 |         .reset_resume =  pm_ptr(picolcd_reset_resume),
         |                                 ^~~~~~~~~~~~~~~~~~~~
   include/linux/util_macros.h:136:44: note: in definition of macro 'PTR_IF'
     136 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                            ^~~
   drivers/hid/hid-picolcd_core.c:653:26: note: in expansion of macro 'pm_ptr'
     653 |         .reset_resume =  pm_ptr(picolcd_reset_resume),
         |                          ^~~~~~


vim +651 drivers/hid/hid-picolcd_core.c

   644	
   645	static struct hid_driver picolcd_driver = {
   646		.name =          "hid-picolcd",
   647		.id_table =      picolcd_devices,
   648		.probe =         picolcd_probe,
   649		.remove =        picolcd_remove,
   650		.raw_event =     picolcd_raw_event,
 > 651		.suspend =       pm_ptr(picolcd_suspend),
 > 652		.resume =        pm_ptr(picolcd_resume),
 > 653		.reset_resume =  pm_ptr(picolcd_reset_resume),
   654	};
   655	module_hid_driver(picolcd_driver);
   656	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

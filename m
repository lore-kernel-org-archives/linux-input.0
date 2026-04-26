Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059D770818;
	Sun, 26 Apr 2026 05:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777181472; cv=none; b=o03Ylh2gjoR4VL3U5vE1y6G4s5i2F28K9dskhlC7jrF/eC3V16eHQ2pgvsG3Hrr4IaK94xwi6yo2motlPJp5Y9MB0aGy2SwpUdLqmxjzenjimIKXCQHSMmtgOzqaBbXCcPQmNMm30xmlH5yVtPFnBpV5Q1uD+ZNRLf+OYi7E8dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777181472; c=relaxed/simple;
	bh=uu2Y+WrvrFZ/fHQt0Se4aE3/RKLma4q81XoocE9F9ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VnfSCWvCs+uWoXdeIZS+M3IJAAmtTWIHC2roxNPiG/j+Z5MNQNVo7xVhx702uWKerN65KWoI8geBCZ8wjXI8VpLQQhRD6GEH7MHkTzIUv8zN4tc/n5qUN0H32Q6FVrLfihCg8z8TDdUXG8quQtPs9f79L0MGM5t3jwKVjhlg9os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ONWZ32Mi; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ONWZ32Mi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777181470; x=1808717470;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uu2Y+WrvrFZ/fHQt0Se4aE3/RKLma4q81XoocE9F9ik=;
  b=ONWZ32Mi9gXsNy8nt8tyGDT8zrJj49+CwoKdIZ1944v06JBYaiX4ZcTE
   CcKXMQkh53CFksrpILhjm3Q9AGuhnBtjFidKA6R2bj80CPqC9EO6UZfdC
   Vpb08VshSx1Fltcp1dGmyHyxuUzcKDRx+RCq5S7FpehZDEKOsorqVZJk7
   rtpos2zSipKzkt4flw4jy+kIsCuGznHotdH85hcVM2YjNi4+l4RtLfPvm
   /+JFRM/InzINazHDU670Z4QfZtUo0zeDias9tHymAYQvE2LaLo+SYK7L2
   Km7cpSfJkDHIN8m5o4WcLFvuiAYerQZ/n8m0yxA0dNWZhcTot+3c+bRy8
   g==;
X-CSE-ConnectionGUID: asvvfluySL2Zvp9VmV4Wcw==
X-CSE-MsgGUID: uNPgQyTZRFGBRbH9B864Tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11767"; a="95670370"
X-IronPort-AV: E=Sophos;i="6.23,199,1770624000"; 
   d="scan'208";a="95670370"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2026 22:31:10 -0700
X-CSE-ConnectionGUID: ITpluNw7SfSHuoQgpUnfKg==
X-CSE-MsgGUID: a31AQ2nyQR6pH5+Y21/HKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,199,1770624000"; 
   d="scan'208";a="271452556"
Received: from lkp-server01.sh.intel.com (HELO aa799cca880d) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 25 Apr 2026 22:31:08 -0700
Received: from kbuild by aa799cca880d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wGs5A-000000007W1-44ps;
	Sun, 26 Apr 2026 05:31:04 +0000
Date: Sun, 26 Apr 2026 13:31:03 +0800
From: kernel test robot <lkp@intel.com>
To: Tomasz =?utf-8?Q?Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>,
	jikos@kernel.org, bentiss@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, oleg@makarenk.ooo,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	tomasz.pakula.oficjalny@gmail.com
Subject: Re: [PATCH] HID: pidff: Fix integer overflow in pidff_rescale
Message-ID: <202604261334.MiQX0gtI-lkp@intel.com>
References: <20260421194941.1422722-1-tomasz.pakula.oficjalny@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421194941.1422722-1-tomasz.pakula.oficjalny@gmail.com>

Hi Tomasz,

kernel test robot noticed the following build errors:

[auto build test ERROR on hid/for-next]
[also build test ERROR on linus/master v7.0 next-20260424]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tomasz-Paku-a/HID-pidff-Fix-integer-overflow-in-pidff_rescale/20260424-133424
base:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-next
patch link:    https://lore.kernel.org/r/20260421194941.1422722-1-tomasz.pakula.oficjalny%40gmail.com
patch subject: [PATCH] HID: pidff: Fix integer overflow in pidff_rescale
config: microblaze-allyesconfig (https://download.01.org/0day-ci/archive/20260426/202604261334.MiQX0gtI-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260426/202604261334.MiQX0gtI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604261334.MiQX0gtI-lkp@intel.com/

All errors (new ones prefixed by >>):

   microblaze-linux-ld: drivers/hid/usbhid/hid-pidff.o: in function `pidff_set':
>> hid-pidff.o:(.text+0x6f4): undefined reference to `__divdi3'
   microblaze-linux-ld: drivers/hid/usbhid/hid-pidff.o: in function `pidff_set_signed':
   hid-pidff.o:(.text+0xb0c): undefined reference to `__divdi3'
   microblaze-linux-ld: drivers/hid/usbhid/hid-pidff.o: in function `pidff_set_envelope_report':
   hid-pidff.o:(.text+0x2094): undefined reference to `__divdi3'
>> microblaze-linux-ld: hid-pidff.o:(.text+0x2104): undefined reference to `__divdi3'
   microblaze-linux-ld: drivers/hid/usbhid/hid-pidff.o: in function `pidff_upload_effect':
   hid-pidff.o:(.text+0x25c0): undefined reference to `__divdi3'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

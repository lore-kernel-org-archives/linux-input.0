Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E452475D0;
	Sat, 21 Feb 2026 15:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771689018; cv=none; b=YXcgQIL/xUhNGh0EzxyLtc0rbas1A1hcxHf/0MYVLg4s2ze4VB0AM/KUSqFZuOcCG7Wrd/ixbzogioMWte4yjNC0SJpdZ2XkEGMD6Tw9oA/2V1KsLBNmVHAmvR22nMjQy45lUIvbvPFjYZ6/f7ixWplOybvw0GlMzbYFqLVnU5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771689018; c=relaxed/simple;
	bh=dXYD130CLN82zcMpstyiaueFqYixALU6DRJ9YSBWq/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KoF7DGkMUhWwcTEMP0erxFPLxDdMWy3ECniyXwO1vIiklIkkspmw/xW7dXo6OulWt3c4llWD93uYYdrps6mCdYu+cUw6F86gYFy2TF93H+SeoUiQARCyMUjUnJ9zvOdsHfOkhs2++chPu9uyl/aO7nnho9DZsyv14Y1ENEfrybI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aWkDGABi; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aWkDGABi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771689016; x=1803225016;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dXYD130CLN82zcMpstyiaueFqYixALU6DRJ9YSBWq/I=;
  b=aWkDGABiAeFp5n9YnU6cI/+m6Ta9Etz7Cjl+xllI4mqgku+Y+xbDbNaV
   pmV0BdJdZDrNo2yFxFQPm2f5mfOSTW/NffOBuqtzvxCDl2AX6GCGjiSgr
   c0ZR0j/ABYccOgTbrco0Ni01ip/K5SKZZYV+I3NqWfaSgq3KrIxj5OfTX
   LVJSYwZzl0+VzJsJkF8HhLTCGDJMZ4pdRb3ca8a7ZsvWmql2NQNWBCPAY
   qbhI2CTeLRHeO9jqxV8Ww4n9qRhk8TKJhJbMCd842CfFD1utde2HWNeJK
   8GGZGP/UYNa7IWbfp9F44Pj0EurNAyOrU16vAm56apAiYtcut2oHW5HvG
   A==;
X-CSE-ConnectionGUID: WskrkvAeTsuQJoCLqCRXBw==
X-CSE-MsgGUID: HEJrO4QERxW0Xb+sz6gptg==
X-IronPort-AV: E=McAfee;i="6800,10657,11708"; a="72795009"
X-IronPort-AV: E=Sophos;i="6.21,304,1763452800"; 
   d="scan'208";a="72795009"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2026 07:50:15 -0800
X-CSE-ConnectionGUID: fwDDmyJITvO5kJe5v9y5pg==
X-CSE-MsgGUID: IOlvAVypQQCI6A5H+CUzaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,304,1763452800"; 
   d="scan'208";a="219665351"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 21 Feb 2026 07:50:13 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vtpFD-0000000151A-00tX;
	Sat, 21 Feb 2026 15:50:11 +0000
Date: Sat, 21 Feb 2026 23:49:18 +0800
From: kernel test robot <lkp@intel.com>
To: Tim Guttzeit <tgu@tuxedocomputers.com>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	wse@tuxedocomputers.com, Tim Guttzeit <tgu@tuxedocomputers.com>,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v3] HID: generic: add LampArray support via hid-lamparray
 helper
Message-ID: <202602212327.QsyQtOFJ-lkp@intel.com>
References: <20260220135309.151487-1-tgu@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220135309.151487-1-tgu@tuxedocomputers.com>

Hi Tim,

kernel test robot noticed the following build errors:

[auto build test ERROR on hid/for-next]
[also build test ERROR on linus/master v6.19 next-20260220]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tim-Guttzeit/HID-generic-add-LampArray-support-via-hid-lamparray-helper/20260220-215620
base:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-next
patch link:    https://lore.kernel.org/r/20260220135309.151487-1-tgu%40tuxedocomputers.com
patch subject: [PATCH v3] HID: generic: add LampArray support via hid-lamparray helper
config: i386-randconfig-002-20260221 (https://download.01.org/0day-ci/archive/20260221/202602212327.QsyQtOFJ-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260221/202602212327.QsyQtOFJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602212327.QsyQtOFJ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: hid_hw_request
   >>> referenced by hid-lamparray.c:210 (drivers/hid/hid-lamparray.c:210)
   >>>               drivers/hid/hid-lamparray.o:(lamparray_register) in archive vmlinux.a
   >>> referenced by hid-lamparray.c:316 (drivers/hid/hid-lamparray.c:316)
   >>>               drivers/hid/hid-lamparray.o:(lamparray_hw_set_autonomous) in archive vmlinux.a
   >>> referenced by hid-lamparray.c:392 (drivers/hid/hid-lamparray.c:392)
   >>>               drivers/hid/hid-lamparray.o:(lamparray_led_brightness_get) in archive vmlinux.a
   >>> referenced 1 more times

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

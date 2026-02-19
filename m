Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5243E27F017;
	Thu, 19 Feb 2026 19:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771528546; cv=none; b=WeX0a2pQFaPU6iEeChv7HEoQtz6dob9uulG4jvhUA8luTsYpi7QcnlZPYzIfgMmKdVNX3sDPisidE5TkyuETA9iSTzR7GKf373TTP07Ros4kYD4k2XXbGHH/COntp0cSvI8Na9tevDTyFnz3X+qqpr5CDjH8koZm+cPfmcBUKc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771528546; c=relaxed/simple;
	bh=6Z081LzIpGyYU0ubZNujB6ZYhzg/b0sDtJVLjBrdrp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PdFm1mNpEoZ3lfSmtr4mzuEN4INWqr0RbKT78E7AkOrdwiC1lExMJPAeVEtaVhR0FnGD6bYwuRMTtwS1hlx9ytA5kjZZ3Awz/fFrm6V7x3C4SM6jO3227sHAjO2Oj9Ko/Abs4rUJ/tzwW868ZRPkNHBF5a5kaic6jmdKjoZLc28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V3Pp+hCr; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V3Pp+hCr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771528545; x=1803064545;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6Z081LzIpGyYU0ubZNujB6ZYhzg/b0sDtJVLjBrdrp8=;
  b=V3Pp+hCrmK25RGocSu5rOSRcn/IC5cBgkUbhX8Y8WKHRQEZf9YbMS2Fa
   5anQ5R1EyuOA8cFUmp3R8u5YDv2nios9PLkQXBiVS4SXmdlmq60vXapAA
   XAKp7VWz+Xu5Kw7PZknvhafZnKk2CvBdDedsQDbFiy/xywPMjyfntksDl
   IU69ewuw3dW7a+plN8Az+oLqDM+Q4oGnZm4UvBYVhYgE1/m8oU0VYCpIr
   kfQd61zbUFB7o1EdOrajeRfPSmyHV/oXlMvxtW07XI2U6gVZQqKmg/OMe
   E2PIddsjXgnWeqDqGShwNGczplHjTAB8d6cIayPI93KLsxKMKqygw/QhY
   w==;
X-CSE-ConnectionGUID: hPfhILEMQzKwI++FozDp2Q==
X-CSE-MsgGUID: QBRgHAi+QGaSYQoV7iTQxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="72686932"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="72686932"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 11:15:44 -0800
X-CSE-ConnectionGUID: 8k8p55yJTXqs+mXFZ5zjRw==
X-CSE-MsgGUID: lUJFHNePR/qInLzE5s59Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="218774215"
Received: from igk-lkp-server01.igk.intel.com (HELO e5404a91d123) ([10.211.93.152])
  by orviesa003.jf.intel.com with ESMTP; 19 Feb 2026 11:15:42 -0800
Received: from kbuild by e5404a91d123 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vt9Uy-0000000042H-0Cnz;
	Thu, 19 Feb 2026 19:15:40 +0000
Date: Thu, 19 Feb 2026 20:14:58 +0100
From: kernel test robot <lkp@intel.com>
To: Tim Guttzeit <tgu@tuxedocomputers.com>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	wse@tuxedocomputers.com, Tim Guttzeit <tgu@tuxedocomputers.com>,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH] HID: generic: add LampArray support via hid-lamparray
 helper
Message-ID: <202602192025.xrvVo680-lkp@intel.com>
References: <20260219130217.2042972-1-tgu@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219130217.2042972-1-tgu@tuxedocomputers.com>

Hi Tim,

kernel test robot noticed the following build errors:

[auto build test ERROR on hid/for-next]
[also build test ERROR on linus/master v6.19 next-20260219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tim-Guttzeit/HID-generic-add-LampArray-support-via-hid-lamparray-helper/20260219-211040
base:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-next
patch link:    https://lore.kernel.org/r/20260219130217.2042972-1-tgu%40tuxedocomputers.com
patch subject: [PATCH] HID: generic: add LampArray support via hid-lamparray helper
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260219/202602192025.xrvVo680-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260219/202602192025.xrvVo680-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602192025.xrvVo680-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: led_mc_calc_color_components
   >>> referenced by hid-lamparray.c:585 (drivers/hid/hid-lamparray.c:585)
   >>>               vmlinux.o:(lamparray_register_led)
   >>> referenced by hid-lamparray.c:449 (drivers/hid/hid-lamparray.c:449)
   >>>               vmlinux.o:(lamparray_led_brightness_set)
--
>> ld.lld: error: undefined symbol: led_classdev_multicolor_register_ext
   >>> referenced by led-class-multicolor.h:70 (include/linux/led-class-multicolor.h:70)
   >>>               vmlinux.o:(lamparray_register_led)
--
>> ld.lld: error: undefined symbol: led_classdev_multicolor_unregister
   >>> referenced by hid-lamparray.c:615 (drivers/hid/hid-lamparray.c:615)
   >>>               vmlinux.o:(lamparray_unregister_led)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59596A930;
	Sat, 21 Feb 2026 04:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771647779; cv=none; b=Hxxs1SS/GFeRoVAL8RyBD+QyIlz9k+YAMk6LsC/uh6k2dk2CtG3uGOzMXl/Y1F+bc43Hh5aE6RVwipyEsijtjgJv0/GgP1W9fVCx65iqj7TbNENm2HVASKIg0OWwven2jHLJbrvjPcLBorQkT445ObxNsOMoA/A3zAxSJrAv52w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771647779; c=relaxed/simple;
	bh=Oh40+MpvSadUfa4uYHyD/GZDcTxBPPS/jRqp+7sWxZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vdgs7RQlxql+WpFISC0KyI97IpbqdnRiOB4+FZnXShrdE3EfvVWDB4P9v5Y2+6zIRqEfLLQ7YFFdhEPOOjb4RJ4bHuBKtogqD7NG3YBGFsqbwo1oiSE/jtdCrVMXYZfCw7td7tpLeRU7gvzVPO3VACdkw52UsFibR1rebtKpGwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=St+N6L5B; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="St+N6L5B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771647776; x=1803183776;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Oh40+MpvSadUfa4uYHyD/GZDcTxBPPS/jRqp+7sWxZw=;
  b=St+N6L5B24Vn3sVl2vbugpj4zh9SS2mHzv6stW2xmeE+KV6STLtFTWl3
   l1JRfM+L3rOQSPNlB5of113YfGnSX15ih5+WEtFL0jDLsuY0Ns9OSv04l
   hyA4WE+SyxiBb55DWAjNCk8/Z0OD0/s/tMESVPTH2WgZSHNcMUax1bwQE
   5L5KTquRKxLzcba0g+PGS6jniK7rbEFSgZyNndZqH75NUTUVQdAlfrok8
   WrSNhj6KglHr9Yv+9rr+TVidADms0OzS7mWYtXcuGEAeAQ7Bbwudn+eXT
   pUCcI0XBwVfHXsvLaLMUZaxrXl5ls/wntGjjwJqBFzxfnkzmv3ILoIbt5
   A==;
X-CSE-ConnectionGUID: cPWxamhgQDm46uLVIwFP7A==
X-CSE-MsgGUID: /6i5efOeQrKJYUNseFgRhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11707"; a="76348634"
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="76348634"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 20:22:56 -0800
X-CSE-ConnectionGUID: JFe+x54rSdecnu4f/U0HyA==
X-CSE-MsgGUID: la31UCpSRDqm6dDY2fOM3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="214135245"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 20 Feb 2026 20:22:54 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vteW3-000000014ho-3Nl0;
	Sat, 21 Feb 2026 04:22:51 +0000
Date: Sat, 21 Feb 2026 12:22:26 +0800
From: kernel test robot <lkp@intel.com>
To: Tim Guttzeit <tgu@tuxedocomputers.com>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, wse@tuxedocomputers.com,
	Tim Guttzeit <tgu@tuxedocomputers.com>,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v3] HID: generic: add LampArray support via hid-lamparray
 helper
Message-ID: <202602211232.5VR8uvU5-lkp@intel.com>
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
config: arm64-randconfig-003-20260221 (https://download.01.org/0day-ci/archive/20260221/202602211232.5VR8uvU5-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260221/202602211232.5VR8uvU5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602211232.5VR8uvU5-lkp@intel.com/

All errors (new ones prefixed by >>):

   aarch64-linux-ld: Unexpected GOT/PLT entries detected!
   aarch64-linux-ld: Unexpected run-time procedure linkages detected!
   aarch64-linux-ld: drivers/hid/hid-lamparray.o: in function `lamparray_led_brightness_get':
>> hid-lamparray.c:(.text+0x1fc): undefined reference to `hid_hw_request'
   aarch64-linux-ld: drivers/hid/hid-lamparray.o: in function `lamparray_hw_set_state':
   hid-lamparray.c:(.text+0x3e0): undefined reference to `hid_hw_request'
   aarch64-linux-ld: drivers/hid/hid-lamparray.o: in function `lamparray_led_brightness_set':
   hid-lamparray.c:(.text+0x5f0): undefined reference to `led_mc_calc_color_components'
   aarch64-linux-ld: drivers/hid/hid-lamparray.o: in function `lamparray_register_led':
   hid-lamparray.c:(.text+0x804): undefined reference to `led_mc_calc_color_components'
>> aarch64-linux-ld: hid-lamparray.c:(.text+0x824): undefined reference to `led_classdev_multicolor_register_ext'
   aarch64-linux-ld: drivers/hid/hid-lamparray.o: in function `lamparray_unregister_led':
   hid-lamparray.c:(.text+0x948): undefined reference to `led_classdev_multicolor_unregister'
   aarch64-linux-ld: drivers/hid/hid-lamparray.o: in function `lamparray_register':
   hid-lamparray.c:(.text+0xec4): undefined reference to `hid_hw_request'
>> aarch64-linux-ld: hid-lamparray.c:(.text+0x100c): undefined reference to `hid_hw_request'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

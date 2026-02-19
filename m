Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2382DB794;
	Thu, 19 Feb 2026 18:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771527347; cv=none; b=cKVazk8j/jltvAL9jbQhE26jr4H8kWbA0X1YTpAi4RFknRx7KpMvigyGL3G6BcQ3cMKrbObvC3FXczI9rCBwNYN0ehLbf0rSRVuyCxHeWAz4u8AeeetWao9XCTYxQgVruWoz+hYHA2vZTjlI/00ccP691EkPB7p2c6ZT8INaMwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771527347; c=relaxed/simple;
	bh=PNTw9kJSdp7SH0WfHOGDgNvFs+mAytqFl+FrF1J66Vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTFaIu//xt8/UW7a3t0d1Lr8iTOqKE7wpGsIqJcgSDSZd8lbgp5jTmq2RVd+EM5v98S2+z4K2tlulWhQ0jFOIXLh8V+3rkPoIwFZhbLKeR8WaB48PZtduu6hk8J9VsAni0G9tHFQ/TjwIvJnLz0xjKx+xWY8Qf7nNaYbZ/jNqVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tzig59kR; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tzig59kR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771527346; x=1803063346;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PNTw9kJSdp7SH0WfHOGDgNvFs+mAytqFl+FrF1J66Vc=;
  b=Tzig59kR8EPlkw77mlHaiK003GJrXPRUvEJrLC2CYtZPozmYpr1pVase
   Wm/nPKfAK+tgxaNnS4B44vgnzPMKX37Vd5Az2vqJQ4sBaRPdL4KDNgNgn
   zQ+BKgzsOrzdCVSbnKObRx9MoUffdUK4JAeeuwRA+2+MwttrCC8cQKBCJ
   /OX9uA1uwXqBGBoSKNEZl+PJ8ApdayN7+WzPK4bJoDBD+HYLmWfhHwbU+
   eGrgDPzb5nb2JPQNcst597kX85mV3AO+UeGCP4rUR1LsO9igVrSIUEeYa
   JVFGrPDrFSw3BT6YH2QnjJGJqdFqZsK3CZ37by8y+SWe8DMiuUXLXNo8p
   Q==;
X-CSE-ConnectionGUID: hDf5ug51R7uIaAghMEqXng==
X-CSE-MsgGUID: XuODohlIRMms2/g1oyjNoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="84077855"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="84077855"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 10:55:46 -0800
X-CSE-ConnectionGUID: 7DrjVRY8RvGysEHAmhUNSA==
X-CSE-MsgGUID: pv5pVYJAT1+/44vegBfLjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="213250502"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 19 Feb 2026 10:55:43 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vt9Bd-000000013Su-2N4z;
	Thu, 19 Feb 2026 18:55:41 +0000
Date: Fri, 20 Feb 2026 02:55:37 +0800
From: kernel test robot <lkp@intel.com>
To: Tim Guttzeit <tgu@tuxedocomputers.com>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, wse@tuxedocomputers.com,
	Tim Guttzeit <tgu@tuxedocomputers.com>,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH] HID: generic: add LampArray support via hid-lamparray
 helper
Message-ID: <202602200241.6ypuWvE5-lkp@intel.com>
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
config: csky-defconfig (https://download.01.org/0day-ci/archive/20260220/202602200241.6ypuWvE5-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260220/202602200241.6ypuWvE5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602200241.6ypuWvE5-lkp@intel.com/

All errors (new ones prefixed by >>):

   csky-linux-ld: drivers/hid/hid-lamparray.o: in function `lamparray_led_brightness_set':
   hid-lamparray.c:(.text+0x550): undefined reference to `led_mc_calc_color_components'
>> csky-linux-ld: hid-lamparray.c:(.text+0x5c0): undefined reference to `led_mc_calc_color_components'
   csky-linux-ld: drivers/hid/hid-lamparray.o: in function `lamparray_register_led':
   hid-lamparray.c:(.text+0x6b2): undefined reference to `led_mc_calc_color_components'
>> csky-linux-ld: hid-lamparray.c:(.text+0x6ce): undefined reference to `led_classdev_multicolor_register_ext'
   csky-linux-ld: hid-lamparray.c:(.text+0x750): undefined reference to `led_mc_calc_color_components'
   csky-linux-ld: hid-lamparray.c:(.text+0x758): undefined reference to `led_classdev_multicolor_register_ext'
   csky-linux-ld: drivers/hid/hid-lamparray.o: in function `lamparray_register.part.0':
   hid-lamparray.c:(.text+0x94e): undefined reference to `led_classdev_multicolor_unregister'
   csky-linux-ld: drivers/hid/hid-lamparray.o: in function `lamparray_unregister':
   hid-lamparray.c:(.text+0xad4): undefined reference to `led_classdev_multicolor_unregister'
>> csky-linux-ld: hid-lamparray.c:(.text+0xb1c): undefined reference to `led_classdev_multicolor_unregister'
   csky-linux-ld: hid-lamparray.c:(.text+0xb24): undefined reference to `led_classdev_multicolor_unregister'
   csky-linux-ld: drivers/hid/hid-lamparray.o: in function `use_leds_uapi_store':
   hid-lamparray.c:(.text+0xc06): undefined reference to `led_classdev_multicolor_unregister'
   csky-linux-ld: drivers/hid/hid-lamparray.o:hid-lamparray.c:(.text+0xc5c): more undefined references to `led_classdev_multicolor_unregister' follow

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

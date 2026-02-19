Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D842E2DDD;
	Thu, 19 Feb 2026 20:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771532926; cv=none; b=fKQWFt3MRO66KUHYn7Wjyo4f/O0+kgd6v9pejwRj0GbNZ+iw1f4PqQOG+EFO2T/FTXCUnVCu+/QEZnzKCpxKJsTX+SvtWfok8IgF+/0kEa7C80SlHIXXWitwgWqn92CPHodC8hMcJCHaJ4VpvCrfDIhoFwzaBHzlEfT6HA6mhLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771532926; c=relaxed/simple;
	bh=m6ApiEDhD8oT31DR/TYVj2BCcgv8WZjP9yDJl+4ApUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCaK8SRgBf/v3ttBV7C8xx6DYa3adWKdQgAVfBAN48mFLEaMDPDXAFz5+hIIUcduV068+2rBJeonup9JuC1fDjLjIi4y0rEePKu8RQQa71r5DpLa6bF9CWecT5xFefDkR0IgB4e65OK2xkqjjpkepY2qZ3+5BYV+d9Te9mZXQQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BFfhERt7; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BFfhERt7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771532926; x=1803068926;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m6ApiEDhD8oT31DR/TYVj2BCcgv8WZjP9yDJl+4ApUQ=;
  b=BFfhERt7M7seJRZork1nfKRPng0KAKS211b4ddW0Hwfz4TyXxAUfOCoI
   0W1wF3878BNWdllZXJ8M+UDr1L9V87Q2w8124czHmYVWmnVgqdNKyfzJt
   u/KBTC7BkMYfbu6FB9cobpH/V6pNoXnSGilSlNlXx/zYeDzt9oSAv1pd/
   bL6apM7PKQJeKyKrgr5QrsdlGFSEME14e9nGz96uORKOaoSUlkQRm/D/D
   Yuagjia/Ua2LBK5ItEb3at8qWrpuOmbtfer8QSHeaI0KbKIfUk7rzcLII
   Hg4hkzLxFhPwV+PWLxh5BCdBHOVAFk3clXqJvIclQuErOApdJksf1xYKZ
   A==;
X-CSE-ConnectionGUID: yv/1PsAdTXiaIV4EuPTABg==
X-CSE-MsgGUID: N8xbznbFRl+uTqxqhd1gFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="72806899"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="72806899"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 12:28:45 -0800
X-CSE-ConnectionGUID: ZpxuUyCmRASTof7suNoMjg==
X-CSE-MsgGUID: EPXHdWneSaa4GacLlZNy2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="213265772"
Received: from igk-lkp-server01.igk.intel.com (HELO e5404a91d123) ([10.211.93.152])
  by fmviesa010.fm.intel.com with ESMTP; 19 Feb 2026 12:28:42 -0800
Received: from kbuild by e5404a91d123 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vtAdc-0000000042X-19IS;
	Thu, 19 Feb 2026 20:28:40 +0000
Date: Thu, 19 Feb 2026 21:28:04 +0100
From: kernel test robot <lkp@intel.com>
To: Tim Guttzeit <tgu@tuxedocomputers.com>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, wse@tuxedocomputers.com,
	Tim Guttzeit <tgu@tuxedocomputers.com>,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH] HID: generic: add LampArray support via hid-lamparray
 helper
Message-ID: <202602192131.Q9y8Kqvt-lkp@intel.com>
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
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260219/202602192131.Q9y8Kqvt-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260219/202602192131.Q9y8Kqvt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602192131.Q9y8Kqvt-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: vmlinux.o: in function `lamparray_led_brightness_set':
>> drivers/hid/hid-lamparray.c:449:(.text+0xcb5bbd): undefined reference to `led_mc_calc_color_components'
   ld: vmlinux.o: in function `lamparray_register_led':
   drivers/hid/hid-lamparray.c:585:(.text+0xcb5db3): undefined reference to `led_mc_calc_color_components'
   ld: vmlinux.o: in function `led_classdev_multicolor_register':
>> include/linux/led-class-multicolor.h:70:(.text+0xcb5dd9): undefined reference to `led_classdev_multicolor_register_ext'
   ld: vmlinux.o: in function `lamparray_unregister_led':
>> drivers/hid/hid-lamparray.c:615:(.text+0xcb60eb): undefined reference to `led_classdev_multicolor_unregister'
>> ld: drivers/hid/hid-lamparray.c:615:(.text+0xcb620b): undefined reference to `led_classdev_multicolor_unregister'
   ld: drivers/hid/hid-lamparray.c:615:(.text+0xcb636d): undefined reference to `led_classdev_multicolor_unregister'


vim +449 drivers/hid/hid-lamparray.c

   434	
   435	static int lamparray_led_brightness_set(struct led_classdev *cdev,
   436						enum led_brightness brightness)
   437	{
   438		struct led_classdev_mc *mc = lcdev_to_mccdev(cdev);
   439		struct lamparray_device *ldev =
   440			container_of(mc, struct lamparray_device, mc_cdev);
   441		struct lamparray *la = container_of(ldev, struct lamparray, ldev);
   442		u8 r, g, b;
   443		int ret;
   444	
   445		if (!la)
   446			return -ENODEV;
   447		ldev = &la->ldev;
   448	
 > 449		ret = led_mc_calc_color_components(mc, brightness);
   450		if (ret)
   451			return ret;
   452	
   453		r = mc->subled_info[0].brightness;
   454		g = mc->subled_info[1].brightness;
   455		b = mc->subled_info[2].brightness;
   456	
   457		ret = lamparray_hw_set_state(ldev, r, g, b, brightness);
   458		if (ret)
   459			hid_err(ldev->hdev, "Failed to send LampArray update: %d\n",
   460				ret);
   461	
   462		mutex_lock(&ldev->lock);
   463		ldev->last_r = r;
   464		ldev->last_g = g;
   465		ldev->last_b = b;
   466		ldev->last_brightness = brightness;
   467		mutex_unlock(&ldev->lock);
   468	
   469		return 0;
   470	}
   471	
   472	static enum led_brightness
   473	lamparray_led_brightness_get(struct led_classdev *cdev)
   474	{
   475		struct led_classdev_mc *mc = lcdev_to_mccdev(cdev);
   476		struct lamparray_device *ldev =
   477			container_of(mc, struct lamparray_device, mc_cdev);
   478		enum led_brightness brightness;
   479		struct lamparray *la = container_of(ldev, struct lamparray, ldev);
   480		u8 rr, gg, bb;
   481		enum led_brightness br;
   482		int ret;
   483	
   484		/* Default: cache (also used while registering LED classdev) */
   485		mutex_lock(&ldev->lock);
   486		brightness = ldev->last_brightness;
   487		mutex_unlock(&ldev->lock);
   488	
   489		/* Only do HID readback after registration completed */
   490		if (READ_ONCE(ldev->led_registered)) {
   491			if (!la)
   492				return brightness;
   493			ldev = &la->ldev;
   494	
   495			ret = lamparray_hw_get_state(ldev, &rr, &gg, &bb, &br);
   496			if (ret) {
   497				hid_warn(ldev->hdev,
   498					 "Failed to read LampArray state (%d), using cached brightness %u\n",
   499					 ret, brightness);
   500				return brightness;
   501			}
   502	
   503			mutex_lock(&ldev->lock);
   504			if (ldev->last_r != rr || ldev->last_g != gg ||
   505			    ldev->last_b != bb || ldev->last_brightness != br) {
   506				ldev->last_r = rr;
   507				ldev->last_g = gg;
   508				ldev->last_b = bb;
   509				ldev->last_brightness = br;
   510	
   511				if (ldev->led_registered && ldev->mc_cdev.subled_info) {
   512					ldev->mc_cdev.subled_info[0].brightness = rr;
   513					ldev->mc_cdev.subled_info[1].brightness = gg;
   514					ldev->mc_cdev.subled_info[2].brightness = bb;
   515				}
   516			}
   517			mutex_unlock(&ldev->lock);
   518			return br;
   519		}
   520		return brightness;
   521	}
   522	
   523	static int lamparray_register_led(struct lamparray_device *ldev)
   524	{
   525		struct device *dev = &ldev->hdev->dev;
   526		struct led_classdev *cdev = &ldev->mc_cdev.led_cdev;
   527		u8 r_i, g_i, b_i;
   528		int ret;
   529	
   530		mutex_lock(&ldev->lock);
   531	
   532		if (ldev->led_registered) {
   533			mutex_unlock(&ldev->lock);
   534			return 0;
   535		}
   536	
   537		if (!cdev->name) {
   538			cdev->name =
   539				devm_kasprintf(dev, GFP_KERNEL, "%s", dev_name(dev));
   540			if (!cdev->name) {
   541				mutex_unlock(&ldev->lock);
   542				return -ENOMEM;
   543			}
   544		}
   545	
   546		cdev->max_brightness = 255;
   547		cdev->brightness_set_blocking = lamparray_led_brightness_set;
   548		cdev->brightness_get = lamparray_led_brightness_get;
   549		cdev->brightness = ldev->last_brightness;
   550	
   551		ldev->subleds[0].color_index = LED_COLOR_ID_RED;
   552		ldev->subleds[1].color_index = LED_COLOR_ID_GREEN;
   553		ldev->subleds[2].color_index = LED_COLOR_ID_BLUE;
   554	
   555		/*
   556		 * Initialize the color mix (multi_intensity) from the last known HW/init
   557		 * state so that writing only /brightness scales the expected default color
   558		 * instead of white.
   559		 *
   560		 * If last_brightness is non-zero, treat last_r/g/b as per-channel
   561		 * brightness and normalize back to intensities (0..255).
   562		 * If last_brightness is zero, keep last_r/g/b as the intended mix.
   563		 */
   564		if (ldev->last_brightness) {
   565			r_i = (u8)min_t(unsigned int, 255,
   566					(ldev->last_r * 255u) / ldev->last_brightness);
   567			g_i = (u8)min_t(unsigned int, 255,
   568					(ldev->last_g * 255u) / ldev->last_brightness);
   569			b_i = (u8)min_t(unsigned int, 255,
   570					(ldev->last_b * 255u) / ldev->last_brightness);
   571		} else {
   572			r_i = ldev->last_r;
   573			g_i = ldev->last_g;
   574			b_i = ldev->last_b;
   575		}
   576	
   577		ldev->subleds[0].intensity = r_i;
   578		ldev->subleds[1].intensity = g_i;
   579		ldev->subleds[2].intensity = b_i;
   580	
   581		ldev->mc_cdev.subled_info = ldev->subleds;
   582		ldev->mc_cdev.num_colors = ARRAY_SIZE(ldev->subleds);
   583	
   584		/* Ensure subled_info[].brightness matches intensity + brightness */
   585		led_mc_calc_color_components(&ldev->mc_cdev, cdev->brightness);
   586	
   587		ldev->mc_cdev.subled_info = ldev->subleds;
   588		ldev->mc_cdev.num_colors = ARRAY_SIZE(ldev->subleds);
   589	
   590		mutex_unlock(&ldev->lock);
   591	
   592		ret = led_classdev_multicolor_register(dev, &ldev->mc_cdev);
   593		if (ret)
   594			return ret;
   595	
   596		mutex_lock(&ldev->lock);
   597		ldev->led_registered = true;
   598		mutex_unlock(&ldev->lock);
   599	
   600		return 0;
   601	}
   602	
   603	static void lamparray_unregister_led(struct lamparray_device *ldev)
   604	{
   605		bool was_registered;
   606	
   607		mutex_lock(&ldev->lock);
   608		was_registered = ldev->led_registered;
   609		ldev->led_registered = false;
   610		mutex_unlock(&ldev->lock);
   611	
   612		if (!was_registered)
   613			return;
   614	
 > 615		led_classdev_multicolor_unregister(&ldev->mc_cdev);
   616	}
   617	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

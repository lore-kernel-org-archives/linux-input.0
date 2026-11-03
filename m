Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793703469;
	b=z09n5Avujm1iyPTPQDfL6lpUP99sx1OuyMhUZXg8GxT6O2vNuWYmYAZ6jXGkwVG9M85z
	 QvY0tA1NPj0irL3L103Jq0rPr1V2W9SYzGhWqY9GtfkHen5EwJv4idbeP1bYjvlBay0j4
	 evQAKRUin8CfSwM3Ud6C3aN8Yi90URaDsUX8cEA54RX3+vdBeAc3GpXKQ/23NZsq+458g
	 IAhCQZ1Q7wVbfofJkbx5Hv45nE8NTPyJoHgr8OLSPDe6NkaUrvBC384O/DWcBlYSl9U3d
	 iULRJaV8QdwNBpMPBJPrwdaPyiIkbyZgYOv9ACQhq3QI8MJNVZ7YUETghL4NmI3EGWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793703469;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=DDfICRyidzH2Xd0djapzVszHzRWjlx8ddWZ00UYB6Ac=;
	b=pTDZ7brKdccwSuPwesNiULw3iDLQcAJNmaUQAibuwg/73B40h1p7ew+Ag1dN7fN2iyUC
	 qXiQz1hPPXqP7gYk6LGdS3LWlIUBrU5H+VplxQ9AIrGPmjAo1rjlk5eEnrEWB3sA7nuOZ
	 PoOPkrM3MP5qVX9VFIb536DLEVjkiP2P8ePvaFRpA3a2ccwwKP1doHdh6kESQH4SPcwRg
	 JtanVssGL2ggIQB9DRvg0sbduyPpDrlp1cNtJakBjpJk3Uh69zkHJdliJWBjWlO47S08M
	 dtYlKjWnrP4c8orXWynI751rCJK63Ovw1qUblReO2s8CEoakO2i6vJVldf34Wizl10A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AwykSUyB;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E55606BF96;
	Tue,  3 Nov 2026 10:57:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97E55606BF96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AwykSUyB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793703469; x=1825239469;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tVqPDu+U/KkDYeLuXRepbX+YYLrWZCTzJZvgZd55h8w=;
  b=AwykSUyB0WmhNagLmxWxocxAYHapilLHrt9YjIkLfU4MnAqEfZ6e4Qkh
   bkJjbBbSz9vfyljiXQxDti8JNt5JwUXusBP3ukIer6lfNmuCmvv4p7kI0
   ahW+G1QlGD1vygWhPUKyImQKEWvy2mce7KLxbfENn1CueUFAEjVZBDlqL
   hWgAIod5yToaJ2Nxd5J7M8bfcoxoaqV3m/7r55JRhTECN+vt2+aaAgQyz
   l9hp6ZdEri268bwowHWNqzaTM3BRLdy74ftcjX1NEBWeN4rpbU3xbBnFy
   7LUGFP6/aKJRCOKQT0oJxXfuhD/gpY3u9DKc768Qf4Q3k9rJ4RVxn/xX2
   A==;
X-CSE-ConnectionGUID: 2liL6YWGToeJ0EUxSs3FrA==
X-CSE-MsgGUID: +fvNWychQFSaR4PYab88xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2302077"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2302077"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 02:57:48 -0800
X-CSE-ConnectionGUID: 43AHykudSHympGxlpG29+w==
X-CSE-MsgGUID: Fjb47Nx4QzCgkr4Wz5LA+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="8181103"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa011.fm.intel.com with ESMTP; 03 Nov 2026 02:57:46 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xOCD1-00000000ie0-2XzN;
	Tue, 03 Nov 2026 10:57:43 +0000
Date: Tue, 3 Nov 2026 18:56:53 +0800
From: kernel test robot <lkp@intel.com>
To: Nehuen Lian Bova <nehuenlian.kernel@gmail.com>, jikos@kernel.org,
	bentiss@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nehuen Lian Bova <nehuenlian.kernel@gmail.com>
Subject: Re: [PATCH v2] HID: wacom: replace sprintf calls with safer
 alternatives
Message-ID: <202611031828.iUFgzaYo-lkp@intel.com>
References: <20261101054830.291749-1-nehuenlian.kernel@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261101054830.291749-1-nehuenlian.kernel@gmail.com>

Hi Nehuen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on hid/for-next]
[also build test WARNING on linus/master v7.3 next-20261030]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nehuen-Lian-Bova/HID-wacom-replace-sprintf-calls-with-safer-alternatives/20261101-024830
base:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-next
patch link:    https://lore.kernel.org/r/20261101054830.291749-1-nehuenlian.kernel%40gmail.com
patch subject: [PATCH v2] HID: wacom: replace sprintf calls with safer alternatives
config: nios2-allmodconfig (https://download.01.org/0day-ci/archive/20261103/202611031828.iUFgzaYo-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261103/202611031828.iUFgzaYo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611031828.iUFgzaYo-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/hid/wacom_sys.c: In function '__wacom_initialize_battery':
>> drivers/hid/wacom_sys.c:1842:37: warning: passing argument 2 of 'snprintf' makes integer from pointer without a cast [-Wint-conversion]
    1842 |         snprintf(battery->bat_name, "wacom_battery_%ld", n);
         |                                     ^~~~~~~~~~~~~~~~~~~
         |                                     |
         |                                     char *
   In file included from include/linux/kernel.h:32,
                    from include/linux/random.h:7,
                    from include/linux/nodemask.h:94,
                    from include/linux/numa.h:6,
                    from include/linux/cpumask.h:15,
                    from include/linux/smp.h:13,
                    from include/linux/interrupt_rc.h:18,
                    from include/linux/spinlock.h:60,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:17,
                    from include/linux/hid.h:19,
                    from drivers/hid/wacom_wac.h:7,
                    from drivers/hid/wacom_sys.c:6:
   include/linux/sprintf.h:13:47: note: expected 'size_t' {aka 'unsigned int'} but argument is of type 'char *'
      13 | __printf(3, 4) int snprintf(char *buf, size_t size, const char *fmt, ...);
         |                                        ~~~~~~~^~~~
>> drivers/hid/wacom_sys.c:1842:58: warning: passing argument 3 of 'snprintf' makes pointer from integer without a cast [-Wint-conversion]
    1842 |         snprintf(battery->bat_name, "wacom_battery_%ld", n);
         |                                                          ^
         |                                                          |
         |                                                          long unsigned int
   In file included from include/linux/kernel.h:32,
                    from include/linux/random.h:7,
                    from include/linux/nodemask.h:94,
                    from include/linux/numa.h:6,
                    from include/linux/cpumask.h:15,
                    from include/linux/smp.h:13,
                    from include/linux/interrupt_rc.h:18,
                    from include/linux/spinlock.h:60,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:17,
                    from include/linux/hid.h:19,
                    from drivers/hid/wacom_wac.h:7,
                    from drivers/hid/wacom_sys.c:6:
   include/linux/sprintf.h:13:65: note: expected 'const char *' but argument is of type 'long unsigned int'
      13 | __printf(3, 4) int snprintf(char *buf, size_t size, const char *fmt, ...);
         |                                                     ~~~~~~~~~~~~^~~


vim +/snprintf +1842 drivers/hid/wacom_sys.c

  1820	
  1821	static int __wacom_initialize_battery(struct wacom *wacom,
  1822					      struct wacom_battery *battery)
  1823	{
  1824		static atomic_t battery_no = ATOMIC_INIT(0);
  1825		struct device *dev = &wacom->hdev->dev;
  1826		struct power_supply_config psy_cfg = { .drv_data = battery, };
  1827		struct power_supply *ps_bat;
  1828		struct power_supply_desc *bat_desc = &battery->bat_desc;
  1829		unsigned long n;
  1830		int error;
  1831	
  1832		if (!devres_open_group(dev, bat_desc, GFP_KERNEL))
  1833			return -ENOMEM;
  1834	
  1835		battery->wacom = wacom;
  1836	
  1837		n = atomic_inc_return(&battery_no) - 1;
  1838	
  1839		bat_desc->properties = wacom_battery_props;
  1840		bat_desc->num_properties = ARRAY_SIZE(wacom_battery_props);
  1841		bat_desc->get_property = wacom_battery_get_property;
> 1842		snprintf(battery->bat_name, "wacom_battery_%ld", n);
  1843		bat_desc->name = battery->bat_name;
  1844		bat_desc->type = POWER_SUPPLY_TYPE_BATTERY;
  1845		bat_desc->use_for_apm = 0;
  1846	
  1847		ps_bat = devm_power_supply_register(dev, bat_desc, &psy_cfg);
  1848		if (IS_ERR(ps_bat)) {
  1849			error = PTR_ERR(ps_bat);
  1850			goto err;
  1851		}
  1852	
  1853		power_supply_powers(ps_bat, &wacom->hdev->dev);
  1854	
  1855		battery->battery = ps_bat;
  1856	
  1857		devres_close_group(dev, bat_desc);
  1858		return 0;
  1859	
  1860	err:
  1861		devres_release_group(dev, bat_desc);
  1862		return error;
  1863	}
  1864	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

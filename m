Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793697929;
	b=RVoD/Al6YwYVI1EFmxBWl7VznsFrhbTzkCSYgUxedlnPG2Xwd4M0+3YLK0B02vQt2iWS
	 1IhDNajXBTYbY5y/1c+XzwUJq5vrAE2BGhOIrabsqosdpz3UppnrCxHP9uP4h3inbOX08
	 +NcVpNsq61Jq4QY1Ln9SeCI+RiO+Xj1Njbs7O03sT3vwuLi8nha5Ng4qeMZLqgxxvvbGU
	 /4MbARZNWHbkWLbquOaQzFJvl7RSj82wDP9PsiXlvmwYhFADGJdNODNpO3BorDvMNqux8
	 UuVOokU5E7g0tujTnSf96uvw9uybhZwRWUVPS6EA6lrzY1qT08/fohzqqAob08jxEqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793697929;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=KSnP4S9euXo8SyEvDVfvmfv9B6rnjJbFdgeaCBJsUmQ=;
	b=MU7DivQxIvUHiFR5trCzB2fildJO7V0nabdc9ybz/rLnW8DMQ2c6rsrZmILo9UtrBwJs
	 /kdKVEHqflsTev+xl7wiEn01oTjJta25EwQMGd6ZWj6zS2iV6+xq9kTRed5ncHSZKvkD8
	 IeUdJjN/0O8cDREoDmnQFzNT275Xiz+LmzX47acBYfrjcuAH5WJsjElPcmU9ffcX+VPfF
	 ANIHb3rf+KWDalp1AiHwTpV2jyJuxtkSI2nH95QfjzMGCRGkFHghJRNJdwZhSlVX2TQ5i
	 fg3zi7kURewHzHww6bF8ScM1CiTFUELA9FqoxEhGeOmFxCAlpvPkb70Fi1zjMElMo0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=l1JQssXR;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2335606A329;
	Tue,  3 Nov 2026 09:25:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2335606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=l1JQssXR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793697928; x=1825233928;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JtthRFrvojy0NIzSq09XA/lQI0bfB+fxouHS5omR5kg=;
  b=l1JQssXRzuhhcPsw0ISEv7xxrcZvJ0+davdmjdpB3qYzpugia4Jd1W3o
   XpOFq2rVO1Ne56J3yIhDRBgAG/lT6BpI3ZbXNQDlvY0lT3stRBRyOi1HM
   TCsGmxC+O+h5FSlrt7tUOq9ZXNzDDJaVfEDOw3qLJH4x/cz725CrbJC/T
   XSjwggb1A/D9XyzxPc6LMylb4jaZ9Z48t1hfdoS1cYaJrHsuDLnDAXazY
   8Kg6bOWgTOffOf7cJYIhX4FfTYtbyDVDppX9aLhzqKyWRySmSkeHz3ugE
   iq4/zCcN3bZTggoG9yDc3L43Mp7/UyhbGBtB7e1Zm1IpfDRLb3e/D2Nwi
   g==;
X-CSE-ConnectionGUID: edf871PPQCu98pSShMpj9Q==
X-CSE-MsgGUID: yNzcjRySQUCxvOkuQc+3pg==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2445085"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2445085"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 01:25:27 -0800
X-CSE-ConnectionGUID: iS0V7koUQsGr21cTJoOHXg==
X-CSE-MsgGUID: Iz/OHAS7Rb+hmhs2mupQ4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6725543"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 03 Nov 2026 01:25:25 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xOAlf-00000000iYM-05lv;
	Tue, 03 Nov 2026 09:25:23 +0000
Date: Tue, 3 Nov 2026 17:25:08 +0800
From: kernel test robot <lkp@intel.com>
To: Nehuen Lian Bova <nehuenlian.kernel@gmail.com>, jikos@kernel.org,
	bentiss@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nehuen Lian Bova <nehuenlian.kernel@gmail.com>
Subject: Re: [PATCH v2] HID: wacom: replace sprintf calls with safer
 alternatives
Message-ID: <202611031735.MAqF2fN1-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on hid/for-next]
[also build test ERROR on linus/master v7.3 next-20261030]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nehuen-Lian-Bova/HID-wacom-replace-sprintf-calls-with-safer-alternatives/20261101-024830
base:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-next
patch link:    https://lore.kernel.org/r/20261101054830.291749-1-nehuenlian.kernel%40gmail.com
patch subject: [PATCH v2] HID: wacom: replace sprintf calls with safer alternatives
config: i386-randconfig-1000-20261103 (https://download.01.org/0day-ci/archive/20261103/202611031735.MAqF2fN1-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261103/202611031735.MAqF2fN1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611031735.MAqF2fN1-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/hid/wacom_sys.c:1842:30: error: incompatible pointer to integer conversion passing 'char[18]' to parameter of type '__size_t' (aka 'unsigned int') [-Wint-conversion]
    1842 |         snprintf(battery->bat_name, "wacom_battery_%ld", n);
         |                                     ^~~~~~~~~~~~~~~~~~~
   include/linux/sprintf.h:13:47: note: passing argument to parameter 'size' here
      13 | __printf(3, 4) int snprintf(char *buf, size_t size, const char *fmt, ...);
         |                                               ^
>> drivers/hid/wacom_sys.c:1842:51: error: incompatible integer to pointer conversion passing 'unsigned long' to parameter of type 'const char *' [-Wint-conversion]
    1842 |         snprintf(battery->bat_name, "wacom_battery_%ld", n);
         |                                                          ^
   include/linux/sprintf.h:13:65: note: passing argument to parameter 'fmt' here
      13 | __printf(3, 4) int snprintf(char *buf, size_t size, const char *fmt, ...);
         |                                                                 ^
   2 errors generated.


vim +1842 drivers/hid/wacom_sys.c

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

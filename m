Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E0B184540;
	Wed,  9 Sep 2026 15:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966972; cv=none; b=Nlj9qqEIUTwc48iXzgWzwd1u6B06PiqPII9PfCrpxhgYwXZVd0xigBeVbP6nio4LJ+dzpUWRYzuvg3eoNMx47mti6423X8Gm/KJYX/ssJlxmiaPUpnudyfk4iLhsePUxVL+zYxp0vUd6lNddfSJHcloUXo/tblEWc/pR/PiDN14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966972; c=relaxed/simple;
	bh=tg5yxBv7c7C7xb37aoXpzahE7awVAo/i6IJkGaqCacQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UhRiL8GpWCquiMzYKPPuUMU1TWLawZoxQdtncv7Rk4GJiqSRfkpbBXt7NkfI9x2rOpNwZC97PdTygcf3g7CcXobyDQjuNBFGJa9lQoldZO7j2RDdm4OUt/8E97ZmyyPmremBvywoKCuY3HM2/+ATyf9Mi9i5rYusN7qAn0hoSRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e6WdlCrZ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e6WdlCrZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788966970; x=1820502970;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tg5yxBv7c7C7xb37aoXpzahE7awVAo/i6IJkGaqCacQ=;
  b=e6WdlCrZw0SkH82SDBDlXK9BwveCJlD8CO/S6eB1Ccs3AfIkJ9VzSaxH
   /k3TjaipqTXYCLC7ARBsRyilkpK7hNR9564MOGfA/rIFJzAYqDRcPaA0+
   9t39t9KCyWSEja0Poq79fIAZqgDohNKx97OKV/8g9worh1RiUm3vW0nvz
   EoOj0Z8r2+aXHn1uEMN13/FZ/Vqqps6CH7f0antbtYKmVxxpGpwQ8/ENs
   j5ClGbL0I+ydNQmbawnXiMyc1L+r2mJsF/zk2kcSj6VQbpUpUxPY7gbx0
   sHQzbdH9SJm8zVJmZhlmKs5EoOwSmoz3VsqJD13KjreTWEP5+HsOfJmUa
   g==;
X-CSE-ConnectionGUID: k7i58fCVQLqv7YlcjvtI2A==
X-CSE-MsgGUID: p/bo45SZR72lJsgSQB/7gA==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="100558744"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="100558744"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 08:16:10 -0700
X-CSE-ConnectionGUID: ABVBP+68SaOnxxdqhKA+YA==
X-CSE-MsgGUID: Y9ZM0ItwRkmvLPolUJJ3tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="274863366"
Received: from lkp-server01.sh.intel.com (HELO a3e91e2cf319) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 09 Sep 2026 08:16:09 -0700
Received: from kbuild by a3e91e2cf319 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x4K1t-000000000W0-2VBk;
	Wed, 09 Sep 2026 15:16:05 +0000
Date: Wed, 9 Sep 2026 23:15:15 +0800
From: kernel test robot <lkp@intel.com>
To: Oleg Keri <okerixx@gmail.com>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: lenovo: suppress phantom radio control input on
 Yoga Slim 7x Gen 11
Message-ID: <202609092332.pk1AmDaL-lkp@intel.com>
References: <20260908091907.5653-1-okerixx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908091907.5653-1-okerixx@gmail.com>

Hi Oleg,

kernel test robot noticed the following build errors:

[auto build test ERROR on 5e036ce12de91c6fd674dad33b169c6150be2a7a]

url:    https://github.com/intel-lab-lkp/linux/commits/Oleg-Keri/HID-lenovo-suppress-phantom-radio-control-input-on-Yoga-Slim-7x-Gen-11/20260908-111907
base:   5e036ce12de91c6fd674dad33b169c6150be2a7a
patch link:    https://lore.kernel.org/r/20260908091907.5653-1-okerixx%40gmail.com
patch subject: [PATCH] HID: lenovo: suppress phantom radio control input on Yoga Slim 7x Gen 11
config: sh-allyesconfig (https://download.01.org/0day-ci/archive/20260909/202609092332.pk1AmDaL-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260909/202609092332.pk1AmDaL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609092332.pk1AmDaL-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/hid/hid-lenovo.c: In function 'lenovo_input_mapping':
>> drivers/hid/hid-lenovo.c:523:14: error: 'I2C_DEVICE_ID_ITE_LENOVO_YOGA_SLIM_7X_G11_KEYBOARD' undeclared (first use in this function); did you mean 'I2C_DEVICE_ID_ITE_LENOVO_YOGA_SLIM_7X_KEYBOARD'?
     523 |         case I2C_DEVICE_ID_ITE_LENOVO_YOGA_SLIM_7X_G11_KEYBOARD:
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |              I2C_DEVICE_ID_ITE_LENOVO_YOGA_SLIM_7X_KEYBOARD
   drivers/hid/hid-lenovo.c:523:14: note: each undeclared identifier is reported only once for each function it appears in
   In file included from drivers/hid/hid-lenovo.c:30:
   drivers/hid/hid-lenovo.c: At top level:
>> drivers/hid/hid-lenovo.c:1584:41: error: 'I2C_DEVICE_ID_ITE_LENOVO_YOGA_SLIM_7X_G11_KEYBOARD' undeclared here (not in a function); did you mean 'I2C_DEVICE_ID_ITE_LENOVO_YOGA_SLIM_7X_KEYBOARD'?
    1584 |                      USB_VENDOR_ID_ITE, I2C_DEVICE_ID_ITE_LENOVO_YOGA_SLIM_7X_G11_KEYBOARD) },
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/hid.h:817:64: note: in definition of macro 'HID_DEVICE'
     817 |         .bus = (b), .group = (g), .vendor = (ven), .product = (prod)
         |                                                                ^~~~


vim +523 drivers/hid/hid-lenovo.c

   488	
   489	static int lenovo_input_mapping(struct hid_device *hdev,
   490			struct hid_input *hi, struct hid_field *field,
   491			struct hid_usage *usage, unsigned long **bit, int *max)
   492	{
   493		switch (hdev->product) {
   494		case USB_DEVICE_ID_LENOVO_TPKBD:
   495			return lenovo_input_mapping_tpkbd(hdev, hi, field,
   496								usage, bit, max);
   497		case USB_DEVICE_ID_LENOVO_CUSBKBD:
   498		case USB_DEVICE_ID_LENOVO_CBTKBD:
   499			return lenovo_input_mapping_cptkbd(hdev, hi, field,
   500								usage, bit, max);
   501		case USB_DEVICE_ID_LENOVO_TPIIUSBKBD:
   502		case USB_DEVICE_ID_LENOVO_TPIIBTKBD:
   503			return lenovo_input_mapping_tpIIkbd(hdev, hi, field,
   504								usage, bit, max);
   505		case USB_DEVICE_ID_IBM_SCROLLPOINT_III:
   506		case USB_DEVICE_ID_IBM_SCROLLPOINT_PRO:
   507		case USB_DEVICE_ID_IBM_SCROLLPOINT_OPTICAL:
   508		case USB_DEVICE_ID_IBM_SCROLLPOINT_800DPI_OPTICAL:
   509		case USB_DEVICE_ID_IBM_SCROLLPOINT_800DPI_OPTICAL_PRO:
   510		case USB_DEVICE_ID_LENOVO_SCROLLPOINT_OPTICAL:
   511			return lenovo_input_mapping_scrollpoint(hdev, hi, field,
   512								usage, bit, max);
   513		case USB_DEVICE_ID_LENOVO_TP10UBKBD:
   514			return lenovo_input_mapping_tp10_ultrabook_kbd(hdev, hi, field,
   515								       usage, bit, max);
   516		case USB_DEVICE_ID_LENOVO_X12_TAB:
   517		case USB_DEVICE_ID_LENOVO_X12_TAB2:
   518		case USB_DEVICE_ID_LENOVO_X13_TAB:
   519		case USB_DEVICE_ID_LENOVO_X1_TAB:
   520		case USB_DEVICE_ID_LENOVO_X1_TAB2:
   521		case USB_DEVICE_ID_LENOVO_X1_TAB3:
   522			return lenovo_input_mapping_x1_tab_kbd(hdev, hi, field, usage, bit, max);
 > 523		case I2C_DEVICE_ID_ITE_LENOVO_YOGA_SLIM_7X_G11_KEYBOARD:
   524			return lenovo_input_mapping_yoga7x_g11_kbd(hdev, hi, field, usage, bit, max);
   525		default:
   526			return 0;
   527		}
   528	}
   529	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

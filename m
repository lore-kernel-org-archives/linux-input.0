Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE72E4F6484;
	Wed,  9 Sep 2026 23:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788997725; cv=none; b=RCnYl6yIeIb2/xqCi1B3M+ZTUx+HZpdXZp64ZOY+6JDLkSCMe6mUs6s/JvWIACwAGd7BxwmYRCQ+zoMz1Q6uaO/XPIVXhiRJFi1mqmxoYLw4tE8gPAnPVP/u6Jc8BtpQTJoa22Wjb3sdaLYQgLV+xKw5ZMqylL+SDxOnBj2lN4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788997725; c=relaxed/simple;
	bh=p5metIfVY3CtI+2oTzxtSM1WtBNXuJaHNZRuFvzc/1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6MgsSeyloJzPHVbisnulWWRj0mtcgbRBoTfLb6g6+LWUbJxZTQvvw6hk/tUGDMmeBu8MIlw7vT83sUrkk7xlI0ytKtmRB+2PKqZgX4zMD9j4rN7sNRIvTqYtL24k9To7AlwX63oHHk2AkVtcw9aE6m2bIXVoijXr/oddoPM5xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SO+P7ctG; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SO+P7ctG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788997722; x=1820533722;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p5metIfVY3CtI+2oTzxtSM1WtBNXuJaHNZRuFvzc/1A=;
  b=SO+P7ctGmZKQno/8tZU+M6hlk3QC3syPNBz3XVoPD+/KGUIeZKp0qw7R
   0bX8mos9m+3dghwdyW3HgLxRiupJqczh/Hh5fH93LTrv97dsoZOHh1VB5
   TjUAX2r56/5XT/0fgNqLsMUiheB+xa6gcdo/hoE3DNiavRDNj71nsgzmQ
   56RV+bFGF8fNKutj4EkFtP+d7yD8+rscN1zASTYJ8GruvWDe3mqEbqrAy
   6XS+WgQEodoZX5j3LFB+C90KePLcH9ds401FKZOffafGlXrsNWmmtrp6e
   b+TCv/j5mjpRXZuYx43GyuFncPKac+SkQst5j1qdibPTX+5LCjVw7zAx8
   A==;
X-CSE-ConnectionGUID: Dv+eIRn2Tw6v6lckV41CmQ==
X-CSE-MsgGUID: b21dMTgqQa+fcZ0y0Y/2eA==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="112210650"
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; 
   d="scan'208";a="112210650"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 16:48:41 -0700
X-CSE-ConnectionGUID: xMUZWJzRTSuN4OtwBVjgTA==
X-CSE-MsgGUID: CZmEZki4Rxm7Mj6cn0lD6g==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO a3e91e2cf319) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 09 Sep 2026 16:48:38 -0700
Received: from kbuild by a3e91e2cf319 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x4S1s-0000000015I-0n14;
	Wed, 09 Sep 2026 23:48:36 +0000
Date: Thu, 10 Sep 2026 07:48:31 +0800
From: kernel test robot <lkp@intel.com>
To: Oleg Keri <okerixx@gmail.com>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: lenovo: suppress phantom radio control input on
 Yoga Slim 7x Gen 11
Message-ID: <202609100719.bu2saXPQ-lkp@intel.com>
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
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20260910/202609100719.bu2saXPQ-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project d1c0cc5e760f9cbb68e2acec80a476c4b8b898b7)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260910/202609100719.bu2saXPQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609100719.bu2saXPQ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/hid/hid-lenovo.c:523:7: error: use of undeclared identifier 'I2C_DEVICE_ID_ITE_LENOVO_YOGA_SLIM_7X_G11_KEYBOARD'
     523 |         case I2C_DEVICE_ID_ITE_LENOVO_YOGA_SLIM_7X_G11_KEYBOARD:
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-lenovo.c:1584:27: error: use of undeclared identifier 'I2C_DEVICE_ID_ITE_LENOVO_YOGA_SLIM_7X_G11_KEYBOARD'
    1584 |                      USB_VENDOR_ID_ITE, I2C_DEVICE_ID_ITE_LENOVO_YOGA_SLIM_7X_G11_KEYBOARD) },
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/hid/hid-lenovo.c:1588:1: error: definition of variable with array type needs an explicit size or an initializer
    1588 | MODULE_DEVICE_TABLE(hid, lenovo_devices);
         | ^
   include/linux/module.h:256:21: note: expanded from macro 'MODULE_DEVICE_TABLE'
     256 | static typeof(name) __mod_device_table(type, name)                      \
         |                     ^
   include/linux/module.h:247:2: note: expanded from macro '__mod_device_table'
     247 |         __PASTE(__mod_device_table__,   \
         |         ^
   include/linux/compiler_types.h:16:23: note: expanded from macro '__PASTE'
      16 | #define __PASTE(a, b) ___PASTE(a, b)
         |                       ^
   include/linux/compiler_types.h:15:24: note: expanded from macro '___PASTE'
      15 | #define ___PASTE(a, b) a##b
         |                        ^
   <scratch space>:15:1: note: expanded from here
      15 | __mod_device_table__kmod_hid_lenovo__hid__lenovo_devices
         | ^
   3 errors generated.


vim +/I2C_DEVICE_ID_ITE_LENOVO_YOGA_SLIM_7X_G11_KEYBOARD +523 drivers/hid/hid-lenovo.c

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

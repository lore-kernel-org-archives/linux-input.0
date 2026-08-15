Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF563A6405;
	Sat, 15 Aug 2026 10:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786789775; cv=none; b=pBBQeVONAWEVVaMs2hvkgj5rqe8z5IwDDJm3qwO0kdLnu314TT5yddDrjTw4CEU5XHWO7Sm1r3EPrAP7YpFs4/sc+F5IRco+hbhPti8QsFVIpQns1XG+HAHtdhkHhld23JMHGETes1XNUK/aBSFgM2opDJbdKc9db8Z+ZS+QlSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786789775; c=relaxed/simple;
	bh=Bs+OmwzydiB2X75Lc87OjijEgk4lOEtL6PdvjN4LD10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYS8oQDmUY4V2xSY4HoBt4JZlhRu+pZgEA/QdWEyKZW6lNnJsc1U08+4EDfgO4p4Sm3uQHFosm6GVs23w5lu4RjhQFGu2D1g/f82eYl1WWml/yCVPkS9rk41QUR7hU7XOVB2gyfLXn/YfR23+QW6bNfrWvgbo8UuWvzhRKJF9IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lml8DAbX; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lml8DAbX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786789773; x=1818325773;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Bs+OmwzydiB2X75Lc87OjijEgk4lOEtL6PdvjN4LD10=;
  b=lml8DAbXEOkDtauG17jAWzfeB9K5iU4LN3FZkRBaD3e+lGLnYbSL/VXv
   t05m1EALZ6g8u6X7J/1b9Xdvp+0SL97IYphEHgzhQnzUlNHYDw6LexWTE
   58z2Z1HKpgmOIUWi+IXMe/BDEULqWlbK0k9AxX+V97s6/kdMGNCo0N+F1
   Ov8kqCHeejYAvf4x3dwnn0km6sCyXFSw6VEq31bRKfkMHg4mr8VBcyjmY
   U4Aitp6psjZCEmcIUnhTirzL6GpCIUep0mqYAWoFsCcWV6FgSH6y2jK2W
   ON8ra62iidg54ULUgjqgGXh6qEOg6HM9j+TukOKeVYBAWrk2F79m9XD0t
   w==;
X-CSE-ConnectionGUID: cM580KIkSXat40DDpKugfg==
X-CSE-MsgGUID: qrO2PzgtS1aenSu1o4VPMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11875"; a="87369550"
X-IronPort-AV: E=Sophos;i="6.25,225,1779174000"; 
   d="scan'208";a="87369550"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2026 03:29:32 -0700
X-CSE-ConnectionGUID: 2I1yTlCVRy2EUOGrFrsumw==
X-CSE-MsgGUID: r49eXXSuTv2jTWlMQMc6Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,225,1779174000"; 
   d="scan'208";a="264009203"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 15 Aug 2026 03:29:31 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wvBdo-00000000blu-3tOb;
	Sat, 15 Aug 2026 10:29:28 +0000
Date: Sat, 15 Aug 2026 18:29:24 +0800
From: kernel test robot <lkp@intel.com>
To: VegetablCat <vegetablecat@foxmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vegetablecat <vegetablecat@foxmail.com>
Subject: Re: [PATCH v2] Input: xpad - add support for Beitong KP series
 controllers
Message-ID: <202608151844.kqZOpOOS-lkp@intel.com>
References: <tencent_CD9DBF098D1B3BB565A1DD5761C1D34F4805@qq.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_CD9DBF098D1B3BB565A1DD5761C1D34F4805@qq.com>

Hi VegetablCat,

kernel test robot noticed the following build errors:

[auto build test ERROR on dtor-input/next]
[also build test ERROR on dtor-input/for-linus hid/for-next linus/master v7.2-rc7 next-20260813]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/VegetablCat/Input-xpad-add-support-for-Beitong-KP-series-controllers/20260814-093918
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
patch link:    https://lore.kernel.org/r/tencent_CD9DBF098D1B3BB565A1DD5761C1D34F4805%40qq.com
patch subject: [PATCH v2] Input: xpad - add support for Beitong KP series controllers
config: m68k-randconfig-r071-20260815 (https://download.01.org/0day-ci/archive/20260815/202608151844.kqZOpOOS-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 16.1.0
smatch: v0.5.0-9187-g5189e3fb
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260815/202608151844.kqZOpOOS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608151844.kqZOpOOS-lkp@intel.com/

All errors (new ones prefixed by >>):

   m68k-linux-ld: drivers/input/joystick/xpad.o: in function `xpad_receiver_remove':
>> xpad.c:(.text+0xa): undefined reference to `hid_hw_close'
>> m68k-linux-ld: xpad.c:(.text+0x18): undefined reference to `hid_hw_stop'
   m68k-linux-ld: drivers/input/joystick/xpad.o: in function `xpad_receiver_probe':
>> xpad.c:(.text+0x288): undefined reference to `hid_open_report'
>> m68k-linux-ld: xpad.c:(.text+0x29e): undefined reference to `hid_hw_start'
>> m68k-linux-ld: xpad.c:(.text+0x2ae): undefined reference to `hid_hw_open'
   m68k-linux-ld: xpad.c:(.text+0x2c2): undefined reference to `hid_hw_stop'
   m68k-linux-ld: drivers/input/joystick/xpad.o: in function `xpad_init':
>> xpad.c:(.init.text+0x12): undefined reference to `__hid_register_driver'
>> m68k-linux-ld: xpad.c:(.init.text+0x46): undefined reference to `hid_unregister_driver'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

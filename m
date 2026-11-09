Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794221159;
	b=l7PjTruRU5Ktk6dmvh2L6jVtoU7khiCzshTNadDpABZhk2r7+XAbqU3KaJVfKKZ++Wjv
	 wGs4u0Oq0JfM5FVN/vvgCCjgQg9vgM1lUY3WjHZUpilyXudALj7tmoW5/DIHioj0LDR7W
	 ZYpMV3z1v7639ikZ+GwNsGqd7rPIdP7tUfC7cdoMr/kfX+UiM7eslcG4lN26E/HYD8T7L
	 1HbojORRJSG9Cfgm7dcf8JerEVyxOotwlzPrBi4D1WezpENUXTk0QCQo+AaNHeaVEDy7N
	 bZx2pmJphANsEQ3g6v6HcSMglUDJZIvnVQjEvr5cPA6FHnZtELp9YOM8KIZHIE1wzbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794221159;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Mli2NzOE9bpY2LuU2SDWnBpzIwjxTbdEEyLHTvMsrGY=;
	b=hajnfu5lg+cb12KjoUFWzu9Lp2wlwa0acTUJTxUm4bm4z//Xmh7v85PM+Jabp+2FICyI
	 6Bgl17FcIWxiE6oJB4Exjx6Q4rx1fxJ8aihe/5hgLgnI4wNc/IbTMweBstw7PXM8ZIxkW
	 8NBmymzVo8PPbD9dtyHcN325gERggcDINYageLedP9Q1zZCge9K/pz7/wZESsa1DT5wLY
	 EAj9r9RFx3UGuVUCybcCwjog2XdcQnLx3BiA4anydCZnM34AgDtW2U5mNyCiyflK3/HH7
	 eQytNPifgikBedfhCbl+KWOKuepK6w6byl/RMnKuJ2ljNhveIe1kPEo8c5rJ8YLvxGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BpwUsJiC;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED3B606A322;
	Mon,  9 Nov 2026 10:45:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9ED3B606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BpwUsJiC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794221157; x=1825757157;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IVZ2D9+rtI9pK846EPVCPzIiWQqKJR9uRcmCu/AVT1A=;
  b=BpwUsJiC4N0z+nULCXn49KB1fC9MYoncaSi5SfuSBiUrOJnWCCPIvGp+
   Elp/jK+5e9TuAM7GFjKKqdUupAkxd70sxXo/vrM2kvzcdzmkzXIpjZa+8
   ymx0ZNnxj6ha+K37es0j2yDPD5VP77UMPZNfjAi04zEpZkx1AtnjXgRBd
   fdYIC2JOHFqBe01rERa2xSOVanAghhlpu91DZFTTLJB5UaBRSnZJbaXl2
   NzBR/0/UhRY+CaQjFlit9LHY7pD2N0eLOU1uBulgK5+CMhY41Bnr8rkF1
   6vlR8Hk9lBt07roT4DF7ca0aQ508wHE8y7GKbyUa5tV2Wv3zpthdnlN8t
   g==;
X-CSE-ConnectionGUID: Gkquja3DTBupI5C+46plFQ==
X-CSE-MsgGUID: H9Mq9V58QyiyPEHa9D3mdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2934782"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2934782"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 02:45:57 -0800
X-CSE-ConnectionGUID: 0+QkFJmIRF+hovaGgxvF+g==
X-CSE-MsgGUID: Sy8aaLyxTQ+pjQFGMT7wsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="8012326"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 09 Nov 2026 02:45:55 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xQMsr-00000000uMR-1WR6;
	Mon, 09 Nov 2026 10:45:53 +0000
Date: Mon, 9 Nov 2026 18:45:33 +0800
From: kernel test robot <lkp@intel.com>
To: xujiahao <xujiahao@cmss.chinamobile.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xujiahao <xujiahao@cmss.chinamobile.com>
Subject: Re: [PATCH v2] Input: sidewinder - use scnprintf() for the port names
Message-ID: <202611091814.ChpgVgpE-lkp@intel.com>
References: <20261109010548.438699-1-xujiahao@cmss.chinamobile.com>
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
In-Reply-To: <20261109010548.438699-1-xujiahao@cmss.chinamobile.com>

Hi xujiahao,

kernel test robot noticed the following build errors:

[auto build test ERROR on dtor-input/next]
[also build test ERROR on dtor-input/for-linus hid/for-next linus/master v7.4-rc2 next-20261105]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/xujiahao/Input-sidewinder-use-scnprintf-for-the-port-names/20261109-090548
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
patch link:    https://lore.kernel.org/r/20261109010548.438699-1-xujiahao%40cmss.chinamobile.com
patch subject: [PATCH v2] Input: sidewinder - use scnprintf() for the port names
config: arm-randconfig-1000-20261109 (https://download.01.org/0day-ci/archive/20261109/202611091814.ChpgVgpE-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261109/202611091814.ChpgVgpE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611091814.ChpgVgpE-lkp@intel.com/

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: drivers/input/joystick/sidewinder.o: in function `sw_3dp_id.constprop.0':
>> sidewinder.c:(.text+0xa52): undefined reference to `__aeabi_uldivmod'
>> arm-linux-gnueabi-ld: sidewinder.c:(.text+0xa66): undefined reference to `__aeabi_uldivmod'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

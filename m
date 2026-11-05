Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890096;
	b=QbswO9jVHaM4POeNJt2zUYn5Wx8fFZ3NeawZBcbJJCnfsOswJgIF4OMDr+yukrLXIP4w
	 Eho8HZPJOfujdSj9dpDOWJhE2+LzE7OLUp75oEJxBoyHS72AtAAc7JnWqK+NoJMJ3VhEi
	 4TGmnt8mhCBWGEsspFwgFbNGkKoOflxWdjeQ/XSfenWSAQt3c2Ht302s5RrltCOpLjo4k
	 G9rvfPzq8Z3LLiuZc8pL6YOHFXuDVRDZVqlFgN5LmHpMOGtc1QdGGkCX9XR0YXdexG+NU
	 zlTFIW3s6nUu19NvqPCnHJJkiuJ2mNkbuiANDMUPzay1KePm8rqKLBTYmq38t21ubBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890096;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=9+WarTFPjrorTOPOCDuAawVTRdpULfBt//vr3xzA/14=;
	b=fPQ3nRvcnrSHsWUn62QTRpjEzNNFfaA+eOiYM5Q+05kR4G0YsrZD7O6BiakTPAHQllYm
	 elg8L//yc8TjbEdJcl9wFnSOr8R16pOyd+51NNQD1W82OQLvYh3Dg8ZWm6uIjhFCEhijE
	 De7q67FQzREx1j5gJ3JgeX9zK/1krxzD6s/XBeMlGYtxKJoQgUtwojJSrDWFyx+S0TZQ1
	 cvMwkUNd9BCR260uxyHtXigQ39/ndMw/x5hYhBcBnKsxcNcc1PpJpZoE21d0riiJkUXgn
	 rDE8el0LQOumUjbPgiW70JFtNJmbuCMnGivsYYa5wiFLOVxXzX4mxoqZQb/I7n4gPwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=W6sIWNqz;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF405606A333;
	Thu,  5 Nov 2026 14:48:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF405606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=W6sIWNqz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793890095; x=1825426095;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KyCZcbnpHT5hVUzl2D1R3B/DaLFXMFs3G4PqJWlxB7s=;
  b=W6sIWNqzLVXHLbjtRIZIwc/cWK722YP7HU6SdNeTRWDo+fqBP8qxCjJ6
   98A+IivbAe0CdoDbR9T7j9ht+KuswncaFpyXdKUlAHc3DU1omAlv4j4D1
   6IqmRVjtWDUWXbidgan1MmoWUGOP7eV5rH52Ac2+adra8j4KBX4csh9LW
   yTDEC3AVUMcC2pCnZ19VV2LBt5yurZObPgNs0fEoFjPWk1gNiKNUrqfNp
   tofOQ1Qa5sH3IMa62X1pqAgMIjvYKCpSwLDZ91Y8SD2Q5q7ZB16Jkk1lF
   qFaU/YyetKk7j8wBWk5loWFhhtYIqeyX6HS5tF0UVw79YvGhefR9py83W
   Q==;
X-CSE-ConnectionGUID: sEA/P768SFGly4gUGmTxXA==
X-CSE-MsgGUID: wQD1A6fwTlKKtTeX85h9zQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2674337"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2674337"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 06:48:13 -0800
X-CSE-ConnectionGUID: oQ7me3/wR2ut42hsd5NzCg==
X-CSE-MsgGUID: WfK767yvS0qLGuv4cfWXfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7033009"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 05 Nov 2026 06:48:11 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xOyl7-00000000mL5-1e5I;
	Thu, 05 Nov 2026 14:48:09 +0000
Date: Thu, 5 Nov 2026 22:47:13 +0800
From: kernel test robot <lkp@intel.com>
To: Lovekesh Solanki <lovekeshsolanki00@gmail.com>,
	dmitry.torokhov@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lovekesh Solanki <lovekeshsolanki00@gmail.com>
Subject: Re: [PATCH] Input: synaptics - make InterTouch quirks table driven
Message-ID: <202611052201.kQxXuVQk-lkp@intel.com>
References: <20261105042614.688312-1-lovekeshsolanki00@gmail.com>
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
In-Reply-To: <20261105042614.688312-1-lovekeshsolanki00@gmail.com>

Hi Lovekesh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on dtor-input/next]
[also build test WARNING on dtor-input/for-linus hid/for-next linus/master v7.4-rc1 next-20261030]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lovekesh-Solanki/Input-synaptics-make-InterTouch-quirks-table-driven/20261105-095614
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
patch link:    https://lore.kernel.org/r/20261105042614.688312-1-lovekeshsolanki00%40gmail.com
patch subject: [PATCH] Input: synaptics - make InterTouch quirks table driven
config: csky-defconfig (https://download.01.org/0day-ci/archive/20261105/202611052201.kQxXuVQk-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 16.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261105/202611052201.kQxXuVQk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611052201.kQxXuVQk-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/input/mouse/synaptics.c:226:1: warning: 'synaptics_intertouch_blocklist' defined but not used [-Wunused-const-variable=]
     226 | synaptics_intertouch_blocklist[] = {
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/device.h:15,
                    from include/linux/input.h:19,
                    from include/linux/input/mt.h:11,
                    from drivers/input/mouse/synaptics.c:26:
   drivers/input/mouse/synaptics.c: In function 'synaptics_init_ps2':
   <command-line>: warning: '%s' directive argument is null [-Wformat-overflow=]
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:160:58: note: in expansion of macro 'dev_fmt'
     160 |         dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                          ^~~~~~~
   drivers/input/mouse/psmouse.h:202:9: note: in expansion of macro 'dev_info'
     202 |         dev_info(&(psmouse)->ps2dev.serio->dev,         \
         |         ^~~~~~~~
   drivers/input/mouse/psmouse.h:195:33: note: in expansion of macro 'KBUILD_BASENAME'
     195 | #define psmouse_fmt(fmt)        KBUILD_BASENAME ": " fmt
         |                                 ^~~~~~~~~~~~~~~
   drivers/input/mouse/psmouse.h:203:18: note: in expansion of macro 'psmouse_fmt'
     203 |                  psmouse_fmt(format), ##__VA_ARGS__)
         |                  ^~~~~~~~~~~
   drivers/input/mouse/synaptics.c:1696:17: note: in expansion of macro 'psmouse_info'
    1696 |                 psmouse_info(psmouse,
         |                 ^~~~~~~~~~~~


vim +/synaptics_intertouch_blocklist +226 drivers/input/mouse/synaptics.c

   221	
   222	/*
   223	 * List of devices with broken board revisions.
   224	 */
   225	static const struct synaptics_intertouch_quirk
 > 226	synaptics_intertouch_blocklist[] = {
   227		{
   228			/* ThinkPad T440p */
   229			.board_id = 2722,
   230			.pnp_id = "LEN0036",
   231		},
   232	};
   233	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

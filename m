Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543EB23BCF7;
	Mon,  3 Aug 2026 17:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785777261; cv=none; b=V3tbleW9ScneSCl5UVjUl6UZEhw+VXsz7/LJsNNt+bO813lWf9w7is6kCA2HdHc/pYUpmvHzlG1R2EiE3FcZJrUCyRr+fG0KGwLO4A5Dl4XyU7wzPzvzu9xK6/SpaictDUnV5b2cY6/Y55638qIuwrEseDCMYKFNONiteBjUNpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785777261; c=relaxed/simple;
	bh=jGRz6kdHaHp2LNgVgSF7lUbV2OC6XWABGW1rWxCQqik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9yhsBhMBzaYFO5whkei05WY27gQFkXrplgdZBdR7B/OG+Vf3DfLpJbqITGaLtDulkSgHYBfVXxhlk9wfwfguozw3q0nmw202eUO6FgZ0hrIYt8jozpd0KuMy4x3z3boyOJFkKnkRiw0qAlb8zLofLWuQ1w/dv7aiR3GD9sOkPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NC5n/bFv; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NC5n/bFv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785777260; x=1817313260;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jGRz6kdHaHp2LNgVgSF7lUbV2OC6XWABGW1rWxCQqik=;
  b=NC5n/bFvVHmTzlWYY9UNHpPd9eprQzLdZeG5nVpsIkzD90i5Avr1J5A8
   cw+asXRS2jjc2SIGGABmgd0gSfpY1Y6alTraM1T4dPg0e/8Wncw6wvOmp
   aLCX62gvqaII0MHePf9Rm5t0DaPMZC7pJ6ozoYs1qs9+1McjwOnplGG+C
   d33H7JJLDpeaNov+qMK8o/kG6YLF63YpnjE4oM3BM8qv3CngfPd+yqeV6
   GUeHwJprc9jpwOIRvpFk1kwE+ETmyRh7z2XMTiR5M3kezVh2xEotx1KjM
   YNeGbFIYTDoEgbTPJviswiobVL7uxb0nxVyyFKKnANT2whPQBdtsTva45
   Q==;
X-CSE-ConnectionGUID: ma5LWqo+RBm+ttIFkNr4GA==
X-CSE-MsgGUID: hwnm01u+RKC8JzgG347/eQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="90131972"
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="90131972"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 10:14:19 -0700
X-CSE-ConnectionGUID: vVDKQ1kRSNWmA0Y7HHg1LQ==
X-CSE-MsgGUID: Im4KLYwuTgmg1ciDt1Lu8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="260681372"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 03 Aug 2026 10:14:18 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wqwEw-000000007RV-3jLH;
	Mon, 03 Aug 2026 17:14:14 +0000
Date: Tue, 4 Aug 2026 01:13:47 +0800
From: kernel test robot <lkp@intel.com>
To: Jiale Yao <yaojiale02@163.com>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Miao Li <limiao@kylinos.cn>,
	Nguyen Dinh Dang Duong <dangduong31205@gmail.com>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Jiale Yao <yaojiale02@163.com>
Subject: Re: [PATCH] HID: huawei/rapoo: reject non-USB transports before
 to_usb_interface()
Message-ID: <202608040101.4jtONal7-lkp@intel.com>
References: <20260728064302.3853953-1-yaojiale02@163.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728064302.3853953-1-yaojiale02@163.com>

Hi Jiale,

kernel test robot noticed the following build errors:

[auto build test ERROR on hid/for-next]
[also build test ERROR on linus/master v7.2-rc6 next-20260731]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiale-Yao/HID-huawei-rapoo-reject-non-USB-transports-before-to_usb_interface/20260803-165822
base:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-next
patch link:    https://lore.kernel.org/r/20260728064302.3853953-1-yaojiale02%40163.com
patch subject: [PATCH] HID: huawei/rapoo: reject non-USB transports before to_usb_interface()
config: hexagon-randconfig-001-20260803 (https://download.01.org/0day-ci/archive/20260804/202608040101.4jtONal7-lkp@intel.com/config)
compiler: clang version 22.1.3 (https://github.com/llvm/llvm-project e9846648fd6183ee6d8cbdb4502213fcf902a211)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260804/202608040101.4jtONal7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608040101.4jtONal7-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: hid_is_usb
   >>> referenced by hid-rapoo.c:39 (drivers/hid/hid-rapoo.c:39)
   >>>               drivers/hid/hid-rapoo.o:(rapoo_probe) in archive vmlinux.a
   >>> referenced by hid-rapoo.c:39 (drivers/hid/hid-rapoo.c:39)
   >>>               drivers/hid/hid-rapoo.o:(rapoo_probe) in archive vmlinux.a

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

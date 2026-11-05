Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890215;
	b=KnbfAx+c848JKjlkgKj9tu0gZ7pw1YMCKq0/C7Y1NbIccCZBzXT/j1ghC063QH8BULy7
	 GBbZ2rdY2cmE7kYCrbNlTtcuJaCi63KZYTUecNASO3NTiMztcZwdYFnp2gG6a+e1oAlLj
	 Nuui/ozSq9r/fbRP8/sblPAMp1sYtw7rAzmdoj5QG0fWxr6HKCVu0OyaJfNoTAzaxe9fV
	 cp+WIyZytQuXeOwxaYsof0zJu0y469KB0uC8LpTYgi5GJCGJ77jWd5dXI5+o+9y09iT2F
	 D+3WB6TbeSdBfmJOYLyCQ13bp80KdJenqqhg7Ce+T/gtaN9BtJfDC7OfE2+C9aP5mVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890215;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=b2crl1kVB09+F59TlrEUv7P01dSBP3Uf/xIwzH7wMCc=;
	b=vT6jXnJaRVTNg8Eu3C3l0wWFsuXjlpcgI0TQRsSVHNJaZ+kXYRO1JdSQV6/S6V9u7QkM
	 X5UAaR/bsyhRmquZ9zKrV/OC4TPpdvai31FIE0K3ZjcxVWr/z7Q2eYvxY9Q2MmLx2WUsk
	 mIGgJ8iU4zHGBy5VJQyZSNq5YbDFhmR6HYiuRMV/uwSsuANarrWOJ5xAgBVzwEjIaiDgc
	 Ik1IWuz3kTSpO0lW0m6Vr+tVZiQJOHhv46RMp4lPp+0g5B4Oxa4B/UdD/tN6mcZffu9u7
	 4aRXlAL98nDWwk7cyX2Aw/JllCS4yAy2/R7jWd/p74VuuEtZFh8QigSnvwWBeWSG39w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IyXJrk6W;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C20606A329;
	Thu,  5 Nov 2026 14:50:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46C20606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IyXJrk6W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793890214; x=1825426214;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n9n7IjbZl9ZQnOs7J/aNx4lKInGmgZYASnXAQCl7QHY=;
  b=IyXJrk6WnfzpPAKbLyRImaW7zSH5cPAqQWFoDoJySTzxSwD5SlPeJAXQ
   TJ+/vMsFPOfoGgc80t1/Q1XbirxydpaLTWMFQCx5pcPHDaSk8BhZ8ZLbV
   w6QYaJN9LIY5D5ZdP+ltPBItwjDuqO+oGzOZ5zcwmJt8jHmPcmwH0x4rA
   gxQqOqqThYwBBhyNqi7OcOHpSN/OnkP/AM3P+3xIGASoe0XMTSPATr2IS
   85JuCORsGvN3xgHOuyX+shqt5VLxaXG0y9W7sLhlcU3cVrzWyZ9tBDS4T
   9l3JGXguqHwzQZwVjns1uuMwYvmN8hRVqvPXCKl2WxCMp7QFzAj5LrcNh
   w==;
X-CSE-ConnectionGUID: DduQdqJoRqCK5OvVbPpDQg==
X-CSE-MsgGUID: 8XxZihLvTdaoUFm9bl5vNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2556688"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2556688"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 06:50:14 -0800
X-CSE-ConnectionGUID: JkPnTE3XTFiHxOj97f85iA==
X-CSE-MsgGUID: SttL37Z+QyyqYRlYmUfUzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7342497"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 05 Nov 2026 06:50:13 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xOyn3-00000000mLX-3e4V;
	Thu, 05 Nov 2026 14:50:09 +0000
Date: Thu, 5 Nov 2026 22:49:35 +0800
From: kernel test robot <lkp@intel.com>
To: Lovekesh Solanki <lovekeshsolanki00@gmail.com>,
	dmitry.torokhov@gmail.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lovekesh Solanki <lovekeshsolanki00@gmail.com>
Subject: Re: [PATCH] Input: synaptics - make InterTouch quirks table driven
Message-ID: <202611052257.XSUus1c3-lkp@intel.com>
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
[also build test WARNING on dtor-input/for-linus hid/for-next linus/master v7.3 next-20261030]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lovekesh-Solanki/Input-synaptics-make-InterTouch-quirks-table-driven/20261105-095614
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
patch link:    https://lore.kernel.org/r/20261105042614.688312-1-lovekeshsolanki00%40gmail.com
patch subject: [PATCH] Input: synaptics - make InterTouch quirks table driven
config: um-defconfig (https://download.01.org/0day-ci/archive/20261105/202611052257.XSUus1c3-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 812626a41399a1d464a0d69627ab45c83b8ebfb9)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261105/202611052257.XSUus1c3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611052257.XSUus1c3-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/input/mouse/synaptics.c:226:1: warning: unused variable 'synaptics_intertouch_blocklist' [-Wunused-const-variable]
     226 | synaptics_intertouch_blocklist[] = {
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


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

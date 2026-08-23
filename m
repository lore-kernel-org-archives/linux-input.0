Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B2121FF2A;
	Sun, 23 Aug 2026 12:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787487552; cv=none; b=cPRSa8D4qi0GhIGoBYeUBOpGsUiZBh1SbiNxqxyULMqJJno4xhOmdWhLVFW6U2iltZXnDzLzpMO3yABWXmYN1M8cU5D6H2x4kBqRpYD8G9QgsTSS5P4xTN2x+aB/q6fwmDfU21H8tY1sEjwb4KXrfLVSMT1IIGM0mYkHoIXZQTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787487552; c=relaxed/simple;
	bh=KiMWoZi3tqJGMYG/DWhKStMs8Tk7Ml+qsw2OS+VcwLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZqBOplzDGj+eRlBvvk+LELle5uEjTHUJ2XY0jagnjYMsaI5hX/7Dp2AnLoXEFvxwP5MacTc4cKLW6lfYA5EdGYdrUxhvHFddvN+6aJXUnZy6GKmodCxMBefduSw5bSuy3HpYPXFzSir8iTOwHZ2B7aeWOEQH7UjNEVNkoQDR1Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jHLLpPYX; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jHLLpPYX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787487551; x=1819023551;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KiMWoZi3tqJGMYG/DWhKStMs8Tk7Ml+qsw2OS+VcwLk=;
  b=jHLLpPYX40jRmJk4MOI2LJqXB/ychrIPlct0RgT1qzX/LSLZmpYwlFeW
   H1ikyJobjqwbnb3YgXoupI+8S9Y8IjRN9X7/hUB9rnmULazkONvCEjXkG
   Au4Xef2PJE6pbBYFxb7jlM6EAKHGrp4ELp/he9brw1+h4+nuYsleuqGK6
   HmfJ62Xa4/Ay04i9QKUd1Yst2eFe1PbrkQh6GvJ8fjRTfSSqk54tKebsU
   TgajfIKcH7+0jgkX910Xv7M3ALRLBoJkaxHxA2J/f0B+pFp9pHPqLp9XY
   y3cxmp3N1oB3X2YKEdud2n7Qpl34lVoTHVKDpggQRh5VzIRt1rLW3u1nh
   w==;
X-CSE-ConnectionGUID: wyY96cPcQkqJ5O1bt9OrNQ==
X-CSE-MsgGUID: AVhhLVI6RXu/1CXjNt2LZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11883"; a="75498338"
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; 
   d="scan'208";a="75498338"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 05:19:10 -0700
X-CSE-ConnectionGUID: rp2BGG6IR2iCvt3U3XhlMg==
X-CSE-MsgGUID: KcYGoRcmT7KbiSZNzwPd7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; 
   d="scan'208";a="264133944"
Received: from lkp-server01.sh.intel.com (HELO 3532383e6126) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 23 Aug 2026 05:19:09 -0700
Received: from kbuild by 3532383e6126 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wy7AI-00000000051-1cGK;
	Sun, 23 Aug 2026 12:19:06 +0000
Date: Sun, 23 Aug 2026 20:18:15 +0800
From: kernel test robot <lkp@intel.com>
To: Triet Hoang <triet.hoang.dev@gmail.com>, dmitry.torokhov@gmail.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	Triet Hoang <triet.hoang.dev@gmail.com>
Subject: Re: [PATCH] input: misc: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Message-ID: <202608232022.yWBqVfG0-lkp@intel.com>
References: <20260821024215.55188-1-triet.hoang.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821024215.55188-1-triet.hoang.dev@gmail.com>

Hi Triet,

kernel test robot noticed the following build errors:

[auto build test ERROR on dtor-input/next]
[also build test ERROR on dtor-input/for-linus hid/for-next linus/master v7.2 next-20260821]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Triet-Hoang/input-misc-Convert-to-DEFINE_SIMPLE_DEV_PM_OPS/20260821-094215
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
patch link:    https://lore.kernel.org/r/20260821024215.55188-1-triet.hoang.dev%40gmail.com
patch subject: [PATCH] input: misc: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
config: i386-randconfig-013-20260823 (https://download.01.org/0day-ci/archive/20260823/202608232022.yWBqVfG0-lkp@intel.com/config)
compiler: clang version 22.1.3 (https://github.com/llvm/llvm-project e9846648fd6183ee6d8cbdb4502213fcf902a211)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260823/202608232022.yWBqVfG0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608232022.yWBqVfG0-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/input/misc/88pm80x_onkey.c:50:53: error: use of undeclared identifier 'pm80x_dev_suspend'
      50 | static DEFINE_SIMPLE_DEV_PM_OPS(pm80x_onkey_pm_ops, pm80x_dev_suspend,
         |                                                     ^~~~~~~~~~~~~~~~~
>> drivers/input/misc/88pm80x_onkey.c:51:5: error: use of undeclared identifier 'pm80x_dev_resume'
      51 |                          pm80x_dev_resume);
         |                          ^~~~~~~~~~~~~~~~
>> drivers/input/misc/88pm80x_onkey.c:50:53: error: use of undeclared identifier 'pm80x_dev_suspend'
      50 | static DEFINE_SIMPLE_DEV_PM_OPS(pm80x_onkey_pm_ops, pm80x_dev_suspend,
         |                                                     ^~~~~~~~~~~~~~~~~
>> drivers/input/misc/88pm80x_onkey.c:51:5: error: use of undeclared identifier 'pm80x_dev_resume'
      51 |                          pm80x_dev_resume);
         |                          ^~~~~~~~~~~~~~~~
>> drivers/input/misc/88pm80x_onkey.c:50:53: error: use of undeclared identifier 'pm80x_dev_suspend'
      50 | static DEFINE_SIMPLE_DEV_PM_OPS(pm80x_onkey_pm_ops, pm80x_dev_suspend,
         |                                                     ^~~~~~~~~~~~~~~~~
>> drivers/input/misc/88pm80x_onkey.c:51:5: error: use of undeclared identifier 'pm80x_dev_resume'
      51 |                          pm80x_dev_resume);
         |                          ^~~~~~~~~~~~~~~~
   6 errors generated.


vim +/pm80x_dev_suspend +50 drivers/input/misc/88pm80x_onkey.c

    49	
  > 50	static DEFINE_SIMPLE_DEV_PM_OPS(pm80x_onkey_pm_ops, pm80x_dev_suspend,
  > 51				 pm80x_dev_resume);
    52	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

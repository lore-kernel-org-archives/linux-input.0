Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E51E2E413;
	Sun, 24 May 2026 01:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779584650; cv=none; b=DZof/Fh3QIGqNkIloOWJ5/mTfXB3deddqjG4rcI43gbq0TgTuw1XyOFIPhYhROQRyESdV0AGDgnSq2vR+d0z6KXLj2JboViSPZWE3fAR0T/pLpRv1MJFiteMHZvf+PrzrR6t/MB4yXvHx+cH4W539U8l/1tuAmYK6nUIXwpttWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779584650; c=relaxed/simple;
	bh=0jxUiWpuObnUElHoR2o5w399YDk8x9hyniPquFTHWDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wqq05+0nV+liYEpLLt05ebYbtvnLDfmARjnLk4uK5RzwFuO++1AjXDbK/oBeBJDDoT854zinBP7e4dbegoD2zJUD5B2xOq7Eu6YJATYJ/9iDf1HnoRE2Opq96/0+rOy00OxetBvzXBZz1pTJzt6ZVvlvlAt5GFt2EaOPzDsgZKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=StNpVdQC; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="StNpVdQC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779584648; x=1811120648;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0jxUiWpuObnUElHoR2o5w399YDk8x9hyniPquFTHWDU=;
  b=StNpVdQC/+GGa/rhIr8l8XY3+RbPsv6UeuXmxmE7QnEpoB7NN80w59Sn
   POXG6+XKeCqXYPw1TRxTGhk2WopSYag1ht3UYTycwfO//G5LrTIO3ji3J
   tQxE0SkE98K0mhxrRv+5qUhUhDLNB3KZpE20ncHt51oyj8lMadfG5ZRq7
   Ds/MOji4n1Fm+GYTrcu9IoKIiyIZU/2I3mPopmc4dq5kCgAR8yjL+Osw7
   jWlrC/Ut0jv7S8tYd+78e61Kg2ALn5iiJZethxksiSbpNREIgHiwhO/e0
   9f0NJBm0wH32jx2NCr95NHrrWywcsiDc/bNwo6KvloamzC4efmR5tTjwd
   Q==;
X-CSE-ConnectionGUID: X9nbrfklS9O8gKSnM5GXBQ==
X-CSE-MsgGUID: lwoSrLCYRuSJ9bLCs/4tOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11795"; a="80367428"
X-IronPort-AV: E=Sophos;i="6.24,165,1774335600"; 
   d="scan'208";a="80367428"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2026 18:04:07 -0700
X-CSE-ConnectionGUID: bvlitePeTACjAGGMx8n27w==
X-CSE-MsgGUID: m09Bao3FR8KFcbqda/29Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,165,1774335600"; 
   d="scan'208";a="237041489"
Received: from lkp-server01.sh.intel.com (HELO 6ba8523b1a8f) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 23 May 2026 18:04:04 -0700
Received: from kbuild by 6ba8523b1a8f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wQxG6-000000000WL-1TEY;
	Sun, 24 May 2026 01:04:02 +0000
Date: Sun, 24 May 2026 09:03:44 +0800
From: kernel test robot <lkp@intel.com>
To: yaolu@kylinos.cn, jikos@kernel.org, bentiss@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lu Yao <yaolu@kylinos.cn>,
	k2ci <kernel-bot@kylinos.cn>
Subject: Re: [PATCH] HID: core: Fix bsize printk specifier in
 hid_report_raw_event()
Message-ID: <202605240823.YKX23Xjr-lkp@intel.com>
References: <20260522072718.186707-1-yaolu@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522072718.186707-1-yaolu@kylinos.cn>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on hid/for-next]
[also build test WARNING on v7.1-rc4]
[cannot apply to linus/master next-20260522]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/yaolu-kylinos-cn/HID-core-Fix-bsize-printk-specifier-in-hid_report_raw_event/20260522-152828
base:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-next
patch link:    https://lore.kernel.org/r/20260522072718.186707-1-yaolu%40kylinos.cn
patch subject: [PATCH] HID: core: Fix bsize printk specifier in hid_report_raw_event()
config: alpha-defconfig (https://download.01.org/0day-ci/archive/20260524/202605240823.YKX23Xjr-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260524/202605240823.YKX23Xjr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605240823.YKX23Xjr-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/input.h:19,
                    from drivers/hid/hid-core.c:25:
   drivers/hid/hid-core.c: In function 'hid_report_raw_event':
>> drivers/hid/hid-core.c:2053:43: warning: format '%u' expects argument of type 'unsigned int', but argument 5 has type 'size_t' {aka 'long unsigned int'} [-Wformat=]
    2053 |                 hid_warn_ratelimited(hid, "Event data for report %d is incorrect (%d vs %u)\n",
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:156:61: note: in expansion of macro 'dev_fmt'
     156 |         dev_printk_index_wrap(_dev_warn, KERN_WARNING, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                             ^~~~~~~
   include/linux/dev_printk.h:215:17: note: in expansion of macro 'dev_warn'
     215 |                 dev_level(dev, fmt, ##__VA_ARGS__);                     \
         |                 ^~~~~~~~~
   include/linux/dev_printk.h:227:9: note: in expansion of macro 'dev_level_ratelimited'
     227 |         dev_level_ratelimited(dev_warn, dev, fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/hid.h:1340:9: note: in expansion of macro 'dev_warn_ratelimited'
    1340 |         dev_warn_ratelimited(&(hid)->dev, fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-core.c:2053:17: note: in expansion of macro 'hid_warn_ratelimited'
    2053 |                 hid_warn_ratelimited(hid, "Event data for report %d is incorrect (%d vs %u)\n",
         |                 ^~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-core.c:2053:90: note: format string is defined here
    2053 |                 hid_warn_ratelimited(hid, "Event data for report %d is incorrect (%d vs %u)\n",
         |                                                                                         ~^
         |                                                                                          |
         |                                                                                          unsigned int
         |                                                                                         %lu
   drivers/hid/hid-core.c:2075:43: warning: format '%u' expects argument of type 'unsigned int', but argument 5 has type 'size_t' {aka 'long unsigned int'} [-Wformat=]
    2075 |                 hid_warn_ratelimited(hid, "Event data for report %d was too short (%d vs %u)\n",
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:156:61: note: in expansion of macro 'dev_fmt'
     156 |         dev_printk_index_wrap(_dev_warn, KERN_WARNING, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                             ^~~~~~~
   include/linux/dev_printk.h:215:17: note: in expansion of macro 'dev_warn'
     215 |                 dev_level(dev, fmt, ##__VA_ARGS__);                     \
         |                 ^~~~~~~~~
   include/linux/dev_printk.h:227:9: note: in expansion of macro 'dev_level_ratelimited'
     227 |         dev_level_ratelimited(dev_warn, dev, fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/hid.h:1340:9: note: in expansion of macro 'dev_warn_ratelimited'
    1340 |         dev_warn_ratelimited(&(hid)->dev, fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-core.c:2075:17: note: in expansion of macro 'hid_warn_ratelimited'
    2075 |                 hid_warn_ratelimited(hid, "Event data for report %d was too short (%d vs %u)\n",
         |                 ^~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-core.c:2075:91: note: format string is defined here
    2075 |                 hid_warn_ratelimited(hid, "Event data for report %d was too short (%d vs %u)\n",
         |                                                                                          ~^
         |                                                                                           |
         |                                                                                           unsigned int
         |                                                                                          %lu


vim +2053 drivers/hid/hid-core.c

  2035	
  2036	int hid_report_raw_event(struct hid_device *hid, enum hid_report_type type, u8 *data,
  2037				 size_t bufsize, u32 size, int interrupt)
  2038	{
  2039		struct hid_report_enum *report_enum = hid->report_enum + type;
  2040		struct hid_report *report;
  2041		struct hid_driver *hdrv;
  2042		int max_buffer_size = HID_MAX_BUFFER_SIZE;
  2043		u32 rsize, csize = size;
  2044		size_t bsize = bufsize;
  2045		u8 *cdata = data;
  2046		int ret = 0;
  2047	
  2048		report = hid_get_report(report_enum, data);
  2049		if (!report)
  2050			return 0;
  2051	
  2052		if (unlikely(bsize < csize)) {
> 2053			hid_warn_ratelimited(hid, "Event data for report %d is incorrect (%d vs %u)\n",
  2054					     report->id, csize, bsize);
  2055			return -EINVAL;
  2056		}
  2057	
  2058		if (report_enum->numbered) {
  2059			cdata++;
  2060			csize--;
  2061			bsize--;
  2062		}
  2063	
  2064		rsize = hid_compute_report_size(report);
  2065	
  2066		if (hid->ll_driver->max_buffer_size)
  2067			max_buffer_size = hid->ll_driver->max_buffer_size;
  2068	
  2069		if (report_enum->numbered && rsize >= max_buffer_size)
  2070			rsize = max_buffer_size - 1;
  2071		else if (rsize > max_buffer_size)
  2072			rsize = max_buffer_size;
  2073	
  2074		if (bsize < rsize) {
  2075			hid_warn_ratelimited(hid, "Event data for report %d was too short (%d vs %u)\n",
  2076					     report->id, rsize, bsize);
  2077			return -EINVAL;
  2078		}
  2079	
  2080		if (csize < rsize) {
  2081			dbg_hid("report %d is too short, (%d < %d)\n", report->id,
  2082				csize, rsize);
  2083			memset(cdata + csize, 0, rsize - csize);
  2084		}
  2085	
  2086		if ((hid->claimed & HID_CLAIMED_HIDDEV) && hid->hiddev_report_event)
  2087			hid->hiddev_report_event(hid, report);
  2088		if (hid->claimed & HID_CLAIMED_HIDRAW) {
  2089			ret = hidraw_report_event(hid, data, size);
  2090			if (ret)
  2091				return ret;
  2092		}
  2093	
  2094		if (hid->claimed != HID_CLAIMED_HIDRAW && report->maxfield) {
  2095			hid_process_report(hid, report, cdata, interrupt);
  2096			hdrv = hid->driver;
  2097			if (hdrv && hdrv->report)
  2098				hdrv->report(hid, report);
  2099		}
  2100	
  2101		if (hid->claimed & HID_CLAIMED_INPUT)
  2102			hidinput_report_event(hid, report);
  2103	
  2104		return ret;
  2105	}
  2106	EXPORT_SYMBOL_GPL(hid_report_raw_event);
  2107	
  2108	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4394239B964
	for <linux-input@vger.kernel.org>; Tue, 12 May 2026 22:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778623872; cv=none; b=KpA8dzZVZAbh9pU0LaKpfjHlL7Yfs7FqlECsPOcDSwphumRFBK4dsKuR8qj4uFryHWj9DmhMClppeKjw2/5cICxq+S16EQRKxaRIqKF2gHcz5lzsJwvVRjXbRzTWUg9Xe6rdMIQpMQugyY96fWDIIYyW7OA9mSfTxGmlAvN7elc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778623872; c=relaxed/simple;
	bh=sTfY+TbLiEI19mCEeQj1xd4ACM74qvNvLPCWOv0FG+4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=LhSCros/BHasgJZIotxu7wgvFwitunOlnNTmucEheQtGEIXgy+eCXz/fAzHYv/iAWvuouzEhjm3ijWPvoTvUwGSK2xZHfY7l/FzoXlZcfr3JBsU1OLp5qLYlInYpGNU5BEX273dSbPfaHG4mhXmOC5K31wZPJXLhi+/o77cpbXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kOj6Zpar; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kOj6Zpar"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778623871; x=1810159871;
  h=date:from:to:cc:subject:message-id;
  bh=sTfY+TbLiEI19mCEeQj1xd4ACM74qvNvLPCWOv0FG+4=;
  b=kOj6ZparYCr2dGZrUXJ78XQ026aiDHmM4b5WY+cQ6wrqv+d/H0qVX4ly
   R1GeR2wr1yrGbm/mtPJod3jrPWIpDgEzcemGiRMcsrUmw8u7k57uIGZW0
   +aaOBvY/BG0iZWDJRkNBolhbPMA/chMx2kq7lmLhhAb/pj5tDxjMMdcUE
   Ln0gziyPbzVZKB6XuaMvrAHWPpQX9YrSxSvUevQGPeepzyPxcvUe9a7Zk
   7DuOaoa7In7q6ObjIdKEP6g8Ou8FeWOUvII/9WksW8xFm04li6UTTiVeZ
   rgXrEXKjSDtnW9E3m7n9CIXpZ9BgG25RFesFfHebfuEoHvmWev9Dbc4z0
   Q==;
X-CSE-ConnectionGUID: zGxE8uOPS3SoOXTmc2izRg==
X-CSE-MsgGUID: QkexcxSZSkenkv2P0Lip2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79494713"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="79494713"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 15:11:11 -0700
X-CSE-ConnectionGUID: GTRD6UKBSKKKGJ1TK+P/Tg==
X-CSE-MsgGUID: oin+gVBxSjq1xVwJbIfe6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="237984930"
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 12 May 2026 15:11:09 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wMvJi-000000002tD-0XpA;
	Tue, 12 May 2026 22:11:06 +0000
Date: Wed, 13 May 2026 06:10:25 +0800
From: kernel test robot <lkp@intel.com>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-input@vger.kernel.org,
 Jiri Kosina <jikos@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Subject: [hid:for-next 9/14] drivers/hid/hid-core.c:2053:43: warning:
 format '%ld' expects argument of type 'long int', but argument 5 has type
 'size_t' {aka 'unsigned int'}
Message-ID: <202605130624.FPpzDGhD-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-next
head:   5d1aae9252b4632ef942017fdd18b9993a5a22ef
commit: 2c85c61d1332e1e16f020d76951baf167dcb6f7a [9/14] HID: pass the buffer size to hid_report_raw_event
config: nios2-defconfig (https://download.01.org/0day-ci/archive/20260513/202605130624.FPpzDGhD-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260513/202605130624.FPpzDGhD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605130624.FPpzDGhD-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/input.h:19,
                    from drivers/hid/hid-core.c:25:
   drivers/hid/hid-core.c: In function 'hid_report_raw_event':
>> drivers/hid/hid-core.c:2053:43: warning: format '%ld' expects argument of type 'long int', but argument 5 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
    2053 |                 hid_warn_ratelimited(hid, "Event data for report %d is incorrect (%d vs %ld)\n",
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
   drivers/hid/hid-core.c:2053:17: note: in expansion of macro 'hid_warn_ratelimited'
    2053 |                 hid_warn_ratelimited(hid, "Event data for report %d is incorrect (%d vs %ld)\n",
         |                 ^~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-core.c:2053:91: note: format string is defined here
    2053 |                 hid_warn_ratelimited(hid, "Event data for report %d is incorrect (%d vs %ld)\n",
         |                                                                                         ~~^
         |                                                                                           |
         |                                                                                           long int
         |                                                                                         %d
   In file included from include/linux/device.h:15,
                    from include/linux/input.h:19,
                    from drivers/hid/hid-core.c:25:
   drivers/hid/hid-core.c:2075:43: warning: format '%ld' expects argument of type 'long int', but argument 5 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
    2075 |                 hid_warn_ratelimited(hid, "Event data for report %d was too short (%d vs %ld)\n",
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
    2075 |                 hid_warn_ratelimited(hid, "Event data for report %d was too short (%d vs %ld)\n",
         |                 ^~~~~~~~~~~~~~~~~~~~
   drivers/hid/hid-core.c:2075:92: note: format string is defined here
    2075 |                 hid_warn_ratelimited(hid, "Event data for report %d was too short (%d vs %ld)\n",
         |                                                                                          ~~^
         |                                                                                            |
         |                                                                                            long int
         |                                                                                          %d


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
> 2053			hid_warn_ratelimited(hid, "Event data for report %d is incorrect (%d vs %ld)\n",
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
  2075			hid_warn_ratelimited(hid, "Event data for report %d was too short (%d vs %ld)\n",
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

Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551DA1E8826;
	Fri, 24 Apr 2026 01:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776992943; cv=none; b=Vv9f2sy2mUYsSmRCEUysSbYyCS9op35wU62lhCjVGgBdLyBG4YCjjNGWGMmAZ4iki+9z3c7MfaSAy7cZdOisy7i74yJn8ZkvpiVM1IEF5SowhdvTnkUMztRvEs6YyqPhkEtw9V6y4AhmaeGpG9LDCTAwSbvizYeUlSzQdnE6ar4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776992943; c=relaxed/simple;
	bh=0zkjJP1zHYwltE31Ri1er1j8LFZiRVKxMvtOSk6Erp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FtpYDQylB8S0WRCuFsm9LDGATiFZ5x+aqoDQYDCMgOnu/WEhjejZaGDoFkXE8DIolktOP2chhqiTdNg48HSJxZ40fHSIjbS6xgRb2x8lpFp0PqTOSCJ3BVSAGiaNanpo+Qf8WZWf4KD4JEqNMkx7yrlNvnp7jgFKmdpm6Nb5ANY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G6c49eT2; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G6c49eT2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776992940; x=1808528940;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0zkjJP1zHYwltE31Ri1er1j8LFZiRVKxMvtOSk6Erp4=;
  b=G6c49eT2xxfGfJC6qz4FBINuKmmGCuQmxu5s0q/EG2jYm8av7mkZPYKE
   ooR9VELtzp+KvpMZ9I6f0Co7ZLdVoYunMXpWkDmfMqPKDTF8MOqeEBtwq
   lNUKqC4rKf9WangkpNWmfRImw0TEp1AF2T4iCmfPtgYeL2j+zNT9PPw5+
   HFtI9Cipcm/Z0Vf5m7S/UHvWmCWvdhuaOvkUR/5w3WU8Vn5JiTyCp8I7S
   2eu/sRMR26Ol5cwUeCf9801fCFnYQJ9qiXQicygWwes7IiIGOwfXaW/pv
   IXN+KY23g63wDEmsxo0c2dNU0ZFKKGCsFr6nE4Hx4/5+q4FWLw8dYpzXX
   g==;
X-CSE-ConnectionGUID: fT52gSvgSvqYHbVsQUXbZw==
X-CSE-MsgGUID: aup04TeCSLGy2HfBFO0cUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="103434921"
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; 
   d="scan'208";a="103434921"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 18:09:00 -0700
X-CSE-ConnectionGUID: 30x24oQRTGCM+k+szEK56Q==
X-CSE-MsgGUID: zzKOK609RIGMo/pUoCBycw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; 
   d="scan'208";a="228246883"
Received: from igk-lkp-server01.igk.intel.com (HELO bdf09bfdbd5f) ([10.211.93.152])
  by fmviesa006.fm.intel.com with ESMTP; 23 Apr 2026 18:08:56 -0700
Received: from kbuild by bdf09bfdbd5f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wG52L-0000000038n-3zcG;
	Fri, 24 Apr 2026 01:08:53 +0000
Date: Fri, 24 Apr 2026 03:08:03 +0200
From: kernel test robot <lkp@intel.com>
To: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Filipe =?iso-8859-1?Q?La=EDns?= <lains@riseup.net>,
	Bastien Nocera <hadess@hadess.net>,
	Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Viresh Kumar <vireshk@kernel.org>, Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lee Jones <lee@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev, linux-usb@vger.kernel.org,
	Benjamin Tissoires <bentiss@kernel.org>
Subject: Re: [PATCH v2 4/4] HID: wacom: use __free(kfree) to clean up
 temporary buffers
Message-ID: <202604240311.WgVgLjLa-lkp@intel.com>
References: <20260416-wip-fix-core-v2-4-be92570e5627@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416-wip-fix-core-v2-4-be92570e5627@kernel.org>

Hi Benjamin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 7df6572f1cb381d6b89ceed58e3b076c233c2cd0]

url:    https://github.com/intel-lab-lkp/linux/commits/Benjamin-Tissoires/HID-pass-the-buffer-size-to-hid_report_raw_event/20260422-150759
base:   7df6572f1cb381d6b89ceed58e3b076c233c2cd0
patch link:    https://lore.kernel.org/r/20260416-wip-fix-core-v2-4-be92570e5627%40kernel.org
patch subject: [PATCH v2 4/4] HID: wacom: use __free(kfree) to clean up temporary buffers
config: i386-randconfig-2006-20250804 (https://download.01.org/0day-ci/archive/20260424/202604240311.WgVgLjLa-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260424/202604240311.WgVgLjLa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604240311.WgVgLjLa-lkp@intel.com/

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

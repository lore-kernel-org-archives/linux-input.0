Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794254942;
	b=crMovuw36Knf/srT3+XJpguf1Yn/msOV5EdV6mFt3hCgQON4VL+O8NU+h6p5mNMtNRfj
	 VSPLJhJZhMCgeHCxwFgfBO6RDN3koD8nxCS4/CEFzbcgbVBS/6iT8Z+hSdiebVJlZMr4C
	 SXmTDNlWK063st+g/5EBz3Y45qFUIbJScnCyZEjoiBwvNkWb4bLn+PM/M18bnKakmoqGf
	 +OUg3QMD0DbHrqD5WBpBxwhwEiFgMBLPx905tMNRMkWYThPg4Qc2AVfz7luXgSDnxTCvm
	 vFtCiz8rK5sbCXpPLT/oNYLRE362Oxf5mLvZWSvrzjxivwtygqGsHfvJQyPh3mmJCaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254942;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=KctrobPWYEwSUCDsU0lDskRvOHLV+0aAUXG3Dlafoi4=;
	b=EoBRELseSJb/H+kTDCva+imZXnggEuDziHORSYQayCXbvAEZEQf5oPf2i3Hr4jXgjylt
	 PjvXaq/h8I6TI3z7chTVFC/6QIWzfFmGR4fwO7Nu0P+Cyw242DI1v1sWeTMbxcHCjcZ+l
	 w5w5+a3SPtT1px88oQusxEJeBS7LeGJPSR1POjQu1m2IITOZzNdRkHkM6kD0loxw4WJ/z
	 PP+JCmM1Gw4q0Z/kB496MsEvcPpM6CGDWly0Y6DoSbQ71ixPMF884ABRsrSxyFf9ipxhS
	 QGynfDpAGr50PJSMAy5dM53rqwZtwwD3Nsf+w8xmnT82Nv169DigOgSqnY7mT4bNIYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iDENWkMv;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023F1606A330;
	Mon,  9 Nov 2026 20:09:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 023F1606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iDENWkMv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794254943; x=1825790943;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pEe8ZQEP3LK/ykVmviX1NKx7J77jZvukhYATfQ7CaP4=;
  b=iDENWkMvY1zl4NrB4/XbZFLhgjL8QawX0hRszp5vLCw9UCDRYbwwTN8y
   HQBXEMr8ImXmIUXTZZ14iCftwm+1V+xJ0U6eLFk6FTxy/yoRSlAC5piEF
   cEq0e5hJcGBXGkpKSV5q5Z9Dnce5oxc8nXvv6LhyV8HJSEw50mKGIQnxc
   9BDKK5jlcCInBqpLCItHINcGxCWvtgmZbFs2TW1V7/sVfDCCdQJmgfuuc
   pHi8YluLPcrwJE54o15GIzTxirwRp+XqkzNSuxpRQs+skJf9pN0gjR5DP
   +EtyyQitC8I5ZUbmaQ3V+cB4YdG+C7D1fYjeimkkSWOU00AW0VPci3SEL
   A==;
X-CSE-ConnectionGUID: KdWr4texQqWKhCUCXYXiFQ==
X-CSE-MsgGUID: jZUypDk+Rr2UBed+EEEHXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2982669"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2982669"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 12:09:02 -0800
X-CSE-ConnectionGUID: osi9n8QgQkuTHopdGK1QtQ==
X-CSE-MsgGUID: 3DupIJkiTHqILqlt1RCvJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="8272637"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 09 Nov 2026 12:09:00 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xQVfl-00000000vG3-2LpF;
	Mon, 09 Nov 2026 20:08:57 +0000
Date: Tue, 10 Nov 2026 04:08:39 +0800
From: kernel test robot <lkp@intel.com>
To: xujiahao <xujiahao@cmss.chinamobile.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xujiahao <xujiahao@cmss.chinamobile.com>
Subject: Re: [PATCH v2] Input: sidewinder - use scnprintf() for the port names
Message-ID: <202611100328.QAelfSpD-lkp@intel.com>
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
[also build test ERROR on dtor-input/for-linus hid/for-next linus/master v7.4-rc2 next-20261109]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/xujiahao/Input-sidewinder-use-scnprintf-for-the-port-names/20261109-090548
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
patch link:    https://lore.kernel.org/r/20261109010548.438699-1-xujiahao%40cmss.chinamobile.com
patch subject: [PATCH v2] Input: sidewinder - use scnprintf() for the port names
config: i386-randconfig-1006-20261109 (https://download.01.org/0day-ci/archive/20261110/202611100328.QAelfSpD-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261110/202611100328.QAelfSpD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611100328.QAelfSpD-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/input/joystick/sidewinder.o: in function `sw_3dp_id':
>> drivers/input/joystick/sidewinder.c:542:(.text+0x1630): undefined reference to `__umoddi3'
>> ld: drivers/input/joystick/sidewinder.c:540:(.text+0x1652): undefined reference to `__udivdi3'


vim +542 drivers/input/joystick/sidewinder.c

   519	
   520	/*
   521	 * sw_3dp_id() translates the 3DP id into a human legible string.
   522	 * Unfortunately I don't know how to do this for the other SW types.
   523	 */
   524	
   525	static void sw_3dp_id(unsigned char *buf, char *comment, size_t size)
   526	{
   527		int i;
   528		char pnp[8], rev[9];
   529	
   530		for (i = 0; i < 7; i++)						/* ASCII PnP ID */
   531			pnp[i] = sw_get_bits(buf, 24+8*i, 8, 1);
   532	
   533		for (i = 0; i < 8; i++)						/* ASCII firmware revision */
   534			rev[i] = sw_get_bits(buf, 88+8*i, 8, 1);
   535	
   536		pnp[7] = rev[8] = 0;
   537	
   538		scnprintf(comment, size, " [PnP %d.%02d id %s rev %s]",
   539			  (int)(((sw_get_bits(buf, 8, 6, 1) << 6) |	/* Two 6-bit values */
 > 540				  sw_get_bits(buf, 16, 6, 1)) / 100),
   541			  (int)(((sw_get_bits(buf, 8, 6, 1) << 6) |
 > 542				  sw_get_bits(buf, 16, 6, 1)) % 100),
   543			  pnp, rev);
   544	}
   545	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793757558;
	b=PziLzcJuTpmTlzKdhRURZlRRiyagnC9zXO+C8iwkUvfbdtS/KPQUKPgFxR9+P6Jtigwk
	 FPv2FsO65LQc9KmVBrrKjfJkPRSLlJmgvTMNb2njzkEFi3oMuDdjaGRvNwsMekhsGIow+
	 iPn64hK3xt4LyBNJczMmPVtsTGecAs58Lvicp1v56WyQ9g/H7fe5Ad5kEFcvrHbv9MNRS
	 bajc38uDIcxr8RTIp5WruZfL+Qqkpvk1PRZ742iIX91COyucXXvpLWIEQh2h2olBoH7Mg
	 7gZw6Qb1hpKVWWvNE1TZPVNp72QjJ+TYgojHM2+TzvVseytKNZ65ybQVeTwainvgm5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793757558;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=94fP6Ho6+DuYZ0Erkyl8RwrkCAL6tT/V8+5vJIb21o0=;
	b=XvDOfLKIRCn1bJKbxdBBgwtrxg6t49VxqoToQa3a4k7PlLjBH5UT1wfQXr+0reDG8Nsh
	 zkAQXusyh+MfilAlpwUoBnH97wCsRg6UXw2P91wjK9cTGrFg5kIOxIXC4QxJYfBekGFUI
	 EtHt7p+7ft+R/eOtqNx1C+qnhGUSVcyWpaBlJzXcrXBRT+LMMqGg1gzF0NA0d7v9SbwvC
	 OET1m3AL8jsD8BNq/udFtdWmxbIbFcYaOOwedDqb1Gh+dsIrVFeMdBClcVGyzn88fRFu1
	 GfvJT/1Hag04D5BrALTwjQx6DhajQpgH7t2mr0Pbn5TVC+0cPlYDSWh9W8l0hWgfspw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Rwe5sfor;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240DD606A326;
	Wed,  4 Nov 2026 01:59:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 240DD606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Rwe5sfor
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793757558; x=1825293558;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o+9cRu0WUKk/jyUxqLdHClP4gcQH0YZV/4qZjL8WnVg=;
  b=Rwe5sforljhGUk4U69kxxfDK22xF+tovVlFeUkMSNulG5233PoeJk7tl
   23jkX+TurYbjf+sLQxSUjjyHxV6dJR5QYhFjoY2QAEcVoyYDDpOvkm7bW
   71MuIv/QbtpDnTmfkvPujnxAGxyc56DIG8CNdHz0aAuFadTkg6d6SqBmA
   Zcp/DoiDOy5ondliWRy7p4+hfp5A8roPM7vJ/bWMQc27ehzO7YMTScuVd
   5hRHS4U0CYlJqJ7Uh4K3dDTLuMk8QA/AbMi8baFUf72qzU0feMx4/un8m
   ITbmbK4eeHrREeRiI7j9b3dWjpP55PRUCV1opJPHTaxLChP8bjg/quvhF
   g==;
X-CSE-ConnectionGUID: /Uw8w13wRiuFX28xbGUfHw==
X-CSE-MsgGUID: X8d+8AjmRMCM7okRuAQUjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2378457"
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="2378457"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 17:59:17 -0800
X-CSE-ConnectionGUID: REKVW3YfQfCgwfioqiNxxQ==
X-CSE-MsgGUID: ww2zn0BRT7msiJezGvul0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="6432817"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 03 Nov 2026 17:59:14 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xOQHP-00000000jbv-1RMn;
	Wed, 04 Nov 2026 01:59:11 +0000
Date: Wed, 4 Nov 2026 09:58:44 +0800
From: kernel test robot <lkp@intel.com>
To: Sanjay Govind <sanjay.govind9@gmail.com>, jikos@kernel.org,
	bentiss@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-input@vger.kernel.org,
	dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org,
	Sanjay Govind <sanjay.govind9@gmail.com>
Subject: Re: [PATCH v2] HID: santroller: add driver for Santroller controllers
Message-ID: <202611040935.jsGsCh4a-lkp@intel.com>
References: <20261103015335.974344-1-sanjay.govind9@gmail.com>
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
In-Reply-To: <20261103015335.974344-1-sanjay.govind9@gmail.com>

Hi Sanjay,

kernel test robot noticed the following build errors:

[auto build test ERROR on hid/for-next]
[also build test ERROR on linus/master next-20261030]
[cannot apply to v7.3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sanjay-Govind/HID-santroller-add-driver-for-Santroller-controllers/20261103-145335
base:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-next
patch link:    https://lore.kernel.org/r/20261103015335.974344-1-sanjay.govind9%40gmail.com
patch subject: [PATCH v2] HID: santroller: add driver for Santroller controllers
config: xtensa-randconfig-1001-20261104 (https://download.01.org/0day-ci/archive/20261104/202611040935.jsGsCh4a-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 13.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261104/202611040935.jsGsCh4a-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611040935.jsGsCh4a-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

   WARNING: modpost: vmlinux: section mismatch in reference: trace_initcall_level+0x60 (section: .text.unlikely) -> initcall_level_names (section: .init.data)
   WARNING: modpost: vmlinux: section mismatch in reference: trace_define_generic_fields+0x38c (section: .text.unlikely) -> initcall_level_names (section: .init.data)
>> ERROR: modpost: drivers/hid/hid-santroller.ko: symbol 'hid_is_usb' undefined!

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for PM_GENERIC_DOMAINS_OF
   Depends on [n]: PM_GENERIC_DOMAINS [=y] && OF [=n]
   Selected by [m]:
   - COMMON_CLK_MT8173_MFGTOP [=m] && COMMON_CLK [=y] && (ARCH_MEDIATEK || COMPILE_TEST [=y]) && COMMON_CLK_MT8173 [=m] && PM [=y]

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

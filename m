Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793773961;
	b=e3qW8VXO9JFmCt0jelM9lzO6DzFjJ/1CUf3Pa5VjEKxEYZwVxOUZDa+YzEYBX9LlL54+
	 /m2sX5JMOEz/UNPva2nrMdrHWfKZOLomMzaUU2035zIYd6elE9DHsqmFx86FFO5lc1kFU
	 ZfGzvnWClhannyOHHltvuw1AKSsM18hZVr9qNSFoQg/93Cu40Dzp2sDAYfd7S7pEGD2Ux
	 iksHx+knMjYP2ZXH0WqEYb74giD97IcKaszOhm6GtZBguCEIj5j5R1A9rGYAgq3PT34UL
	 T4fxOGhGpKSPOn0HE4JGcrtJzdHGxGNiM7ceHHSYNVGB0EdwnHe1hSpDslRM2Py6MgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793773961;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=FKYnkzUp7dcaKwPjAS6Kzcom3HkwZDiuBk/RNxQ8hl8=;
	b=ishsjfQiuZgvTTaY8rmcfRUYxiHirzXZEsKPbxXYIrP3qtjg+2ADtUESF90b66PluhM4
	 gGp6KvklybL2Nri59vIRWBtUuX1t1RrbiWLd6ManGXjbEp8LFvfMvx/avJUERKqRF3Qqi
	 DSflGmXFVviW4BXY7TAo+g+VC31M2UlJJvp3o+CCN2VSRyUAxRpVNqz6n0D/gphS3uQLv
	 ygFX8sBRUFariVj13bXzUTiCDJhb+qua7yDcBDVmP9IVIKE+FiV0PnFrwbegXSi37LHl5
	 xS0ovNge2Z+OEtxfoEAW6eCCN2vtiavvCO8jjvjDjiX5fjzINrfEtRhBT/o4nqWzRmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="GSppx/29";
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941E0606A326;
	Wed,  4 Nov 2026 06:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 941E0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GSppx/29
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793773960; x=1825309960;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6sHvxvkTPJCc29XYwbaFpovcVxjYO/xDqLAB4UQVgRw=;
  b=GSppx/29BTpLIueKK4EnIsSVeyDVh00/aHzVZO4yyBEuqEyqALTZVYsR
   uRCSbWnCI3rM6xY+DSwXG9if3BbYQ7BlMHuolkzF9g0izZw7MWx9qIz0g
   hvEB5+4l6rKuUZxZH0h6NIGNwaNgPYTzOED0LfKzF8jM648i4GzjGNq62
   QN4tCKPUx/P3EZTYgsfOGE0AIer1h/wxvxvjmZ5f9nGb/aXm8qiiY0Ur/
   6pfyvErZrc7JfHrbF/YvZVj7G3IACDk1mvySgHiPMZz0n7wDEwnS/HYpD
   G+bKK28o/j2vNFuiNp4z+mEBDDOLXsLVFAcvz40C1JgE6MI7e0V5n3Hao
   g==;
X-CSE-ConnectionGUID: +i1hbFZYSkawm4c1J78DuQ==
X-CSE-MsgGUID: Bn1GLRX7QEeMcDEdDzKjPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2535246"
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="2535246"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 22:32:40 -0800
X-CSE-ConnectionGUID: tZmulct4RrC+i109NuwCIA==
X-CSE-MsgGUID: cn87MhLnRvCLEr+lGQUrCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="6539746"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 03 Nov 2026 22:32:38 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xOUXz-00000000jsV-1DcR;
	Wed, 04 Nov 2026 06:32:35 +0000
Date: Wed, 4 Nov 2026 14:32:26 +0800
From: kernel test robot <lkp@intel.com>
To: Sanjay Govind <sanjay.govind9@gmail.com>, jikos@kernel.org,
	bentiss@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-input@vger.kernel.org,
	dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org,
	Sanjay Govind <sanjay.govind9@gmail.com>
Subject: Re: [PATCH v2] HID: santroller: add driver for Santroller controllers
Message-ID: <202611041409.Y0jPIir1-lkp@intel.com>
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
config: sparc64-randconfig-1000-20261104 (https://download.01.org/0day-ci/archive/20261104/202611041409.Y0jPIir1-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261104/202611041409.Y0jPIir1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611041409.Y0jPIir1-lkp@intel.com/

All errors (new ones prefixed by >>):

   sparc64-linux-ld: drivers/hid/hid-santroller.o: in function `santroller_probe.part.3':
>> hid-santroller.c:(.text+0x610): undefined reference to `hid_is_usb'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

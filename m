Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9764A5EB7;
	Wed, 14 Oct 2026 22:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792017309; cv=none; b=qV/ejrM0ZQKJ4ZTr5fBNo2IyrrnJiWYGYD54EG7AXnXl55nQho1El86M+8PwKi/N+KkztI8CR1r+OMcS6dPoE8xZQzPQPZCNevcl6kBXMsk+uWip7ojwtTjILZ1dBRlsTlcui1qUE7c3euLX3mgtVmYT30LxNbaWEykcK65Xqs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792017309; c=relaxed/simple;
	bh=AmDME+Tz+w9UcXrraGYGQuY678RxPXZRS4l65fAAWE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AAdbi3QiMxY2Dwo+CtdiSNLQNF6botrRDM/Ve6kEyI3Qw8HNKmxgxYTMIQ75FEbG/pnXiI3r2oeMSsDqCDttGAeYE1YzMSQXD2nqe1JdWT+zIrVDczx7CwfhcME8ATBpHi43sH4ywBzvDtrroE5wmUhgtpvAaFHeojTZYG0EzsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WqQWwC29; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WqQWwC29"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792017307; x=1823553307;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AmDME+Tz+w9UcXrraGYGQuY678RxPXZRS4l65fAAWE4=;
  b=WqQWwC29a0eycMorQZ5sdJlvUtFok/tl0tVp6mUaNv0G1eRmUynVlDgt
   c325wffqCzpUsvDZEf2+IHsQk4M39iIkB4cHRIQSnCAqWMWYA3gE6VkHp
   mr/k+CuTdF+Jep0ljDvqmoDnN7Nl6qIKLv+GOeXwF0ph6r76prMgF3LKq
   T/9M0ziwxJ7Hu3IISkF5J3WvjbH84+MvvWE2Hv0Ca6m3irL2rmEVusiW5
   xcZfwT+C4E1kwAdYhXlQ5BwEeSUJSjXnjsWgDyG38ABQlXh2TdIzQjoOz
   wnONp35urJwqSHnKuURR/i63eob97EriGlaceMWiKhjNrrL+NWE3Hafe8
   w==;
X-CSE-ConnectionGUID: gZ5HcQ3oTkeBIFi5LFdHFw==
X-CSE-MsgGUID: r3vQQzGCT6Gv0zFNHcgZaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="659032"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="659032"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 15:35:06 -0700
X-CSE-ConnectionGUID: DOunOLk8RbaLId/zN2tjMw==
X-CSE-MsgGUID: +xMdiST+S3SP7XR59Me36g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1453123"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 14 Oct 2026 15:35:03 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xH7Yp-00000000FGw-34Xe;
	Wed, 14 Oct 2026 22:34:59 +0000
Date: Thu, 15 Oct 2026 06:34:39 +0800
From: kernel test robot <lkp@intel.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Ion Agorria <ion@agorria.com>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	Florian Krischer <florian.krischer@fkr.dev>
Cc: oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	mfd@lists.linux.dev, linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v11 2/7] mfd: Add driver for ASUS Transformer embedded
 controller
Message-ID: <202610150612.syb967F8-lkp@intel.com>
References: <20261013173504.451391-3-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013173504.451391-3-clamor95@gmail.com>

Hi Svyatoslav,

kernel test robot noticed the following build warnings:

[auto build test WARNING on dtor-input/next]
[also build test WARNING on dtor-input/for-linus sre-power-supply/for-next robh/for-next linus/master v7.3-rc7 next-20261012]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Svyatoslav-Ryhel/dt-bindings-embedded-controller-document-ASUS-Transformer-EC/20261013-203457
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
patch link:    https://lore.kernel.org/r/20261013173504.451391-3-clamor95%40gmail.com
patch subject: [PATCH v11 2/7] mfd: Add driver for ASUS Transformer embedded controller
config: csky-randconfig-1001-20261015 (https://download.01.org/0day-ci/archive/20261015/202610150612.syb967F8-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261015/202610150612.syb967F8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610150612.syb967F8-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/mfd/asus-transformer-ec.c:59 struct member 'fmode' not described in 'asus_ec_chip_info'
   Warning: drivers/mfd/asus-transformer-ec.c:59 Excess struct member 'mode' description in 'asus_ec_chip_info'
>> Warning: drivers/mfd/asus-transformer-ec.c:79 Excess struct member 'logging_disabled' description in 'asus_ec_data'
>> Warning: drivers/mfd/asus-transformer-ec.c:59 struct member 'fmode' not described in 'asus_ec_chip_info'
   Warning: drivers/mfd/asus-transformer-ec.c:59 Excess struct member 'mode' description in 'asus_ec_chip_info'
>> Warning: drivers/mfd/asus-transformer-ec.c:79 Excess struct member 'logging_disabled' description in 'asus_ec_data'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

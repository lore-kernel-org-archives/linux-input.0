Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EB83002A0;
	Tue,  3 Feb 2026 23:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770160682; cv=none; b=nHnPzZOb+DJ3xVTHGqkVT/qIagmZaC8jRen0PQ/TNaESx9ZPd0E22zO99Naq8kviPBUGZ2DHNhMpUCDHIZoJBblGRazMfrKHiCh5+wQBvcwq0aO5hPTyFgzY6CPiS24qp5iHh8pv525J/liiH342gTXFK5P5mFvmBznZmBfpc40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770160682; c=relaxed/simple;
	bh=EZdlmMuWubpZ64KCJhFpuoZeVdTV3W5B6LfNQyiAMMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mYzQTVAAQ9bH/CLcFGQpFLd7g2gcBwrvPV5rebJW0Wc/03fjDMHnT10GIy6WzFO/TJxroXpF5y2MFbPIWYnSacj0kbKaZ/ZAgL1jrLHw4nlmiVPs1eVkNAtu5XvsEke7cgF507Su9d7dKoWi9bW1J2vrPEQ6l0VDKCQAuxbgtGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mmKkVelQ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mmKkVelQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770160680; x=1801696680;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EZdlmMuWubpZ64KCJhFpuoZeVdTV3W5B6LfNQyiAMMw=;
  b=mmKkVelQfJgca0bE3OkgJlhc01vN3nxsZJAYKT4lJGOalJYrcqB6Lnnu
   7spUMagRNXBCdXpH/msvC/qzSEj+nO6eDFkUZAz3uicjRqh0MtYg2QSlY
   xBpFBA2H+gB8vo/HOlER6Df2yGAs6JuFcYAsFL2mkCxetc0q5+MUdmNto
   aOlJK0cbigYdVv3Ae9j+W2N8DaCJ1ergOfYT0URNWSzHnpletRC3YHjFr
   0us2UoBet45r8S4SIbDItRNGHs1cJ2sjsQ3x//QO+L4mF0GG0iIcY5w5I
   tWt1ZyRakWGVFf/Bihp41j/dLKyW/M8fZ+WOKH6bjpnnlAZjgs5an+pT9
   g==;
X-CSE-ConnectionGUID: 5NLOROeIQeeehEErRwrxrw==
X-CSE-MsgGUID: K9B+hyvGSBCK4+wRwltT6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="74963116"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="74963116"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 15:17:59 -0800
X-CSE-ConnectionGUID: 2IkFBlUsTcS6R4HXxNf7Cg==
X-CSE-MsgGUID: 5EuLEejTTJyLpfjkyQPWVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="214716393"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 03 Feb 2026 15:17:57 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vnPec-00000000hHo-3x4c;
	Tue, 03 Feb 2026 23:17:54 +0000
Date: Wed, 4 Feb 2026 07:17:08 +0800
From: kernel test robot <lkp@intel.com>
To: Hugo Villeneuve <hugo@hugovil.com>, hvilleneuve@dimonoff.com,
	dmitry.torokhov@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	hugo@hugovil.com
Subject: Re: [PATCH 2/2] Input: charlieplex_keypad: add GPIO charlieplex
 keypad
Message-ID: <202602040703.1Bu56Htu-lkp@intel.com>
References: <20260203155023.536103-3-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203155023.536103-3-hugo@hugovil.com>

Hi Hugo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on ed8a4ef29da3821ee3155d3b1925fa67fc92aae2]

url:    https://github.com/intel-lab-lkp/linux/commits/Hugo-Villeneuve/dt-bindings-input-add-GPIO-charlieplex-keypad/20260204-001338
base:   ed8a4ef29da3821ee3155d3b1925fa67fc92aae2
patch link:    https://lore.kernel.org/r/20260203155023.536103-3-hugo%40hugovil.com
patch subject: [PATCH 2/2] Input: charlieplex_keypad: add GPIO charlieplex keypad
config: parisc-randconfig-r072-20260204 (https://download.01.org/0day-ci/archive/20260204/202602040703.1Bu56Htu-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 8.5.0
smatch version: v0.5.0-8994-gd50c5a4c
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260204/202602040703.1Bu56Htu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602040703.1Bu56Htu-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/input/keyboard/charlieplex_keypad.c: In function 'charlieplex_keypad_init_gpio':
>> drivers/input/keyboard/charlieplex_keypad.c:120:6: warning: variable 'nkeys' set but not used [-Wunused-but-set-variable]
     int nkeys;
         ^~~~~


vim +/nkeys +120 drivers/input/keyboard/charlieplex_keypad.c

   115	
   116	static int charlieplex_keypad_init_gpio(struct platform_device *pdev,
   117						struct charlieplex_keypad *keypad)
   118	{
   119		bool active_low;
 > 120		int nkeys;
   121		int i;
   122	
   123		keypad->line_gpios = devm_gpiod_get_array(&pdev->dev, "line", GPIOD_IN);
   124		if (IS_ERR(keypad->line_gpios))
   125			return PTR_ERR(keypad->line_gpios);
   126	
   127		keypad->nlines = keypad->line_gpios->ndescs;
   128	
   129		if (keypad->nlines > MATRIX_MAX_ROWS)
   130			return -EINVAL;
   131	
   132		nkeys = (keypad->nlines * keypad->nlines) - keypad->nlines;
   133	
   134		active_low = device_property_read_bool(&pdev->dev, "gpio-activelow");
   135	
   136		for (i = 0; i < keypad->nlines; i++) {
   137			gpiod_set_consumer_name(keypad->line_gpios->desc[i], "charlieplex_kbd_line");
   138	
   139			if (active_low ^ gpiod_is_active_low(keypad->line_gpios->desc[i]))
   140				gpiod_toggle_active_low(keypad->line_gpios->desc[i]);
   141		}
   142	
   143		return 0;
   144	}
   145	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

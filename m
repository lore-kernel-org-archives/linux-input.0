Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FB247ECEB;
	Tue, 21 Jul 2026 09:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784627657; cv=none; b=J6Ge0FNKxsbw6SKUZOiJWCZwj4yLTogQSz03VFE0dL1j9l7X85pDmoTGwMJxpX3wllfgEmfXgEDFas+PKr+vm50TKdwQknc42agDqHgdQkD1Xo9dlg4/71jYQcyP7xx2GnCh2R+uB+EBWdLuP+KO/6WLOexOTAROzpmdwP6ZtZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784627657; c=relaxed/simple;
	bh=kRHPnnFh2X+21LPOizKSZmusrUu78ngN/jBigWFpw5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dv23YG3RTX1Un0u9U+j9HuM2VaYzNqQNhCycOkJfK63njS/zmA5MGuiC01f1UILHSEFj00AdBlTwQjapF4980xSWrgbOhrYQ88SYhmVwHkf40MBuSLplfhrS7r9mjWf8l3AAjwPRvdNJULYBX71PeUC7ccZmGhgEgIHaiG3cldk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CVIo9YZN; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CVIo9YZN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784627656; x=1816163656;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kRHPnnFh2X+21LPOizKSZmusrUu78ngN/jBigWFpw5M=;
  b=CVIo9YZNKjYo8eblhx8aUjXkyfpNf0JJ3s3/a+T9uAmiezgjIb5Quu/P
   42hY0NAdtXp+B7kGfGZQC+Y5bYeUv2yuCkhaoHEt5Hci47OX+TL78c3oA
   OaurXC6jDPDlakCXQ7Ljp3soit60n05cnX0K7efihkUlK9kiH1t7x3R66
   +bzmAfnASDY34hXMR382VadgPefYrbCnPLbdFjryKoTExaoDOAlu5aXeq
   eGeev4F9bNCnTYA5R9Cl1+hSui2KzcOfnG7zm/7q7bxL9pV6M4fD+I5Ns
   DVkxGivtAk6B5Ns0fePnu5hL6UrTE7CfWMUemZJUo5uBvKbgyQdjlCSMy
   A==;
X-CSE-ConnectionGUID: O4o8yiT1Q/ibyw36BrfeYQ==
X-CSE-MsgGUID: EPon5moNSymht6R1ws76cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="95873436"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="95873436"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 02:54:14 -0700
X-CSE-ConnectionGUID: r9OCG1FcRO6fqxsy8OJs+A==
X-CSE-MsgGUID: H9avTQT6S+at69QN4ALNdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="295924390"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.67])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 02:54:10 -0700
Date: Tue, 21 Jul 2026 12:54:08 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	chrome-platform@lists.linux.dev, linux-input@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/9] regulator: core: Add "enable and wait" functions
Message-ID: <al9BwHbG5IX0mIem@ashevche-desk.local>
References: <20260721075226.2347933-1-wenst@chromium.org>
 <20260721075226.2347933-2-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721075226.2347933-2-wenst@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 21, 2026 at 03:52:15PM +0800, Chen-Yu Tsai wrote:
> In device power sequencing and initialization use cases, it is common
> for the driver to enable the regulator and then wait for a certain
> period of time to pass before continuing.
> 
> In cases where the regulator supply is always on, or has been turned on
> or left on by another consumer, the driver could shorten the delay or
> skip it altogether, provided that enough time has already passed since
> the regulator was _actually_ turned on.
> 
> Tracking this requires support from the regulator core. Introduce a
> "last turned on" timestamp field to the regulator device, and "enable
> and wait" functions to the single and bulk regulator consumer APIs.
> The existing "enable without wait" functions are then converted to
> macros that expand to the new functions.
> 
> One case in particular is not optimized yet: a regulator left on either
> by hardware reset default or by the bootloader, but does not have the
> "regulator-boot-on" property set. As the enable timestamp only gets
> updated when enabled by a consumer or by the core, the first enablement
> always needs to wait.

...

> -/* locks held by regulator_enable() */
> -static int _regulator_enable(struct regulator *regulator)
> +/* locks held by regulator_enable_and_wait() */
> +static int _regulator_enable_and_wait(struct regulator *regulator, unsigned int wait_us)

Hmm...
This comment a bit confusing, perhaps adding some lockdep annotations help?

...

> +	if (wait_us) {
> +		ktime_t end = ktime_add_us(rdev->last_on, wait_us);
> +		s64 remaining = ktime_us_delta(end, ktime_get_boottime());
> +
> +		if (remaining > 0)
> +			fsleep(remaining);

This style is discouraged as it makes maintenance harder. Better

		s64 remaining;

		remaining = ktime_us_delta(end, ktime_get_boottime());
		if (remaining > 0)
			fsleep(remaining);

> +	}

...

>  	/* private: Internal use */
>  	int ret;
> +	unsigned int wait_us;

If you want to make it more private (the above is only for kernel-doc) add
__private annotation that will affect how sparse will check this.

...

> -int __must_check regulator_enable(struct regulator *regulator);
> +int __must_check regulator_enable_and_wait(struct regulator *regulator, unsigned int ms);

ms or us? Please, double check all units.

-- 
With Best Regards,
Andy Shevchenko



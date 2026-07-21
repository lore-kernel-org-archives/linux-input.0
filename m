Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF2E480DE3;
	Tue, 21 Jul 2026 10:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784629650; cv=none; b=iTIX1XIBJv02Aih57PRWP+ZTp+aXtvrssZNw287DECoqxWFEbD2nHalRZqmKn0JPumeMG9F7cQ3gyh/fLZF6B4CRJn6xZhRuJ385Ib//IajpJEeiBO7kWp3q4PQf/V4bfmCdcSMRp7se8vPIa17m2KcuT2sFWfwQZnXd0RuuTi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784629650; c=relaxed/simple;
	bh=VVGwOlrUZrGKadwD0Qw7A0i/OVcEhvAYchvF53YubSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=quE1vl6TFyPwtHkoN4PC+8fh5Se+kr5oRs+Q/B2Sesl+D0Griij9al66CwiZEzkzMAcuDKNeFUC76LYQ/nXcSN/z4SJg99+fAeO43pkiI2x99osBIiFipDDDaBUJ0VFSrT9mOONqv835mXYzPuh4eTinjQwI1kQJnr7X3nhydSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UsvekSUG; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UsvekSUG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784629649; x=1816165649;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VVGwOlrUZrGKadwD0Qw7A0i/OVcEhvAYchvF53YubSg=;
  b=UsvekSUGK0VLP1kh/kStVJLJudwWqkem1bd7msGInDhFhywswZwp62AX
   L5Un2stmYZMSg9aC2JK+3DxV3GV2rpFGFhHb994b7TzltuDx8qa0JtUMU
   yFi0jWoNL9XEF8MLR9YUPAoU9eKfcodrvBMpNaX+T4d5RlhpdnJ5nUAUI
   00cYQnlGbv/X8Xa9ndmVKoWEolFGIKUsUkZe/j04hILE8TEokCn/1CF3X
   KU3H3d3UaLTNbmbXAz1ayYgvsroMzq4Wh6ejPwD+ZndLxmefyzVb8bORI
   wp5R2TgQB7pZA+E2NtLNzeuM0n00x79tb0xlbtOOrZVGeh+szqrMyhXz1
   Q==;
X-CSE-ConnectionGUID: 2TQpfkH/TiG6nNBGBk7Qsw==
X-CSE-MsgGUID: 0ZNily/1QLWlfkWGneYiKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="85343354"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="85343354"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 03:27:28 -0700
X-CSE-ConnectionGUID: zBUxcsmiSl2TbYJ5Uzr3BQ==
X-CSE-MsgGUID: 2DXv5ovhSkio4WPrhKWEoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="251400447"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.67])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 03:27:25 -0700
Date: Tue, 21 Jul 2026 13:27:22 +0300
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
Subject: Re: [PATCH v3 7/9] platform/chrome: of_hw_prober: Add delay for hana
 trackpads
Message-ID: <al9JivV0SZCiOgK8@ashevche-desk.local>
References: <20260721075226.2347933-1-wenst@chromium.org>
 <20260721075226.2347933-8-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721075226.2347933-8-wenst@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 21, 2026 at 03:52:21PM +0800, Chen-Yu Tsai wrote:
> Up until now, the MT8173 elm/hana device tree has set the dedicated
> regulator supplying the trackpad as always-on, simply because the Elan
> driver was missing proper delays. As a result the delay for the
> Synaptics trackpad was also omitted, as it was not strictly required
> under such a model and delayed the availability of the trackpad to the
> user.
> 
> The Elan driver recently gained proper delays after power-up, with
> adaptive skipping of the delay if the regulator was originally
> on. The I2C HID driver and I2C OF component prober library gained
> similar adaptive delay skipping. The device tree will be fixed to have
> the regulator not be always on, and proper post-power-on delay time
> added to the I2C HID device.
> 
> Also add the post-power-on delay to the ChromeOS OF component prober,
> so that if the regulator is off at the time of probing, the prober knows
> to wait for the hardware to initialize.

...

> +++ b/drivers/platform/chrome/chromeos_of_hw_prober.c

>  		/*
>  		 * ELAN trackpad needs 2 ms for H/W init and 100 ms for F/W init.
>  		 * Synaptics trackpad needs 100 ms.
> -		 * However, the regulator is set to "always-on", presumably to
> -		 * avoid this delay. The ELAN driver is also missing delays.
>  		 */
> -		.post_power_on_delay_ms = 0,
> +		.post_power_on_delay_ms = 110,

This and the other delay in the previous patches are all HW-related. What if
another touchpad gets connected? I mean that the delays for the certain HW
should not affect other possible devices connected to the platform.

-- 
With Best Regards,
Andy Shevchenko



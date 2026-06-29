Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545383E92BD;
	Mon, 29 Jun 2026 15:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782745804; cv=none; b=OY0qM397LWZo1GLv21w++jjnMeFVRfrRs8m1rsdjOGpIBLFJIq5YqH4hKQw1RKpgsDqfyKksqcahs0jHGlUiR156MKyZOdahWEQAtxRmXoRPWtqtxoUb5iZawNMN4NiFQOjbs6RXZ8dqoSTHb3YAO1w8qEqJ70hDWHW5zShGJ6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782745804; c=relaxed/simple;
	bh=KPvDGPjMqG4x73TK2zJPV7GSwKG2WIpcWNT33r6AJIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QtG1HdE+GYo9Tmr6KDzX7IFVJ63u99Xk3Khsr5KW3GCRQ4VrJ/+m2v3db5TsFfXxDNcpzwgLmMhVpPxTYP2KCcYbXBPa/0F89qT7GTkg+GK6khRpEH5hI9vYhhpC0J/go9uF6PrULVew0Vtd2o+VsF+7txYMtu5+4PeLIOQ/H/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X8MtNOMV; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X8MtNOMV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782745804; x=1814281804;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KPvDGPjMqG4x73TK2zJPV7GSwKG2WIpcWNT33r6AJIo=;
  b=X8MtNOMVqqrgbmuJ/e8Uwm60puEgWjdSUUdteXbIBWQrq/+CiXR2ToRX
   PE9HCl+jlpanhkYk4SUC4YGHzXLwGU/MBsLL2XSKX8iEnScCwdl9SNaMa
   nx9R2/4G5S+NnArrw1/StR4ErkrX8vyrqqC/PUxsAV0CjIPwWllOB55Bm
   8EQIIetY5tkzWKGnjhVLNW7s4Y316GeEh1j6gFwaMF7PJb2IwdQIDvkWE
   vlUwpKEb2HGPKAp9zBzfLmu6QV4X61d1n/q2JBEmO1STQMqhS41KZsIZU
   qCYCTa3S5JxDf/JI2mqgUlgHcbrOMstQJgACsitLzpL+ifwJLtxpW1eRu
   Q==;
X-CSE-ConnectionGUID: 7Kl0kvw/R2uPTgChT3T8cg==
X-CSE-MsgGUID: MlLLlKBxRpmT+oD8Wbl+2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="93789514"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="93789514"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 08:10:03 -0700
X-CSE-ConnectionGUID: /xknQc/XQ/O5QOYBgCiPfA==
X-CSE-MsgGUID: hSUYX2pDSkK656ZDkQ8Bng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="290105338"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.207])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 08:09:58 -0700
Date: Mon, 29 Jun 2026 18:09:56 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-gpio@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH 5/6] [v5] leds: gpio: make legacy gpiolib interface
 optional
Message-ID: <akKKxHB6RMymG70Z@ashevche-desk.local>
References: <20260629130329.1291953-1-arnd@kernel.org>
 <20260629130329.1291953-6-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629130329.1291953-6-arnd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 29, 2026 at 03:03:28PM +0200, Arnd Bergmann wrote:

> There are still a handful of ancient mips/armv5/sh boards that use the
> gpio_led:gpio member to pass an old-style gpio number, but all modern
> users have been converted to gpio descriptors.
> 
> While the CONFIG_GPIOLIB_LEGACY option that guards devm_gpio_request_one()
> and related helpers is currently turned on in all kernel builds,
> the plan is to only enable it on the few platforms that actually
> pass gpio numbers in any platform_data.
> 
> Split out the legacy portion of the platform_data handling into a custom
> helper function that is guarded with in #ifdef block, to allow the
> the leds-gpio driver to compile cleanly when CONFIG_GPIOLIB_LEGACY
> gets turned off. Once the last user is converted, this function can
> be removed.

...

>  	gpiod = devm_gpiod_get_index_optional(dev, NULL, idx, GPIOD_OUT_LOW);
> -	if (IS_ERR(gpiod))
> -		return gpiod;

We can leave these and rather have

	gpiod_set_consumer_name(gpiod, template->name);
	return gpiod;

than introduce irregular pattern.

> -	if (gpiod) {
> +	if (!IS_ERR(gpiod))
>  		gpiod_set_consumer_name(gpiod, template->name);
> -		return gpiod;
> -	}
>  
> -	/*
> -	 * This is the legacy code path for platform code that
> -	 * still uses GPIO numbers. Ultimately we would like to get
> -	 * rid of this block completely.
> -	 */
> +	return gpiod;
> +}

I haven't insisted on this previously as I thought that this was on track to be
applied. Since it's not (yet), please, amend the change.

-- 
With Best Regards,
Andy Shevchenko



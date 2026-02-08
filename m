Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DAC21019E;
	Sun,  8 Feb 2026 12:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770555386; cv=none; b=VOy2jj8yIeYL3tKnDCIN7pGvOEE19y1rRO7I+aRQ7tFYC4HSK50+pGQOifbwLdw2kXi437o9VaOAsFKCvHP2KyoMp3JpfkiA6NCJPyJBUwcplg3Pb6U/AwP+wxBoHmkP2lfNpyEJjLKSr2s7VQ5UJBIFw+LyY4zEjyWa145RbVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770555386; c=relaxed/simple;
	bh=aLd9l6VkAyHVpK9L2eE7+aB1geV7OxU1mtgjLgYs4HY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E51TZChBiP0/Ux+iyd0pi8mE7PH4zcZEHkXf7Ai9OMb6TgnVGBPZGgl43BgrUZw1j9w95LB4mM2bCo5rNrx/IQD/x+RJcW31+TYQK1JpTEi2bZ+FoYQPpeXsV/lxu7GpfdQIk4juAyI/H3DJaYyHPbH7HGjAnQDrFssIoId6XzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GeFSN8GR; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GeFSN8GR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770555386; x=1802091386;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aLd9l6VkAyHVpK9L2eE7+aB1geV7OxU1mtgjLgYs4HY=;
  b=GeFSN8GRAPoWDR2EEnIkye52GiSf4EpT0MZfzPCFfMBEVYpifDHES8D7
   iJqY2zVAapxI0bMq6w0H+b9qL1TtonYpPP52v0D4sl/KR/Qo6ckaQNPH4
   SVZnHuRKRrF+3/Ew3Mm9UipZwndg2U80yDxeg+D6e1h6XTITaQ6bevT1A
   U9zPp+Du+qd8k1mE6xntPhu7kHx5A5LA5NOE+1WYWhKcstVnsvlByU8TI
   byDrIxQfjBIWbhhwEcEJ/tWQAFuVuM4uOo8walIrieb6qmqtmnCOPDSte
   6x/xXdGwiqaJgCmMoQYuDpPXVcjMGGumOdBTokM2VSSP6Noi3aRcxHVNn
   A==;
X-CSE-ConnectionGUID: ILNl/FpWR52ddHNfFTKcsQ==
X-CSE-MsgGUID: Hs9/6pt1TcWUqip1ZkiLkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11694"; a="75309658"
X-IronPort-AV: E=Sophos;i="6.21,280,1763452800"; 
   d="scan'208";a="75309658"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 04:56:26 -0800
X-CSE-ConnectionGUID: uPMNcQYeTTmopmfKNNfrig==
X-CSE-MsgGUID: ZNxNWNeOSzGBijUbvr8dLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,280,1763452800"; 
   d="scan'208";a="215511551"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.245.100])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 04:56:21 -0800
Date: Sun, 8 Feb 2026 14:56:18 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Dixit Parmar <dixitparmar19@gmail.com>,
	Tony Lindgren <tony@atomide.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v2 11/11] mfd: motorola-cpcap: add support for Mot CPCAP
 composition
Message-ID: <aYiH8iwetvRfWxGI@smile.fi.intel.com>
References: <20260206172845.145407-1-clamor95@gmail.com>
 <20260206172845.145407-12-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206172845.145407-12-clamor95@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 06, 2026 at 07:28:45PM +0200, Svyatoslav Ryhel wrote:
> Add a MFD subdevice composition used in Tegra20 based Mot board
> (Motorola Atrix 4G and Droid X2).

...

>  	{ .name = "cpcap", },
>  	{ .name = "6556002", },
>  	{ .name = "mapphone-cpcap", },
> +	{ .name = "mot-cpcap", },

Drop inner trailing comma.

>  	{},

Drop a comma at the terminator.

>  };
>  MODULE_DEVICE_TABLE(spi, cpcap_spi_ids);

This can be done in the patch that adds driver data.

-- 
With Best Regards,
Andy Shevchenko



Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8B7207A32;
	Sun,  8 Feb 2026 12:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770555301; cv=none; b=YjPs9txF8Lx8YgdRL9wO37REKLZXsFRU8EyiZUYI3kIBWySgZjWiyZojT37f+M6hpcp9sdJcsKQGgBhOhH2ayx7y+I2mlc2AinS6KpxaDdWmcU64M2jq86gzbjYv3S9eZ0VPzTut1ali2y77sxNoLDtXMDs9QNVI25vfmnfa1no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770555301; c=relaxed/simple;
	bh=AZx6c9CoMFID8DnP0rl6XsK8kOpriozdjmvOXiHwRKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dSXqslNuE7lwEVT3aCSq+0Svpb2NVLdlQ1Xg4Xc+97Emt9eUXVCyQH1O/wfoni3LHTgfqLIVekczgoy5O5UeTo2uVrASLIDrFhvaj5GDIpo+OQ4Xfu3eou8DzaK4Z/6Pn4bj8Fz4T23NK48pS8E+wy7asCbg0mkjW0/oVUbqwqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B+76nWCg; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B+76nWCg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770555302; x=1802091302;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AZx6c9CoMFID8DnP0rl6XsK8kOpriozdjmvOXiHwRKU=;
  b=B+76nWCgWrAkv0M3EwjUMaQxI8ttASk6yRX+e6dyUufEiTzbSgvrT7ay
   gUvgiJ7rRsh8+Ls0n1nf7b4hp/ENTELo33q9XHTT/iJ5TNat/e5RPO7VC
   bFu+yfziVVtX5/+6ZW0YhVIanhDE2adkUYFkqFAi009ItllLbJJiMqk6e
   OXwvusYt6r87lRdGqSpC9ji4CMpOo2yZyRS05X2wQdi7XOwn0uMjFBQd5
   d/wINEShwb6cCjE7oYEHpTCW6oJfpR0gGHHuZhy/KkKj9xj233Fh48zw6
   I15K4x1i6xYTiawO/sMVx1tL6sUC5oGgiYwa+XWmR5d4Fkc/drmbwv4xr
   A==;
X-CSE-ConnectionGUID: Hg29sWpYQnefaqNAnRNMOA==
X-CSE-MsgGUID: HST9Dgc2SMeFc65ltegGIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11694"; a="71592387"
X-IronPort-AV: E=Sophos;i="6.21,280,1763452800"; 
   d="scan'208";a="71592387"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 04:55:01 -0800
X-CSE-ConnectionGUID: 4MbOHrcZSQiwHI+rxB0+oQ==
X-CSE-MsgGUID: g1ZOGS5fSEOAMt/iI2BNzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,280,1763452800"; 
   d="scan'208";a="216314342"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.245.100])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 04:54:56 -0800
Date: Sun, 8 Feb 2026 14:54:53 +0200
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
Subject: Re: [PATCH v2 10/11] mfd: motorola-cpcap: diverge configuration
 per-board
Message-ID: <aYiHnUW93AB0ARJH@smile.fi.intel.com>
References: <20260206172845.145407-1-clamor95@gmail.com>
 <20260206172845.145407-11-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206172845.145407-11-clamor95@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 06, 2026 at 07:28:44PM +0200, Svyatoslav Ryhel wrote:
> MFD have rigid subdevice structure which does not allow flexible dynamic
> subdevice linking. Address this by diverging CPCAP subdevice composition
> to take into account board specific configuration.
> 
> Create a common default subdevice composition, rename existing subdevice
> composition into cpcap_mapphone_mfd_devices since it targets mainly
> Mapphone board.

...

> -static const struct of_device_id cpcap_of_match[] = {
> -	{ .compatible = "motorola,cpcap", },
> -	{ .compatible = "st,6556002", },
> -	{},
> -};
> -MODULE_DEVICE_TABLE(of, cpcap_of_match);
> -
>  static const struct spi_device_id cpcap_spi_ids[] = {
>  	{ .name = "cpcap", },
>  	{ .name = "6556002", },
> +	{ .name = "mapphone-cpcap", },
>  	{},
>  };

This  also needs to be converted to use driver data.

>  MODULE_DEVICE_TABLE(spi, cpcap_spi_ids);

-- 
With Best Regards,
Andy Shevchenko



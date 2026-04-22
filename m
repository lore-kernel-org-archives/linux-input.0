Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE56C347C6;
	Wed, 22 Apr 2026 09:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776849510; cv=none; b=Me57gNuEJ8JYpMaJwRSX91Pn6mLFIf8yhG3iosZgI2yeb2AE/mrKbp7iY0lAY7DfYL8vBSFpkZ451U8o1DZuHOzFGnkqYjSECdfaFL+kEytWul5suaSkeKNcKpldBoyP/iO+p3CGIC4r5oVC6GLZ7BTyY9+0i/nl96E7Ljv1+Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776849510; c=relaxed/simple;
	bh=m6iMIuOC6RQhsJW4Q9UP5JUJodsxvQzkeFVHR2/r5vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lreaDhHudRhMDk155cWP7O0wsmxB1vR4Qm+Ty3dqia6En/ThGOby3nH/0cacqrleJI9CIqG1KITuCvtBGgxPe0GGFBHW4+bqjyywSxLxsT/0wywiQinYPBDJ4iwfUMkRkTRNVvkawP56bKjDeBxFbyupcHaP1ETO9IVp5JjJScU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WSdGgPxk; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WSdGgPxk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776849509; x=1808385509;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=m6iMIuOC6RQhsJW4Q9UP5JUJodsxvQzkeFVHR2/r5vw=;
  b=WSdGgPxk3m+YPz64BAVHsvqEw2cypeNqxRttkB5yDhveeBncjrAxQ3Qb
   aBlcTRJkjEkjRKzqHafWtespOiAv/4Z2uMZqyj3itKgsXmZrPGUu3XKhm
   4faao/q4lcOafzzHmkj93VuW+cmMnXYNXXAprFpKVLJBlB6GC1uFyRJeU
   we94EZW2utUIsDhY6kyNkmr6snpS5Z75rmTGmI7ISkYsydMqLpPQIf3PI
   C+CmD1NAu0Q0uDIvMLGtym1mpfFv4WwQfyc3yhT8aUaFgWWhIsfDg96+D
   Vo0LLQNnQNCsUjdKrSqJK0ucRuOgXd4rEpp++uFyuxdtPAnumF+o3HLEE
   w==;
X-CSE-ConnectionGUID: afjXqxo9SYCIktBTzjCOkg==
X-CSE-MsgGUID: DmttWYB8RoinV74LnT6JRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="80384673"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="80384673"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 02:18:27 -0700
X-CSE-ConnectionGUID: 0/HVHcaeSTySbkGH6lFjEg==
X-CSE-MsgGUID: zVmCr7eyT5uwQ76g4vjs4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="232167193"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 02:18:24 -0700
Date: Wed, 22 Apr 2026 12:18:22 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: =?iso-8859-1?Q?Nat=E1lia_Salvino_Andr=E9?= <natalia.andre@ime.usp.br>
Cc: andy@kernel.org, bentiss@kernel.org, dlechner@baylibre.com,
	jic23@kernel.org, jikos@kernel.org, nuno.sa@analog.com,
	srinivas.pandruvada@linux.intel.com,
	Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>,
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v2 6/7] iio: magnetometer: HID: Replace method
 magn_3d_adjust_channel_bit_mask()
Message-ID: <aeiSXn4Un630xYA6@ashevche-desk.local>
References: <20260421222210.16016-1-natalia.andre@ime.usp.br>
 <20260421222210.16016-7-natalia.andre@ime.usp.br>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260421222210.16016-7-natalia.andre@ime.usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 21, 2026 at 07:20:38PM -0300, Natália Salvino André wrote:
> Replace method magn_3d_adjust_channel_bit_mask()
> with helper method hid_sensor_adjust_channel_bit_mask().

...

> -				magn_3d_adjust_channel_bit_mask(_channels,
> -								*chan_count,
> -								st->magn[i].size);
> +				hid_sensor_adjust_channel_bit_mask(_channels,
> +					*chan_count,
> +					st->magn[i].size);

Fix the indentation accordingly.

-- 
With Best Regards,
Andy Shevchenko



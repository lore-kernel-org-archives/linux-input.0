Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FAC2D9481;
	Mon, 27 Apr 2026 09:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777282760; cv=none; b=pyM91VGDEIkwjcBXDtw1oMkvcca1fjWfdXwTavsHVXx4CrUpKScGXywiOMtv8msdhScDkBPtf9bo+plWCI8XCCFaAICPgA5DtGUjoJq7XUL8LDjuv0PuI6RI2zBJesZNMUYuMLRcOdfpwxw8hqRGj63BT9V2kWxYruQkYjqZIcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777282760; c=relaxed/simple;
	bh=6kpUPLhPxHTplUFHgrnW1C/GxDnS+DF941vvv/DLYKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJEEK3LpStQvkec4+GVsX7hIbzmSBwHuuTzMWfUFQEeJbERd+ka/4uWtt+qrAfRWbcHaKdSCMkZTaLpX3QFndaUDdeH+gdyVVxtkYc6h23Feu1IDKnkcWW1r71UHqi6tFJ4464GpMJ2shM+mbzJDKwHNE+i5uTcrtN9SZM0JpHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IJ3cOiUs; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IJ3cOiUs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777282759; x=1808818759;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=6kpUPLhPxHTplUFHgrnW1C/GxDnS+DF941vvv/DLYKM=;
  b=IJ3cOiUs5DX8atGmjCfcYmhFpQwRQIZ5vUZ7UcKMYR1qqxilqlpD39p6
   7jab0z5FdOudvxkyql0DsSrTfNXBOHb+OunSr49u3+LqGls12N8BoMiV1
   iGJcrjUCumGsmxtEEbu+f9NfoAaCnLAANHoDTd+D6Lp/Q+mNZwPLB7f5r
   3UlsBpYYsmoyDYX6MHMOAdMRO3AbrlkbGFj7ZXr8e2qQO1NA9vrd2LcYE
   S4+Lf/xLB9bWW5S3TF8xjLpRCmRjJefnP+tzkcxqX6hWKKgjaZ+ni+tl/
   Coc3BhVX0YSYaCvKksHGgviZDJx9s+jfM7OhV20uSqREGweehC6tWaQfx
   A==;
X-CSE-ConnectionGUID: mvtA0aiFSPm7ZoZ41Pp69Q==
X-CSE-MsgGUID: F4NlXsfDQ/CiiBbzGwZc8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="89628854"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="89628854"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 02:39:19 -0700
X-CSE-ConnectionGUID: jEDkR2UZTu6t8JfCzUBmZw==
X-CSE-MsgGUID: UVzty5TzQnyPiS2xygmirw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="256897002"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 02:39:16 -0700
Date: Mon, 27 Apr 2026 12:39:14 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?iso-8859-1?Q?Nat=E1lia_Salvino_Andr=E9?= <natalia.andre@ime.usp.br>,
	andy@kernel.org, bentiss@kernel.org, dlechner@baylibre.com,
	jikos@kernel.org, nuno.sa@analog.com,
	srinivas.pandruvada@linux.intel.com,
	Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>,
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v2 1/7] iio: HID: Add helper method
 hid_sensor_adjust_channel_bit_mask()
Message-ID: <ae8uwmF6nQanmEux@ashevche-desk.local>
References: <20260421222210.16016-1-natalia.andre@ime.usp.br>
 <20260421222210.16016-2-natalia.andre@ime.usp.br>
 <aeiO0JRGW0oKdcON@ashevche-desk.local>
 <20260424200155.61b6f273@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260424200155.61b6f273@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Apr 24, 2026 at 08:01:55PM +0100, Jonathan Cameron wrote:
> On Wed, 22 Apr 2026 12:03:12 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Tue, Apr 21, 2026 at 07:20:33PM -0300, Natália Salvino André wrote:
> > > Add helper method to deduplicate code in HID sensors.  

...

> > > +	channels[channel].scan_type.realbits = size * BITS_PER_BYTE;  
> > 
> > BITS_TO_BYTES(size)
> 
> BYTES_TO_BITS(size)

Indeed.

-- 
With Best Regards,
Andy Shevchenko



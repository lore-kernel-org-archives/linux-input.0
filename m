Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240B2370D6F;
	Wed, 22 Apr 2026 09:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776848599; cv=none; b=eVTIel0ZXbnmqSiIDZgZLac4z5pRM8cHPfK0bgK3KUCNelevLLQbhFJpA/+X9n8b/zmHf2pXJEeviQ4EU30JNVLqDmC24mHvsamy4DvzstR1P8QiN2zsWak4lmBzzMHJvADLPQN+EFGhwED6KhmwLNBos1VjCsI4SwxBKoAmA98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776848599; c=relaxed/simple;
	bh=iN42LWWjRPpM1eNIj9mYDkEYDzCtGWVRxRn2+xST77I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwcszGa3roab9Dy02afyG46b8OfMXuGyf5NbE+a3xkEmm+jkfMPXiFY+XK09IwFWc0CZ6THe9xh21fzkOmJn1VYfm7aUm+gaUBrcF2DAOHIqY5N1tIFFEgP6kex1QzQ719YNhg8Fo3tYmmk4rd6XCunu6yHEBzdsQmqaZVrseSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=axhEQLnU; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="axhEQLnU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776848598; x=1808384598;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=iN42LWWjRPpM1eNIj9mYDkEYDzCtGWVRxRn2+xST77I=;
  b=axhEQLnUEGqwMfnRkyRiJKjiZ9FXmIy9ApiNPQXbQHmJuv17RifVRN61
   hS3SvmzQlQlUa/TPMKMBVKY7E+feuZuaGRyLt/J47kORn3g+JIatJF8dP
   ViNFW6xk2qf8f/sUigxffrSND5Eloalah1l9Rlk4vinVWHLkI+TGJkz23
   lNi7yCLTcPI0hLjqzirn8uNo1i14zd3kZxNTCFvYCnji5R9P8KFj6adz6
   ibjp8Fv/HpEG360Mea19AhH+IXTp8bEr+HnMEsMRSnr4vihqnWCLwPa8g
   nKyvCHJcaG2/hbkSXehzdgtyZQ28iVvokz0pVJaPLaQvsMFalYhjcqDrZ
   A==;
X-CSE-ConnectionGUID: TR61+TsFStaGVQtj2TeQcA==
X-CSE-MsgGUID: IoHczGgNT4SIQWvrDm8MeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="81662712"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="81662712"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 02:03:17 -0700
X-CSE-ConnectionGUID: 3t7RxIWuRr6CiP+/MgfP9g==
X-CSE-MsgGUID: YyhjOSdLTTiOd7VCW8nxJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="227715661"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 02:03:15 -0700
Date: Wed, 22 Apr 2026 12:03:12 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: =?iso-8859-1?Q?Nat=E1lia_Salvino_Andr=E9?= <natalia.andre@ime.usp.br>
Cc: andy@kernel.org, bentiss@kernel.org, dlechner@baylibre.com,
	jic23@kernel.org, jikos@kernel.org, nuno.sa@analog.com,
	srinivas.pandruvada@linux.intel.com,
	Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>,
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v2 1/7] iio: HID: Add helper method
 hid_sensor_adjust_channel_bit_mask()
Message-ID: <aeiO0JRGW0oKdcON@ashevche-desk.local>
References: <20260421222210.16016-1-natalia.andre@ime.usp.br>
 <20260421222210.16016-2-natalia.andre@ime.usp.br>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260421222210.16016-2-natalia.andre@ime.usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 21, 2026 at 07:20:33PM -0300, Natália Salvino André wrote:
> Add helper method to deduplicate code in HID sensors.

...

> +#include <linux/bits.h>

Will need bitops.h instead (see below why).

...

> +void hid_sensor_adjust_channel_bit_mask(struct iio_chan_spec *channels,
> +					int channel, int size)
> +{
> +	channels[channel].scan_type.format = 's';
> +	/* Real storage bits will change based on the report desc. */
> +	channels[channel].scan_type.realbits = size * BITS_PER_BYTE;

BITS_TO_BYTES(size)

> +	/* Maximum size of a sample to capture is u32 */
> +	channels[channel].scan_type.storagebits = sizeof(u32) * BITS_PER_BYTE;

BITS_PER_TYPE(u32)

> +}

-- 
With Best Regards,
Andy Shevchenko



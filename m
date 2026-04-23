Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9229F26ADC;
	Thu, 23 Apr 2026 07:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776930878; cv=none; b=KhYNWjA9rUp+9sbiL7V3DyBLr3CPePfIuSMkZoRj3swmXu/pf4vzKgFGGoAr+vhG3zHji2EbzsA9WELpnG8U6aXAT+5y1x5MG6s1i4BXVdDQ3DYNG2Xl5U/CYYoVS4YYGgs8LYTBNThTQyS4fm2CxJiU7N1btt2vo749hy/tEBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776930878; c=relaxed/simple;
	bh=XuZlJQJa0/9nvq1fexTS1sKbvIch201jw4T1tYmur6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWKOyS5bz/0d7fzlUR2qZyRHB5QSeTJSQeVbh4OPkmEgVUwBdI1A9DDoLU/yywOIoo0YAhT0oRyK9xZuwmve2btV5r6ZRBZgB/fxt3klEfEDOOzqhuH3O9L6+Eyh3SjvIuSfoq0TkjyKXj/r++Ad9hMa8IKSYQ0PtWzPL4oR43o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QbG/FV3O; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QbG/FV3O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776930877; x=1808466877;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=XuZlJQJa0/9nvq1fexTS1sKbvIch201jw4T1tYmur6A=;
  b=QbG/FV3ODr58P1YD7UdalSzZLWeyErHOgSBhUZMsVNKbiaVKNNhQKxqf
   WKhDeHjfHQZCyPkFeJOuFzsQ2vWGqkNSoKKSdE29tCuaKMKFpJluYd6Zn
   s/C8AwFM6mipc5Dbr/7NZBycpIB6sVZGjHBS0QebbP8l/JlEdrKTF8yKQ
   tAfYRnQMuUWiD7GBbcGXNU0wQyy3YIl6M/dE3CCrfjRnn7Amx1I8lcbNC
   smq7aBMU2crBvL6nv3S8ywKpfB8FjCytzGV+jN/0N1yIMSCpxUWcqzmln
   xflQM0YZeIN+MvUsYTg42xb+nSlrw3NMLJFWmZARw1HOWgjlNvtw0R0EW
   g==;
X-CSE-ConnectionGUID: EF4AWwHgSxOTL6JFsLUj9Q==
X-CSE-MsgGUID: F/83vqA0T/qFPfA//eIDOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="88974679"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="88974679"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 00:54:36 -0700
X-CSE-ConnectionGUID: flgbvjnwTSOb2dPTxuUSYw==
X-CSE-MsgGUID: pwUwnOVoRiKzMfEMyuiz2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="229405044"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.163])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 00:54:32 -0700
Date: Thu, 23 Apr 2026 10:54:30 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Zhang Lixu <lixu.zhang@intel.com>
Cc: natalia.andre@ime.usp.br, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, andy@kernel.org, bentiss@kernel.org,
	dlechner@baylibre.com, jic23@kernel.org, jikos@kernel.org,
	nuno.sa@analog.com, srinivas.pandruvada@linux.intel.com
Subject: Re: [PATCH v2 1/7] iio: HID: Add helper method
 hid_sensor_adjust_channel_bit_mask()
Message-ID: <aenQNrLHqGxbiipb@ashevche-desk.local>
References: <20260421222210.16016-1-natalia.andre@ime.usp.br>
 <20260421222210.16016-2-natalia.andre@ime.usp.br>
 <20260423032038.233475-1-lixu.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260423032038.233475-1-lixu.zhang@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Apr 23, 2026 at 11:20:38AM +0800, Zhang Lixu wrote:
> On Tue, Apr 21, 2026 at 07:20:33PM -0300, Natália Salvino André wrote:
> > Add helper method to deduplicate code in HID sensors.

...

> > +void hid_sensor_adjust_channel_bit_mask(struct iio_chan_spec *channels,
> > +					int channel, int size)
> > +{
> > +	channels[channel].scan_type.format = 's';
> 
> There is no 'format' field in struct iio_scan_type. This should be:
>         channels[channel].scan_type.sign = 's';

Your information is outdated, I believe.

> > +	/* Real storage bits will change based on the report desc. */
> > +	channels[channel].scan_type.realbits = size * BITS_PER_BYTE;
> > +	/* Maximum size of a sample to capture is u32 */
> > +	channels[channel].scan_type.storagebits = sizeof(u32) * BITS_PER_BYTE;
> > +}

With Best Regards,
Andy Shevchenko



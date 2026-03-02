Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CA52F12A5;
	Mon,  2 Mar 2026 08:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772441418; cv=none; b=oiMsUMzxqeg6Ch1v2r4RJtZv1c2QTw7ZyqXx6kqWdynLTQ+MuMdJNq5pD+7LnjyadCcwVvhSl80KEOIsQ1XyMd6c/bgmaH7q1zWlJvtNit9uwWPPBMvQpxdIJlwbQGjYktX2hmHsUTrdmJsNYVkVIS1fKMPT6J5qOqfj23M20Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772441418; c=relaxed/simple;
	bh=7vHGFD85v8qWRUsZb1wOJxlwGmT3jk/wEl5UfEp0x0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVGsDIBriB5UM0PVmqUMs1TTz3K6H0AFlnEDrRI4kARGzCi9Nt4Bbn/cmmydRfLUv8I/gcEEHsqyfN+bPYcV/nWqcsR9FOGD9Ml6TO20gZMJYebHK7FHDsljqFDiCFwj8h6jl+2FHbdUbUkgXTZEPvQsbR9fXnPMlog7J5sqB80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lx1EzEw7; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lx1EzEw7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772441416; x=1803977416;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7vHGFD85v8qWRUsZb1wOJxlwGmT3jk/wEl5UfEp0x0I=;
  b=lx1EzEw7GaHnwxbk7MmCyRVuj9R1Uz/BoVcvDpRFz5hhWF01FZvuNA37
   5an2TOuFksYuFWjXIRzdHhFodBtHjkJkJvjjguV7ghP2MDBy+US2j0a9C
   qBwwCLl3F7ZHg/BK7Cf8Qyqx1rC0reVtvgTzrsWCnnTD040qFEhrQM21z
   kvPJBWn7Qzk/6pn3FNZyKtEj5xJ+FNdyhYuKQJAK1y+qMtR/vXUtq1LpB
   sW6OJZxsiUek1Tf5HvTp9x+UR2p7Bqu8kPDzbsbqERbIfuB4aNBG1bWM4
   Ijicpdl5aD/tUg2qY6+cKAQKTx3HVSeydvSszhtONDezqmfHNTM1YLvwL
   Q==;
X-CSE-ConnectionGUID: 4zjlHtoNScW43YzaLKPGyg==
X-CSE-MsgGUID: nAcf2xdDSLaIWQuzB0Gd8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11716"; a="73482803"
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="73482803"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 00:50:16 -0800
X-CSE-ConnectionGUID: 8e66e6x8QC2GlTz6WA7Z0g==
X-CSE-MsgGUID: iTNzM50nRE+/VAd98VsdmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="248090459"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.52])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 00:50:12 -0800
Date: Mon, 2 Mar 2026 10:50:10 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars =?iso-8859-1?Q?M=F6llendorf?= <lars.moellendorf@plating.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Lixu Zhang <lixu.zhang@intel.com>, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] iio: orientation: hid-sensor-rotation: add timestamp
 hack to not break userspace
Message-ID: <aaVPQsvz02S8GtsX@ashevche-desk.local>
References: <20260301-iio-fix-timestamp-alignment-v1-0-1a54980bfb90@baylibre.com>
 <20260301-iio-fix-timestamp-alignment-v1-1-1a54980bfb90@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260301-iio-fix-timestamp-alignment-v1-1-1a54980bfb90@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Mar 01, 2026 at 02:24:50PM -0600, David Lechner wrote:
> Add a hack to push two timestamps in the hid-sensor-rotation scan data
> to avoid breaking userspace applications that depend on the timestamp
> being at the incorrect location in the scan data due to unintentional
> misalignment in older kernels.
> 
> When this driver was written, the timestamp was in the correct location
> because of the way iio_compute_scan_bytes() was implemented at the time.
> (Samples were 24 bytes each.) Then commit 883f61653069 ("iio: buffer:
> align the size of scan bytes to size of the largest element") changed
> the computed scan_bytes to be a different size (32 bytes), which caused
> iio_push_to_buffers_with_timestamp() to place the timestamp at an
> incorrect offset.
> 
> There have been long periods of time (6 years each) where the timestamp
> was in either location, so to not break either case, we open-code the
> timestamps to be pushed to both locations in the scan data.

...

> +		/*
> +		 * HACK: There are two copies of the same timestamp in case of

Usually we use FIXME in such cases. HACK is something which goes with
"do not apply".

Does it mean it will stay forever?

> +		 * userspace depending on broken alignment from older kernels.
> +		 */
> +		aligned_s64 timestamp[2];

...

> +		/*
> +		 * HACK: IIO previously had an incorrect implementation of

Ditto.

> +		 * iio_push_to_buffers_with_timestamp() that put the timestamp
> +		 * in the last 8 bytes of the buffer, which was incorrect
> +		 * according to the IIO ABI. To avoid breaking userspace that
> +		 * depended on this broken behavior, we put the timestamp in
> +		 * both the correct place and the old incorrect place.
> +		 */
> +		rot_state->scan.timestamp[0] = rot_state->timestamp;
> +		rot_state->scan.timestamp[1] = rot_state->timestamp;

-- 
With Best Regards,
Andy Shevchenko



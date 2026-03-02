Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316A2383C60;
	Mon,  2 Mar 2026 08:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772441271; cv=none; b=W409spky0ZAbpMQ4dQLgtq08kzitBloSxPSA6xDJRKFCSo4uKj8ubZC5GTnDTlWLZwpNlWX7Z28y0VJgOpRiK9RmOxp2tFEYdn5Jlp1pDltkhQ95bH58Z+3KXyMor2cAmjFnnnxraQO90GE7LIo9WBVW9hG9fzwBnz9oavkHHWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772441271; c=relaxed/simple;
	bh=Jf3wLN5x6FpYLcvL8ebXLG/Z9zjjUuKzeETlMv1PgtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hg8kocY329wNueMoA8uGSQlWeVsrvDAfB8RKtYPItfRRlJhsqPiEypXWTliFJZ29Dea9+0rAUj09c9QloSsPGZWBpDKyn1kX06SSgzNh5/GdZJ/RziDJBWsVl/I6RAupLqZ2vws+IM4WIDE7MzRNETd8AIKIq7P1HK+DpX+3170=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fzjlu4fC; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fzjlu4fC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772441269; x=1803977269;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Jf3wLN5x6FpYLcvL8ebXLG/Z9zjjUuKzeETlMv1PgtE=;
  b=Fzjlu4fChChwAYVeEjln5IfOjvH8ITb686y+hOyPoG3gMXtpfBOlTZn2
   nBIsjCJqF1GCIC2OGDlDzfXqUWaOe00xSHlvZminoRqSa+44HNz1y2kqJ
   VS3Y5ZvNuRO09FTwDfBc2oMRBAq1A5oDvnSEZfV9+N5n3wr6EQ7kmI0MM
   8b0cqP5mdE2GkxPpwOMZdUVizQ2AsMP17FIKxTnK+vWFHs6NLeX5XnyIR
   xqysl3OjGXzWnH7ulWg/Wn4aYcv5nQWPDlPRXhQytTtBAOvXoE76GYp2L
   GSnf0LX/rTMk7MrXYxBsCCjEs20uqAly53QKcASot+jErkBL1YeijlhVl
   w==;
X-CSE-ConnectionGUID: Sxx2HRecSumJRGeZHgXvuA==
X-CSE-MsgGUID: ldx5afvhT5eWUnlxPvO10Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11716"; a="73146615"
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="73146615"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 00:47:48 -0800
X-CSE-ConnectionGUID: boPvknlwRtuOKpVS+JFFHw==
X-CSE-MsgGUID: 0NyqdckzQt256EpdVGOZCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="215254314"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.52])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 00:47:45 -0800
Date: Mon, 2 Mar 2026 10:47:42 +0200
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
Subject: Re: [PATCH 4/4] iio: buffer: fix timestamp alignment when quaternion
 in scan
Message-ID: <aaVOrvyzgDKNsB0S@ashevche-desk.local>
References: <20260301-iio-fix-timestamp-alignment-v1-0-1a54980bfb90@baylibre.com>
 <20260301-iio-fix-timestamp-alignment-v1-4-1a54980bfb90@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260301-iio-fix-timestamp-alignment-v1-4-1a54980bfb90@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Mar 01, 2026 at 02:24:53PM -0600, David Lechner wrote:
> Fix timestamp alignment when a scan buffer contains an element larger
> than sizeof(int64_t). Currently s32 quaternions are the only such
> element, and the one driver that has this (hid-sensor-rotation) has a
> workaround in place already so this change does not affect it.
> 
> Previously, we assumed that the timestamp would always be 8-byte aligned
> relative to the end of the scan buffer, but in the case of a scan buffer
> a 16-byte quaternion vector, scan_bytes == 32, but the timestamp needs
> to be placed at offset 16, not 24.

...

> -		((int64_t *)data)[ts_offset] = timestamp;

> +		*(int64_t *)(data + ts_offset) = timestamp;

What's the point in modifying this? The comment you added suffice for
the original line.

-- 
With Best Regards,
Andy Shevchenko



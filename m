Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175D927F010;
	Mon,  2 Mar 2026 16:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772467429; cv=none; b=DG9UmsfrwV7y+jo8UpjKEyt7PlEqMizEdnobNkiVZEwoBlPvRr3fUPsHWOLQ+58wMfDHwoPLSQkxagrDu8GC74TIKVROfb5+Wh75biLJ0a/QZy/D6QARja/do6rRJtTq6RF81bE2PJLhpOUzHOI11Yjmesb7qz5BRRYBHRm/qtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772467429; c=relaxed/simple;
	bh=g+dVX/31950jcpgu+SWVjmm7iq/sZxRwVoWRFsxQJ3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7Dq6QxfioRgrVX4lhdfGCV+E+spXCNITFHVZ5qPHbD2Sq7o9zu+8bX/0J33tGioCxkpjE6pZRy/csgVjnV5Y1pLtLf9PsB3jq8K2B9U4JVmMj/5lu0Oe1FFWVNxykGwQCEM6fMAKtsD3jPlcI6Er2SAad9GdNUHIYCyl8Ov+Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OnUnLrct; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OnUnLrct"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772467418; x=1804003418;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g+dVX/31950jcpgu+SWVjmm7iq/sZxRwVoWRFsxQJ3c=;
  b=OnUnLrctSvKiykFOFHlA5frUNT3K2o9OmRb8oxZgYyoU2vNLLpxwIwMR
   FGhB/+GiJ167z5lrrnoVB1IYdt36UzJv/EJTnoiQyhzHCQluSsuz+rvwt
   8grO2NuEtkMkK28MLmD0oEcBWw1QlwHKoYlCXbWRHbwi6xQvR5ZeM9EtV
   Y+WSs78bhWwmk3CWAR07in9a7k0kgvUwhd32itps+aU4VIf+pY1KLFzBG
   Um/3rfr+YYdRdsBRLL/+JqLwwtXXGXVIyPnM6h7YaUomUPAzwh0OF02iG
   nVLmGWga5s0Ej5163moSDuK7x9otP5YbpzWrTUST9eYzg/VCEJ20XjNWV
   A==;
X-CSE-ConnectionGUID: hidtfME2TKqAwT8Xm7uYMg==
X-CSE-MsgGUID: 5AiDk+LSQeerd8UjvK+tcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="73517367"
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="73517367"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 08:03:36 -0800
X-CSE-ConnectionGUID: LT2nLDslQO66BjMoX8uRWw==
X-CSE-MsgGUID: HvIWA4p1RF6wgIaz9hqc6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="217707982"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.52])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 08:03:32 -0800
Date: Mon, 2 Mar 2026 18:03:29 +0200
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
Message-ID: <aaW00SLoHBNJ1wlt@ashevche-desk.local>
References: <20260301-iio-fix-timestamp-alignment-v1-0-1a54980bfb90@baylibre.com>
 <20260301-iio-fix-timestamp-alignment-v1-4-1a54980bfb90@baylibre.com>
 <aaVOrvyzgDKNsB0S@ashevche-desk.local>
 <d7809acc-01e8-4dd7-8c6a-a7e8386a9e6b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7809acc-01e8-4dd7-8c6a-a7e8386a9e6b@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 02, 2026 at 09:39:30AM -0600, David Lechner wrote:
> On 3/2/26 2:47 AM, Andy Shevchenko wrote:
> > On Sun, Mar 01, 2026 at 02:24:53PM -0600, David Lechner wrote:

...

> >> -		((int64_t *)data)[ts_offset] = timestamp;
> > 
> >> +		*(int64_t *)(data + ts_offset) = timestamp;
> > 
> > What's the point in modifying this? The comment you added suffice for
> > the original line.
> 
> ts_offset is now in bytes rather than number of int64_t elements.
> So ((int64_t *)data)[ts_offset] would now 8x past the end of the array.

So semantic of the variable changed w/o name changing... OK.



-- 
With Best Regards,
Andy Shevchenko



Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C09B385531;
	Mon,  2 Mar 2026 08:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772441895; cv=none; b=IJCuOe5i8ruvZU1P9RbzvCs1rbivh1sB5qLSJCBy6Zdjtmfv8XXp54BZ1ab/wuX4ehKYuA5SW6Hc72uRNnFYW05x/8p6PYxKmOhQImK9cwX0uq54I10ZZwqRK2HIiqGww2HHrbNL/w3Wi2uhcSuFcKKl+aDunm6k2Z6Q78GdfNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772441895; c=relaxed/simple;
	bh=ztVWdx7tymJoc2QG+MimBdurPRTD1aFQGz3ipOCUR0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1mJ8JwMlkd6NRmXyPVOtOW+oCD59CLtt6IOARH2CAND9vtxhKUe4Dpox/V4aLlWv7hU9cedvtJzmljaOKfBjYqANgkdgF4fTBPlToF1MG9CWZy1aWAALHdtp2fgoQlc2SUQ7blcDxzyNkJIxERPcW35n96FWnXocLNj9ZbXNQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iC6sZMf+; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iC6sZMf+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772441894; x=1803977894;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ztVWdx7tymJoc2QG+MimBdurPRTD1aFQGz3ipOCUR0w=;
  b=iC6sZMf+rWWu+RzeVuPgFEip4MOZUmS3uLpX8Qwrz3TD9MuV6jJirLET
   c6J85ufxiUYQzQ9Qihr6aTyzg0JraxzebrxZUJ5SFm7jk3B9mRBUEzU9k
   YhfhzU/7KKhqY3cPnjtvXgnvT8NMEpYZfFp18UQhUZucra5D7rmstZDnn
   R4W+m/xwINvcPdzL2qxfZ0K6famqZjAO5xoR5vHFX00D9yCTBf4EseG1n
   LAnfywyBmi9JLrnDVpl8hbEw9xPzJBJDXYJOITm6cTGY7C2Tdrhf5QOkc
   Lp85W7ued8wRPrBo+e5kZ7Y+0x3VOFRSObCm9dTExM1fiuH2MIjiL+PaF
   Q==;
X-CSE-ConnectionGUID: HiTqGQ2uQDOSVTvUID2rzA==
X-CSE-MsgGUID: ySUknEO+TVy6DLzSHwvfOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11716"; a="84147158"
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="84147158"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 00:58:14 -0800
X-CSE-ConnectionGUID: gCanRWyuRymOxwOjp9+x3Q==
X-CSE-MsgGUID: XzTY1uFLS5umA9ESNdMETw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="217492105"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.52])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 00:58:11 -0800
Date: Mon, 2 Mar 2026 10:58:08 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-input@vger.kernel.org, Lixu Zhang <lixu.zhang@intel.com>
Subject: Re: [PATCH v2 0/2] iio: orientation: hid-sensor-rotation: fix
 quaternion alignment
Message-ID: <aaVRIOejIgnOdAfY@ashevche-desk.local>
References: <20260228-iio-fix-repeat-alignment-v2-0-d58bfaa2920d@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228-iio-fix-repeat-alignment-v2-0-d58bfaa2920d@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Feb 28, 2026 at 02:02:21PM -0600, David Lechner wrote:
> The main point of this series is to fix a regression reported in
> hid-sensor-rotation where the alignment of the quaternion field in the
> data was inadvertently changed from 16 bytes to 8 bytes. This is an
> unusually case (one of only 2 in the kernel) where the .repeat field of
> struct iio_scan_type is used and we have such a requirement. (The other
> case uses u16 instead of u32, so it wasn't affected.)
> 
> To make the reason for the alignment more explicit to future readers,
> we introduce a new macro, IIO_DECLARE_QUATERNION(), to declare the
> array with proper alignment. This is meant to follow the pattern of
> the similar IIO_DECLARE_BUFFER_WITH_TS() macro.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

But this is in conflict with the other hack-patch in another series.
I'm a bit lost what patch 2 fixes here and that hack-patch fixes
in the same driver. Shouldn't survive only one?

-- 
With Best Regards,
Andy Shevchenko



Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1401CF8B;
	Mon, 16 Feb 2026 07:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771227921; cv=none; b=qhqwOwCnkoAH0U++1TV8Xf0IfvI1ovKJfh4LJrLT4LQcKEkwA/91U5CrLZTZGEvLNCB+plh5hY6YZfGnmY8bIOIwLCLulI0LF/n6vaMVzc+JFKi2IWgy6CieeAMtygSeMz5jOfbV594b/TC+MkYpVnFLOi51716IwkYePJ7DwGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771227921; c=relaxed/simple;
	bh=HByV616+lZC5/9Tc7gPkfyPncpmup2F9Fl/W237SZ+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PlzILIVvkqQD9fRJvDlCeRinoT4CSSz8mk9zrgkMt/d9QRrtvGvRh2p7IhRLcPL1+zDIxlrOyk8Htf4LsLTLPrtYrpNL0h0fJzXQl3VOZMCIQqCDXCeCDx2+gUWCP+jX6daqyya7w0CDVjKisYAzYhjIMSp0w4IB7vHfgt+7E5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AHNH/WP7; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AHNH/WP7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771227921; x=1802763921;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HByV616+lZC5/9Tc7gPkfyPncpmup2F9Fl/W237SZ+U=;
  b=AHNH/WP7eyuCpxsBjjm1n+iYlF/K7nQP6NBNxaFF5S8YmNorpsseuE9u
   Dh7sDwC+VmqO7W2LbClzFFvZxM0uAA4YBj+HLwxCUFPaKw9EBuD0FcGAg
   gLLjLDdQcyljyiaR3INAGqJxt6KMQJNXgxeQ9Y20osqKShJRDau5lQ229
   vbR6JsiPxjl1/J413//ztJMaR7KFuHkNHhXIBO42sotiVNWU0cKLpBThb
   lTLKn8lLQCrkbx+yaP7M9jg2/kBGhjFGcRD0gr1SKSegVfZmKHxCqN1zQ
   LHMgmMn8rfCsifGxY6T0rH9Zq15CxX4YuhICSmGpnR03LVWtXp8PgCb/q
   g==;
X-CSE-ConnectionGUID: 9vYCihVpT8i58OqrXWRgbw==
X-CSE-MsgGUID: GtQxt3V0QuWa22mkHelgKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11702"; a="72477594"
X-IronPort-AV: E=Sophos;i="6.21,293,1763452800"; 
   d="scan'208";a="72477594"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2026 23:45:21 -0800
X-CSE-ConnectionGUID: J9qDjNCgRgCqco+b5CM7ug==
X-CSE-MsgGUID: Tl3IruscQGSfEULFAvXBVQ==
X-ExtLoop1: 1
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.188])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2026 23:45:17 -0800
Date: Mon, 16 Feb 2026 09:45:15 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-input@vger.kernel.org, Lixu Zhang <lixu.zhang@intel.com>
Subject: Re: [PATCH 2/2] iio: orientation: hid-sensor-rotation: fix
 quaternion alignment
Message-ID: <aZLLCzkFg4PVDziP@smile.fi.intel.com>
References: <20260214-iio-fix-repeat-alignment-v1-0-47f01288c803@baylibre.com>
 <20260214-iio-fix-repeat-alignment-v1-2-47f01288c803@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260214-iio-fix-repeat-alignment-v1-2-47f01288c803@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Feb 14, 2026 at 03:00:21PM -0600, David Lechner wrote:
> Restore the alignment of sampled_vals to 16 bytes by using
> IIO_DECLARE_REPEATED_ELEMENT(). This field contains a quaternion value
> which scan_type.repeat = 4 and storagebits = 32. So the alignment must
> be 16 bytes to match the assumptions of iio_storage_bytes_for_si() and
> also to not break userspace.

...

>  	struct {
> -		s32 sampled_vals[4];
> +		IIO_DECLARE_REPEATED_ELEMENT(s32, sampled_vals, 4);

This becomes
		IIO_DECLARE_QUATERNION(s32, sampled_vals);

>  		aligned_s64 timestamp;
>  	} scan;

In the similar way we can address drivers/iio/imu/bno055/bno055.c.

-- 
With Best Regards,
Andy Shevchenko



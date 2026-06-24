Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4F318C332;
	Wed, 24 Jun 2026 11:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782299904; cv=none; b=Zdrcp52ZWE4nETksrfb45Lr7aO4BykkgphLcLz/drfGeXQmRTUAGDPrXOVeVxyYaHlEnZQzDcwyfgQePJmS7912H3itv+VXfNeEi08XEeFUU0IRdZfqjIg1Bd/JTXSIJ5RAmNVlCvQMp6+rVNKHr2nOc3oDhds611vGgBi6qx4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782299904; c=relaxed/simple;
	bh=FGn2mj5vdttynSieVS0wPKp4dB+oV3GtPZBHpEqVL1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pAiAaueunY6CFTMbsBs/e2RsHOiRwwigS4596UFEHEr7jtGlhrLGv1BJOWH1/wF0E1BblipapSC6YjloXGvCPWoH6Fa4TfBUmzrouPtU237eBAltXzFCka3sxftZvGPgcB/7HM/p+i9nEc+jFiBr0lLVR8i/v6koeTOnRh1xWw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lRtJaIpd; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lRtJaIpd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782299903; x=1813835903;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=FGn2mj5vdttynSieVS0wPKp4dB+oV3GtPZBHpEqVL1g=;
  b=lRtJaIpd1e+rD0IYIcYz3bV9fZyLuuuWNtrS5RJ2Q3jhVDbRGn317pr+
   ks8/l+jnyj7o4+FBYrp3nWQbF5tepIYzoXSWqQyY1IN34Z2kQatK8as3M
   CXm2+lOzuE8pdIeBD9LLDbFrkZTFGRRslcqTi6QRNoulYoLWurZaIZJ7R
   RqokPDhUnzQgwYf+AoNL/1XJxdqYq0k4srqvgA/xf18zrGO3sP4wjf2Tx
   VhnPbRgoCN794PXAch3MqWROI6297Curh1sYu+Dcr4VT8y0ytsjsSLnZf
   PjaBOQwtM7kVM3fQ2OMRwFnqzSjDLDWI8pTaJgjXbFKXWBaZpmh8xgX5y
   Q==;
X-CSE-ConnectionGUID: hwGxu8N2R8CEmFPzVVKMXA==
X-CSE-MsgGUID: 7bYwftSjRTq8mecph0t0wA==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="100482141"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="100482141"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 04:18:22 -0700
X-CSE-ConnectionGUID: H+rc1GxHQEmFpXD7/P1/rg==
X-CSE-MsgGUID: Lq8w6KGoRHqH/HQ9dzGTBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="254904166"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.156])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 04:18:20 -0700
Date: Wed, 24 Jun 2026 14:18:17 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Archana Patni <archana.patni@linux.intel.com>,
	Song Hongyan <hongyan.song@intel.com>, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	srinivas pandruvada <srinivas.pandruvada@intel.com>
Subject: Re: [PATCH v2 0/8] HID: iio: Avoid race between callback setup and
 device exposure
Message-ID: <aju8-caYYYR7_47N@ashevche-desk.local>
References: <20260622-5-june-hid-iio-race-fixes-v2-0-1cfabcd1881e@gmail.com>
 <ajpgQ8vCHacv_klG@ashevche-desk.local>
 <7288DEE7-91CD-4823-959B-229AEF1CAD97@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7288DEE7-91CD-4823-959B-229AEF1CAD97@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 24, 2026 at 07:13:12AM +0530, Sanjay Chitroda wrote:
> On 23 June 2026 4:00:27 pm IST, Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> >On Mon, Jun 22, 2026 at 10:59:56AM +0530, Sanjay Chitroda wrote:
> >> 
> >> This series avoid a race condition in HID IIO drivers related to the
> >> ordering between callback registration and device exposure.
> >> 
> >> Currently, several HID IIO drivers register the IIO device (making it
> >> visible to userspace and other kernel consumers) before all required
> >> callbacks and resources are fully initialized, or rely on devm-based
> >> cleanup in a way that does not guarantee correct teardown ordering.
> >> This creates a window where the device can be accessed while it is
> >
> >There is a difference between "this creates" and "this might create".
> >I believe Srinivas and others were asking for the proof. So, what path
> >in the code makes this happen or possible to happen?
> >
> iio_device_register() exposes the IIO device to user space, while
> sensor_hub_register_callback() registers callbacks for buffered IIO(streaming
> mode).
> 
> This might create window where from userspace buffer mode is enabled and
> callbacks are not registered which would result into loss of samples until
> callback registration completes, although no explicit failure. In teardown
> path which can resulting in stale/no data.
> 
> This was discussed in the v1 thread and v2 was posted based on discussion and
> agreement:
>  https://lore.kernel.org/all/3FED088A-651B-4E8B-840B-1B92CB4DF6F4@gmail.com/
> 
> >> not fully initialized or is being torn down, potentially leading to
> >> sample drop or stale/no data.
> >> 
> >> To handle this, the series ensures that:
> >>   - All required callbacks and resources are set up before the device
> >>     is registered with the IIO core
> >>   - Resource cleanup is performed explicitly where ordering matters
> >> 
> >> PS: This is prepratory series to convert all HID IIO driver to devm.
> >> 
> >> Testing:
> >>   - Compiled with W=1 for each patch in series
> >> 
> >> ---
> >> Changes in v2:
> >> - Drop fixes tag and rectify commit message with reference to that
> >
> >You also dropped my tag. Why?
> >
> Thank you for the review and tag on v1.
> 
> While code changes are intact in v2, the rational and commit message were
> updated substantially. Since commit message is as important as change which
> will be permanent in history for future reference, I chose to drop the tag to
> request a fresh review.

Now it's clear, thanks.
This version with changed commit messages seems good to me.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

> I shall highlight the same in change log. I'll make sure to note in future revision.

Yes, please.

> 
> >> - Link to v1: https://patch.msgid.link/20260606-5-june-hid-iio-race-fixes-v1-0-27a848c5758f@gmail.com

-- 
With Best Regards,
Andy Shevchenko



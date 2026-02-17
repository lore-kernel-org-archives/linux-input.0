Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315912D59FA;
	Tue, 17 Feb 2026 08:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771315860; cv=none; b=Ea3aTTilW/UzM4ybTo3Vb1YVR8J2gIDVn55WKQndQ4zy0Nlia3Ec4y9mmXpjAeUc3/GPeA5y20cNxJgs2cTZYTMG/9oanE4G3H5DE4q/hbsT+0+i1KbFlNBHKhU9mJFtKB+8BZr9ISpnX8yAQlk6qhidfY1ymUWAqFcEs/bg4vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771315860; c=relaxed/simple;
	bh=oA2rZARAQUJ6xB0VC+dSDepaOhpDSPUotQBPBumMN2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DPgWx57ly51IeahFbxxwy1WKuSBWP8gOWu7Ce/49ka3Q6SfAd8If3bDA70N3pHgYQ0LPgB7FBK/f8edrXo+fIGwlrbLYaaFG1wvSln0oyNcEeY93iaV4uzafh2UnnKEW74JdSsLz1oX27kjefbfShMDVajP6J6jaoIdOlZ66koM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aOPYOqx6; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aOPYOqx6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771315859; x=1802851859;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oA2rZARAQUJ6xB0VC+dSDepaOhpDSPUotQBPBumMN2A=;
  b=aOPYOqx6WfJ7kP8uJQ5HkE/Dx64imXA7oN4ovhRHAq71DmqzvqN5hGob
   7hlNLlLiR+t2iTfjlPsa3KeN9TN06qVdUdMq7hMHTUWMD1c7rrTvNjbgf
   1+LFJ61Lilgh9m8FAameswIyvl4kWWfWJ4YAW2Ft7e2GXhIs0LUvXZBN2
   cfRG1fbNKoQMkI764eoH5fur0aT5UTzB3vjIJliUBJxMIfykRSQU4R4CX
   noBMYY0TUSkNcZ6PT2gXvYyFL0Rde+tr226JsUBekAoRoUFFDe1PhBonu
   S28MxANG4JsJaOazWT8ONUiXvHPrCY8iiyw6y/1ra9Ogw6mLcmrb1ShQx
   Q==;
X-CSE-ConnectionGUID: BWnWYkbHRAyuQ1kB6fKh3w==
X-CSE-MsgGUID: zGYqCZ3aTRC8NA4u11xU0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="59947721"
X-IronPort-AV: E=Sophos;i="6.21,295,1763452800"; 
   d="scan'208";a="59947721"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 00:10:59 -0800
X-CSE-ConnectionGUID: iEgWq6ynSSqyVOfFGrxebw==
X-CSE-MsgGUID: rtpeFw+zRmStTDhIOL9/Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,295,1763452800"; 
   d="scan'208";a="251490522"
Received: from lstrano-mobl6.amr.corp.intel.com (HELO localhost) ([10.124.220.245])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 00:10:56 -0800
Date: Tue, 17 Feb 2026 10:10:53 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-input@vger.kernel.org, Lixu Zhang <lixu.zhang@intel.com>
Subject: Re: [PATCH 0/2] iio: orientation: hid-sensor-rotation: fix
 quaternion alignment
Message-ID: <aZQijRLVjzuWcU2W@smile.fi.intel.com>
References: <20260214-iio-fix-repeat-alignment-v1-0-47f01288c803@baylibre.com>
 <aZLKy4l6OlPgIkZx@smile.fi.intel.com>
 <bcfc711c-a02a-4470-a2a6-de43c71e7c2e@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcfc711c-a02a-4470-a2a6-de43c71e7c2e@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 16, 2026 at 09:25:58AM -0600, David Lechner wrote:
> On 2/16/26 1:44 AM, Andy Shevchenko wrote:
> > On Sat, Feb 14, 2026 at 03:00:19PM -0600, David Lechner wrote:
> >> The main point of this series is to fix a regression reported in
> >> hid-sensor-rotation where the alignment of the quaternion field in the
> >> data was inadvertently changed from 16 bytes to 8 bytes. This is an
> >> unusually case (one of only 2 in the kernel) where the .repeat field of
> >> struct iio_scan_type is used and we have such a requirement. (The other
> >> case uses u16 instead of u32, so it wasn't affected.)
> >>
> >> To make the reason for the alignment more explicit to future readers,
> >> we introduce a new macro, IIO_DECLARE_REPEATED_ELEMENT, to declare the
> >> array with proper allignment. This is meant to follow the pattern of
> >> the similar IIO_DECLARE_BUFFER_WITH_TS() macro.
> > 
> > In both cases it's quaternion, maybe be more explicit and define
> > IIO_DECLARE_QUATERNION() ?
> 
> It is really the fact that the scan_type has .repeat > 1 that requires
> this, so I was trying to make a name that shows that link.
> 
> But right now, quaternion is the only thing that has .repeat > 1, so
> I guess it would be OK either way. We'll see if Jonathan has an
> opinion on the naming.

I think we should solve the problems when they appear. Naming explicitly
for quaternion makes it easier to get from the core reading without having
a variable name to repeat that. Magic 4  might not always be a quaternion.

Do we have "repeat" to be used in other cases, btw?

-- 
With Best Regards,
Andy Shevchenko



Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295C13644DA;
	Tue, 20 Jan 2026 21:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768943228; cv=none; b=OLRU0xPOephi9ZLVuSwmQ8CTfSsZE7WppDXPn/mKiLYEbRT1NPWtOn6gTAoo6tPF2HJCJW9x/1lgGGlvwaDPHVKD2aNQ6Js3w++pQ8AI+moRyNJ49VMjaB5zIfwV20PPXoxfSnFhMaGU/K3xuOCYjcKF81FaNlzRAMAZScN7lUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768943228; c=relaxed/simple;
	bh=qwQe/gYDpjv/glIpyFtYefPG33oUItwpKi2fQz1DQ4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QAlbaMvtI/JT7fVXh/Fc2IPIQpOyq9zt9C093RjQeaCLNFir827OfJQ9tk0I7sGlJ8KMUjQVuNmQz4vF4mjET/aXJB8m9ZvBKRjKSzfdm2ArgFcLV2MjFgSxE/9K1hUzLdpR6bkAzfC7GyrInKDaD1OarkHRzRxl1Xw+7B6D+t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lBeKePrq; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lBeKePrq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768943226; x=1800479226;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qwQe/gYDpjv/glIpyFtYefPG33oUItwpKi2fQz1DQ4o=;
  b=lBeKePrqQCIpybqIbBLx5MyDLZOEt3YggJzYYVQfvNIY7svQum97UqMn
   HyHmSrJQXfTALClRFGlS4oHmY0WoOjswqQqqhtwrKCqjjzR03LB3u1S3/
   uS5XnLSmunAebrrbrKBHrjWhuPJibGJ3cpM7LBcNKD+3c9FmDb9Ac7o7m
   LKyApCiqMUyut3WNb1/D/1U32NpYwOJNB332tBJCsPh2zOFKW+fpqJFki
   yZGNqXfM63KBnrygcahoZUNI/8nHATpp14xATnq2NA9QPb4UIRhqhZ874
   g/BbkT/yGsQpgV3d/3Whh03YEwSqtD2RNVThi29ilqZSBPz6ievZ8zyxT
   g==;
X-CSE-ConnectionGUID: 9PSFQLoyQa60YykESI5jTw==
X-CSE-MsgGUID: 98hQfnp9Qaq5XCGW/6F90A==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="70218849"
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="70218849"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 13:07:06 -0800
X-CSE-ConnectionGUID: WD6dqH+ET+y7v14kN83oiw==
X-CSE-MsgGUID: Ij3Ut5eoRNSgvs+Nk0eYdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="236899011"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.240])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 13:07:04 -0800
Date: Tue, 20 Jan 2026 23:07:01 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Input: wdt87xx_i2c - tidy up ACPI ID table
Message-ID: <aW_udfdK9mMOvW1X@smile.fi.intel.com>
References: <20260113082445.44186-1-andriy.shevchenko@linux.intel.com>
 <20260113082445.44186-2-andriy.shevchenko@linux.intel.com>
 <nn6qjsmd4vt2giq3kd46lemd2q2ofdjbb6mmlaao7y2edodm3u@s2qwtwhyhiwb>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nn6qjsmd4vt2giq3kd46lemd2q2ofdjbb6mmlaao7y2edodm3u@s2qwtwhyhiwb>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jan 20, 2026 at 12:42:16PM -0800, Dmitry Torokhov wrote:
> On Tue, Jan 13, 2026 at 09:22:57AM +0100, Andy Shevchenko wrote:

> > Tidy up ACPI ID table:
> > - drop ACPI_PTR() and hence replace acpi.h with mod_devicetable.h et al.
> > - remove explicit driver_data initializer
> 
> With the exception of cleaning the driver_data is it unclear to me what
> the benefit is. The driver is potentially useful on non-ACPI systems (or
> may be easily adopted) so making ACPI not optional does not sound like
> improvement...

I'm not sure how you came to the conclusion "making ACPI not optional".
This is just matter of dozens of bytes in the binary, it doesn't affect
functionality neither on ACPI-based, nor on non-ACPI platforms.

-- 
With Best Regards,
Andy Shevchenko



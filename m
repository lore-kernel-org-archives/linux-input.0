Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD0E3BBA00;
	Wed, 22 Apr 2026 09:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776849300; cv=none; b=gmmK8UTQCzLrL7RGzF/yu9++QK7Si7FWLviiJy7KUGjQfIdOJWHofIwn2kREjbRg3M92nqlrOxKTkFs/LaqGy7ijCHlb8zOx9/tzRINB01Bq+RcYk0h4CG5h5vCwhVW6uE7gSR1vlo40FH0BLJvjWUY6G9Z9SKAsynpUQ+dPwNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776849300; c=relaxed/simple;
	bh=RhcLfaR5IDyWa18CBl2Iyz0waLSHKBOGcIXb6UT8phg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZivwZH9gVTCLq882T5T+hJA26mVnFUuwFup6acV6LOP0LnFb8yWqExEb2x0u16PRn79PDbx/g6Cp30uXxShBPPCd8aIzkb87HqV7I5IvefvfBYoEUOcFO37I/mtRcq0yqbt4t1E21ENKv5Q27wl+vGTuYS02l8dahvO8PH8+EUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UHN7WeQb; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UHN7WeQb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776849299; x=1808385299;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=RhcLfaR5IDyWa18CBl2Iyz0waLSHKBOGcIXb6UT8phg=;
  b=UHN7WeQbSkLk1vPETkL+CJNem2gt9wcraVclyuAgd5XdY0Hhbhle7Vwv
   nrq5I+t3BSmb/ebe/qNfmDrtmkFZZO7QZ5fxwmMWdF/ffMACmkZdVpCP9
   dkRv4xSpCQTLPLCnEd1XA7so4MCyE1WKhybmmDz/aO9EfdeUwSNXPfeiu
   SFJOmY0+d1M29ffPNnVt/P2eIIee4IDcLUdVnoadZ8TIFxeK8XDK7rHOI
   u2bvBXxBeWN7gsHF3z59tfgKRt7Csibsme7nnXHTUutzggWb34zpcKHYR
   gTnJebBe1u2J790RjiGwVHk8qkWBQSXcGIlTsJPltvRFywdbX3yXxpx87
   A==;
X-CSE-ConnectionGUID: oHGiSJi1SXKovmpl+uhN9g==
X-CSE-MsgGUID: yvwgzjvXRxa7Asas/XoW/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="81663292"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="81663292"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 02:14:59 -0700
X-CSE-ConnectionGUID: CkHC4cyfS++nFgZ/QKZnlA==
X-CSE-MsgGUID: 4IyCb+W3TtiN5RG+Q6ft7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="262690502"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 02:14:56 -0700
Date: Wed, 22 Apr 2026 12:14:54 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: =?iso-8859-1?Q?Nat=E1lia_Salvino_Andr=E9?= <natalia.andre@ime.usp.br>
Cc: andy@kernel.org, bentiss@kernel.org, dlechner@baylibre.com,
	jic23@kernel.org, jikos@kernel.org, nuno.sa@analog.com,
	srinivas.pandruvada@linux.intel.com,
	Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>,
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v2 3/7] iio: gyro: HID: Replace method
 gyro_3d_adjust_channel_bit_mask()
Message-ID: <aeiRjtoyTfHrpJoT@ashevche-desk.local>
References: <20260421222210.16016-1-natalia.andre@ime.usp.br>
 <20260421222210.16016-4-natalia.andre@ime.usp.br>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260421222210.16016-4-natalia.andre@ime.usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 21, 2026 at 07:20:35PM -0300, Natália Salvino André wrote:
> Replace method gyro_3d_adjust_channel_bit_mask()
> with helper method hid_sensor_adjust_channel_bit_mask().

...

> +		hid_sensor_adjust_channel_bit_mask(channels,
> +			CHANNEL_SCAN_INDEX_X + i,
> +			st->gyro[CHANNEL_SCAN_INDEX_X + i].size);

Same, at least one more tab for indentation.

-- 
With Best Regards,
Andy Shevchenko



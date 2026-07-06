Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835CD3EFD0E;
	Mon,  6 Jul 2026 21:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783372613; cv=none; b=C0FkPD9ebGqelWFviYry8y6lZ9RGnMKrys4JEhdUSD5nq4oNZgwQEr1WOzy0C8ATIQEfGiz/sUoyWwta7SbgjLa6H7TbxyspbtqxJ03EtOXq6ln/VX8/KVcL4gyq55M+9IoevD4FzwDc1JD5Alb5R90c/MZWwALXAM0p7qs8t28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783372613; c=relaxed/simple;
	bh=Nyq9T7NfxUKyzwtRKo8UekX4IIX2LM0TykSJJnG1SxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qRwaIEAHvLpuUbta1Fe3mjsoKOCUNpvKW9Wl47aL9Z2VhpahLqrMuUJxuVEt6RflghYtHPYv0Ay5VBOntfN2SrXQChF21A9xbjXjCFpPi9L+pMl1BrWonfwhvYyKIwwwJ/qlF5PuG3pjdTexObEVRNgjeCjdnkaNTcN9KLYqKjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aH3qqwAM; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aH3qqwAM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783372609; x=1814908609;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Nyq9T7NfxUKyzwtRKo8UekX4IIX2LM0TykSJJnG1SxE=;
  b=aH3qqwAMr4Qcu6pKs5YkPZY0UN7fP2RpKwg/D+FxW4mcQ7HFHaN315pJ
   hKS/HWQjYvXQJrA+G0pOqnbs/ZGu41s5mibaXMja/G+GN5Dtcpk8AFzkf
   9mH+y+0WyFl+vCrRuh16U89ruCGD+DwYIY6U4aTntqGc8tmTzl4Qz8tqb
   iESvp8QVwnODAYstYa8E9SKZvjmBeEjhsFHznFhbknWTw0UyvqgYaQI5G
   lwhajc86wwH/Ef8bJWlvkB0fu9+qsEaH/pRDWB8lqfzP47uat5tz54+sK
   29Xn83CM/96z/6mVFVCv3VKCnYUZJ6H9UVkPMmAfSBCZqCAGGeFL2GEL7
   w==;
X-CSE-ConnectionGUID: NWr+CoOfSiymkk5ecKU43w==
X-CSE-MsgGUID: mY/H7eGgTHKVwfiq3p9DtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="83877658"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="83877658"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 14:16:47 -0700
X-CSE-ConnectionGUID: Gedxb4BLRYaq9/RiGOA/Jw==
X-CSE-MsgGUID: D9oUdjdNRO2MzPcdTyZsDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="254465291"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.178])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 14:16:45 -0700
Date: Tue, 7 Jul 2026 00:16:42 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: sanjayembeddedse@gmail.com
Cc: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Maxwell Doose <m32285159@gmail.com>
Subject: Re: [PATCH v3 0/2] HID: iio: warning clean up and prefer kernel
 coding style
Message-ID: <akwbOnnEuQ4wA-OE@ashevche-desk.local>
References: <20260707-15-jun-hid-iio-alignment-v3-0-8791574ad0fe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707-15-jun-hid-iio-alignment-v3-0-8791574ad0fe@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 07, 2026 at 12:29:42AM +0530, Sanjay Chitroda via B4 Relay wrote:

> This series updates HID sensor IIO drivers to address checkpatch
> warnings, improves readability and compliance with kernel coding style.
> 
> The changes are:
>   - replacing explicit NULL comparisons with implicit pointer checks;
>   - adjusting indentation and alignment;
>   - reformatting multi-line function declarations for improved
>     readability and consistency.
> 
> While updating alignment and line wrapping, function parameters are
> grouped more logically and common callback signatures are formatted
> consistently across HID sensor IIO drivers.
> 
> Testing:
>   - Compiled with W=1 for each patch in the series

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko



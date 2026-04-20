Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71897298CA5;
	Mon, 20 Apr 2026 07:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776670609; cv=none; b=YDvWfNemIvsUyV0rH98H/vP/SdMLvRWwM7iirlJvN2meQdeKioahSoxdZrwyKfzpqMUaCcMj5G7mOJ7UP91w5PcvSkbkpSpngzIjn4wJ7vpoabFA1fegFH3iKtMlyhqgrxSylkBfasnHQA0RcZhyoqiPllGf+Eyw2mHQqEm5AlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776670609; c=relaxed/simple;
	bh=8whNwNLICqb+0Yx7LD1vb3V7QW1bBxZ6Jc58zR1F0BI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hl6cmLqUSXpnju5WxD1F4Updeq3sr4hC3hl/iDuxf37fdrSaF2JsQBW7jH8yzk8VEz01TKusitnZ5+9xjeM6+S2+HcqXzRTcUcHp3VPap7R+K+9RrnTK73CIr9JdrOWcRr1AuvtcmoA5eMBmsPBftSQ6/E2xcM6/1JZg4p47SgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JyG838VN; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JyG838VN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776670608; x=1808206608;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=8whNwNLICqb+0Yx7LD1vb3V7QW1bBxZ6Jc58zR1F0BI=;
  b=JyG838VNzly/d3sq8OpSRfwlc3rLkXanzy61Z1X1P4Jj75Z/bQgfsi3m
   d2xO0h50FH1tOxmKfIzDtjF4a0hsgXbgYsuuC3w7YRtJ7YMaePuaDx0YJ
   uxQBRP4od1/XiPXx3GE5IJKP8RGWkiFR04bicVXsG6uidmBDIc4iyT3Jh
   hQUPjjimOGPe0UkL4g1zSQCANm5AI6/Ig+gysG1/96I1VIWMglJK31Fh7
   jztLcx+qK/tVmPIUFEF4rfT8zW/MMaZ/bfkKZJr9lQ4hKxdsrGP+q9oOq
   vpKD7IvN2KY4mH+/rQ8dMg7ZYQl3ODlqtqVplC+oVwOZ9LQdrUpDiHp4z
   w==;
X-CSE-ConnectionGUID: 4vbydUHFQjuaT/ygFjjb8A==
X-CSE-MsgGUID: usjrjGYLQXCBVXYIPNz/7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77284671"
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="77284671"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 00:36:47 -0700
X-CSE-ConnectionGUID: AzzR7xmGR5m7ww3S0hWYqg==
X-CSE-MsgGUID: awcxNqqNQWuitTiBhq/dcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="228964209"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.90])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 00:36:43 -0700
Date: Mon, 20 Apr 2026 10:36:41 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: =?iso-8859-1?Q?Nat=E1lia_Salvino_Andr=E9?= <natalia.andre@ime.usp.br>,
	andy@kernel.org, bentiss@kernel.org, jic23@kernel.org,
	jikos@kernel.org, nuno.sa@analog.com,
	srinivas.pandruvada@linux.intel.com,
	Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>,
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH 1/7] iio: HID: Add helper method
 hid_sensor_adjust_channel_bit_mask()
Message-ID: <aeXXiWGJIvdhdBMQ@ashevche-desk.local>
References: <20260417225959.16688-1-natalia.andre@ime.usp.br>
 <20260417225959.16688-2-natalia.andre@ime.usp.br>
 <1c49e011-ae23-4c6f-ad6f-f0b494c2dbbc@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c49e011-ae23-4c6f-ad6f-f0b494c2dbbc@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Apr 18, 2026 at 11:32:13AM -0500, David Lechner wrote:
> On 4/17/26 5:58 PM, Natália Salvino André wrote:
> > Add helper method to deduplicate code in HID sensors.

...

> > +	/* Real storage bits will change based on the report desc. */
> > +	channels[channel].scan_type.realbits = size * 8;
> 
> There is a BITS_PER_BYTE macro that would make sense here.

> > +	/* Maximum size of a sample to capture is u32 */
> > +	channels[channel].scan_type.storagebits = sizeof(u32) * 8;
> 
> and here.

FWIW, we have BYTES_TO_BITS().

-- 
With Best Regards,
Andy Shevchenko



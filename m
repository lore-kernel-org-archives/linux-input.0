Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DCF238C1A;
	Mon,  9 Feb 2026 08:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770627335; cv=none; b=Z11k4qSoob/91zkBWUUqko3GNIAsL6L0F0L4tYI2XMNf6hmk1fraTPBNJVKgV39dfxJGaMpmmQ+t5GK4j/1484n2oKZeoUyD2mjmt9IoH9dMPLu6G4r9sdA3WKctVkEzMH29fvJmMt+JMnSRkUJWcsrLDzueRlpg2CIcYHXtBH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770627335; c=relaxed/simple;
	bh=u+RJ5fpOLGFTj43FZI6P3+rLGJsrgpsOqXn1p/coU4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2pQNYdgsVqgYXtwnDPWI1O6ITSFIDWl2xx/hJb/ihaomvQmYRH8VUrT3g2/m//OauyIbhceteA7K4Yg0hLUQ4V5l5fLuwepZsjO934+8TNZ6YXFKw3U/VsjawNhcKLvFPiUZP0JSuTqfJDHkfqdbhRNrY0s3+Cm9S9b1+u/Xu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GIdrdVEa; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GIdrdVEa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770627335; x=1802163335;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=u+RJ5fpOLGFTj43FZI6P3+rLGJsrgpsOqXn1p/coU4c=;
  b=GIdrdVEaY5wiCCOji7wgGB4XUAw1W2akZ3Po5nbNxWDl1SEzVbgFMgNt
   d2Gv+ENvqunpxbeKTvrRmVLesagIwyTKegUV6asHfu601hRO9iK/vLNuG
   XuFhg0WCLnK3E5RsfdORK+ZuTs9Y4zXgbPkJnP/lG+5wZS1rGv3ljmuLx
   0Gfl02qt1XcxRQEAy8bZSkwMlTJK4ROl77W0zmXhoP1EfqQNeejeM68a6
   MUthd4bgCyBJHvMz3nCOVZyrUZFUfEKah6hCc51BwfLPAta5eQf5Krq7I
   s2l13H3kKqHXbHFJgBcghEgEZK2cEKrMQFS7DHQsUzEGG++m8DA+DXY6z
   w==;
X-CSE-ConnectionGUID: 9RMWBJ5jSb+oi+RNcXntqw==
X-CSE-MsgGUID: ZOjD1WwDTF2kTAxqnHLDOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="59300718"
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="59300718"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 00:55:34 -0800
X-CSE-ConnectionGUID: i0pxkEVJRVqp3sNeat8wPA==
X-CSE-MsgGUID: LmJhRbNnS6+1kuD+ePH6gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="210618064"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.128])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 00:55:30 -0800
Date: Mon, 9 Feb 2026 10:55:27 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Dixit Parmar <dixitparmar19@gmail.com>,
	Tony Lindgren <tony@atomide.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v2 10/11] mfd: motorola-cpcap: diverge configuration
 per-board
Message-ID: <aYmg_7uq2rAWJgGK@smile.fi.intel.com>
References: <20260206172845.145407-1-clamor95@gmail.com>
 <20260206172845.145407-11-clamor95@gmail.com>
 <aYiHnUW93AB0ARJH@smile.fi.intel.com>
 <D8B3E97F-3405-4EBD-882D-677F530E4EDB@gmail.com>
 <aYmYcd0431P5sUtq@smile.fi.intel.com>
 <5AA39777-F5C8-4AD5-A5C2-47265C8213F5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5AA39777-F5C8-4AD5-A5C2-47265C8213F5@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 09, 2026 at 10:42:02AM +0200, Svyatoslav Ryhel wrote:
> 9 лютого 2026 р. 10:18:57 GMT+02:00, Andy Shevchenko <andriy.shevchenko@intel.com> пише:
> >On Sun, Feb 08, 2026 at 05:19:49PM +0200, Svyatoslav Ryhel wrote:
> >> 8 лютого 2026 р. 14:54:53 GMT+02:00, Andy Shevchenko <andriy.shevchenko@intel.com> пише:
> >> >On Fri, Feb 06, 2026 at 07:28:44PM +0200, Svyatoslav Ryhel wrote:

...

> >> And please, may you contain all your reviewing in one iteration. Then both of
> >> us will spend less time working on the patch. Thank you!
> >
> >It's an impossible request, you should understand that. If you want, use AI
> >or your robot colleagues for that, I'm just a human being, I can't see
> >everything at once.
> 
> Ability to see only nits and don't see the possible issues seems to be a talent.

Paying respect to the reviewers requires some talent, indeed.

...

Also, train your logic a bit, why do humans have so many professions? According
to your "logic" one should be a doctor and a cook and a programmer. Why not?

Or even closer to this case, a doctor must be a surgeon, a dentist, a therapist,
and you name it. Why not?

-- 
With Best Regards,
Andy Shevchenko



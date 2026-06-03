Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A1064A9D;
	Wed,  3 Jun 2026 00:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780444902; cv=none; b=ZNCoNVkoPJQoUap78aJRCFhWSbYQ1GJl4E6W3OwjB08k/N1OkabPTRbVdgdyvYWqvEwbk5U+agKxPG0l9oHZ3aTcSdvoS4UNWulDc35vUNJ4e5P8vR5+Qr621rSZWBct7q6CM19RZPfq7v695IyngWAikHCFiZW58Svi5lCMFp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780444902; c=relaxed/simple;
	bh=mcFjCQtsnqxmjJASQKDaQi7WqsUBZsX4sw/q7RWlnRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xmy61WYoiOHIWxshTTYlxaLGwtMMm4O4JMh8yUIMX0/D0iSXSVK741N0IcZKRCPau/2EJlfxWPDp+MYIhq1vI43H83YVzqB2/ZDo0A1TVtZDCIMWvo/vU75fxI0ZHMg/oj18Juy81emCw0ucMz9/vT41/EiiauYMtzYNtP5JixM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QG52JnRR; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QG52JnRR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780444900; x=1811980900;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mcFjCQtsnqxmjJASQKDaQi7WqsUBZsX4sw/q7RWlnRA=;
  b=QG52JnRR9vNQDOsF7CRhI7E6bGCXE4B5TBVPpYgeuv4RuAEzzKAjiFz6
   tt039oXzOhzXq/E2lBDtWS8tt7YaaAiiLGFOdQXvf1GHGZosxuMTetZDa
   J/cvcD3/y47wpco9OdC+UIrQ0+jU8kSpW6Re14H/ehfCkjySpKm4f8iUK
   /zS2Zr68vSw3yYWfdFvXa3RgvjpHGxv1n0iaPNZ1mJ2xYk/TyYtSQDA3C
   y6F43ImO3g6/0JqtBJc5a5VM3L/XTUQ72JqocoJH0Lat1WgLOnhEtAiwG
   7+5Mss4pdf93VZVSam0XeND+pnuhPk4BgYF677WYxPJYkd9YL0rYEyYHz
   A==;
X-CSE-ConnectionGUID: UKWvF0edRzCkJ5Lm72k1bg==
X-CSE-MsgGUID: 9+hzfZ0xRx+UEDB1gjsDTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="98807630"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="98807630"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 17:01:39 -0700
X-CSE-ConnectionGUID: 7Z+V5H0xTDWxPMlOyEsJSg==
X-CSE-MsgGUID: jK39cvjZQFyk3keD2XDHSQ==
X-ExtLoop1: 1
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 17:01:37 -0700
Date: Wed, 3 Jun 2026 03:01:35 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>, jikos@kernel.org,
	srinivas.pandruvada@linux.intel.com, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, sakari.ailus@linux.intel.com,
	linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/36] HID: iio: basic clean up and introduce devm_
 API for HID sensors
Message-ID: <ah9u3z4k-QtSLr3l@ashevche-desk.local>
References: <20260524192059.1193716-1-sanjayembedded@gmail.com>
 <20260526165639.42d6e98e@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526165639.42d6e98e@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 26, 2026 at 04:56:51PM +0100, Jonathan Cameron wrote:
> On Mon, 25 May 2026 00:50:23 +0530
> Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

> > Key highlights:
> > - 0000-0024: General cleanup and kernel few coding style fixes across HID IIO drivers
> > - 0025: Remove unused iio_dev argument from HID IIO sensor helper
> > - 0026: Introduce devm_hid_sensor_setup_trigger() device-managed API
> > - 0027-0036: Convert HID IIO sensor drivers to use the new devm-based trigger setup
> > 
> > changes in v4:
> > - Extend the series to cover remaining HID IIO drivers with devm API usage
> > - Reorder patches to place cleanup and warning fix at beginning and,
> >   devm-related changes toward the end based on feedback from David
> > - v3 series -> https://lore.kernel.org/all/20260509101040.791404-1-sanjayembedded@gmail.com/
> > changes in v3:
> > - Added cleanup and prepratory changes before adding devm_ API
> >   conversion based on self review: 0002, 0004, 0006, 0007 and 0008
> > - Address andy's review comment on commit message and coding style
> > - v2 series -> https://lore.kernel.org/all/20260429175918.2541914-1-sanjayembedded@gmail.com/
> > changes in v2:
> > - Following input from Jonathan and Andy, squash initial patch v1
> >   series in single change as individual change should not break anything
> > - Add devm API support and two driver using the same
> > - v1 series -> https://lore.kernel.org/all/20260428071613.1134053-1-sanjayembedded@gmail.com/
> > 
> > Testing:
> >   - Compiled with W=1 for each patch in series
> >   - Build-tested on QEMU x86_64
> > 
> > P.S.
> > - Sashiko reported an issue in a different driver and noted that it is not
> >   introduced by this series. I have taken this feedback into account and
> >   will address the actual issue in a separate series focus on that driver.
> > - Once this series is merged into the IIO tree, a number of HID IIO
> >   drivers will become available to fully converted to devm API usage.
> > - The changes are organized across drivers to keep similar modifications
> >   grouped together for consistency, making the series easier to review,
> >   rather than grouping all changes per driver.
> > 
> The series is mostly fine, though not sure what happened with how you sent
> it as I have it in seperate threads of 10 patches at a time. If you are having
> email troubles with big series, use b4 to send them instead (instructions on kernel.org)

I'm also confused. Fix your email and then come with better series chaining.

> My main concern is this is a lot of churn on a critical driver. I'd like therefore
> to be able to see the full benefit of those devm patches rather than get us
> part way as this does.


-- 
With Best Regards,
Andy Shevchenko



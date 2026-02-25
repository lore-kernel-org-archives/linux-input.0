Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEE53DA7D9;
	Wed, 25 Feb 2026 17:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772040123; cv=none; b=o0alXda5+LpqrQp6PsqyXlodwbLEqvOWzyPBgfka5E7Krt8sn+T2c0olNa+aZP8bxNRLI4QjuMf68gIH6QSx80c1PrBdcSM4fY6HeQowWr+98Km3tOwgRXcW36Cyuly7ujqIoO5+O0ywNEDEHRRbHMA9rah5SJ8XMwf/GrailuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772040123; c=relaxed/simple;
	bh=e8zWuX4eYM6nTZJhf2F/Lk+jDBCWaLgI0oA8b1vz2wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSQ4ftLZ3O9sMpcX1l/7sxE4Wdztjvhe194qSVXBJGx+X6+saSdbgtxrxKcXCjUrYTlADDAUs5L0HT3uGljlkuGTcYlZG8WqibOLJb/4mi+wxG7cuSNsGIYc+eeO0D56UgWIXgn/bYXPL7q6CHgJQO0zVTPht0TlgXgW4DelQpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KsMvktmU; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KsMvktmU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772040122; x=1803576122;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e8zWuX4eYM6nTZJhf2F/Lk+jDBCWaLgI0oA8b1vz2wg=;
  b=KsMvktmUSwXy0tMxQGiZBjm/o1j50NiVGQxsjq7DVdNt2/R53/pftYB5
   Pwgi74+xlWfnXJFxAI6QDciKPUg1hQzTBm8y+M5au6gV/mQctND4Ov+8o
   HMe9AnygmPlR6Pyti6fxS3GTmucDz/W6KO5NsRz3jIl1mnMS8XUriHjHv
   EiYNmriDVeoSJaN0J36A/gHqkj3UJwjOHn+oh+GzvlaubmzpupocWfoa2
   k1Xlbf8ZchKDulvBFhcCUdaDImHunXsNjDpV2eucp6zifiILBVjxUvdws
   IMfjcLsoRO0JDpuWVyc/0uMGsavbfufRlR8Gu1qvomFNiUKEgodrx0Rif
   w==;
X-CSE-ConnectionGUID: jliSi8sEQLmR1t8HD82aOg==
X-CSE-MsgGUID: hQuMFHWeQB+RjNsB9TOS7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="72994569"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="72994569"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 09:21:47 -0800
X-CSE-ConnectionGUID: FqbgM12LSsWtlmgmCPpHig==
X-CSE-MsgGUID: 4VG8RksBS42YGJmfs5zoqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="213953604"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.71])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 09:21:38 -0800
Date: Wed, 25 Feb 2026 19:21:36 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hugo Villeneuve <hugo@hugovil.com>, robin@protonic.nl, andy@kernel.org,
	geert@linux-m68k.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, hvilleneuve@dimonoff.com,
	mkorpershoek@kernel.org, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, lee@kernel.org,
	alexander.sverdlin@gmail.com, marek.vasut@gmail.com, akurz@blala.de,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 4/4] Input: charlieplex_keypad: add GPIO charlieplex
 keypad
Message-ID: <aZ8voAddPvMLCvc4@smile.fi.intel.com>
References: <20260225155409.612478-1-hugo@hugovil.com>
 <20260225155409.612478-5-hugo@hugovil.com>
 <aZ8fXXGMx3fk7gKs@smile.fi.intel.com>
 <20260225114155.3ee2efb002aa0f52a905f535@hugovil.com>
 <20260225115652.8beb1979df3824f7a95d22bc@hugovil.com>
 <aZ8tocPCKqTXqbC0@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ8tocPCKqTXqbC0@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Feb 25, 2026 at 09:14:16AM -0800, Dmitry Torokhov wrote:
> On Wed, Feb 25, 2026 at 11:56:52AM -0500, Hugo Villeneuve wrote:
> > On Wed, 25 Feb 2026 11:41:55 -0500
> > Hugo Villeneuve <hugo@hugovil.com> wrote:
> > > On Wed, 25 Feb 2026 18:12:13 +0200
> > > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > > > On Wed, Feb 25, 2026 at 10:54:01AM -0500, Hugo Villeneuve wrote:

...

> > > > > +#include <linux/of.h>
> > > > 
> > > > Is this in use? Or you wanted mod_devicetable.h for OF ID table?
> > > 
> > > I need only OF ID table, so will replace with mod_devicetable.h.
> > 
> > Hi Andy,
> > finally I need <linux/of.h> for of_match_ptr()...
> > 
> > But I will keep <mod_devicetable.h> ...
> 
> Do we need the dependency on OF? We may include of match pointer
> unconditionally and the driver could be used on ACPI systems with
> PRP0001 HID.

Not only that. of_match_ptr() or ACPI_PTR() shouldn't be used in a new code
(there are, of course, _rare_ corner cases, which this one is not one of).

-- 
With Best Regards,
Andy Shevchenko



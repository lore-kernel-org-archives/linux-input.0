Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BAE1547C0;
	Tue, 10 Mar 2026 19:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773170313; cv=none; b=eqcugIyjDgvmdecp4rfM+4tjsa72EQuR6DSmzDB5YUHKVc/8MLYtATxUNlbgIMVVk29x20RBcCBbbw44erMYdSq49arUclNQWaJFSxwYVH6A7zhsuGbNxdvWuqYofjk4vkqSosUBDg1mxVQvc5ifsMrAkjm5eUmTBjv0geUBwTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773170313; c=relaxed/simple;
	bh=xcdQ7ftwUAonmlIubDJUO2exQTONEx2whkAN5AV9mXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amMhSsC5BpKPUviWuaDmTFr3ad0U88cmvJTcMHDDQhigdCPlezikXEKn3e+CITn2mcfaKEqO4fHPY+lhjUYchZFRdoBmM1q6USW/OV+f99RvgatW6vfrcjfhEwu8+sCbzLEs0AOVubynt8gwXg0XEbS6NEQDscLkaEsvfAg9AQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OgdQwh9Y; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OgdQwh9Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773170312; x=1804706312;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xcdQ7ftwUAonmlIubDJUO2exQTONEx2whkAN5AV9mXY=;
  b=OgdQwh9Yiut7P+6LU45bTw+SVpI3a76YElTSTaXDYQn+M2wczG/JyruP
   bZ53IQGmU4RFHgVQ7ifh9K9KJx6f+9nmJEvefmuqJLzOu2taorXA1Ieh/
   iMi4+VRHOEt6IDANAVh7SUZEH0tdEMkgyHAZBR0ga3kZACbeT8w0c3gj6
   iL7Hc8IUNj9oqfFfXKshaEHtHP04e4bhUdCFy3RRhk6h3Vl0460T1pXSR
   KtZDk21iW84kBY3ZXgm55tT0q4VzTEmmGzGg+8YNaLNdYUWI4NdOS5c2O
   j8o1PmHlH1mQP55jofiLW2O0huoMdf1MtAH2opUbiHKodO7ICRmyeWxiq
   w==;
X-CSE-ConnectionGUID: r9mlkO+ISSS7N7lkw0Bajw==
X-CSE-MsgGUID: XbFAWlguROyd1Ddzm/xVoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="77833323"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="77833323"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 12:18:32 -0700
X-CSE-ConnectionGUID: 1b+o1Bi+StapWP0nj7nQpw==
X-CSE-MsgGUID: i7vlGp/0RdKlly7MEgNErQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="220396741"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.54])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 12:18:26 -0700
Date: Tue, 10 Mar 2026 21:18:25 +0200
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
Subject: Re: [PATCH v4 4/4] Input: charlieplex_keypad: add GPIO charlieplex
 keypad
Message-ID: <abBugQOUWG_FTs4f@ashevche-desk.local>
References: <20260305192101.2125660-1-hugo@hugovil.com>
 <20260305192101.2125660-5-hugo@hugovil.com>
 <aari1Y1CPZSYEVj3@ashevche-desk.local>
 <abBkk4Ng-_MDHd6t@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abBkk4Ng-_MDHd6t@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Mar 10, 2026 at 06:37:34PM +0000, Dmitry Torokhov wrote:
> On Fri, Mar 06, 2026 at 04:21:09PM +0200, Andy Shevchenko wrote:
> > On Thu, Mar 05, 2026 at 02:20:50PM -0500, Hugo Villeneuve wrote:

...

> > > +	int oline;
> > 
> > Why signed?
> > 
> > > +	int code;
> > > +
> > > +	for (code = 0, oline = 0; oline < keypad->nlines; oline++) {
> > 
> > Can be like
> > 
> > 	code = 0;
> > 	for (unsigned int oline = 0; oline < keypad->nlines; oline++) {
> > 
> > as iterator is not used outside the loop.
> > 
> > > +		DECLARE_BITMAP(values, MATRIX_MAX_ROWS);
> > 
> > > +		int iline;
> > 
> > Why signed?
> 
> Does it make any difference given practical limits on nlines?

Maybe not, but might lead to interesting bugs in the future in case if used in
some arithmetics.

-- 
With Best Regards,
Andy Shevchenko



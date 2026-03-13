Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D50D306D26;
	Fri, 13 Mar 2026 09:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773393767; cv=none; b=rhWg+SLlkzx9PALaTp3+z3nJozvx9A6jtZkRqIp0UpTB+eTqa9ncGdVg3KYJofc48+VYJjJsTvIWdTGCQGezEhWuFkqH+TYvkNWJPrYycEkLXSAWtpCMwz8n7eE2g+EC1o4p1lCBcM/pV3IQ7XYed8u12l6XjpE0bhXh/ebe0P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773393767; c=relaxed/simple;
	bh=iWPfnSUIcQh2r/4xOFGM1kwIjo5t36uxHeaHCPe0Lak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bwi4QMTBkSHinzJ2Hk+YRIxtGhKsZKstFTdAvtOWP0hvtGNR9/hTSNRpmHflJdR3/y0y73qyInrBm0GBLFwSHQNvmcT5HpA5NHeX3lmzzdSTzgXMaleIFuIOOv9V6FzGREr1D/EM9M63qiVgM3UB68CnjREPFQkrZ9qFZ0joYqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QKUrh1nU; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QKUrh1nU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773393767; x=1804929767;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iWPfnSUIcQh2r/4xOFGM1kwIjo5t36uxHeaHCPe0Lak=;
  b=QKUrh1nUf5r8a6G6rdlwGKfEicOxPBZIYQ+yKu9YRpY/RqZNkL79R/Hr
   3ch08gVGTrELj6ntfDXupxABLFkjoQRETF5SEESaOFxnvMhbH3nLcIvt/
   Kpmw1K0oFhbPM/g4jo2yGzp1gaENhJ791MLbNZR4XAl8mOjPCobZ9yBtL
   Jp5l5O4k5q2dH2m2ROSrzpVDDZIdN9QoAl/sTFYUqK9emMZ8Qw5eJvxVu
   Xo3qV5WPW9U04f4dPbS0K+3HGaGsPYPKRSMNk2xznYt/gnKxx4v3AzzR0
   FNN6/LFw17SzgttRBt19Gm/PgAKk8AP/nw9xRqNgbmWKb2+RW3pW/e1JP
   w==;
X-CSE-ConnectionGUID: 8SkmGmd3SXuqqY/3rT2vSQ==
X-CSE-MsgGUID: yFqRPOX9S9iSyT2wGhE28A==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="74686952"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="74686952"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 02:22:46 -0700
X-CSE-ConnectionGUID: feumLp8MRSSSUjNa0zQJNA==
X-CSE-MsgGUID: hsqv2FpmRcmQlwBdfCq1/g==
X-ExtLoop1: 1
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.246])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 02:22:41 -0700
Date: Fri, 13 Mar 2026 11:22:39 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: robin@protonic.nl, andy@kernel.org, geert@linux-m68k.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	dmitry.torokhov@gmail.com, hvilleneuve@dimonoff.com,
	mkorpershoek@kernel.org, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, lee@kernel.org,
	alexander.sverdlin@gmail.com, marek.vasut@gmail.com, akurz@blala.de,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v5 4/4] Input: charlieplex_keypad: add GPIO charlieplex
 keypad
Message-ID: <abPXX1eWoq7C7J1R@ashevche-desk.local>
References: <20260312180304.3865850-1-hugo@hugovil.com>
 <20260312180304.3865850-5-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312180304.3865850-5-hugo@hugovil.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 12, 2026 at 02:00:58PM -0400, Hugo Villeneuve wrote:
> 
> Add support for GPIO-based charlieplex keypad, allowing to control
> N^2-N keys using N GPIO lines.
> 
> Reuse matrix keypad keymap to simplify, even if there is no concept
> of rows and columns in this type of keyboard.

LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko



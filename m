Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0662D3A543F;
	Mon, 22 Jun 2026 10:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782123936; cv=none; b=pa6Is2d8HIXjOKakjtsId0fWv/9IoHP3FqeVNIj1Bu3VyxR378JNIOmwJxRyfppzX3un/Vwcao1svM+bSdi24I8AIxuaEGdBArtlSTw7kvNBIHg2HuoJje+uVsPex07+xYrlzmhe7tyozfFpg0J7DHHu1Se/RkIoM09xPL7j5Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782123936; c=relaxed/simple;
	bh=a9vX3+xfcFAWBwgKRDgr3SOJJxO6gh2KtKBTflzIozw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EsufvvigyfcC0TR2SswajyzMkzeY10vebJVPlqBUKdr8AmmWfi+xzN2YSRSAujIO44uo0LAAAbUHaBAkEVbe49Ym8HB2U/DUH+3mrRFde9flKOKA1x23sXfqE09UC/P0ENzMxcnnxQvwy9n04xK1+9jppGqu0c3JaqW+zp79jUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FS+45VV4; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FS+45VV4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782123935; x=1813659935;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a9vX3+xfcFAWBwgKRDgr3SOJJxO6gh2KtKBTflzIozw=;
  b=FS+45VV4uhYAe+wgBcIm+T70kOxnhDd3sBBQ4hYrAb3XzC4S2DsHAl/g
   Qfqz6D3wVlrdPu03F9TdTkcEWecHUCnpkjskV+IumcGQj9VscEQ8cRxz3
   /o6wIJCbLkmE4pFId9VHoHDkx6QMZX1B9RPKfpuy2d3YDpwTYDhpA4TU+
   pCHLg7sjlcr6Yx8BlP1GXTIahKgvC83bdgR52FClv4JW/U7lD7BEBds2s
   BO/7blrtTP94o6kAD37QJFeDVjdUNwmdCc5h4SnN2Z7zXXREHlRSJ5J8q
   oHQ38DaVFvmOBhVRu4uyV5nZoHMZw4Fz+udbX0fBfR0j0o5dGqRfAEHGM
   w==;
X-CSE-ConnectionGUID: v5JddFWiTgmRnmChD+rSlw==
X-CSE-MsgGUID: QkyM9tEFTBSOzPji0dftlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="86532689"
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="86532689"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 03:25:34 -0700
X-CSE-ConnectionGUID: 9QIk+cUhRQ+trtRk+QHrgA==
X-CSE-MsgGUID: VHfAWD6mRJ+8WsC8PKyEfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="242833300"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.152])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 03:25:32 -0700
Date: Mon, 22 Jun 2026 13:25:29 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jikos@kernel.org, jic23@kernel.org, srinivas.pandruvada@linux.intel.com,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	hongyan.song@intel.com, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] iio: temperature: hid-sensor-temperature: switch to
 non-devm iio_device_register()
Message-ID: <ajkNmQwGbxWwmH7h@ashevche-desk.local>
References: <20260622052135.1804135-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622052135.1804135-1-sanjayembedded@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 22, 2026 at 10:51:35AM +0530, Sanjay Chitroda wrote:

> Avoid using devm_iio_device_register(), as this driver requires explicit
> error handling and teardown ordering.
> 
> Mixing devm_* APIs with goto-based error unwinding breaks the expected
> LIFO resource release model and can introduce race windows during device
> removal. In particular, the IIO device may remain visible to userspace
> while dependent resources are already being freed, potentially leading
> to use-after-free issues.
> 
> Add explicit iio_device_unregister() call in the teardown path to ensure
> deterministic cleanup and follow kernel resource management conventions.

Strictly speaking this needs Cc: stable@ as well as mentioned in the
documentation.

LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko



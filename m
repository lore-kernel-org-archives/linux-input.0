Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8EE1DF256;
	Wed, 22 Apr 2026 09:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776849439; cv=none; b=bkoU8KxC/MJzQZvf4Q8ya3l3GVZW2mm+9EcULZ3EpZdaMtvDOJep4l9GKc8cMZEq2jqv/R5+bv5fKLV/HOpUBLVGEjTOJxazEeApquHgRlZQr71cNFgOm0+4gA41Vh/IIiTSExlthM5dPsbXyYHv/tUniHDta052FbkxAntUMD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776849439; c=relaxed/simple;
	bh=QfiZR+HTjxHSmCsuxFe4l8pGxHBPMGcdd+e+UgrS5JU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iuq35qGrY54hbs+KazJVWFCsAONr911gLT6mj9tKawASMTLwCe1jXBXC6wvYOWISJAFhS0KMpPWq77d9hX/4LgKzWmPAm7WanEtYNorUAABlVuBLV1BmwtTclBnDnIvP0wfWZ5vM3e6mTU0PDa7nGSJW6DKxKH3hyi4kfwXbKiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h8wDjDp4; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h8wDjDp4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776849438; x=1808385438;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=QfiZR+HTjxHSmCsuxFe4l8pGxHBPMGcdd+e+UgrS5JU=;
  b=h8wDjDp40ak4zchGbGqlE0tZ6OvVawI64kOUJ4uFJJZ0gecZvKw3MEma
   JqlXmOScvai/ZFP13x9nESizyoFaICJDQ4PXMszEJ3cDXjTAFPXFnrRtR
   5RSPYTYvV8BQMnvRNNPEp5N14chH5G4P9bhkRSZVvAtWP2p89YzFbRsrL
   XGQv/e2PhylPetN1j5tuZ6vHbEVkBtFkvtFgxmN8cCIOyZJB0ncQt3i4A
   OrgkkgDhCkna3vuhYN+Rgx7R9MaXLoyHbWsAhTXkmH7pjRj32zputhZFT
   ai7NILJRhxROr9/xvmwvJbar5wmKc5na8FSWE72kWcZXxmrLLdzVlwp4y
   w==;
X-CSE-ConnectionGUID: MavlyuxdQQ6wFMkEgG121Q==
X-CSE-MsgGUID: RlLGG837RF+0qnuhxQEGUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="89266855"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="89266855"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 02:17:17 -0700
X-CSE-ConnectionGUID: Lb+omntnSg+DpMpR11HfDw==
X-CSE-MsgGUID: EN7fCtBwSLuR3j3vatKi6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="229631986"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 02:17:15 -0700
Date: Wed, 22 Apr 2026 12:17:12 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: =?iso-8859-1?Q?Nat=E1lia_Salvino_Andr=E9?= <natalia.andre@ime.usp.br>
Cc: andy@kernel.org, bentiss@kernel.org, dlechner@baylibre.com,
	jic23@kernel.org, jikos@kernel.org, nuno.sa@analog.com,
	srinivas.pandruvada@linux.intel.com,
	Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>,
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v2 4/7] iio: light: HID: Replace method
 als_adjust_channel_bit_mask()
Message-ID: <aeiSGP-QZ1K1srfw@ashevche-desk.local>
References: <20260421222210.16016-1-natalia.andre@ime.usp.br>
 <20260421222210.16016-5-natalia.andre@ime.usp.br>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260421222210.16016-5-natalia.andre@ime.usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 21, 2026 at 07:20:36PM -0300, Natália Salvino André wrote:
> Replace method als_adjust_channel_bit_mask()
> with helper method hid_sensor_adjust_channel_bit_mask().

...

> -		als_adjust_channel_bit_mask(channels, index, st->als[i].size);
> +		hid_sensor_adjust_channel_bit_mask(channels, index, st->als[i].size);

Indent to next line

		hid_sensor_adjust_channel_bit_mask(channels, index,
						   st->als[i].size);

-- 
With Best Regards,
Andy Shevchenko



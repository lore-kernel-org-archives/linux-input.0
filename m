Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FC9388E71;
	Tue, 12 May 2026 20:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778617273; cv=none; b=pDUp7VVHMEO3vzlD6T1ETbUZ1u1Ngy0DPWjN7nRYV3xuKtjs7jeeHv+jD1IwGpE8DrUo6fYSiVhCAIdyI8aAnfs7V69UogRcgUJAA5RQuIA90RblZ73wauWr3N9eVzVCOVsakk8fGwjwGJAcT3lbZP+9IdYGdmApHCh8D2ZjbNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778617273; c=relaxed/simple;
	bh=s2rj61DpAPI76iq1R9DkUD3MAI6ETO5bD9dTXZ3Wyf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rnIG0RaQ7kMeVAfinHrfwdE4Qc60HxCvWSE2ub2O9pXxGrKFhlrridTw5RutQKFaNR3P0LuwqERrzBeFMOtYvr62IiU4uC6HqU6qMPzoM4qGpsHqZXj6zDFkEV162M+rU/uj9foVACgYgqoEV7RDVSGtcsUfvG2z76axwCMecjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iREQAb78; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iREQAb78"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778617271; x=1810153271;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=s2rj61DpAPI76iq1R9DkUD3MAI6ETO5bD9dTXZ3Wyf0=;
  b=iREQAb78NHI3PBBS6MWJ4HJWZqImrIVb+ka+QC12WcZLj1njvHVdBUrP
   eheAKsJot5zkgmlNUB7fdhgE8GMZ3r8CLbjXJU9Pz5QplwL732B4zip76
   ZIVB9A3iPmWKz3iKSCh/+vUL5wOf2s5ogHHVZVQ+xeHS/HEwCSTqa091J
   uvaAlbt29P8gdcAAaI4ev4DqZhDb3V05k/D9ygUb4OKM3on4tazCn8iZQ
   zW6o6Gc4WzC2Q7N7YVDtHy07orARoBXZRcFRyGmjIv0RuzmZxWdUoIBrr
   cUcLh6HPhXO7m6C2xk71sIeSzEx6IzHPvJTGkeTNl1DgzDsRxOEvVD5AX
   Q==;
X-CSE-ConnectionGUID: Phzq/CZASRmOm4KRNS5YkA==
X-CSE-MsgGUID: 51L8o5s6TV2/LR5TlGiupA==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="78681444"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="78681444"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 13:21:10 -0700
X-CSE-ConnectionGUID: KZKQZcKDRLyfnPxPqRD3Kg==
X-CSE-MsgGUID: yWKLqMOnSlayhGbdAIYreg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="237959991"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.244])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 13:21:09 -0700
Date: Tue, 12 May 2026 23:21:06 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?iso-8859-1?Q?Nat=E1lia_Salvino_Andr=E9?= <natalia.andre@ime.usp.br>,
	andy@kernel.org, dlechner@baylibre.com, jikos@kernel.org,
	nuno.sa@analog.com, srinivas.pandruvada@linux.intel.com,
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v3 0/6] iio: hid-sensor: standardize scan_type
 initialization
Message-ID: <agOLsmc89ADvSxFG@ashevche-desk.local>
References: <20260512012302.20883-1-natalia.andre@ime.usp.br>
 <20260512154204.0052b352@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260512154204.0052b352@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 12, 2026 at 03:42:04PM +0100, Jonathan Cameron wrote:
> On Mon, 11 May 2026 22:16:16 -0300
> Natália Salvino André <natalia.andre@ime.usp.br> wrote:
> 
> > This series refactors the HID sensor drivers to standardize the
> > initialization of the iio_chan_spec scan_type structure.
> > Direct initialization using compound literals was used.
> > 
> > This change improves code readability and ensures that all fields
> > of the scan_type structure are properly zero-initialized.
> > Additionally, for the hid-sensor-accel-3d driver, the channel
> > initialization loop was refactored to iterate directly over the
> > scan indices, eliminating redundant logic.

> I'm a little confused.  How is this v3?  Where is the change log?
> 
> I'll review it as a fresh series.

I remember seeing this series at least twice, so changelog is missing for sure.

-- 
With Best Regards,
Andy Shevchenko



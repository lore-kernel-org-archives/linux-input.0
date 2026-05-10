Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7582628D;
	Sun, 10 May 2026 06:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778395111; cv=none; b=bhX/vt0R2k9uzyRC6FCIxrWU/+4AgrHFXvC8yhK/H8bWQaay8DjkS85aLZvbGBPVzEMjt2rJ8t5YRyq0A0B4HXNoINOyHq3EruH6dbDvF1lqIwCsiQy2f9Z4TaXDO8SUfOELU4ni+NlrkqoxDcAOABirl5CbFZwXoRQLdfWk91k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778395111; c=relaxed/simple;
	bh=4zhMnMH1GSzGc+u/hZfcX+Iyl+NYPIJ8s6TMOTw2/Jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5iEbTHQXBUzCJhniSLQDJBc3krEgyJg/GHw+LFn+INy/+Y/clL4kvuk8JcAN4iXhMiHMyLXkiMzN/2yLblzuMH+bEId8nIaUwG+49V5Ht1DEerVbUf1guNsfwpgcmAjHc+Hr1o8TSodlX9gKWVv38rcgAysV61vdg5Z5j1ybkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AawMwxLO; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AawMwxLO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778395111; x=1809931111;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4zhMnMH1GSzGc+u/hZfcX+Iyl+NYPIJ8s6TMOTw2/Jg=;
  b=AawMwxLOKc1IsgKc1DhNhlPCcFZg4J4mvAmZWjgp6q4Lgo/c2Dh9vSdt
   MNH9SuRubMchwnatPo4Irw8Zjbx6NPgaUS/iz+gW4Bn5sawhh9BMZXCQ2
   G9urpPdEHSAu2ssFN3l64j446suZiY4NoqXLpCWZfgfWKZ4C3B9wZ/Os2
   LfFDJerWT+kWU9Y0loapOPjqGU/3P+POysPf4Bq5nazh2sHO0cMMVlCrP
   Fz3nxkovquyUNZq57ab+7usIX/P/Ltgt+SOTadI6P3Wh42pnlgwE8Y2De
   cvtJeOG06R4g7doDC6xrir8kPcStgvIQYadd+uNwpLXbm59qaTJVmMYFa
   Q==;
X-CSE-ConnectionGUID: mPXCp2hGRu+WsCdsj1B/AA==
X-CSE-MsgGUID: 81dC8s6aRZ6hjVwoKLFfBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11781"; a="79303392"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="79303392"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 23:38:30 -0700
X-CSE-ConnectionGUID: kdrHoVJSRZKM1rQUBiEheg==
X-CSE-MsgGUID: FCo3PiDgQxuN+PqR9kdJsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="234496786"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.171])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 23:38:27 -0700
Date: Sun, 10 May 2026 09:38:25 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jikos@kernel.org, jic23@kernel.org, srinivas.pandruvada@linux.intel.com,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	sakari.ailus@linux.intel.com, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/9] iio: gyro: hid-sensor-gyro-3d: cleanup codestyle
 warning
Message-ID: <agAn4UQjYRw_unMu@ashevche-desk.local>
References: <20260509101040.791404-1-sanjayembedded@gmail.com>
 <20260509101040.791404-5-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260509101040.791404-5-sanjayembedded@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, May 09, 2026 at 03:40:35PM +0530, Sanjay Chitroda wrote:

> Reported by checkpatch:
> FILE: drivers/iio/gyro/hid-sensor-gyro-3d.c
> 
> WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> +                               unsigned usage_id,

Use the type that is in the respective prototypes.

Also note, there was a patch doing exactly that. Find it in the mailing lists
and ask author if you can take it or what the status of affairs is.

-- 
With Best Regards,
Andy Shevchenko



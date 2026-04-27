Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1624C3B2FDF;
	Mon, 27 Apr 2026 09:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777282733; cv=none; b=hnSr3wW/D1uubfs5W8oni49g0ra1O1iZHo+mg1qMe6Psx+KXH5vk64z4x5Y1W2NoRzM3LtDZJHGFOiswm8D1d3isTwBMwHnUnsVWKhiOsvxtIKHcRm7II0gB/npcYrSXaEOLmT/s4GauEkcZMmUJ2QYcbXyTdADHG7oN39vF93E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777282733; c=relaxed/simple;
	bh=Cp7e6qSrX4wi5ufxgQsRMI1WkYYX2m2ipgsbvjfqjPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQL/4gMFSuU0NBl8z/gHofAM/upuGANUFZi49kXA3ywDe7RaLWoz5vpLtFTnOXpdn105/xU02g+Q90Tb8tZzS4FBmhdSjELq0lT4H0ptKfNlWGzD+SY61sYQ92DB0cAn2pFRXzo21RwYCmw4Z5kU1JWXfgW0trGdmvtTpJSznR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=am+Lq7rx; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="am+Lq7rx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777282732; x=1808818732;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Cp7e6qSrX4wi5ufxgQsRMI1WkYYX2m2ipgsbvjfqjPA=;
  b=am+Lq7rxcGQXgFOyuznXr+gjZ/bgeddKpvzPTnONs/ruuS9Hwpws4pvB
   NBf7P9OqmDwMwPmlpYVmrTP2td8xx2Io8wsGnnI9Bx62NCYbijIr2J4YG
   4nptaP74HeH4RhMi+jVaHgfjamw1NF0aETsrw69ONJ2JlJhWhdySCImA9
   rncF8wvbuqK41Tp/mBRUsNP2HJUiqTZ1opRJ9B/qWQJDPkJxQTb1PicAw
   FBY459tggGHb/XetfwfmptljgeqiYetWN31kena4Wvs28xDEnvCbGc24g
   fE0hoLAKGnC3Ztp8e2eJD6vdoIvIikfOKd972POlz0/sWUEF08zfYvjoj
   A==;
X-CSE-ConnectionGUID: 8LAWbA5GQ2ahFbvyt+0fdg==
X-CSE-MsgGUID: yJIzI/FJRxCSy96dUP/zZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="89628811"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="89628811"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 02:38:52 -0700
X-CSE-ConnectionGUID: nuot05xTTpin3WYueyBQ6g==
X-CSE-MsgGUID: J/bYUojDT8+jaWAk6y1PYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="256896939"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 02:38:46 -0700
Date: Mon, 27 Apr 2026 12:38:44 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?iso-8859-1?Q?Nat=E1lia_Salvino_Andr=E9?= <natalia.andre@ime.usp.br>,
	andy@kernel.org, bentiss@kernel.org, dlechner@baylibre.com,
	jikos@kernel.org, nuno.sa@analog.com,
	srinivas.pandruvada@linux.intel.com,
	Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>,
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v2 2/7] iio: accel: HID: Replace method
 accel_3d_adjust_channel_bit_mask()
Message-ID: <ae8upGN9ILmtCzeA@ashevche-desk.local>
References: <20260421222210.16016-1-natalia.andre@ime.usp.br>
 <20260421222210.16016-3-natalia.andre@ime.usp.br>
 <aeiPuxj2TRLNRbv1@ashevche-desk.local>
 <20260424200847.78494f27@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260424200847.78494f27@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Apr 24, 2026 at 08:08:47PM +0100, Jonathan Cameron wrote:
> On Wed, 22 Apr 2026 12:07:07 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Tue, Apr 21, 2026 at 07:20:34PM -0300, Natália Salvino André wrote:

...

> > > -		accel_3d_adjust_channel_bit_mask(channels,
> > > -				CHANNEL_SCAN_INDEX_X + i,
> > > -				st->accel[CHANNEL_SCAN_INDEX_X + i].size);
> > > +		hid_sensor_adjust_channel_bit_mask(channels,
> > > +			CHANNEL_SCAN_INDEX_X + i,
> > > +			st->accel[CHANNEL_SCAN_INDEX_X + i].size);  
> > 
> > Indentation is broken. Taking into account that the last line is too long when
> > properly indented, perhaps
> > 
> > 		hid_sensor_adjust_channel_bit_mask(channels,
> > 				CHANNEL_SCAN_INDEX_X + i,
> > 				st->accel[CHANNEL_SCAN_INDEX_X + i].size);
> > 
> > Which makes it most right and under 80 limit.

> Why the double tab? Maybe just go long on this one and align after the (

I never know when you are strict about 80 limit :-)


-- 
With Best Regards,
Andy Shevchenko



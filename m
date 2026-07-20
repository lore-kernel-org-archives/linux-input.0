Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6DF47DD40;
	Mon, 20 Jul 2026 19:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576122; cv=none; b=uPgRacMbo4rSu9D4RdYnfHHd9I9wnm824L89ErvI1HHGr+9A4RU1bJlHT2kjPTNigb5qsgLgbCW5SKiEn2QVPRrLdC13B8ZrTyp4yqBV3rsZUHgwyJYpAOFJCoZd05ubv/FNC+xYMbreYTT3nhIBrk4UW+AuAnRvJvnfXWd3Xr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576122; c=relaxed/simple;
	bh=5NLVdoLJdU/hCpGfjZnuWbVoyyc0VwafE53K3sxQk4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ehUjMCR6UeV9X44G4ArKVU5QK8aXjUXjKJ0uBchNHc6FPTpFmWYh0lbFRkkifcPsRg3/qU2dMRiUdKSSNnro0UaCfuW9iJUxRlhllZDuMbfDl5nBXfrnqS2J9ABudNX6lLEesozARVEJeotCCj7lscteAO+wYAnKRFTm/EZ/aS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ClPYcbAf; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ClPYcbAf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784576119; x=1816112119;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=5NLVdoLJdU/hCpGfjZnuWbVoyyc0VwafE53K3sxQk4U=;
  b=ClPYcbAfgBwSmzIeCHd6xyJ0IEYTp5THito1i81OoZibLyZunbWTxIMC
   GOJ+cLhBPhw8+QimhmFJNFqReyjcugN0PBf9YUNEb6XA6Ei9CnhkJ6zbs
   Bl6v/70dyjOX2cY90N3yardXR10Hfh6zWt02zvPsRCHPOnjwRCxOv3ZaN
   qULPMYiT9tUMricBfsIG+xzAp85Jg5VqrY4npIA0mvSftlb4Oq2JlDSZ6
   cgYnmoUt9OJlihwHzM3XXGZJ12F+HhFL643QHtaFye+yzYkuia/iV3JKl
   Y6BbsudxG6reaNC8hObS2eJKpEb5nZcGncaFvDevNLBi/gBPu/nFprHEY
   w==;
X-CSE-ConnectionGUID: Ms8hxswKRJeoZ86X6ZIYQA==
X-CSE-MsgGUID: VpD5KgzXR2eyp8cV/Peq6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="95530549"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="95530549"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 12:35:16 -0700
X-CSE-ConnectionGUID: dzOYpiqZRoumUj/qJD8M9w==
X-CSE-MsgGUID: cKRoHGRVQXCWGZW417LvjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="258183519"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.175])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 12:35:14 -0700
Date: Mon, 20 Jul 2026 22:35:11 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] iio: gyro: hid-sensor-gyro-3d: use local struct
 device
Message-ID: <al54b953O6JXcbU6@ashevche-desk.local>
References: <20260720-hid-iio-local-struct-device-v1-0-74496fee6327@gmail.com>
 <20260720-hid-iio-local-struct-device-v1-2-74496fee6327@gmail.com>
 <al4MeTgAWWkJsb1T@ashevche-desk.local>
 <1E009860-0A0F-4F8D-8017-CE5739F22144@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1E009860-0A0F-4F8D-8017-CE5739F22144@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 20, 2026 at 10:20:28PM +0530, Sanjay Chitroda wrote:
> On 20 July 2026 5:24:33 pm IST, Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> >On Mon, Jul 20, 2026 at 03:10:14PM +0530, Sanjay Chitroda via B4 Relay wrote:

...

> >> -		dev_err(&pdev->dev, "failed to setup common attributes\n");
> >> +		dev_err(dev, "failed to setup common attributes\n");
> >>  		return ret;
> >
> >Nope, First one (to eliminate a lot of churn) should be to convert this and
> >similar to use
> >
> >		return dev_err_probe(...);
> 
> Thank you for your input.
> 
> I'm planning to have a incremental series: first introduce a local "dev"
> pointer, then convert the resource management to "devm_*", and finally
> replace the remaining error reporting with "dev_err_probe()".
> 
> This keeps each series focused and avoids introducing intermediate patterns such as:
> 
>    ret = dev_err_probe(dev, ret, ...);
>    goto error;
> 
> Once the cleanup paths are removed, those sites naturally become:
> 
>    return dev_err_probe(dev, ret, ...);
> 
> Does this approach sound reasonable?


No. First you should drop the dead code for sure (see above).
Second, try to convert to dev_err_probe() as many drivers as you can without an
intermediate change. If the driver requires an intermediate thing like the above
it means it requires bigger refactoring. So, you should not have intermediate
churn. With your current approach there are drivers that will have it, and for
them you need to have different strategy (see my proposal in the above lines).

-- 
With Best Regards,
Andy Shevchenko



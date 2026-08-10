Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9763A4F30;
	Mon, 10 Aug 2026 09:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786353123; cv=none; b=NNn9Rq9rX4cmxRcPKIx4Y299/mhmy6r7LzVWn+w0DvnfJeSYNV842KFConBtmHdIPpqVlDrYkSmM5q3TqRuuKrEddVRtZ1+/jLeje9Xxjn92XTW+d5/5zPtxr5XwNcHT+VMFEtMTLPHQSi4AlzAanuZqykBg2Hwn8xhftp0Ngxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786353123; c=relaxed/simple;
	bh=wB1WlKNB0e+Hd3mmjMUrAQQLQpQysiLiVLIr2FF4cqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LpB0wiFQAn7vbMoShX42v+M+mrbq5XIbXzdnGrpyBcCSLFNdQjUyRkCc+itcxXdR2rctMvNq+DWG9jqGXDFQyXw0+avy60wRqFp4G9M+cDwVyTABua64fpFXVb2ChdZMxtDXwyo6BoagAIev0GGLJkb/QXh49dgSUh/ZGVh7RmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bmpZgnj1; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bmpZgnj1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786353122; x=1817889122;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=wB1WlKNB0e+Hd3mmjMUrAQQLQpQysiLiVLIr2FF4cqg=;
  b=bmpZgnj1ebpKmt5x4jtPi+729vQ5OEjUE1UKuZODqdf1l85VomJy4vCe
   qJg3CLMu+L7Gfc/6rzU5X1mcqbHxmwYuUY1WAm2Ceqt07JKeMIVrnmJVj
   qU8nORXTe02Z1NYPEbdqKnFYXN75in1UbrK1+mcTI4UJTpjRpG38HmK2A
   7RyrL6SrXmVvG3I8fTPADujuI/w1vIPrgIi0RE6B1xC7/sayEMBZeymYy
   5EhrUzcQNn15LvGJMj1rG+eXDfP3aA+IyPK20GP10F51nbgkazYJBtt3F
   vPbqZ6bCSNOBGlhUX79FreB0rh8nramLNOubcrfVlUS3sSp6lbPRzqMxZ
   Q==;
X-CSE-ConnectionGUID: bDRqmvVuRHig+VfHqvn8QA==
X-CSE-MsgGUID: 6Qy9VgpTR0Wy1eJy/p4Ggw==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="98012237"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="98012237"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 02:11:40 -0700
X-CSE-ConnectionGUID: m2wuEXZdRFKpDyxYknJDTA==
X-CSE-MsgGUID: 5yKGuPpuQqiKihNAB4boaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="259127154"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.99])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 02:11:32 -0700
Date: Mon, 10 Aug 2026 12:11:30 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: Eliav Farber <farbere@amazon.com>, rafael@kernel.org,
	tony.luck@intel.com, bp@alien8.de, guohanjun@huawei.com,
	mchehab@kernel.org, xueshuai@linux.alibaba.com, lenb@kernel.org,
	laurent.pinchart@ideasonboard.com, linusw@kernel.org,
	brgl@kernel.org, orsonzhai@gmail.com, baolin.wang@linux.alibaba.com,
	zhang.lyra@gmail.com, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, dmitry.torokhov@gmail.com,
	hansg@kernel.org, ilpo.jarvinen@linux.intel.com, W_Armin@gmx.de,
	fabio.m.de.francesco@linux.intel.com, kaihengf@nvidia.com,
	ankita@nvidia.com, leitao@debian.org, pedro.pbg@usp.br,
	paulmck@kernel.org, frederic@kernel.org, kees@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v4 01/13] notifier: add device-managed registration APIs
Message-ID: <anmVwiYW6fT7XhD2@ashevche-desk.local>
References: <20260726101739.33170-1-farbere@amazon.com>
 <20260726101739.33170-2-farbere@amazon.com>
 <anlUQXtxrghA8kNT@monoceros>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <anlUQXtxrghA8kNT@monoceros>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 10, 2026 at 06:37:25AM +0200, Uwe Kleine-König wrote:
> On Sun, Jul 26, 2026 at 10:17:27AM +0000, Eliav Farber wrote:

...

> > +{
> > +	struct atomic_notifier_chain_devres *dr;
> > +	int ret;
> > +
> > +	dr = devres_alloc(devm_atomic_notifier_chain_unregister,
> > +			  sizeof(*dr), GFP_KERNEL);
> > +	if (!dr)
> > +		return -ENOMEM;
> > +
> > +	ret = atomic_notifier_chain_register(nh, n);
> > +	if (ret) {
> > +		devres_free(dr);
> > +		return ret;
> > +	}
> > +
> > +	dr->nh = nh;
> > +	dr->nb = n;
> > +	devres_add(dev, dr);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(devm_atomic_notifier_chain_register);
> 
> IMHO devm_atomic_notifier_chain_register() should look as follows:
> 
> 	ret = atomic_notifier_chain_register(nh, n);
> 	if (ret)
> 		return ret;
> 
> 	return devm_add_action_or_reset(dev, devm_atomic_notifier_chain_unregister, dr)
> 
> which is much easier and includes less details from the inner workings
> of devm. Same for the blocking variant.

Won't work. We need more than one parameter and hence the whole devres_alloc().
Please, look closer to the code.

-- 
With Best Regards,
Andy Shevchenko



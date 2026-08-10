Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DBE3A4F30;
	Mon, 10 Aug 2026 09:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786353173; cv=none; b=sQBjk89j5JUiQblNWNilI3w9FlyWA7igykDDhK6i3TkSZXfrI2r9rtLOt36iMHRtt/brJ6jVLq3XM9yXXDSq31PF1GNo0SAZg+BgefwcJVlRpvJ8pz0OAl75VN7D/AX7bkbzBlsWfNWEJWeDFm0jVTsZ3Hyf0IxiFNJO43OwXvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786353173; c=relaxed/simple;
	bh=KbyP52yX1Fc5M0iYUxcfXNkbcaU95W0GezyjeE8qj58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGZbyJQxYzfgF347c6N/W7wRX7mCZXB/CudFQ9IJLXnqvZCu0F8c3UX9VC1q/hEFxOh4rI+jxSjh9oK56rwSdk2CgQb/Vt3Lgquq9Awsra0yuyWETLnr3sNwu9nWmoIjnGJSRKdNLIQHK00bE3klYmtOfLJ2xzf/a2jS27xW6Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EMMTWoPQ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EMMTWoPQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786353172; x=1817889172;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=KbyP52yX1Fc5M0iYUxcfXNkbcaU95W0GezyjeE8qj58=;
  b=EMMTWoPQsE3KlcM0nNk7HkvGyjk/bolUF9qke3QUPk9P3U+vkLI6u3ky
   yLHgaE1V2BlfZKp67bPztIBXDdu5nhMrVxTSEA5e40Ee+dgq74V8rUM/u
   jhLgxpH//3E7hM78HdG7GZvbxzg5eFH4cxujci9LSyWveve/tJ8HIMCXI
   8aMQSglKejJYxQJnq1AgiOi0W4oVM3lwEPFMXxknzgHrdeWrXOLmgsLlA
   HMgcVvBpt05qsVMWI6B5JjktZKtOuFWCp/a0t3rzrQFK9AJHsuMXAo0AK
   SOKoq7PlKjM9e7hYCKYbOq3pRWKODSSrQ0e5RifQNv3bzOOusNiE1yetQ
   g==;
X-CSE-ConnectionGUID: WlFaw+YYS0ygSmEGGGJdJw==
X-CSE-MsgGUID: TmsmZ3B3ReScbkx7sIAcag==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="90540087"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="90540087"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 02:12:51 -0700
X-CSE-ConnectionGUID: Zap65IgfRyao47/XSMPIRA==
X-CSE-MsgGUID: 2mcW99ImTKyDObLUkRAsdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="287692937"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.99])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 02:12:44 -0700
Date: Mon, 10 Aug 2026 12:12:41 +0300
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
Message-ID: <anmWCWT_p8sIMwyf@ashevche-desk.local>
References: <20260726101739.33170-1-farbere@amazon.com>
 <20260726101739.33170-2-farbere@amazon.com>
 <anlUQXtxrghA8kNT@monoceros>
 <anmVwiYW6fT7XhD2@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <anmVwiYW6fT7XhD2@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 10, 2026 at 12:11:40PM +0300, Andy Shevchenko wrote:
> On Mon, Aug 10, 2026 at 06:37:25AM +0200, Uwe Kleine-König wrote:
> > On Sun, Jul 26, 2026 at 10:17:27AM +0000, Eliav Farber wrote:

...

> > > +{
> > > +	struct atomic_notifier_chain_devres *dr;
> > > +	int ret;
> > > +
> > > +	dr = devres_alloc(devm_atomic_notifier_chain_unregister,
> > > +			  sizeof(*dr), GFP_KERNEL);
> > > +	if (!dr)
> > > +		return -ENOMEM;
> > > +
> > > +	ret = atomic_notifier_chain_register(nh, n);
> > > +	if (ret) {
> > > +		devres_free(dr);
> > > +		return ret;
> > > +	}
> > > +
> > > +	dr->nh = nh;
> > > +	dr->nb = n;
> > > +	devres_add(dev, dr);
> > > +
> > > +	return 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(devm_atomic_notifier_chain_register);
> > 
> > IMHO devm_atomic_notifier_chain_register() should look as follows:
> > 
> > 	ret = atomic_notifier_chain_register(nh, n);
> > 	if (ret)
> > 		return ret;
> > 
> > 	return devm_add_action_or_reset(dev, devm_atomic_notifier_chain_unregister, dr)
> > 
> > which is much easier and includes less details from the inner workings
> > of devm. Same for the blocking variant.
> 
> Won't work. We need more than one parameter and hence the whole devres_alloc().
> Please, look closer to the code.

And just answering ahead, no, devm_kmalloc() is not good bandaid as it makes code
not anyhow better to read and have a downside of memory fragmentation.

-- 
With Best Regards,
Andy Shevchenko



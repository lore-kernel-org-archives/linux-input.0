Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375F31F099C;
	Tue, 20 Jan 2026 21:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768943355; cv=none; b=hq5qbrWuB8fy0KH/DaUYfLeqGtJuKA6sJxXHIf3V1cHGauFNReGrp3m4WXP6QhSL/yp5eCKkr+8898dAfQIWWBzTjNDjyfcWfXn3cFRAZoZbJcljotkpHQspTQtqHxYxumuXHjOvXAeZBX54B195EgecL7rDmtbMfy30K194ssA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768943355; c=relaxed/simple;
	bh=jyriptaC8gOLcx6ewfhvEsKvb8HNY0FUsxEfwMLnPh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bTjZlwW1NOYJ+uKdmPR5wip7N6eC2Yu6gj7AZXI/Ah6+PqmiHfDVtUtOvfW0xJhIa5Pl6XnaDwOecuDO/r51gOmjCBlJ7VobDD3ifGIZ24V7Qv+Ucfjw2p+/fdeZHR3p2xXHxgQF5Ol1ItvRUROMW/Cl7Sv8RWk9abW8ozRWTmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i3T0FjVJ; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i3T0FjVJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768943354; x=1800479354;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jyriptaC8gOLcx6ewfhvEsKvb8HNY0FUsxEfwMLnPh4=;
  b=i3T0FjVJZiOlEiRiNEKtUnpzMsD43O5uqbacrPe1v6qwuEu0y5btQRts
   6Z16hGl3SB9gXeMvs6INM3OteMtnXokbKSLVyFFQTP2kVsmOAGOI8+sx2
   pzHS19zyp2IU/wxBol2v4ZAjOZzrnk0NNnQuePMPOVSIBLcDKzazmi3qO
   iD5/m0TB036u6zpKma38XxZR23dMlnIJRyEF85qQY/4zmzSb/hU/gdjqN
   qAOKl93KiJ0OE440jXhvB7mYxXQ5UftlrjhicctNAa3AD0b6/ewc+QMCe
   0WZeX1Z0G8BVzUXnWa3be5rJIYxitNl+ZJlyrRlYXPHsFaMyR/bBy+oW+
   Q==;
X-CSE-ConnectionGUID: CIs9Akc4SkapUl/xx8W3Rw==
X-CSE-MsgGUID: FWtZc2fKQPuT7cT7p6jQRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="69896419"
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="69896419"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 13:09:13 -0800
X-CSE-ConnectionGUID: 9+mhSUBISoyEMUBrqDNLnA==
X-CSE-MsgGUID: TJVh9teYR9OuBjwffFZvgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="243801524"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.240])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 13:09:11 -0800
Date: Tue, 20 Jan 2026 23:09:09 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] Input: wdt87xx_i2c - switch to use dev_err_probe()
Message-ID: <aW_u9QUfzE23zoE_@smile.fi.intel.com>
References: <20260113082445.44186-1-andriy.shevchenko@linux.intel.com>
 <20260113082445.44186-3-andriy.shevchenko@linux.intel.com>
 <u5nsup2neifb2k3ujtxtcnwzs76ieqdwjr2o45eu5uhwwo3dhw@cjyxn43etrzm>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <u5nsup2neifb2k3ujtxtcnwzs76ieqdwjr2o45eu5uhwwo3dhw@cjyxn43etrzm>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jan 20, 2026 at 12:40:25PM -0800, Dmitry Torokhov wrote:
> On Tue, Jan 13, 2026 at 09:22:58AM +0100, Andy Shevchenko wrote:

...

> > +	struct device *dev = &client->dev;
> 
> You introduced a tempo but used it in only one place. I dropped it.

Yes, to avoid churn on converting unrelated places right now. But it may help
in the future.

...

> > -	error = devm_request_threaded_irq(&client->dev, client->irq,
> > -					  NULL, wdt87xx_ts_interrupt,
> > -					  IRQF_ONESHOT,
> > -					  client->name, wdt);
> > -	if (error) {
> > -		dev_err(&client->dev, "request irq failed: %d\n", error);
> > -		return error;
> > -	}
> > -
> > -	return 0;
> > +	return devm_request_threaded_irq(dev, client->irq,
> > +					 NULL, wdt87xx_ts_interrupt,
> > +					 IRQF_ONESHOT, client->name, wdt);
> 
> My preference is to keep "if (error) return error;" even for the last
> call when there are multiple potential points of failure in the
> function, adjusted.

Okay, no problem.

> Applied the updated patch.

Thanks!

-- 
With Best Regards,
Andy Shevchenko



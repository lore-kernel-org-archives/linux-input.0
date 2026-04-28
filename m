Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62414311967;
	Tue, 28 Apr 2026 08:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777364574; cv=none; b=hgucx9u6K4ADxqpyCkqQQFirY2C2IbkK581dx2iriWkWHv3UHVEDvdGKD3Q29xyvqp6ooocZh5yRf7YnYXMRO8hjrcG2ZtRICixPLEWzXlglYdQgw++FQL1Tr6Bi2eqW+gCAM96SN8ukAqY5IFTcVSymwZZFwKYAqfWd9zfBe9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777364574; c=relaxed/simple;
	bh=9xVG2NPhgmOcCcdq6C1CP9H1yHZANHSseKA4ni8v3fY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PtrbdCFGgiKu+Og+ca2tq3crtU8QUiDNU2JYFarY3DW42FROVxA6Dcj2VRL4xW4K1L82Htqcod1VdkLPLp24qY4AV7XM4IeqdDjBOeV2QpJZC8Z8IIwci/V09L4R6tbALIDfwr19gnbll1Y8GEmUutSQZAHOqov8Fev+1JT9orc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fIK7UzXj; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fIK7UzXj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777364573; x=1808900573;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9xVG2NPhgmOcCcdq6C1CP9H1yHZANHSseKA4ni8v3fY=;
  b=fIK7UzXjR3URQM9jBc6G4O1ZZ7hG3dAEx8zVnWMvawJUA1A316wSaFKA
   /m+qgXHNRvqNcxZgWMAGHNVc5wCzEMVIllJfGFWe+lBMRJNVh1vp923AW
   8y16MwTaDnCZbaJK/YrDsALGmf1yL++Z3xeJ2MG7wkySLvUl0k+3p8/pv
   r9E2P29t0lngL6AOgkhFgmp9PounCnShTfeEHiWOI2zEjXG8P/p766E5f
   sAXmAqF6qy70TSrGAkwxowjD2JwTXu/e87mpEGJkka+nRRxIbuZ14mob9
   jg7sHX2rmnKnV9hcphiwhxWU4KuBBS6XnDRIYesC/7e6k10f+oJOJOenh
   Q==;
X-CSE-ConnectionGUID: X9dy2cbaT9u4cM3QxbPMHA==
X-CSE-MsgGUID: flKQ9GOARou7EcF94dEJlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="78144836"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="78144836"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 01:22:52 -0700
X-CSE-ConnectionGUID: UV+NulQgRsa6SqkKbCT5zw==
X-CSE-MsgGUID: SHrOZbnQTB2yQiKKrTFXMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="231243664"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.213])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 01:22:50 -0700
Date: Tue, 28 Apr 2026 11:22:48 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jikos@kernel.org, jic23@kernel.org, srinivas.pandruvada@linux.intel.com,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	sakari.ailus@linux.intel.com, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] iio: orientation: adapt to
 hid_sensor_remove_trigger() API change
Message-ID: <afBuWAElmx7t7FcB@ashevche-desk.local>
References: <20260428071613.1134053-1-sanjayembedded@gmail.com>
 <20260428071613.1134053-3-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428071613.1134053-3-sanjayembedded@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 28, 2026 at 12:46:05PM +0530, Sanjay Chitroda wrote:

> Update the driver to match the updated hid_sensor_remove_trigger()
> prototype, which no longer requires struct iio_dev.

You haven't compiled the previous patch, right?
This is not the way how all this should be done.

Also NAK to the patch 1 as even unused parameter is there for the sake of
consistency. The prototype to allocate and other in the similar group all
have it.

-- 
With Best Regards,
Andy Shevchenko



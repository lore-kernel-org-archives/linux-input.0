Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4B634F48F;
	Sun, 10 May 2026 06:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778395017; cv=none; b=XLOpSZjKWJfo7NRFYv6azdH9P0M+1oLFOqhD2rLMQH0ZjnyTegoLfp48fN+Jkovp1uQeH7Mah3Sx7QLleusuTbhCNfVAilhATpnmGFSeAC4bl0xwX9/l1WFItDepSQHwkxC/LrFWi9nnGB0qZUjiBVxk91C7mLxNNcXJmV6J520=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778395017; c=relaxed/simple;
	bh=tP/+7Cn/qRh71QVtnjkemGxDTY7scoYRh5eAYpe3vTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mH1XujosbOSyFTrRO9M650hS2iZEM8OZ4IpbzMG7KHgrnK8DUmduie9XNBlvLhuP3bK5YSVluWOIMbZlDoES4JjU22ofGu0sr+aBI+VTS2hzlCXAssDBM9yxsfQWea2V6eXu7dzshUwumt5ApNXEr/gYthav5fwyQFRx7IK2VD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DX1ul8m1; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DX1ul8m1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778395016; x=1809931016;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tP/+7Cn/qRh71QVtnjkemGxDTY7scoYRh5eAYpe3vTI=;
  b=DX1ul8m1HzwFAjMXMkpgcJoZVc516LtAnNGOdZoDN7uYn5Ihv8hVbxEd
   RgRpqs5843a3Sj9fQrRra7tgtUFSX+o4GTGhZRL9nn27up1O+l5X/S796
   7sgB05lu6/Tcx/MWynaHVddu/lYTlm2dkF8DfLHewKvglZn1xRkVFcCko
   LosBh8l24n9EhlunWIBw1GmbhIwyOKancEtdghclXt9ZjSaRck2eMIkO3
   rhBEZPHus/WQ+VtJL+uTkBJHa1zfjk040lUlbMYkusgmZhPPJArs2dBQZ
   fSICRPWnwvv1ilsNP414S8t10yDdf5o7w+t1KX7vtiyizWyS7ek7X5Ls8
   g==;
X-CSE-ConnectionGUID: 8J8o8CWzTGKDW/EpWkI++A==
X-CSE-MsgGUID: 0SMiuwWoQtyxkemjh5VIUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11781"; a="79340700"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="79340700"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 23:36:55 -0700
X-CSE-ConnectionGUID: FdNnHhcEShG4bkhriIBGCA==
X-CSE-MsgGUID: uBIM/BhQQyKfZojlnW6uCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="237254665"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.171])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 23:36:52 -0700
Date: Sun, 10 May 2026 09:36:49 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jikos@kernel.org, jic23@kernel.org, srinivas.pandruvada@linux.intel.com,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	sakari.ailus@linux.intel.com, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/9] iio: hid-sensors: introduce device managed API
Message-ID: <agAngXqFb5L2--AN@ashevche-desk.local>
References: <20260509101040.791404-1-sanjayembedded@gmail.com>
 <20260509101040.791404-4-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260509101040.791404-4-sanjayembedded@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, May 09, 2026 at 03:40:34PM +0530, Sanjay Chitroda wrote:

> hid_sensor_setup_trigger() is common API used for the HID IIO drivers,
> prepare devm API devm_hid_sensor_setup_trigger() to acquire resource
> during setup and release using device managed framework during drivers
> fail, unbind or remove path.
> 
> Register action with devm_add_action_or_reset() to release resource with
> devres framework.

...

> +int devm_hid_sensor_setup_trigger(struct device *dev, struct iio_dev *indio_dev,
> +				  const char *name, struct hid_sensor_common *attrb)

At this point don't we have indio_dev->dev.parent == dev?

> +{
> +	int ret;
> +
> +	ret = hid_sensor_setup_trigger(indio_dev, name, attrb);
> +	if (ret)
> +		return ret;
> +
> +	return devm_add_action_or_reset(dev, hid_sensor_remove_trigger_action, attrb);
> +}

-- 
With Best Regards,
Andy Shevchenko



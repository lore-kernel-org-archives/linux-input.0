Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596B03B14B6;
	Sat,  8 Aug 2026 20:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786219818; cv=none; b=Xbv9ca7d/WBOdP8EbKNRiPA/4o6ofltgzIjlfg+3W/nSpoh7mxOE3g5R392KWUsgwQwvN6Sq82G1wutgZ3Gd0eLMl+UdlyfA+mTUXHp7Unrp36WkdNukAuV5saPNUz635ljTD1TSOALCIkQEkDQmFfWs7rApW7yCkFPclUlhNfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786219818; c=relaxed/simple;
	bh=YyZ1w6DdQDXpeQEKgiF/HHllRQkv0UMKkuw4OVlch08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlZnAADbXLKpBtEvze6Vp3Jrbambak0AldHpu79snv1xX8X4L8d95VxdPmX6vi7tD2K+bhq6s4+gKgYCwDzKz5SmzVizgus5t2np8Ngh+c2x//q9eK+cRLvQQXhlTgUPrMSn338WwuSWYkfRxJuk5KZszMB2azQLhAQXYEia0H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NB/mckT9; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NB/mckT9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786219817; x=1817755817;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YyZ1w6DdQDXpeQEKgiF/HHllRQkv0UMKkuw4OVlch08=;
  b=NB/mckT98x6mw7iTsX46v9OtVdfdfpieb55S+AtTMBs0ZwBBxoVqqAqc
   5MMa3Eanrc9DS0GrQcWrWWJ3ZdcXg8ToiWsi78TZs3noFUEi8ZSix73Ss
   QmyhuJ4K1WerAz8qcfqH9znlYSOIM8PF9HmxwuE8roRrQsWMWfnFzfyS+
   QEROWRZjWz0ZMYL9zpD9mkpAk49YU+tnk/hpxvLr2CeCtYZUUy1MRqydx
   cKQiKnAPRGlx37ggSqAWrACWBHgUgcSKnpmrfKpbdazlOlbGzdKnp1XnR
   q31gIym1puWqvj7vKY+q83TiTOMlJELMOgRoVoYc9DNkgp4t8U8fUl/6C
   w==;
X-CSE-ConnectionGUID: udeu66l0Twy5gnLe8VbUag==
X-CSE-MsgGUID: L/syX5/KQF+zkFtHkhcWQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11869"; a="104186444"
X-IronPort-AV: E=Sophos;i="6.25,212,1779174000"; 
   d="scan'208";a="104186444"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2026 13:10:16 -0700
X-CSE-ConnectionGUID: qCaiY9rvTPapFYnfyQTe5w==
X-CSE-MsgGUID: pl5A6+GmRJWR3Ljx/lOTPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,212,1779174000"; 
   d="scan'208";a="286076280"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2026 13:10:13 -0700
Date: Sat, 8 Aug 2026 23:10:11 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: sanjayembeddedse@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Benjamin Tissoires <bentiss@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v5 03/13] HID: hid-sensor-hub: introduce device managed
 API
Message-ID: <aneNIxxRVuJDFgh0@ashevche-desk.local>
References: <20260806-28-apr-iio-redundant-argument-v5-temp-v5-0-f1f92c1d830f@gmail.com>
 <20260806-28-apr-iio-redundant-argument-v5-temp-v5-3-f1f92c1d830f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806-28-apr-iio-redundant-argument-v5-temp-v5-3-f1f92c1d830f@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 06, 2026 at 05:55:49PM +0530, Sanjay Chitroda via B4 Relay wrote:

> sensor_hub_register_callback() is common API used for the HID IIO drivers,
> prepare devm API devm_sensor_hub_register_callback() to acquire resource
> during setup and release using device managed framework during drivers
> fail, unbind or remove path.
> 
> store the required callback removal context (hsdev and usage_id) in a

Store

> dedicated struct sensor_hub_cb_devres, and register a devres action to
> handle to release resource with devres framework and helper API.

...

> +static void sensor_hub_remove_callback_helper(void *ptr)
> +{
> +	struct sensor_hub_cb_devres *res = ptr;
> +
> +	sensor_hub_remove_callback(res->hsdev, res->usage_id);
> +}
> +
> +int devm_sensor_hub_register_callback(struct device *dev,
> +				      struct hid_sensor_hub_device *hsdev,
> +				      u32 usage_id,
> +				      struct hid_sensor_hub_callbacks *usage_callback)
> +{
> +	struct sensor_hub_cb_devres *res;
> +	int ret;
> +
> +	ret = sensor_hub_register_callback(hsdev, usage_id, usage_callback);
> +	if (ret)
> +		return ret;
> +
> +	res = devm_kmalloc(dev, sizeof(*res), GFP_KERNEL);
> +	if (!res) {
> +		sensor_hub_remove_callback(hsdev, usage_id);
> +		return -ENOMEM;
> +	}

Why is this order? What's wrong with the memory allocation first?

> +	res->hsdev = hsdev;
> +	res->usage_id = usage_id;
> +
> +	return devm_add_action_or_reset(dev, sensor_hub_remove_callback_helper, res);
> +}

...

> +/**
> + * devm_sensor_hub_register_callback() - Managed register client callbacks
> + * @dev: Device for resource management
> + * @hsdev: Hub device instance
> + * @usage_id: Usage id of the client (e.g. 0x200076 for Gyro)
> + * @usage_callback: Callback function storage
> + *
> + * This is the devres (managed) version of sensor_hub_register_callback().
> + * The callback will be automatically unregistered when the device is detached.

Here, and everywhere else, validate kernel-doc. Here you introduced a new warning
(missing return section).

> + */

Also, why kernel-doc is here?! It should accompany the implementation, here is
a declaration.

> +int devm_sensor_hub_register_callback(struct device *dev,
> +				      struct hid_sensor_hub_device *hsdev,
> +				      u32 usage_id,
> +				      struct hid_sensor_hub_callbacks *usage_callback);

-- 
With Best Regards,
Andy Shevchenko



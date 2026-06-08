Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03AE3B9601;
	Mon,  8 Jun 2026 13:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780927139; cv=none; b=FQQqlYNVlXwpC9Z6BLto4m/HzjTsEhWNvZDazjybB/DcEWHLw3x7kimaPiwv16cAvTPXDAHdk6VQlxgY7QVPEOY/R7Z8WGEfBlleGC3C04znIN+HKWa/VohYE5TIm6Arj9DOfLi7EA/n1/lIxdqIQy0d02PWQfn1bBjufsnQO5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780927139; c=relaxed/simple;
	bh=vEMDmLdCNf21JHqw1u/XPb9zEdi8HFzp789J8sc2oCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UTOv4G1b2CFQ4y/l586lIm1stV+Jf94EW1kUlPSxn5zsctnmt5bCXV3uHbmKwtw0/SmdtbOXJPrRmEzSiyq8ZKfJy2Icxn5nYuV/Vrn9vZsmaOswxwZL0lKNpDE47L7MqxSPBEfIUcDIm1QA3mbAhM/DCyGqLZCTf28Kq+SuoIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VAQww+Bb; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VAQww+Bb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780927138; x=1812463138;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vEMDmLdCNf21JHqw1u/XPb9zEdi8HFzp789J8sc2oCE=;
  b=VAQww+BbsN8aSBXEJWJOy9uOWxZKoY0GcWUVbS+2jwmIVo0grK7W6OgH
   bxeOHNgg9X0Tttf/O6zHnFd4pHUqHfX9GIr0imiDHCw7fO3mrconHew+i
   mFOFU/Oy3k1MXDwnhGGLaH4tpELulm+RU6abxCg2fU/ULTyHow+QynLit
   H7XpzzTiQzRIkuS1cu+K0k1Mvb1wLp0vzk81a5H2s6hSQi60pP7KB1dah
   YJ9JejRgJ5YX3DigHV07+qCkHZ/m6RTZtFtcxUaNrrb5aZoBO90Ypi4q+
   Sqn4xVScxekGwHNmLrYacc1bdxMVd8kQeTVxKrbFpkndls+9LQv+B35jh
   Q==;
X-CSE-ConnectionGUID: Pi1/Ih2WSymgPDOvdvHmHQ==
X-CSE-MsgGUID: o7ZcX49WTEWRXM4LjT5l3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="80794317"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="80794317"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 06:58:57 -0700
X-CSE-ConnectionGUID: VhLod6i0R+eBGAgEsHpyKw==
X-CSE-MsgGUID: WyrYGqAeRhOypWlBd5gpWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="249480931"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.110])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 06:58:54 -0700
Date: Mon, 8 Jun 2026 16:58:51 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] iio: gyro: hid-sensor-gyro-3d: use u32 instead of
 unsigned
Message-ID: <aibKmxPDM8-qhCk2@ashevche-desk.local>
References: <20260606-6-june-hid-iio-correct-usage-id-v1-0-dd4a6820b674@gmail.com>
 <20260606-6-june-hid-iio-correct-usage-id-v1-1-dd4a6820b674@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606-6-june-hid-iio-correct-usage-id-v1-1-dd4a6820b674@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Jun 06, 2026 at 05:47:42PM +0530, Sanjay Chitroda wrote:

> Prefer 'u32' instead of bare 'unsigned' variable to improve code
> clarity and consistency with kernel style.

...


>  /* Callback handler to send event after all samples are received and captured */
>  static int gyro_3d_proc_event(struct hid_sensor_hub_device *hsdev,
> -				unsigned usage_id,
> +				u32 usage_id,
>  				void *priv)

It still has an indentation issue and I dunno if it's okay to solve at the same
time. Jonathan?

...

>  static int gyro_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
> -				unsigned usage_id,
> +				u32 usage_id,
>  				size_t raw_len, char *raw_data,
>  				void *priv)

Ditto.

...

>  static int gyro_3d_parse_report(struct platform_device *pdev,
>  				struct hid_sensor_hub_device *hsdev,
>  				struct iio_chan_spec *channels,
> -				unsigned usage_id,
> +				u32 usage_id,
>  				struct gyro_3d_state *st)

Ditto.

-- 
With Best Regards,
Andy Shevchenko



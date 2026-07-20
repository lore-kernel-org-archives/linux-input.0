Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435C440680B;
	Mon, 20 Jul 2026 11:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784548481; cv=none; b=D22C6OrKBtwc89lLqlEUh95X6Vr4HH2xUK7YzpHjMPMqdMpLZ0xKEnYA8DlcGgJ+NftqeB4aIK+q8qdo695uixPiV3NM8edOV0bJnQXJzsmCYAP9gqNRHft4TJVTL1wcMTd/KrkcjbglQ5Zmo8xyCCClZBgGqQwXMwVSbA8lSGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784548481; c=relaxed/simple;
	bh=mUJ8q/ntU1A/QPFWy2QySDcXE7m7R4uI/TLBDDYrydE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OFxc1oveAxZlHEMUxMciflc8cJoirM8PQXj6EyFSmvcQm3+/hL3E1Nvr6qv5FMh/wKw2rN4Gx2fiq9phoUGpXax0jm9WB6lLgp69Xj7RLx9u9TX92h0CBmn7KdMc6tvTwWgny80y2ywJvdljHsd8NHRQgJjmVbhU9musflT2zYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QrBNaHke; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QrBNaHke"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784548479; x=1816084479;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mUJ8q/ntU1A/QPFWy2QySDcXE7m7R4uI/TLBDDYrydE=;
  b=QrBNaHkeZg0ubV1m2mFuMLKDwBlUQbTF1eb8ENXXBbkuLzwQCkq9bs62
   pa0jmwIxMK9EDF9LJNYQ4beSjhPgSsYDA8HyoInWocNeJgMTsPrFOAx5V
   zBqea3qqO5p5BLDrmI2v5Ql3VnQ1XJGN7qmExcpIevkzO/Un7QFc70OWv
   ESQEXd8o6Uo9AcIjTUGlbtZH7opNlnFVyY6wiw73XWSuCV7xER4nyQWX5
   49xAby6EaBW8fOoPaPsnFxP0nsrHW8THl3EtZxNS98DVYvRDqS/bbGRAK
   sErsXG0SlpHi1w3giHwdAnxJ2iEQDlYToxGvlOtTD6G7d4zA0VL9UeM0p
   w==;
X-CSE-ConnectionGUID: yLtZSoNVRgyBgxacoe9weg==
X-CSE-MsgGUID: pvFGsaUsRT2bJkbkXLNedQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="85244620"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="85244620"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 04:54:38 -0700
X-CSE-ConnectionGUID: IN5Eo6dlTFiO4OeemJDiWQ==
X-CSE-MsgGUID: 7zylmj/gTceiRPRWwKEopA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="261000490"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.175])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 04:54:35 -0700
Date: Mon, 20 Jul 2026 14:54:33 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: sanjayembeddedse@gmail.com
Cc: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] iio: gyro: hid-sensor-gyro-3d: use local struct
 device
Message-ID: <al4MeTgAWWkJsb1T@ashevche-desk.local>
References: <20260720-hid-iio-local-struct-device-v1-0-74496fee6327@gmail.com>
 <20260720-hid-iio-local-struct-device-v1-2-74496fee6327@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720-hid-iio-local-struct-device-v1-2-74496fee6327@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 20, 2026 at 03:10:14PM +0530, Sanjay Chitroda via B4 Relay wrote:

> Introduce a local struct device pointer derived from &pdev->dev.
> This avoids repeated &pdev->dev usage and improves readability.

...

>  	if (ret) {
> -		dev_err(&pdev->dev, "failed to setup common attributes\n");
> +		dev_err(dev, "failed to setup common attributes\n");
>  		return ret;

Nope, First one (to eliminate a lot of churn) should be to convert this and
similar to use

		return dev_err_probe(...);

>  	}
>  
> -	indio_dev->channels = devm_kmemdup(&pdev->dev, gyro_3d_channels,
> +	indio_dev->channels = devm_kmemdup(dev, gyro_3d_channels,
>  					   sizeof(gyro_3d_channels), GFP_KERNEL);
>  	if (!indio_dev->channels) {
> -		dev_err(&pdev->dev, "failed to duplicate channels\n");
> +		dev_err(dev, "failed to duplicate channels\n");

And this kind of messages are dead code and must be just removed completely.

>  		return -ENOMEM;
>  	}

...

Please, revisit the whole series.

-- 
With Best Regards,
Andy Shevchenko



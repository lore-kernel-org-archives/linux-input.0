Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795777747;
	b=jvXLQeGkRvZLY1qPz1uLrwLBO/whlXRv4Tec7JqGSaZp9PtLq61pFtcmCxCg6X9fqpXo
	 5Z+yiNhYnScQf3UUv29hXhmT8u9Qsc/+gDESDy6PCycoRTI+/A81bCXSrYyL0w/+kUTwy
	 L7o99smHBy6saOHFipC/b/rI+DTkwMfkyMKL8/TfRfRyniPCkefc9FWJyQeWNfiMt6/HP
	 NajfBg+4Li6gzPIG/2I2Va+jq7Rn4Jlv8CkOBtrnEwv55lUFBCHo8whvRoBSFFxqoWaWm
	 Y3tJZ+6P+I/v3bEEImaW+rfygLWuKt37gxCpnpwNCZ0JY5Dl1xQcNZqUtKYLg2AyuNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795777747;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=QWQrWZSqsVK72t3F2YybUVFJXqGqffaUTRwEo5NpGRY=;
	b=sQX6bJladbtXHMnH2SW4n4zfcoQcGQ4A6oCgDhoPaz1qGiF0DgJbKbb7dfYuZNz9Rutn
	 xkc9K9XmPXwePSALHOwK1g+s3GzHf1iewouClfvxWLFumCXC76G+YIPg9oirza6cx85UI
	 L2MrTTTz6kXb7K2iEvnwmCJ8SNGAKOd/AG7tva0OYFWufZFeIUw1dZXLQ1k02AVydAqz9
	 56WabA6sB0m8QPTYE56WPGlRcel90oNRLS9dPOVcm+GC1E/1ALzomTspz4WDEmnPIf/7+
	 T5/rkGB9e89gZN9rFFAABntNSQfqjBq5EUs9qcB701mkmgVqPD119O9if4HzX2NZjrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UcgBRZAk;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9417D606A32A;
	Fri, 27 Nov 2026 11:09:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9417D606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UcgBRZAk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795777747; x=1827313747;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ktKVlkAVYIRLZkVlUsZsKpsQTE93/EMkxf8Vfar7JXU=;
  b=UcgBRZAkGVQFwk13UdtN6FlqthVSOhBRjnztWzonR1UB5dggXRD9jEY2
   hqaMcEXCIyMJi7pwvkSczQE89IyMLE7nMU3Zu4HqsDiY6KbxLoDfE5+3o
   vnOf935TGdFAKTYfElwTS57EQqp8GMeghaE15PZ+jN1XuVi2SOYEYbRLn
   Z/w2appWY+2UQZCnaAuexJaYGoJ4VrthgtrK2UddTMMWmqcWyKw8WVGSL
   dol+Y2CqMs32yvFZIr+/RXkF0oRNWIK2TdJpurLHg3mL1XA3JIjclAvFV
   rn2C7dXfRd14m7+yJql4K7e5fktxsmQBOor1FUxRmF5upGn7bsE0FGFTQ
   Q==;
X-CSE-ConnectionGUID: PrIvl6iaTgyawQ3eg3CTIw==
X-CSE-MsgGUID: hX3LQY2VSLi00iuUNQk31Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4544486"
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="4544486"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 03:09:06 -0800
X-CSE-ConnectionGUID: +jLDKlUfRHWHYIKSUTqp2A==
X-CSE-MsgGUID: cz8kT8clRMWHLr/PB+h77Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="14050738"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.115])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 03:09:04 -0800
Date: Fri, 27 Nov 2026 13:09:01 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: sanjayembeddedse@gmail.com
Cc: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] iio: magnetometer: hid-sensor-magn-3d: drop
 redundant probe error messages
Message-ID: <awlkzVRCTNaA4-gJ@ashevche-desk.local>
References: <20261127-19-oct-hid-iio-unified-print-framework-v2-0-3f476fe1a940@gmail.com>
 <20261127-19-oct-hid-iio-unified-print-framework-v2-3-3f476fe1a940@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261127-19-oct-hid-iio-unified-print-framework-v2-3-3f476fe1a940@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 27, 2026 at 04:03:58PM +0530, Sanjay Chitroda via B4 Relay wrote:
> 
> The probe path emits error messages for conditions where the failure is
> either already conveyed by the returned error code or can be identified
> from the existing debug messages in the magn_3d_parse_report().
> 
> Remove the redundant error messages to reduce log noise and simplify the
> error handling code.

...

> -	if (attr_count <= 0) {
> -		dev_err(&pdev->dev,
> -			"failed to find any supported usage attributes in report\n");
> +	if (attr_count <= 0)
>  		return  -EINVAL;
> -	}

What is the meaning of attr_count < 0 value? Does it hold the error code already?

...

> static int magn_3d_parse_report(struct platform_device *pdev,

> -	if (*chan_count <= 0) {
> -		dev_err(&pdev->dev,
> -			"failed to find any magnetic channels setup\n");
> +	if (*chan_count <= 0)
>  		return -EINVAL;
> -	}

Same question here.

-- 
With Best Regards,
Andy Shevchenko



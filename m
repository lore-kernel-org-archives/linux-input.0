Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFB63C199E;
	Wed, 22 Apr 2026 09:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776849542; cv=none; b=q78lyHcOBC6eaZz6TaLP0cuc3gEz7grYTurd++jDhTX2E+GPyUCMSJEdxS7lsC8KD5oJs9T9y2Qv3vFvyM0/ZmONqW3LrlwaMcS4FrUEFWtL/ctOHfGHifTRL91CSj9cBhe8pH0k+xsGZ/mVLcRcdA1CYGulcVJYel/fL+mTJ3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776849542; c=relaxed/simple;
	bh=Lvz1Iu9lY80DRvlGIoimX8d9uO3WBJsvgxi7IUXR4dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sY5mMVXNXTZnMeQYX+XHSGmaKRsuI0WI/cXXEZ/AaSinmqBXMruqspwS05T0VBSab0n+Gd/VjPAsfdILRsm+OdP+4lbcEgfER7wx5nC/UxbPN4PNNSJPh1LMXsjAUsE9bo53y5Z9eZp+w2OdxpuIHQNh3pK1pOZwgrSUu88yoeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nmJrD2HH; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nmJrD2HH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776849541; x=1808385541;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Lvz1Iu9lY80DRvlGIoimX8d9uO3WBJsvgxi7IUXR4dc=;
  b=nmJrD2HHPdDugiH1PhefSV8Or+b7rAAbDLeu3Oq2H+ms8Q+292mhcsah
   hLOa7HBLWbh5odFAj1ed0yZqPo5mhfXUEm1P9A8YOkuhYFAmi6yAcBhV8
   mwOKm9bJG01x4/NWfmT2AY5KJY3iMhHR6+l6bbOXLOH3X7tP5Irwydtby
   X+pE23bxL4rCKWsgv+uRvn8TTQcBeba2sPbVrCgJ03Fw/zCKRX1Uoj7ET
   0WDE6rUQAl9KWqlJRv0insidBCFbEWpVOlstZO4vOkkT0bIkYP+A3FUfo
   5UEza1dwP6qYXwt6bHg6XzMZSjTgtQC0najT0o3uMOdGWgj5IwmUKDuCk
   A==;
X-CSE-ConnectionGUID: XOZl7rKoR3+LTcagRuJdbg==
X-CSE-MsgGUID: evyPnUQ1Smidh1LFjgT4Ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="81663724"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="81663724"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 02:19:00 -0700
X-CSE-ConnectionGUID: 7gED/e8tRkKqAUq789L/OA==
X-CSE-MsgGUID: NqMSb0Y6QtCNq2gELENysg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="234093807"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 02:18:57 -0700
Date: Wed, 22 Apr 2026 12:18:55 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: =?iso-8859-1?Q?Nat=E1lia_Salvino_Andr=E9?= <natalia.andre@ime.usp.br>
Cc: andy@kernel.org, bentiss@kernel.org, dlechner@baylibre.com,
	jic23@kernel.org, jikos@kernel.org, nuno.sa@analog.com,
	srinivas.pandruvada@linux.intel.com,
	Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>,
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v2 7/7] iio: pressure: HID: Replace method
 press_adjust_channel_bit_mask()
Message-ID: <aeiSf96HaPkd9GtV@ashevche-desk.local>
References: <20260421222210.16016-1-natalia.andre@ime.usp.br>
 <20260421222210.16016-8-natalia.andre@ime.usp.br>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260421222210.16016-8-natalia.andre@ime.usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 21, 2026 at 07:20:39PM -0300, Natália Salvino André wrote:
> Replace method press_adjust_channel_bit_mask()
> with helper method hid_sensor_adjust_channel_bit_mask().

...

> -	press_adjust_channel_bit_mask(channels, CHANNEL_SCAN_INDEX_PRESSURE,
> -					st->press_attr.size);
> +	hid_sensor_adjust_channel_bit_mask(channels, CHANNEL_SCAN_INDEX_PRESSURE,
> +									   st->press_attr.size);

Ouch!

-- 
With Best Regards,
Andy Shevchenko



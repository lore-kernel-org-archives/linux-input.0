Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCBA39C657;
	Wed, 10 Jun 2026 10:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781088818; cv=none; b=nEMI3urKhZrw2k1QhqIlj7aKZb+zW8bP4P1cLobFv9NHNXpWh84qyQ6qsZJpfOfqZCNnIM5Su6w7Wqd3avhXk9xvVBbFoE/875mWb0A9tspJuzV3i3LiLkfqQ8h2HZLq/f/qKQO3Ltrs6TF50RAwsUe6p9SBC7oNo6xK/oZk0DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781088818; c=relaxed/simple;
	bh=axU5vqkvNu5P+l1DEZVIejg1FjcCNzKWU16V7xbicaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jggm7bAu1oQ0Hehmw8/LGP70qe4MbvithqtKbDbJvBiYbFWMFPk5MKn81BV20kyReY1whHv69aWFLy/vSuW+uHWigbunSrfZwlotPvzQzN7mJdl22MYRVZHD1R3mf7a3vmkeeXObe6CT1yQJS969tYLyqhlw8aw0JlBesQTXEgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JMC0Hylj; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JMC0Hylj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781088817; x=1812624817;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=axU5vqkvNu5P+l1DEZVIejg1FjcCNzKWU16V7xbicaM=;
  b=JMC0HyljeEqBet7SG1A/tatWWoxBcjw1gdlRFSu8NS2/YA92fbBgvkL+
   VhLTQSvbw2wyXftPU4p0+Ex7tjj1RcPKpiviq9JX7XjqXipWAheZGmMj1
   NW5FJL/IcVDkrXDfft60srVXjbDtYAF5rnW5ipZZ09G7nYhUvu2g5vXog
   JSUka1dpngh53t50nVgtbyMk0BT7X1muulv+cXX8PIkmTBtkekVBDoCRO
   t6R9WpIN7JK1CTODx2Zq1Taqla9oID6V//eWHCXkH6roMnknykYyZLoMA
   tmW+ljy1MSjprWRJyqE5WHyDhyOJ3UpodFueSfYhYUN+28Aomk/2NOh8G
   g==;
X-CSE-ConnectionGUID: HAFQ7FJ0TLqIAf+exttSLw==
X-CSE-MsgGUID: 4h7/rWaVQmqj5PzD595UUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="84447287"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="84447287"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 03:53:35 -0700
X-CSE-ConnectionGUID: wF9BSYe6SjGZaXTlD4praw==
X-CSE-MsgGUID: 27GVhZH2Tzq9IztIFGOEqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="246168243"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.38])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 03:53:33 -0700
Date: Wed, 10 Jun 2026 13:53:30 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Zhang Lixu <lixu.zhang@intel.com>
Cc: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: hid-sensor-rotation: Fix stale or zero output
 when reading raw values
Message-ID: <ailCKuwqK2vZEzcL@ashevche-desk.local>
References: <20260610082911.157232-1-lixu.zhang@intel.com>
 <20260610082911.157232-3-lixu.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610082911.157232-3-lixu.zhang@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 10, 2026 at 04:29:10PM +0800, Zhang Lixu wrote:
> When reading the raw quaternion attribute (in_rot_quaternion_raw), the
> driver currently returns either all zeros (if the sensor was never enabled)
> or stale data (if the sensor was previously enabled) because it reads from
> the internal buffer without explicitly requesting a new sample from the
> sensor.
> 
> To fix this, power up the sensor, call sensor_hub_input_attr_read_values()
> to issue a synchronous GET_REPORT and receive the full quaternion data
> directly into a local buffer, then decode the four components.

I have reviewed that internally and checked public version which LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko



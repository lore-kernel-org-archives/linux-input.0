Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC3942EEC7;
	Tue, 16 Jun 2026 10:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781607471; cv=none; b=o9wgYqUD8EwmIf7gtkQuTqlKFS3uruORFw5gMgaJnG44P1znEIQ3R9qagdDNdkk1RXH3O02nKPx2MWIssjpOX43C8xfaV2hLhr5PrvYEEkPGowimgDxivo8yQSh+l3+dvaO/uziTzBRj9iKPdEd/USdZ2SZJZ/03lllnvJWpP5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781607471; c=relaxed/simple;
	bh=sLyOZ8iJJiH3AhhLDiKMB09BMI9ej6NGdHrqVhmiAak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f93mCJ0yKdp8pGWHORgdrZTX4IvsWtSdqEEV9MKcOcC/trrrTx2ii9+Qak6mbEdWwOXxA/xxelgyoRYCXDJqcbi7ZyrNq8Yv/lphsOv73QyljNuXw6j1Ck7RHlFizH1huvfyHBgkA1L0f8sTJAkOJgdlWi3yMJEdKzitFWH5lPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SGd2YOk/; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SGd2YOk/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781607470; x=1813143470;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sLyOZ8iJJiH3AhhLDiKMB09BMI9ej6NGdHrqVhmiAak=;
  b=SGd2YOk/yPQI2rFYMfIGtjc1sX9sk62J15SVIHBxX1xw7xf81nmDvdWs
   bVkCOPAe05t3k8QImnL89EBVjOkUaH19QipYbANOCaxc5TOjtKyZQ4Ymu
   5nyfaeCOd+tIkZWGilsS4ud9NWRISafLjK1Rp+KzO9RsDTotrCkGiEMUS
   8XP/nhXpsQk37gj50AzgS1IIVr3qMXOVBtTshlebvdIA+s2V6oS5ay5Pv
   JS004MF6hdXy7ZMDjsycvEibANJ2BJ/HKruxgbA0qpXZgXaJf6Zx3+GTq
   Qbm2ycz1edNtrVM17CsShFWvm09yPfC/uBOsXtx4/HTZJyBIxaV2sSANi
   Q==;
X-CSE-ConnectionGUID: qrjVdC24R1+YSpRQ5en2rg==
X-CSE-MsgGUID: 7c7UgRdUTWCC6jf8jHb44Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="86206318"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="86206318"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 03:57:49 -0700
X-CSE-ConnectionGUID: eda4+Q06Rm+Osig9pYfRTA==
X-CSE-MsgGUID: qCK1fyn2RIe6JoYk8ZVjvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="244852693"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.153])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 03:57:47 -0700
Date: Tue, 16 Jun 2026 13:57:45 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: Re: [PATCH 02/11] iio: humidity: hid-sensor-humidity: align
 parenthesis for readability
Message-ID: <ajEsKSuOo9AsVLbj@ashevche-desk.local>
References: <20260616-15-jun-hid-iio-alignment-v1-0-0cd544286575@gmail.com>
 <20260616-15-jun-hid-iio-alignment-v1-2-0cd544286575@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616-15-jun-hid-iio-alignment-v1-2-0cd544286575@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 16, 2026 at 03:56:07PM +0530, Sanjay Chitroda wrote:

> Adjust alignment of parentheses to improve readability and
> maintain consistency with kernel coding style

Same comment about punctuation.

...

>  /* Callback handler to send event after all samples are received and captured */
>  static int humidity_proc_event(struct hid_sensor_hub_device *hsdev,
> -				unsigned int usage_id, void *pdev)
> +			       unsigned int usage_id, void *pdev)

Shouldn't usage_id be u32 to begin with? Can you check what's going on there?
(It used to be a change to implement that, maybe it was not comprehensive one and
 needs a part 2?)

-- 
With Best Regards,
Andy Shevchenko



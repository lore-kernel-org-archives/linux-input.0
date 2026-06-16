Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447C7436352;
	Tue, 16 Jun 2026 10:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781607387; cv=none; b=ZQv+H5zw36w294mekqf9RbOIX4ktKWe5uHQd4ay/+37iPjXSOfibol9HQG1dK8uKZcIMIFLhYtaTYPmip+aghuvHIX+kF7PCBsuaCyvMmikK6RssuoQ+IyKQ+jYoLr3VZbzCA6Lsb7Mdlibdu0knSrl9AM08bBtW/TTz/evCG2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781607387; c=relaxed/simple;
	bh=Ao58b7q0stDu/hWcsJ3whYzkm/9stC0oEvrPqJyRYDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XtQ+Z9c8BeEjnbwUMm3xRU7u2w56DLg1CNDBuP69HmJk2Th4/eAMV9PI8O+vIS0kB1hr3TbNNYuZZ/HtlWqi7hG1NEN4lENKwMGQzHJedmhOxkGt5lDYAtJZWipKob/YI4zdtHR4aKKu3pXCXHwH6dasL3pO/yeIy4PrncLmrWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a6HfYJXd; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a6HfYJXd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781607386; x=1813143386;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ao58b7q0stDu/hWcsJ3whYzkm/9stC0oEvrPqJyRYDU=;
  b=a6HfYJXdWlGFJDVTTLK8U66OWe4KvpDMM2stzHfOWiU//wU43DRe8Yw/
   H8gnORye+sKCfBMwgHlTRNm/gDgBKjYsRnfzd4jk1I80jehH1XeO1UmCu
   958VXohI9ax2ovxCgpH0uDrVrYe9a+PG4WJNrs/AefiKTYvdgRYdKgHnS
   tkJeKoMmtKRys0oWE74WwEdgXUr9lCdV/0lGX8eqsOdj2BEPQXK49iIcg
   yEZI5HNogasff5Jkr4lzOg5gjA/HTaYzMHMWd0e1rp3zcHcVKu7t/D/Ck
   grgwpmSPdcIZnT1kNIxfSSlBIZ/QrIhyMSqSbXE7nL93ljRIIO/fDXXuO
   g==;
X-CSE-ConnectionGUID: 8+6oGK/PS82LPkPOTrDh0A==
X-CSE-MsgGUID: TM5oTdjRTpyLLUBMXVgpLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="105036912"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="105036912"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 03:56:25 -0700
X-CSE-ConnectionGUID: nigG6DdzQZ+NL6SzChq05g==
X-CSE-MsgGUID: CH5Wft4GTcSqemAnOYX6Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="252041840"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.153])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 03:56:22 -0700
Date: Tue, 16 Jun 2026 13:56:20 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: Re: [PATCH 03/11] iio: gyro: hid-sensor-gyro-3d: align parenthesis
 for readability
Message-ID: <ajEr1AUMkyj6lDhL@ashevche-desk.local>
References: <20260616-15-jun-hid-iio-alignment-v1-0-0cd544286575@gmail.com>
 <20260616-15-jun-hid-iio-alignment-v1-3-0cd544286575@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616-15-jun-hid-iio-alignment-v1-3-0cd544286575@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 16, 2026 at 03:56:08PM +0530, Sanjay Chitroda wrote:

> Adjust alignment of parentheses to improve readability and
> maintain consistency with kernel coding style

Respect English grammar and punctuation.

...

>  /* Channel write_raw handler */
>  static int gyro_3d_write_raw(struct iio_dev *indio_dev,
> -			       struct iio_chan_spec const *chan,
> -			       int val,
> -			       int val2,
> -			       long mask)
> +			     struct iio_chan_spec const *chan,
> +			     int val,
> +			     int val2,
> +			     long mask)

In cases like this have a chance to (re-)split logically.

static int gyro_3d_write_raw(struct iio_dev *indio_dev,
			     struct iio_chan_spec const *chan,
			     int val, int val2, long mask)

...

These comments for the entire series.

-- 
With Best Regards,
Andy Shevchenko



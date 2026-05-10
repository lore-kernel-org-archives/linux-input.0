Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7A32628D;
	Sun, 10 May 2026 06:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778395376; cv=none; b=VJv4peE5eg8kxkUMGnMoamQxrQHM5VvFZwdJBnNo5ufCwCMYTWrMhTUno7qFU88bXXSW4iqB/UIRjZG6zbgX7lduUFc2AbG3JWpX3GIh5E9ZNQ34U1/GK6iKSUkqgfjnT3u6UtajuGC8UICT7HelY7iGEXpxcWtgYsZ0nmDlmN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778395376; c=relaxed/simple;
	bh=NwYBVY1F2qQhWgGxYHu5Y/G0Rp5iNBVBJS/mz7Ouu5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pi+cALG9Z44ZlHCbrhHMqxdzTJ8q4tqD3rgmFydlxnIgQNW5R6W/B0PVpkyXpUd+oFMnfTmvDcXecZFFdGEZslzXScm2ooos7v4wjGE2n++iz0l4puOSEFfeDWzmHhduDeotshvSx1BuPf7nniBCZk9SO6mKZmr9lwU67zpy2aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BnKy70re; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BnKy70re"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778395374; x=1809931374;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=NwYBVY1F2qQhWgGxYHu5Y/G0Rp5iNBVBJS/mz7Ouu5w=;
  b=BnKy70rebcNXT9zOLJMmmLPxOXCNI2yDD6PMnSkgzzPR4+gvB/L/Nwfa
   6FzA62WqHKD8hL8n1WChxN40TH0kCqP+UvNy5noy3xma3WPf7+ByzHFok
   LnnuH/jwH6FGw8CSQJNQ3up3vMw9Vn8VcuHU62p12t+3oDlWBkS0KYFgp
   4/AQiCGUEsIgufNQ7N1eqU/qbBu0gfyx7SDP1BmDcDGNTMkQqUKtkcfem
   CKtGO09zhlzofnO8v82Brz6zyv3K865RmVXE0PvenLHkEoD/l5Rnc9GUR
   kXfW9cUaa3GNjxaMPEM6uD+GPUKWWOATJGiRKkODOGdWteTFCL4HCSiIQ
   Q==;
X-CSE-ConnectionGUID: FHlLoemQRUG2/+PzIXkpIA==
X-CSE-MsgGUID: TPY4i94WTuy/5kDhXxE2bA==
X-IronPort-AV: E=McAfee;i="6800,10657,11781"; a="96881917"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="96881917"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 23:42:54 -0700
X-CSE-ConnectionGUID: qvC+GlhLS12zVckHHXEgvQ==
X-CSE-MsgGUID: 7+NHvgJlR9qq7ZhHJpzwDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="260889416"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.171])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 23:42:51 -0700
Date: Sun, 10 May 2026 09:42:49 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jikos@kernel.org, jic23@kernel.org, srinivas.pandruvada@linux.intel.com,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	sakari.ailus@linux.intel.com, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/9] iio: humidity: hid-sensor-humidity: use common
 device for devres
Message-ID: <agAo6fXUaoTwl326@ashevche-desk.local>
References: <20260509101040.791404-1-sanjayembedded@gmail.com>
 <20260509101040.791404-8-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260509101040.791404-8-sanjayembedded@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, May 09, 2026 at 03:40:38PM +0530, Sanjay Chitroda wrote:

> kmemdup() is used for memory that is logically tied to the HID
> platform device, even though the driver binds into the IIO framework.
> 
> Using &indio_dev->dev for devres allocations works functionally, but it
> results in two separate devres ownership trees—one for the HID
> platform device (pdev) and another for the IIO device (indio_dev).
> 
> The devres framework is intended to have a single, well-defined parent
> device. Since the memory originates from HID sensor probing and is not
> IIO-specific, &pdev->dev is the correct and logical owner.
> 
> Switch to using the platform device for devm_kmemdup() so that all
> resources are released deterministically and consistently.

This patch sounds like a required fix and has to be placed in the beginning of
the series along with the Fixes tag.

-- 
With Best Regards,
Andy Shevchenko



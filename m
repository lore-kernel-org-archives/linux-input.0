Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795777928;
	b=UTqEa1Mv9HjgsVMoC7gQ14CFuMQAIbEtu8JiJQ0cLYOAhv74Yojv2bWnTWmR8m4SO+fn
	 IA/P9N5L/Rx9lU9S+BgHDBqGZgPHYFJBqvWpxCPBqD5sH5HXSHqUQqQjUh6m5L5a1Bn0i
	 2p6bSNb0QWQYx+0u3PDTwnm95bkFj6zLbBgWkCyCvwglmq0UjUUGSqsyTz19LQ5XoTAV/
	 3KyP7V+pHGsZA/kBjDRtD4LMohfrl5egnDdnLEegqbLQMIGVTP4Wr0HmfWr8D+XimtLdO
	 B8+7Poxu/Fx7fcF6w33T26VXRL3LetTtLf/Y0INmLnn/6UGCvThiiwD5+69JL3Mc9uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795777928;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=y5YJi1sJrMPuqmdeCSGcwMhOZSaaMEqVhLWjWg1y5DQ=;
	b=r+p8+o0xz0eLY6IkJ9sxVA8v73SoVZH6OBpWlkcEqcmEVx+3xoMagVUVNK8rjPry6jGM
	 7SPaKkcvFzY3hpowU8/pgteV9oGZ85aPhTm6FwaBrsu+0yC1bZeoh7OPNHuf8Ri6tSfiN
	 y/wkDK6pJX2cjrGC3IAhYTW0QRG+Zn6+Vpci4NdJbI4GH8FM/QnbvHELYGQ2sIpBIJ94s
	 NgTUNEF9HbBwRpN2XLji3MXqgx6uJ1rSIiHyl6G4stGt34F+82vepcvxwhKzODYSKh99h
	 gFof+ZalUTSbS6Bdm3nXqgZ0Lr3Yi90v+3e8RHk0pT78+HFL6ddZKuGZhEuEnILKWmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bIUvy44G;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714E1606A338;
	Fri, 27 Nov 2026 11:12:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 714E1606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bIUvy44G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795777927; x=1827313927;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KqHOKykbe5ZyFYsaUPcERJBTPAJ7CBqMo8obDfHE8bI=;
  b=bIUvy44GmFFezPVnol0g6umloag550GEG6UIi0MIXMA3ZUv1spVT1BG8
   GWbeRY/YP2bZMDNSrpUyX1jRtp+NHtYmPnJiFd0eGWnxDlmzk6bVEnF5m
   ODeQU3U4UqtR/eSgR+Z4VvjM/FDGOnjjBBXrC25n4yBDwhPN2FqYf0rfQ
   2c+YPaILoScCo8dLK3jiAzk4tBQ2J3iB/8Rw+uNmKcGKtseCyD7qUOnXI
   HhA6V1oiwtrSTEIrb2fghutLt6dhja7DBPvsf2Llerh6RKJUWF56i2KKD
   vU0oiFHPDyijr7Uk6OpOE4Hid47OUWT5UbNf0UzCR6MwoG9MZgB8yUrsc
   g==;
X-CSE-ConnectionGUID: GEuW5iV9RCSYc/al0XbTgw==
X-CSE-MsgGUID: qEqFXznBSPmEnGQgn/dxVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4544764"
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="4544764"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 03:12:07 -0800
X-CSE-ConnectionGUID: Y/NDu+7dRgyXEKj6eGNtkA==
X-CSE-MsgGUID: N4ac5XDcS4avPB+40bfN1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="14051309"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.115])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 03:12:04 -0800
Date: Fri, 27 Nov 2026 13:11:58 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: sanjayembeddedse@gmail.com
Cc: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Joshua Crofts <crofts@kernel.org>
Subject: Re: [PATCH v2 0/7] HID: iio: Unify probe-path logging
Message-ID: <awllftF3xR6Arvua@ashevche-desk.local>
References: <20261127-19-oct-hid-iio-unified-print-framework-v2-0-3f476fe1a940@gmail.com>
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
In-Reply-To: <20261127-19-oct-hid-iio-unified-print-framework-v2-0-3f476fe1a940@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 27, 2026 at 04:03:55PM +0530, Sanjay Chitroda via B4 Relay wrote:
> This series provides consistent support for logs in probe() path for
> HID IIO drivers with suggestion and input from Jonathan.
> 
> This is followup series on top of multiple sub-series submitted for HID
> IIO device drivers which included fixes, devm support, cleanup and using
> preferred kernel coding style. This series adopts a common logging
> approach throughout the HID IIO device drivers in probe path.

> ---
> Changes in v2:
> - Following suggestion of Joshua, remove the comparison and change the
>   checks to `if (ret)` as respective devm_*() API `return 0` on success.
> - Link to v1: https://patch.msgid.link/20261105-19-oct-hid-iio-unified-print-framework-v1-0-0b360d9552d9@gmail.com

Reviewed-by: Andy Shevchenko <andy@kernel.org>
for the not commented patches (the one is depends on the answer).

-- 
With Best Regards,
Andy Shevchenko



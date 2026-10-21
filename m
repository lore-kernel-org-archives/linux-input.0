Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792602343;
	b=s9l6vuczbxtmRTao8pJ2Xlb/98OpYkeWoEa9WouErnK8j5e3dgD1H2zwqacEeg6f0lsU
	 XP/Cj9b/MAXbGzicN1GBvFeUywhPWW/N4fC5xuyncR8eY0070UnEVchFr7YYnX1ejR7Yo
	 PaZnCJijLDCwsDtmrDkU53wBlUYgPBxpvjYxNknGdko8OlRShMcsgpKZ0JAGgXCfcib5C
	 EtzAwNY/aGMemajf5m7Hhvd0sqSDaofeIsAiGQ2YgalPUnsqAUWUvd0lUghnS0HOOWes/
	 8gRP/2TmHCWbp2fRzCECAUbkxva1zRNE2ZudSrFaE8vqMZhObnXqOpixr5qGgMYMWGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792602343;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=265XAVagHHfBwn0bErrMPqbKoGS5PBcl58aJYs48LK4=;
	b=0GeQ/Bv11keBr4CwJSsVxgQWNyHhc5wHgDrqgtidVmXKCWwda5NZrpvucGRoPUeof2mN
	 ENkF4PMR5RuFd+y6tXQSdtO3fFeZjPjoCYQnm31e9W2d6PcGmOs588XyOb0xrLQPIbwHq
	 jNzkNxA4n+ybg1aWXQyaH5c5Y/4dy3kgtUxyI9udfFsucuHXMV3iUAmjxuOtCBCdc+7Fd
	 aCnxfQ/p3NItakPthuclHm7EAAzLwGFWu3wGxRs3IG0kbpt3a4GfOWeOcIIt6uKglmMAO
	 UMCc5ddCd0kIKjra6OVi6je0xuhXBem8gkSHrEOvzeP1tIv/bV8v/KNYJnQm0+5ob5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NYLO7aaM;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34479606A320;
	Wed, 21 Oct 2026 17:05:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34479606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NYLO7aaM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792602342; x=1824138342;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jqKgAILFYh54yN5rl3rwpF7NMEthST2ms7tfqNttxxM=;
  b=NYLO7aaMtjVbFwMGMr6TFbinj9SZ9k9pacSwW9vkA5p7w3Lacs0LEY0n
   UzlXX7Idp4RqfPD10Q56g8L5oL5DAtZQKhW4QDAojUETYWGc2YgXtE49M
   UHCUpTe8iIgkRtLIz/JuZC0rRijkondmOQZ5PRaJ7bRl36JRvNVseJ3Vc
   0AbHD4gIQ4A3BRy4wAsiO7PYK6adaxGpraJJZK3MD9xIhi6Ng99z+3qJN
   Loqdw2oMg/PrGeA/eQJaTbxM2+5zb0sUbT2Wgp7MFoCniq3Xc2H5Hik+X
   /aQ8ZKb7u4AY17duX6QLJhbaroiorr8UEymWC8ukVr6axKTnDhKPCgRYm
   w==;
X-CSE-ConnectionGUID: SrVuMeFlRneo05Sb6wWR+A==
X-CSE-MsgGUID: oCde/XEsSNCB28xTnogMCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1231949"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1231949"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 10:05:42 -0700
X-CSE-ConnectionGUID: mYS56sDoRlKbxdXSRDLNxw==
X-CSE-MsgGUID: PHyESIJ3QJSk5prm1F3tYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3060932"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 10:05:39 -0700
Date: Wed, 21 Oct 2026 20:05:37 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hansg@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linusw@kernel.org>, linux-input@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] Input: soc_button_array - use __free() cleanup
 facilities to free memory
Message-ID: <atjw4b-ICVGH3-2a@ashevche-desk.local>
References: <20261021015004.1537738-1-dmitry.torokhov@gmail.com>
 <20261021015004.1537738-2-dmitry.torokhov@gmail.com>
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
In-Reply-To: <20261021015004.1537738-2-dmitry.torokhov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 20, 2026 at 06:50:00PM -0700, Dmitry Torokhov wrote:
> Switch to using __free(kfree) cleanup facilities instead of doing manual
> cleanup or abusing devm for allocations that are only needed during
> probing.

...

> +	const union acpi_object *desc __free(kfree) = buf.pointer;

Rafael added 'acpi_object_free' for __free() (pun wasn't intended :-).

-- 
With Best Regards,
Andy Shevchenko



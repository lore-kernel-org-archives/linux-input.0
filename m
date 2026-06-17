Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45B8472775;
	Wed, 17 Jun 2026 15:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781711589; cv=none; b=lDcfv+u6/h5di3lXi4Pnrn4F9xSoFMj/g5Lw8+vrrHZxvbtKvIx7PR6y9S0QMlY22WyEPwnaXcYdR6jKGQ7kQDlI3B8ttTiIItTHudRK6DoGIkvN6C5vbmHGOTWeR5uPoKu9Wq88W+YVJDV/2OKmI/neMrYio6RMcfvYEmJQx0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781711589; c=relaxed/simple;
	bh=n81ub2yqosIloZgj8o8+tb+wS5L9WmHdmvyHbyetQCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqVJG2UAxj1kGU0Q76Q3gOZ64cTh4Du9Bmi8xwJH9U+opk8u+/1FWL5TEPxxoEhIbCtnHRE3RZk7VMiRCdGjSoKzPWojY8182mzdkGWRMS1gSjQy3vBiIG7bmfOWyUxmeTSe0YitDh5k8kCg2Stw1eovisVyZxQNCRymOpOtIt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LE5cPyMz; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LE5cPyMz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781711577; x=1813247577;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n81ub2yqosIloZgj8o8+tb+wS5L9WmHdmvyHbyetQCg=;
  b=LE5cPyMzwjKD4HNwBs4G4VOtQi1104gvzjtZzpuLV8F/T3YRAY4hQSG9
   w/Kp2ux454b1x/gnB3CMRYLzBHODfrQ56niJc/jY9MvYO2xU2lp3qQ2L9
   WV4J6PvdaaBYGlCXjOl2XUqwslzvZq8pX8NOdylLOGJDYRs60dCBb6zxb
   FqZAkmTlWg6sri9ur5rhLkO+9uResxqpE5iAnQDwBc4uQTjuJ6w/0nTeD
   IgD/21uSjCKU9oFYWnuxme1hXs5VlrDvq/Gcw/7cG07iDv76INhjzGcx4
   9ASUU+CprZ4m4reZ8oPmN7mi9B89R80FKWHVDR3LkAMsEbuKh5Udx8UVx
   A==;
X-CSE-ConnectionGUID: 3Cq6a5zIT3Seaq5KLfUEaQ==
X-CSE-MsgGUID: LaFPii1HT/muq+golATXzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="82616850"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="82616850"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 08:52:56 -0700
X-CSE-ConnectionGUID: BpRzT5d/Qj+B7hXmPCdo2w==
X-CSE-MsgGUID: dBQdErZQSaydM7QtfXYm/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="286213918"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.245.69])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 08:52:53 -0700
Date: Wed, 17 Jun 2026 18:52:51 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] HID: iio: callback API signature match for usage_id
Message-ID: <ajLC09uEIOClVzEq@ashevche-desk.local>
References: <20260616-16-jun-hid-iio-u32-api-type-v1-0-952c74195f46@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616-16-jun-hid-iio-u32-api-type-v1-0-952c74195f46@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 16, 2026 at 06:55:19PM +0530, Sanjay Chitroda wrote:
> 
> Most of HID IIO driver has correct 'u32' type of usage_id with
> https://lore.kernel.org/all/20260610-6-june-hid-iio-correct-usage-id-v2-0-c3c5f0720493@gmail.com/
> series which is applied on iio/testing branch.
> 
> On top of the same, this series updates remaining HID IIO drivers
> to use 'u32' for the usage_id parameter.
> 
> Pending list of HID IIO drivers are extracted with command line:
> find drivers/iio/ -type f -name "*hid*" | xargs grep -A 5 static | \
>     grep -E -A 5 "_proc_event\(|_capture_sample\(|_parse_report\(" --color | \
>     grep usage_id

I recommend to get used with `git grep ...` which is more powerful and much
faster (on a Git index).

	git grep -lw 'u[^3].* usage_id' -- drivers/iio/

for the list of files, and

	git grep -np -w 'u[^3].* usage_id' -- drivers/iio/

for a better view.

(It gives one false positive, though :-)

> This matches expected callback API type as HID usage IDs are
> defined as 32-bit values.
> 
> No functional changes are introduced.
> 
> Testing:
>   - Compiled with W=1 for each patch in the series

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Jonathan, it seems the missing part of the initial unification. Please, apply
to your testing branch.

-- 
With Best Regards,
Andy Shevchenko



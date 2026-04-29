Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5F0287259;
	Wed, 29 Apr 2026 19:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777491323; cv=none; b=DCp9QjUFNVtfm2rYiJnDLPPrqoJxQ5Vgncji9+jGHAc/n9QDdxQoGkS/5cFQs4xnWIl0WpIF7+GMGiWqPErXkWD6HYPUc91ZUx0+DJN4MzU9hPb6BE/LCNK+TqI/vYEMOuwPnFJicNbWxf4Daaz4m0SZEbYg5S22+gcbvjRfUwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777491323; c=relaxed/simple;
	bh=1QXcF6dknZUJ0wPx4RRKWzyjzq4Np7uoGjgiSikQmC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJBwpjID0Gz/QuY5X8smSKDF7DHhFN/UKtGAemKiSHZapgcD28UiStfagwbNT0xEQLK6KW1km70x4Ghz+jiBM/P8h3KuEQCpkAD8E7KLzYcls/anQ86A/GwGb0REnPCy4Uy6zBrqqT2CR5njqU2VWYygM3kdP7EzYVprTCt/GWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CKMfUogh; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CKMfUogh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777491322; x=1809027322;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1QXcF6dknZUJ0wPx4RRKWzyjzq4Np7uoGjgiSikQmC4=;
  b=CKMfUoghvoGg65kLWIjgv7wTA1A37Is6kN4kjg1C65tzQ24gWI0WtZYB
   7iRiaMrOzimrs5QuH6zwmtFUAYJLFbqNkzbXs2USQ/ZzEm+Dwrs+nx+av
   PC80fd8V1CE8elVsHqRXni17vEIC+in0fM131i1NAPz8H7o0oSg6XjIlw
   I2zzZCZdTpG3TlCU/L8zvwYAa112Ofdqs0JZGEworYCj3lLqHmkQIuoXD
   LR6az2hR3ShtbiX9Gtj8HJcOjAYBCWDJBzJ8v/djajzAuuyowxuFYDYFA
   wqX++tWezsPDvHmqALn0X+QLfPpHhGhNohXOmOhJYCtyXZ8ca8vpw+l+w
   A==;
X-CSE-ConnectionGUID: HYeweK7CR3u6qnOCZnQ8xg==
X-CSE-MsgGUID: VyXwncuURiq5hItkugoDOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="82295306"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="82295306"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 12:35:22 -0700
X-CSE-ConnectionGUID: jADMw2iaRMema1DUzhWeFA==
X-CSE-MsgGUID: Sw6k/8qKTNefAglnlqOY+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="239382619"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.141])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 12:35:19 -0700
Date: Wed, 29 Apr 2026 22:35:16 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jikos@kernel.org, jic23@kernel.org, srinivas.pandruvada@linux.intel.com,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	sakari.ailus@linux.intel.com, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] iio: introduce devm_ API for hid sensro setup and
 cleanup
Message-ID: <afJddNO9XX0nURON@ashevche-desk.local>
References: <20260429175918.2541914-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429175918.2541914-1-sanjayembedded@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 29, 2026 at 11:29:14PM +0530, Sanjay Chitroda wrote:

> Key highlights:
> - Prepare change as pre-requisite for devm conversion for HID IIO
>   drivers by removing redundant argument
> - Add devm API to setup trigger and clenaup resource using
>   devm_add_action_or_reset()
> - few sample driver update using devm conversion to auto release resource

> Based on further feedback and reviews, I would extend this series to convert
> all HID IIO driver to use devm_* API.

Not sure about this. But if people (and HID sensors maintainers in particular)
are fine with this, I have no objections. There are some nit-picks and one
serious problem to address, though.

-- 
With Best Regards,
Andy Shevchenko



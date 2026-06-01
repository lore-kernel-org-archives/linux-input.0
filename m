Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DF21A6839;
	Mon,  1 Jun 2026 19:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780341527; cv=none; b=Go/P3sqjra1tCIjsxh8aBh7Sodh3d2+EaXn8laYLZnv4DS1Gwed3CgxrrNkTdHifPeNUFCqB3Eu44Qxwh+ohTbL/QBLy/tkLmGuI4kXS+vxixi4KSazq3RcFxBpz4D6tZ7EFRqqaf8y2Dqu0PmNd/fBr2L8P1WoZMaNhn/iuqc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780341527; c=relaxed/simple;
	bh=XByac4jqa9bNVJj/uf8ZToa0I4yv1Dz1L1o/ssrvxVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8ZFEPhzEtV74181nDolVhgbmugzXvJCUIX8YrNco8qJqa3C9TNMHs8MJlRECIb3dYDLCKpjaRhs9hGPhbSe24jbn3rynmZWgZILzXtcVf7/RRl8prEsrAzqKiUw6nM4JQnYXryE1AvDkhf2zcbxPhV1rGXlqzouMcEmc+gxMYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ccjX/1qa; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ccjX/1qa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780341525; x=1811877525;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XByac4jqa9bNVJj/uf8ZToa0I4yv1Dz1L1o/ssrvxVg=;
  b=ccjX/1qaMrg6CKhl14YPXVwQLWAnQmxMqvRtiOwgj5M36qpVKCi0RLmD
   +eTBJLTPcIufcjLeOgUK47HA+vqIy+Faii6bkFxZ4cw6ZvSVbGOlAOrH/
   3tFp6MJTD8hZBhX5QKyHaOQ+yFIa4t4/nQPzBvvwlrveqt62EsE2oAszr
   VvNLsBZFryZFMBgPZ4mXNAbecZ7ODJTiYIFYhPeCVYxJTvQP/kk8fjAEl
   VPRZYMNCk7ouQJWEFjOL1yCSQRVuYQwdYe8oKgMVIaLl7lPX9p/nKIxhy
   8RR+IlN7f2Ypegx/AUDqLX2n8lOJ3lunqPsaOL8OVDnHFp7Uw+ixljeRX
   g==;
X-CSE-ConnectionGUID: 2UZWEeqvSOWFtBzyMpDFlQ==
X-CSE-MsgGUID: 4bgIcR5JSeKPwjZu+FZFbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="81294862"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="81294862"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 12:18:45 -0700
X-CSE-ConnectionGUID: 6WVaCva+Sg6StVOfA0UDwg==
X-CSE-MsgGUID: pvLmmQTOR3qfi6hWUiT8Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="267547772"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.111])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 12:18:41 -0700
Date: Mon, 1 Jun 2026 22:18:39 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Danny Kaehn <danny.kaehn@plexus.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	linux-input@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Ethan Twardy <ethan.twardy@plexus.com>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, Leo Huang <leohu@nvidia.com>,
	Arun D Patil <arundp@nvidia.com>, Willie Thai <wthai@nvidia.com>,
	Ting-Kai Chen <tingkaic@nvidia.com>,
	Bartosz Golaszewski <brgl@kernel.org>
Subject: Re: [PATCH v14 1/2] HID: cp2112: Add fwnode support
Message-ID: <ah3bDxgh-r7FtdbZ@ashevche-desk.local>
References: <20260520-cp2112-dt-v14-0-b1b4b6734b6f@plexus.com>
 <20260520-cp2112-dt-v14-1-b1b4b6734b6f@plexus.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520-cp2112-dt-v14-1-b1b4b6734b6f@plexus.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, May 20, 2026 at 11:13:06AM -0500, Danny Kaehn wrote:
> Support describing the CP2112's I2C and GPIO interfaces in firmware.
> 
> Bindings between the firmware nodes and the functions of the device
> are distinct between ACPI and DeviceTree.
> 
> For ACPI, the i2c_adapter will use the child with _ADR equal to Zero
> and the gpio_chip will use the child with _ADR equal to One.
> 
> For DeviceTree, the i2c_adapter will use the child with name "i2c",
> but the gpio_chip will share a firmware node with the CP2112.

As we seems settled on the approaches in both cases, I think we are fine
to go
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



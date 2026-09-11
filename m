Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE57E39A80E;
	Fri, 11 Sep 2026 09:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789119765; cv=none; b=nido7PLAPmyocEWs56B4KZ/HyaFH9Ns3GJeKXj394UPGQp90nLvN7vk4zbYA9jlFWiu6uJlG6M9Yfa/3e5NxVfuxcHXNcEftFadArFZFzWcUlgF1S9p8Cj9ofgJ/qw8VsVZ42QXM/D2VvkIyaqlXiWbUDNk3oTFYdDaJl1LxqMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789119765; c=relaxed/simple;
	bh=WxG3rNoe+gqUM8P7w3hOznkwUqalM11LnbkjAPJv9o8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8m2OZ/qjARUfY+d0QGKOobmUK2FqzdSFECAmiN4FlyNULpLEDNhRUSsWqmORzJr2k94ClK3lkYXPb/3jaWUcjst5VwbhqKd9mJ6y38UXjb7MqiuVNnckWQxgKmsv1kA9VbUaO0QYvGjQi7CD81waE2cHhqVYOjk6g7/Ttvv2X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QvH9tA7K; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QvH9tA7K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789119763; x=1820655763;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WxG3rNoe+gqUM8P7w3hOznkwUqalM11LnbkjAPJv9o8=;
  b=QvH9tA7KfcALzdW0VRMYdTcoy4ehhq2njWOwVMU4gG4SU4ZCwmOXseF3
   nQmF4jXFAgJHVLmHQH3X0ErnlF9RXgIS20WkH9hppDUWgwAAgagL6dgCZ
   EoikXXSksUfVkSaY5jtf6KL09pv68donps+R4CRfAnyIfsc1x0o98os0Z
   D+nDWd1/oYEkL2XKDDfQaktiv/pNiQEC8PNMJoySYQHu3uQgvgHlUzxAB
   BjQHHUEAZl2MaDoeuMNwfAV6YM6PXssWt4y2n8Q65ZyxB8Ne5sqrUOdj8
   Csjq+x+unnHEoCaC6PmZiHikJBCPI5LUrkWyvxanvqqWrrMh9V7xMoUD7
   g==;
X-CSE-ConnectionGUID: cwkYIJCzSmqc7RKkH41slw==
X-CSE-MsgGUID: n1+XKnHoRQ6QSPNh1HLfCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="100243442"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="100243442"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 02:42:42 -0700
X-CSE-ConnectionGUID: A92FjVxpTpKJpz4F+kMM1A==
X-CSE-MsgGUID: EjtWWbi9TaGL7B25NRtF0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="272381088"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.80])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 02:42:39 -0700
Date: Fri, 11 Sep 2026 12:42:37 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Yibo Tan <lhfff@tju.edu.cn>
Cc: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Zhang Lixu <lixu.zhang@intel.com>, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] HID: sensor-hub: Fail unfinished multi-value reads on
 removal
Message-ID: <aqPNDZgMS9K6NT7d@ashevche-desk.local>
References: <20260911092039.234253-1-lhfff@tju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911092039.234253-1-lhfff@tju.edu.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 11, 2026 at 05:20:39PM +0800, Yibo Tan wrote:
> sensor_hub_remove() completes pending reads after stopping the HID device,
> but does not record why they completed.  A successful completion wait
> therefore returns zero even if no complete input report was received.
> Multi-value IIO callers then format their untouched automatic buffer as a
> successful result.
> 
> With a valid four-element signed 32-bit quaternion report descriptor, an
> unprivileged reader received all 16 bytes of the untouched buffer.  Across
> 11 independent KASLR-enabled boots, four reads exposed exact pointers to
> dev_rot_channels or dev_sysfs_ops.  Subtracting the matching link-time
> symbol address recovered the kernel KASLR slide in all four cases.
> 
> The reader ran as UID/GID 65534 with no effective capabilities through the
> mode-0644 IIO attribute.  The test used a privileged UHID broker to create
> and remove the provider; it does not demonstrate unprivileged provider
> removal.
> 
> Publish -ENODEV through pending.raw_size before completing an unfinished
> multi-value request, and propagate the error after a successful wait.  A
> fully received response already has a positive raw_size and remains
> successful; max_raw_size is zero for the separate single-value path.
> 
> The Root B-only repair returned -ENODEV with no payload or kernel
> diagnostic in 3/3 matching signed-32-bit runs.
> 
> A source reproducer, complete vulnerable and fixed serial logs, result
> tables, and checksums are available at:

> https://github.com/kimaiden1984-boop/linux-kernel-poc-collections/tree/main/cases/hid-sensor-quaternion-root-b-kaslr

Make it a Link tag and add reference to the text.

> Fixes: f784fcea4506 ("HID: sensor-hub: Add sensor_hub_input_attr_read_values() for multi-byte reads")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:GPT-5

Assisted-by: LLM

-- 
With Best Regards,
Andy Shevchenko



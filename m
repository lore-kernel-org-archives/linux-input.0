Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F96C3F65EE;
	Wed, 10 Jun 2026 10:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781088751; cv=none; b=TZAB9Nc7Yi5JUEkNc5XzshVx8hzMuN38A9ot90TzhKx3tj9tLcTg5odkHXWU5AUdzbVk94uTFag82w+yjnq/+BlkSWxg0uLgqvN9NGRcypQutQi+eoCggzeEHnEVj/jO1uMTUV4IFEZXdscrE2UyoyAzWvdZnWnbzS58CeRUHuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781088751; c=relaxed/simple;
	bh=EZvolpzRks7yVCrQk5I7CBPzXK/FN7EqRZmadrpp1p8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmdB6eEBME7J/z71ArBN2GEf5sXEpufyDSOKy25Kn5LCovqmvahuSwyD1xqNZwHNYS7Gus9oteg/RdZY9ek/1EYblMLW0JU7BxcrCWEid6wext2bi644GhpdZc9DR9CGqxTX0qo2Mtj4M2Sn5vncL6iYq60gpPAr/5LbiS0R+R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aOxUBFC6; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aOxUBFC6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781088751; x=1812624751;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EZvolpzRks7yVCrQk5I7CBPzXK/FN7EqRZmadrpp1p8=;
  b=aOxUBFC6c9sqI4wVnUrVyJU/Eu+oTc9gbFFyfE9+FYtQYQZgcCvBS6Ub
   8EBRQvLbgo2xhLNyBapDHjv/de0j/o4IRhCn1CmA41RjmTgPlRiGGsH+f
   KP3KsmSq4971/WfADbAnXGArNmvo2eDH3xXuJPpTbDuU727T+msOT7Gar
   xGVQVopSuMH4dhQlmw5nBEbdlQQOnwMm5kFugkMIkCcEVWYJaegLDzzF2
   YEKRs0MQ+e6JgXI3Sda/yEgWy6HHUxo7exLOCK33GsAUCBL3SV8WyvGQq
   Qyv4/6qJ8HRGNnc1FW5doIofMkAcFYJJcwtXWyk15LQfum1MoqKCpn+Ya
   A==;
X-CSE-ConnectionGUID: A+GZ6RiBSfKm0SMFefhJBw==
X-CSE-MsgGUID: 58yne1D4R5O8jmR613CCaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="69411641"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="69411641"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 03:52:30 -0700
X-CSE-ConnectionGUID: wJqWUPjQS2ChPkPegU7FyA==
X-CSE-MsgGUID: qw0r5AZzTWuWPhBqSrsdgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="270146171"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.38])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 03:52:27 -0700
Date: Wed, 10 Jun 2026 13:52:24 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Zhang Lixu <lixu.zhang@intel.com>
Cc: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] HID: sensor-hub: Add
 sensor_hub_input_attr_read_values() for multi-byte reads
Message-ID: <ailB6HeV7Hdgb3-b@ashevche-desk.local>
References: <20260610082911.157232-1-lixu.zhang@intel.com>
 <20260610082911.157232-2-lixu.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610082911.157232-2-lixu.zhang@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 10, 2026 at 04:29:09PM +0800, Zhang Lixu wrote:

> sensor_hub_input_attr_get_raw_value() is limited to returning a single
> 32-bit value, which is insufficient for sensors that report data larger
> than 32 bits, such as a quaternion with four s16 elements.
> 
> Add sensor_hub_input_attr_read_values() that accepts a caller-provided
> buffer and accumulates incoming data until the buffer is full. The two
> paths are distinguished in sensor_hub_raw_event() by pending.max_raw_size
> being non-zero, preserving backward compatibility.

I have reviewed that internally and checked public version which LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko



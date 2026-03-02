Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D75623EAA3;
	Mon,  2 Mar 2026 08:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772439439; cv=none; b=cmro5UPQ/jLfY2HVXX4tydD9AdAUTYpYdwHjg9bOZa6P4d2Z1TlLSTC5TBCj2rOuJNkiaYByXpvtfWsAqN1KZa+POuduyat8/kFYSJQLddwdf5vuQtDzWVtLQNWH1ZNiOI0BR2o7ImBiFKhwIJqiTFcFgV1pbW07+H679PmxzIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772439439; c=relaxed/simple;
	bh=MhsnHiOZOsglwyWweboq79Q06Zi3FgpbCSVlwVtbgZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cId9drA/XOm3ohkvmKjOI42hepQd+qNFDaW/SSJe+6erzF+qnLPjxpUcdxoyU/OgNGxXJvm6SeiR/3wNRNk9wD9xxAIWxARTvtnNhbU4NufH0YpVXMawEs/7ury6leQ+7dq/MIY0waXAnkAedygUN0yrr1h1+olAnrWz9MDm0NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TEhrHPHk; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TEhrHPHk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772439438; x=1803975438;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MhsnHiOZOsglwyWweboq79Q06Zi3FgpbCSVlwVtbgZE=;
  b=TEhrHPHkW0oF9YbGd4QybBN/0dkfezDLrBWBa9OwXIXpu3WcTPTNl5v3
   BBOoBz0xOT8uVBBAFUg1/DHmKoe6ughYHlTGjNb6R4x/fDZKEGBajQQa+
   oDSg9dhAiMdifU79gZZXCC/rJ+71gItVkYxyA0+IQwY9baPBxSMzeT4dW
   QBSeWJSbOBxn0qx0VgnjI1fyHmJuos7G06odWlF9MjnXbKDtm0XvhRDcP
   T5tiTJ+fQBIu551WIBFLYo7ofKRLCMaDojUL5htQ8iigUU+ZAo//io7NE
   3yxENGNzMk1L6VP7bWYMb4BassiQCSF5me13UY5QFA4ZCTghkN4wuPEGs
   g==;
X-CSE-ConnectionGUID: I72abHZBT9eUtBHAMZ2sTQ==
X-CSE-MsgGUID: cgwunIAmTFun/YdCbgrrKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11716"; a="72467024"
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="72467024"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 00:17:17 -0800
X-CSE-ConnectionGUID: bsZN/rwCTWaQ6pwoJckJOA==
X-CSE-MsgGUID: DZLaxu5BRWiaPZreLoJYgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="216711969"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.52])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 00:17:14 -0800
Date: Mon, 2 Mar 2026 10:17:11 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: orientation: hid-sensor-rotation: use
 ext_scan_type
Message-ID: <aaVHh6FpX-l0CiC2@ashevche-desk.local>
References: <20260301-iio-hid-sensor-rotation-cleanup-v2-1-245c6ad59afc@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260301-iio-hid-sensor-rotation-cleanup-v2-1-245c6ad59afc@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Mar 01, 2026 at 05:46:48PM -0600, David Lechner wrote:
> Make use of ext_scan_type to handle the dynamic realbits size of the
> quaternion data. This lets us implement it using static data rather than
> having to duplicate the channel info for each driver instance.

I like this change!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
(assuming somebody from Intel tests and confirms it working)

-- 
With Best Regards,
Andy Shevchenko



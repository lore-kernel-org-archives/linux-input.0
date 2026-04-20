Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C27B288C08;
	Mon, 20 Apr 2026 08:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776674574; cv=none; b=SoJK569AJnQC7WjXLzivsZtyoJYKe1nJGFdi9PO0kuUBTzewQwkgtfwlXofj0x70ErKvm/K36yvMFj9jxsbYKr5T6FFWsi6NiaIxR1NYskXL6J/+zx5bQ22sdLmLD3YBrpdOmQunxgFLLXvbpZgQNnsbaX1pCnPNO0cLY9UUO1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776674574; c=relaxed/simple;
	bh=7ZA2+RZNILcuGGWDhs2trqwiJhv6+KfLcFiT3A2uZnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NaMXfOEFFyT+YAonVz1eyjupiH/RlZcKc7JETSMPxcuqzIvxfZ68XzdWeNkfa5HR5od7IsIOzeZRcAIB6rpnFX5mEx8NeAd00hVYTLhZVe8ck4f/FAdgJudIwLrIeYfyRgkQOQ5l15m/TH/6Rp7E4mQyihsg0rdyV0Vlg4Hgndw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NVGgAqZN; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NVGgAqZN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776674574; x=1808210574;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7ZA2+RZNILcuGGWDhs2trqwiJhv6+KfLcFiT3A2uZnY=;
  b=NVGgAqZNv9B6OtFbl+cDvuLJfO0PMCLIgc5lk0OFCOtN8tSjJ3EOmQSP
   WGdxJykaaEvqy5xRjWY3TCMov7HcLD7vhkC2z0sLUgV/RxCNK88AiWZqZ
   goQYyxZZIitz39tNaCk8WJtkEDvuRql8jg2aUktb2P3BUWtMwmLI7zSOP
   bhreI0fGfD6JD63odvCSIGoU6MmTFBR/y6ZOHKkdD1y3Sq7VwWJtDZyTc
   iFeEdEplVlITq2Mcaot6OytcCqywnF3NRYtOeLUmhZh4QdpDklfhz4xtV
   mSSOMhGq6ZtmqOzx/JQFCI9NNV51sh0O+/3DNADzeiZ3g0gL4LTzO+UQW
   A==;
X-CSE-ConnectionGUID: /ykUPKIeTbaumvZaiPDgRA==
X-CSE-MsgGUID: VYdzpfIcRu+wLsZcbRVxqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="65118479"
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="65118479"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 01:42:53 -0700
X-CSE-ConnectionGUID: qEkR2qfyQTqJjgF4e3VFxg==
X-CSE-MsgGUID: I7wV86QnQzmT3JI5P6pB4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="227027669"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.90])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 01:42:50 -0700
Date: Mon, 20 Apr 2026 11:42:48 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: jikos@kernel.org, jic23@kernel.org, srinivas.pandruvada@linux.intel.com,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: magnetometer: hid-sensor-magn-3d: prefer
 'unsigned int'
Message-ID: <aeXnCCp2QEzCa4SQ@ashevche-desk.local>
References: <20260419180523.37396-1-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260419180523.37396-1-joshua.crofts1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Apr 19, 2026 at 08:05:23PM +0200, Joshua Crofts wrote:
> Use 'u32' instead of bare 'unsigned' to resolve checkpatch.pl warnings
> and correct type use as defined in the hid_sensor_hub_callbacks struct.

"...in the struct hid_sensor_hub_callbacks."

> No functional change.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko



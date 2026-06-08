Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675923C0A1A;
	Mon,  8 Jun 2026 13:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780926993; cv=none; b=CGhZnRJuICTXs0Jt53klSiFLF6FdBWH7b/KcuD/V5H6V2o0dE3YPnHQ6doRS6gBLbKZxiPW0RZIQFcEiFi444pibI0IvddkzrKGJV+rCkg6MLlOCV8GZs/DtMgGkTbySQUViYPG1E6evgmr1XGNbIdOf0BvJbO5tkfDRBT63zZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780926993; c=relaxed/simple;
	bh=mZChzpBALuOo8q3IsSzfizdWfN9d3K1KQQqwG+WQ/Ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f0YLuUG3frQqETkY4WWPpx6gdY6tsJJH6dhB0CZPn5vs+ZvUMqC7VZD2oCjqsgHh9Zaq3SmZoTCzUdekwN0o1PTOmq1VuHyTUy6dy9tC3Ed+4bbd4J2utA/ddyFQWGMOP2PTMtkptPrtdp2/6O0rfbakMy3H8t9xg8GSiIfSGhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PUjeprA4; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PUjeprA4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780926992; x=1812462992;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mZChzpBALuOo8q3IsSzfizdWfN9d3K1KQQqwG+WQ/Ms=;
  b=PUjeprA4tiMS61F+k3xpLKee7jRLstUqT6dtVpTCz52soSeYfKOwXiq6
   Nj0gSN1xgymgP1qlcTUGOrH5qQXzk4yG+sAB/IuMwn0vm7d9tri9xpr3C
   W7Yq5mUB71yCSPDxieFeODGDzEEsmG7K2Q9szXf4n9/6ih+CwslQnNoBf
   /c0ulw4agsDG5EDJn5RSIUb7+5RbbifFZeHcpx9G0pbYAwvUqVkhklnn8
   8azXOrMDprIPvYyXtFshFZuz0BLhX4w3Uiq7UlUxYjW4bS+J5msiY1n+S
   Wn0DxVzJ+Op1BCYHGKVKJ3YlQW/Q2GPWocUCiVjyxzTzNnmoDc/5NHa+f
   g==;
X-CSE-ConnectionGUID: zSzT/7AVRzyXSMTkfOiVlQ==
X-CSE-MsgGUID: Pfe1G8Y8QvStCQUuH/vITw==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="80794079"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="80794079"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 06:56:31 -0700
X-CSE-ConnectionGUID: DKzpYk1kSh++Q8EeSQipZw==
X-CSE-MsgGUID: QsbmksH8SH+R1YhuSksVnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="245612089"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.110])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 06:56:28 -0700
Date: Mon, 8 Jun 2026 16:56:25 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Archana Patni <archana.patni@linux.intel.com>,
	Song Hongyan <hongyan.song@intel.com>, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	srinivas pandruvada <srinivas.pandruvada@intel.com>
Subject: Re: [PATCH 0/9] HID: iio: Fix race condition between callback
 registration and device exposure
Message-ID: <aibKCYSED2Yo2vqd@ashevche-desk.local>
References: <20260606-5-june-hid-iio-race-fixes-v1-0-27a848c5758f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606-5-june-hid-iio-race-fixes-v1-0-27a848c5758f@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Jun 06, 2026 at 05:07:09PM +0530, Sanjay Chitroda wrote:
> Hi all,
> 
> This series fixes a race condition in HID IIO drivers related to the
> ordering between callback registration and device exposure.
> 
> Currently, several HID IIO drivers register the IIO device (making it
> visible to userspace and other kernel consumers) before all required
> callbacks and resources are fully initialized, or rely on devm-based
> cleanup in a way that does not guarantee correct teardown ordering.
> This creates a window where the device can be accessed while it is
> not fully initialized or is being torn down, potentially leading NULL
> dereference or use-after-free.
> 
> To address this, the series ensures that:
>   - All required callbacks and resources are set up before the device
>     is registered with the IIO core
>   - Resource cleanup is performed explicitly where ordering matters
> 
> PS: This is prepratory series to convert all HID IIO driver to devm.

I haven't found anything problematic, but still would be nice if somebody can
reproduce the issue and test this fix. Code wise LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko



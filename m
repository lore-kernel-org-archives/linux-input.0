Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8CA34DB6D;
	Fri, 17 Apr 2026 11:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776425621; cv=none; b=dusE64c8utFAUVYONPIWlkz0wourmyMFWc2HNrjSCRVcAVQs0tPVUhNrMtXKbG8al+l0MW/MP/NtCwBNLn5CI+FqImvJPEuo8e8xiRuUWk3AtcjeC3OKcIHc0u5vyBCzUQUpGR73/7Ro3eJUNax2HpI87SVgCgKNV6kLmlgLtL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776425621; c=relaxed/simple;
	bh=/EvIpevwl/xCtpf9YIe3nTxFjQPC3FrRwx2kK5HEd/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBsahNHZSJElJyaxwLuCgC7nyJng02mxWHhl53so/PJjBOcEt5NY1AjsQzhTsaL+Uv7LJtnR+vOkkjB8g3GJpvGqdLu6y4/8Ua2hwvVd3PKVyfy6S+mM1de7HXkItdSd+83ezanwgFPJX3r+0hr5iZw62cE4KRQOWs+7ebbs5LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aXFTKaZs; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aXFTKaZs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776425620; x=1807961620;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/EvIpevwl/xCtpf9YIe3nTxFjQPC3FrRwx2kK5HEd/w=;
  b=aXFTKaZsctQ+GH2GOAnLekIXwOoUPMJBuw6Msv8EbnU/vkNzOlnBqiWo
   VNcaHzvaN+/nA/ZM8GR4HsSMX9oudZh0Wqas3cxm9xxONOt7+m7as2Fpf
   54TSO5PFJQBEo4vZxFnKTA71o+hI7G077tY0ngp7lmDpr9eTpo+VfV2TY
   vqHSruqDaYm7ipK1JkEM4f0eNrMXJp5tbaaZ4Gi1dTb6J/Qa8BF1bP7JD
   J06r5Dp4eKRc6T6FlAt/eVZddFt6nbPTmA594W3k6zzpNJiZR99sM4x63
   kc7C4emOScQ/b7OaBrB0Gyp8piuUytayPkyqZNWXNJ1IC0xLUScOYnOj0
   g==;
X-CSE-ConnectionGUID: VfjBAZhASRq1C12QCygrOw==
X-CSE-MsgGUID: ptenvT/BRvSi+bjxwBLNJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="77560696"
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; 
   d="scan'208";a="77560696"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 04:33:39 -0700
X-CSE-ConnectionGUID: NZ3US4bnRWe/kXQ5zW+0aA==
X-CSE-MsgGUID: rFmy5r5ASyajapTtPU5Hhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; 
   d="scan'208";a="254488484"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 04:33:37 -0700
Date: Fri, 17 Apr 2026 14:33:34 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: jikos@kernel.org, jic23@kernel.org, srinivas.pandruvada@linux.intel.com,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: magnetometer: hid-sensor-magn-3d: prefer 'unsigned
 int'
Message-ID: <aeIajr-NaBGdhvK9@ashevche-desk.local>
References: <20260417112808.1280-1-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417112808.1280-1-joshua.crofts1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Apr 17, 2026 at 11:28:08AM +0000, Joshua Crofts wrote:
> Use 'unsigned int' instead of bare 'unsigned' to resolve checkpatch.pl
> warnings and adhere to kernel coding style.
> 
> No functional change.

Please, use the same types as defined in the respective data structure.
https://elixir.bootlin.com/linux/v7.0/source/include/linux/hid-sensor-hub.h#L87

-- 
With Best Regards,
Andy Shevchenko



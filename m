Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B8F2F5A13;
	Mon, 20 Apr 2026 16:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776703837; cv=none; b=KntQ/+X5h3LKMRGvnalCKfDjL2Lkf0KzCiD1LQNA4YvTskU+3S0xpeEf1uaTxwIxnDvgo69pP9S2YqxwvgG5RTWh/jAYhe8GI9l/J2Zjn0qlFyppx4KzjBCqWvHp/XLlP7QN+0z/rwmAfrDFTMubCIRlPlKtbwF0vvklHZF4rt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776703837; c=relaxed/simple;
	bh=Kr6h74H8lz0vsV0jhb5XQdSGijgvq9UENV23oNMwFIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCUIUvtoAsZr87hBTH6pQGJl3wy9MGbsBWrtMSxF1ZcIEOEZ6LhxN69xqj2KubeSaK/RECImS6LyJQqCBaN+TxBbxLOyI8C8gnlo30UpQOzFxOO4EVJvyyq5iGyLHlM7UXojL0zfP4dWiZLQMQupX0BTOO8dO9cJi0P7x2XONuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NtqVqpLj; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NtqVqpLj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776703836; x=1808239836;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Kr6h74H8lz0vsV0jhb5XQdSGijgvq9UENV23oNMwFIM=;
  b=NtqVqpLjjYVI6x4gNQgCKttlHIeoZhJtjff0PrVcXH+Wt6vlhsG3nHVf
   fCitcjrGhABRFvhEf5wN453u8PBcwZwWhG+iM5b57Qtyw2Z5YvW71ibBb
   rKaCDEL86GRXsdx7RT9es1ygrRNosdnkVF1SK/wHsiM5ZJsPnUueICwcT
   +RWMjjK7RZjMwsX1mGTtW5xaH7o/31kGtFooAn4E5i0R268T2PxL+uWrA
   bLudvfPDBOlggEFohJOrUMZ6QAIzXTeOSV8x+GeG6b3itueQgn4BNcy63
   PR4jog0hjG14bs0hUDBBZi+1B8bE9typfvlYDsVfsD3r3GSILkhKih9iL
   Q==;
X-CSE-ConnectionGUID: unEBkKXyTxeLUWvPJKqBlg==
X-CSE-MsgGUID: r1ENBFsBS1uNYnU4fyoTdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77500308"
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="77500308"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 09:50:35 -0700
X-CSE-ConnectionGUID: m3oeEsfORrS2N62Iojd/gQ==
X-CSE-MsgGUID: OKIxIq1ESS6p/5vZY+3tBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="236140257"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.90])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 09:50:32 -0700
Date: Mon, 20 Apr 2026 19:50:30 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>, jikos@kernel.org,
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: magnetometer: hid-sensor-magn-3d: prefer
 'unsigned int'
Message-ID: <aeZZVgvfmQDVO5jm@ashevche-desk.local>
References: <20260419180523.37396-1-joshua.crofts1@gmail.com>
 <4e84f9cc258676ed038e1f932137f10f34064aca.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4e84f9cc258676ed038e1f932137f10f34064aca.camel@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 20, 2026 at 08:46:57AM -0700, srinivas pandruvada wrote:
> On Sun, 2026-04-19 at 20:05 +0200, Joshua Crofts wrote:
> > Use 'u32' instead of bare 'unsigned' to resolve checkpatch.pl
> > warnings
> > and correct type use as defined in the hid_sensor_hub_callbacks
> > struct.
> > 
> > No functional change.
> > 
> > Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> 
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

The Subject needs to be adjusted as well.

> > ---
> > v2:
> >  - changed 'unsigned int' to 'u32' per struct definition

-- 
With Best Regards,
Andy Shevchenko



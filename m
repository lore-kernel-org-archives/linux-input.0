Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DC1332ED6;
	Mon, 13 Jul 2026 16:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783958903; cv=none; b=K5CdAhVVPm7+jzAuTP0b1dJuE2puUI+wZVwirQkRpBFQSbpl0oNRMAFZqcyNOT97RIPwuoLO9npt8xQqfCXyG6t/VSjsHs72Og+09YpBHvbodoZbQW1BnWIAuzWt1uk2Mcjh1mJazhAc4/62TkWjyKPectUAn9EsIt8c3c0mdfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783958903; c=relaxed/simple;
	bh=g6zgsnmRfzssg/IhUUfra83Ig1hsskFvIjM8FAZy/lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDZDXJVfYjB0g8pS0jkcWUxx+43P6JcIxepGW8xRCVYQTImBx5w9lkbcsB5LyGj/QLLj5SPH0GTIOtgbLci0mlKQZsnbPZavCK8z87m1L1A4JXa1ys9SAkBmK2Y82cW6ezDFsMEIQLVGuseO9E+X4gjljse4TC+4JVR4zrUDNT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XNaFh+aP; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XNaFh+aP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783958902; x=1815494902;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g6zgsnmRfzssg/IhUUfra83Ig1hsskFvIjM8FAZy/lk=;
  b=XNaFh+aPAZazb+7j67vilRArNHFTVi6scS9q/ia9kJrgU/9i5rzQImew
   rK7IJ6opg0nrNmqJ5zNXCH6lSaP8hgsXnZR8k7yaR1SubGyhQgS5VW6ca
   ElWEzaUWSP0AiTEv03m9QIKVv3OiWfpyFee4fEZV2tQIBsfJzFK3xOwiI
   ywE5TFICRpQnQWXf2qmdNSrqwFA4itygO3n4HVIAZGXCeQw6V/01TorNf
   HbJ1Y+ayok6WoPdcRjREsvAGSCOf+JYjC38kqC8twXRLA79Cu27DuqD6b
   qycM8EXarC0y120aN/V8pm1195RPz710FmUwowd07tSLQ39Tqosiy773W
   w==;
X-CSE-ConnectionGUID: dRRYTKBYTVa6BBUgGvSEFQ==
X-CSE-MsgGUID: rRY0yOMPRTOMv00yAkKawQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="110116589"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="110116589"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 09:08:21 -0700
X-CSE-ConnectionGUID: riXMN8DoSUOMGCrbE1eY0g==
X-CSE-MsgGUID: c9K7f/7TS+mhcOf44sPCeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="256233662"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.88])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 09:08:19 -0700
Date: Mon, 13 Jul 2026 19:08:16 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Pan Chuang <panchuang@vivo.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Zhang Lixu <lixu.zhang@intel.com>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	"open list:INTEL INTEGRATED SENSOR HUB DRIVER" <linux-input@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] HID: intel-ish-hid: ipc: Remove redundant dev_err()
Message-ID: <alUNcCTsTCctMNi2@ashevche-desk.local>
References: <20260713132439.380121-1-panchuang@vivo.com>
 <20260713132439.380121-4-panchuang@vivo.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713132439.380121-4-panchuang@vivo.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 13, 2026 at 09:24:32PM +0800, Pan Chuang wrote:
> Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> devm_request_*_irq()"), devm_request_irq() automatically logs
> detailed error messages on failure. Remove the now-redundant
> driver-specific dev_err() calls.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko



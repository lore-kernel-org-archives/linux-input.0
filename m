Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A123DDDC7;
	Tue, 24 Mar 2026 12:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774354316; cv=none; b=JUQfOUiwVeBvB1p7Hae0yf1afytOz+n/aYqtFSAwscR6xWYg8g+kDUxFOOnE3rCxLJBb9NyvaSF+q0LAOKNBnmuBk4pSfBUgoBJ+QGBFylCuVsaVtMZmAs8Qa2qYE7Lm/7KzZlq0LSxhmOct4pLyorX668kULlDekam1NXujqVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774354316; c=relaxed/simple;
	bh=tnjgl7FshrcTDYjFxCRkvsQvHRM1Z2PmgQRVSmPHYHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2UYV+qfzmpi8p7UCQ/i1N7Tk9kDNfsc/kmPsITF6W2m38L/7w0XBIgxRfLAwmxplxVJjMSCE4cn01sVGTacQ5HR9XQLE6mQb2yS6aNHBnd+4uf9vwvRUla+zsOhP+Vgr1eEPTR2+QHrGpB1+uGAbWX/y9OpBYZtsaH2hFj4vh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CCgyt9Ex; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CCgyt9Ex"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774354315; x=1805890315;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tnjgl7FshrcTDYjFxCRkvsQvHRM1Z2PmgQRVSmPHYHo=;
  b=CCgyt9ExLQNZTpYE17OnSqsKbl8E9HtrdBtxmhykYswZuelg0t474kbS
   8NQp1KDTGOCuORIRJmiHEFQDNOM83eMqc+uSkr465Ex6fzF+U7X0xwsjH
   vi+OJQJn+Zgr7GM2qNzP/OUb8NF7B6QbKQ/wWoD+Fi37WTmo0vii3BWb5
   MWqwOmvDF4weNCcrO5ilZzesoPOgnjSFID7TGTdLTL9YUUUWVLQT8TBj/
   a5nhRL8M/+DKII/GLsYaUJEP14R4SFyhwEa2xey0OQ7qTryQVzJJd+ccZ
   COcA7XLRIlMvUZ0exSN+ZxJbo3tA6PgvHwPK6fan91FRMn78Gn2/zpdlG
   A==;
X-CSE-ConnectionGUID: 6o6ExiLeT4mmhU/6YxZadg==
X-CSE-MsgGUID: CYbAwCqOTPa7tnW73jjpKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75558566"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="75558566"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 05:11:54 -0700
X-CSE-ConnectionGUID: UGJTvI9pTAeFWI3Ipg4R4Q==
X-CSE-MsgGUID: 6RYjJXnxTay+/hHYtKF3PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="224303459"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.214])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 05:11:52 -0700
Date: Tue, 24 Mar 2026 14:11:49 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: andy@kernel.org, hansg@kernel.org, mchehab@kernel.org,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: penmount: bound packet buffer indices in IRQ path
Message-ID: <acJ_hbhH-XeRokDY@ashevche-desk.local>
References: <20260323121715.74954-1-pengpeng@iscas.ac.cn>
 <20260324022950.456-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324022950.456-1-pengpeng@iscas.ac.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Mar 24, 2026 at 10:29:50AM +0800, Pengpeng Hou wrote:
> 
> This was found during static code analysis of the packet receive path.
> 
> About the fix: my reasoning was that once pm->idx has already moved past
> the valid packet buffer state, the current partial packet is no longer
> usable, so the safest local recovery is to drop that stale state and
> resynchronize from the current byte. That is why I reset the index before
> storing the next byte.
> 
> I did not choose to ignore the IRQ entirely because the interrupt has
> already delivered a byte, and simply returning without resetting the stale
> state would leave the parser in the same invalid condition for the next
> interrupt. Resetting the index seemed like the smallest change that both
> prevents the out-of-bounds write and lets the parser recover cleanly.

Good, (summary of) this should be in the commit message in the first place.

-- 
With Best Regards,
Andy Shevchenko



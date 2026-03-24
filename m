Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14124175D53;
	Tue, 24 Mar 2026 13:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774360083; cv=none; b=ug5fxg03yEvWaynEkVaTziOLa9S6OePPu5qS3hjeLtXAz2PDgtQyL++zl9SXjHNOVpdqr+2jREHVv18GIdsYCAgxzsALe4FDQLCtDLyP3ABPfYcyhob7wVTOlDgOasP5xthWkvgKlCcqxk/KLlqyyDGF6uQmY/EIR+EZWT9BoP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774360083; c=relaxed/simple;
	bh=qKemQUdSMi1g3Wok7SDBDFaxHb9r4JQE6a5wgQbCG5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rjdK0uxZgOqXa+29aFX16HtFOqpHnwcxBeMBbNWRZoitOXQR7MRwZPSC5OduGJpbAnyI59d1gAOEV8HPWadG+VEF8wOGj2fNMxbSo1tvF9AmjewBvWqi1udGPZa5ibbW/nK2AZ2QCbSLDIzBsGe4YtKlgraA0J51tdIB+Fg1194=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FaXoiwmZ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FaXoiwmZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774360082; x=1805896082;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qKemQUdSMi1g3Wok7SDBDFaxHb9r4JQE6a5wgQbCG5M=;
  b=FaXoiwmZzeE6i3IJhwJETAskLb9uME9FdaUFRZ/8glDbjveI+xdmXwwA
   xvNWCAzKHHgJJ+9lMDWXYqQQkpf6tAIO+TJQcLCPkJ1ui0xFHSbbvj7/A
   9eIEOzARXiMCTFBWdOGaoY9Ozw1irkuY5WSixboCPVydinhXMjkxHhg2U
   HZ6nBuvBW8ZwatLkNr1mEGsWLmw/BoYiS5tBjbOzpK1rpIR53F5vmAnbO
   aDbpuVih6klszof9SoaJq0546Sg6IbVl1ce+ptLw3vLQLXU1P8uDRivPs
   q7famSZOUj0xaO3xpWJb7LW9MwvRuTtkv6FkOGuLLOoCyHf2t/sF2hQ9+
   w==;
X-CSE-ConnectionGUID: 55vajkA5SR2rxfJEmkB6lA==
X-CSE-MsgGUID: mOYRHNOUR8qdwAj0BpM2iQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="100818783"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="100818783"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 06:48:01 -0700
X-CSE-ConnectionGUID: kNfx5JYBQXGnxDgY5UTCnQ==
X-CSE-MsgGUID: 112h2g6fTWyEcZ5aXtCkIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="221459529"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.214])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 06:48:00 -0700
Date: Tue, 24 Mar 2026 15:47:58 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: dmitry.torokhov@gmail.com, kees@kernel.org, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Input: penmount: bound packet buffer indices in IRQ
 path
Message-ID: <acKWDo9ocJWb0QiT@ashevche-desk.local>
References: <20260323121715.74954-1-pengpeng@iscas.ac.cn>
 <20260324131442.27632-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324131442.27632-1-pengpeng@iscas.ac.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Mar 24, 2026 at 09:14:42PM +0800, Pengpeng Hou wrote:
> pm_interrupt() stores each incoming byte into pm->data[] before the
> packet parser gets a chance to reset pm->idx. If the incoming serial
> stream never matches one of the expected packet headers, pm->idx can
> advance past the fixed receive buffer and the next IRQ will write beyond
> PM_MAX_LENGTH.
> 
> Reset stale indices before storing the next byte. Once pm->idx has
> already moved past the valid packet buffer state, the current partial
> packet can no longer be trusted, so the smallest local recovery is to
> drop that stale state and resynchronize from the current byte instead of
> carrying the invalid index into the next interrupt.
> 
> Found by static code analysis.

Missed blank line here. No need to resend until maintainers ask explicitly for
that.

...

The explanation sounds sane, but I'm not familiar enough with how this device
works. In case others consider this good, feel free to add

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



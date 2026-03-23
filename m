Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0953AB29C;
	Mon, 23 Mar 2026 13:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774272735; cv=none; b=DQSBPxyHyOHL2SoYULuZ9r2BWokhvQVBahs5kY8NApDtPYlkgSJ3AFLqb6ia6NE0eU6cVllMZnjbGfoaR6GOXrDct1hyX4tQ9amyheL3SCppUYwFtfWGeVgYNwCz2GNcZy0XmJQsqPebgteIsjCWW3r4eycRJC9Duu83dlKjHqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774272735; c=relaxed/simple;
	bh=Ypio/85DEPgW2LwF7Y0rssSrQEaqx51IjmDfIqBqEhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kC4/r9Jo7Uc8EVeO50Lj6sIKWL6mGuI+WM+j0qB6xGeIIRU2aeNIiuNpIYoNLzmx76Zm2l10guaID8QyvLOeHLKnD87NOyKopK5ZAH+a1WTBnxwaPfj1vDT/zJx5v51tdGtR2Uf2dfzgFikhpfIlyMQyrwvHg5L4rW9Ar83/0Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=huNJr8m1; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="huNJr8m1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774272734; x=1805808734;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ypio/85DEPgW2LwF7Y0rssSrQEaqx51IjmDfIqBqEhM=;
  b=huNJr8m1Wic9tj4YZH5lIpJzxGtPLenhDVJI6vj757pjp1v7YNDvdYAB
   +XFfsV91uauqFjVznLrlcs+ePeFHZYr/WKVBQR3qegjCWF0Mn8ZNZRGU4
   MzSr5SfcIn50tLmIFQccnVejXnA375yCF2bT6if+fvpN2Rq8PucAJNkE5
   cHKWoDGC+SUNq4YSNfasJx71Lfojath75lSMcoNd/ujkb3SVN2a7kAApO
   WIP9DV7vt2bM9jSi66ecZk0bFDXWpgVu8Hpk3msABsTWe5/yzm3GVZSVp
   m62//WDNZieBLKkruEphI47Tgjcn7qWYMC5XrTkt1i0zo4GxFKrwvzA7Y
   A==;
X-CSE-ConnectionGUID: iPsFhSvzTpqYAgZE1FAT3A==
X-CSE-MsgGUID: xO8skVpTTxiL4m/bOK2a3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="75151205"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="75151205"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 06:32:14 -0700
X-CSE-ConnectionGUID: NFi387UQRzi6mVmWWAb2Hg==
X-CSE-MsgGUID: Ll3lV9OISvi5zSo5zyMYUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="223097070"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.22])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 06:32:12 -0700
Date: Mon, 23 Mar 2026 15:32:09 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: dmitry.torokhov@gmail.com, kees@kernel.org, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: penmount: bound packet buffer indices in IRQ path
Message-ID: <acFA2aNGcdI_y9IS@ashevche-desk.local>
References: <20260323121715.74954-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323121715.74954-1-pengpeng@iscas.ac.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 23, 2026 at 08:17:15PM +0800, Pengpeng Hou wrote:
> The IRQ handler stores each incoming byte into pm->data[] before the
> packet parser gets a chance to reset pm->idx. If the incoming serial
> stream never matches one of the expected packet headers, pm->idx can
> advance past the fixed receive buffer and the next IRQ will write beyond
> PM_MAX_LENGTH.

How did you find the issue? Any assistance?

> Reset stale indices before writing the next byte so malformed packet
> streams cannot walk past the end of the local packet buffer.

Why do you think this is the best possible approach? Maybe we should
simply ignore IRQ or handle it without any further actions?

-- 
With Best Regards,
Andy Shevchenko



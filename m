Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A8D38D400;
	Thu, 10 Sep 2026 15:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789054348; cv=none; b=e16IBPRAsLREwF0Kl5LinSinMY2ME/w84JwQYLKI4WqEibB63haOU5Yg4qLu8q6PZ/NYGxXaYFwSCOVlJpg7KUQ4vHE9Nv9MIOzPhDpqMGel+uz1rnhivXwDqiJ2kosAr8rjbbjhXUG/okDc3f5znCKL3gytsgQl8uEGbWuOEjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789054348; c=relaxed/simple;
	bh=liGLw2jy2S+Tg2RAR32Z7q/17QAS4fuYBykh8PXbOlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYsvVJ1MxhETM8rOMLPXx/9ej9fzTWS7s6FfhXSTYaOEPAbhkG0hxbyYkjhsa+mFB2ovGoGEGfygA1hg31iMHKLfkzuN4sKPB8f+pBNG0dL40KPbLlZSDuqcL76AkT4akFIrmAGep1mIvw/Aj8BgGEcgSwxcNkViQJ+i7ehU2b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ns1d0iTk; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ns1d0iTk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789054347; x=1820590347;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=liGLw2jy2S+Tg2RAR32Z7q/17QAS4fuYBykh8PXbOlU=;
  b=ns1d0iTkcGPJ4Sfbm9Q3A20GB37YL/HBfF0o5PJB7hOELtAyL0faf8Bd
   2x1Rdwyc5fqxbcWnuS4/a8j9jzy9J92Kt4PL4YtE8151Iv7/mUmX0PDD6
   rd70tNoCTXlg6Wqj1GiUOMRFn8KzQg/ym+dYE05s1W6696Y98X3GPksFD
   8qBnLSjEtOQ3EeUpNLXTCUwj1BjrMD+COZLw4mLpk8nyAr7HzgPI+NNsm
   8KjTQ+NT3XQk6T9OnZjiKwO8PltdmvcqgM0XPY5RmWaieNT12v8n9tJ8K
   h+hf3v8ysXIQW2FHnetmVCfAVqwCLEb3OYZBISbVTk3Z8408pF0tOetK3
   g==;
X-CSE-ConnectionGUID: 3EC+2+5lRpOl8QD5t/7EFQ==
X-CSE-MsgGUID: xTdQwshBSu+dLuggGkhMMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="88449055"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="88449055"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 08:32:26 -0700
X-CSE-ConnectionGUID: cE2Mk/7CQT2Zn3kO493YTA==
X-CSE-MsgGUID: p6tWx1bPQimIqbQmD7hRjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="276907925"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.177])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 08:32:24 -0700
Date: Thu, 10 Sep 2026 18:32:21 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Yibo Tan <lhfff@tju.edu.cn>
Cc: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Zhang Lixu <lixu.zhang@intel.com>, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] HID: sensor-hub: synchronize multi-value read
 cancellation
Message-ID: <aqLNhbbpWEQZmbzl@ashevche-desk.local>
References: <20260910112338.4171983-1-lhfff@tju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910112338.4171983-1-lhfff@tju.edu.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 10, 2026 at 07:23:38PM +0800, Yibo Tan wrote:
> sensor_hub_input_attr_read_values() publishes a caller-owned buffer to the
> raw-event path. If its interruptible wait times out or is interrupted, it
> clears pending.status without taking data->lock and returns.
> 
> sensor_hub_raw_event() may already have observed pending.status while
> holding that lock. The caller can then release its buffer before raw-event
> finishes copying into it.
> 
> Take data->lock when cancelling the request. The raw-event path now either
> sees the request retired or finishes the copy before cancellation can
> return.
> 
> On an uninstrumented PREEMPT_RT kernel, a valid 16-byte quaternion report
> overwrote a live futex waiter's plist node with the report's 0x41 payload.
> Two vulnerable runs produced the same general protection fault in
> plist_del(), after 471 and 91 completed trials. The locking fix completed
> two 10,000-trial runs without an Oops, panic, warning or payload signature.
> 
> The virtual provider setup and FIFO assignment require privilege. The IIO
> read, signal handling and futex operations run as uid 65534 without
> effective capabilities. No physical-device or normal-priority hit was
> tested.
> 
> A source reproducer, kernel configuration, complete serial logs and the
> vulnerable/fixed result table are available at:

> https://github.com/kimaiden1984-boop/linux-kernel-poc-collections/tree/main/cases/hid-sensor-quaternion-root-a

Make it a Link tag and refer in the text like [1].

Link: ...$URL... [1]

> Fixes: f784fcea4506 ("HID: sensor-hub: Add sensor_hub_input_attr_read_values() for multi-byte reads")
> Reported-by: Sashiko <sashiko-bot@kernel.org>

> Link: https://lore.kernel.org/r/20260610083849.067A11F00893@smtp.kernel.org/

What's this for? Make sure you have a reference in the text (see above the example).

> Cc: stable@vger.kernel.org
> Assisted-by: Codex:GPT-5
> Signed-off-by: Yibo Tan <lhfff@tju.edu.cn>
> ---

...

> +++ b/drivers/hid/hid-sensor-hub.c

> +		spin_lock_irqsave(&data->lock, flags);
>  		hsdev->pending.status = false;
> +		spin_unlock_irqrestore(&data->lock, flags);

Seems legit. Can you also amend the kernel-doc of this lock at the top of this
file? Currently it says

* @lock:		Spin lock to protect pending request structure.

I would replace the tail and make it

* @lock:		Spin lock to protect struct sensor_hub_pending request data.

-- 
With Best Regards,
Andy Shevchenko



Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9E52FD1DA;
	Wed,  3 Jun 2026 13:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780494171; cv=none; b=ptWcYRJRfCiRtPsofQ8DPUHdHzf6NDuHdal4sttO+MynaarzZMW0esEdfRCpI9Z7H8u+rGhcDxl3iI8/WRP4GTcuBMDQ4WmfKtKTC5ZdoR1UnY0EziWI+BY3HmuOvYnrgp9g8k1+7kbQXfwSgp4jrVYLktABvsZlPLoaV2kH3sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780494171; c=relaxed/simple;
	bh=rMKZjBP7AuEpr0QSYrK0D98BzJfCMoK06rqueXVej4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2xbv3kNjyNyOxZFhvqGD+7X8nLXzTrTqA8uG/sxmsPs85mgAUnIVEK1t5BGmo9rBMzmRmH8iRX6+0D0tlB0rODDuvS8qCrBjoYI2LGkjWoHmS3ySRaos6EV4WM6VsGmjJwFX38FRe841pOI0qZe9bHCGS+/o7UwPo73UrV3xqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PDLxHu9x; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PDLxHu9x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780494170; x=1812030170;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rMKZjBP7AuEpr0QSYrK0D98BzJfCMoK06rqueXVej4U=;
  b=PDLxHu9xe376yuShu8S3jvElj5Y7ouFbW2TP7NET9ZR1sZJKy6ShBST8
   +86C2RnZrdzfkivgVp76ofwv7Hb0mqcAwsYLymNSlDr/q3H8JIic7MQUy
   IUgQ486Hfs6SV3UJl4rxOo3mIjpZFtLp1b7jCmAzmBRd8ZOmj71DxVfLa
   /wOTUwYMj6e645xSrAARtwovxyTp8SeNarj2vmN5TzloMwDxW8zu1601f
   IwRSsIb5QKsrJc68FLyMPZummAfnZVoqzZhdCI+64B/bfwiFT4O//SeRD
   juC/YeUVoc8tfUydTfegEceTANHwktSsh6BUgijd+9svCdInBujKTHjZV
   g==;
X-CSE-ConnectionGUID: cWqEZhBnQoqthDRtddNhhA==
X-CSE-MsgGUID: 4h4xbSOLTBmz1KnAe3IOHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81485257"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="81485257"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 06:42:49 -0700
X-CSE-ConnectionGUID: llsCtjQkRNSxywrZs3B2yQ==
X-CSE-MsgGUID: ZEP5mG5nRMy+dQpm16d/sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="240067059"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.250])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 06:42:45 -0700
Date: Wed, 3 Jun 2026 16:42:43 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>,
	"Daniel J. Ogorchock" <djogorchock@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	Tamir Duberstein <tamird@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 2/2] HID: nintendo: Use %pM format specifier for MAC
 addresses
Message-ID: <aiAvUw7uWBv8bf0-@ashevche-desk.local>
References: <20260603104351.152085-1-andriy.shevchenko@linux.intel.com>
 <20260603104351.152085-3-andriy.shevchenko@linux.intel.com>
 <aiAXraQh-IrbAe0C@beelink>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiAXraQh-IrbAe0C@beelink>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 03, 2026 at 02:03:01PM +0200, Benjamin Tissoires wrote:
> On Jun 03 2026, Andy Shevchenko wrote:
> > Convert to %pM instead of using custom code.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Not sure where the first patch should land,

Up to the maintainers Petr and you, to me it makes no difference.

> so in case someone prefers having the full series through their tree:
> Acked-by: Benjamin Tissoires <bentiss@kernel.org>

Thank you!

-- 
With Best Regards,
Andy Shevchenko



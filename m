Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0D1282F05;
	Fri,  3 Jul 2026 12:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783083147; cv=none; b=e/+ZFg/O6kabVJiY1NySXK+0UdxvOMc7maS4nIJrbWSyBgkrxKg+65dDtNe4sjYWEUoOh/BetBVoQ9wur9UHX8I/K+eT1vcRNhuKgn3lTFuAuTL1SMeh7UlqIBqage9fSMkf4eIREDgqsMYmQcNqI7j74k/ON/wga3XHR3zVUkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783083147; c=relaxed/simple;
	bh=xxY/sOqY3kDarmmSy7xP9tXH8ROvZuygysh5bVmeV2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBG/86vLf4l1ow4xoLuGzfHiPTkwJIOQNUBy+H2zq4hsJz9qu/wKweB4Hh6DnyG6LMXmep0CECmTSahga8m6sqKjLKWGDD8juq8vT5MIgLxJ4HjOY9Kn2x10d6k/9yUGbum7IX/kdyUvCVJ9jeKlWvyd/6HYWfb/YpFKVihjUvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eENhz+Rz; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eENhz+Rz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783083146; x=1814619146;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=xxY/sOqY3kDarmmSy7xP9tXH8ROvZuygysh5bVmeV2I=;
  b=eENhz+RzUaqQ2bu1cK6OxDhM4QTh4LTkDlN/vRZOnGPW8uaNA0dggIqh
   pBUsbLA1OtQy47R5k95do2YohCNSXzmRV6mCKAI6ixt+MBnByTGgvrM0B
   yxI5l7v/GC+JFSuNTLVqTomWt6/mswskKxxDfIIjJxQTLMW2GmJRrNPme
   VcFO1g3L/UM93Prgg01QdDdaNewJm6RsSckG1fAGkvukNmdhUfz6YaI/D
   9hjFs5u9TiJdaGehlqx6eeGPkR4QMKCN3BVfVukSvE233vCARi+KJ3CUj
   0oBOuM0Rjeaj/EMUch0Qdlnvchho0t7jHGi3dbqclErw7Ae7IDjQg5gtX
   A==;
X-CSE-ConnectionGUID: XNTFOLETSaO8wKFNdkF1Sw==
X-CSE-MsgGUID: qOPh5sFuRXqp3pZU1TJDWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="101380430"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="101380430"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 05:52:25 -0700
X-CSE-ConnectionGUID: NksTJBxmTGOK37GFoLf7+w==
X-CSE-MsgGUID: lSl6Xf9nQzCa6rOyjbqrSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="251388198"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.80])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 05:52:23 -0700
Date: Fri, 3 Jul 2026 15:52:20 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>,
	sanjayembeddedse@gmail.com, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: Re: [PATCH v2 2/6] iio: hid-sensors: align function parenthesis for
 readability
Message-ID: <akewhE9wEpU6UW0u@ashevche-desk.local>
References: <20260702-15-jun-hid-iio-alignment-v2-0-b87f01f5efbc@gmail.com>
 <20260702-15-jun-hid-iio-alignment-v2-2-b87f01f5efbc@gmail.com>
 <20260702182015.303db93c@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260702182015.303db93c@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 02, 2026 at 06:20:15PM +0100, Jonathan Cameron wrote:
> On Thu, 02 Jul 2026 21:47:59 +0530
> Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org> wrote:
> 
> > Adjust alignment of parentheses across HID sensor IIO drivers to
> > improve readability and maintain consistency with kernel coding style.
> > 
> > While updating the formatting, group related arguments consistently in
> > multi-line function signatures where appropriate.
> > 
> > No functional change intended.
> 
> Whilst I appreciate this code isn't quite in line with standards
> and usually like that stuff to be fixed up, in this particular case
> this is a massive amount of churn.  That churn will make backporting
> fixes etc messier, so I'd like input on whether others consider this
> one worthwhile.  Jiri, Srinivas, Andy etc. What do you think?

I am fine as long as Srinivas is. I understand pros and cons of this, but from
time to time we have patches à la this one that messes up with backporting but
were accepted as a good part of some bigger series.

-- 
With Best Regards,
Andy Shevchenko



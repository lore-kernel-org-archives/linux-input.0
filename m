Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6548F477999;
	Tue, 21 Jul 2026 10:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784629246; cv=none; b=SXUXhypxfzLJJj1+miyATZTA2EwdR+c15OIzw+EHumGUPmHnSZdNM5SS3ovp7AZmTgo2n2MJivrZwL3A2WwduGZcEgTYI9XyqjHW4RpT779dI7BvE++LbuO8ocKUsDNKN6ITXEZvtYkTOY2jydsn27RkV0e9WI8jpYNUCkFlGrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784629246; c=relaxed/simple;
	bh=BuikVx7La/9chV7s1hxXnMG7wdWI9UN7BDknLSFwfoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mv/nbyiL6NTp1VIr1PXwMMTEjZgfuEF8BFFH6tjt58cxADgo7Ny29vn+GuVHAVvJOYTfbTYfVGF8bZcW8dA234zizQuLF0gKLByb9nLHzqfQmMtsUjdeL6/dmgId2CjY6AgmJzavyczqsW+Ml7k2Cjdf5z8fgVwR76/O4TLnEeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=klVErddC; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="klVErddC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784629245; x=1816165245;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BuikVx7La/9chV7s1hxXnMG7wdWI9UN7BDknLSFwfoA=;
  b=klVErddC1PjfrsptqTnbGGK9EjiDmwDAb05TIdYDZRiBZkYwyDg9MLY0
   BQBEf1/ioFsqq9FqOSUfaffkuZtgVc63uMMb2BLX3ZvkAbWsF9o0DtlZY
   GQGl2y0F2ybfWuDQQQRteILaB1gg81v7c4OD9s3CNoe/AL+M/k7/QGLlS
   VNVEM594NQWRk9Gdkb052X//OUtQ/U0KR9yZv0ZCpNwyN6Z05gZnb+r3k
   ExYunKpNUrVCHBqofQejxbLI57vpVCGo8OTM2THW2lz2KSg7WCsLlg72C
   iKCv6C+sukT2y63jihDYyluoA+HiVZENvXSvBKZqW/LFzKQXYoTuLVg2e
   Q==;
X-CSE-ConnectionGUID: QnUOiliQTHGYGRgPyY69TA==
X-CSE-MsgGUID: oa9eloVISIyNf3qLVVKgmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="72760701"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="72760701"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 03:20:44 -0700
X-CSE-ConnectionGUID: emV8fJJ2RYaoLii1C2v5Wg==
X-CSE-MsgGUID: 735o4J9fS5Kac9BFspqMGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="257793437"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.67])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 03:20:41 -0700
Date: Tue, 21 Jul 2026 13:20:38 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	chrome-platform@lists.linux.dev, linux-input@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/9] Input: elan_i2c - sort include statements
Message-ID: <al9H9rn7Y2qtIJ80@ashevche-desk.local>
References: <20260721075226.2347933-1-wenst@chromium.org>
 <20260721075226.2347933-3-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721075226.2347933-3-wenst@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 21, 2026 at 03:52:16PM +0800, Chen-Yu Tsai wrote:
> Sort the include statements before adding new ones in the next change.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



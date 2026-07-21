Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B4B3B47F3;
	Tue, 21 Jul 2026 10:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784629448; cv=none; b=NbX+ebZ4s2hBbYWqGBD6XRUCh+ZhmsJ0VnzPJFlt3kDhCriWAINzEh1zIIHiQJNAeUTCf1DihDBhOKwSiEb4GDHu7yd8o3olJPvhBbZBxVRiA7lu2WejEqrMSjzsarHwzDe82GBz/Du3u/VYl4WwkMFHEVt9+0840prKG5+aQ9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784629448; c=relaxed/simple;
	bh=VMK1c+/vKVbSVeoy8U+5qlX4JI006aD0Z1nIkGcjxis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBjBsxyxODB+dCW52vQP9nwADDD7/KURoJ0xwpL9v2E+g2nzZecSdpUBublDc+lzdU1sjgEhveWUH44ij6EP19ArCPftHjXFFYkaj80ki8BgfukHbLeuK7RNCt+bH8MPmiOGsqmDmh4CTc+vyi6MeRfHfmqLWye/gYsKn9RPjqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P+n6hoyO; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P+n6hoyO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784629447; x=1816165447;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VMK1c+/vKVbSVeoy8U+5qlX4JI006aD0Z1nIkGcjxis=;
  b=P+n6hoyOtlfdCOZ6WunxNi6UdS5tJmR90BRgrsUhtYvGjDCFBj4v11Wo
   TSgOpo4UZHJ7UJ6KWsG0GYNfhE5INvHh40+jjjwulINZtxrvZ0IpcrN6+
   FJxHj0azXasa824qH0Q6IyR5B0B+rx2SUVjkf1JghK0yeH1ObW9RpDYyR
   PfgUojDvpkV9KgdA/MoOLIq55ex5FtTE/0y1L4baya5yBad1hJzL1BqTQ
   BmI3PDpyOtPQLmvVJ3zGANkRbepSkldx58IRc4zimyCW9YrMW9Z+02wF9
   v9yl4MVS+BBs6J+VjjG62qgABRPO1DkB64+tY1FnY+G2xT3FR0AbjTYxh
   g==;
X-CSE-ConnectionGUID: WZ31u38xQjiaq5YYMxVhrQ==
X-CSE-MsgGUID: nYXf2vbHSxuprvH+7zZiDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="85263568"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="85263568"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 03:24:06 -0700
X-CSE-ConnectionGUID: /9LtnjzdQa6SVnzQ5fbYLQ==
X-CSE-MsgGUID: Zn8wz1zZSvOS4lf+f8rYAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="262662523"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.67])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 03:24:03 -0700
Date: Tue, 21 Jul 2026 13:24:01 +0300
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
Subject: Re: [PATCH v3 6/9] i2c: of-prober: Defer regulator_disable() on
 successful probe in simple helper
Message-ID: <al9IwVR7Whw2DiXU@ashevche-desk.local>
References: <20260721075226.2347933-1-wenst@chromium.org>
 <20260721075226.2347933-7-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721075226.2347933-7-wenst@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 21, 2026 at 03:52:20PM +0800, Chen-Yu Tsai wrote:
> When a I2C component is found, it's device node is immediately enabled.
> This triggers device creation and driver binding. The prober will hold
> the regulator enable reference across this part. If the driver probes
> synchronously, then it happens within this window. On the other hand,
> if the driver probes asynchronously, there is high chance that it
> happens after the prober's cleanup function was called, in which case
> the regulator would have been disabled when the driver's probe function
> is called. This would then require the driver to wait 100 ms for the
> hardware to reinitialize, even if the probe function was just a split
> second late and the regulator was disabled a few milliseconds ago.
> 
> Recently, some of the drivers for the component that are targeted by the
> I2C OF component prober gained the ability to skip waiting for hardware
> initialization if the regulator was left enabled. This happens when the
> PMIC has them on by default, or if the component prober left them on
> after probing the component.
> 
> Wait a bit of time before dropping the enable refcount on our end so
> that the actual driver has the opportunity to catch and increase the
> refcount on their end. The 100 ms delay was arbitrarily chosen.

...

> +	/*
> +	 * Wait a bit of time for async drivers to probe and increase the
> +	 * regulator enable count. This allows the drivers to check and
> +	 * skip waiting for re-initialization.
> +	 */
> +	if (defer_disable) {
> +		dev_dbg(dev, "Deferring regulator disable\n");
> +		msleep(100);

How was this value chosen?

> +	}

-- 
With Best Regards,
Andy Shevchenko



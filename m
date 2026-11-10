Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794340563;
	b=2ujy/mVZN78cxyofrCVPtwgR8Us+ofzj2ihN0aNCDQctU27bzr/jFR6ju449nqLi593t
	 4pD/kMB8upjr8kX9MzkNu7r2Z48oydio4U1DDixbkg2PnjQ83/0c5lTifK6Dhi//Y7/uT
	 aSgT/2/HJBsn8An0NTCUaqHiLB0ikBb5c9JBCP2tORkNy7O+7xUTVTXVoOygepizsVeQR
	 7ULTDz+rt2fXC1qNoMMUKMGSHpE4wtu8wCP/3nhTC80KWrT78Q6FtM3U6zRyK+Rz9WW68
	 1i6J+hxHF/csd/f6/omvRwXNhX/2ZtPaLniHKatjL90g62eX56Qtndr7n+yCr+zR8/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794340563;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=EvDHKFgV8ZaR6tQMOPWNUyoThgdxDYzb5iXOrSl5e8U=;
	b=K8Ro9beGS9upmBxB+uWZVnIG5Wf2EJEVoPAVzSAS4jUwPcGskmtlmMFLPIOs2pOLR58v
	 Gxc8uLPMdGhoFw6EDD0bPjAStUMG7gwESaqEagRFrXQAPDR6Ka0Vas2DYJ0ZZrTT9Xy+3
	 +2EudXKDtcBAUYXaMufagmJXPBUkiUprvCuZVX3XhzlH6lPEn8Z7OlRBwnYwNxSIOSn21
	 AaT6AzyxZ7plr5cyYlB7CbaXGZWShHq541rjVySW5xl8UKW/1eUhDlrjjJfvN1MQHayR+
	 GOn6SKp1nQ9A4r+JjDszldk2e2NPvAzcRspdGPumOFVKp2wJ0h/NChtvYOEl4VLga+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="k4BC/V6X";
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E242E606A320
	for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 19:56:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E242E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=k4BC/V6X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794340562; x=1825876562;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m2q7AnzczYOYpAe+axWWNA1iiCjtiSlvZAa2pLt/beM=;
  b=k4BC/V6XAUpg5s5K177BDT27refgQgjZjTaUH5usjsaYEqOPWyj1C/zo
   Dky54yT0kuMGahMYHi1BXcFIyMXtBxXq4mHx8jljO+S3dL5mszlMUgWcD
   6LMUlXO5QbT/DI1G0Nxr80mM2QaMcSGN2ir6BkqBh43PwYKNEMK7/Jk5I
   ylD8sm8o7UZSVjOck16slUyJbIE8so2ilHgzGpcnq/jx7W2aX66R1gL+4
   JIP/v7dlEaHR/LtBHMrc92oHiIGlRcLghVm/jcyj6PNEmotUj+e49fLeu
   pcWs76weMk8haugOhdLEmRo7K3LYpTe7d2pMS4vHv+7FFaho+ltyn3cGH
   A==;
X-CSE-ConnectionGUID: SjLsnzUWQvaDSlOqFu76OQ==
X-CSE-MsgGUID: N+2sZmGkQdCW242aiiut0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3007763"
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="3007763"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 11:56:01 -0800
X-CSE-ConnectionGUID: 1oz1SDdtRJKzbxYwW4DAQg==
X-CSE-MsgGUID: +9GbqhM2QMm1g8OhlfpJyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="8135397"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 11:56:00 -0800
Date: Tue, 10 Nov 2026 21:55:57 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Danny Kaehn <danny.kaehn@plexus.com>
Cc: Jiri Kosina <jkosina@suse.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Subject: Re: Firmware Support for USB-HID Devices and CP2112
Message-ID: <avN2zfSvXs3OOFX4@ashevche-desk.local>
References: <20260520-cp2112-dt-v14-0-b1b4b6734b6f@plexus.com>
 <autpMnQT8t0Ecu-m@ashevche-desk.local>
 <20261110185603.GA102891@LNDCL34533.neenah.na.plexus.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110185603.GA102891@LNDCL34533.neenah.na.plexus.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 10, 2026 at 12:56:03PM -0600, Danny Kaehn wrote:
> On Wed, Nov 04, 2026 at 07:19:46PM +0200, Andy Shevchenko wrote:
> > In lieu of this discussion [1] I just realised that CP2112 misses the
> > documentation piece under Documentation/firmware-guide/acpi/ on how
> > it's supposed to be enumerated. Danny, can you add a such, please?
> > 
> > [1]: 20261003095924.1370238-1-thierry.reding@kernel.org

> Apologies about the delay here -- getting an environment set up to send
> kernel email always takes some time :)
> 
> I will target getting something sent out for this by the end of the
> week.
> 
> This can wait for the review of course, but since it seems like
> this is a relatively unblazed trail (ACPI "binding" documents for
> specific drivers), do you have opinions on whether a directory tree
> should be started for driver documents like this? (i.e. an i2c
> subdirectory?), or would you prefer it just be added to the top-level
> directory? It seems like there also isn't yet a naming convention for
> these -- presumably the "silabs,cp2112.rst" name would be too
> "DeviceTree-ish"... maybe "i2c-silabs-cp2112.rst" if kept at the
> top-level...

Hmm... Since you rose this topic, I think we can move i2c-mux ACPI
documentation to i2c folder and create there the support for that specific
hardware in DTish naming schema.

-- 
With Best Regards,
Andy Shevchenko



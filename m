Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794331263;
	b=d3gAM5nArld1TULIXnV1RBSRwhMFWuzx3zQiTe2hT1YankmJf4ssJSsqh8oJi5mnn69U
	 cE8WJW8znjivPyFdRfBYvGjkhPun0iCZsoac0j6D/9gFapNU/LYjShIW73DPc5AOyltL3
	 nyaHuEXNQn36ZT5yKL0YhWNZRXLfa9uxTEGAHW2SjYbitVO+hW5Cm7jDfXQuIMBJGhRGi
	 MmXyNFRLCbReabWFRYfjSlhS3C1qGQpGUAsQCmu67Tj4vD7YUlTcdKCvnSD76mZNbPhRI
	 KILFeR+eUUhjxPxp3LmJoI35UmmvAFDbq2KPlR830Z5+eeIgZa+n553oUzhltulxFJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794331263;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=jhWlGU6sdGMIbL8A3mvtXb9qb6dmuOuSfQM/jO/Czyw=;
	b=j/k8zGWeANf1mngaTnJQ4TZ4WfBrtlB4mbpsMLFtkl/WQeF0lQMRWkDRpAE2M7yJSi8U
	 LCW8aMyzZ40QWmN40Lj98KtkFpfITdAODtjwrhSYKqjCsj6FJpfxQC2OZZX+WUg5XAyrB
	 djrcVUtIJg/xp313/rF9gkOGCtUYUTHaKpioZda47L6yTtdDJxBz28D/34C2xARqExlvK
	 djqAMz2zzUE2WKN84ACbSbj6CNxMvTpStkvfLTTS1bPbhfiCKfNPluJ4gaAuzS7H7dpXP
	 hDklRtFcvYLLfCCuFGG9jypSJ69sCFKB3apvn+ecVjizR26mpyI5zAmiKT/VgnLwqGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kFPQmdA3;
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA3B606A321;
	Tue, 10 Nov 2026 17:21:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCA3B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kFPQmdA3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794331263; x=1825867263;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vA1ZEofqWJ38453xjUJ/JXSJtuSTOtOU6lPIkoEWzvc=;
  b=kFPQmdA3YYZfsuFPrkta/VhCdbfqfJ2heksVxG7xfzZU1MLlpbCJjaRI
   mupfZeugRJo2Xz79K2SVj5hKyVo+OHwS0VIV5RepgGSflpvKDTaFvjzbF
   eMx3Rrc8QeDIR46d0/R/P3Cgc/Aj/6wxfK3vZukbA7itzb0rVXJ72mp03
   rPSukWl2Dzwrj7eH+Jp630XXHE6tbJ2bauosySa4aQKxn8wDVX4tS8uuB
   xlZUlqtBvczI3EODz6YSLqseNTfJksA7mmI9gRAReiruOFlTJxKNx2sai
   iAcqTaR0E/a5LZNi4zUyMiH6gG6cKAuYwwjs7/lEM7AK81w/CoqhvzoXi
   A==;
X-CSE-ConnectionGUID: /L/4WPpYQcet9d04+NK96g==
X-CSE-MsgGUID: AO9A1KloThugCIQpBUIXqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3090277"
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="3090277"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 09:20:06 -0800
X-CSE-ConnectionGUID: MtCkQXpLQVe733T53cMUpQ==
X-CSE-MsgGUID: 2DRsMvZ6Tq+RE6qUGkGueQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="8071528"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 09:20:02 -0800
Date: Tue, 10 Nov 2026 19:20:00 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: HoroTW <git@horotw.dev>
Cc: jikos@kernel.org, bentiss@kernel.org, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com,
	andy@kernel.org
Subject: Re: [PATCH] HID: i2c-hid: acpi: Add Dell Latitude 7400 2-in-1
 touchscreen power quirk
Message-ID: <avNSQJFlT96Qomkn@ashevche-desk.local>
References: <010201a1c63771e5-dbbba1f2-8a9f-4dbc-8901-c60927cf5a56-000000@eu-west-1.amazonses.com>
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
In-Reply-To: <010201a1c63771e5-dbbba1f2-8a9f-4dbc-8901-c60927cf5a56-000000@eu-west-1.amazonses.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 10, 2026 at 04:08:04PM +0000, HoroTW wrote:
> On the Dell Latitude 7400 2-in-1, the Wacom touchscreen (WCOM48CA) does
> not work after resume from S3. Resume runs into I2C timeouts for 4 to 37
> seconds and then fails:
> 
>   [37928.985861] i2c_designware i2c_designware.0: controller timed out
>   [37928.986100] i2c_hid_acpi i2c-WCOM48CA:00: failed to change power setting.
>   [37928.986340] i2c_hid_acpi i2c-WCOM48CA:00: PM: dpm_run_callback(): acpi_subsys_resume returns -110
> 
> The controller has a power enable on GPP_B21 and an active-low reset on
> GPP_B15.

Oh, cool! Do you have access to the schematics?

> The firmware sets both up at boot, but ACPI does not describe
> them: TPL0's _CRS only lists the I2C bus and the interrupt, and there is
> no _PS0, _PS3 or _PR0. After S3 the firmware leaves both pads low, so
> the controller stays unpowered and in reset. pinctrl-intel does not
> restore them either, as it only saves pads that the kernel has requested.

Oh, can you bring the excerpts from /sys/kernel/debug/pinctrl/*/pins file
for B21 and B15 before the suspend (working case) and after (non-working),
so we can see their configurations?

> Add a DMI quirk that provides the two GPIOs through a GPIO lookup table,
> and power_up()/power_down() callbacks that sequence them like i2c-hid-of
> does: power on, wait, release reset, wait. Holding the GPIOs from probe
> makes pinctrl-intel save and restore the pads, and power_down() drives
> them low first, so power_up() always starts from the powered-down state.
> 
> As far as I can tell from the BIOS image, the firmware waits about 9 ms
> after enabling power before pulsing reset, so use 10 ms. Starting the
> first transfer less than 3 ms after releasing reset makes SET_POWER fail
> with -121, while 100 ms and 1000 ms both work; use 200 ms for some
> margin, as I could not find a datasheet value.
> 
> As the touchscreen is not a wakeup source, the controller is now also
> powered down in s2idle and for hibernation.

> Tested on a Latitude 7400 2-in-1 (BIOS 1.39.1) in S3, s2idle and
> hibernation (pm_test=devices).

> AI notice: I threw an AI coding agent against it which wrote most of
> the initial patch, I reviewed everything, directed the investigation
> and ensured this is a minimal patch. The agent ran the initial tests
> (via a KVM switch), and I tested it on the device myself as well.

For now this paragraph should go after '---' line below.

> Signed-off-by: HoroTW <git@horotw.dev>
> ---
> 
> Notes:
>     This is my first kernel patch, so sorry in advance for anything I got
>     wrong; I would be glad about any feedback.. I tried hard to match the
>     required ettiquete.
>     
>     Background: the Latitude 7400 2-in-1 is a nice device, but it has
>     issues with S3 sleep. As I did not have much time, I threw an AI coding
>     agent on it and steered it in the directions that looked promising,
>     until it found out what goes wrong and how it could be fixed.
>     I reviewed all of the code and tried to keep the patch minimal,
>     while keeping it readable and oriented me on how similar cases were
>     handled before.
>     
>     - I looked at i2c-hid-dmi-quirks.c and tried to follow its pattern (DMI
>       match, then device name), but kept the table in i2c-hid-acpi.c, as
>       only this driver uses it, and did not add a bigger structure for a
>       single device. My thought was that if more models need this, the
>       delays could move into the DMI match data, as i2c-hid-of-elan keeps
>       them per compatible. I'm happy to rework it if you would prefer it
>       differently, e.g. in i2c-hid-dmi-quirks.c or drivers/platform/x86.
>     
>     - The GPIOs are only requested for the quirked device and with named
>       con_ids, so as far as I understand, gpiolib-acpi will not fall back
>       to _CRS and pick up the touchscreen's GpioInt.
>     
>     - I did not add checks for the return values of the GPIO writes in
>       power_up(), following i2c-hid-of; i2c_hid_core_resume() ignores the
>       return value of power_up() anyway.
>     
>     - Only the Wacom WCOM48CA panel was tested. The DSDT can also describe
>       other panels in the TPL0 node; this quirk does not cover them.
>     
>     - Test setup: Latitude 7400 2-in-1 (SKU 08E2, board 0HCNR3, Core
>       i5-8365U, touch controller 056A:48CA), BIOS 1.39.1. S3 works with the
>       BIOS "Sleep Mode" set to "Force S3" as well as "OS Automatic
>       Selection". Kernel v7.2.14 with i2c-hid.ko and i2c-hid-acpi.ko rebuilt
>       with this patch: 7 S3 and 5 s2idle cycles, hibernation freeze/restore
>       (pm_test=devices) and a driver reload. After every resume the touch
>       resume callback returned 0 in about 315 ms and the controller answered
>       HID GET_REPORT; finger input worked after S3. Without the patch, one
>       S3 cycle reproduced the failure. The patch builds cleanly on v7.4-rc2
>       with W=1 and sparse.
>     
>     - I was not sure whether this is suitable for stable... (I think it is?),
>       so I did not add a Cc: stable tag and would leave that to you.

-- 
With Best Regards,
Andy Shevchenko



Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D950538E8B9;
	Tue,  4 Aug 2026 09:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785835878; cv=none; b=TW49/F1/Hv7rVjZ3HmR16USECRUdFYE4O3CPlB2HWycoVCDzkK98NOOo5oaeVqrbOU/tz0xVx587fE+GLIS2cNpPfXfUbJlo2XRbRGnPs2hUuGElJ+XHI0stoE5Fnq6cqm/S/lR/6Tk52K23KbgVg0KKuycVgEMMIxFKNNjaYqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785835878; c=relaxed/simple;
	bh=SvhAFQKo0L2Xf0Mrn7YvwV7QtrLUDpBUYPhtf7tQd+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXdaQnjXW/ntZ838qPGlZtVaddkmvoDGq5iwxjoddadjEbIlEJ0HAqBKryMVmnzRttS5vuXnUPbCcF7R06N4MGUErkyCLaLiwjCxLZ9Fxtb1FKiGn5njSQzhaE9c/fnADKaqKsTWc8Q3nhuI9Wer8HN7As5ojs10sNIN2668YI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 5368F200048;
	Tue, 04 Aug 2026 11:31:13 +0200 (CEST)
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1wrBUP-002qKg-0o;
	Tue, 04 Aug 2026 11:31:13 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1wrBUP-0000000AUTU-0c5e;
	Tue, 04 Aug 2026 11:31:13 +0200
Date: Tue, 4 Aug 2026 11:31:13 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: sashiko-reviews@lists.linux.dev, robh@kernel.org, 
	linux-input@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 4/4] Input: Add TouchNetix aXiom I2C Touchscreen
 support
Message-ID: <ujewi7j52r5vtgofpkg26brbh767onsahwknuiify4ikyltsev@7gufjzgpeqfd>
References: <20260703-v6-10-topic-touchscreen-axiom-v7-0-0d2a550a7ee8@pengutronix.de>
 <20260703-v6-10-topic-touchscreen-axiom-v7-4-0d2a550a7ee8@pengutronix.de>
 <20260702224804.E0B0D1F000E9@smtp.kernel.org>
 <anFxs8grhvIVSdNA@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anFxs8grhvIVSdNA@google.com>

On 26-08-03, Dmitry Torokhov wrote:
> On Thu, Jul 02, 2026 at 10:48:04PM +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 18 potential issue(s) to consider:
> > - [High] Missing bounds checking during firmware chunk parsing allows malformed firmware to trigger integer underflow and out-of-bounds memory accesses.
> > - [High] Invalid cast of regmap buffer to u16* causes endian-dependent behavior and corrupts register addresses.
> > - [High] Unbalanced pm_runtime_put in firmware upload cleanup leads to negative PM usage counts.
> > - [High] Firmware-controlled allocation size allows out-of-bounds heap read when checking touch slots.
> > - [High] The driver prevents firmware recovery when the device boots in bootloader mode by improperly failing the probe.
> > - [High] fwupdate_lock is held across system calls violating kernel mutex semantics, and is double-unlocked on error paths.
> > - [High] Improper devm teardown order causes Use-After-Free of the input device by background firmware upload threads.
> 
> I am not sure this is true as sysfs attributes should be removed iand
> handlers complete before we get to remove() method. 
> 
> > - [High] Use-after-free of ts->input in the threaded IRQ handler during config firmware updates and device removal.
> > - [High] The driver waits on completion primitives for hardware resets and saves without reinitializing them, causing future waits to falsely succeed immediately.
> > - [High] The driver passes stack-allocated buffers to I2C transfers, which violates DMA requirements and can cause memory corruption.
> 
> This is Sashiko's hallucination.
> 
> > - [High] NULL pointer dereference in `axiom_remove_axfw_fwl_action` if `devm_add_action_or_reset` fails.
> > - [Medium] An operator precedence error in subtracting the preamble and postamble causes the calculated report payload length to be artificially inflated.
> > - [Medium] Probe error paths leak PM runtime references and fail to disable regulators.
> > - [Medium] I2C read errors are swallowed and falsely reported as success in polling functions.
> > - [Medium] Missing NULL check on `kasprintf` results in a crash or broken sysfs state when registering the firmware upload interfaces.
> > - [Medium] The driver lacks system sleep power management callbacks, causing the device to remain powered on during system suspend if not acting as a panel follower.
> > - [Medium] Dead code in `axiom_register_input_dev` prevents failing initialization when no touchslots are enabled.
> > - [Low] Typo in the sysfs `device_state` output violates the documented ABI.
> > --
> 
> However there appears to be quite a few items that need addressing.

Already on it.

Regards,
  Marco

> 
> Thanks.
> 
> -- 
> Dmitry
> 

-- 
#gernperDu 
#CallMeByMyFirstName

Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |

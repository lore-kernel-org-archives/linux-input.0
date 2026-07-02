Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6112A3BBFD1;
	Thu,  2 Jul 2026 23:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783033917; cv=none; b=oFS4MHoYDFAtqdsXKjx4Yts6VS+qr/y33o0m+YvULlJKfqHJMQBCgp3eS1EkvRv1yDGOgN4n3DIRmM3u6G2rRrINVKyQWoywLb0OtXGMsi6An0nb07D4Z4mOAVy7cwRaFUaHPYmxqIu12WS2n2Al5MqohNe7WY6Ub33U3ZDNKts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783033917; c=relaxed/simple;
	bh=wUdP+CNy1ketiNH4C1ATkD4qoY0ELdNQyFMUu54Uo0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=REZJz8kFXF2RqhfMWB6G18EGgxA5jllA5RgaQdJuKxOJNT80ww7EITgCjBteOjIMOKw3JYjFrztb04e6mO5c7T0zueuRe7clI24k5mSyv8DEyBqi7qQqKbSwcrxRU46hNa9mEeluTkxcAL7tZUumDQ+ExLp4zP6lQgJo5+X0koQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 34352202596;
	Fri, 03 Jul 2026 01:11:53 +0200 (CEST)
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1wfQZV-005ogT-0Q;
	Fri, 03 Jul 2026 01:11:53 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1wfQZV-0000000DX7d-08rt;
	Fri, 03 Jul 2026 01:11:53 +0200
Date: Fri, 3 Jul 2026 01:11:53 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: sashiko-reviews@lists.linux.dev
Cc: dmitry.torokhov@gmail.com, devicetree@vger.kernel.org, 
	linux-input@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org
Subject: Re: [PATCH v7 1/4] firmware_loader: expand firmware error codes with
 up-to-date error
Message-ID: <nwxv6xkeey324ftvgj6g6eq43rz7zautmjro4fi2tmd2vh35f6@fahpuuvaqhg6>
References: <20260703-v6-10-topic-touchscreen-axiom-v7-0-0d2a550a7ee8@pengutronix.de>
 <20260703-v6-10-topic-touchscreen-axiom-v7-1-0d2a550a7ee8@pengutronix.de>
 <20260702224537.0823C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260702224537.0823C1F000E9@smtp.kernel.org>

On 26-07-02, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] The selftest script for firmware uploads does not inject and test the new 'firmware-duplicate' error.
> - [Low] Missing ABI documentation for the newly added sysfs error string 'firmware-duplicate'.
> --
> 
> commit b451d666b20500e69051bac63ead44572b79d708
> Author: Marco Felsch <m.felsch@pengutronix.de>
> 
> firmware_loader: expand firmware error codes with up-to-date error
> 
> This commit adds FW_UPLOAD_ERR_DUPLICATE to allow drivers to inform the
> firmware_loader that an update is not required. It also updates the
> test_firmware module to support injecting this new error state.
> 
> > diff --git a/drivers/base/firmware_loader/sysfs_upload.c b/drivers/base/firmware_loader/sysfs_upload.c
> > index efc33294212fd..82c4b1fedf4cd 100644
> > --- a/drivers/base/firmware_loader/sysfs_upload.c
> > +++ b/drivers/base/firmware_loader/sysfs_upload.c
> > @@ -28,6 +28,7 @@ static const char * const fw_upload_err_str[] = {
> >  	[FW_UPLOAD_ERR_RW_ERROR]     = "read-write-error",
> >  	[FW_UPLOAD_ERR_WEAROUT]	     = "flash-wearout",
> >  	[FW_UPLOAD_ERR_FW_INVALID]   = "firmware-invalid",
> > +	[FW_UPLOAD_ERR_DUPLICATE]    = "firmware-duplicate",
> 
> [Severity: Low]
> Since a new error string "firmware-duplicate" is exposed to userspace,
> should this also be documented in
> Documentation/ABI/testing/sysfs-class-firmware?

I checked the firmware-invalid which is also not documented. I could add
2nd patch to fix this if this is urgent.

> 
> It looks like the new string is missing from the allowed error values
> documented for the sysfs interface.
> 
> >  };
> >  
> >  static const char *fw_upload_progress(struct device *dev,
> 
> [ ... ]
> 
> > diff --git a/lib/test_firmware.c b/lib/test_firmware.c
> > index 7459bba65444d..a822d9641eb4c 100644
> > --- a/lib/test_firmware.c
> > +++ b/lib/test_firmware.c
> > @@ -1134,6 +1134,7 @@ static const char * const fw_upload_err_str[] = {
> >  	[FW_UPLOAD_ERR_RW_ERROR]     = "read-write-error",
> >  	[FW_UPLOAD_ERR_WEAROUT]	     = "flash-wearout",
> >  	[FW_UPLOAD_ERR_FW_INVALID]   = "firmware-invalid",
> > +	[FW_UPLOAD_ERR_DUPLICATE]    = "firmware-duplicate",
> 
> [Severity: Medium]
> Does the test script also need to be updated to exercise this new code path?
> 
> While this properly adds injection support to the test module, the hardcoded
> errors list in tools/testing/selftests/firmware/fw_upload.sh does not appear
> to include "firmware-duplicate", meaning the kselftest won't actually
> inject or test this new error type.

I'm not sure how much sense it is to have a test reporting this error.

Regards,
  Marco



> 
> >  };
> >  
> >  static void upload_err_inject_error(struct test_firmware_upload *tst,
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260703-v6-10-topic-touchscreen-axiom-v7-0-0d2a550a7ee8@pengutronix.de?part=1
> 

-- 
#gernperDu 
#CallMeByMyFirstName

Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |

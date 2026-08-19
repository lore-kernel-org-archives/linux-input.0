Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F1B39BFF2
	for <linux-input@vger.kernel.org>; Wed, 19 Aug 2026 20:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787170512; cv=none; b=s0py4Y7WIf9kjP1wNjZrBPnmq6cY4Y+V1+SgHavqK0p2ebYyvc/YZY2IYsX2igkOUTJtUk7ryTWwJhRdPntSOB9jt143mrKVW1U34J0KYP9u4tfTKKLCt7v0qzy5TIfpJJmzOCTZx0AywdtAnf+g1OHefpMvQZxO568a1ZdVy+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787170512; c=relaxed/simple;
	bh=UWxgTQ3Z6AJKOMgjNRGC9vLjwbm4a8eQ+EpPd7DeVrE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tD9IkCglrKPN1l5whwyGgQEItSrJMeWp/QXKAin7Ea8TFCdfbmO8L3QiDhcUvWHNsCrwzHmv089zb1d10Tx7/xIGMnaOnLFGNV59aIDXjwKHhUDb63C5dNsBXsDmFSyQEPgaLdUgdF01pW6Quiw4OOltbe/Bh3OAEMsGYOLABdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cisl7bx0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cisl7bx0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F3C1F000E9;
	Wed, 19 Aug 2026 20:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787170508;
	bh=3CQC6FtIfSY59l8GncxS/x90HAEyzc5XvRh2b1X/19I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Cisl7bx031XO+Clsfb0qfToYfMcUdzh24iLWeVtVH8pRxGGpNIcjLOolv/7aBPJ63
	 58MK3Z6tLiB62mzr6ncEXtPadM2A0vRCSNlcrT3OAl5OiKJA+VAFabmA+mvoFNVlYs
	 SKYTxow5aVjPex4vLCf8evgeXrtD2omcuHkz5WIZ30TIo+/NONSBApT2AzTfv6TeEE
	 fEsy4BUr1Wrf+eAGRQHypnAwwcpkIzEIkrRpHAfdn+xvCFdJBXGhj1FSiuMXCk0QGb
	 vwUb+ORhs0exw4YfAWjUvNkPjg75GOhwQfdp7CqvGIXPSDlMM40ZjRnotYPXq1Waw5
	 tdZd7yO/NOaDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/12] HID: asus: add joysticks inner and outer range
 configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260819195835.1649657-6-denis.benato@linux.dev>
References: <20260819195835.1649657-1-denis.benato@linux.dev>
 <20260819195835.1649657-6-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 20:15:08 +0000
Message-Id: <20260819201508.83F3C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing `intf_mutex` lock in `ally_set_joystick_thresholds` allows=
 concurrent HID requests to interleave and corrupt device state.
- [Medium] Joystick threshold sysfs 'show' functions do not check for hardw=
are support, returning a dummy default value even when the feature is unsup=
ported.
--

--- Patch [5]: [PATCH v2 05/12] HID: asus: add joysticks inner and outer ra=
nge configuration ---
commit 2e6189717a427b3132c324a798d81ea6224e0246
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add joysticks inner and outer range configuration

This commit adds sysfs attributes to configure the inner and outer ranges
for the ROG Ally joysticks, allowing userspace to modify sensitivity.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 6b005afe01a24..d028697f61bfd 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
[ ... ]
> +static int ally_set_joystick_thresholds(struct hid_device *hdev, struct =
ally_config *cfg,
> +					u8 left_it, u8 left_ot, u8 right_it, u8 right_ot)
> +{
> +	u8 payload[] =3D { left_it, left_ot, right_it, right_ot };
> +	int ret;
> +
> +	if (!cfg->xbox_controller_support)
> +		return -ENODEV;
> +
> +	u8 *buf __free(kfree) =3D ally_alloc_cmd(CMD_SET_JOYSTICK_DEADZONE, pay=
load, sizeof(payload));
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	ret =3D ally_dev_set_report(hdev, buf, ROG_ALLY_REPORT_SIZE);

[Severity: High]
Does this need to hold ally->intf_mutex when sending the report?

Other configuration functions like ally_set_xbox_controller() and
ally_set_gamepad_mode() use ally_gamepad_send_packet(), which safely
acquires the lock before calling ally_dev_set_report().

If called concurrently with a USB reset (where ally_gamepad_check_ready()
holds intf_mutex but not config_mutex), could this interleave between the
set and get report phases and corrupt the device state?

[ ... ]
> +static ssize_t left_joystick_inner_threshold_show(struct device *dev, st=
ruct device_attribute *attr,
> +				      char *buf)
> +{
> +	struct hid_device *hdev =3D to_hid_device(dev);
> +	struct asus_drvdata *drvdata =3D hid_get_drvdata(hdev);
> +	struct ally_handheld *const ally =3D drvdata->rog_ally;
> +	struct ally_config *cfg;
> +
> +	if (!ally)
> +		return -ENODEV;
> +
> +	cfg =3D ally_get_config(ally);
> +	if (!cfg)
> +		return -ENODEV;
> +
> +	scoped_guard(mutex, &cfg->config_mutex)
> +		return sysfs_emit(buf, "%u\n", cfg->left_deadzone);
> +}

[Severity: Medium]
Should this check cfg->xbox_controller_support before emitting the value?

The corresponding store paths return -ENODEV via
ally_set_joystick_thresholds() if the hardware doesn't support the feature,
but the show paths seem to return the default initialized values regardless
of hardware support.

This appears to apply to all the joystick threshold show attributes added in
this patch.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819195835.1649=
657-1-denis.benato@linux.dev?part=3D5

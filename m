Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6410B4AB1BC
	for <linux-input@vger.kernel.org>; Tue, 15 Sep 2026 17:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789493082; cv=none; b=PbRXvFTr87rTqW7YMkHuWOYyZ83aT7rH21BkDVyypW1XwUH7BYmeHQIHJKw4N2clDezD9sZJ1Krgi7TBcyV28C6H9kAP4Frz/lnC7mpDMD1/shCCArBeA236BACHApIfQqLvG5ecTZ4QaqzxWnGHhfLZK7VsyBe/A1p/Pp7PrB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789493082; c=relaxed/simple;
	bh=zQ5hkf9aYabbjEwCRXOMXb+3BskapnW6qrBBy315R+A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FKyiCoAGvWXYPt+6hF0eeuZIGBXQw/NA6Mz4lHr53cyWJHMYZhFpBYM3ObRcX8Yr7ZWUBEnlW5sXfE6PuJkAs83NFjApyT3LW9XIJ3G/kFZGfxLu93vbiTzGGSMiOEjBCKALTQ4aVrPX3492+XQ8rlgrBW4x0XN5iABIsiKAh+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZJ6CsX6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZJ6CsX6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ACB31F000FF;
	Tue, 15 Sep 2026 17:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789493080;
	bh=N9v7KBbQ7VFwubj5iTibih22Mz+iiq/9rXa+gII2lTU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mZJ6CsX6YAS84ICUCJ06E5nIDjtPcYCbXDfd4HB6+jbk/bam1aFCeDXSor3k6JEBC
	 18eeaCWYVezAuiLkb/rP4x9HOCPC4LkqHyZoupXHHsna2ezB3o+X3rR6H+VWu6uVbP
	 fIxjEZET4gPm5y/S5z0NQiHWgIl1JPvOYLOBJFAT3g4fZtvNHPmX0tmXqR2MC4BC89
	 SR6AZr/AVrn6oV6CcvQdcneLQ8ovYoDq3aVXck0tKNe2K5duUpvkkl4Baxt3ELlcyV
	 H20WsnRpcLKVGlQWWOkluw1f8dKN3/6gUJ3Cv2o441mre9MnQWmybPwgEfhiTDmS4F
	 B83Kn2JTErzZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/2] HID: flydigi: add support for vader 5 pro
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260915171425.11058-2-denis.benato@linux.dev>
References: <20260915171425.11058-1-denis.benato@linux.dev>
 <20260915171425.11058-2-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 17:24:40 +0000
Message-Id: <20260915172440.9ACB31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] hid: flydigi: I/O on stopped hardware during probe error path
- [Medium] hid: flydigi: devm_power_supply_register error code is masked
- [Low] hid: flydigi: missing Kconfig dependency on POWER_SUPPLY
--

commit 31540c0ea898a7ef0b58eb15e340ebc735efebe9
Author: Denis Benato <denis.benato@linux.dev>

HID: flydigi: add support for vader 5 pro

The Flydigi Vader Pro 5 is a gamepad with additional buttons and a gyroscope
that connects to a PC via its own USB dongle. This commit adds support for =
it
by spawning two evdev nodes that share the same unique ID, allowing SDL to
expose them as a single controller.

> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index a81bf51cbcf10..3f080d59a897b 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -1205,6 +1205,14 @@ config STEAM_FF
>  	Say Y here if you want to enable force feedback support for the Steam
>  	Deck.
> =20
> +config HID_FLYDIGI
> +	tristate "Flydigi game controller support"
> +	depends on USB_HID
> +	select INPUT_FF_MEMLESS

[Severity: Low]
Since the driver unconditionally uses power supply APIs like
devm_power_supply_register(), does this Kconfig entry need a
'depends on POWER_SUPPLY' dependency?=20

If a user builds with CONFIG_HID_FLYDIGI=3Dy and CONFIG_POWER_SUPPLY=3Dn, it
appears the build will fail with unresolved symbols because the power supply
APIs do not provide static dummy implementations for that configuration.

> diff --git a/drivers/hid/hid-flydigi.c b/drivers/hid/hid-flydigi.c
> new file mode 100644
> index 0000000000000..b6d57080fed8f
> --- /dev/null
> +++ b/drivers/hid/hid-flydigi.c
[ ... ]
> +static int flydigi_register_battery(struct flydigi_device *fd)
> +{
[ ... ]
> +	fd->battery =3D devm_power_supply_register(&hdev->dev, &fd->battery_des=
c,
> +						 &psy_cfg);
> +	if (IS_ERR(fd->battery)) {
> +		/*
> +		 * flydigi_report_battery() only checks for NULL, so packets
> +		 * received while the probe failure unwinds must not find an
> +		 * error pointer here.
> +		 */
> +		fd->battery =3D NULL;
> +		return PTR_ERR(fd->battery);

[Severity: Medium]
By setting fd->battery to NULL before returning PTR_ERR(fd->battery), doesn=
't
this cause the function to always return 0 (success) on failure?=20

It seems this will mask the actual error code (like -ENOMEM) and leave the
device partially initialized when devm_power_supply_register() fails.
Consider storing the error code in a temporary variable before nullifying t=
he
pointer.

[ ... ]
> +static int flydigi_probe(struct hid_device *hdev, const struct hid_devic=
e_id *id)
> +{
[ ... ]
> +err_stop:
> +	hid_hw_stop(hdev);
> +	return ret;
> +}

[Severity: High]
If probe fails after hid_hw_start() succeeds (for example, in
flydigi_register_sensors or hid_hw_open), could this error path lead to I/O
on stopped hardware?

Since fd->removed is not set to true here, when devres subsequently unregis=
ters
the gamepad, it will trigger flydigi_gamepad_close(). Looking at
flydigi_gamepad_close():

	/* Stop the motors right away on close. */
	if (!removed)
		mod_delayed_work(fd->wq, &fd->rumble_work, 0);

This will enqueue the rumble worker because removed is false. The rumble wo=
rker
then executes:

static void flydigi_rumble_worker(struct work_struct *work)
{
	...
	if (removed)
		return;

	flydigi_send_rumble(fd, strong >> 8, weak >> 8);
}

This appears to call into the HID transport (hid_hw_output_report) after
hid_hw_stop() has already shut down the hardware, which could lead to URB
submission errors or use-after-free in the lower-level transport driver.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915171425.1105=
8-1-denis.benato@linux.dev?part=3D1

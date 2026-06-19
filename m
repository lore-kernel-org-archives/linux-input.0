Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4202D3815F9
	for <linux-input@vger.kernel.org>; Fri, 19 Jun 2026 12:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781872161; cv=none; b=EsbebPwhiGNLFFQ7pnXLTqh2e1kZWjRLsDNHmoNBlBIK1YnvwGYE6PgVqxMUFW4xY3nQQfEWJtPsf3LQZJ6lPGJfJ3kYuupYqZMpUzT69Bmg5vZhDSMCeqgmHzXZDFpR1lJIKyD5qDoYAaYxEo8MlSaf6RCmVc2Q+eC6Hq6Dhbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781872161; c=relaxed/simple;
	bh=i9d9VmOb6yKmrqNWnEoJ77lxzslzr0DhajRlKHZ+Iqc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L9i1XiD7rz4ZYqezXZV1B62d8SLGuk18GzTNFHTL9fXgAGe/ccNo7qYOabpAcmrS0vivzn3fMSn1wx3cqcEOT6SbeTX48ghy6HshUomC11TXx/iHbPBOUpKqRajIZKma20nUWRaf+cDX60UqV8kCNbjNHqHtroR1TsWZPl+gGBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=luSlZYWG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="luSlZYWG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D5B1F000E9;
	Fri, 19 Jun 2026 12:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781872159;
	bh=wHB2wmY1m9eYeF5ujbJ1KUHQEYX/+SWvaHvm49AxXwM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=luSlZYWGeO6ZhftKGfzeJBwFN59FiSN87YalEhLcfdjqf98zFYHSs4bCSDE5Ivavo
	 U43pS3ejW8lVOizBjpV+aztgH4CzhJy/gDqinmHuqP5cFMK0sAl98g/t2J9ifef4+i
	 iaYBfdkTEcfl1xPstk2ow6zx8xvbngTrb+VGctiNIkNrRwsWmO1vXpsuPlMHNqvm62
	 axF3yKIt5caByTioghKRzV1hu3biIwqOvqQ/1WB4G/DskGKxtyeSGrXu7WPUMMpSgL
	 nEeSHicCDn274WnNAxF7BmbKcCbjeEwTjA7rHgUbZVocU0mqDN/Z/pn5fLgox4Tgb1
	 ZSPmI6OW8VPGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: xpad - add support for Azeron devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Roberts Kursitis" <roberts.kursitis@azeron.eu>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260619121901.17926-1-roberts.kursitis@azeron.eu>
References: <20260619121901.17926-1-roberts.kursitis@azeron.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 12:29:19 +0000
Message-Id: <20260619122919.B3D5B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] The patch inadvertently introduces duplicate device entries and bre=
aks the documented sorting order of the `xpad_device` array.

Pre-existing issues:
- [High] The newly supported devices permanently wedge the driver's OUT end=
point upon connection due to an unhandled -EPIPE stall on the LED packet.
--

commit 82abb48f58f1b666ded31cf35205e5974880b177
Author: Roberts Kursitis <roberts.kursitis@azeron.eu>

Input: xpad - add support for Azeron devices

Add USB Vendor and Product IDs for the Azeron devices (Cyro, Cyborg,
Classic/Compact, Cyro Lefty, Cyborg II and Keyzen).

> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index feb8f368f834e..82019cbe2a9c7 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -292,6 +292,14 @@ static const struct xpad_device {
>  	{ 0x1689, 0xfd00, "Razer Onza Tournament Edition", 0, XTYPE_XBOX360 },
>  	{ 0x1689, 0xfd01, "Razer Onza Classic Edition", 0, XTYPE_XBOX360 },
>  	{ 0x1689, 0xfe00, "Razer Sabertooth", 0, XTYPE_XBOX360 },
> +	{ 0x162e, 0xbeef, "Joytech Neo-Se Take2", 0, XTYPE_XBOX360 },
> +	{ 0x16d0, 0x1103, "Azeron Cyro", 0, XTYPE_XBOX360 },
> +	{ 0x16d0, 0x113c, "Azeron Cyborg", 0, XTYPE_XBOX360 },
> +	{ 0x16d0, 0x1192, "Azeron Classic/Compact", 0, XTYPE_XBOX360 },
> +	{ 0x16d0, 0x1212, "Azeron Cyro Lefty", 0, XTYPE_XBOX360 },
> +	{ 0x16d0, 0x12f7, "Azeron Cyborg II", 0, XTYPE_XBOX360 },
> +	{ 0x16d0, 0x13ea, "Azeron Keyzen", 0, XTYPE_XBOX360 },
> +	{ 0x1689, 0xfd00, "Razer Onza Tournament Edition", 0, XTYPE_XBOX360 },
[Severity: Low]
It looks like this might be a copy-paste error, and it also breaks the
documented vendor/product ID sorting order of the xpad_device array.

Was it intended to duplicate the "Joytech Neo-Se Take2" and "Razer Onza
Tournament Edition" entries here?

[Severity: High]
This isn't a bug introduced by this patch, but adding these new devices here
unconditionally triggers it since they are mapped generically as XTYPE_XBOX=
360
without any quirks.

The commit message notes that these devices reject the LED magic-packet with
a stall (-EPIPE). Because they are mapped as XTYPE_XBOX360, xpad_led_probe()
unconditionally queues an LED initialization command during probe.

When the device stalls the endpoint, the xpad_irq_out() handler receives
-EPIPE but fails to clear the hardware halt via usb_clear_halt(). It leaves
the endpoint permanently halted at the hardware level:

drivers/input/joystick/xpad.c:xpad_irq_out() {
	...
	switch (status) {
	case 0:
		/* success */
		xpad->irq_out_active =3D xpad_prepare_next_out_packet(xpad);
		break;
	...
	default:
		dev_dbg(dev, "%s - nonzero urb status received: %d\n",
			__func__, status);
		break;
	}
	...
}

The host controller will ignore further submissions to a halted endpoint,
causing all subsequent output commands (like force-feedback) to silently
fail or hang.

Should a quirk be implemented and applied to these devices to avoid sending
LED packets to devices that stall on them?

>  	{ 0x17ef, 0x6182, "Lenovo Legion Controller for Windows", 0, XTYPE_XBOX=
360 },
>  	{ 0x1949, 0x041a, "Amazon Game Controller", 0, XTYPE_XBOX360 },
>  	{ 0x1a86, 0xe310, "Legion Go S", 0, XTYPE_XBOX360 },

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619121901.1792=
6-1-roberts.kursitis@azeron.eu?part=3D1

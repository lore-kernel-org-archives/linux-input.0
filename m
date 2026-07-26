Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443AF25F984
	for <linux-input@vger.kernel.org>; Sun, 26 Jul 2026 08:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785054410; cv=none; b=Vru3G4hV7gXFowNhDbjDwCnk6xPxlJ5087ckkUL30qtiSNa2pZFdaVyR7w6aAj9cFAZIUeB19pJFOiVaOYOL/9ehTBkMeXB+pbdYSL561zXnXvZsukSN9lQ1efDeLBa/JzpkaDj7s9J6eJMA1OTbouiEZ7KpIqSm7TDYouT+O+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785054410; c=relaxed/simple;
	bh=N8YyuQqoEFQ8gey58p99zKaMopppwO8oJeSb7fw53Gw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ueqMGNAcUKW0XUzas6OVQq05nRojClLSBpSabQ+rpVjPsULFWIha0cRtBuyhLSRXdv7ShqcUjcis7xLq2aMYvaiPoeupLj88oQu2w/j1cKH85aVmUU9vr/JDv9xjk1kNJVpUu5TqTXKRZ1EvTFDWQe/UX2UjdMyPPgsC8dOPn28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7IEskyy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7IEskyy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D551F000E9;
	Sun, 26 Jul 2026 08:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785054408;
	bh=G5xtd3p/mCi86QNnD/aJ/7I6HbhjrVkGFdNrLJ0ogfc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O7IEskyyxSO1vk9Jz6k70TNPpaNZUgPFozfykZumQphzA71nsWUFOlJgLq4C3ah2/
	 20RSGFZYRJDZP/ywfIeaQ4b7ion38sxtuizQC3E9eywWr/4Cqji0qewQcwMmrgkBYI
	 /fK/WRpixEDz8rfVNOM2OrqJCggZUZpjCEqqfiWyhzc7qHY09Tt6qhPmr+/RA45jRq
	 0Lc1R9ZUzLOSs+A5M8sK2ZvN6g3ld2GRG11AgTN0xvAeBLGIVvbrf7vocEShFNyciT
	 wE2c8o45nsmq7QW2HoFrIDbLmeBINN+92lJbIX/22yghVMAYFteWDwInEBWBJijeth
	 AZWps7A5LRo6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: xpad - add support for Beitong KP series
 controllers
Reply-To: sashiko-reviews@lists.linux.dev
To: VegetablCat <vegetablecat@foxmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <tencent_3FA5706BA66E2CCCFA362E90F805A8FF370A@qq.com>
References: <tencent_3FA5706BA66E2CCCFA362E90F805A8FF370A@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 08:26:48 +0000
Message-Id: <20260726082648.A1D551F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Aggressive 25ms timeout for USB control message can cause device=
 initialization failures.
- [Low] Build Error / Linker Failure when CONFIG_JOYSTICK_XPAD=3Dy and CONF=
IG_HID=3Dm.
--

--- Patch [1]: [PATCH] Input: xpad - add support for Beitong KP series cont=
rollers ---
commit abec748a4c53845b79c26002cb6f3fc8b88c0708
Author: vegetablecat <vegetablecat@foxmail.com>

Input: xpad - add support for Beitong KP series controllers

This patch adds support for Beitong KP series controllers by reading the
XUSB10 descriptor to lock them into XInput mode. It also includes an option=
al
HID receiver driver for the KP40D dongle to prevent hid-generic interferenc=
e.

> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c

[ ... ]

> @@ -2148,6 +2180,19 @@ static int xpad_probe(struct usb_interface *intf, =
const struct usb_device_id *id
>  	xpad->irq_in->transfer_flags |=3D URB_NO_TRANSFER_DMA_MAP;
> =20
>  	usb_set_intfdata(intf, xpad);
> +	if (xpad->read_xusb10) {
> +		error =3D usb_control_msg_recv(udev, 0, 0xee,
> +					     USB_TYPE_VENDOR | USB_DIR_IN |
> +						USB_RECIP_DEVICE,
> +					     0x0000, 0x0004,
> +					     ms_feature_descriptor,
> +					     sizeof(ms_feature_descriptor), 25,

[Severity: Medium]
Is this 25ms timeout for usb_control_msg_recv() too aggressive?

Standard USB timeouts (e.g., USB_CTRL_GET_TIMEOUT) are typically 5000ms. A
25ms timeout risks transient probe failures on busy systems or slower USB
hubs, which could cause the device to fail to stay in XInput mode.

> +					     GFP_KERNEL);
> +		if (error)
> +			dev_warn(&intf->dev,
> +				 "unable to read Microsoft feature descriptor: %d\n",
> +				 error);
> +	}

[ ... ]

> +static int __init xpad_init(void)
> +{
> +	int error;
> +
> +#if IS_ENABLED(CONFIG_HID)
> +	error =3D hid_register_driver(&xpad_receiver_driver);

[Severity: Low]
Will this cause a build error when CONFIG_JOYSTICK_XPAD=3Dy and CONFIG_HID=
=3Dm?

IS_ENABLED(CONFIG_HID) evaluates to true even when HID is built as a loadab=
le
module. Since xpad is built into the main kernel image in this configuratio=
n,
it cannot link against module symbols, leading to a vmlinux link error.

Should this be #if IS_REACHABLE(CONFIG_HID) or managed via a Kconfig
dependency instead?

> +	if (error)
> +		return error;
> +#endif
> +
> +	error =3D usb_register(&xpad_driver);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_3FA5706BA66=
E2CCCFA362E90F805A8FF370A@qq.com?part=3D1

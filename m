Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA59937DEA3
	for <linux-input@vger.kernel.org>; Sun, 26 Jul 2026 08:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785053436; cv=none; b=FYXBtrdRukB3b2SkRUhFy0RIqDPvt7SmhKIgfEKPoLLGv3o9AfzNLZGB9m726sIRsGxcrg4YEWIAbNi1Cex7Em2s31HcYQ/b99GDnL3k5AvTc9MmE9vetsT16XSMw/tbaWIX8pKNYfpQQVpji0OICY/6wy76mCIt50/Tl8MZ8Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785053436; c=relaxed/simple;
	bh=voMBMGc0iFoE/832BU0f8OMBUK3OPJE/TX7VjPLH6Mk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KNTQyc9F/T8atC/TPI1deMJ/F4cJXmr5QgKxIi1e0WHdb4rJCvQ82WxkrVL0/f08Aqr/aaZah9op4+wVmpvZNyZIIuTvUQxgwYrL10WzYCronILlZ5C5GMMsVYr0tqCPIEetVhShhY1jGqfMbT/3QWRYYIiK7lKWN8i9IiemIKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKeZLctn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKeZLctn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 307EB1F000E9;
	Sun, 26 Jul 2026 08:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785053434;
	bh=ZwTIQg8rT6wLeU8ZVR9YBzB9KczkZKG4lWUrcD8W7e4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MKeZLctnwNkadIdYwhjIF3/IdsBUzCrBUgTRFtcnG0p6kExaRNTsyt5XBI/Nr9SYz
	 SebSKpsGu6eA+xkjw+nWzrQUwA1Xd+PWaX1HIrq30SLiINo0JCklnaYF0WxHyf0vPH
	 iPcNqim3ODDOUeuXqpnseq2OPk7aTuayGpcuhg1Zs66R2KDOm88WzkAuCLhhyRVRMO
	 gPQ0mcQL713miepelLfafYXi1gdsYyKv+6CJOY1ltZH7cJ0ie7DGki5eIomqaQeTCW
	 HWx4hOpNItcAjYiQ+OUGnuo5zVWe2uF/wIBBAEsmtVlqItH3mXoXdD9e4MO28I1HaU
	 cNrH/oyax7khA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: xpad - add support for Beitong KP series
 controllers
Reply-To: sashiko-reviews@lists.linux.dev
To: VegetablCat <vegetablecat@foxmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <tencent_2DEADF4D9ADC33A9420BECBEA70B1A7EFD08@qq.com>
References: <tencent_2DEADF4D9ADC33A9420BECBEA70B1A7EFD08@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 08:10:33 +0000
Message-Id: <20260726081034.307EB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The HID device ID for the receiver dongle uses an incorrect vendor=
 ID (`0x20dd`), which conflicts with the `0x20bc` vendor ID defined in the =
USB device table, preventing the driver from binding.
- [Low] Missing Kconfig dependency on `CONFIG_HID` for `CONFIG_JOYSTICK_XPA=
D` leads to build and linkage failures when HID is disabled or built as a m=
odule.
--

--- Patch [1]: [PATCH] Input: xpad - add support for Beitong KP series cont=
rollers ---
commit bcec2846a21020976ee3a5901681b58a510bad9a
Author: vegetablecat <vegetablecat@foxmail.com>
Subject: Input: xpad - add support for Beitong KP series controllers

This commit adds support for Beitong KP series controllers by reading the=20
XUSB10 descriptor to lock them into XInput mode. It also introduces a=20
minimal HID receiver driver for the KP40D receiver dongle to prevent=20
hid-generic from interfering.

> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index feb8f368f834e..d33ca181dfe8b 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
[ ... ]
> @@ -332,6 +334,32 @@ static const struct xpad_device {
>  	{ 0x1bad, 0xfd00, "Razer Onza TE", 0, XTYPE_XBOX360 },
>  	{ 0x1bad, 0xfd01, "Razer Onza", 0, XTYPE_XBOX360 },
>  	{ 0x1ee9, 0x1590, "ZOTAC Gaming Zone", 0, XTYPE_XBOX360 },
[ ... ]
> +	{ 0x20bc, 0x515b, "BETOP BTP-KP40D Controller (White)", 0, XTYPE_XBOX36=
0, FLAG_READ_XUSB10 },
> +	{ 0x20bc, 0x515c, "BETOP BTP-KP40D Controller (White)", 0, XTYPE_XBOX36=
0, FLAG_READ_XUSB10 },
> +	{ 0x20bc, 0x515d, "BETOP BTP-KP40F Controller (White)", 0, XTYPE_XBOX36=
0, FLAG_READ_XUSB10 },
[ ... ]
> @@ -2312,7 +2357,71 @@ static struct usb_driver xpad_driver =3D {
[ ... ]
> +static const struct hid_device_id xpad_receiver_devices[] =3D {
> +	{ HID_USB_DEVICE(0x20dd, 0x515c) },
> +	{ }
> +};

[Severity: High]
Is the vendor ID 0x20dd in the HID device table correct?

The USB device table defines product 0x515c with vendor ID 0x20bc,
but the HID device ID table uses 0x20dd. Since a child HID device inherits
its vendor ID from the underlying USB device, will the HID driver fail to
bind to the dongle if it is looking for 0x20dd instead of 0x20bc?

> +MODULE_DEVICE_TABLE(hid, xpad_receiver_devices);
> +
> +static struct hid_driver xpad_receiver_driver =3D {
> +	.name =3D "xpad-kp40d-receiver",
> +	.id_table =3D xpad_receiver_devices,
> +	.probe =3D xpad_receiver_probe,
> +	.remove =3D xpad_receiver_remove,
> +};
> +
> +static int __init xpad_init(void)
> +{
> +	int error;
> +
> +	error =3D hid_register_driver(&xpad_receiver_driver);

[Severity: Low]
Does this driver now require a dependency on the HID subsystem in Kconfig?

Since xpad_init() now unconditionally calls hid_register_driver(), will
building the kernel with CONFIG_JOYSTICK_XPAD=3Dy and CONFIG_HID=3Dm (or
disabled) cause a linker failure due to undefined HID core symbols?

> +	if (error)
> +		return error;
> +
> +	error =3D usb_register(&xpad_driver);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_2DEADF4D9AD=
C33A9420BECBEA70B1A7EFD08@qq.com?part=3D1

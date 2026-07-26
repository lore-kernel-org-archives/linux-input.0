Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3653BCD13
	for <linux-input@vger.kernel.org>; Sun, 26 Jul 2026 17:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785088253; cv=none; b=ERE6lvQKpWwv6vrmby9rZKi9yLlFz4PFvYvreThpJlaW5DAUpT75iJ6lwUSxsDQKxPM7cRmrXkWBtwJyP4W6Dn6m2qDbXA0MDkk0x3hZXCgOaIza6FdCE0dKYrHwWCAWFHvU9S8He93Zxe3NSOOyTFVFZChfqTyqeuoV9P5pxFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785088253; c=relaxed/simple;
	bh=lhbIpntu7Q0UaSBbcqGWq2GdvPwqepAMpST1vI3mnGA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PUoJbb7bQ+JS8S/iXAhlgbLx2yYXtnRukmShHiwLXBKWO4RG/v0/hA7XgPeroJZ/LV27x6rwSyXjq7jQL/F4TiFnsRp3MYFY+XrzKKPMg8+YQ752tjaCEvem41OUEAYlNwnrJV1IDDonHgIYr+a2Hss0aoYcQa6Ak+EI7tVx8hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8DA6vJH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8DA6vJH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D791F000E9;
	Sun, 26 Jul 2026 17:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785088251;
	bh=iShrf7PX+IhPBbpGoTRo5Om/R8VGSPSn8Hjll58esyk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M8DA6vJHu+ubiSHaAsopNyujkHu3g408wdlrGD87xX4KhZkrPpiFKf18piGYuOxoo
	 JIHH3etwGKSSq2d8sad4yZrl74vjPZcYQma4G24VzHbT1VYY4FLWZJYEEhn7iU9DXo
	 mf3g09Yizml8kGR6W/Pfd5bp7mj4eXHtH/XtaAWyuZWcWcIMaH3toIx/llHXwIG2Rt
	 K4caBMz4mIFnICHhUtEhKS5bAqjaToWJWTO6ZUwZpA3phfj1Op0xGwML2QS2lzaVhy
	 HaEENgtiK5P7mLGlVDoGYoaliwgDnGAp/Mh1pXg9MRr4uiYJLQbuP5SW9WZuEE4Sp6
	 I9DJotwO5lG+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: xpad - add support for Beitong KP series
 controllers
Reply-To: sashiko-reviews@lists.linux.dev
To: VegetablCat <vegetablecat@foxmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <tencent_A72FD342899FA27A59D321374BEAD5828706@qq.com>
References: <tencent_A72FD342899FA27A59D321374BEAD5828706@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 17:50:51 +0000
Message-Id: <20260726175051.97D791F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The KP40D wireless receiver dongle (0x20dd:0x515c) is defined wi=
th vendor ID 0x20dd in the HID driver but incorrectly listed as 0x20bc in t=
he USB driver tables, preventing the driver from binding.
--

--- Patch [1]: [PATCH] Input: xpad - add support for Beitong KP series cont=
rollers ---
commit a241c834ca356248bc12344397a71cd6ee7c97b1
Author: vegetablecat <vegetablecat@foxmail.com>

Input: xpad - add support for Beitong KP series controllers

This commit adds support for Beitong KP series controllers by issuing an
XUSB10 descriptor read during probe to prevent them from reverting to
Nintendo Switch mode. It also includes an optional HID receiver driver for
the KP40D dongle to prevent interference from hid-generic.

> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
[ ... ]
> @@ -332,6 +334,32 @@ static const struct xpad_device {
>  	{ 0x1bad, 0xfd00, "Razer Onza TE", 0, XTYPE_XBOX360 },
>  	{ 0x1bad, 0xfd01, "Razer Onza", 0, XTYPE_XBOX360 },
>  	{ 0x1ee9, 0x1590, "ZOTAC Gaming Zone", 0, XTYPE_XBOX360 },
> +	{ 0x20bc, 0x5125, "BETOP BTP-KP20A/BTP-KP40A Controller", 0, XTYPE_XBOX=
360, FLAG_READ_XUSB10 },
[ ... ]
> +	{ 0x20bc, 0x515b, "BETOP BTP-KP40D Controller (White)", 0, XTYPE_XBOX36=
0, FLAG_READ_XUSB10 },
> +	{ 0x20bc, 0x515c, "BETOP BTP-KP40D Controller (White)", 0, XTYPE_XBOX36=
0, FLAG_READ_XUSB10 },

[Severity: Medium]
The commit message states the receiver dongle (0x515c) has a distinct vendor
ID of 0x20dd. However, this entry maps it to the controller's vendor ID
of 0x20bc.

Will this incorrect vendor ID, along with the omission of 0x20dd in the
xpad_table USB match list, prevent the xpad driver from binding to the
dongle's USB interface?

[ ... ]
> @@ -2312,7 +2357,79 @@ static struct usb_driver xpad_driver =3D {
>  	.id_table	=3D xpad_table,
>  };
> =20
[ ... ]
> +static const struct hid_device_id xpad_receiver_devices[] =3D {
> +	{ HID_USB_DEVICE(0x20dd, 0x515c) },
> +	{ }
> +};

[Severity: Medium]
This correctly identifies the dongle with vendor ID 0x20dd, but contradicts
the xpad_device array above.

Could the xpad_device array and the xpad_table be updated to include 0x20dd
so the USB driver can successfully probe the device?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_A72FD342899=
FA27A59D321374BEAD5828706@qq.com?part=3D1

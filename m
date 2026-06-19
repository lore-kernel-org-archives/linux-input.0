Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DD92853F3
	for <linux-input@vger.kernel.org>; Fri, 19 Jun 2026 13:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781876629; cv=none; b=KFv7QOjrrERiXY7F+LX1jtsCuqbaLyztSCvGgiQFCUGhfI1GpA3spa9oiu/phD3dLC+xWwdcRqXCqa1IYtpzDNLeU5aa9T0TiNNOnnbwbKboDKGAXQFZzfPJ42lt+FS0eg+ES4uVH2dPaq4HVzkv8RJEg9RCfC2dayidWKWw9kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781876629; c=relaxed/simple;
	bh=OCJ3Zt5m0ws3fR82pCODRgtnmTjlOh/0UeUeJkhsUPA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QFCmTDJy92B+rZAus2VoL1VXykQf/oe67yIQKzvZVty1GiQCr4Vx2itV5m08beJ7BSgfnwOJRV5W3YfzqOfpavxtarH6wnXy5jHlxYppcNJRSf+a9B8Vy1MdhfuygHxc0a48hNnoBlM8QPxOccqpAyknKbktE8SkPFEICbMqQfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fN2Y9oRB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fN2Y9oRB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C801F000E9;
	Fri, 19 Jun 2026 13:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781876628;
	bh=L9VkplPEQS0/bjStGEDr1vpopGAc/Y5Rc1Vzq6buFlg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fN2Y9oRBeJMIFaUf/HTS24X57xicQ6h6TmVnb1JUwEukq5OKsIbvO0UtE6p5ggn62
	 IElVPE0XrmV5Wujm4LkYCEgXSYs1FvdMJ775DPQL8NSviwRaspVe7WwHEr5xqNFwin
	 OhRxHclP9uFKeshEg5JLZ+IW4MQjYhOxNVAygE3Jwihkq2iP+ylLLmfCsdAwdJAwXG
	 a/biJGZ0IRBDm9BhpPCi5JoHUKVK1mlFQHlzjOSHCRylz/cNdyhjjcIOkSCUAuOgEO
	 fD9Cl+bwoDuw53ZrX9/Q/kgHP+KwocgEkFkIGGdURng3SfgK7+itgWxbdDmFP7KqMi
	 pygfRvGmHtN+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/1] Input: xpad - add support for Azeron devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Roberts Kursitis" <roberts.kursitis@azeron.eu>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260619132821.18764-1-roberts.kursitis@azeron.eu>
References: <20260619121901.17926-1-roberts.kursitis@azeron.eu>
 <20260619132821.18764-1-roberts.kursitis@azeron.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 13:43:47 +0000
Message-Id: <20260619134347.E1C801F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] The newly added Azeron device IDs are not sorted by vendor ID, viol=
ating the explicit comments in the driver.

Pre-existing issues:
- [High] Azeron devices will stall (-EPIPE) on FF_RUMBLE packets, triggerin=
g a pre-existing infinite URB retry loop.
--

commit 32ac579407e3b61d52176dbd3f7d52733eb47d44
Author: Roberts Kursitis <roberts.kursitis@azeron.eu>

Input: xpad - add support for Azeron devices

Add USB Vendor and Product IDs for the Azeron devices (Cyro,
Cyborg, Classic/Compact, Cyro Lefty, Cyborg II and Keyzen). Adds
a QUIRK_NO_LED flag to skip LED initialization since these devices
reject the Xbox 360 LED magic packet with a stall.

> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index feb8f368f834e..4efcd16c3713c 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c

[ ... ]

> @@ -289,6 +290,12 @@ static const struct xpad_device {
>  	{ 0x15e4, 0x3f0a, "Xbox Airflo wired controller", 0, XTYPE_XBOX360 },
>  	{ 0x15e4, 0x3f10, "Batarang Xbox 360 controller", 0, XTYPE_XBOX360 },
>  	{ 0x162e, 0xbeef, "Joytech Neo-Se Take2", 0, XTYPE_XBOX360 },
> +	{ 0x16d0, 0x1103, "Azeron Cyro", QUIRK_NO_LED, XTYPE_XBOX360 },

[Severity: High]
This is a pre-existing issue, but mapping these devices as XTYPE_XBOX360 wi=
ll
unconditionally enable the FF_RUMBLE capability in xpad_init_ff().=20

Since you noted in the commit message that these devices stall (-EPIPE) on =
LED
packets, will they also stall if userspace sends a rumble effect packet?

If they do stall on rumble, this will trigger a pre-existing bug in
xpad_irq_out(), which handles the -EPIPE status by falling through to the
default case:

drivers/input/joystick/xpad.c:xpad_irq_out() {
    switch (status) {
    ...
    default:
        dev_dbg(dev, "%s - nonzero urb status received: %d\n", __func__, st=
atus);
        break;
    }
   =20
    if (xpad->irq_out_active) {
        usb_anchor_urb(urb, &xpad->irq_out_anchor);
        error =3D usb_submit_urb(urb, GFP_ATOMIC);
    ...
}

Because xpad->irq_out_active is not cleared on -EPIPE, the driver will
infinitely resubmit the stalled OUT URB, creating an interrupt storm.

Should a QUIRK_NO_RUMBLE or similar be added to prevent rumble packets
from being sent to these devices?

[Severity: Low]
this isn't a bug, but the new entries with vendor ID 0x16d0 are placed befo=
re
the 0x1689 entries. Should these be moved down to maintain the numerical
sorting of the xpad_device array?

> +	{ 0x16d0, 0x113c, "Azeron Cyborg", QUIRK_NO_LED, XTYPE_XBOX360 },
> +	{ 0x16d0, 0x1192, "Azeron Classic/Compact", QUIRK_NO_LED, XTYPE_XBOX360=
 },
> +	{ 0x16d0, 0x1212, "Azeron Cyro Lefty", QUIRK_NO_LED, XTYPE_XBOX360 },
> +	{ 0x16d0, 0x12f7, "Azeron Cyborg II", QUIRK_NO_LED, XTYPE_XBOX360 },
> +	{ 0x16d0, 0x13ea, "Azeron Keyzen", QUIRK_NO_LED, XTYPE_XBOX360 },
>  	{ 0x1689, 0xfd00, "Razer Onza Tournament Edition", 0, XTYPE_XBOX360 },
>  	{ 0x1689, 0xfd01, "Razer Onza Classic Edition", 0, XTYPE_XBOX360 },

[ ... ]

> @@ -532,6 +539,7 @@ static const struct usb_device_id xpad_table[] =3D {
>  	XPAD_XBOXONE_VENDOR(0x1532),		/* Razer Wildcat */
>  	XPAD_XBOX360_VENDOR(0x15e4),		/* Numark Xbox 360 controllers */
>  	XPAD_XBOX360_VENDOR(0x162e),		/* Joytech Xbox 360 controllers */
> +	XPAD_XBOX360_VENDOR(0x16d0),		/* Azeron controllers */

[Severity: Low]
this isn't a bug, but similarly here, should the 0x16d0 vendor block be
placed after 0x1689 to keep the list sorted by vendor ID as requested by the
comment at the top of xpad_table?

>  	XPAD_XBOX360_VENDOR(0x1689),		/* Razer Onza */
>  	XPAD_XBOX360_VENDOR(0x17ef),		/* Lenovo */
>  	XPAD_XBOX360_VENDOR(0x1949),		/* Amazon controllers */

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619132821.1876=
4-1-roberts.kursitis@azeron.eu?part=3D1

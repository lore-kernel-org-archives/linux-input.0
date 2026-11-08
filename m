Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794161006;
	b=wJitZAuj79BejM+h0T8sOha3P9rjkAumoUpv+/yjUq6l8DYigmSokQ8vfUVsdKu+TIXj
	 0aO+VfdlMoTOVtrFi63oAJEXVjbo+NeroxLWKP/fQjk/i9mJaiebppaC7PFoxWdbKgmAo
	 OgDEpZC17QP/hneKaqUchrW4eN5FuO+dptVe3Fbj9/uZVcVXXIO5oKxowXFih8CXpj9ta
	 TSoOz1UQxhyjy+5gJ/KA14wbAWWEoclwxcZYMQkrrAEvu4h/m9aMBgpuUjk3g4m4H/W5G
	 CVVoHNLN+AKFbQerac1Tam4HhfhzgeWrOTkAb21TqtQnnha/NlUDDVyeyKVV78EQ/vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794161006;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Y7QToFCv+rBYUzorhIZyG+PoWcboFm4WEtffXC323v0=;
	b=3H2Y/fMF3REq9lkJ6ATJ3vhrclr/d0puozICSrjGOBiLpS8ahwfqfcyowXfikPBJ9mhj
	 9B3YS86xX2WnNMEJDu1rYhiBeNXSrcUZZ6A/m9C/D9eZoCiX2Yk/Lz6RHvDlFBEO89m4P
	 pGc7CWm0AyX+pYIABZKYbapaY7tImauQlRcGynFbrDpcGBMtAh+8dOERdA/hIvgSxSoTB
	 TG+YqC67wQnDaKixWtBsfeuiEncHnN5DX8s6jqf1DMMuEcjU7sSvYa7A2myRhKoWv1hzO
	 6HiUnS+/IRfOThcPTVK6TdW5CrjAGyVEU1YXaNKqM4kwvcHgtGcNO8PlsYbwyz1hUuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J6GNDg0Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE603606A31C
	for <linux-input@vger.kernel.org>; Sun,  8 Nov 2026 18:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J6GNDg0Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE951F0089F;
	Sun,  8 Nov 2026 18:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794161005;
	bh=Y7QToFCv+rBYUzorhIZyG+PoWcboFm4WEtffXC323v0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J6GNDg0Zz//AyyqEvysikhm8eMbijmoUOAQmqbSG2nNgGsGPlTOBtHQCoVcmxUHBl
	 o5CkGZYLwN9xOcIsTd3XwiWoJQWtNrwVaIPJe7E/WLxqRdOMCifbHuHLqnzWHJA5HX
	 +lN8o8KRry/hv/qNHBIQGNusQpY0wJ/lQmUS/+yJl/UOkvHGRf3op3HamwBWqsu2Qz
	 dmMA9hZCWhPBbx6tmiQNApeAAXBAITXY8zmkxLQ00MoQXTs0eHyUIEjT6EqBF6wpJG
	 eztnwzU3yzBk3Tk+/Ne0ZlVC+xsHbBVO/FscIuR1aehB25tLRV10DWjEaxkT09/xpP
	 Xk2l0R+07oVMg==
Message-ID: <sashiko-outbox-203893@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: lg-g15: Add G15 LCD framebuffer support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Benjamin Valentin" <benpicco@googlemail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261108173920.424072-1-benpicco@googlemail.com>
References: <20261108173920.424072-1-benpicco@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 18:03:24 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] HID: lg-g15: missing hid_is_usb() check in lg_g15_fb_init()
- [Medium] HID: lg-g15: reversed horizontal pixel bit order in
  lg_g15_pack_report()
- [Medium] HID: lg-g15: LCD updates dropped during USB runtime
  autosuspend
--

commit 12c2a94ad75eaba461660e9c5ba7c7edbfce9af1
Author: Benjamin Valentin <benpicco@googlemail.com>

HID: lg-g15: Add G15 LCD framebuffer support

This commit adds deferred-I/O framebuffer support for the 160x43 monochrome
LCD on Logitech G15 and G15 v2 keyboards.

> diff --git a/drivers/hid/hid-lg-g15.c b/drivers/hid/hid-lg-g15.c
> index 02ef3e2094b4c..ca1f3280c05a6 100644
> --- a/drivers/hid/hid-lg-g15.c
> +++ b/drivers/hid/hid-lg-g15.c
[ ... ]
> +static void lg_g15_pack_report(u8 *report, const u8 *pixels)
> +{
> +	unsigned int page, x, bit, y;
> +	u8 value, mask;
> +
> +	memset(report, 0, LG_G15_LCD_HEADER_SIZE);
> +	report[0] =3D 0x03;
> +	report +=3D LG_G15_LCD_HEADER_SIZE;
> +
> +	/*
> +	 * The LCD consumes vertical, LSB-at-the-top groups of eight pixels.
> +	 * Its pixel polarity is opposite to FB_VISUAL_MONO10.
> +	 */
> +	for (page =3D 0; page < LG_G15_LCD_PAGES; page++) {
> +		for (x =3D 0; x < LG_G15_LCD_WIDTH; x++) {
> +			mask =3D BIT(7 - x % 8);

[Severity: Medium]
Should mask be BIT(x % 8) instead of BIT(7 - x % 8)?

Standard 1bpp packed-pixel sysmem framebuffers (with nonstd =3D 0) place the
leftmost pixel of each byte (x % 8 =3D=3D 0) in BIT(0) on little-endian
architectures, as used by sys_imageblit(), sys_fillrect(), sys_copyarea(),
and samples/auxdisplay/cfag12864b-example.c.  Testing BIT(7 - x % 8) mirrors
every 8-pixel horizontal byte on the LCD when drawn via standard fbdev
operations.

[ ... ]
> +static int lg_g15_fb_init(struct hid_device *hdev, struct lg_g15_data *g=
15)
> +{
> +	struct usb_interface *intf =3D to_usb_interface(hdev->dev.parent);
> +	struct usb_host_interface *alt =3D intf->cur_altsetting;
> +	struct usb_endpoint_descriptor *out;
> +	struct fb_info *info;
> +	struct lg_g15_fb *fb;
> +	int ret;
> +
> +	ret =3D usb_find_int_out_endpoint(alt, &out);

[Severity: High]
Does lg_g15_fb_init() need to check hid_is_usb(hdev) before casting
hdev->dev.parent with to_usb_interface()?

A virtual HID device created via /dev/uhid with bus =3D BUS_USB and a G15 L=
CD
product ID passes all earlier transport-agnostic HID calls in
lg_g15_probe(), causing to_usb_interface(hdev->dev.parent) to cast a
non-USB parent device and dereference an invalid intf->cur_altsetting
pointer.

[ ... ]
> +static int lg_g15_suspend(struct hid_device *hdev, pm_message_t message)
> +{
> +	struct lg_g15_data *g15 =3D hid_get_drvdata(hdev);
> +	struct lg_g15_fb *fb;
> +
> +	if (!g15 || !g15->fb)
> +		return 0;
> +
> +	fb =3D g15->fb;
> +	mutex_lock(&fb->lock);
> +	fb->suspended =3D true;
> +	mutex_unlock(&fb->lock);
> +	flush_delayed_work(&fb->info->deferred_work);
> +	return 0;
> +}

[Severity: Medium]
Does setting fb->suspended during runtime autosuspend cause
lg_g15_fb_deferred_io() to drop all subsequent LCD updates?

Because usbhid enables autosuspend and G15 / G15 v2 devices do not connect
hidinput LEDs, the USB interface can runtime-suspend while no G-keys are
pressed.  lg_g15_suspend() then sets fb->suspended =3D true even when
PMSG_IS_AUTO(message) is true, and lg_g15_fb_deferred_io() bails out
instead of waking the interface (for example via
usb_autopm_get_interface() / usb_autopm_put_interface()).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108173920.4240=
72-1-benpicco@googlemail.com?part=3D1

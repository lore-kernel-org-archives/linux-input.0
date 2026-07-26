Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD0427EFE9
	for <linux-input@vger.kernel.org>; Sun, 26 Jul 2026 13:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785072824; cv=none; b=NIhNbx1ngXGcA0WBVPqUX2nsbxihG7XVdU7IRmPIv2EtkbbROH9+yYzaTUJ9scOWq8Gi6E87BWuZ37UwSKdsCBgpavvI87N4ZxCZ4DbXhLFA5HCv7s2jwBGzoLD3cfWcdz8FQ992YG0GIH5uqsgjWXFPEk7xwSqj84G/7ZLkMy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785072824; c=relaxed/simple;
	bh=q5KZzJ0pxDpEOtLsMxwQeqzgHbRdjmqS9w8gOtr671U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ML6cA2Fw4/WV6U4L+xGabu3vO3jnaqHENuPYi5HHMZKQ6/TzhjWpNPQnT3hqbA9RT7/mKa92O0wHbIzmVfgF//1eKjV1RrjjJ71DhCSsr5WPO7iIXWrivL+xXWd8P7U9UOiwBtzdsICyWsYH7iLbUV4x4voYMsN+ZXS2oIsK9tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eE60dkzx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eE60dkzx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565CE1F000E9;
	Sun, 26 Jul 2026 13:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785072822;
	bh=bFfGZvpEiUqgsXZDkdPq6vo8JRi00dbBbZYFN9bgsZU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eE60dkzx1Ta7CFxT0v/jxFmAy47IvHkFyhOpdFmaU181vU6SKJ/0brkLd1Gt8/vo/
	 y17aJSZwCyTI4T8jvKsQfSUYtWGA4SxIoAMbOrZR404fU2yXti/TMJSMckcLIwDGAq
	 sGoAwggJU0WTrN6FQD2dEJAJugpGJ/aA28fqnMPAOn8+u23lEwQPctEC8eiF8/DJ2l
	 lT4pZPUVV2q9SR+bBjR7lRoQ46M+5whcqCKbsaqbUGTa8TlgCnFQqKYnYigQbly12S
	 81YHSNFAw1SoAh9IxNep5BOhOtH680j7dHRCScFBDtbtBNrUI5KKGIBzeAG+ilKM2T
	 ckcC6EZkfU8vg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] Input: xpad - add support for generic clone X-Input
 gamepads
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ishaan Dandekar" <ishaan.dandekar@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260726132039.28330-4-ishaan.dandekar@gmail.com>
References: <20260726132039.28330-1-ishaan.dandekar@gmail.com>
 <20260726132039.28330-4-ishaan.dandekar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 13:33:41 +0000
Message-Id: <20260726133342.565CE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Improper USB Device Matching causing interface hijacking
--

--- Patch [3]: [PATCH 3/3] Input: xpad - add support for generic clone X-In=
put gamepads ---
commit 8d8bacca3354683f27c3566047a8b73e337bdddd
Author: Ishaan Dandekar <ishaan.dandekar@gmail.com>

Input: xpad - add support for generic clone X-Input gamepads

This commit adds support for a generic X-Input gamepad (0283:0001) by adding
its vendor and product IDs to xpad_device and xpad_table to initialize it as
an X-Input gamepad.

> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c

[ ... ]

> @@ -496,6 +497,7 @@ static const struct usb_device_id xpad_table[] =3D {
>  	 */
>  	{ USB_INTERFACE_INFO('X', 'B', 0) },	/* Xbox USB-IF not-approved class =
*/
>  	XPAD_XBOX360_VENDOR(0x0079),		/* GPD Win 2 controller */
> +	{ USB_DEVICE(0x0283, 0x0001) }, /* Generic X-Input Gamepad */

[Severity: Medium]
Will this binding hijack other interfaces on the composite USB device?

By using USB_DEVICE() here, the match flags are set to
USB_DEVICE_ID_MATCH_DEVICE, which drops interface-level matching. Because
this device is statically mapped to XTYPE_XBOX360 in xpad_device[],
xpad_probe() will skip the XTYPE_UNKNOWN interface class check.

Does this cause the xpad driver to bind to all interfaces on the device
(such as audio or standard HID) that happen to have one IN and one OUT
endpoint, stealing them from their correct drivers and creating ghost input
nodes?

Should this use XPAD_XBOX360_VENDOR(0x0283) or explicitly match the
USB_CLASS_VENDOR_SPEC interface class instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726132039.2833=
0-1-ishaan.dandekar@gmail.com?part=3D3

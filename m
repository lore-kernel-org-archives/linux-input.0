Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E6C30149F
	for <linux-input@vger.kernel.org>; Sun, 26 Jul 2026 17:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785086832; cv=none; b=Vr8rl8OKJu5/McD2xJN9zwG4V3VmpkIWa3IAcRmmT2yasASBJPGT3kX+K6exOqVasAlLT/78lzobFN55kjX8QjwR9GHvXwMnRFs/GhS9y54xVQKMzvBwYZk8FFYMj6cezKPYY5RQmS00uALISZb46gtf9Hnt5DcskNH6FbS6eOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785086832; c=relaxed/simple;
	bh=Iv49v5YHzKcN7VdB/B34YjWedgqMa42ahlJu8+Ys/bw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Dd6Bi86jMlqJzEL0Jn0nJf0k+pm5Gx09RBSfnKoaHmFKpE8lCTRVyaBpJ9L36OVRefuGI//5r7CryF8ThSWWM7Cfgdt9ck/7w6cRfH2ha7qQC402ppZBkU88Nmz/8DgOAHPTRteVh3jhl1Qanp3Eu5DBzHVyjqJzkFtFl4Skou0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqKnb33T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqKnb33T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0602B1F00A3A;
	Sun, 26 Jul 2026 17:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785086831;
	bh=W6z8X412imwAJOF5rwSNhTDiY1M3wVpH8lqp2x4hu8g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oqKnb33T+FHtmVA/S5RpJhFOBoXZujjl9TLs7K/G6pwWISqrdi8NYzUu2PQa9S1zT
	 dJSLdQghjWIf1dzga0uC/uSJqj9KBwyC34uCZ+u16FJU5L0ANM22XhPet3op4uoLs8
	 FC1hP4eER5oEWoILCJH0Y+192OhHQEFE0wHXsk/0eG2rBU/CqTx7t2nVyyei89Armx
	 lW7407G4I1CbxQksVNLYldR9PuFqrOPtGvKNma1Vj+rs6bE8tnmt9pE7XqYBekU7iw
	 Q8s4fP+3O4Oi8XvUhlTUWmQDfsxyY8fc99issLVmX4ZLL8t7qflC2cfYjA+7OQEfpe
	 ekHT7IhSknBqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] Input: xpad - add support for generic clone X-Input
 gamepads
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ishaan Dandekar" <ishaan.dandekar@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260726171526.43071-1-ishaan.dandekar@gmail.com>
References: <20260726171526.43071-1-ishaan.dandekar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 17:27:10 +0000
Message-Id: <20260726172711.0602B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Using `USB_DEVICE()` matches all interfaces on the composite devic=
e, causing `xpad` to improperly bind to the generic HID interface alongside=
 the vendor-specific interface.
--

--- Patch [1]: [PATCH v2] Input: xpad - add support for generic clone X-Inp=
ut gamepads ---
commit 00ab3ea53016b88e3489cabeb13695b6e3ca4191
Author: Ishaan Dandekar <ishaan.dandekar@gmail.com>

Input: xpad - add support for generic clone X-Input gamepads

This patch adds the vendor and product ID (0283:0001) for a generic clone
X-Input gamepad to xpad_device and xpad_table. This allows the device to
be recognized and initialized as an X-Input gamepad instead of falling back
to a generic HID interface.

> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index feb8f368f834e..c0a15db032963 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c

[ ... ]

> @@ -496,6 +497,7 @@ static const struct usb_device_id xpad_table[] =3D {
>  	 */
>  	{ USB_INTERFACE_INFO('X', 'B', 0) },	/* Xbox USB-IF not-approved class =
*/
>  	XPAD_XBOX360_VENDOR(0x0079),		/* GPD Win 2 controller */
> +	{ USB_DEVICE(0x0283, 0x0001) }, /* Generic X-Input Gamepad */

[Severity: High]
Will using USB_DEVICE() here cause the driver to incorrectly bind to the
device's generic HID interface as well?

Since USB_DEVICE() only matches by Vendor and Product ID without checking
the interface class, this appears to match all interfaces on the composite
device.

Because the device is found in the xpad_device table, xpad_probe() will set
the xtype to XTYPE_XBOX360. This bypasses the XTYPE_UNKNOWN check later in
xpad_probe() that normally verifies if the interface class is
USB_CLASS_VENDOR_SPEC.

If xpad binds to the standard HID interface, it could steal it from usbhid,
create a ghost input device, and send invalid X-Input packets to the generic
HID OUT endpoint. Could this be avoided by using the XPAD_XBOX360_VENDOR()
macro or specifying the interface match flags directly?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726171526.4307=
1-1-ishaan.dandekar@gmail.com?part=3D1

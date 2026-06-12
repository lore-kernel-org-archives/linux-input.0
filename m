Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D333D47B7
	for <linux-input@vger.kernel.org>; Fri, 12 Jun 2026 13:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781269287; cv=none; b=dNXDzUIbt23eDAweZFqVE64n8zm0O1aa/jOUhAL4f6dLH3NCM+Xx0i/jUOWL9qTE5+gSTTNHhnLizioRVqSCbdWlKBeDijWK94dUG5AQ4j04uCM9huz7lbnX+WueMBNjW9l6XdLptKpKFNtbBA0jYPfhRRILO4dW2c2uNI8YvS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781269287; c=relaxed/simple;
	bh=YKni3FkYM5p3sXHMFpHmvd0Snpcs6Sx5ANgPJ3Q8RXU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=emjrlK/hls/ymq0yoKm58eUl9Zmhp0aXlWpNCPGsaRmiItRfEL0vKod/Kp4nndtO+DGMB0cI/lKmUOuH0hgqIyZRuHnIDUUbNJSOqOycv6zUICyydY9fqBXsNT0AvoTUYB1Rk7i2wnSb6ThLra+eDH/CzWFCDMpvW881vJlH1M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2U2h7KW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2U2h7KW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAAE71F000E9;
	Fri, 12 Jun 2026 13:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781269285;
	bh=J3kXU0nrKlpyu2Wpx775kIf/5+iVf5JbjVcWtS2LobU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k2U2h7KWcDOAmUXqokprPQse31iRbKkjuh3UyHup71OxmoGUixLt/sVGIzX1lyDA7
	 jt9NScu57l+fBlpDV3LaIQmW7XX579Z/Kwexd1TUsFj/kSk5weRAjP+rNBDHpzSxJx
	 KbCKscV1LanW2KL6UooApQr1emVS7V2n26CSdK/rj1eC5Zj4bxLJoUmJwPVF8kNotQ
	 kf7yWsQkq71AvlRXMG1mVUUC9KX4fnK3ljmdUbLPlSUVHapTHYTtJJT16m7H0czQEx
	 iZrjZyuh7pCADg7GEWavOn5YVUN6B1wRkWxXO8PeNL+MqRQch2YJ6xFLnZBF7YsG6r
	 K3C9r5ma/XtYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: asus: add i2c entry for FA808UM and other TUFs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260612124830.984592-1-denis.benato@linux.dev>
References: <20260612124830.984592-1-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 13:01:25 +0000
Message-Id: <20260612130125.AAAE71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free during device removal if asus_kbd_register_leds() f=
ails
- [High] Invalid type cast and Out-of-Bounds read for non-USB devices mimic=
king QUIRK_ROG_ALLY_XPAD
--

commit 8b4f857c02ac46f316151cd7e8bd26fec4c17401
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add i2c entry for FA808UM and other TUFs

This patch adds an I2C HID device entry for the ASUS ROG NKEY Keyboard 2
in the hid-asus driver. This allows newer TUF laptops, which use the same
PID/VID over I2C instead of USB, to successfully bind to the driver.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 3f5e96900b67a..5a2ab3cfef0b5 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -1494,6 +1494,9 @@ static const struct hid_device_id asus_devices[] =
=3D {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
>  	    USB_DEVICE_ID_ASUSTEK_ROG_NKEY_KEYBOARD2),
>  	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD | QUIRK_HID_FN_LOCK=
 },
> +	{ HID_I2C_DEVICE(USB_VENDOR_ID_ASUSTEK,
> +	    USB_DEVICE_ID_ASUSTEK_ROG_NKEY_KEYBOARD2),
> +	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD | QUIRK_HID_FN_LOCK=
 },

[Severity: High]
This isn't a bug introduced by this patch, but while looking at the
QUIRK_USE_KBD_BACKLIGHT initialization, could there be a use-after-free
during device removal if asus_kbd_register_leds() fails?

If asus_hid_register_listener() fails within asus_kbd_register_leds() (e.g.,
due to missing asus-wmi or another keyboard already being registered), the
allocated drvdata->kbd_backlight is freed using devm_kfree():

	ret =3D asus_hid_register_listener(&drvdata->kbd_backlight->listener);
	if (ret < 0) {
		/* No need to have this still around */
		devm_kfree(&hdev->dev, drvdata->kbd_backlight);
	}

However, the pointer itself is not set to NULL. Since this error is
intentionally ignored by the caller (asus_probe()), the device probe
succeeds.

When the device is later unbound or unplugged, asus_remove() checks
if (drvdata->kbd_backlight) and dereferences the dangling pointer to
unregister the listener:

static void asus_remove(struct hid_device *hdev)
{
	...
	if (drvdata->kbd_backlight) {
		asus_hid_unregister_listener(&drvdata->kbd_backlight->listener);

Will this unconditionally dereference the dangling pointer, leading to a
use-after-free?

[Severity: High]
This is a pre-existing issue, but while looking at devices mimicking
QUIRK_ROG_ALLY_XPAD, could asus_kbd_register_leds() perform an invalid
type cast and out-of-bounds read?

In asus_kbd_register_leds(), devices with QUIRK_ROG_ALLY_XPAD unconditional=
ly
cast the parent device to a usb_interface:

	if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD) {
		intf =3D to_usb_interface(hdev->dev.parent);
		udev =3D interface_to_usbdev(intf);
		validate_mcu_fw_version(hdev,
			le16_to_cpu(udev->descriptor.idProduct));
	}

This assumes the device is always backed by a USB transport.

However, a local user can use uhid to inject a fake HID device with matching
USB vendor and product IDs, causing this driver to bind to it. For uhid
devices, the parent is the uhid character device, not a USB interface.

Would this blind cast lead to type confusion, memory corruption, and
out-of-bounds reads when attempting to access the USB device descriptor?
Should there be a hid_is_usb(hdev) check before treating the parent as a
USB interface?

>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
>  	    USB_DEVICE_ID_ASUSTEK_ROG_Z13_LIGHTBAR),
>  	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD },

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612124830.9845=
92-1-denis.benato@linux.dev?part=3D1

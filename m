Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B31216DC28
	for <linux-input@vger.kernel.org>; Thu, 21 May 2026 03:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779335129; cv=none; b=s9uz9TEVtdChN4nFI681tOAVe8+v5Iw8fxKg4MReJFZo+ShjhFPiEHpr7AEjLyrrKxmGeW2249433sxs5fYAFdUa67ZlBtoJiSg8tcKLNCoY5oOCk044Wb2pbqaLlFoYgMKEXFAUoc4c44YIikXdVcx9UdSIKInF2jecOldZX+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779335129; c=relaxed/simple;
	bh=hc77aHXvbN0OblB3PF3xH33gmuiXfaRzvPF1qhqW5rY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M8eyxAlNydnFTlM7CxVFXSvlhzArCwwNZW0BA5a2j4VDy5a8hIA4+xhzXC1tYUd2SxlY9UwU+0e6G2qgJ9tssDdtICc+b/HlqdkkRdovgq32gOjJOyTlkGUu3NGp6uQBT96hr/cGQQnC1HNj1hVrQhyB0z5N/89phP0uO+4+b6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCAKeUuA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCAKeUuA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB9E31F000E9;
	Thu, 21 May 2026 03:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779335128;
	bh=AMlFICCeB6jRLpfUFtl+LSOahXaxoo9vf7QZdn7YKMk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YCAKeUuAP4Ro+p48e5ldM+LJwW+2kzGciP9XNO1jnFK8zc9TLm8RdWtVcD5jDLUkk
	 4WTLwlbz9rCdNWhq4dB2WWYI67lMA7UVSkCVRLb4bhz3DDfJIFETU86JWnPBAUtyLV
	 jHmNeVvQhkVvMvFsT6kmgdp3/AV0sGyzyGJl912Y6A3gSnmFT5eZ28lMen10cdmQNr
	 iSnVVCHYRfvLhZ+bfuWN1oK/g2TY1NuThzcwb2qW+MCtxKZMaX9rLL/8oSlC8KWqrW
	 R80RY6+6P0CCKbLPQtNlzpI4FMjc95w8s6G47uHRJI0dMQiZ1ITEUee5h3F9cTr2ut
	 qEXDnPWB3Ro3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] HID: Expose LattePanda IOTA UPS as a power_supply
 device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrew Maney" <andrewmaney05@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260521031750.498110-1-andrewmaney05@gmail.com>
References: <20260521031750.498110-1-andrewmaney05@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 03:45:27 +0000
Message-Id: <20260521034527.CB9E31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] The driver unconditionally binds to the generic Arduino Leonardo V=
ID/PID, breaking standard HID input functionality for all such devices.
- [Medium] Device removal can block the USB disconnect process for up to 3 =
seconds if the device is unplugged during initialization.
- [Medium] The Kconfig dependency incorrectly requires `USB_HIDDEV`, preven=
ting the driver from being built on modern systems.
- [Low] Unsynchronized access to the `ups->psu` pointer causes a C data rac=
e.
--

commit 9862889f837997957a0680fd4f3667a6d06c2828
Author: Andrew Maney <andrewmaney05@gmail.com>

HID: Expose LattePanda IOTA UPS as a power_supply device

This commit introduces a new HID driver to expose the LattePanda IOTA UPS
as a power_supply device. It reports battery status and capacity via HID
reports from a custom Arduino Leonardo firmware.

> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index ff2f580b660ba..21ffc2fd06096 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -510,6 +510,16 @@ config HID_KYSONA
>  	Say Y here if you have a Kysona M600 mouse
>  	and want to be able to read its battery capacity.
> =20
> +config HID_LATTEPANDA_IOTA_UPS
> +	tristate "LattePanda IOTA UPS"
> +	depends on USB_HID && USB_HIDDEV && X86 && POWER_SUPPLY

[Severity: Medium]
Does this driver actually require the legacy /dev/usb/hiddevX interface?

Since the driver connects using HID_CONNECT_HIDRAW, depending on USB_HIDDEV
could unnecessarily prevent the driver from being enabled or compiled on
distributions that have disabled legacy hiddev support.

> +	help
> +	Support for the LattePanda IOTA UPS (DFRobot, VID 0x2341 PID 0x8036).
> +	Exposes the battery status and capacity via the power_supply interface.

[ ... ]

> diff --git a/drivers/hid/hid-lattepanda-iota-ups.c b/drivers/hid/hid-latt=
epanda-iota-ups.c
> new file mode 100644
> index 0000000000000..f5d522695081e
> --- /dev/null
> +++ b/drivers/hid/hid-lattepanda-iota-ups.c
> @@ -0,0 +1,409 @@
[ ... ]
> +static const struct hid_device_id iota_ups_devices[] =3D {
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_LATTEPANDA_IOTA,
> +		USB_DEVICE_ID_LATTEPANDA_IOTA_UPS) },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(hid, iota_ups_devices);

[Severity: High]
Does this driver unconditionally bind to the generic Arduino Leonardo VID/P=
ID
(0x2341/0x8036)?

Since it matches the standard development board ID and uses HID_CONNECT_HID=
RAW
without HID_CONNECT_HIDINPUT, will this prevent any Arduino Leonardo acting=
 as
a standard keyboard, mouse, or gamepad from functioning properly?

The driver might need to inspect the HID report descriptor during probe()
(e.g., checking for specific report IDs or usages) to confirm it is actually
communicating with the custom UPS firmware before returning success.

[ ... ]

> +static int iota_ups_raw_event(struct hid_device *hdev,
> +			      struct hid_report *report,
> +			      u8 *data, int size)
> +{
[ ... ]
> +	/*
> +	 * Notify the power_supply core outside the spinlock to avoid
> +	 * a deadlock; power_supply_changed() may call back into
> +	 * get_property() which acquires the same lock.
> +	 */
> +	if (changed && ups->psu)
> +		power_supply_changed(ups->psu);

[Severity: Low]
Could there be a data race when accessing ups->psu here?

In iota_ups_register_work(), ups->psu is assigned without synchronization.
Concurrently, iota_ups_raw_event() reads ups->psu outside of the spinlock.

While x86 aligned pointer writes are atomic (preventing partial pointer rea=
ds),
this is undefined behavior in C. Using WRITE_ONCE() and READ_ONCE(), or saf=
ely
reading the pointer inside the existing ups->lock critical section, would
prevent this.

> +
> +	return 0;
> +}

[ ... ]

> +static void iota_ups_remove(struct hid_device *hdev)
> +{
> +	struct iota_ups *ups =3D hid_get_drvdata(hdev);
> +
> +	cancel_work_sync(&ups->register_work);

[Severity: Medium]
Will device removal block the USB disconnect process for up to 3 seconds if
the device is unplugged during initialization?

If the device is abruptly disconnected while iota_ups_register_work() is st=
ill
waiting in wait_for_completion_timeout(), cancel_work_sync() will block her=
e.

Since the physically removed device cannot send reports to trigger complete=
(),
the wait will always take the full 3 seconds. The driver likely needs to si=
gnal
completion proactively during removal to abort the wait before calling
cancel_work_sync().

> +	hid_hw_close(hdev);
> +	hid_hw_stop(hdev);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521031750.4981=
10-1-andrewmaney05@gmail.com?part=3D1

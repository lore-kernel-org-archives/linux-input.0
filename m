Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09832E7377
	for <linux-input@vger.kernel.org>; Sun, 31 May 2026 22:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780265219; cv=none; b=tHCoUFYpyyNqJDjwb+N3D97PqLgFPA4mamNfo9zCk3zbd0xkqb0asIeAwjU/j6/Md53gKXa+oVf9hqNey2Vy9e6gJRnJifJYT4pjtdn/kja0+Mv0ieAi0Sk7XzQ93uWle4lH/ba+aDRSq6GkT0cMhxR8x55vPvdj0mKP4oqzr04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780265219; c=relaxed/simple;
	bh=2qqXx8gWBoIjPOoNTW07iSvtEM2inWWA89XfDISLVHg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uS1DOdGkZGQF/NYWWgeRhJDp91IwlOt8GTVh3k08WQWhqHK9mSwcjvGazk4ebgRmdX/+pK5+EnQ7uCZrS6cZ5KjWJmfnsqx4vMD55nWi1MU2N+4ntNhyct2brouHoO5RNhRhb7SwWcvkD3p64NtTAdWSUvoIBvjVqG8mbUnPHEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSAjZFBI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSAjZFBI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D5031F00893;
	Sun, 31 May 2026 22:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780265217;
	bh=JqVqFCiHLMA6MR8Bx2v/dkxSblIIfr9MDxejj5ITq4w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kSAjZFBI6EknrdOSvWUWf5vTsX/GAP9u3B0LqYdDaBvM8F94UogrEH4YEbAqDyoXo
	 wtXxQXv0ht/HqYUixQrB+Gf4xh1tCXUXsCKZgwcp8le0YFxysTM/Ri2QLDiou2/qTR
	 9JlW/PKoQ0Et4vGHXP5uva1FH+gVOrNel7yztXywjiJVluqP9nleWBh2FbkLKP/FCZ
	 A8fPzVrVxw9J4bDe21FQozG8NeiKzluESLRnUgPkSto/IZRnWz0Wnb1A+jjzXihoXG
	 gM+jVfYuuQ7LuZMhYvmjQ0BF9SSZeDnlfM2eFXkaLLulvr1Dknd1F2dQ6xJvndf+Kr
	 2RZJgVz+Te/HQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: steelseries: Add MSI Raider A18 HX A9WJG RGB
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Glushkov" <david.glushkov@sntiq.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260531215204.172030-1-david.glushkov@sntiq.com>
References: <20260531215204.172030-1-david.glushkov@sntiq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 31 May 2026 22:06:57 +0000
Message-Id: <20260531220657.7D5031F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Type Confusion / Out-of-Bounds Read due to unsafe cast to `usb_int=
erface`
- [High] `steelseries_remove()` unconditionally calls `cancel_delayed_work_=
sync()` on an uninitialized `delayed_work` struct.
- [Medium] Missing `hid_hw_stop()` and `hid_hw_close()` on probe error path.
- [Medium] Missing runtime PM management during direct USB control transfer=
, breaking LED updates when the device is idle.
--

commit 827dd1dcdf0039cad78b73365e7fd12bdc59d84e
Author: David Glushkov <david.glushkov@sntiq.com>

HID: steelseries: Add MSI Raider A18 HX A9WJG RGB support

This patch adds support for MSI Raider A18 HX A9WJG internal RGB devices
(KLC and ALC) to the steelseries HID driver. It exposes them as multicolor
LED class devices and sets uniform RGB values across zones.

> diff --git a/drivers/hid/hid-steelseries.c b/drivers/hid/hid-steelseries.c
> index f98435631aa18..0492814791753 100644
> --- a/drivers/hid/hid-steelseries.c
> +++ b/drivers/hid/hid-steelseries.c

[ ... ]

> @@ -528,6 +542,140 @@ static bool steelseries_is_vendor_usage_page(struct=
 hid_device *hdev, uint8_t us
>  		hdev->rdesc[2] =3D=3D 0xff;
>  }
> =20
> +static const struct dmi_system_id steelseries_msi_rgb_dmi_table[] =3D {
> +	{
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Micro-Star International Co., Ltd."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Raider A18 HX A9WJG"),
> +			DMI_MATCH(DMI_BOARD_NAME, "MS-182L"),
> +		},
> +	},
> +	{ }
> +};
> +
> +static struct usb_device *steelseries_hid_to_usb_dev(struct hid_device *=
hdev)
> +{
> +	return interface_to_usbdev(to_usb_interface(hdev->dev.parent));
> +}

[Severity: High]
Could this cause an out-of-bounds read if the device is not a USB device?

If a local user injects a virtual HID device with the MSI RGB vendor and
product IDs via the uhid subsystem, the device's parent will be the uhid
device, not a usb_interface.

Calling to_usb_interface() and interface_to_usbdev() without first verifying
the transport using hid_is_usb(hdev) could interpret the uhid parent memory
as a usb_interface, leading to wild pointer dereferences and a panic.

> +
> +static bool steelseries_msi_rgb_is_interface0(struct hid_device *hdev)
> +{
> +	return to_usb_interface(hdev->dev.parent) =3D=3D
> +	       usb_ifnum_to_if(steelseries_hid_to_usb_dev(hdev), 0);
> +}
> +
> +#if STEELSERIES_HAS_LEDS_MULTICOLOR
> +
> +static int steelseries_msi_rgb_set_blocking(struct led_classdev *led_cde=
v,
> +					    enum led_brightness brightness)
> +{

[ ... ]

> +	if (hdev->product =3D=3D USB_DEVICE_ID_STEELSERIES_MSI_KLC) {
> +		sd->rgb_buf[2] =3D 0x66;
> +		for (i =3D 0; i < ARRAY_SIZE(keys); i++) {
> +			sd->rgb_buf[4 + i * 4] =3D keys[i];
> +			sd->rgb_buf[5 + i * 4] =3D r;
> +			sd->rgb_buf[6 + i * 4] =3D g;
> +			sd->rgb_buf[7 + i * 4] =3D b;
> +		}
> +	} else {
> +		sd->rgb_buf[2] =3D 0x06;
> +		for (i =3D 0; i < ARRAY_SIZE(alc_zones); i++) {
> +			sd->rgb_buf[4 + i * 4] =3D alc_zones[i];
> +			sd->rgb_buf[5 + i * 4] =3D r;
> +			sd->rgb_buf[6 + i * 4] =3D g;
> +			sd->rgb_buf[7 + i * 4] =3D b;
> +		}
> +	}
> +
> +	ret =3D usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
> +			      HID_REQ_SET_REPORT,
> +			      USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
> +			      0x0300, 0,
> +			      sd->rgb_buf, 524, USB_CTRL_SET_TIMEOUT);

[Severity: Medium]
Will this USB control message fail if the device has entered runtime suspen=
d?

Because this directly uses usb_control_msg() and bypasses the HID transport
layer, it doesn't appear to wake the device. Without explicitly waking the
device via hid_hw_power(hdev, PM_HINT_FULLON) or usb_autopm_get_interface(),
the transfer might drop LED updates when the keyboard is idle.

> +
> +	mutex_unlock(&sd->rgb_lock);
> +	return ret < 0 ? ret : 0;
> +}

[ ... ]

> @@ -567,7 +721,15 @@ static int steelseries_probe(struct hid_device *hdev=
, const struct hid_device_id
>  	if (ret)
>  		return ret;
> =20
> -	if (steelseries_headset_battery_register(sd) < 0)
> +	if (sd->quirks & STEELSERIES_MSI_RGB) {
> +		ret =3D steelseries_msi_rgb_register(sd);
> +		if (ret)
> +			hid_err(hdev, "Failed to register MSI RGB LEDs: %d\n", ret);
> +		return ret;
> +	}

[Severity: Medium]
Does this error path leak the hardware state initialized by hid_hw_start()
and hid_hw_open() called earlier in steelseries_probe()?

Returning directly here skips calling hid_hw_stop() and hid_hw_close(),
which could leave active URBs and orphaned hidinput/hidraw device nodes
exposed to userspace.

> +
> +	if (sd->quirks & (STEELSERIES_ARCTIS_1 | STEELSERIES_ARCTIS_9) &&
> +	    steelseries_headset_battery_register(sd) < 0)
>  		hid_err(sd->hdev,
>  			"Failed to register battery for headset\n");

[Severity: High]
Since steelseries_headset_battery_register() and INIT_DELAYED_WORK() are
skipped for MSI RGB devices here, what happens when the device is removed?

If steelseries_remove() unconditionally calls cancel_delayed_work_sync() on
sd->battery_work, passing a zero-initialized work struct will trigger a
debug objects (ODEBUG) warning and splat on device removal.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260531215204.1720=
30-1-david.glushkov@sntiq.com?part=3D1

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D6632B126
	for <linux-input@vger.kernel.org>; Wed,  2 Sep 2026 14:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788357790; cv=none; b=A89fao2U6ZbCdiBLKDlEY7PSEn87aKaW2RjoK7q1W+39seh17tk95xSIAAUdLzmylY+PCnRurXl28cUxy9O1ZZ8c5FXVkAQNZDny3mbB8tIb7R/ZnLmsIkACA6fr7hwNtc2os5sINO1XE0t19BGW3zN7AjTXfw3pLbgcg4hwgw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788357790; c=relaxed/simple;
	bh=zT8uK3nF2LgWG+5aJJcsY8mhwm5/USkFznsMwPhu4Vs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uwgjFgNuKfjIKbceau6mWBohjGsP9J2H1MYL9imW1VOm1QFIoPKJzSECNV6RD29m2zmWOMMnK1DYO2RDq9gDhKs7RgC0X04cIABPB5cwT7+6uJBeyr4RbygJAc6LepcAx4flC5MIRNne5WMExiejbY0minKwoThMbPY19kjFHRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VyPxwZ1i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VyPxwZ1i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DCE31F000E9;
	Wed,  2 Sep 2026 14:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788357788;
	bh=fXDZeNMNj5b38EYBdvxQZd9XGXBPIa2U2cmhQ/tnvwA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VyPxwZ1irv/9hOAG0p4q6u4fOllocyfJRzhd47gOtfSKZbC0RPl2aFcwNQVcY8qGt
	 w9wPMt2vWnMUsRTgF4X2UGVKgbeLPakGy6LWeHPqqERUPoUGD9fB9NJ/Pq4FX5grbS
	 89Sd/yiftpo1pN6OLc0yN3cZ11bjM75XbtxJAfrNQuMnmjKo0v/NyzKtavaTeORM6P
	 M9F+OgaiLPq6DiQ12w0YW+G0eXb5PXLqMK3voK/R5u5x25yBbSHGc6rgua1PLJuZJC
	 /uiVqzAqHQqvU3zXg5Pll1FX16xrGK3HSYyQWPUN+5d/8TOrwjYKeGWHoJYUMhu5i4
	 kNLzdTu3vIIOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 2/5] HID: wacom: Advertise SW_MUTE_DEVICE capability
 prior to registration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lee Jones" <lee@kernel.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260902134417.1270552-2-lee@kernel.org>
References: <20260902134417.1270552-1-lee@kernel.org>
 <20260902134417.1270552-2-lee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 14:03:07 +0000
Message-Id: <20260902140308.2DCE31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Generic touch devices will enter an infinite -EPROBE_DEFER loop if=
 they share a USB device with a non-Pen/Pad HID interface.
- [High] Standalone generic touch devices with a hardware mute switch will =
no longer advertise the SW_MUTE_DEVICE capability.
- [Medium] Missing memory barrier / RCU acquire semantics when reading shar=
ed sibling state causes a TOCTOU race.

Pre-existing issues:
- [High] Missing cancel_delayed_work_sync in the hid_hw_open error path cau=
ses a Use-After-Free.
--

commit bd90131f0064218ea089e2069fff71db08186576
Author: Lee Jones <lee@kernel.org>
Subject: HID: wacom: Advertise SW_MUTE_DEVICE capability prior to registrat=
ion

This commit moves the SW_MUTE_DEVICE capability setup to
wacom_setup_touch_input_capabilities() for touch devices. It also defers
registration for generic touch devices until their sibling Pen/Pad interface
has been parsed and shared capabilities are initialized.

> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 0eafa483b7f75..026a6be467d3d 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
[ ... ]
> @@ -2359,12 +2348,52 @@ static void wacom_set_shared_values(struct wacom_=
wac *wacom_wac)
[ ... ]
> +static bool wacom_sibling_pending(struct wacom *wacom)
> +{
> +	struct hid_device *hdev =3D wacom->hdev;
> +	const struct wacom_features *features =3D &wacom->wacom_wac.features;
> +	struct usb_host_config *actconfig;
> +	int i;
> +
> +	if (features->type !=3D HID_GENERIC ||
> +	    !(features->device_type & WACOM_DEVICETYPE_TOUCH))
> +		return false;
> +
> +	if (wacom->wacom_wac.shared &&
> +	    rcu_access_pointer(wacom->wacom_wac.shared->pen))

[Severity: Medium]
Is there a potential TOCTOU race here due to a missing acquire barrier?

Because rcu_access_pointer() does not provide an acquire memory barrier,
could weakly ordered CPUs reorder the reads, seeing the updated pen pointer
here but a stale false value for the switch flag later when
wacom_setup_touch_input_capabilities() checks shared->has_mute_touch_switch?

> +		return false;
> +
> +	if (!hid_is_usb(hdev) || !wacom->usbdev)
> +		return false;
> +
> +	if (features->oPid !=3D HID_ANY_ID && features->oPid !=3D 0)
> +		return true;
> +
> +	actconfig =3D wacom->usbdev->actconfig;
> +	if (actconfig && actconfig->desc.bNumInterfaces > 1) {
> +		for (i =3D 0; i < actconfig->desc.bNumInterfaces; i++) {
> +			struct usb_interface *sibling_intf =3D actconfig->interface[i];
> +
> +			if (!sibling_intf || sibling_intf =3D=3D wacom->intf)
> +				continue;
> +
> +			if (sibling_intf->cur_altsetting->desc.bInterfaceClass =3D=3D
> +			    USB_INTERFACE_CLASS_HID)

[Severity: High]
Could this overly broad check lead to an infinite -EPROBE_DEFER loop?

If a generic touch device shares a USB device with a standard HID interface
(like a keyboard or raw vendor HID), the Wacom driver might reject the
standard interface, causing hid-generic to bind to it instead.

Since hid-generic would not populate wacom_wac.shared->pen, this check
would repeatedly observe shared->pen =3D=3D NULL and a sibling interface wi=
th
USB_INTERFACE_CLASS_HID, returning true indefinitely. It seems this could
leave the touch interface permanently trapped in probe deferral.

> +				return true;
> +		}
>  	}
> +
> +	return false;
>  }
[ ... ]
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index 4436faf2d2bbd..a7e3817aa2c4f 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -3965,6 +3965,10 @@ int wacom_setup_touch_input_capabilities(struct in=
put_dev *input_dev,
> =20
>  	if (features->type =3D=3D HID_GENERIC) {
>  		hid_dbg(hdev, "generic touch setup\n");
> +		if (wacom_wac->shared && wacom_wac->shared->has_mute_touch_switch) {

[Severity: High]
For standalone generic touch devices with a hardware mute switch, does this
result in the loss of the SW_MUTE_DEVICE capability?

The local parser sets the wacom_wac->has_mute_touch_switch flag, but this
now only checks the shared flag (wacom_wac->shared->has_mute_touch_switch).

However, wacom_set_shared_values() syncs the local flag to the shared
struct at the very end of wacom_parse_and_register(), which happens
after capabilities are set up. Could this leave the shared flag false
during setup for standalone devices, breaking userspace expectations?

> +			input_set_capability(input_dev, EV_SW, SW_MUTE_DEVICE);
> +			wacom_wac->has_mute_touch_switch =3D true;
> +		}
>  		/* setup has already been done */
>  		return 0;
>  	}

[ ... ]

[Severity: High]
This is a pre-existing issue, but I noticed a potential use-after-free
in the hid_hw_open() error path of wacom_parse_and_register().

During device probe, wacom_query_tablet_data() schedules wacom->init_work
with a 1-second delay. If the device has WACOM_DEVICETYPE_WL_MONITOR and
the subsequent hid_hw_open() fails:

	if (features->device_type & WACOM_DEVICETYPE_WL_MONITOR) {
		error =3D hid_hw_open(hdev);
		if (error) {
			hid_err(hdev, "hw open failed\n");
			goto fail_hw_stop;
		}
	}

The code jumps to fail_hw_stop without canceling the delayed work. Since
the devres framework frees the wacom structure on probe failure, does this
leave a dangling timer that will attempt to access freed memory when
wacom->init_work runs? Should cancel_delayed_work_sync(&wacom->init_work)
be called in this error path?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902134417.1270=
552-1-lee@kernel.org?part=3D2

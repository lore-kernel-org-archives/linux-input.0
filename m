Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5D4332907
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 17:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787678722; cv=none; b=ATJrOzeMW413YxfR51j4mCclWte7/vWoUYojipw8wwJvYd4XVXrHh2jeII5MBynu37wJbev2ztA1uN+3dVa1RrdhrQdoEwxLzPzEM/oL6Xu4Lc+UVC+HV77XfIpsvbRQvoIvwL8ShjFlw1J1fUBuBBY5lMsouc4WQSZE75vAuco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787678722; c=relaxed/simple;
	bh=qf0sVNNlq4csVF/0apEUzVb8XOGJPSgBBIutHOxQtMY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pUq+fpFP+n39vUyALki0/IydkXKl7OV/cC9ISeETzdCdjw+Sfx9sTL+oj4K/KOfvxMWjcGeEZ3aiCoJD3mNLNGGseArjb2ljuLVFAEhjs9UQG49wTRy571CKklrzcoYv5SlcJ6u2ekyASJhqeuD5pg4ibrldqrNe/PUUXgfVQEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wy5/XTvk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wy5/XTvk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE4941F00A3A;
	Tue, 25 Aug 2026 17:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787678721;
	bh=XXF4jBdrHIAt0/uj5QUam1gGoFrQZ9fo11NEmjHXxy4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wy5/XTvk8PBA0a7Hg1nCWcmUEjsId1HHrIM0hV5Ang5LqqHowiD4i0doNBJ0oRLV2
	 mC3nXWIC4JKMEQJlNhzwCeQvHdW65RPfToKR2bsPW68Gfxyl53YLFCEDmegkofHjvK
	 D0CMDNgJmJx2r0M7Rwiofgkq8v5CthDf3of4bdN++h5HOWv8DUgAvqqLCuJwvUWY9h
	 uE6QWbQOh9Lq1R/MUsG7uhksC8vi1Qqve0g93ooz7iXhEN+13kpb1pR+0131VPG6zx
	 6XWXR/db3LQWS9Kh6LxzkioHCpOCVrBZvzsWaZm+xrbSOazjn+s0r63opwisWxY1jH
	 2EpeQ8n30Z8fw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] HID: wacom: Advertise SW_MUTE_DEVICE capability
 prior to registration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lee Jones" <lee@kernel.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260825151242.576456-2-lee@kernel.org>
References: <20260825151242.576456-1-lee@kernel.org>
 <20260825151242.576456-2-lee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 17:25:20 +0000
Message-Id: <20260825172520.CE4941F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Infinite probe deferral if sibling interface is a Pad or unsupport=
ed HID device
- [Medium] TOCTOU race condition in shared capabilities advertisement

Pre-existing issues:
- [High] Use-After-Free of devm-allocated driver data on probe error path
--

commit 4eb131c54fac495d482614e8b0c028a0f23f19f7
Author: Lee Jones <lee@kernel.org>

HID: wacom: Advertise SW_MUTE_DEVICE capability prior to registration

This patch moves the SW_MUTE_DEVICE capability setup before input device
registration to comply with input subsystem guidelines. For generic touch
devices relying on a sibling Pen or Pad interface, it defers registration
via -EPROBE_DEFER until the shared capabilities are initialized.

> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 0eafa483b7f75..2738d4f515e6a 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c

[ ... ]

> @@ -2358,13 +2358,44 @@ static void wacom_set_shared_values(struct wacom_=
wac *wacom_wac)
>  		if (wacom_wac->is_soft_touch_switch)
>  			wacom_wac->shared->is_touch_on =3D true;
>  	}
> +}
> +
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
> +		return false;
> +
> +	if (!hid_is_usb(hdev) || !wacom->usbdev)
> +		return false;
> =20
> -	if (wacom_wac->shared->has_mute_touch_switch &&
> -	    wacom_wac->shared->touch_input) {
> -		set_bit(EV_SW, wacom_wac->shared->touch_input->evbit);
> -		input_set_capability(wacom_wac->shared->touch_input, EV_SW,
> -				     SW_MUTE_DEVICE);
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
> +				return true;
> +		}
>  	}
> +
> +	return false;
>  }

[Severity: High]
Could this lead to infinite probe deferral if the sibling interface is a Pad
or an unsupported HID device?

If a composite Wacom device presents a generic Touch interface and a Pad
interface (without a Pen), or a generic HID interface not handled by this
driver, this loop will return true indefinitely. The logic requires
shared->pen to be populated to stop deferring, but wacom_add_shared_data()
only populates shared->pen for Pen interfaces, leaving the Touch device
unusable.

>  static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
> @@ -2444,6 +2475,11 @@ static int wacom_parse_and_register(struct wacom *=
wacom, bool wireless)
>  	if (error)
>  		goto fail;
> =20
> +	if (wacom_sibling_pending(wacom)) {
> +		error =3D -EPROBE_DEFER;
> +		goto fail;
> +	}
> +
>  	error =3D wacom_setup_inputs(wacom);

[Severity: High]
This is a pre-existing issue, but does the error path in this function fail
to cancel scheduled asynchronous works, leading to a Use-After-Free?

If wacom_query_tablet_data() schedules init_work with a delay, and a
subsequent step like hid_hw_open() fails:

wacom_parse_and_register() {
    ...
    if (!wireless) {
        wacom_query_tablet_data(wacom); /* schedules init_work */
    }
    ...
    if (features->device_type & WACOM_DEVICETYPE_WL_MONITOR) {
        error =3D hid_hw_open(hdev);
        if (error) {
            goto fail_hw_stop;
        }
    }
    ...
fail_hw_stop:
    hid_hw_stop(hdev);
fail:
    wacom_release_resources(wacom);
    return error;
}

The error path returns and the driver core devres cleanup frees the
struct wacom. When the delayed work later executes, it will access the
freed memory. Should the error path explicitly cancel pending works?

> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index 4436faf2d2bbd..a7e3817aa2c4f 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c

[ ... ]

> @@ -3965,6 +3965,10 @@ int wacom_setup_touch_input_capabilities(struct in=
put_dev *input_dev,
> =20
>  	if (features->type =3D=3D HID_GENERIC) {
>  		hid_dbg(hdev, "generic touch setup\n");
> +		if (wacom_wac->shared && wacom_wac->shared->has_mute_touch_switch) {
> +			input_set_capability(input_dev, EV_SW, SW_MUTE_DEVICE);
> +			wacom_wac->has_mute_touch_switch =3D true;
> +		}
>  		/* setup has already been done */
>  		return 0;
>  	}

[Severity: Medium]
Is there a Time-of-Check to Time-of-Use (TOCTOU) race condition here when
enumerating concurrent USB interfaces?

In wacom_add_shared_data(), the Pen interface publishes itself to
shared->pen early. If the Touch device probe concurrently reads shared->pen
in wacom_sibling_pending(), it will break out of its deferral loop. However,
it may reach this point and read shared->has_mute_touch_switch before the
Pen device has finished parsing its descriptors and written to it in
wacom_set_shared_values(), causing the Touch device to miss advertising
the capability.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825151242.5764=
56-1-lee@kernel.org?part=3D2

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A18217723
	for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 02:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787366282; cv=none; b=Fe5bz7o/n59XcB26oHri1eRxwA+138/bB6nPM7Fx//AsKiGm/VTqofcK5xMSSHxrKVrr6jk5nwg7hZSUnlMr7fEVHthZ45qnHQi+l0Tb2m57h4fTMoMlc3BTxZ3xvFr1qMadkwPYw0V8+fD8KqeTMFSPUehSLPpPQOWnMwGcrVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787366282; c=relaxed/simple;
	bh=+IxCSf+D5anyHneWeUuqBW7HX73AY06ZR0GJa6Ezysc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JCuXDFST2C8iKq2nJbC9i9pGwOAFNRQWQ3L+0Y/7ABSYMrU0W6iwkaQL86kI+S5urftYtrnxrITFkMvlw0VAmej7fHJDjvpxABt3yXAzdSg4Ntgq+3jrDggPyHf7pKpwIdiVPdvd/ECEKAogq5x9QubxmDqFoi1IA581D2C6Fj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESZ0sl6U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESZ0sl6U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B861F000E9;
	Sat, 22 Aug 2026 02:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787366281;
	bh=ivTS5EHKgHEFA1EHJ8l7vfNOEOzbUrTqp59h+DvbDNo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ESZ0sl6UapU176VY+dEBVFijjzDjvy6Nmz0h9Nv0VyZaKEACyofvqM5Mux8yhQSjK
	 9aopwp1LWYBYmKCOwdPEcd3juq9qLWr4Ox3OEGR1aZbaFXJs6pT4H9vz7qJ8g9Xdzm
	 dpacWVAEfisXQJ4GcRbX553slBJVAWk81yphetBsZ+Urk0ocyeEYnT7ml4R2YXspRM
	 wR0Guj/sASLsw0oCXNg32BaolSLiNOZ/XLaHHxdF+Uyy9ktNIpMk72Iz7b3Cn42y23
	 99QF8Tqqh5+FxwDVFRkUwUKM06+4nVIXZMGZX6Z7TAubxCwX17ZBwmvDUgYo3ZFKxM
	 bQU8xrQLADotg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/12] Input: xbox_gip - Add HID relaying
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260822021140.1149546-5-vi@endrift.com>
References: <20260822021140.1149546-1-vi@endrift.com>
 <20260822021140.1149546-5-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 02:38:00 +0000
Message-Id: <20260822023801.14B861F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

New issues:
- [High] The tunneled `hid_device` (`attachment->hdev`) is permanently leak=
ed when the controller's metadata is reset, which can lead to a future Use-=
After-Free.
- [High] The HID device is configured with `BUS_USB` but its parent is set =
to a `usb_device` rather than a `usb_interface`, causing downstream HID dri=
vers to crash.
- [Medium] The transport driver uses `hid_input_report()` instead of the re=
quired `hid_safe_input_report()`, circumventing HID core bounds checking.
- [Low] Unnecessary `synchronize_rcu()` after `rcu_assign_pointer()` when p=
ublishing `hdev`.
- [Low] Not all required `hid_device` fields are initialized before `hid_ad=
d_device()`.

Pre-existing issues:
- [High] The error path in `gip_setup_input_device()` leaves a dangling poi=
nter in `attachment->input`, which causes a Use-After-Free during shutdown.
- [High] Missing NULL check after allocating memory with `devm_kmalloc` in =
`gip_send_raw_message()`, leading to a NULL pointer dereference.
--

--- Patch [4]: [PATCH v4 04/12] Input: xbox_gip - Add HID relaying ---
commit a021e64e3205f2caaac1426796abb2e1c1a1a8e6
Author: Vicki Pfau <vi@endrift.com>

Input: xbox_gip - Add HID relaying

GIP allows tunneling of HID packets, with the HID descriptor embedded in
the GIP metadata exchanged during the initial handshake. This patch creates
a hid_device for this HID descriptor if found, as well as relaying the HID
packets.

> diff --git a/drivers/input/joystick/gip/gip-core.c b/drivers/input/joysti=
ck/gip/gip-core.c
> index 15f8ed2107110..c833b10259ab8 100644
> --- a/drivers/input/joystick/gip/gip-core.c
> +++ b/drivers/input/joystick/gip/gip-core.c

[ ... ]

> @@ -1361,7 +1409,34 @@ static int gip_send_init_sequence(struct gip_attac=
hment *attachment)
>  	if (rc)
>  		return rc;
> =20
> -	return 0;
> +	if (attachment->metadata.device.hid_descriptor) {
> +		struct hid_device *hdev =3D hid_allocate_device();
> +
> +		if (IS_ERR(hdev))
> +			return PTR_ERR(hdev);

[Severity: High]
Does this leak the previous hdev if called multiple times, or does
gip_reset_metadata() need to be updated to clean up this new device?

When the metadata is reset, gip_reset_metadata() tears down the input
device:

	if (input) {
		rcu_assign_pointer(attachment->input, NULL);
		synchronize_rcu();
		input_unregister_device(input);
	}

But the newly added attachment->hdev is not destroyed there, which could
leave a stray hid_device and lead to a use-after-free via hidraw.

> +
> +		hdev->ll_driver =3D &gip_hid_ll_driver;
> +		hdev->bus =3D BUS_USB;
> +		hdev->vendor =3D attachment->vendor_id;
> +		hdev->product =3D attachment->product_id;

[Severity: Low]
Are there missing hid_device initializations here?

The HID subsystem guidelines recommend fully initializing the device fields
(such as uniq, version, country, etc.) before calling hid_add_device().

> +		hdev->dev.parent =3D to_gip_device(attachment);

[Severity: High]
Could this parent assignment cause a crash in downstream HID drivers?

The device is configured as a USB bus device, but the parent is being set
to a gip_device (which contains a usb_device) rather than a usb_interface.
Many USB HID drivers assume the parent is a usb_interface and call
to_usb_interface() on it. If they do, they will perform an invalid cast and
crash.

> +		hdev->driver_data =3D attachment;
> +		if (attachment->name)
> +			strscpy(hdev->name, attachment->name);
> +		else
> +			strscpy(hdev->name, "Xbox Chatpad");
> +		strscpy(hdev->phys, attachment->phys);
> +		rc =3D hid_add_device(hdev);
> +		if (rc) {
> +			gip_err(attachment, "HID device add failed: %d\n", rc);
> +			hid_destroy_device(hdev);
> +		} else {
> +			rcu_assign_pointer(attachment->hdev, hdev);
> +			synchronize_rcu();

[Severity: Low]
Is this synchronize_rcu() call necessary?

Since rcu_assign_pointer() already provides the needed memory barriers to
publish a new pointer, and we aren't waiting for readers of an old pointer
to finish (as there isn't one being freed here), calling synchronize_rcu()
might just unnecessarily block and degrade performance.

> +		}
> +	}
> +
> +	return rc;
>  }

[ ... ]

> @@ -1769,9 +1844,16 @@ static int gip_handle_command_firmware(struct gip_=
attachment *attachment,
>  static int gip_handle_command_hid_report(struct gip_attachment *attachme=
nt,
>  	const struct gip_header *header, uint8_t *bytes, int num_bytes)
>  {
> -	gip_warn(attachment, "Unimplemented HID report message\n");
> +	struct hid_device *hdev;
> =20
> -	return -EOPNOTSUPP;
> +	guard(rcu)();
> +	hdev =3D rcu_dereference(attachment->hdev);
> +	if (hdev)
> +		return hid_input_report(hdev, HID_INPUT_REPORT, bytes, num_bytes, true=
);

[Severity: Medium]
Does this bypass the HID core's bounds checking?

Using hid_input_report() instead of hid_safe_input_report() for incoming
data violates the HID subsystem transport guidelines, as it prevents the
core from validating the size of the buffer.

> +
> +	gip_warn(attachment, "Got HID report with no HID descriptor\n");
> +
> +	return -EPROTO;
>  }

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the input
device lifecycle, I noticed a potential use-after-free during shutdown.

In gip_setup_input_device(), if input_register_device() fails, the pointer
is left dangling:

	err_free_device:
		input_free_device(input);
		return rc;

When gip_shutdown() later runs, it sees the remaining attachment->input
pointer and calls input_unregister_device() on an already freed device.

[Severity: High]
This is a pre-existing issue, but does this allocation in
gip_send_raw_message() need a null check?

	fragment->data =3D devm_kmalloc(to_gip_device(attachment),
		fragment->total_length, GFP_ATOMIC);
	fragment->fragment_offset =3D 0;
	memcpy(fragment->data, bytes, num_bytes);

If the atomic allocation fails and returns a null pointer, the immediate
memcpy() will cause a kernel panic.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822021140.1149=
546-1-vi@endrift.com?part=3D4

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A94470EAC
	for <linux-input@vger.kernel.org>; Tue, 18 Aug 2026 15:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787066943; cv=none; b=gQBQ3ig8rpMlm7Dt33ufVFeRiJoMVPGbH9mjAKlM9WhuNBLtCTPQuyJrLNU0hKStudkksNif2FSLnwYAb0rycYiToEWXOTDG+/NxozANHg8fXUDstCC5ZhCSjI10WR2WTcr9DvnQfjbozBZghF2KYT/VA44RThi3CbMHWxy8JH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787066943; c=relaxed/simple;
	bh=PwdTyuYbnnkHc7r2ZauosnwpW11Tov6V/Phx5pyLyak=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P/VvmrfPgsVAdfoxZ+Pr5CcTFSN4+P3Pv47KMA7Fw0TdRGF+jGVq6ozDZ6Xnm699viSDV1MF8K5czUO/IOTbxtw+fO6Y5Krv54HsAUHFp/cY1NrAKilUCZ4WlB3G75KrVZvTkJfc1RTtSrqXIXbOfnuwiboDXDimgo2mYEjkUYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvGPGQGq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvGPGQGq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D781F00A3D;
	Tue, 18 Aug 2026 15:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787066942;
	bh=o4Kj1Klhk7fjfk/ilq6lolnfnMahspYKieDrHglS8Lg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fvGPGQGqiKlDk/eVvDc8o3+P3eoXFpWIdMYFUapJfQLoOL+4v8zqPn6JCTprdWWt5
	 aDHMS1N6iU6GqWHeadqJmgw4smmeKrYj/T1eZEUYZoFYYBjIB65Bu/EcL4n/kKq5v/
	 VhbWLJLwyVgatrXaSfVfOnZOdeMPbUL0x3Z4Q1Hzh828ETueTfQrDVSdFxNhavG2QX
	 Y+wbmSUS2hLIxpHa27gbWF+/3gjW7j5P/lWjbxSWygV32mge96b4snOGwsz/2sJanY
	 ijcXl8wwmnAII00c/skqkxLLuZq9oUNjWwZhOVvBci+4MWdM12mD42Lp+8eT7fjQh4
	 v8wE83a9BJjvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] HID: asus: do not send keyboard init reports to
 touchpads
Reply-To: sashiko-reviews@lists.linux.dev
To: "Panz Dev" <panz.development@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260818151431.939132-1-panz.development@gmail.com>
References: <20260818151431.939132-1-panz.development@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 15:29:01 +0000
Message-Id: <20260818152901.B5D781F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing `hid_is_usb()` check before casting the parent device =
to a `usb_interface` in `asus_kbd_register_leds()`.
- [High] Dangling pointer `drvdata->kbd_backlight` causes a Use-After-Free =
in `asus_remove()` if `asus_hid_register_listener()` fails.
- [High] Incorrect teardown order in `asus_remove()` cancels `fn_lock_sync_=
work` before stopping the hardware, leading to a Use-After-Free race condit=
ion.
- [High] Dangling pointer dereference of `drvdata->input` in `asus_probe()`=
 when a device has multiple report IDs or applications and the last one has=
 no mapped usages.
--

--- Patch [1]: [PATCH v2] HID: asus: do not send keyboard init reports to t=
ouchpads ---
commit 83a2843d77c483e6b894c00208643414ac5b2d26
Author: Panz Dev <panz.development@gmail.com>

HID: asus: do not send keyboard init reports to touchpads

This commit avoids sending keyboard feature reports to touchpad endpoints
by wrapping the initialization loop in an if (!drvdata->tp) check. This
prevents sending invalid feature requests that could corrupt the touchpad
probe state.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c

[ ... ]

> -	for (int r =3D 0; r < ARRAY_SIZE(asus_report_id_init); r++) {
> -		if (asus_has_report_id(hdev, asus_report_id_init[r])) {
> -			ret =3D asus_kbd_init(hdev, asus_report_id_init[r]);
> -			if (ret < 0)
> -				hid_warn(hdev, "Failed to initialize 0x%x: %d.\n",
> -					 asus_report_id_init[r], ret);
> +	if (!drvdata->tp) {
> +		for (int r =3D 0; r < ARRAY_SIZE(asus_report_id_init); r++) {
> +			if (asus_has_report_id(hdev, asus_report_id_init[r])) {
> +				ret =3D asus_kbd_init(hdev, asus_report_id_init[r]);
> +				if (ret < 0)
> +					hid_warn(hdev, "Failed to initialize 0x%x: %d.\n",
> +						 asus_report_id_init[r], ret);
> +			}
>  		}
>  	}

[ ... ]

>  	if (drvdata->input && (hdev->claimed & HID_CLAIMED_INPUT)) {
>  		if (drvdata->tp)
>  			drvdata->input->name =3D "Asus TouchPad";

[Severity: High]
This is a pre-existing issue, but can this lead to a use-after-free?

When a device uses HID_QUIRK_MULTI_INPUT, hidinput_connect() creates a
separate hid_input for each application. The asus_input_configured() functi=
on
unconditionally assigns drvdata->input =3D hi->input.

If the last report ID processed has no valid input usages, the hid_input and
its input_dev are freed by the core, leaving drvdata->input pointing to
freed memory.

Since earlier valid report IDs successfully registered, HID_CLAIMED_INPUT is
set. Could this dereference the freed pointer here to set the name?

While reviewing the driver, I also noticed a few other pre-existing issues
in this file:

> static int asus_kbd_register_leds(struct hid_device *hdev)
> {
[ ... ]
> 	if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD) {
> 		intf =3D to_usb_interface(hdev->dev.parent);
> 		udev =3D interface_to_usbdev(intf);
> 		validate_mcu_fw_version(hdev,
> 			le16_to_cpu(udev->descriptor.idProduct));
> 	}

[Severity: Critical]
This is a pre-existing issue, but does asus_kbd_register_leds() need to ver=
ify
the transport type before casting the parent device?

If the driver is bound via a non-USB transport like an injected uhid device,
the parent is not a USB interface. Can this read of the product ID access
invalid memory and cause a crash?

[ ... ]

> 	ret =3D asus_hid_register_listener(&drvdata->kbd_backlight->listener);
> 	if (ret < 0) {
> 		/* No need to have this still around */
> 		devm_kfree(&hdev->dev, drvdata->kbd_backlight);
> 	}

[Severity: High]
This isn't a bug introduced by this patch, but does asus_kbd_register_leds()
leave a dangling pointer if asus_hid_register_listener() fails?

The error path calls devm_kfree() on drvdata->kbd_backlight but doesn't
set the pointer to NULL.

During unbind, asus_remove() checks if (drvdata->kbd_backlight) and
dereferences it. Could this cause a use-after-free?

[ ... ]

> static void asus_remove(struct hid_device *hdev)
> {
> 	struct asus_drvdata *drvdata =3D hid_get_drvdata(hdev);
[ ... ]
> 	if (drvdata->quirks & QUIRK_HID_FN_LOCK)
> 		cancel_work_sync(&drvdata->fn_lock_sync_work);
>
> 	hid_hw_stop(hdev);

[Severity: High]
This is a pre-existing issue, but is the teardown order in asus_remove()
safe from race conditions?

cancel_work_sync() is called before hid_hw_stop(). Because the hardware is
not stopped, incoming HID reports can continue to trigger asus_event() and
unconditionally re-queue the worker:

drivers/hid/hid-asus.c:asus_event() {
    ...
    if (drvdata->quirks & QUIRK_HID_FN_LOCK) {
        drvdata->fn_lock =3D !drvdata->fn_lock;
        schedule_work(&drvdata->fn_lock_sync_work);
    }
    ...
}

Could the pending work item execute after devres frees drvdata, leading to a
use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818151431.9391=
32-1-panz.development@gmail.com?part=3D1

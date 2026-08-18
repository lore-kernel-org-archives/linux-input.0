Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCB13932EE
	for <linux-input@vger.kernel.org>; Tue, 18 Aug 2026 09:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787044546; cv=none; b=n2qsAbzPRWyxmFj7k7Au0462q8y3i8IeqlF5kk8AbBIFIJHvFAKsqjWyNzoBl229fYq9ROj2msJ46ilG4RTTvXFhXsfd5S5T13b3l5lTs4ZKjwCLsqiMCElofS2lbu9cuyY5Q+VbaKm3uc5V0Ww/ac5PvzNSgGge+h3ih1zXGgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787044546; c=relaxed/simple;
	bh=B72AWwnVdZDRWb0WNSQaWjLXA2wgb9Kbz9SIOVopoeE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=egFYHfn8nNwfTdD7H8nFTwUmIzF/EebHcYNvieM8EQgp2gZpUTc0+ulhbvxnkIjtxYvHdoPk3/ELWJu5wpjeEWbloxslkcN71VwLM8l8FmhdTKx9juAW99RGXfhqnyauTVjwwbJS1ddQoq81DTv22/XVH1BkdZsJ1bHns6AjgMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJIoH5ST; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJIoH5ST"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C9C1F000E9;
	Tue, 18 Aug 2026 09:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787044544;
	bh=ZhNxF9weviGW5a/bNhAOjChSoHMM+OyWh24DeFE50/c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dJIoH5STgQT8tCAQsVOCoMuNS4QJxYe8PNuY+gs3rNpBORIVTP8AqmkSBdFxvcDsq
	 krstehijoJbr847EaXfhlvZd+ZAinLUv+9HLSANiSRhzufVbM5BHJWo/auY9E7Jwy8
	 /+I6NpiA4QlCIr2kqnhyYbZ8/rp0XiTWTRfH7yynI2jiYWvcR4q4+Z4OFMn1V426Xx
	 KJ+Z1F9TUgGTM6qyFMJBkSpLYeaFOkEoYqBiajvxhSUGkevtFxIrLGjSDvdPBmHBTX
	 HTw+hzDObQ2YWMd9Z7SSbb5mJ8MVK5+JFDKrX8qbTtWikP/HTtH9NAJHtsq/ZWDfLm
	 8qVHGrSVUdArQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: asus: fix touchpad multitouch initialization
 regression
Reply-To: sashiko-reviews@lists.linux.dev
To: "Panz Dev" <panz.development@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260818085623.18467-1-panz.development@gmail.com>
References: <20260818085623.18467-1-panz.development@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 09:15:44 +0000
Message-Id: <20260818091544.88C9C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Unconditionally calling `asus_start_multitouch()` outside the `HID=
_CLAIMED_INPUT` check introduces a Use-After-Free if input registration fai=
ls.

Pre-existing issues:
- [High] Incorrect cleanup order in `asus_remove()` creates a Use-After-Fre=
e race condition by cancelling the workqueue before disabling hardware even=
ts.
- [High] Missing `hid_is_usb()` check in `asus_kbd_register_leds()` allows =
an invalid cast to `usb_interface`, causing out-of-bounds reads or crashes.
- [Medium] Modifying `input->name` after device registration creates a data=
 race and violates input subsystem API requirements.
--

--- Patch [1]: [PATCH] HID: asus: fix touchpad multitouch initialization re=
gression ---
commit 53becd94719f665ca15fc8c3f4b7876a402da45f
Author: Panz Dev <panz.development@gmail.com>

HID: asus: fix touchpad multitouch initialization regression

This patch fixes probe regressions for ASUS I2C/HID touchpads by skipping
keyboard report initialization for touchpads and moving
asus_start_multitouch() outside the claimed input check block.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 3f5e96900b67a..72b93bdeb4e8f 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
[ ... ]
> @@ -1327,12 +1329,12 @@ static int asus_probe(struct hid_device *hdev, co=
nst struct hid_device_id *id)
>  			drvdata->input->name =3D "Asus TouchPad";
>  		else
>  			drvdata->input->name =3D "Asus Keyboard";

[Severity: Medium]
This is a pre-existing issue, but can modifying drvdata->input->name here
after device registration (which occurs earlier during hid_hw_start) create=
 a
data race?

If a userspace process like udev reads the name attribute concurrently, mig=
ht
it read the default string or race with the pointer reassignment?

> +	}
> =20
> -		if (drvdata->tp) {
> -			ret =3D asus_start_multitouch(hdev);
> -			if (ret)
> -				goto err_stop_hw;
> -		}
> +	if (drvdata->tp) {
> +		ret =3D asus_start_multitouch(hdev);
> +		if (ret)
> +			goto err_stop_hw;
>  	}

[Severity: High]
Does moving asus_start_multitouch() outside the HID_CLAIMED_INPUT check
introduce a use-after-free regression if input registration fails?

If input_register_device() fails during hid_hw_start(), hidinput_connect()
frees the allocated input_dev and returns an error without setting
HID_CLAIMED_INPUT.

Since the HID_CLAIMED_INPUT safety guard is now removed, the driver
will force the touchpad hardware to start sending reports. When the hardware
interrupt arrives, asus_raw_event() intercepts it and routes to
asus_report_input():

drivers/hid/hid-asus.c:asus_raw_event() {
    ...
	if (drvdata->tp && data[0] =3D=3D INPUT_REPORT_ID)
		return asus_report_input(drvdata, data, size);
    ...
}

This blindly dereferences the freed drvdata->input pointer, which was assig=
ned
earlier in asus_input_configured():

drivers/hid/hid-asus.c:asus_report_input() {
    ...
		input_mt_slot(drvdat->input, i);
		input_mt_report_slot_state(drvdat->input, toolType, down);
    ...
}

Is it possible for this to cause a use-after-free, for instance if triggered
via uhid device spoofing or resource allocation failures during probe?

> =20
>  	return 0;

[Severity: High]
This isn't a bug introduced by this patch, but does the cleanup order in
asus_remove() create a use-after-free race condition?

In asus_remove(), the driver calls:

drivers/hid/hid-asus.c:asus_remove() {
    ...
	if (drvdata->quirks & QUIRK_HID_FN_LOCK)
		cancel_work_sync(&drvdata->fn_lock_sync_work);

	hid_hw_stop(hdev);
    ...
}

If the device sends a KEY_FN_ESC report via hardware interrupt immediately
after cancel_work_sync() returns but before hid_hw_stop() completes, might
asus_event() re-queue the work via schedule_work()? Once asus_remove()
finishes, the devm-managed drvdata is freed, which could leave the work item
scheduled and lead to a use-after-free when the worker executes.

[Severity: High]
This is a pre-existing issue, but could the lack of a hid_is_usb() check in
asus_kbd_register_leds() allow an invalid cast?

When handling the QUIRK_ROG_ALLY_XPAD quirk:

drivers/hid/hid-asus.c:asus_kbd_register_leds() {
    ...
	if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD) {
		intf =3D to_usb_interface(hdev->dev.parent);
		udev =3D interface_to_usbdev(intf);
    ...
}

If the device is connected via another transport (like Bluetooth, I2C, or
spoofed via uhid), the parent device is not a USB interface. Would calling
interface_to_usbdev() on this invalid pointer lead to out-of-bounds
memory access or a crash?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818085623.1846=
7-1-panz.development@gmail.com?part=3D1

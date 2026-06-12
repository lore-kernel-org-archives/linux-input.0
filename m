Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ADB348452
	for <linux-input@vger.kernel.org>; Fri, 12 Jun 2026 14:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781275120; cv=none; b=V6vYCoUucRWHDcFdYKIYhfZhd2O6uRWJipN1rblG989di5jShpxgT7B17FBu2T8fG9PFPBXHRR3DXDIQowPIRV0AjbddXw1pi9Na/WrhM8tyfo3syb/eE2wMTg0alcLdqhZloEsJ0bKSY2nDzY4gXcPleSqjKKa1PIE1+bA+cEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781275120; c=relaxed/simple;
	bh=t19CLn4AXID6oWsEWoP+2PHmOtoeqax3TYh5iNsbG5I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Py1eGSaOhPXw2Vh7Vm33klo5mKXPCHRNGXIJ4OHXQwoshcmvWsMXs+YoTS273PNhf9Lf4AHisO5Ntkjw/DKEljYsGa6i8rfWnIuqfB9TB6ZvIr5FY3BQSGsjtnawRdjs5ZH43vZmzwXEcr5C8CeTzSFMAK3sq26fd5t+udI1O4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=la5kFzoa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="la5kFzoa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD8651F000E9;
	Fri, 12 Jun 2026 14:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781275119;
	bh=3Qz1neuN/kjrGO4su6CXDWMJPPre/zCFV/mZrbpEWmo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=la5kFzoaWw4qbBH8cwoD8LXYDF6QcP2NUcS5sRwNHeYuFD16O1qbUWZ8WsKPVMVwd
	 5VRhQF91fu9nAjqf1OJwfxoOLkGqVkN721yaI03bswL+LBgFb2KTkRXez7qvrUKBLC
	 EAukrvOTU8OZL8bYldrVfJsa6XIccdKQLgW/AUigpSJwOxFiJVoG5lPDdC9lUbMjYe
	 5BDdCEJo9Q49D/fkt54EOm0s+3fCH0Gp9olufjhrIcfYg65gO0VRR689/MPNH1JRMK
	 UvuYrv92eYaKf9FSQX3iZ55+Iom1DKtgYApJ/Oi9TnKehCxod2s9xW3u02BjWwbQ2E
	 Tzrk8TnvapBzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] HID: asus: prevent wrong pointer cast
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260612142326.1704858-3-denis.benato@linux.dev>
References: <20260612142326.1704858-3-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 14:38:38 +0000
Message-Id: <20260612143838.BD8651F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing cleanup in asus_probe error path leads to Use-After-Free.
- [High] Calling ACPI method evaluation from HID raw_event handler leads to=
 sleeping in atomic context.
--

commit 3fe25fc3ce0bf42eb96551214cb9606ee3c5ff97
Author: Denis Benato <denis.benato@linux.dev>

    HID: asus: prevent wrong pointer cast
   =20
    The firmware version check for ROG ally devices assumes the parent devi=
ce
    is a USB device, therefore prevent possible out-of-bounds access by usi=
ng
    hid_is_usb() to mitigate possible out-of-bounds access.

    Link: https://lore.kernel.org/all/20260612130125.AAAE71F000E9@smtp.kern=
el.org/

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -753,7 +753,7 @@ static int asus_kbd_register_leds(struct hid_device *=
hdev)
>  			return ret;
>  	}
> =20
> -	if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD) {
> +	if (hid_is_usb(hdev) && (drvdata->quirks & QUIRK_ROG_ALLY_XPAD)) {
>  		intf =3D to_usb_interface(hdev->dev.parent);
>  		udev =3D interface_to_usbdev(intf);
>  		validate_mcu_fw_version(hdev,

[Severity: High]
This isn't a bug introduced by this patch, but while looking at
asus_kbd_register_leds(), I noticed it registers a listener to a global list
and uses devm_kzalloc(). If a subsequent initialization step in asus_probe()
fails:

drivers/hid/hid-asus.c:asus_probe() {
    ...
			ret =3D asus_start_multitouch(hdev);
			if (ret)
				goto err_stop_hw;
    ...
err_stop_hw:
	hid_hw_stop(hdev);
	return ret;
}

Can this lead to a use-after-free on the listener?

The driver returns without unregistering the listener, and the devres
subsystem will automatically free the memory, leaving a dangling pointer
in the global list.

[Severity: High]
This is a pre-existing issue, but I also noticed that asus_raw_event() can
synchronously trigger an ACPI method evaluation:

drivers/hid/hid-asus.c:asus_raw_event() {
    ...
				int ret =3D asus_wmi_send_event(drvdata, ASUS_FAN_CTRL_KEY_CODE);
    ...
}

drivers/hid/hid-asus.c:asus_wmi_send_event() {
    ...
	err =3D asus_wmi_evaluate_method(ASUS_WMI_METHODID_DEVS,
				       ASUS_WMI_METHODID_NOTIF, code, &retval);
    ...
}

For USB HID devices, asus_raw_event() is invoked from the URB completion
handler in atomic context.=20

Since wmi_evaluate_method() acquires mutexes and may sleep, will this cause
the kernel to sleep in atomic context?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612142326.1704=
858-1-denis.benato@linux.dev?part=3D2

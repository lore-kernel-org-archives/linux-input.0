Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A476E36B043
	for <linux-input@vger.kernel.org>; Fri, 12 Jun 2026 14:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781275071; cv=none; b=AE0xopZ3OVoX0bZP12/w979W7+2g/MVfHe2Vp1PiwoVI3o2pSN9t2sVK68fip9PYqRHXcQEBMWMiChQ13qNZr8Kcjrjw/Zmu7tA9HiNDnYTupxbBxp0IJqiEhFY1iqiRMrebfFDqHxzbgksKbWeJ6IxBzbYO2jTyUFVMVO1vUGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781275071; c=relaxed/simple;
	bh=z5GVs923KuaVkwVWdEHSQP72g+vNsdPtC9RKmShoaV4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=huqm2K7vT83hN3QF25Lnh4NWZC3xZ4rvAeOjvNlj+90SkwbJhSeDA3j5EW7WsNdrkDqBnEYMvIiYYiQAlHDfQDYd1UC1n2FZD90xqdNO0skGzOY/Az7X5SM6/FPtTQr7dnVCQU3uvCf11fmO+AzYazaalz/liZ0kLfrXfpALJlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUp1u9fU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUp1u9fU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B531F000E9;
	Fri, 12 Jun 2026 14:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781275070;
	bh=QuPgYwHaQziCGnf7T68KElry4FvshrfEE63v/a0Mol0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lUp1u9fUREhGInIXt55l04yWx2ALF2scVk9f8LvFlRv0KnELWvNuy/GkGWh4NbSdb
	 a9rsru3GvMH2h5iy5uoOsg8W/Ky5dDybcPjireS4QuK5nmZjBLXZb+/diDHzTVahy2
	 2eRRJrSdeRcZAINZ7SLYCKzfBYsW1SDiMpniQRLSKtChV/EtYlJzj95gJ/RYQBAVqw
	 /1I7UjfyREa4806IpY3aOEzIiRu4n9ONBB3ZY8+uiDzIxgP3ftnlRajxgy952gdST/
	 5O+5hhmeVYUTfDfQeM+Vuusf8P/1v6eBHbcWiF/Q03ak+c4tdN50eukctQ7KKypZDg
	 dy5zRzsqdFdTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] HID: asus: add i2c entry for FA808UM and other
 TUFs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260612142326.1704858-5-denis.benato@linux.dev>
References: <20260612142326.1704858-5-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 14:37:49 +0000
Message-Id: <20260612143750.26B531F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Improper Workqueue Initialization / Memory Corruption via Re-i=
nitialization
- [High] Use-After-Free due to Race Condition in `asus_remove()`
- [High] Missing NULL check for `devm_kasprintf` allocation leading to Kern=
el Oops
--

commit ee67627a03893a0ccf0a7653ac62191a687b7821
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add i2c entry for FA808UM and other TUFs

On newer TUF laptops the keyboard HID device uses the same PID/VID of a
USB device that was found in ROG laptops: add it to hid-asus as i2c too.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 0f78242b6a1db..7964fc96196e5 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -1565,6 +1565,9 @@ static const struct hid_device_id asus_devices[] =
=3D {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
>  	    USB_DEVICE_ID_ASUSTEK_ROG_NKEY_KEYBOARD2),
>  	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD | QUIRK_HID_FN_LOCK=
 },
> +	{ HID_I2C_DEVICE(USB_VENDOR_ID_ASUSTEK,
> +	    USB_DEVICE_ID_ASUSTEK_ROG_NKEY_KEYBOARD2),
> +	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD | QUIRK_HID_FN_LOCK=
 },

[Severity: Critical]
This is a pre-existing issue, but since this patch enables QUIRK_HID_FN_LOCK
for a new device, could the fn_lock_sync_work initialization cause workqueue
corruption?

In asus_input_configured(), INIT_WORK(&drvdata->fn_lock_sync_work, ...) is
called per-input. For devices with multiple inputs, if hid_hw_start() enabl=
es
interrupts before all inputs are configured, an early KEY_FN_ESC event could
schedule the work before the next input is configured.=20

The next call to asus_input_configured() would then re-execute INIT_WORK() =
on
the already queued work item, clearing its list pointers and causing a pani=
c.=20

Additionally, for devices with 0 inputs, it is never initialized, causing a
warning in cancel_work_sync().

[Severity: High]
This is a pre-existing issue, but is there a potential use-after-free during
device removal when QUIRK_HID_FN_LOCK is enabled?

In asus_remove(), cancel_work_sync(&drvdata->fn_lock_sync_work) is called
before hid_hw_stop(hdev). Since the hardware is still active, a late
KEY_FN_ESC event can trigger asus_event() and unconditionally call
schedule_work() after the work was supposedly canceled.=20

Once the driver is removed and drvdata is freed by devres, could the
workqueue execute asus_sync_fn_lock() and dereference the freed drvdata?

[Severity: High]
This is a pre-existing issue, but does the XGM LED name allocation need a
NULL check?

In asus_probe(), devm_kasprintf() is used to allocate the name for
drvdata->xgm_led->cdev.name:

	drvdata->xgm_led->cdev.name =3D devm_kasprintf(&hdev->dev, GFP_KERNEL,
			"asus:xgm-%s:led",
			strlen(hdev->uniq) ?
			hdev->uniq : dev_name(&hdev->dev));
	drvdata->xgm_led->cdev.brightness =3D 1;

If devm_kasprintf() fails under memory pressure, it returns NULL. This NULL
pointer is then passed to led_classdev_register(), which passes it to
led_classdev_next_name() and eventually to strscpy() as the source string.=
=20
Since strscpy() does not check for a NULL source, this would cause an
immediate NULL pointer dereference.

>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
>  	    USB_DEVICE_ID_ASUSTEK_ROG_Z13_LIGHTBAR),
>  	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD },

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612142326.1704=
858-1-denis.benato@linux.dev?part=3D4

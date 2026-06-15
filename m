Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0643240B6F4
	for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 17:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781542847; cv=none; b=SN+ff8JzUnxhPZvI78ktZ49N7vjnlSjiEsy8/g220k1xkybPAROiK3Hld/aGeu0JWXATuoTKr4KsqRy7wuiBubzQD9IPexuFA9ErpiGlcQpULxAEtgiHZvrBP2jofZlzbInAw33gV0Voux6yx5DQ+3M3ZUpBwZ2V97Ur+9yNFeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781542847; c=relaxed/simple;
	bh=EmnzxuL1oHKNocIT//11unedltuvB27eHzKgNfhSoVU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IMDNYRsCsK7fiAzqwskxVNDrfWqQQDCQU5yfpobjl+3FDHOlhk8FH79S4vsLkUWeeWbRHWeuxdsZJ5V14t19iv3y1Y6CoqAGZo+rIjAaLOXOmuN4yld4ctEEkO22tv6Onxm+O5vv4SE42ebU6V/Ep/N5piqcLgKfObpl5XT/xzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjDWnRnO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjDWnRnO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF91E1F000E9;
	Mon, 15 Jun 2026 17:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781542845;
	bh=nkmxhN9VBXc/3aCRPkmC03pY5KkNUrKScMzUK3zSTNM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AjDWnRnOpTI2hdO+E3Pj3lS9ShjoN5t9XBG0wBfQRsujPtcunLh5TUVaPXuX82xz/
	 4UTN9QBwdGZZqu1ETYdui40W1qktj+QhkTyH9BOlD0+o8sOUyhnyBShNs+5JGngB2A
	 11kWl9eI7uAvvnElDcJxS8/MWYjt0zE4Am81sg1prUOc9lT+3hWp5nCRgza1AtPCC4
	 2LzL8iL7JOJMOv5gJ8rLyV/J7yeVwvIbxHjB4d04i5q/mMNJagG+mM2udzoVx0i44H
	 tDu1LyqSseWv9Xz4Yn49UM2rt6butD28AULhyNVKjOoM59t9Zvx4WYAQDxxiu21NH6
	 x5bt6MUZlOIRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/5] HID: asus: add support for xgm led
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260615165058.3845-5-denis.benato@linux.dev>
References: <20260615165058.3845-5-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 17:00:45 +0000
Message-Id: <20260615170045.AF91E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Propagating cosmetic LED restore errors during system resume cause=
s the entire device resume to fail.
- [High] Failing to initialize the auxiliary XG Mobile LED aborts the entir=
e HID device probe.
- [High] Manual call to `hid_hw_stop()` while using `devm_led_classdev_regi=
ster()` leads to a use-after-teardown bug during device removal and probe e=
rror paths.
--

commit 26f82fa14c4bebc817bb5d79a1cdcdc34bb503d3
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add support for xgm led

XG mobile stations have very bright leds behind the fan that can be
turned either ON or OFF: add a cled interface to allow controlling the
brightness of those red leds.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 6896730efafca..e68a6d93369d8 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
[ ... ]
> @@ -1343,9 +1371,52 @@ static int asus_start_multitouch(struct hid_device=
 *hdev)
>  	return 0;
>  }
> =20
> +static int asus_xgm_init(struct hid_device *hdev, struct asus_drvdata *d=
rvdata)
> +{
[ ... ]
> +	drvdata->xgm_led->cdev.brightness_set_blocking =3D asus_xgm_led_set;
> +
> +	/* LED state is arbitrary on boot, set a default */
> +	ret =3D asus_xgm_led_set(&drvdata->xgm_led->cdev, drvdata->xgm_led->cde=
v.brightness);
> +	if (ret) {
> +		hid_err(hdev, "Asus failed to set xgm led: %d\n", ret);
> +		goto asus_xgm_init_err;
> +	}
> +
> +	ret =3D devm_led_classdev_register(&hdev->dev, &drvdata->xgm_led->cdev);

[Severity: High]
Because this LED is registered using devm_led_classdev_register(), its
unregistration happens during the devres cleanup phase. This phase runs aft=
er
the driver's remove callback (or probe error path) finishes.

If the probe error path or asus_remove() manually calls hid_hw_stop(hdev),
the HID transport is shut down. During the subsequent devres cleanup,
led_classdev_unregister() is called and sets the LED to LED_OFF. This invok=
es
asus_xgm_led_set(), which calls hid_hw_raw_request() on a stopped interface.

Could this lead to a use-after-teardown bug?

> +	if (ret) {
> +		hid_err(hdev, "Asus failed to register xgm led: %d\n", ret);
> +		goto asus_xgm_init_err;
> +	}
> +
> +	return 0;
> +asus_xgm_init_err:
> +	drvdata->xgm_led =3D NULL;
> +	return ret;
> +}
> +
>  static int __maybe_unused asus_resume(struct hid_device *hdev)
>  {
>  	struct asus_drvdata *drvdata =3D hid_get_drvdata(hdev);
> +	int ret;
> =20
>  	/*
>  	 * If we have a backlight listener registered, restore the previous sta=
te,
> @@ -1355,7 +1426,17 @@ static int __maybe_unused asus_resume(struct hid_d=
evice *hdev)
>  	if (drvdata->listener.brightness_set)
>  		asus_kbd_backlight_set(&drvdata->listener, drvdata->kbd_backlight_brig=
htness);
> =20
> +	if (drvdata->xgm_led) {
> +		ret =3D asus_xgm_led_set(&drvdata->xgm_led->cdev, drvdata->xgm_led->cd=
ev.brightness);
> +		if (ret) {
> +			hid_err(hdev, "Asus failed to restore xgm brightness: %d\n", ret);
> +			goto asus_resume_err;

[Severity: High]
If asus_xgm_led_set() fails to restore the LED state (e.g., due to an I/O
error or timeout), this returns the error code directly to the PM core.
A failed resume callback causes the PM subsystem to treat the device resume=
 as
failed, potentially leaving primary features like the keyboard and touchpad
unresponsive.

Would it be better for the failure of a cosmetic LED restore to log a warni=
ng
instead of aborting the entire device resume?

> +		}
> +	}
> +
>  	return 0;
> +asus_resume_err:
> +	return ret;
>  }
> =20
>  static int __maybe_unused asus_reset_resume(struct hid_device *hdev)
[ ... ]
> @@ -1484,6 +1565,16 @@ static int asus_probe(struct hid_device *hdev, con=
st struct hid_device_id *id)
>  		}
>  	}
> =20
> +	if (asus_has_report_id(hdev, FEATURE_KBD_REPORT_ID) &&
> +	    ((hdev->product =3D=3D USB_DEVICE_ID_ASUSTEK_XGM_2022) ||
> +	     (hdev->product =3D=3D USB_DEVICE_ID_ASUSTEK_XGM_2023))) {
> +		ret =3D asus_xgm_init(hdev, drvdata);
> +		if (ret) {
> +			hid_err(hdev, "Failed to initialize xg mobile: %d\n", ret);
> +			goto err_stop_hw;

[Severity: High]
If asus_xgm_init() fails, the code jumps to err_stop_hw, failing the entire
device probe.

Does this make a non-critical aesthetic feature a hard dependency for the
entire device? Might it be safer to log the failure rather than preventing
the keyboard and touchpad from working?

> +		}
> +	}
> +
>  	/* Laptops keyboard backlight is always at 0x5a */
>  	if (is_vendor && (drvdata->quirks & QUIRK_USE_KBD_BACKLIGHT) &&
>  	    (asus_has_report_id(hdev, FEATURE_KBD_REPORT_ID)) &&

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615165058.3845=
-1-denis.benato@linux.dev?part=3D4

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E324312819
	for <linux-input@vger.kernel.org>; Fri, 12 Jun 2026 14:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781275072; cv=none; b=kwMx0tniBZkYb0CsGI1t+6d2NKtWZqVIu4TkrZeMZeCGy/AI0jea5TO2ahZztyaxYXMeyIBBm/mfZONeK3fDT7TnC/IqQ7D/8vgIPfk6EU7DhinEHx/i0bPit72aiFslqUTX38ezz8Bmis4HA/P4iEAI1cR2Kc7udLu0OPVMgHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781275072; c=relaxed/simple;
	bh=pVvrtkKyNLlRRjXu2X0przpQO2ZAdSyQ3MzyobHapKc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cA9i+W2iBWFmb2KZtK1wHixVSFWba0daxqrBGXeflFIdiISuw9UgZZP1QUJcu5O+rnhy7ytOFzhIjxQBKe66t8f6ENne58/CXm0+bQ6+2yZyYLvYHM38Ge444jrueRt8CLuIGj/fw9MqzGxQIvgsO3Y9pd9jHIPbEdItzvs4B1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQ5nUYsO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQ5nUYsO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C98141F00A3A;
	Fri, 12 Jun 2026 14:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781275071;
	bh=l9J7CzzPu/DgC6Ir9DbdTASz64Q83o5muySKdSHYCqI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZQ5nUYsOqM6S1C4p9GTs6HPWPEYU04ChzlfaF7aekjxMV/FYLOHDdCuz49/6jRUx6
	 1PtlxmpizyUssttoQkrkuMoXdqNfoPS6SFDM8ZnBiqWVYbQxHB15LNuO8/C8AyKYAs
	 doO16CKesFiYU81YRg5nBcjPKYL3+qg/MLc2lndzGDDg/4z2lDdn+iK8WcLUAYJxLy
	 nGwANu17UhDxyTTgUz6BeaUHIwhHTGdowF1HV3M+UWKPhwh/4DygFrXtDUL4hZyaq/
	 jRHZIfdPV2XkQOLcBbXljnVBx/K7ol0uspbW03CpdrplcijP01UZTBA2/ANXOWvDpv
	 TpEp3re4SVpjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] HID: asus: add support for xgm led
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260612142326.1704858-4-denis.benato@linux.dev>
References: <20260612142326.1704858-4-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 14:37:50 +0000
Message-Id: <20260612143750.C98141F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Missing NULL check for devm_kasprintf() return value causes a kern=
el panic on allocation failure.
- [High] Missing led_classdev_unregister() in the asus_probe() error path c=
reates a structural Use-After-Free risk.
- [Low] Incorrect error propagation in asus_xgm_led_set() when asus_kbd_set=
_report() returns a short byte count or 0.

Pre-existing issues:
- [High] Missing cleanup of kbd_backlight->listener and fn_lock_sync_work o=
n asus_probe() error path causes Use-After-Free.
--

commit a9179e65e5727586c134f2af39cf55f67620125b
Author: Denis Benato <denis.benato@linux.dev>
Subject: HID: asus: add support for xgm led

This patch adds support for controlling the brightness of the red leds behi=
nd
the fan on XG mobile stations. It introduces a cled interface via the
led_classdev to turn them on or off.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 52d755659d951..0f78242b6a1db 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
[ ... ]
> @@ -941,6 +949,23 @@ static int asus_battery_probe(struct hid_device *hde=
v)
>  	return ret;
>  }
> =20
> +static int asus_xgm_led_set(struct led_classdev *led_cdev, enum led_brig=
htness value)
> +{
> +	const u8 buf[ROG_XGM_REPORT_SIZE] =3D {
> +		FEATURE_KBD_LED_REPORT_ID2, 0xC5, (value) ? 0x50 : 0x00
> +	};
> +	struct asus_xgm_led *xgm =3D container_of(led_cdev, struct asus_xgm_led=
, cdev);
> +	int ret;
> +
> +	ret =3D asus_kbd_set_report(xgm->hdev, buf, ROG_XGM_REPORT_SIZE);
> +	if (ret !=3D ROG_XGM_REPORT_SIZE) {
> +		hid_err(xgm->hdev, "Unable to set XG mobile led state: %d\n", ret);
> +		return ret;

[Severity: Low]
Could this return a positive value or 0 on failure?

asus_kbd_set_report() returns the number of bytes transferred on success or=
 a
negative error code on failure. If a partial transfer occurs or if it retur=
ns
0, this check will evaluate to true and return the non-negative value. The
caller might silently treat a 0 return value as success, bypassing error
handling expectations.

> +	}
> +
> +	return 0;
> +}
> +
[ ... ]
> @@ -1304,6 +1337,40 @@ static int asus_probe(struct hid_device *hdev, con=
st struct hid_device_id *id)
>  		}
>  	}
> =20
> +	if (asus_has_report_id(hdev, FEATURE_KBD_REPORT_ID) &&
> +	    ((hdev->product =3D=3D USB_DEVICE_ID_ASUSTEK_XGM_2022) ||
> +	     (hdev->product =3D=3D USB_DEVICE_ID_ASUSTEK_XGM_2023))) {
> +		drvdata->xgm_led =3D devm_kzalloc(&hdev->dev, sizeof(*drvdata->xgm_led=
), GFP_KERNEL);
> +		if (drvdata->xgm_led =3D=3D NULL) {
> +			ret =3D -ENOMEM;
> +			goto err_stop_hw;
> +		}
> +		drvdata->xgm_led->hdev =3D hdev;
> +		drvdata->xgm_led->cdev.name =3D devm_kasprintf(&hdev->dev, GFP_KERNEL,
> +					"asus:xgm-%s:led",
> +					strlen(hdev->uniq) ?
> +					hdev->uniq : dev_name(&hdev->dev));

[Severity: High]
Does this code need to check if devm_kasprintf() returns null?=20

Under memory pressure, if this allocation fails, passing the null cdev.name=
 to
led_classdev_register() will lead to a null pointer dereference in the led
subsystem when it uses strscpy() to copy the device name.

> +		drvdata->xgm_led->cdev.brightness =3D 1;
> +		drvdata->xgm_led->cdev.max_brightness =3D 1;
> +		drvdata->xgm_led->cdev.brightness_set_blocking =3D asus_xgm_led_set;
> +
> +		/*
> +		 * Sometimes after a reboot LEDs are ON, sometimes are OFF: set them to
> +		 * what the default brightness resets when doing a cold boot.
> +		 */
> +		ret =3D asus_xgm_led_set(&drvdata->xgm_led->cdev, drvdata->xgm_led->cd=
ev.brightness);
> +		if (ret) {
> +			hid_err(hdev, "Asus failed to set xgm led: %d\n", ret);
> +			goto err_stop_hw;
> +		}
> +
> +		ret =3D led_classdev_register(&hdev->dev, &drvdata->xgm_led->cdev);
> +		if (ret) {
> +			hid_err(hdev, "Asus failed to register xgm led: %d\n", ret);
> +			goto err_stop_hw;

[Severity: High]
If asus_probe() fails later in the probe process and jumps to err_stop_hw,
does the error path miss unregistering the led device?

Because the xgm_led structure is allocated with devm_kzalloc(), it will be
automatically freed when the probe fails. If led_classdev_unregister() isn't
called on the err_stop_hw path, the led subsystem may retain active referen=
ces
to the freed cdev, potentially causing a use-after-free when sysfs led
attributes are accessed.

[Severity: High]
This isn't a bug introduced by this patch, but looking at the error path for
asus_probe() when jumping to err_stop_hw:

err_stop_hw:
	hid_hw_stop(hdev);
	return ret;

It seems we miss cleaning up kbd_backlight->listener and fn_lock_sync_work
if the probe fails downstream. Once devres cleans up drvdata, the listener
remains in the global list in asus-wmi, which might lead to a use-after-free
if a WMI event triggers the listener and accesses the freed memory.

> +		}
> +	}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612142326.1704=
858-1-denis.benato@linux.dev?part=3D3

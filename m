Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F55C35959
	for <linux-input@vger.kernel.org>; Fri, 19 Jun 2026 00:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781828585; cv=none; b=JQ0hQeEmQ4q9p2Yrrcaz25BAGxOJ1eY18NgBZ9Q408a7MlXSE552uFTLcd0iKd1smQfwh4HWMtbedud99x4xM2d/RRPVInkE9kPJL5y+PEXStT5ogqkOJ6U2ErAhugrxVJVPwgVLwmQLhNjWeUl7Z1B2lfASk/zsQVodxugJelU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781828585; c=relaxed/simple;
	bh=p+61EtB955LMsjL6l7j56SS5sgERnJ23Po64HNySEmk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FgN0I/YDbibz2I4GXAo9pPFxHoJGsvSkIAguI7DRDu2FrhI1BbwWaGedZWVnBAhLGmv/C2QjSGbGK3z/KsHjbikZDjapqvnnqAiFau29jGpuYMI3jIs/EQCtG+srcBfSmu62mLP65hTkrVfBAHoYTs5JBIJWWN9tEUMZqfplsIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DplVEOQ/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DplVEOQ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0DF1F00A3D;
	Fri, 19 Jun 2026 00:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781828584;
	bh=h1zrhECW9A1Bnbw8MHTFA3ObTKIkcGf/ObxmxN2sc/k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DplVEOQ/JnPBukhEcOETvRCfNn3nCIWenCJihzGLaFfL8jvdVFKjhV91MQL77SpzM
	 y2WT06RzlSA7twYiD3Gn6Yfwgk8sh5um5rH3mvoai2VV0DCR0s5grYbUdo7DPcm+Cf
	 s3bLgkgWctJcui0kRByyHOuge9FHAXp3JD8ZGZ9gI7OPnDNZ+0kpkQlW4P0mBkRX3F
	 jwD+fK+NObIgB0+Nm4jjRUHLQLXBHIqnXfVlz20H6pOO4ZagIS2OjDSPmGPxM+bXV/
	 2wvP3QOilNOMmGtcVU93Ssd0UtCaNY2RgM50btZDrY3n5K/i1sFWz/ZF9e/jrvKo2Y
	 rN7fXXE7eswKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/5] HID: asus: add support for xgm led
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260619001103.1189200-5-denis.benato@linux.dev>
References: <20260619001103.1189200-1-denis.benato@linux.dev>
 <20260619001103.1189200-5-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 00:23:03 +0000
Message-Id: <20260619002303.DF0DF1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] A failure to initialize the cosmetic XG Mobile LED aborts the enti=
re HID device probe.
- [High] Failing to restore the XGM LED brightness causes the entire HID de=
vice resume process to fail.

Pre-existing issues:
- [High] The devm-managed battery is not explicitly unregistered before sto=
pping the hardware, leading to use-after-stop during teardown.
--

commit 7aa41eaa0bd3e715bef4c850703c7d47445cad14
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add support for xgm led
   =20
XG mobile stations have very bright leds behind the fan that can be
turned either ON or OFF: add a cled interface to allow controlling the
brightness of those red leds.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 0fb8cd6437b77..06e4888f090ca 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c

[ ... ]

> @@ -1361,7 +1432,17 @@ static int __maybe_unused asus_resume(struct hid_d=
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
> +		}
> +	}
> +
>  	return 0;
> +asus_resume_err:
> +	return ret;

[Severity: High]
In asus_resume(), if asus_xgm_led_set() fails to restore the LED state,
returning an error causes the entire HID device resume process to fail.

Will this leave the device in an inconsistent state and break input
functionality?

As documented in the comments for the backlight, non-fatal LED state
restorations shouldn't fail the system resume. Could this just ignore the e=
rror
here as well?

[ ... ]

> @@ -1491,6 +1572,16 @@ static int asus_probe(struct hid_device *hdev, con=
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
> +		}
> +	}
> +

[Severity: High]
If asus_xgm_init() fails due to a transient USB error during the initial
asus_xgm_led_set() call, will this completely abort the HID device probe and
disable the keyboard?

Since similar features like the keyboard backlight only emit a warning on
failure, should a non-fatal cosmetic LED initialization failure also just w=
arn
and allow the driver to continue normal operation?

[ ... ]

> @@ -1540,6 +1631,9 @@ static void asus_remove(struct hid_device *hdev)
>  	if (drvdata->listener.brightness_set)
>  		asus_hid_unregister_listener(&drvdata->listener);
> =20
> +	if (drvdata->xgm_led)
> +		devm_led_classdev_unregister(&hdev->dev, &drvdata->xgm_led->cdev);
> +
>  	asus_worker_stop(drvdata->worker);
>  	hid_hw_stop(hdev);
>  }

[Severity: High]
This is a pre-existing issue, but the devm-managed battery is not explicitly
unregistered before stopping the hardware.

Because the battery is registered via devm_power_supply_register() before
hid_hw_start(), and hid_hw_stop() is called here before the devres cleanup,
could this lead to a use-after-stop?

If a concurrent read of the battery sysfs properties happens during teardow=
n, it
triggers asus_battery_get_property() which calls hid_hw_raw_request() on a
stopped HID device. Can this cause bus hangs or undefined behavior?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619001103.1189=
200-1-denis.benato@linux.dev?part=3D4

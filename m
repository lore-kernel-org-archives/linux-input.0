Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1503803E7
	for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 15:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781365340; cv=none; b=ogUIRIyLBJHJUJOjkjvv8XwbnxhIs32Po5eswBI+dVX9DBu8m0ku0ctFGU+/340p6fAdofWNbbHJqmEu1q/4XeQSdun3tV5QKGEXGVNW/8fVQYP5WQ2+TpzM4JFilHP7MAIQSghzGBU1NfyAWDt4OtwWR59295K08omDB/2cW48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781365340; c=relaxed/simple;
	bh=x2Cr8I4EpbaS0vFuESFSUOjQwFm44ygVFwwf80sBrnc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mT5Ybpz+vChxt8jhnrZGa4h4QVUbhA6QuvJZllzkNDu3gJZa/pSco3ajsGGUf9W6v3IQcKEc1boUeGV81WICxlIGIpKS5dKz4j/FgIby7d51tne8/uonbDra2+u3PqSJJ7JZDxWNd0mMmiR9wvQJkjbSPlnydcbsLOuikLUXHhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VEdmUS4d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEdmUS4d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3B9B1F000E9;
	Sat, 13 Jun 2026 15:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781365337;
	bh=UEvWxXJfZfwEliM9njMeX1b2GRBCwAOMxc3UxRlzPVo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VEdmUS4dL7V3MMW1rinwUkSYSVbPYLin3BqVOojYUKfDgLeYc0EI8BfqqtThYsgWW
	 J7QQaMj36fg/5BnBNpHgSjjqf7iDE86mKw03G5qCrqXoN1z0SazIWec6R979IDzocN
	 44uJClrWBg8qL/EOy22XmekdtDRcjVwGi3zJSVfec6XEN/saKKBZJoCwxeDY0L+qyZ
	 3KEn+10hoeboGIABma/Ow5BxPS6b4g5HKSbTUW1JY+WgUFrKSht8/v010yOUdpXU3g
	 /ErFU2UaiBuW6tcWvdz3/fnOwGCuvJC0MGpCrbErBnFqbhLpYpi8vDpds2in2s1hkV
	 ljnMI44Zf4Thg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/8] HID: asus: add support for xgm led
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260613153029.2559774-4-denis.benato@linux.dev>
References: <20260613153029.2559774-4-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 15:42:17 +0000
Message-Id: <20260613154217.B3B9B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Missing led_classdev_unregister() in the probe error path leads to=
 a use-after-free.
- [Medium] An error during keyboard backlight resume causes the XGM LED res=
ume to be skipped.
- [Medium] Returning a positive short transfer length from brightness_set_b=
locking instead of a negative error code.
--

commit 201b953e7851d7aae6a4427d79499eefd3b7b433
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add support for xgm led

XG mobile stations have very bright leds behind the fan that can be
turned either ON or OFF: add a cled interface to allow controlling the
brightness of those red leds.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 52d755659d951..95e7dc6a447d8 100644
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

[Severity: Medium]
If a short transfer occurs, asus_kbd_set_report() will return a positive
number less than ROG_XGM_REPORT_SIZE.=20

Will returning this positive value cause the LED subsystem API to incorrect=
ly
interpret the short transfer as a success instead of a failure?

> +	}
> +
> +	return 0;
> +}
> +
[ ... ]
> @@ -1178,6 +1248,14 @@ static int __maybe_unused asus_resume(struct hid_d=
evice *hdev)
>  		}
>  	}
> =20

[Severity: Medium]
If restoring the keyboard backlight fails earlier in asus_resume(), the
early return via goto asus_resume_err causes this XGM LED resume logic
to be skipped.

Should the device resume function try to resume as many independent
components as possible instead of unconditionally aborting here?

> +	if (drvdata->xgm_led) {
> +		ret =3D asus_xgm_led_set(&drvdata->xgm_led->cdev, drvdata->xgm_led->cd=
ev.brightness);
> +		if (ret) {
> +			hid_err(hdev, "Asus failed to restore xgm brightness: %d\n", ret);
> +			goto asus_resume_err;
> +		}
> +	}
> +
>  asus_resume_err:
>  	return ret;
>  }
[ ... ]
> @@ -1304,6 +1382,16 @@ static int asus_probe(struct hid_device *hdev, con=
st struct hid_device_id *id)
>  		}
>  	}
> =20
> +	if (asus_has_report_id(hdev, FEATURE_KBD_REPORT_ID) &&
> +	    ((hdev->product =3D=3D USB_DEVICE_ID_ASUSTEK_XGM_2022) ||
> +	     (hdev->product =3D=3D USB_DEVICE_ID_ASUSTEK_XGM_2023))) {
> +		ret =3D asus_xgm_init(hdev, drvdata);

[Severity: High]
If asus_probe() encounters an error later on (such as asus_start_multitouch=
()
failing), the error handling path does not unregister the LED class device.

Because drvdata->xgm_led was allocated with devm_kzalloc(), devres will
free it. Does this lead to a use-after-free if userspace interacts with the
sysfs interface of the leaked cdev structure?

Would using devm_led_classdev_register() in asus_xgm_init() instead of
led_classdev_register() cleanly avoid this issue?

> +		if (ret) {
> +			hid_err(hdev, "Failed to initialize xg mobile: %d\n", ret);
> +			goto err_stop_hw;
> +		}
> +	}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613153029.2559=
774-1-denis.benato@linux.dev?part=3D3

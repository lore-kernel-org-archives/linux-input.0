Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B212E35DA76
	for <linux-input@vger.kernel.org>; Thu, 11 Jun 2026 22:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781216463; cv=none; b=JQh3hMFIjyhNqPwEMFN7cKqNQ4HUZMMbBKM273+n6zetTUfVz+TD1lz4A8RFO7nGnUNMuTjhUKPX6jFRZLt1igRG4XlgXthZOJhYHVrtkZmnj3l/DJs4fRxyy3yx/RyKN41NxldiX2HMqZ64DDnMeBT8ZUUbyN9EkrFDDqs9qkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781216463; c=relaxed/simple;
	bh=6pVAr7nRapShMkQKAWgJmv1kcVN4aWm5qHLb8ZwhdXI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hQ7O8XJQB46SErq4YfEjJvRYoSYHiimAVU/Hd1qK28zBYIYA2G8CGWT/LBmvPcg7G3TL5elqTUpb+qAkXw2Q3jVILcfuFhdT5MRbJebb7Q0X03BP5iDPhsEFaYG9DmaX1pZmFzYizktbptcAAMVD/b1t9EF9xpExRsfmAouBXTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WB7twzvD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WB7twzvD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2528F1F000E9;
	Thu, 11 Jun 2026 22:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781216462;
	bh=jZkBp8+pDNA9OIYnzncUxZZI4NxLSeKQypkOSgRlQn4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WB7twzvDBCLNVimxOVnRndSigm9QEKvmprddBiOa325ZrmBkVaF7wB20Q3kqgFvfw
	 GenbzvwyG2hHJ66pSP5e3aOtdaevBsgVUjIka8lzxZ36mnXkEYLWXT01+oivnUtYNy
	 sMvmjxfzwLFhwxrPJbxBgDhVRxUhuwE5MthAQ2IyaTUW4EF8KapSN9r5oDiw6Oz9y+
	 ZY4lqhxt/6a4aa2LO9cpZ7UmGBooor1F41R9Gm+9SHs7W5TNo8wZAA8Ihv6SgclMwO
	 jLK6JpJI0ABeOCx27qU8gQWCrqVD9GEL/4awV70pHjWxTSi8EIzghR1RPWD2lnjjfr
	 idecS6kXxME/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: asus: add support for xgm led
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260611221141.45456-1-denis.benato@linux.dev>
References: <20260611221141.45456-1-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 22:21:01 +0000
Message-Id: <20260611222102.2528F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The `asus_xgm_led_set` function is incorrectly assigned to the non=
-blocking `brightness_set` LED callback, but it performs sleeping operation=
s.
- [Medium] The XGM LED class device name is hardcoded, which causes device =
probe failures due to sysfs naming collisions.
--

commit 55bc647f99f9d2c64c1e99f0ee43e81efa5a6298
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add support for xgm led

XG mobile stations have very bright leds behind the fan that can be
turned either ON or OFF: add a cled interface to allow controlling the
brightness of those red leds.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 3f5e96900b67a..8a5f364b7535f 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c

[ ... ]

> @@ -1303,6 +1327,32 @@ static int asus_probe(struct hid_device *hdev, con=
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
> +		drvdata->xgm_led->cdev.name =3D "asus:xgm:led";

[Severity: Medium]
If multiple XG Mobile docks are connected, or if an ungraceful disconnect
leaves a stale sysfs entry behind, will this hardcoded name cause a sysfs
naming collision? A duplicate name error here would cause
led_classdev_register() to fail and abort the entire HID device probe.

Should this use a dynamic identifier, perhaps incorporating dev_name(),
to ensure uniqueness?

> +		drvdata->xgm_led->cdev.brightness =3D 1;
> +		drvdata->xgm_led->cdev.max_brightness =3D 1;
> +		drvdata->xgm_led->cdev.brightness_set =3D asus_xgm_led_set;

[Severity: High]
Can this cause a sleep-in-atomic bug if the LED is triggered by a software
blink (such as a timer or heartbeat sysfs trigger)?

When software blinking is used, the LED core invokes the brightness_set
callback directly from softirq context. However, asus_xgm_led_set() calls
asus_kbd_set_report(), which performs a GFP_KERNEL allocation and a blocking
USB transaction via hid_hw_raw_request().

Should this callback be assigned to brightness_set_blocking instead,
so the LED core knows to defer the sleeping work to a workqueue?

> +		ret =3D led_classdev_register(&hdev->dev, &drvdata->xgm_led->cdev);
> +		if (ret) {
> +			hid_err(hdev, "Asus failed to register xgm led: %d\n", ret);
> +			goto err_stop_hw;
> +		}
> +
> +		/*
> +		 * Sometimes after a reboot LEDs are ON, sometimes are OFF: set them to
> +		 * what the default brightness resets when doing a cold boot.
> +		 */
> +		asus_xgm_led_set(&drvdata->xgm_led->cdev, drvdata->xgm_led->cdev.brigh=
tness);
> +	}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611221141.4545=
6-1-denis.benato@linux.dev?part=3D1

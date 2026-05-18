Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A99D199EAD
	for <linux-input@vger.kernel.org>; Mon, 18 May 2026 23:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779148564; cv=none; b=jaUMSyICaxgkNU522/VESDFTHB47DGoun3lS7QgElR6QRZIURsT8ViwGSwIeLuTcF2+vFlGE2UnMCicmCS2pjs62V2pqaPVuGEE+DPwz0IIm+sqCIsu2aLfS2e/1BGH2YkQvyfM0KF/ymqDTq4NTFZ9D9N86Z35vwrqAyGFYpJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779148564; c=relaxed/simple;
	bh=aTpXjJOXPjXj2yLBpQmAPp2xAH0F3qCWgIB8ObbK5Ws=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mPGgsrp54n5g+vy43EkTEOaCrLNjapExS3hONVcmwzOVWacjth2sPb5xd/xaz0zgRccScR05uj8UObHl8RCDC9jcpkmXE/iwZTkzt4vyTxqJ5bitRbXNMSgZsi2H74tpnVWvDfIIeQ2CcEDyDIAa5VwwXdO5KSAdUmk6SlaVFx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KawZPAiB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KawZPAiB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC3E9C2BCB7;
	Mon, 18 May 2026 23:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779148564;
	bh=aTpXjJOXPjXj2yLBpQmAPp2xAH0F3qCWgIB8ObbK5Ws=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=KawZPAiBjcPmmyYiKqn36nBACV56dhDyGHIbke+eqszgraGRphBrp/L8QgRNlDPar
	 +x+F+7cLNl83tOytHm1aLIPSVv048FETZiVNF/dTOIDPgT45xBbqzn5meitskTVUo5
	 loJK+AM5iSYfA8MtT3a3vpXsPBLNPtS4vJ+Gsvubp6X06dlooyGlf9/Gao2hWnoE85
	 Bx74BiAdFpX8eLN30Z2+GHZVCiRxcUJsJeDOjVBM9/dR1mACeT7gNbw2uU0n5EDKn8
	 4TD2IfN4le3LUMRAD+PTJCpeU4fE+OKxlPUnWaocpEukLinsMQjRXtJRwJZ1eaRlWR
	 V5F8DRKGsvKNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/4] HID: hid-msi: Add RGB control interface
Reply-To: sashiko-reviews@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260518222935.1802071-4-derekjohn.clark@gmail.com>
References: <20260518222935.1802071-4-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 23:56:03 +0000
Message-Id: <20260518235603.DC3E9C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] Use-After-Free and NULL pointer dereference risks during RGB i=
nterface teardown.
- [High] Use-After-Free due to incorrect workqueue cancellation order.
- [Medium] Lifecycle mismatch of sysfs groups causes kernfs warnings on dev=
ice removal.
- [Medium] Gamepad initialization is fully disabled if the RGB configuratio=
n read fails.
--

commit 1d7a0aec4b983c2c64bceb50fe253ae0e8e94c94
Author: Derek J. Clark <derekjohn.clark@gmail.com>
HID: hid-msi: Add RGB control interface

This commit adds an RGB control interface for MSI Claw devices, parsing
profile and effect data to mirror the RGB effects available in Windows.

> diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
> index e58d35dba5b40..4d267b896da72 100644
> --- a/drivers/hid/hid-msi.c
> +++ b/drivers/hid/hid-msi.c

[ ... ]

> @@ -846,16 +1372,44 @@ static void cfg_setup_fn(struct work_struct *work)
>  		return;
>  	}
> =20
> -	/* Add sysfs attributes after we get the device state */
> -	ret =3D devm_device_add_group(&drvdata->hdev->dev, &claw_gamepad_attr_g=
roup);
> +	ret =3D claw_read_rgb_config(drvdata->hdev);
>  	if (ret) {
>  		dev_err(&drvdata->hdev->dev,
> -			"Failed to setup device, can't create gamepad attrs: %d\n", ret);
> +			"Failed to setup device, can't read RGB config: %d\n", ret);
>  		return;
>  	}

If claw_read_rgb_config() fails, it returns early and skips registering the=
=20
gamepad attributes. Should core gamepad functionality (like button mapping)
break if the cosmetic RGB feature fails to initialize?

> -	drvdata->gamepad_registered =3D true;
> +
> +	/* Add sysfs attributes after we get the device state */
> +	if (!drvdata->gamepad_registered) {
> +		ret =3D devm_device_add_group(&drvdata->hdev->dev, &claw_gamepad_attr_=
group);
> +		if (ret) {
> +			dev_err(&drvdata->hdev->dev,
> +				"Failed to setup device, can't create gamepad attrs: %d\n", ret);
> +			return;
> +		}
> +		drvdata->gamepad_registered =3D true;
> +	}
> +
> +	/* Add and enable RGB interface once we have the device state */
> +	if (!drvdata->rgb_registered) {
> +		ret =3D devm_led_classdev_multicolor_register(&drvdata->hdev->dev, &dr=
vdata->led_mc);
> +		if (ret) {
> +			dev_err(&drvdata->hdev->dev,
> +				"Failed to setup device, can't create led device: %d\n", ret);
> +			return;
> +		}
> +
> +		ret =3D devm_device_add_group(drvdata->led_mc.led_cdev.dev, &claw_rgb_=
attr_group);

Will this trigger a kernfs warning on device removal?=20

The LED class device is unregistered via devres first, which calls=20
device_del() and implicitly removes all sysfs entries. This makes the=20
subsequent devres removal of claw_rgb_attr_group fail to find the directory=
,=20
triggering a "can not remove '...', no directory" warning.

Would it be safer to assign this group to drvdata->led_mc.led_cdev.groups
before registration instead of using devm_device_add_group()?

> +		if (ret) {
> +			dev_err(&drvdata->hdev->dev,
> +				"Failed to setup device, can't create led attributes: %d\n", ret);
> +			return;
> +		}
> +		drvdata->rgb_registered =3D true;
> +	}
> =20
>  	kobject_uevent(&drvdata->hdev->dev.kobj, KOBJ_CHANGE);
> +	kobject_uevent(&drvdata->led_mc.led_cdev.dev->kobj, KOBJ_CHANGE);
>  }

[ ... ]

> @@ -979,10 +1553,14 @@ static void claw_remove(struct hid_device *hdev)
>  		return;
>  	}
> =20
> +	/* Block writes to brightness/multi_intensity during teardown */
> +	drvdata->led_mc.led_cdev.brightness_set =3D NULL;

Can this race with __led_set_brightness() in the LED subsystem? If the LED=
=20
core checks the brightness_set pointer and finds it valid, but gets preempt=
ed
while this runs without locking, could it then jump to a NULL pointer?

>  	cancel_delayed_work_sync(&drvdata->cfg_setup);
>  	cancel_delayed_work_sync(&drvdata->cfg_resume);

Since cfg_resume_fn() schedules cfg_setup, is it possible for cfg_setup to=
=20
be re-armed here?=20

If cfg_resume is currently running, cancelling cfg_setup first does nothing=
,=20
and then cfg_resume will queue cfg_setup again before completing. This coul=
d=20
leave cfg_setup pending after the driver data is freed.

> +	cancel_delayed_work_sync(&drvdata->rgb_queue);
> =20
>  	drvdata->gamepad_registered =3D false;
> +	drvdata->rgb_enabled =3D false;
> =20
>  	hid_hw_close(hdev);
>  }

Because drvdata->rgb_registered remains true here, and the RGB sysfs=20
attributes are devres-managed (meaning they persist until after claw_remove
returns), could a concurrent userspace write pass the rgb_registered check=
=20
and call mod_delayed_work()?=20

This would re-arm rgb_queue after it was cancelled, leading to a=20
use-after-free when drvdata is eventually freed. Should=20
drvdata->rgb_registered =3D false be set before cancelling the workqueue?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518222935.1802=
071-1-derekjohn.clark@gmail.com?part=3D3

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F111A2882CD
	for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 01:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785116711; cv=none; b=CRxB8nHMWd0nM8oIFVUbz9o6TvBeMJ+FiFll56+HR8xQfERIKtjJEv8EslW7rO1KKXZ1p5nkc5+nUyeAzjZJvIMdvXeydljVmDoG5YzWB2LPAcT+Yvy9THAzsnuZ8JbtoHjwvwbnlmtvSXVkRpw6wtmXoNoKUol9m4Ys0mB5qFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785116711; c=relaxed/simple;
	bh=o8oChsP4C2YONUy4goKufT8OHJZtI60cXTitKwgTBKw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HdLVvPHpQ1oY5w4f/nhHCFw5aiUiyMThSok1T2lLDJhhqeBpwZfuHYW9oD7NWTcIS08aIqTmkBwQeSzfaF60umPvcB1c+FL4wMh3RxjppjIIhfOeGWDhm/mBVMCF8+Xpy08094+PObqJUkyPUWt3TpyXJdYUFTe6Pfj8hl/ZuAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLlk+GRD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLlk+GRD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9121F00A3A;
	Mon, 27 Jul 2026 01:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785116709;
	bh=+Yv/FYb5pf5GKTLqXblzQqgdVHraWX9dR6SpgyZTs8U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PLlk+GRDwewGi18mATiro7a89+w95R6LlzElftKG//Au+W69xZXNt2LUCNk6SB6XM
	 M0uHcJm1zdNlg86Tsvk4Yf4cT/qAlIUYeKbAFLEGSBk0AmS0zNoiCWUBwg7ZVk8nQ7
	 SwXGe9Xrw1yTu/HUcLxHWDKH8PvrTZCFHuIJuOiaKJ+D7taxevSsdTbrvGq3/SdqY9
	 jUWPsgUU/D8MKVnNnU7/0PMf1vQtTOmSDC4wRcAzz5HJ/WirXauCLQQwP1TAzeT1nO
	 FOh42oObqzfmH0gdxyoGevcFBpHrWAi0yi9c88xKA8lpfSRNjoz0rz5D/pq57Iv8nd
	 JiVoZbsMGYRSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] HID: corsair: cancel worker before unregistering
 LED to fix use-after-free
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chen Changcheng" <chenchangcheng@kylinos.cn>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260727013500.23435-3-chenchangcheng@kylinos.cn>
References: <20260724091906.240588-1-chenchangcheng@kylinos.cn>
 <20260727013500.23435-1-chenchangcheng@kylinos.cn>
 <20260727013500.23435-3-chenchangcheng@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 01:45:09 +0000
Message-Id: <20260727014509.AB9121F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] Reordering `cancel_work_sync()` before `led_classdev_unregiste=
r()` introduces a deterministic Use-After-Free and workqueue corruption, be=
cause unregistering the LED unconditionally schedules new work immediately =
before the work struct is freed.

Pre-existing issues:
- [High] The original race condition causing a use-after-free was not fixed=
 in the initialization error path.
- [Medium] The driver manually registers LED classdevs instead of using the=
 managed `devm_led_classdev_register()` API.
--

--- Patch [2]: [PATCH 2/2] HID: corsair: cancel worker before unregistering=
 LED to fix use-after-free ---
commit 8341efa9384aeb1521083777d15f9e9a3ba4a7fd
Author: Chen Changcheng <chenchangcheng@kylinos.cn>

HID: corsair: cancel worker before unregistering LED to fix use-after-free

This patch swaps the order of cancel_work_sync() and
led_classdev_unregister() in the cleanup paths of the corsair HID driver.
It attempts to fix a race condition where the LED worker accesses device
structures while they are being unregistered.

> diff --git a/drivers/hid/hid-corsair.c b/drivers/hid/hid-corsair.c
> index ac12877a6db7b..278c6efb565df 100644
> --- a/drivers/hid/hid-corsair.c
> +++ b/drivers/hid/hid-corsair.c

[ ... ]

> @@ -524,8 +524,8 @@ static void k90_cleanup_backlight(struct hid_device *=
dev)
> =20
>  	if (drvdata->backlight) {
>  		drvdata->backlight->removed =3D true;
> -		led_classdev_unregister(&drvdata->backlight->cdev);
>  		cancel_work_sync(&drvdata->backlight->work);
> +		led_classdev_unregister(&drvdata->backlight->cdev);

[Severity: Critical]
Does this sequence introduce a use-after-free? When unregistering the LED,
led_classdev_unregister() turns off the LED by default, calling the
brightness_set callback. In this driver, k90_brightness_set() calls
schedule_work().

If led_classdev_unregister() is called after cancel_work_sync(), it will
unconditionally schedule a new work item on the workqueue immediately before
the following kfree() destroys the work structure.

>  		kfree(drvdata->backlight->cdev.name);
>  		kfree(drvdata->backlight);
>  	}
> @@ -540,8 +540,8 @@ static void k90_cleanup_macro_functions(struct hid_de=
vice *dev)
>  		sysfs_remove_group(&dev->dev.kobj, &k90_attr_group);
> =20
>  		k90->record_led.removed =3D true;
> -		led_classdev_unregister(&k90->record_led.cdev);
>  		cancel_work_sync(&k90->record_led.work);
> +		led_classdev_unregister(&k90->record_led.cdev);

[Severity: Critical]
Similarly, does this apply to the macro record LED? Moving the unregister
call after cancel_work_sync() will schedule work right before freeing the
k90 structure in k90_cleanup_macro_functions().

>  		kfree(k90->record_led.cdev.name);
> =20
>  		kfree(k90);

This isn't a bug introduced by this patch, but the error path in
k90_init_macro_functions() was not updated to match the new ordering:

drivers/hid/hid-corsair.c:k90_init_macro_functions() {
    ...
fail_sysfs:
    k90->record_led.removed =3D true;
    led_classdev_unregister(&k90->record_led.cdev);
    cancel_work_sync(&k90->record_led.work);
    ...
}

[Severity: High]
Does this error path retain the original race condition that this patch aims
to fix?

This is a pre-existing issue, but the driver manually registers the LED
class devices in the initialization functions:

drivers/hid/hid-corsair.c:k90_init_backlight() {
    ...
    ret =3D led_classdev_register(&dev->dev, &drvdata->backlight->cdev);
    ...
}

[Severity: Medium]
Could the driver be converted to use the managed devm_led_classdev_register=
()
API to automatically handle lifecycle cleanup and prevent registration leak=
s?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727013500.2343=
5-1-chenchangcheng@kylinos.cn?part=3D2

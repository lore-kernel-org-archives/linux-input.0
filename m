Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CAF4BEE2C
	for <linux-input@vger.kernel.org>; Sat, 12 Sep 2026 03:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789183230; cv=none; b=GEP5vUJDmfNnggklUriVOfvU7f+O3zEz3zaZUqENGtSWdiz+1Xw0QMuRgarKuU0Z0dBaLWt0+m4FuAWVi/o82xY+v05Xqc1Ix3H9PO5ePSj6iMLInuAQfw27oORIkbnceAMrYi4cn/492jt/9go+D2NQ1Jw1p4PnQCk5cFWdUq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789183230; c=relaxed/simple;
	bh=uBdaw3j+9aXs8jp1OqFCbGQprFAV6lVHClG5nkfz8XQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uN8RU5JmYipbkejEC+XUadgoLSMocrdH+i1MtV5UTOpWqCFhYM5YJT+/fcuh2pVE+2gsUioRyKgBGIXYmado+DySMabv2vf8JxfKeMInmfFz9zu9mM9wAIYWTSs01sR9pwiAuDha53n7rrmKAHyflKfsIzAJOtfMNhLFvYaE94o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTlO3Clu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTlO3Clu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8581F000FF;
	Sat, 12 Sep 2026 03:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789183229;
	bh=uAbVKk753gAomFE5yhw5Gt1ugp/GOHSUNfyvzRdD7qI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gTlO3CluouS84hAVFyfnEj7jeM3zr+nJgPb16HyRusu3VsFBDEKve8jp3oKDA0Lko
	 bf5CDKpz2Iqm5kOjwFg7kUs/DFexgxk+1waCkhebyTuUvWSzLIplsw7evPOrmCSJNF
	 UFSKQJgurIB++55/lZH9TZ+cSKFxFCc1SOnJ3FMmifQR8ZJI7LFubKvYZZL/aWX0BO
	 XxDZLDavpR4RRL5zGRdhXgPCCqMbzydC4p5mebY1TCrBJtUTr1Gn1WLvmDtNvohJdv
	 jlxQAa8C0NtLF8R0JD0ab8ov7rylpzmCMzA4FEYGPzx9Elb5gxz30NIV6WdVNcIvot
	 /mOIjxIkbZzWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 03/12] Input: xbox_gip - Add controllable LED support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260912030426.2997003-4-vi@endrift.com>
References: <20260912030426.2997003-1-vi@endrift.com>
 <20260912030426.2997003-4-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 03:20:28 +0000
Message-Id: <20260912032028.CF8581F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] LED class devices remain registered after the driver's private=
 data (`struct gip_attachment`) is freed, leading to a Use-After-Free via s=
ysfs attributes.
- [High] Double registration of the same embedded `led_classdev` during dev=
ice reset causes list corruption.

Pre-existing issues:
- [Critical] This problem wasn't introduced by this patch, but a race condi=
tion in driver teardown leaves a window where `gip_rumble_work` can be sche=
duled and executed after `attachment` is freed, causing a Use-After-Free.
--

commit 2f28cf978dca855a5f6208e26764df2b03de1082
Author: Vicki Pfau <vi@endrift.com>

Input: xbox_gip - Add controllable LED support
   =20
Xbox One controllers have two different types of controllable LED support:
   =20
- Monochrome white, which most controllers have.
- RGBW addressible, which the Elite 2 controllers have.
   =20
This exposes both types as led cdevs.

> diff --git a/drivers/input/joystick/gip/gip-core.c b/drivers/input/joysti=
ck/gip/gip-core.c
> index b67b38c880cd3..9371d860a59b8 100644
> --- a/drivers/input/joystick/gip/gip-core.c
> +++ b/drivers/input/joystick/gip/gip-core.c
[ ... ]
> @@ -1056,9 +1056,120 @@ static int gip_send_guide_button_led(struct gip_a=
ttachment *attachment,
[ ... ]
> +static int gip_guide_led_probe(struct gip_attachment *attachment, struct=
 device *dev)
> +{
[ ... ]
> +		if (!rc)
> +			rc =3D devm_led_classdev_multicolor_register(dev,
> +				mc_cdev);

[Severity: High]
Can this cause a double registration of the same embedded led_classdev
during a device reset?

If the controller unexpectedly resets (e.g., receiving a GIP_CMD_HELLO_DEVI=
CE
message), the driver calls gip_reset_attachment(), which unregisters the
input_dev. It then re-initializes and allocates a new input_dev, calling
gip_guide_led_probe() again.

Because the previous input_dev's devres hasn't executed (if userspace kept =
it
open), the original LED registration is never undone. The driver then calls
devm_led_classdev_multicolor_register() on the exact same statically embedd=
ed
mc_cdev (which is still actively linked in leds_list). Double-registering a
node into a linked list corrupts its pointers.

> +
> +		if (rc)
> +			devm_kfree(dev, mc_led_info);
> +	} else {
> +		struct led_classdev *cdev =3D &attachment->guide_led.standard;
> +
> +		cdev->max_brightness =3D GIP_LED_GUIDE_MAX_BRIGHTNESS;
> +		cdev->brightness =3D GIP_LED_GUIDE_INIT_BRIGHTNESS;
> +		cdev->flags =3D LED_CORE_SUSPENDRESUME | LED_RETAIN_AT_SHUTDOWN;
> +		cdev->brightness_set_blocking =3D gip_guide_led_set;
> +		cdev->name =3D devm_kasprintf(dev, GFP_KERNEL,
> +			"%s:white:power", dev_name(dev));
> +		if (!cdev->name)
> +			return -ENOMEM;
> +
> +		rc =3D devm_led_classdev_register(dev, cdev);

[Severity: High]
Similarly, does registering the standard embedded cdev here expose it to
the same double-registration vulnerability during a device reset?

> +
> +		if (rc)
> +			devm_kfree(dev, cdev->name);
> +	}
> +
> +	return rc;
> +}
[ ... ]
> @@ -1169,6 +1280,10 @@ static int gip_setup_input_device(struct gip_attac=
hment *attachment)
>  	if (rc)
>  		goto err_free_device;
> =20
> +	rc =3D gip_guide_led_probe(attachment, &input->dev);

[Severity: Critical]
Can tying the devres lifecycle of the LED to &input->dev lead to a
use-after-free?

During a physical disconnect, gip_disconnect() explicitly frees the
attachment structure. However, if userspace holds an open file descriptor
on the input device (e.g., via evdev), the input_dev reference count
remains positive, delaying its devres execution.

This leaves the embedded led_classdev registered and pointing to freed
memory. A subsequent write to the LED's sysfs attribute calls
gip_guide_led_set(), which dereferences the freed attachment structure.

[Severity: Critical]
This is a pre-existing issue, but does a race condition in driver teardown
leave a window where gip_rumble_work can be scheduled and executed after
attachment is freed, causing a use-after-free?

In gip_shutdown(), work is canceled synchronously:

    cancel_work_sync(&attachment->rumble_work);

However, while the input_dev is still registered, a concurrent thread in
userspace can invoke the EVIOCSFF ioctl, calling gip_play_effect() to
re-schedule the work.

Later in the teardown, gip_reset_attachment() uses the non-blocking
cancel_work():

    cancel_work(&attachment->rumble_work);

If the worker thread has already started executing, cancel_work() does not
wait for it. The worker blocks on guard(mutex)(&attachment->lock) held by
gip_shutdown(). gip_shutdown() then unregisters the input device and
returns. gip_disconnect() then immediately frees the attachment structure.
Finally, the worker thread unblocks, acquiring the lock and accessing the
freed attachment.

> +	if (rc)
> +		gip_err(attachment, "Failed to register LEDs: %d\n", rc);
> +
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912030426.2997=
003-1-vi@endrift.com?part=3D3

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCB7384245
	for <linux-input@vger.kernel.org>; Sat,  6 Jun 2026 12:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780747919; cv=none; b=BDAcnZLgqdUlzTp07wj8UhjNi+LO+F3SAf+OlnAhyorynrk+NMujyJu1r6ezAtdQ+GYrAw8yZpebPdGLvBH+Rmk93THTNYvl6HsSI+/PGn6ASVHL+cDmkW5GSfNwbIlIHtSk/6nzjYJxv2Tfe5nvdfxCgOnoldTTss6AWtrTEWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780747919; c=relaxed/simple;
	bh=HYsgU/jMVv4omdfFysOPUrYlO7KenVvgbreT8U2YLsY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OMyRclWIgAKYLezTdfeZ2YateiI/xY37MeIFDkwgOZPb/08OFSY75wot+f+n6BnIkENvxGvu4vRV5QwdRS7/td1iaFZ1zCs4WBxLoUkXLCUjQysBlDp7sXst/LLXLW18YbB7h20+GLglp7e/lXUZjL7ve+DT9Ibb++yt9uurARU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/YJR7i7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/YJR7i7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A2841F00893;
	Sat,  6 Jun 2026 12:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780747917;
	bh=UGa+vbmQ9AVVJt4Yx1DLkTNO8uOhyeWM+ONrjy0XLH0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G/YJR7i7RDkr0I2aL+oso0adhvs9hBEd4bF0H6WBtI2ztaO9H/gj3ETAYzIbKdvwZ
	 ap6tRD/4nv9ONaLGCaPuP1ALxabHCM98oB6U0tF6DVVoBImqVQUTEd43ovFmMdDbfd
	 iamvmxcsRLGA7whaJ603DKu3n/DUevagTsOh9gAVCtt02EJ8mXaYI4l9hSnxBajwa0
	 T2Q0bxHPuv2YeofLA3OaIYtDBjhuTKctP4pQG8BvrMJEqlqPsLDQwo9B6uocGH0fzs
	 t1Er3CYlYvdf6VxnFnlPf5kgNmQoS1rFf4ZKQoEybGpPCtnyPiVKJ4N4FuTG4cF7tB
	 cCp0gBazsIn+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/9] iio: orientation: hid-sensor-rotation: Fix race
 between callback registration and device exposure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Chitroda" <sanjayembeddedse@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260606-5-june-hid-iio-race-fixes-v1-1-27a848c5758f@gmail.com>
References: <20260606-5-june-hid-iio-race-fixes-v1-1-27a848c5758f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 12:11:56 +0000
Message-Id: <20260606121157.5A2841F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Newly introduced Use-After-Free in the probe error path caused by =
registering the callback before IIO device registration.
- [High] Newly introduced data race leading to list corruption in the remov=
e path by unregistering the IIO device while the sensor hub callback is sti=
ll active.

Pre-existing issues:
- [High] Pre-existing Use-After-Free due to a lack of synchronization in se=
nsor hub callback removal.
- [High] Pre-existing Out-of-Bounds Read in dev_rot_capture_sample when rea=
ding malicious HID reports.
--

commit 53e3688342562957aa2297744b7cc0b03bf921af
Author: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Subject: iio: orientation: hid-sensor-rotation: Fix race between callback r=
egistration and device exposure

The driver registers the IIO device before completing sensor hub callback
registration and unregisters callbacks while the IIO device is still exposed
during teardown. This creates race windows in both probe and remove paths.
This patch attempts to fix this by correct ordering of callback registratio=
n.

Fixes: fc18dddc0625 ("iio: hid-sensors: Added device rotation support")

> diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/=
orientation/hid-sensor-rotation.c
> index 4a11e45550991..fd9beb93cefb1 100644
> --- a/drivers/iio/orientation/hid-sensor-rotation.c
> +++ b/drivers/iio/orientation/hid-sensor-rotation.c
> @@ -332,12 +332,6 @@ static int hid_dev_rot_probe(struct platform_device =
*pdev)
>  		return ret;
>  	}
> =20
> -	ret =3D iio_device_register(indio_dev);
> -	if (ret) {
> -		dev_err(&pdev->dev, "device register failed\n");
> -		goto error_remove_trigger;
> -	}
> -
>  	rot_state->callbacks.send_event =3D dev_rot_proc_event;
>  	rot_state->callbacks.capture_sample =3D dev_rot_capture_sample;

[Severity: High]
This is a pre-existing issue, but can dev_rot_capture_sample() read
out-of-bounds when handling malicious HID reports?

If raw_len does not correspond to an array of four 16-bit integers, the
function unconditionally copies 16 bytes:

drivers/iio/orientation/hid-sensor-rotation.c:dev_rot_capture_sample() {
    ...
    } else {
        memcpy(&rot_state->scan.sampled_vals, raw_data,
               sizeof(rot_state->scan.sampled_vals));
    }
    ...
}

If a malicious USB device provides a report descriptor with a field size
smaller than 16 bytes, will this memcpy() read out-of-bounds without verify=
ing
that raw_len is at least 16?

>  	rot_state->callbacks.pdev =3D pdev;
> @@ -345,13 +339,19 @@ static int hid_dev_rot_probe(struct platform_device=
 *pdev)
>  					&rot_state->callbacks);
>  	if (ret) {
>  		dev_err(&pdev->dev, "callback reg failed\n");
> -		goto error_iio_unreg;
> +		goto error_remove_trigger;
> +	}
> +
> +	ret =3D iio_device_register(indio_dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "device register failed\n");
> +		goto error_remove_callback;
>  	}

[Severity: High]
Is there a use-after-free introduced in this new error path?

By registering the callback before the IIO device, if iio_device_register()
fails, the error path removes the callback and returns, triggering devres
cleanup.

Because sensor_hub_remove_callback() lacks execution synchronization, an ev=
ent
dispatched immediately after callback registration can run concurrently. Wh=
en
hid_dev_rot_probe() returns, the rot_state memory is freed while the event
handler is still executing.

[ ... ]

> @@ -364,8 +364,8 @@ static void hid_dev_rot_remove(struct platform_device=
 *pdev)
>  	struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
>  	struct dev_rot_state *rot_state =3D iio_priv(indio_dev);

[Severity: High]
This isn't a bug introduced by this patch, but does hid_dev_rot_remove()
complete teardown without synchronization, allowing devres to free memory
while callbacks are still executing?

When sensor_hub_remove_callback() removes the callback entry from the list:

drivers/hid/hid-sensor-hub.c:sensor_hub_remove_callback() {
    ...
    list_del(&callback->list);
    kfree(callback);
    ...
}

It does not wait for any currently executing callback, such as
dev_rot_proc_event(), to finish. When hid_dev_rot_remove() returns, devres
automatically frees indio_dev and rot_state.

If dev_rot_proc_event() is running concurrently on another CPU:

drivers/iio/orientation/hid-sensor-rotation.c:dev_rot_proc_event() {
    ...
    struct iio_dev *indio_dev =3D platform_get_drvdata(priv);
    struct dev_rot_state *rot_state =3D iio_priv(indio_dev);
    ...
}

Could it dereference the freed indio_dev pointer?

> =20
> -	sensor_hub_remove_callback(hsdev, hsdev->usage);
>  	iio_device_unregister(indio_dev);
> +	sensor_hub_remove_callback(hsdev, hsdev->usage);

[Severity: High]
Will moving sensor_hub_remove_callback() after iio_device_unregister()
dismantle the buffer list concurrently with active events?

Leaving the callback active during teardown means an incoming sensor event =
can
trigger dev_rot_proc_event(), which calls iio_push_to_buffers() while
iio_device_unregister() is disabling buffers.

If iio_push_to_buffers() locklessly iterates over the buffer list:

drivers/iio/industrialio-buffer.c:iio_push_to_buffers() {
    ...
    list_for_each_entry(buf, &iio_dev_opaque->buffer_list, buffer_list) {
    ...
}

And iio_device_unregister() concurrently uses list_del_init() to remove
buffers from the list, might this cause list corruption?

>  	hid_sensor_remove_trigger(indio_dev, &rot_state->common_attributes);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260606-5-june-hid=
-iio-race-fixes-v1-0-27a848c5758f@gmail.com?part=3D1

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE961241C8C
	for <linux-input@vger.kernel.org>; Mon, 22 Jun 2026 05:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782107086; cv=none; b=ACbTFrFz0/9roc4yRdOOojNzvZ5R+Wi0R3n5D5BHjedAj3ti+QRfGW6C5mP/IB4zQgb0Pv0H7YjXgpZCYpR5rCCdZ/n2luJ+kJy803lpJJZIg0PJRE9epWLpejNrDW7M4LFLXwKE+qgcS/oHwC4czinkzD/LgJOrqGos7sRWVRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782107086; c=relaxed/simple;
	bh=vPBabHDKqgw3MLLlXyWbUtYsWmbPm7NXmRvpw38QrmE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bxGu6sZoN5GM/xkqxa26QdqnKEeZFuQ7hnepWyuNaB8hbFup5ybZ4UH86FQJMNGzIraEXizQL7lCeHrZbF10ASfhKaHJS+7QSUiWACP07V5IcGpeKgBF4MAeoNjkt/rMraQ7tVO1+Ikq5A61weEsLZv90yNJgKCjAC1GzqKEUGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSIZmtoo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSIZmtoo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F4F1F000E9;
	Mon, 22 Jun 2026 05:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782107085;
	bh=jvWDlBmX9ckUCQDnIxXOKYx658hTa51nDSV1HoWLIRQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gSIZmtooynVEnoDkwa0aoLIPWBlG+gs8w4DM8b6Q5A0d6v47GUWkYg6XFrMe1FcNk
	 XVvaZkkTf4LTXNr+BufsdYN+77Gp2Zwq7G5TAAzq5269I4L66P1QEJOsOKVH+rYKef
	 FS1Gi+kk2q9XXKDLf6MZitDV2GAnWa4RbuONzeGwPXn27ab5dslGNI17NJpiV0O0oL
	 8As5wApGC47ugfQvEIMzILAhAPZugmlKZRmxHK+GEPQua2qFKQrVz/fnJKgAZi6hYF
	 vbyJnf51r+XbM0nTlIGh5nO9QB778ngxnoDjQJW15UAqD0j1JSA5OVLlZRBimIvtGF
	 Dp94w11FXA/ew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/8] iio: pressure: hid-sensor-press: Avoid race
 between callback setup and device exposure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Chitroda" <sanjayembeddedse@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260622-5-june-hid-iio-race-fixes-v2-4-1cfabcd1881e@gmail.com>
References: <20260622-5-june-hid-iio-race-fixes-v2-0-1cfabcd1881e@gmail.com>
 <20260622-5-june-hid-iio-race-fixes-v2-4-1cfabcd1881e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 05:44:44 +0000
Message-Id: <20260622054445.44F4F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Reordering `iio_device_unregister()` before `sensor_hub_remove_cal=
lback()` introduces a race condition leading to list corruption or Use-Afte=
r-Free.

Pre-existing issues:
- [High] Lack of synchronization in `sensor_hub_remove_callback()` allows c=
oncurrent events to cause a Use-After-Free in the probe error path and devi=
ce removal.
- [High] Unaligned and out-of-bounds memory access in `press_capture_sample=
()`.
--

commit 9b0142efc7c55a69dc83b67a2c132e1f174fd7cc
Author: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Subject: iio: pressure: hid-sensor-press: Avoid race between callback setup=
 and device exposure

This patch reorders the probe and remove paths in the hid-sensor-press
driver. It registers the sensor hub callbacks before exposing the IIO
device to userspace, and in reverse during teardown, intending to fix
timing windows where buffers might be accessed before callbacks are ready.

> diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressu=
re/hid-sensor-press.c
> index 3e47a10d72a89..8f81a6d65b9f7 100644
> --- a/drivers/iio/pressure/hid-sensor-press.c
> +++ b/drivers/iio/pressure/hid-sensor-press.c

[ ... ]

> @@ -304,13 +298,19 @@ static int hid_press_probe(struct platform_device *=
pdev)
>  					&press_state->callbacks);
>  	if (ret < 0) {
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
> =20
>  	return ret;
> =20
> -error_iio_unreg:
> -	iio_device_unregister(indio_dev);
> +error_remove_callback:
> +	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_PRESSURE);

[Severity: High]
This is a pre-existing issue, but does sensor_hub_remove_callback() wait
for any executing callbacks to complete?

If iio_device_register() fails, the new error path calls
sensor_hub_remove_callback(). If a callback like press_proc_event() is
already running concurrently, it appears the memory for press_state will be
freed by devres while the callback is still dereferencing it, potentially
leading to a use-after-free.

>  error_remove_trigger:
>  	hid_sensor_remove_trigger(indio_dev, &press_state->common_attributes);
>  	return ret;
> @@ -323,8 +323,8 @@ static void hid_press_remove(struct platform_device *=
pdev)
>  	struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
>  	struct press_state *press_state =3D iio_priv(indio_dev);
> =20
> -	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_PRESSURE);
>  	iio_device_unregister(indio_dev);
> +	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_PRESSURE);

[Severity: High]
Does unregistering the IIO device before removing the sensor hub callback
introduce a regression during teardown?

By explicitly reversing the teardown order, iio_device_unregister() will
dismantle the IIO buffers via iio_disable_all_buffers(). If a hardware
event arrives concurrently, the still-active press_proc_event() callback can
call iio_push_to_buffers_with_ts() and attempt to push data to buffers being
locklessly destroyed, which could lead to list corruption or a
use-after-free.

>  	hid_sensor_remove_trigger(indio_dev, &press_state->common_attributes);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but is press_capture_sample()
safely handling the raw_data buffer?

Looking at the callback handling in press_capture_sample():

drivers/iio/pressure/hid-sensor-press.c:press_capture_sample() {
	...
	switch (usage_id) {
	case HID_USAGE_SENSOR_ATMOSPHERIC_PRESSURE:
		press_state->scan.press_data =3D *(u32 *)raw_data;
        ...
}

The pointer raw_data is directly cast to u32 * and dereferenced without
verifying raw_len or checking for proper alignment.

Could a maliciously crafted HID descriptor with a shorter report length
cause an out-of-bounds read that leaks heap memory to userspace, or trigger
unaligned access faults on architectures that strictly require alignment?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622-5-june-hid=
-iio-race-fixes-v2-0-1cfabcd1881e@gmail.com?part=3D4

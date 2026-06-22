Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4365C3537F7
	for <linux-input@vger.kernel.org>; Mon, 22 Jun 2026 05:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782107107; cv=none; b=uoXGbmCZe9x3+LigrpiMaeIKaOlV01jQo9BvWWX9Ot+Rb4Zm73qfQTg/83VTe9TuMhgWYqYMk72ZSRHiq7myuvfvBAMLCcqZ9PxrpatlLUZboiWVJ/RPPmQGZQFMw1GrEyuX5JJ4MW4SkQYbdP8YjUcOhOEP8E+YV+Y2d9QkOpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782107107; c=relaxed/simple;
	bh=lm8RexbV3SmBAKbeEzvBaymQRTh6iqiFuPydJ9DR19M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=asvXGSGZgboqtSGUdaTuw1xPSlRigNWi9JXoKbxgFTC8I4k78D4KvwofEelWy8BYW83VMrK7yvaw0GUvYy9+MwhtmQOHjlRO9XpPoyqqtEjqi4i9KcJdP1ZUrnQpa6jqNjTkEibU6dhWbu1OIVz9geaVRgOie5fA/6izJG2bcPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o3kROcte; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3kROcte"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A991F000E9;
	Mon, 22 Jun 2026 05:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782107106;
	bh=9h0JIk72p4ywz6aEQaRIin1B1UhYl3/M88UQGq7qQMY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=o3kROcte+oMSKfSio9aGYVnanWfOgTtSA9MT5A60GLiHfqje3Le68ePqqOb4WC5iZ
	 E2+hb8/wWWxh8G8bUCwcCHMdK7DfE4Csq2Iu+h1c+y1+FcNrYOYIXno/7+WvjAVskT
	 t15ietLbQYLv+Zd/LYAOaM/lYiDB8Vp84M11l69MM1QRC+EC8gHrCQ3BfqRQWQa7jY
	 iy8zgS+IhLAy+kan32JABu+fFCpspS7emfmQni0xG5hTgK49DKAuRbMqGiWF2l4H6w
	 K8oRqjr0Rd065cQ/QqVG2CNu7Zwjfo6AdFGiBSw3ok4/uVhk164gyRgXhRg7ZIz75R
	 sNTeBPbUCWADw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/8] iio: gyro: hid-sensor-gyro-3d: Avoid race
 between callback setup and device exposure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Chitroda" <sanjayembeddedse@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260622-5-june-hid-iio-race-fixes-v2-3-1cfabcd1881e@gmail.com>
References: <20260622-5-june-hid-iio-race-fixes-v2-0-1cfabcd1881e@gmail.com>
 <20260622-5-june-hid-iio-race-fixes-v2-3-1cfabcd1881e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 05:45:05 +0000
Message-Id: <20260622054506.01A991F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] Reordering `iio_device_unregister()` to execute before `sensor=
_hub_remove_callback()` introduces a critical race condition leading to lis=
t corruption or an infinite loop.
- [High] The patch introduces a use-after-free vulnerability on the probe e=
rror path if `iio_device_register()` fails.

Pre-existing issues:
- [Critical] A preexisting architectural flaw in the `hid-sensor-hub` frame=
work allows a use-after-free if a raw event is processed during driver remo=
val.
--

commit 081315902ee73f264b09ca59da9c7688bdfeefd0
Author: Sanjay Chitroda <sanjayembeddedse@gmail.com>

iio: gyro: hid-sensor-gyro-3d: Avoid race between callback setup and device=
 exposure

The driver currently exposes the IIO device to userspace before
completing sensor hub callback registration, and similarly removes
callbacks while the device can still be accessed during teardown.

> diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid=
-sensor-gyro-3d.c
> index bbca2111e79bb..c8130b488f103 100644
> --- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> +++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c

[ ... ]

> @@ -337,13 +331,19 @@ static int hid_gyro_3d_probe(struct platform_device=
 *pdev)
>  					&gyro_state->callbacks);
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
> +	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_GYRO_3D);

[Severity: High]
Does this error path introduce a use-after-free vulnerability?

By moving sensor_hub_register_callback() to execute before
iio_device_register(), if device registration fails, the new error path
removes the callback and returns.

However, sensor_hub_remove_callback() does not wait for concurrently
executing callbacks to finish. If an incoming hardware event triggers
gyro_3d_proc_event() on another CPU right after registration, and then
probe returns, devres will automatically free indio_dev (which contains
gyro_state). The still-executing callback would then dereference the freed
memory.

Could this be prevented by ensuring the callback is only registered when it
is safe to process events?

[Severity: Critical]
This isn't a bug introduced by this patch, but there is a pre-existing
architectural flaw in the hid-sensor-hub framework that exacerbates this
teardown race.

Looking at sensor_hub_remove_callback(), it removes a sensor's callback from
dyn_callback_list under a lock, then immediately returns without waiting for
sensor_hub_raw_event() handlers executing on other CPUs to complete.

Because sensor_hub_raw_event() temporarily drops the list lock and invokes =
the
driver's function pointers based on a cached pointer, if driver removal or
probe failure completes while this is executing, devres frees the driver
memory. The framework then continues to dereference the cached callback
pointer into freed memory.

Would it be possible to add proper synchronization, such as a completion or
RCU sync, in the sensor_hub_remove_callback() framework to prevent this?

> @@ -356,8 +356,8 @@ static void hid_gyro_3d_remove(struct platform_device=
 *pdev)
>  	struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
>  	struct gyro_3d_state *gyro_state =3D iio_priv(indio_dev);
> =20
> -	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_GYRO_3D);
>  	iio_device_unregister(indio_dev);
> +	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_GYRO_3D);

[Severity: Critical]
Does reordering these functions introduce a race condition that leads to li=
st
corruption or an infinite loop?

iio_device_unregister() disables IIO buffers and dismantles the buffer list
locklessly using list_del_init(). If we call iio_device_unregister() while
the sensor hub callback is still active, incoming hardware events can still
trigger gyro_3d_proc_event().

gyro_3d_proc_event() calls iio_push_to_buffers_with_timestamp(), which
iterates over the buffer list locklessly:

gyro_3d_proc_event()
   iio_push_to_buffers_with_timestamp()
      list_for_each_entry()

Because list_del_init() points the next pointer to itself, traversing the l=
ist
concurrently while it is being dismantled could cause the loop to never
terminate, resulting in a hard CPU hang.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622-5-june-hid=
-iio-race-fixes-v2-0-1cfabcd1881e@gmail.com?part=3D3

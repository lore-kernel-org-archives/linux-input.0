Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E2D23370F
	for <linux-input@vger.kernel.org>; Mon, 22 Jun 2026 05:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782107189; cv=none; b=XIzrBz8kkCcewUwye+mV1GW8CUFfbXnDeItiyDhGoHslsU4OhG37GlU8Hkxplbo/wcXfxTqrhFjMCNIdCsCUh8ruIXKFDc/wf7IctlJdw5u0RX6Q7aNeYGPLAhPWCM1hCoO0xJyhZKSBRIUX1CDbnF5tSCecMk0kXSABSDQq2JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782107189; c=relaxed/simple;
	bh=z20d/1LSnTs4qoaCZwF8O60pVzfXFH6bZwTKaOIex3I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c2dqZ2fj7ushm+BY9wp2Y5UTKOp3KDr7HenucEitsvP+q6Y9394bX5I13lmjBZjom5aPqFEgDjcjQ6PRgMmtswEBVtAEn230LII7yOfLRtD8mNGTpYENT7vpFiZX5SNY0kA8uqpNqjTZ4hbHeXIsTb+71sP8rmoVxGXg3IuWf6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPswr+nn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPswr+nn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C091F000E9;
	Mon, 22 Jun 2026 05:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782107188;
	bh=DPB0/nrAdQCn6qhe5dvnj2ZsRDisXqmmYrVDpuu0iZg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FPswr+nnCUSBPO+fFgMz0Y9BfNk89ra3LYlDt6wXOiwBmXdvbM3jB9vqw3e5ACIoR
	 chL99NQ040vPbWwuSJ5enzOlXHLBwCzxMqJvIWSAZsL8/gEs7fhQ2kgpledhLXItkH
	 GG+Yy2rBPTCQX/v/OofCz/6AaZG+J+2rPjSSzujofIl5V45ytebJsE4WV8HS8x2Rz+
	 AxUj+j+xTttBbr2t7QDX6lvZRUnKFMBSMtVWCdAym64YRLcU/NX2rW/Kaf2q7Uir8n
	 Xa/uNGfKlkdSpzGmHmSywkE+vk7kDuw2Thin4X6Edjbw7hkZedKvn9inDSaQgb/Abq
	 1WlvSBsZYwFkg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/8] iio: orientation: hid-sensor-incl-3d: Avoid race
 between callback setup and device exposure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Chitroda" <sanjayembeddedse@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260622-5-june-hid-iio-race-fixes-v2-2-1cfabcd1881e@gmail.com>
References: <20260622-5-june-hid-iio-race-fixes-v2-0-1cfabcd1881e@gmail.com>
 <20260622-5-june-hid-iio-race-fixes-v2-2-1cfabcd1881e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 05:46:28 +0000
Message-Id: <20260622054628.71C091F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Reordering `iio_device_unregister()` before `sensor_hub_remove_cal=
lback()` introduces a race condition leading to list corruption and use-aft=
er-free.

Pre-existing issues:
- [High] `sensor_hub_remove_callback()` does not wait for concurrently exec=
uting callbacks to finish, leading to Use-After-Free.
- [High] Out-Of-Bounds read in `incl_3d_capture_sample` due to lack of `raw=
_len` bounds checking.
--

commit 4947d2a547210c33e3a2154a81959edb205f29de
Author: Sanjay Chitroda <sanjayembeddedse@gmail.com>

iio: orientation: hid-sensor-incl-3d: Avoid race between callback setup and=
 device exposure

This commit reorders the probe and remove paths for the incl-3d sensor driv=
er.
It aims to ensure callbacks are registered before device registration and
removed after device unregistration, closing a timing window where userspace
might enable the buffer before callbacks are available.

> diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c b/drivers/iio/o=
rientation/hid-sensor-incl-3d.c
> index c7fbff498be7a..5696e4ef36334 100644
> --- a/drivers/iio/orientation/hid-sensor-incl-3d.c
> +++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
[ ... ]
> @@ -370,13 +364,19 @@ static int hid_incl_3d_probe(struct platform_device=
 *pdev)
>  					&incl_state->callbacks);
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
> =20
>  	return 0;
> =20
> -error_iio_unreg:
> -	iio_device_unregister(indio_dev);
> +error_remove_callback:
> +	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_INCLINOMETER_3D);

[Severity: High]
This is a pre-existing issue, but does sensor_hub_remove_callback() wait for
currently executing callbacks to finish?

When sensor_hub_remove_callback() is called here or during device removal, =
it
removes the callback from the internal list under a spinlock but doesn't
appear to synchronize with event handlers executing on another CPU.

Since the devres subsystem subsequently frees the memory containing incl_st=
ate,
could a concurrently executing callback dereference the freed memory, leadi=
ng
to a use-after-free?

>  error_remove_trigger:
>  	hid_sensor_remove_trigger(indio_dev, &incl_state->common_attributes);
>  	return ret;
> @@ -389,8 +389,8 @@ static void hid_incl_3d_remove(struct platform_device=
 *pdev)
>  	struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
>  	struct incl_3d_state *incl_state =3D iio_priv(indio_dev);
> =20
> -	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_INCLINOMETER_3D);
>  	iio_device_unregister(indio_dev);
> +	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_INCLINOMETER_3D);

[Severity: High]
Does this reordering introduce a race condition leading to list corruption
and a use-after-free?

If iio_device_unregister() executes while the HID sensor callback is still
actively registered, iio_disable_all_buffers() will locklessly clear the
buffer_list using list_del_init().

Because the hardware is not synchronously powered down, incoming events can
continue to trigger incl_3d_proc_event(), which calls
iio_push_to_buffers_with_timestamp().

Since iio_push_to_buffers_with_timestamp() uses a lockless
list_for_each_entry loop to traverse the same buffer_list:

drivers/iio/industrialio-buffer.c:iio_push_to_buffers() {
    ...
    list_for_each_entry(buf, &iio_dev_opaque->buffer_list, buffer_list) {
    ...
}

won't modifying this list concurrently cause list corruption or a panic?

>  	hid_sensor_remove_trigger(indio_dev, &incl_state->common_attributes);
>  }

[Severity: High]
This is a pre-existing issue, but does incl_3d_capture_sample() check the
raw_len bounds before dereferencing raw_data?

drivers/iio/orientation/hid-sensor-incl-3d.c:incl_3d_capture_sample() {
    ...
    incl_state->scan.incl_val[CHANNEL_SCAN_INDEX_X] =3D *(u32 *)raw_data;
    ...
}

If a malicious USB HID device or a userspace program using uhid advertises a
custom HID descriptor with a field size of 1 byte, could dereferencing
raw_data as a 32-bit or 64-bit integer read past the end of the field and
leak kernel heap memory into the IIO buffer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622-5-june-hid=
-iio-race-fixes-v2-0-1cfabcd1881e@gmail.com?part=3D2

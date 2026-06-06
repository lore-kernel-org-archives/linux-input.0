Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D2436D9FE
	for <linux-input@vger.kernel.org>; Sat,  6 Jun 2026 12:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780747879; cv=none; b=mHTlUT+RVdE+5HS8O1KJnh2RdAGVigs+24OKfNc6m4f4yJPLu59yYErZ0628ly49vVm9crFzR2mikr8LY6XiyP9InZMYIYp1BT4ef7CMq0vU6GsUDnv1EtxmiXS6a8TsrK/Ld1Rl0l2lVxc2v8etrZE2prcQl/DYRQbTRHujRUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780747879; c=relaxed/simple;
	bh=uyPDzHLOxSF+7mYGxOtMtX7KGUqSbjV2eeO7lsrAohU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Do68Q7bSi3s1COk3AuP18IVIHyDSP7FVzBrG7M8uqI9KktKXM/CRYT+m7wIV2fLEIkXxkRvDerigd0zUODgzrnmezbTZSJyE8nqoAAft6FZVTSiStM78GMUP+oK/YY9FC5FpbbDOI6zeVmVWJs3wyg/hr5HPmg9IEpM91AJDwLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gf+TLr1D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gf+TLr1D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0AD21F00893;
	Sat,  6 Jun 2026 12:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780747876;
	bh=UtQF/Hf5VgkBrvBjQlpzXFhoKT/xLwM1uROCaJqhv+g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gf+TLr1DHLHTc+gvDdbEqWcy573WxGOAazFPSy6kuYASHF838n1ZfM2m+U8NppATu
	 /6a+dN3JNoOnAChDo2T1TjfA5sla2TyybR8ZR06V1DeJwJdNLZOsgBJL3VASJYToak
	 5EtJzVvqlutyVigcvGeTFpO7dOzZ9utpvvdRoM6W8o5p945Swh4/b+iH0Jlhov5XMf
	 wk4Ki8Upk8WfjSFeybLgXALHA4x5v5MMYrBOr3YP0VgW4LKhSKLzbuNH2qrFutug8y
	 vfP7X/WckOYQrI4YP3yOCO3UvNnJG13bwNDysgLzkxj4PGFe1uZe1GMHIYGjsb9C9v
	 wWqOs6VMCSvfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/9] iio: light: hid-sensor-als: Fix race between
 callback registration and device exposure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Chitroda" <sanjayembeddedse@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260606-5-june-hid-iio-race-fixes-v1-7-27a848c5758f@gmail.com>
References: <20260606-5-june-hid-iio-race-fixes-v1-7-27a848c5758f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 12:11:15 +0000
Message-Id: <20260606121115.F0AD21F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] Reversing the teardown order in `hid_als_remove()` leaves the =
data producer active during IIO device unregistration, leading to buffer li=
st corruption and a kernel panic.
- [High] Registering the HID sensor hub callback before `iio_device_registe=
r()` introduces a Use-After-Free vulnerability on the probe error path.

Pre-existing issues:
- [High] `sensor_hub_remove_callback()` does not wait for executing callbac=
ks to finish, causing a Use-After-Free when the driver unbinds.
--

commit 7a8f6d5a76d506427e21235e877b3b2cd1616826
Author: Sanjay Chitroda <sanjayembeddedse@gmail.com>

iio: light: hid-sensor-als: Fix race between callback registration and devi=
ce exposure

This commit modifies the initialization and teardown sequences in the
hid-sensor-als driver. It registers the sensor hub callback before exposing
the IIO device in the probe path, and reverses the order in the remove
path.

> diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-s=
ensor-als.c
> index d72e260b82668..93d6038486908 100644
> --- a/drivers/iio/light/hid-sensor-als.c
> +++ b/drivers/iio/light/hid-sensor-als.c
> @@ -406,25 +406,25 @@ static int hid_als_probe(struct platform_device *pd=
ev)
>  		return ret;
>  	}
> =20
> -	ret =3D iio_device_register(indio_dev);
> -	if (ret) {
> -		dev_err(&pdev->dev, "device register failed\n");
> -		goto error_remove_trigger;
> -	}
> -
>  	als_state->callbacks.send_event =3D als_proc_event;
>  	als_state->callbacks.capture_sample =3D als_capture_sample;
>  	als_state->callbacks.pdev =3D pdev;
>  	ret =3D sensor_hub_register_callback(hsdev, hsdev->usage, &als_state->c=
allbacks);
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

[Severity: High]
Does registering the HID sensor hub callback before iio_device_register()
introduce a use-after-free vulnerability on the probe error path?

If iio_device_register() fails, the error path calls
sensor_hub_remove_callback() and the probe function returns, triggering
devres to free the allocated indio_dev and als_state memory.

However, sensor_hub_remove_callback() only unlinks the callback from the
list; it does not synchronize or wait for concurrently executing events.
If an event arrived from the hardware between registration and failure,
als_capture_sample() could be executing on another CPU.

That function will continue to run and write to the devres-managed memory
after it has been freed:

drivers/iio/light/hid-sensor-als.c:als_capture_sample() {
    ...
	struct iio_dev *indio_dev =3D platform_get_drvdata(priv);
	struct als_state *als_state =3D iio_priv(indio_dev);

	switch (usage_id) {
	case HID_USAGE_SENSOR_LIGHT_ILLUM:
		als_state->scan.illum[CHANNEL_SCAN_INDEX_ILLUM] =3D sample_data;
    ...
}

>  	}
> =20
>  	return ret;
> =20
> -error_iio_unreg:
> -	iio_device_unregister(indio_dev);
> +error_remove_callback:
> +	sensor_hub_remove_callback(hsdev, hsdev->usage);
>  error_remove_trigger:
>  	hid_sensor_remove_trigger(indio_dev, &als_state->common_attributes);
>  	return ret;
> @@ -437,8 +437,8 @@ static void hid_als_remove(struct platform_device *pd=
ev)
>  	struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
>  	struct als_state *als_state =3D iio_priv(indio_dev);
> =20
> -	sensor_hub_remove_callback(hsdev, hsdev->usage);
>  	iio_device_unregister(indio_dev);
> +	sensor_hub_remove_callback(hsdev, hsdev->usage);

[Severity: Critical]
Does reversing the teardown order here leave the data producer active
during IIO device unregistration?

iio_device_unregister() cleans up buffers by calling
iio_disable_all_buffers(), which unlinks buffers from
indio_dev->buffer_list using list_del_init():

drivers/iio/industrialio-buffer.c:iio_buffer_deactivate() {
    ...
	list_del_init(&buffer->buffer_list);
    ...
}

Because the HID event callback remains registered and active, incoming
sensor events can concurrently trigger iio_push_to_buffers_with_ts(). This
function locklessly iterates over buffer_list:

drivers/iio/industrialio-buffer.c:iio_push_to_buffers() {
    ...
	list_for_each_entry(buf, &iio_dev_opaque->buffer_list, buffer_list) {
		ret =3D iio_push_to_buffer(buf, data);
    ...
}

Concurrently traversing a linked list while it is being actively dismantled
via list_del_init() without synchronization causes the reader to follow
self-referential pointers, which can result in an infinite loop, soft
lockup, or kernel panic.

[Severity: High]
This is a pre-existing issue, but does sensor_hub_remove_callback() wait
for executing callbacks to finish?

When the driver is removed, it removes the callback using
sensor_hub_remove_callback(). This function removes the callback from the
list under dyn_callback_lock but fails to synchronize with or wait for
currently running callbacks:

drivers/hid/hid-sensor-hub.c:sensor_hub_remove_callback() {
    ...
	list_for_each_entry(callback, &pdata->dyn_callback_list, list)
		if (callback->usage_id =3D=3D usage_id &&
						callback->hsdev =3D=3D hsdev) {
			list_del(&callback->list);
			kfree(callback);
			break;
		}
	spin_unlock_irqrestore(&pdata->dyn_callback_lock, flags);
    ...
}

If an event is already in-flight, als_capture_sample() can continue
executing after hid_als_remove() completes and devres frees the indio_dev.
The concurrent execution will then dereference the freed als_state
structure, causing a use-after-free.

>  	hid_sensor_remove_trigger(indio_dev, &als_state->common_attributes);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260606-5-june-hid=
-iio-race-fixes-v1-0-27a848c5758f@gmail.com?part=3D7

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF26E3126D6
	for <linux-input@vger.kernel.org>; Mon, 22 Jun 2026 06:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782108213; cv=none; b=i0DFI2Y3Q0EkVOpxDV0U+22BqcZyoiDfY7tG08dAwJ4eNvd6KsZ+ZFFwrhungfw9DeiPQVTGuMtVyITtHgCzM/DzHgA8BgGf9oksU1Sc+JZQbSuE/KoLjqCkLscGihRtTjjtLvnHFsoZDs5TDmaRl2wqMSTtfFChn4cOJ+7Ross=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782108213; c=relaxed/simple;
	bh=tIjQHlKOz7JQPOrPz5KwQMjYkJU38QN0kIAJZkNf+to=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AkcXEUbDZhKCkt8sMwz7E0bZPerYIES2vGG6c69uO5qbdaVqFlVIH2RMc13XJCeLeYf+olqVPh2DGmg0nnKdY1ik2ad1oGnFvc5Vx9sfxlDbqXy/RNlSF+DZqzwC0+I+Gdntgby4PZdp5EkHiCrARClitR76JxdSsFgrLYukFGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JsNAQM35; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JsNAQM35"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 707001F000E9;
	Mon, 22 Jun 2026 06:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782108212;
	bh=rAz+TBiCDiP9fGkDCTU90SHhGPqm7nhkg8WTpNjvsyM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JsNAQM35xt2CBTUN54K2dAZkDiYSbop7CGGnpp5+4tFJrN4gMdkSny2wcA5T0JYWz
	 TTdTpO0N00Sg1RROqlvFMIdgiaFImNgKPnPrW+mXb2yFwFhafTxzX1ZrfYcajiumKb
	 ksJXb30PxF7Y7VomaSb5GN7H9jHehC0h83eZVcKqH06FblFnrds5smVOzOragridRE
	 pQrAO9eO7XbUxnYPI0vaLI7C2VbXItIfPT5S/xtjNACC0NkGEseyX4QiH+SAPcD+71
	 39H3k6zQ6Fg61QWX/1BhC93jQqowvdYZuwBcF572es1d6rjsGYnhgb/Zh4Ijz4yRGJ
	 zK0H8tmKE1HmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 8/8] iio: accel: hid-sensor-accel-3d: Avoid race
 between callback setup and device exposure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Chitroda" <sanjayembeddedse@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260622-5-june-hid-iio-race-fixes-v2-8-1cfabcd1881e@gmail.com>
References: <20260622-5-june-hid-iio-race-fixes-v2-0-1cfabcd1881e@gmail.com>
 <20260622-5-june-hid-iio-race-fixes-v2-8-1cfabcd1881e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 06:03:32 +0000
Message-Id: <20260622060332.707001F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Pre-existing Use-After-Free during driver removal or probe fai=
lure due to lack of callback synchronization.
- [High] Pre-existing race condition between data push and buffer disable l=
eading to infinite loop.
- [High] Missing length validation on `raw_data` in `accel_3d_capture_sampl=
e` leads to out-of-bounds reads and potential Information Leak.
--

commit d6d7cec4acad5d2e20a4e415413ae49c117fe317
Author: Sanjay Chitroda <sanjayembeddedse@gmail.com>

iio: accel: hid-sensor-accel-3d: Avoid race between callback setup and devi=
ce exposure

This patch reorders the probe and remove paths in the hid-sensor-accel-3d
driver to ensure callbacks are registered before device exposure and removed
after the device is unregistered. This aims to prevent race conditions where
userspace might enable buffers before callbacks are fully set up.

> diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/=
hid-sensor-accel-3d.c
> index 42c4259bf2094..12481cfe9800a 100644
> --- a/drivers/iio/accel/hid-sensor-accel-3d.c
> +++ b/drivers/iio/accel/hid-sensor-accel-3d.c
> @@ -386,12 +386,6 @@ static int hid_accel_3d_probe(struct platform_device=
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
>  	accel_state->callbacks.send_event =3D accel_3d_proc_event;
>  	accel_state->callbacks.capture_sample =3D accel_3d_capture_sample;

[Severity: High]
This isn't a bug introduced by this patch, but does this callback setup lea=
ve
us vulnerable to an out-of-bounds read?

Looking at accel_3d_capture_sample(), it casts the incoming raw_data pointer
without checking if raw_len is sufficiently large:

accel_3d_capture_sample()
    accel_state->scan.accel_val[CHANNEL_SCAN_INDEX_X + offset] =3D
        *(u32 *)raw_data;

Since raw_len is derived directly from the HID report descriptor provided by
the device, could a malicious device declare an artificially small field
(e.g., 1 byte) causing us to read adjacent kernel slab memory when
dereferencing as a u32 or int64_t?

>  	accel_state->callbacks.pdev =3D pdev;
> @@ -399,13 +393,19 @@ static int hid_accel_3d_probe(struct platform_devic=
e *pdev)

[ ... ]

> @@ -418,8 +418,8 @@ static void hid_accel_3d_remove(struct platform_devic=
e *pdev)
>  	struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
>  	struct accel_3d_state *accel_state =3D iio_priv(indio_dev);
> =20
> -	sensor_hub_remove_callback(hsdev, hsdev->usage);
>  	iio_device_unregister(indio_dev);

[Severity: High]
This isn't a bug introduced by this patch, but could this unregister sequen=
ce
trigger an infinite loop during a concurrent data push?

If accel_3d_proc_event() is executing asynchronously in the HID event
context and observes data_ready > 0, it prepares to call
iio_push_to_buffers().

If preempted, another thread could execute this remove path:

hid_accel_3d_remove()
  -> iio_device_unregister()
    -> iio_disable_all_buffers()
      -> iio_buffer_deactivate_all()
        -> iio_buffer_deactivate()

iio_buffer_deactivate() uses list_del_init(&buffer->buffer_list), which mak=
es
the list node self-referential. When iio_push_to_buffers() resumes its
lockless list_for_each_entry() traversal, will it infinite loop on this nod=
e?

> +	sensor_hub_remove_callback(hsdev, hsdev->usage);

[Severity: Critical]
This is a pre-existing issue, but does this callback removal leave a window
for a use-after-free?

sensor_hub_remove_callback() removes the callback from the list under a
spinlock but does not appear to wait for concurrently executing
sensor_hub_raw_event() handlers to complete.

Once hid_accel_3d_remove() returns, the devres framework will immediately
free indio_dev and accel_state. If a concurrent sensor_hub_raw_event() alre=
ady
fetched the callback pointer:

sensor_hub_raw_event()
    if (callback->capture_sample) {
        if (report->field[i]->logical)
            callback->capture_sample(hsdev, ...);

Could it dereference the freed accel_state to execute capture_sample and
send_event, resulting in a use-after-free?

>  	hid_sensor_remove_trigger(indio_dev, &accel_state->common_attributes);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622-5-june-hid=
-iio-race-fixes-v2-0-1cfabcd1881e@gmail.com?part=3D8

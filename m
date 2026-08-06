Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB9225B095
	for <linux-input@vger.kernel.org>; Thu,  6 Aug 2026 12:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786019978; cv=none; b=U/TlEuw/l4HebXo11kmDyb7AY6yYebUidD0amhLOE96ycrPuzJn84S2wYpXAm72kiqCcHW70egi78dYPAzf34idJdCqwHaLpQz66jyTeCzMKrRQyiJNotxP7tCbgyRvc1zBGnGp6a8H7uTlmUztXgQqX/SttAXdtPy1lWTBjPI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786019978; c=relaxed/simple;
	bh=IDlb+PDFHb2qMqibp7jNA3/GwYdeiSq5i09QHdwKIAY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vxf17NIkAGM+A3uPPA3xjln/fsUhUU/ftv48oOi3SpSV3vffmOA9Zx1Hk3jTGfUXinxNItYA/DzB7bJlhVaMm1fWPk3rq7VA37aPwNc4ZxM0QZnFzLax/3zUv4qNOh+OTbv01MdaFxnbDMk6uJKe5F5JC/6vdUQ+oUmS1E4TTOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHyScY22; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHyScY22"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C001F000E9;
	Thu,  6 Aug 2026 12:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786019972;
	bh=s76xtWiwGGGhH3CDAapikueJKAWgN/1kucQPl4nRUbc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CHyScY22R20L7C7aOybXOZnEwFGHDygXBHiDMbY5vQ7nOHTyW60uotGL2eV10cDXr
	 l5qI/xwUCBV8t8d7vRSiD6UrKZM2Q7vSmC8UNQIyyNHN2dVmQPpyLJ/nbCgDY3zfLI
	 J7zl2OZgAGrGuPblDgfQkRwL0uUPTMBogEBbVLOD6ebfTkU6BXrwFBUz7qNmnC82pp
	 Vy285TqvCKTCvVckWFpRFZjga/Nhqf4NE4ynbR8wg+Uw/VmBoptLtKgxb3ZAZdkO8L
	 yoCECKrl/Dd3wHaN1QsnfkPGzR16eJPX6jKlWZJoXP6cHLu6k0cB+JbkzueiHJPdyQ
	 TNEOPy9hEKoGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 05/13] iio: accel: hid-sensor-accel-3d: convert probe
 and teardown to devm-managed resources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Chitroda" <sanjayembeddedse@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260806-28-apr-iio-redundant-argument-v5-temp-v5-5-f1f92c1d830f@gmail.com>
References: <20260806-28-apr-iio-redundant-argument-v5-temp-v5-0-f1f92c1d830f@gmail.com>
 <20260806-28-apr-iio-redundant-argument-v5-temp-v5-5-f1f92c1d830f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 12:39:31 +0000
Message-Id: <20260806123932.50C001F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Concurrent HID sensor events can trigger a Use-After-Free beca=
use callback deregistration does not synchronize with active event handlers.
--

--- Patch [5]: [PATCH v5 05/13] iio: accel: hid-sensor-accel-3d: convert pr=
obe and teardown to devm-managed resources ---
commit a9b078923d03e5b1bd623e5152abd36454ac1fc5
Author: Sanjay Chitroda <sanjayembeddedse@gmail.com>

iio: accel: hid-sensor-accel-3d: convert probe and teardown to devm-managed=
 resources
   =20
Convert HID IIO driver resource management to use devm-managed helpers,
tying the lifetime of all resources to the device.

> diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/=
hid-sensor-accel-3d.c
> index a7cccbaa82f86..7ba0228f18b43 100644
> --- a/drivers/iio/accel/hid-sensor-accel-3d.c
> +++ b/drivers/iio/accel/hid-sensor-accel-3d.c

[ ... ]

> @@ -384,38 +385,14 @@ static int hid_accel_3d_probe(struct platform_devic=
e *pdev)
>  	accel_state->callbacks.send_event =3D accel_3d_proc_event;
>  	accel_state->callbacks.capture_sample =3D accel_3d_capture_sample;
>  	accel_state->callbacks.pdev =3D pdev;
> -	ret =3D sensor_hub_register_callback(hsdev, hsdev->usage,
> -					   &accel_state->callbacks);
> +	ret =3D devm_sensor_hub_register_callback(dev, hsdev, hsdev->usage,
> +						&accel_state->callbacks);

[Severity: Critical]
This is a pre-existing issue, but does this sequence leave a use-after-free
window during device teardown?

If the driver unbinds or probe fails, devres will call
sensor_hub_remove_callback(). This removes the callback from the list using
dyn_callback_lock, but it does not wait for active sensor_hub_raw_event()
invocations to complete.

If sensor_hub_raw_event() is running concurrently and has already obtained =
the
callback pointer, devres will proceed to free the indio_dev memory.

When the event loop subsequently invokes the callback, wouldn't
accel_3d_capture_sample() execute on the freed memory?

drivers/hid/hid-sensor-hub.c:sensor_hub_raw_event() {
    ...
    if (callback->capture_sample) {
        if (report->field[i]->logical)
            callback->capture_sample(...);
    ...
}

Could this lead to out-of-bounds writes when it attempts to store the
sample data into the freed accel_state?

drivers/iio/accel/hid-sensor-accel-3d.c:accel_3d_capture_sample() {
    ...
    struct iio_dev *indio_dev =3D platform_get_drvdata(priv);
    struct accel_3d_state *accel_state =3D iio_priv(indio_dev);
    ...
    accel_state->scan.accel_val[CHANNEL_SCAN_INDEX_X + offset] =3D
                        *(u32 *)raw_data;
    ...
}

>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "callback reg failed\n");
> -		goto error_remove_trigger;
> -	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806-28-apr-iio=
-redundant-argument-v5-temp-v5-0-f1f92c1d830f@gmail.com?part=3D5

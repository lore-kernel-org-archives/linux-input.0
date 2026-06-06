Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87FCCA4E
	for <linux-input@vger.kernel.org>; Sat,  6 Jun 2026 12:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780748005; cv=none; b=rDjhovg0xgEFous1hTkDDUw4svsPXmigOuj6Png9sfTsZeBEmKIq1ZfdEin5v26rIPpcInwRIT33dARZc1g8JJmCEB/CnwWXmFWvCcTWElTPzgcggu56mq6zcDfcLFzYTqpqzd02lNecfHxn9K05EekMbf9hEeU8zv2xx60fxbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780748005; c=relaxed/simple;
	bh=bizZRYCNzPNOpIurPwm1s/hKodILSTnGm26QRqaDMpc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XYXOiomg3g661qc1QEQo/fp9BoyINEo//qnA/7aOXbyozXxJqkC1eon24gwLNkJEv7XhdQVikL0Q5/LdoKkNu2XA2EBd/+ngE3ICPxsE8EoHOFJySM8wdYWCof6dVmyNUSWvGYF/r3WR/2RJZ710cBP2DyWMGVG1fsK9O3cKNf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXgZY3yC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXgZY3yC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 679411F00893;
	Sat,  6 Jun 2026 12:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780748004;
	bh=s6GCM7Pj7eNesrT1aTowm5Av3jJpn0wKb57k+gwU7Yg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lXgZY3yC4aEDJktfCOal7GpBo4E6n/mPvCk3t8x7c7H44T0JKvP7H8TbEqc2Z3EiI
	 PmWpKMuxizeT5Mrs+SVJCwEnMnyokFVqcrBLgVodUIa5JnJrDyPUgiJHfOl5HyOMcU
	 Yj6UNat7JmYMzBlDKNTtJxmz2lUccLHwHi3OB9xU8uCyiLDud/qFOJwx8gCyjlw9BW
	 UxlDx3xMocdE+BP9T3SjAztfcRYdSHHZ4I9p2YDwxB6RPr/DBTEB+gbRO+uwzEF6bF
	 flqiFbaCoG38o2mq70s5J888YKYUzMsTpsgrvdUs1zw74PYdOAqyYonS/2gOKgTvuJ
	 UhAy8pdUWVNew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/9] iio: gyro: hid-sensor-gyro-3d: Fix race between
 callback registration and device exposure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Chitroda" <sanjayembeddedse@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260606-5-june-hid-iio-race-fixes-v1-3-27a848c5758f@gmail.com>
References: <20260606-5-june-hid-iio-race-fixes-v1-3-27a848c5758f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 12:13:24 +0000
Message-Id: <20260606121324.679411F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Lack of synchronization in sensor_hub_remove_callback() leads to U=
se-After-Free (UAF) of function pointers and device state.
--

commit aa52ffd9a4b9c66e6a2d69f6946e1ab533f472af
Author: Sanjay Chitroda <sanjayembeddedse@gmail.com>

iio: gyro: hid-sensor-gyro-3d: Fix race between callback registration and d=
evice exposure

This commit reorders callback registration and IIO device registration
in the probe and remove paths to prevent race conditions during
initialization and teardown.

> diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid=
-sensor-gyro-3d.c
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
Does this new error path introduce a use-after-free window if an event
arrives concurrently?

Looking at sensor_hub_remove_callback(), it removes the callback from the
active list but does not appear to synchronize with or wait for concurrently
executing event handlers.

If iio_device_register() fails, probe() calls sensor_hub_remove_callback()
and returns immediately. The devres subsystem will then free the indio_dev
and gyro_state memory.

Could this sequence occur:

CPU1
hid_gyro_3d_probe()
    error_remove_callback:
    sensor_hub_remove_callback()
    return ret;

CPU2 sees this in sensor_hub_raw_event():
    if (callback->capture_sample) {
        callback->capture_sample(...);

Since callback points to the devm-allocated gyro_state->callbacks, would
this lead to dereferencing freed function pointers and state data?

>  error_remove_trigger:
>  	hid_sensor_remove_trigger(indio_dev, &gyro_state->common_attributes);
>  	return ret;
[ ... ]
> @@ -356,8 +356,8 @@ static void hid_gyro_3d_remove(struct platform_device=
 *pdev)
>  	struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
>  	struct gyro_3d_state *gyro_state =3D iio_priv(indio_dev);
> =20
> -	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_GYRO_3D);
>  	iio_device_unregister(indio_dev);
> +	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_GYRO_3D);

[Severity: High]
Does this teardown sequence suffer from the same lack of synchronization?

If sensor_hub_remove_callback() does not wait for ongoing events to complet=
e,
could a concurrent sensor_hub_raw_event() still be executing and access
gyro_state->callbacks after hid_gyro_3d_remove() finishes and devres cleans
up the memory?

>  	hid_sensor_remove_trigger(indio_dev, &gyro_state->common_attributes);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260606-5-june-hid=
-iio-race-fixes-v1-0-27a848c5758f@gmail.com?part=3D3

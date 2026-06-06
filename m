Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16B339DBE0
	for <linux-input@vger.kernel.org>; Sat,  6 Jun 2026 12:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780747841; cv=none; b=rF+2TeFDaSXzhCMUCCQB8m2qOuxLT38Z7D3XDCUecQLO3OWZndKNQXieEUd9zb8FDPT8vZw7I1ZTV+3jcXop09vIktJSjwSe5yw9KmoT5qAQlAHquVPtNp3pJNVBvKuVzMyC11H+4tyv78YqfsU8AmpGVIhmpvEwY6XmiO/E2Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780747841; c=relaxed/simple;
	bh=tm8o2ZIlwKmxJclibSz7ketT3dgPhZhctouMVLg4QMA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KQVqFNr5fPtytVSHe7kuG/1dto5IfO7EDPCPBgq3ky0tuXpz2dTRhJmJy7yLAKK88qHavW74XhTZTxTFUYj6t1kRXf/Btz8A/YIXQJU7eVmPaP+932NoI/+D1mZ7GVNfvZce9uuzpiixodmI1fYrYbTof2Z2dLhbdXLZXe5aP88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElVs+Jvr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElVs+Jvr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B641F00893;
	Sat,  6 Jun 2026 12:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780747840;
	bh=szsY0RkqMlCRNE5X3HQcx9kmDa03i0F7h5rmSl7JBtY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ElVs+JvrKzdX+ZH6ZAKxLzihD9JWTkNACnrtF+JUrY6eCocY5Z5jjcBQZwklZwHJT
	 taSJQ+XbD1dxBz1U9eV7UK+7j/b6Tx4j8ogdBQh6ZIu5yj+Vpn9dO/tEk4uwLS0Tjz
	 Al2ozrTScpd46tOoAqkdD1vaPbd8sqF3Of0RO5JSRC/8a1+nW5WUNug+L7Ncn/v5BX
	 d9tCLzxRUJP1+humRZlIYuSs0dXwETjdKI+tON2ikCqZggNq9utDOCHOe45H4MyOU7
	 8CmBF9D1JaEoKOf2idcHI8dD0rnmeHGW9JE/YUcKLQm14IVf0jR0jaYoB0bxQpvGBW
	 im+oR82mFF0BQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 8/9] iio: magnetometer: hid-sensor-magn-3d: Fix race
 between callback registration and device exposure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Chitroda" <sanjayembeddedse@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260606-5-june-hid-iio-race-fixes-v1-8-27a848c5758f@gmail.com>
References: <20260606-5-june-hid-iio-race-fixes-v1-8-27a848c5758f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 12:10:39 +0000
Message-Id: <20260606121040.49B641F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] Reordering `iio_device_unregister()` before `sensor_hub_remove=
_callback()` in the remove path introduces a critical list corruption race.
- [High] Reordering callback registration before IIO device registration in=
troduces a Use-After-Free (UAF) window on the probe error path.

Pre-existing issues:
- [High] Pre-existing Use-After-Free vulnerability because `sensor_hub_remo=
ve_callback()` unlinks the callback without synchronizing with currently ex=
ecuting asynchronous HID events.
--

commit b4969e9293deed992cb095faf4c58a2ab65c8d1e
Author: Sanjay Chitroda <sanjayembeddedse@gmail.com>

iio: magnetometer: hid-sensor-magn-3d: Fix race between callback registrati=
on and device exposure

This patch attempts to fix a race condition by reordering the callback
registration and IIO device registration in the probe and remove paths.
It registers the sensor hub callback before exposing the IIO device, and
unregisters the IIO device before removing the callbacks.

> diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/=
magnetometer/hid-sensor-magn-3d.c
> index 23884825eb00f..acae77273bd5e 100644
> --- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> +++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
[ ... ]
> @@ -526,13 +520,19 @@ static int hid_magn_3d_probe(struct platform_device=
 *pdev)
>  					&magn_state->callbacks);
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
> +	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_COMPASS_3D);

[Severity: High]
Can this sequence cause a use-after-free if a callback is currently
executing?

Since sensor_hub_remove_callback() only unlinks the callback without
synchronizing or waiting for currently executing ones to finish, could
magn_3d_proc_event() still be running?

When hid_magn_3d_probe() returns an error, the devres subsystem will
immediately free indio_dev and magn_state. If a concurrent callback was
triggered right before iio_device_register() failed, it would then
access the newly freed memory.

>  error_remove_trigger:
>  	hid_sensor_remove_trigger(indio_dev, &magn_state->magn_flux_attributes);
>  	return ret;
> @@ -545,8 +545,8 @@ static void hid_magn_3d_remove(struct platform_device=
 *pdev)
>  	struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
>  	struct magn_3d_state *magn_state =3D iio_priv(indio_dev);
> =20
> -	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_COMPASS_3D);
>  	iio_device_unregister(indio_dev);

[Severity: Critical]
Does reordering iio_device_unregister() before removing the callback
expose a list corruption race?

iio_device_unregister() calls iio_disable_all_buffers(), which modifies
the buffer_list using list_del_init() without lock or RCU protection.

Since the sensor callback is still active, incoming hardware events can
continue to fire. If magn_3d_proc_event() calls=20
iio_push_to_buffers_with_timestamp() and iterates over buffer_list
locklessly at the same time list_del_init() is executing, could this
cause the next pointer to loop on itself and result in a hard lockup?

> +	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_COMPASS_3D);

[Severity: High]
This isn't a bug introduced by this patch, but does the lack of
synchronization in sensor_hub_remove_callback() leave a lingering
use-after-free window here?

sensor_hub_remove_callback() removes the callback from the list but
returns without waiting for any currently executing sensor_hub_raw_event()
to finish.

After sensor_hub_remove_callback() completes, hid_magn_3d_remove()
returns and devres will free indio_dev and magn_state. If a callback is
still executing on another CPU, it might access this freed memory.

>  	hid_sensor_remove_trigger(indio_dev, &magn_state->magn_flux_attributes);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260606-5-june-hid=
-iio-race-fixes-v1-0-27a848c5758f@gmail.com?part=3D8

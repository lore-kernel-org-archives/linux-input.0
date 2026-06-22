Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A6C2D661C
	for <linux-input@vger.kernel.org>; Mon, 22 Jun 2026 05:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782107128; cv=none; b=G2TRN1uNPPfqK80MrdHNLkxgSkA/hf0E1qs3jjMm1aFi011m/VJfqCkgA3Ldvm7fJ/Q1jZX58zT9IKzW9lQw5oNfw08OKRcrtWU8lNS35en6MCo+ARUcHVVLmUXnLf/9jEXGH4LGvph00PEia+kdXoJxlH7k5vmMZ26Nh7158iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782107128; c=relaxed/simple;
	bh=7ttvzDKhlxgmX8QbVy2OesiETbCPkBbSLUaWSanMj0I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UlUSMGHwBITpjvEAiLC/2rWLE6SVyEYKFOdbroRInBIzZ4iu7/WusBbTNcO/fiQrF9m8cHZYpICK1EE3iTRdhHUIUsuz3MDoRxQVqaCJ0M5sdEG3Vuqh7cNrzdxKTCxwtZi++/TQSsdgsMH4vUNh3ZW+BgdqqGkidDb8KHlEAUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8G65Wur; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8G65Wur"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1D91F00A3D;
	Mon, 22 Jun 2026 05:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782107127;
	bh=jipG5bzQJCnQlaQWal6WjcG8wg4irVbEUtc59nHEp0A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b8G65Wurb/TEe/z+4ME9/QUoUAKTkwzf7r2VTGMP2DrTiYBn8kR/gnefv6AKxQHyQ
	 T6Iz1xGD3SC0rDLAIHybOvLyv6B2go+cHhDC68N/oGgKbGXUE4/65jhzxDdZbmM11A
	 YoNXRyRm3yVolffLHr5mbAfFcKvZgNsMIC38p076yMzZ1rdIt1hVaFb+sqJhb33oke
	 UuL8ZUq8YuMuuomAmZviaAmqhGj2fHzgpkEPBlbX1rm7gyNwkLKPOeZ8vaMm3hRRPW
	 RocxfP2ECWbta/io7G35Wy0SYsbe5sAev69FG9mNObxWHqwTmYYX7bba/n49SvEYdU
	 u41E1wXFbvw5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/8] iio: light: hid-sensor-als: Avoid race between
 callback setup and device exposure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Chitroda" <sanjayembeddedse@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260622-5-june-hid-iio-race-fixes-v2-6-1cfabcd1881e@gmail.com>
References: <20260622-5-june-hid-iio-race-fixes-v2-0-1cfabcd1881e@gmail.com>
 <20260622-5-june-hid-iio-race-fixes-v2-6-1cfabcd1881e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 05:45:26 +0000
Message-Id: <20260622054527.0C1D91F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free due to lack of synchronization in sensor_hub_remove=
_callback()
--

commit 74625485fbdc50663ffbe0a0e45aa978eaafe03d
Author: Sanjay Chitroda <sanjayembeddedse@gmail.com>

iio: light: hid-sensor-als: Avoid race between callback setup and device ex=
posure

The driver currently exposes the IIO device to userspace before completing
sensor hub callback registration, and similarly removes callbacks while the
device can still be accessed during teardown. Reorder probe and remove path=
s to
ensure callbacks are active before device exposure and are removed after de=
vice
is no longer accessible.

> diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-s=
ensor-als.c
> index ae2fda8dc500a..823bb56b9873a 100644
> --- a/drivers/iio/light/hid-sensor-als.c
> +++ b/drivers/iio/light/hid-sensor-als.c
> @@ -406,25 +406,25 @@ static int hid_als_probe(struct platform_device *pd=
ev)

[ ... ]

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
>  	}
> =20
>  	return ret;
> =20
> -error_iio_unreg:
> -	iio_device_unregister(indio_dev);
> +error_remove_callback:
> +	sensor_hub_remove_callback(hsdev, hsdev->usage);

[Severity: High]
This is a pre-existing issue, but can this lead to a use-after-free if
sensor_hub_raw_event() is executing concurrently?

When iio_device_register() fails, we call sensor_hub_remove_callback() in t=
he
new error path. Looking at sensor_hub_remove_callback() in
drivers/hid/hid-sensor-hub.c, it removes the callback list entry under
dyn_callback_lock and returns immediately without synchronizing with any
currently executing events:

drivers/hid/hid-sensor-hub.c:sensor_hub_remove_callback() {
    ...
		if (callback->usage_id =3D=3D usage_id &&
						callback->hsdev =3D=3D hsdev) {
			list_del(&callback->list);
			kfree(callback);
			break;
		}
	spin_unlock_irqrestore(&pdata->dyn_callback_lock, flags);
    ...
}

However, sensor_hub_raw_event() drops dyn_callback_lock before executing
the callbacks:

drivers/hid/hid-sensor-hub.c:sensor_hub_raw_event() {
    ...
				callback->capture_sample(hsdev,
					report->field[i]->usage->hid, sz, ptr,
					callback->pdev);
    ...
}

If sensor_hub_raw_event() is running concurrently when we return from
hid_als_probe(), devres will automatically free the IIO device and als_stat=
e.
Would the concurrently executing event handler then access freed memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622-5-june-hid=
-iio-race-fixes-v2-0-1cfabcd1881e@gmail.com?part=3D6

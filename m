Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2581A3E3D8E
	for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 12:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782391148; cv=none; b=rfWIUSS4MjWbXJgNpyXTyl8TIShC6JC0KtH1+wqq6ROX4emtMczg41fm6Z/QdBALtPDPrsK/6PlCHwc8k30VBiWdpZUGB8Uh27OoKS1xMEIvwASzzkBquuIxhnvT1C7Sb2F9PBNAtOL46kzR4amj7AIcSveJHEGjsmE7RZIs94s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782391148; c=relaxed/simple;
	bh=KYDFg10440Z59IGdQGHT1Lh3fEwz9W3SHWjXuYf2PjE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LmOwof80zN+8phagUaLN90hPYf6hYMwmXCWt11zy9X+oEqpNbyj/VnfGfzUKoIdzmPUfvOa3HCFJ8qnbl1joFyhrw8ddqM9gPTDExQY3Hw0Xp0mHYWHZ0lGMsQEAKIzE5wEYR6WDuAF2yK8mFg3DrlQ69n6GfCYErzb+DIYSUMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oAIoDMSe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oAIoDMSe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B68C1F00A3A;
	Thu, 25 Jun 2026 12:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782391141;
	bh=R9APhsN/fNECvBw6C52LdhltV1t+qLSJOAMQpQJPi5Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oAIoDMSeSB+oOvw4Itwq+8TouJigZDFzQuObeT5G/mg4zY63QRhr90dTcLlSxysL/
	 9bsB1hs5Dxr9lERuqHocXJAHRnGPdUcu7Ud3ldXocmNXS+1BTHxlc7K788A7V+qCV1
	 ZDNynTK6OkKUji09IF1CAJMIsTwnvLOnUHVHMefNV8wdz5THq1QGJwkPH6a9gYv/28
	 8ZMjXBBuEqH5mqCBVAwohh8Ce7hdJIWecvesoELcfpe4iFh++VvG2lNw4KQHlQyJnr
	 dgUaASwvTr6u+F+t04hnzw503ejpOZFRTBl4NoSmKb3z4hP/EaOCfRGXdC/bWcaPwX
	 ODCjOGEUr2kzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] iio: temperature: hid-sensor-temperature: switch to
 non-devm iio_device_register()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Chitroda" <sanjayembeddedse@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260625121611.2003780-1-sanjayembedded@gmail.com>
References: <20260625121611.2003780-1-sanjayembedded@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 12:39:01 +0000
Message-Id: <20260625123901.9B68C1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver incorrectly uses a static global structure `temperature=
_callbacks` to hold per-device state, causing cross-device data corruption =
and potential Use-After-Free.
- [High] A race condition during device unbind can lead to a Use-After-Free=
 or NULL pointer dereference because `sensor_hub_remove_callback` does not =
wait for concurrently executing events.
--

commit 0a06e7ba97cafc3e2c79740421bf8186cb0fc540
Author: Sanjay Chitroda <sanjayembeddedse@gmail.com>

iio: temperature: hid-sensor-temperature: switch to non-devm iio_device_reg=
ister()

The patch switches from devm_iio_device_register() to iio_device_register()
to fix a teardown ordering issue. It adds an explicit iio_device_unregister=
()
in the remove function to ensure the device is not accessed after its backe=
nd
resources begin to be dismantled.

> diff --git a/drivers/iio/temperature/hid-sensor-temperature.c b/drivers/i=
io/temperature/hid-sensor-temperature.c
> index 9f628a8e5cfbe..34bff7e9f3a33 100644
> --- a/drivers/iio/temperature/hid-sensor-temperature.c
> +++ b/drivers/iio/temperature/hid-sensor-temperature.c
> @@ -244,7 +244,7 @@ static int hid_temperature_probe(struct platform_devi=
ce *pdev)
>  	if (ret)
>  		goto error_remove_trigger;
> =20
> -	ret =3D devm_iio_device_register(indio_dev->dev.parent, indio_dev);
> +	ret =3D iio_device_register(indio_dev);

[Severity: High]
This is a pre-existing issue, but does this driver incorrectly use a static
global structure for per-device state?

Looking at hid_temperature_probe(), we overwrite the shared global pdev
pointer in the statically allocated temperature_callbacks structure:

drivers/iio/temperature/hid-sensor-temperature.c:hid_temperature_probe() {
    ...
    temperature_callbacks.pdev =3D pdev;
    ret =3D sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_TEMPERATUR=
E,
                                       &temperature_callbacks);
    ...
}

If multiple temperature sensors are probed, the most recently probed device
will overwrite this shared pointer. If the last probed device is later
unbound, its driver data is cleared.

Subsequent events for other active devices will dereference the cleared pdev
in temperature_proc_event(), leading to a null pointer dereference or
use-after-free.

>  	if (ret)
>  		goto error_remove_callback;
> =20
> @@ -264,6 +264,7 @@ static void hid_temperature_remove(struct platform_de=
vice *pdev)
>  	struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
>  	struct temperature_state *temp_st =3D iio_priv(indio_dev);
> =20
> +	iio_device_unregister(indio_dev);
>  	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_TEMPERATURE);

[Severity: High]
This isn't a bug introduced by this patch, but can a race condition during
device unbind lead to a use-after-free or null pointer dereference?

The sensor_hub_remove_callback() removes the callback from the sensor hub's
list, but does not synchronize with concurrently executing callback handlers
like sensor_hub_raw_event().

If an event from the sensor hub arrives exactly as the driver is unbinding,
the event handler might fetch the callback just before it is removed. When
hid_temperature_remove() completes, devres frees indio_dev, and the driver
core sets drvdata to NULL.

The concurrent event handler then executes temperature_capture_sample(),
calling platform_get_drvdata(pdev) which either returns NULL or a dangling
pointer to the freed indio_dev, causing a crash.

>  	hid_sensor_remove_trigger(indio_dev, &temp_st->common_attributes);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625121611.2003=
780-1-sanjayembedded@gmail.com?part=3D1

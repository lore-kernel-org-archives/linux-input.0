Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE49D39B97B
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 09:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784541588; cv=none; b=pmsxvmKc1ZyPE97qunTln2AHmiDNnod6vZAWWswR0Xkq+9iuigW/wHLTDuT+gouHNBcQAsjHjAEOcyRylfVvaGwIndTaUyQ2RKnIgGI1/SbhtxGUyK85JofdkOyZxuzwgv8gclkbEKY69R62ujvDA5biwXd0FY/1RhdgAaWknEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784541588; c=relaxed/simple;
	bh=9hF+OvM/Jey0bK6HTsxl95xe78Sfq5TWrLooYlA3A8Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CieDashUvGufCoCcYsmIJb5oES+JEFlkuvPq6+n/kvzGzEWn5tpbjLM4uXsac3MXE//Am1JczS8Xl4dBgMH0ZncXGspnlZUjjyv0QvyI/oCH6eHMuNY0CxNUuFfvAsQYF3vRIudHT2MgPNTnWtC0B/aQixwL/i2hdIa0dY4UL1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhXCdb4+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhXCdb4+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 276E31F00A3A;
	Mon, 20 Jul 2026 09:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784541586;
	bh=7FUy37tNQzShYjRwXlkK/vUimm7wzlm+8Im9tOJmk6Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dhXCdb4+G+k+Nd9Ka/7QgAlewMIsnmm2U4iJLhp4eusNvNAZs5zABsrB5VKbtvo5z
	 jMv9QwHi0LQbten1Fos+Wz7jauJF3kx+nAvvPuMoTv1xZjOHVZyc7/oYF+vMI4gKuA
	 f1Ncwsz8X+fA4jrh8j+UjruQufhNo2oP338hCW6yKx3yy+fdYW7J2pBlfR7MpfflXp
	 MsVXZQGXX6b57mk2siyspdgh66z1v8dgoqw2YUZpj2+5NI4GiOW+WQBUNHVol7UzLF
	 brJagVdqDD3132aV88iIEXOG+1cbAtmpHwNMAkaxH9DBU/wkwe5TmQp+TIBVNPT9lG
	 mYFyqEoQiGY8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/10] iio: position: hid-sensor-custom-intel-hinge: use
 local struct device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Chitroda" <sanjayembeddedse@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260720-hid-iio-local-struct-device-v1-9-74496fee6327@gmail.com>
References: <20260720-hid-iio-local-struct-device-v1-0-74496fee6327@gmail.com>
 <20260720-hid-iio-local-struct-device-v1-9-74496fee6327@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 09:59:45 +0000
Message-Id: <20260720095946.276E31F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Possible Use-After-Free of `hinge_state` and its embedded `callbac=
ks` during driver unbind or probe error paths, due to lack of synchronizati=
on with concurrent HID sensor events.
--

--- Patch [9]: [PATCH 09/10] iio: position: hid-sensor-custom-intel-hinge: =
use local struct device ---
commit 7aa4981763773e6c94e52f6b3bcf4d8c0d85b050
Author: Sanjay Chitroda <sanjayembeddedse@gmail.com>

iio: position: hid-sensor-custom-intel-hinge: use local struct device

Introduce a local struct device pointer derived from pdev->dev to avoid
repeated pdev->dev usage and improve readability.

> diff --git a/drivers/iio/position/hid-sensor-custom-intel-hinge.c b/drive=
rs/iio/position/hid-sensor-custom-intel-hinge.c
> index d275bc1413feb..febc32f5a3328 100644
> --- a/drivers/iio/position/hid-sensor-custom-intel-hinge.c
> +++ b/drivers/iio/position/hid-sensor-custom-intel-hinge.c

[ ... ]

> @@ -322,13 +323,13 @@ static int hid_hinge_probe(struct platform_device *=
pdev)
>  	st->callbacks.pdev =3D pdev;
>  	ret =3D sensor_hub_register_callback(hsdev, hsdev->usage, &st->callback=
s);
>  	if (ret < 0) {
> -		dev_err(&pdev->dev, "callback reg failed\n");
> +		dev_err(dev, "callback reg failed\n");
>  		goto error_remove_trigger;
>  	}
> =20
>  	ret =3D iio_device_register(indio_dev);
>  	if (ret) {
> -		dev_err(&pdev->dev, "device register failed\n");
> +		dev_err(dev, "device register failed\n");
>  		goto error_remove_callback;
>  	}
> =20
> 	return ret;
>=20
> error_remove_callback:
> 	sensor_hub_remove_callback(hsdev, hsdev->usage);

[Severity: High]
This is a pre-existing issue, but can this lead to a use-after-free during
the probe error path or device unbind?

If iio_device_register() fails, sensor_hub_remove_callback() removes the
callback from the list but does not appear to synchronize with
sensor_hub_raw_event() which might be concurrently executing the callback.

Since the hinge_state structure is allocated with devm_iio_device_alloc(),
returning from hid_hinge_probe() will cause the devres framework to
prematurely free the memory while the concurrent event handler is actively
writing to it.

Does there need to be some synchronization to ensure pending events are
flushed before the devres cleanup occurs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720-hid-iio-lo=
cal-struct-device-v1-0-74496fee6327@gmail.com?part=3D9

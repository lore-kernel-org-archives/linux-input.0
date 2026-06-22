Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D317F241C8C
	for <linux-input@vger.kernel.org>; Mon, 22 Jun 2026 05:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782106775; cv=none; b=R2ijsy271tWLnaq+pleNPxK+D6z3VniDOMcf8XUxvLM7CNEjbzVl+NSlhRsA+B5EZu4upUgnKPq9pWifPcxk/s4UafFt/pZDRE3VhC5PBkp54eUgJ0Il7+BGSs35/or7kauUPOidSd+x1MzSCMQkkZMF+GTQdfWD8yBca8WiIjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782106775; c=relaxed/simple;
	bh=OERz+17IjVNNL9p5CytOLH7Eb+4BWMDmT1qn/DxT64U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UYu9xp3dVhW/nOKbscfoh/ayNSbkvq39QaB8kTYXmreaolh+3AivcLtgPO60lRZo3h1KV9Y/LS2x4D0pBgIK4/iLyBzB9Ve645Sgc7CcmjILAGY1EBCcHZnGqNiwFC27ld3MGo3TyU1MD9ojGUsO16kGmZwRp0rbp0lJT9C6B4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOrQnbgX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOrQnbgX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC211F000E9;
	Mon, 22 Jun 2026 05:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782106774;
	bh=8yTszHzuJYs/ngpVuybzt/Yj2HysP+OgFbegzKVReY4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iOrQnbgXqUicnUd35v3rGaEJMm57hyPYi3o9XLpIMazGBOQ2o42EJ2RuhvQk6WKA7
	 NG+UH5WB4YOWejf7hwqMBn9N7XrF2Pt5xK3F8FiA6R5l9DzztvK5xjVQ1hG6wxdXWP
	 2N0Ug/WrcW8aONefmoBBzMZbXP2ewg4+1kHihQEq/UJ3I8vGvka+KbPfeq8GWMSy+G
	 yrQSLle+h6uDDz2Gm74jClfXSqpSmGfHSrNV8pw6jG5/mhcNaXiwPV1QpRqD3D9E77
	 6R+hgAipe+wmNoJZRdAiEdOy+yofulCviMbMVmewlQFIsYcE1U/Q7guIOUN4cZBWXy
	 YpRZuewhcztjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] iio: temperature: hid-sensor-temperature: switch to
 non-devm iio_device_register()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Chitroda" <sanjayembeddedse@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260622052135.1804135-1-sanjayembedded@gmail.com>
References: <20260622052135.1804135-1-sanjayembedded@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 05:39:33 +0000
Message-Id: <20260622053934.5CC211F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Concurrent execution of HID sensor hub callbacks and device un=
bind leads to a Use-After-Free of `indio_dev`.
- [High] The static global `temperature_callbacks` struct is mutated during=
 probe, causing data corruption and cross-device routing bugs when multiple=
 sensors are present.
--

commit 829c19b8a370c5d8b09345d4e07b865deb47a88f
Author: Sanjay Chitroda <sanjayembeddedse@gmail.com>

iio: temperature: hid-sensor-temperature: switch to non-devm iio_device_reg=
ister()

This commit replaces devm_iio_device_register() with iio_device_register()=
=20
to ensure deterministic cleanup. It adds an explicit iio_device_unregister(=
)=20
call in the remove path to fix potential use-after-free race conditions=20
during device removal.

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
This isn't a bug introduced by this patch, but looking at the probe function
just prior to this registration, is there a risk of corrupting device routi=
ng
when multiple sensors are present?

The driver defines temperature_callbacks as a static global struct:

static struct hid_sensor_hub_callbacks temperature_callbacks =3D {
        .send_event =3D &temperature_proc_event,
        .capture_sample =3D &temperature_capture_sample,
};

During hid_temperature_probe(), the current device's pdev is directly
assigned to temperature_callbacks.pdev.

If a system has multiple HID temperature sensors, does the last probed sens=
or
overwrite this global pointer? It seems like when sensor_hub_raw_event()
processes hardware events, it might fetch the shared struct and pass the
single overwritten pdev to temperature_capture_sample(). Would this cause t=
he
data from all temperature sensors to be written exclusively into the IIO st=
ate
of the last probed sensor?

[ ... ]

> @@ -264,6 +264,7 @@ static void hid_temperature_remove(struct platform_de=
vice *pdev)
>  	struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
>  	struct temperature_state *temp_st =3D iio_priv(indio_dev);
> =20
> +	iio_device_unregister(indio_dev);
>  	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_TEMPERATURE);

[Severity: Critical]
This is a pre-existing issue, but I wanted to ask about the teardown order
here.

In hid_temperature_remove(), we call sensor_hub_remove_callback(), which
removes the callback from the sensor hub's list under dyn_callback_lock.
However, it doesn't appear to synchronize with or wait for concurrently
executing callback handlers like sensor_hub_raw_event() to finish before
returning.

Since indio_dev is allocated with devm_iio_device_alloc() during probe, it
will be freed by devres immediately after hid_temperature_remove() returns.

If sensor_hub_raw_event() is executing concurrently and has already retriev=
ed
the callback pointer, could it pass the pdev to temperature_capture_sample()
and perform a use-after-free write on the freed private state?

For example:
temp_st->scan.temperature_data =3D *(s32 *)raw_data;

Should we be flushing or waiting for running callbacks to complete before
letting the device context be freed?

>  	hid_sensor_remove_trigger(indio_dev, &temp_st->common_attributes);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622052135.1804=
135-1-sanjayembedded@gmail.com?part=3D1

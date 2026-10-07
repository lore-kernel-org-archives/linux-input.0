Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215BF3FB07A
	for <linux-input@vger.kernel.org>; Wed,  7 Oct 2026 07:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791359066; cv=none; b=nG+kkqG64uTs7cdliRuTDkXzqCfvRbSbvpJXocHgi7IyaceLpgGAZvvl/lyKLt9ENAgE7seamLpqfKoPAXBtgN5RGtqYUnUUmQaoyzfzO0Qi5oTfos3donsWy9zPux1z+BRbjgMRGnt+AVyYhy6urvEFiKtWpOMIh2Yh63kBFX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791359066; c=relaxed/simple;
	bh=YR8rw7E6yujA56zFQjoLaAG+ChfIT8Rlx7Qsl1QxtuQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=aOkvaE5U/ea8Dc/iVRcgW3ykhNV211VrLqNu8Z6RuAFWmaCfFA8rV8QncX3/NdWvxZo26OFvkzWOIP6ay8HwXzYLefOh1975ePObKdLGpwUl+jwNui0LVIjHSWpEx2E+IGILrjmzT2ynlyu1pU1UVHereVvT6Y+2TsLOJMyaGCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIDZCFgL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIDZCFgL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 520831F0089B;
	Wed,  7 Oct 2026 07:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791359062;
	bh=0BVgl53Un41UMdgeeIzxZPwS3jwS1lHGW+axcpH++so=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MIDZCFgLAo8N0KkwUFYotaujIdbwn5/Zmf9fRk1fH1hWCR6VMOG3xGtxGGwTrquQ5
	 BG5SbNgMrYuJb66AhnHW1KrZlBJnFuyU6LRr16SMj9YAICsXOumb1iUm7j7KrRWr3k
	 h3qGmxglHk758fp5r7JIDE5TWYvyU+OWm0gfYlt6G3NYxGALkZn0XJL7p9CDVxYDEO
	 4MBZrtt6Pxtrc6Q+PUyisAJd/zcm6yQMRBxtnptKLpRTrSADMpyCwrxHjzY09tbyEO
	 Bb31ufKIqTdbYtASscTfKf9L0uIFoCWXdUwL+4R82+i9KLdKgcil4+OOMl40D4skfN
	 xlkdQCkz/i/kQ==
Message-ID: <sashiko-outbox-162723@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] iio: temperature: hid-sensor-temperature: Use
 per-instance callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christopher Hoover" <ch@murgatroid.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261007072329.27806-2-ch@murgatroid.com>
References: <20261007072329.27806-1-ch@murgatroid.com>
 <20261007072329.27806-2-ch@murgatroid.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 07:44:21 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] iio: hid-sensor-temperature: Use-After-Free of callback struct on =
unbind
--

commit c0e839b50a28c72b4e45a4af57921da5a4656f96
Author: Christopher Hoover <ch@murgatroid.com>

iio: temperature: hid-sensor-temperature: Use per-instance callbacks

This patch moves the hid_sensor_hub_callbacks structure from a static
global variable to the dynamically allocated temperature_state structure
to fix an issue where platform devices are overwritten in a multi-sensor
setup.

Cc: stable@vger.kernel.org

> diff --git a/drivers/iio/temperature/hid-sensor-temperature.c b/drivers/i=
io/temperature/hid-sensor-temperature.c
> index 5e3262e461f46..35b8643305b9f 100644
> --- a/drivers/iio/temperature/hid-sensor-temperature.c
> +++ b/drivers/iio/temperature/hid-sensor-temperature.c
[ ... ]
> @@ -237,9 +233,11 @@ static int hid_temperature_probe(struct platform_dev=
ice *pdev)
> =20
>  	platform_set_drvdata(pdev, indio_dev);
> =20
> -	temperature_callbacks.pdev =3D pdev;
> +	temp_st->callbacks.send_event =3D temperature_proc_event;
> +	temp_st->callbacks.capture_sample =3D temperature_capture_sample;
> +	temp_st->callbacks.pdev =3D pdev;
>  	ret =3D sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_TEMPERATUR=
E,
> -					   &temperature_callbacks);
> +					   &temp_st->callbacks);

[Severity: High]
Could this change introduce a use-after-free during driver unbind?

Since temp_st is allocated using devm_iio_device_alloc(), its lifetime is n=
ow
tied to the driver bind lifecycle and it will be freed automatically after
the remove callback returns.

During unbind, hid_temperature_remove() calls sensor_hub_remove_callback().
This removes the callback from dyn_callback_list, but does not synchronize
with a concurrently executing sensor_hub_raw_event() on another CPU:

drivers/hid/hid-sensor-hub.c:sensor_hub_raw_event() {
    ...
    if (callback->capture_sample) {
        if (report->field[i]->logical)
            callback->capture_sample(hsdev, ...);
    ...
}

If sensor_hub_remove_callback() finishes and devres frees temp_st while
sensor_hub_raw_event() is still running, could the raw event path
dereference the freed callback function pointers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007072329.2780=
6-1-ch@murgatroid.com?part=3D1

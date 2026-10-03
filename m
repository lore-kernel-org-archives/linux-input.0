Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE6939891F;
	Sat,  3 Oct 2026 17:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791050173; cv=none; b=EbXK0/0a3yHGCqQQLJeTjfDjUQ8FUzgppJ4HTLj6L6CNoBbBF9wpiLsJ1T3eF4cTUnN5+17qoGKlD21RH8aaho/UBFardwxcNqaLdrKw8DtQOSwb+vmDBefGeHBJZN+uWkO5Jbo5m8h48IGDIKeW64+o8VA4F7RfxaVQE67PMAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791050173; c=relaxed/simple;
	bh=TREzesDfzsQaAcnwWNJ3WGBx2F/MXePW1glUiS2VD9Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tqk2Kif45hZ7ClMHVwFo/jw+97r81HtRtXnt1WXjbk0fmqRE+DZ97e62sXDicEkqR+7+vub+sgVVW/enS5XYRE2c+Ny0aqN2UfhWXE5gBhKV/lAdRsXyUPH4vqYC1Sb/1uF6e3Bk1DnHY9ga8Q9kaJJUypLTQvvRLFgUXW4MwQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxqWFhl2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxqWFhl2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350961F0089C;
	Sat,  3 Oct 2026 17:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791050171;
	bh=7p3llDdy1/oNRABs1MEWrrUVwYmq3aBML8SczUtDMrY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AxqWFhl2OaMTD6L1pttbpl6O8x+NQIhIvQl7h03yxbnUCFSSMJGAEgLhkwXkxH4VK
	 JDGj3eIgju63XJu0X+93//m5lRwj9MuqTPymoNPMyzE1GgKvk6omIKOlF3ZX89wQYA
	 V76ECHmgMhVsa+LG0anprXZ7djU5fn9aoL3/ygsiKYeDCCzu/SwTL2XYY8ZzbXfba2
	 t6AtblANvhclP6WxN7fmSPbLga2otDzYQl36dbrUvPFW3y3jiMPfv5ZuW/y7rHgtp2
	 8f18ymwKEm/SilJZfe5W2IOzQGIM5O8Z/h6L9bK5p5bDL0NSpKcXhQtizFmo1JLswX
	 NQMf1pv9ic20g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/6] HID: himax: Add DRM panel follower support
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWljaGHFgiBLb3BlxIc=?= <michal@nozomi.space>
Cc: devicetree@vger.kernel.org, robh@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20261003142741.48634-4-michal@nozomi.space>
References: <20261003142741.48634-1-michal@nozomi.space>
 <20261003142741.48634-4-michal@nozomi.space>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 17:56:10 +0000
Message-Id: <20261003175611.350961F0089C@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] input: unbounded resource leaks and permanent initialization failu=
res on DRM panel prepare retries
- [High] hid: destroying and recreating the HID device on panel suspend/res=
ume breaks userspace input continuity
- [High] input: masking of -EPROBE_DEFER breaks DRM panel follower probe de=
ferral
- [Medium] hid: missing hardware boot delay after reset pin deassertion in =
himax_chip_resume()
--

commit eb8f38c8024df3c3e0a8931cb1c98f90a31716d2
Author: Allen_Lin <allencl_lin@hotmail.com>

    HID: himax: Add DRM panel follower support
   =20
    The touch function of the HX83102J is part of a TDDI controller and has
    to follow the power sequence of the panel. Register as a DRM panel
    follower, and suspend and resume the touch function when the panel is
    unprepared and prepared.
   =20
    Link: https://lore.kernel.org/all/20230727171750.633410-1-dianders@chro=
mium.org

> diff --git a/drivers/hid/hid-himax.c b/drivers/hid/hid-himax.c
> index 1cdb310dec642..653c92829ec7f 100644
> --- a/drivers/hid/hid-himax.c
> +++ b/drivers/hid/hid-himax.c

[ ... ]

> +static int himax_chip_suspend(struct himax_ts_data *ts)
> +{
> +	himax_int_enable(ts, false);
> +	gpiod_set_value(ts->pdata.gpiod_rst, 1);
> +	himax_power_set(ts, false);
> +	himax_hid_remove(ts);

[Severity: High]
Does tearing down the HID device here break userspace input continuity?

When the panel unblanks and blanks, destroying and recreating the HID device
causes userspace compositors (like X11 or Wayland) to permanently lose track
of the touch device or drop existing input grabs.

> +
> +	return 0;
> +}
> +
> +/**
> + * himax_chip_resume() - Setup flags, I/O and resume
> + * @ts: Himax touch screen data
> + *
> + * This function is used to resume the touch screen. It will set the res=
ume
> + * success flag to false, and disable reset pin. Then call the himax_res=
ume_proc()
> + * to process detailed resume procedure.
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +static int himax_chip_resume(struct himax_ts_data *ts)
> +{
> +	if (himax_power_set(ts, true))
> +		return -EIO;
> +	gpiod_set_value(ts->pdata.gpiod_rst, 0);
> +	himax_resume_proc(ts);

[Severity: Medium]
Is there a missing hardware boot delay after deasserting the reset pin?

The hardware seems to require a 20ms delay after the reset pin is pulled low
(as seen with usleep_range(20000, 20100) in himax_pin_reset()), but here
gpiod_set_value(..., 0) is immediately followed by SPI communication in
himax_resume_proc(). Could this cause intermittent hardware failures, SPI
timeouts, or ignored commands on resume?

> +	himax_hid_probe(ts);

[Severity: High]
This recreates the HID device on panel resume, which as mentioned above,
breaks userspace input continuity.

> +	himax_int_enable(ts, true);
> +
> +	return 0;
> +}

[ ... ]

> +static int __himax_initial_power_up(struct himax_ts_data *ts)
> +{
> +	int ret;
> +
> +	ret =3D himax_platform_init(ts);
> +	if (ret) {
> +		dev_err(ts->dev, "%s: platform init failed\n", __func__);
> +		return ret;
> +	}
> +
> +	ret =3D himax_chip_detect(ts);
> +	if (ret) {
> +		dev_err(ts->dev, "%s: IC detect failed\n", __func__);
> +		return ret;
> +	}

[Severity: High]
Does this error path leak resources?

If __himax_initial_power_up() fails midway (e.g., himax_chip_detect() fails
due to IC boot time), it returns without cleaning up the resources allocated
in himax_platform_init() (like the kzalloc'd ts->xfer_buf).

Since the panel follower mechanism will retry asynchronously when the panel
is toggled via himax_panel_prepared(), the retry will overwrite the
ts->xfer_buf pointer and permanently leak memory.

Additionally, since himax_ts_register_interrupt() uses
devm_request_threaded_irq() and the probe function already completed, devm
allocations are not rolled back on asynchronous errors. A subsequent retry
will fail permanently with -EBUSY because the IRQ is already devres-claimed.

Also, if the driver unbinds, himax_spi_drv_remove() checks if
(ts->probe_finish) and skips himax_platform_deinit(), leaving ts->xfer_buf
permanently leaked.

[ ... ]

> @@ -1660,25 +1932,13 @@ static int himax_spi_drv_probe(struct spi_device =
*spi)
>  	ts->initialized =3D false;
>  	ts->ic_boot_done =3D false;
> =20
> -	ret =3D himax_platform_init(ts);
> -	if (ret) {
> -		dev_err(ts->dev, "%s: platform init failed\n", __func__);
> -		return ret;
> -	}
> -
> -	ret =3D himax_chip_detect(ts);
> +	ret =3D himax_initial_power_up(ts);
>  	if (ret) {
> -		dev_err(ts->dev, "%s: IC detect failed\n", __func__);
> -		return ret;
> +		dev_err(ts->dev, "%s: initial power up failed\n", __func__);
> +		return -ENODEV;

[Severity: High]
Does returning -ENODEV here break DRM panel follower probe deferral?

If the display panel driver is not yet ready, drm_panel_add_follower() (cal=
led
via himax_initial_power_up()) correctly returns -EPROBE_DEFER. Overwriting
this return value with -ENODEV permanently breaks standard probe deferral
logic.

>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003142741.4863=
4-1-michal@nozomi.space?part=3D3

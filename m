Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2757A175A6C
	for <linux-input@vger.kernel.org>; Sat, 18 Jul 2026 14:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784383422; cv=none; b=AJe5D5PRgDj9VKTbp5RUm0d+2JOwfEOv/5R7cq5Yo0rcLi8dBJ30Gaq71hWQTZbUqCncARXT8r1KEGZgECpOfgXk3NRLxV5Jvov1xpkpe9l/dh+s13Mg9OoXFfWKF4ZO5ArYmYkPm1IQE6Y00oKvp8XiR60zJ60il54Rdj9yVlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784383422; c=relaxed/simple;
	bh=tJl5sPiBcb5PeNGoIBqkuXAdXPHjj9glokD6gvGSm8s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g+n1tQRCYUg5fQ7AfRCP8ldl7ZnTaYsWose9I7vMK6QlfIU43FLFTSaspo5PakttugY6HbGltbg0AjMiY9n9zKZBjI5JqfnS4qVdONguBwMZGSQjcbWyXOkiHzOcj3WU/yTfBSSWoMAA1hiopc6duSClWIgmqzcjkiKrIw8534k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EUTMzoNH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUTMzoNH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA5A1F000E9;
	Sat, 18 Jul 2026 14:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784383420;
	bh=RY3+bxpBdFfv9j/4cZ0hj9zAjIpkRdmVtzfDUNYXl2Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EUTMzoNHjP06WpaAgo1Qz65n87H5kzHj8jLIliP4l2WBrOQMF1Rs4iugdhBatbpL7
	 L8ugcJ9uJSkArhI24SdHKosN7MKl58wqH6ShKhHxgDndhHzbjp7xLdd0lhYyxBtyK7
	 QqAuJl0MmLyqNNuN3mrMgXRMj8665+FIM6XPN8ZTanqMEZbQTWeeO/nkknM/fQ3/rs
	 hGlsdamFfTFcC6rJCleS5m9w9X2GUIDLUYvei+S22T5SiYUIN224GxZ7FAQEVZOdlQ
	 nnF9R/XP38XX5Tsf7jD49w7eyfzA/+HaqSopXlMaFNgJJItxVzsqaesiD9QtupqP59
	 GwpZd7/nX4zxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: novatek-nvt-ts - support being panel follower
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gianluca Boiano" <morf3089@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260718135316.785467-1-morf3089@gmail.com>
References: <20260718135316.785467-1-morf3089@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 14:03:40 +0000
Message-Id: <20260718140340.9CA5A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] Unconditional dereference of `data->input` in `on_novatek_pane=
l_unpreparing` causes a kernel crash if initialization failed.
- [High] Devres ordering inversion causes a Use-After-Free of the input dev=
ice and invalid IRQ access during driver unbind.
- [High] Late `devm_*` allocations in a retryable panel callback cause perm=
anent `-EBUSY` errors on initialization retries.
- [High] Independent userspace `open()` defeats the panel follower power se=
quencing, unconditionally powering the touchscreen.
- [Medium] Premature assignment of `data->input` without rollback on error =
leaves a dangling pointer that breaks initialization retries.
--

--- Patch [1]: [PATCH] Input: novatek-nvt-ts - support being panel follower=
 ---
commit 13c26acf74fd7e860a0a8efe083b34d9bd7e6937
Author: Alexey Minnekhanov <alexeymin@minlexx.ru>

    Input: novatek-nvt-ts - support being panel follower

This commit adds support for the novatek-nvt-ts driver to operate in panel
follower mode, where the touchscreen and panel are powered together in sync.
It splits the input device registration out of the probe function, deferring
it until the panel prepares via callbacks.

> diff --git a/drivers/input/touchscreen/novatek-nvt-ts.c b/drivers/input/t=
ouchscreen/novatek-nvt-ts.c
> index 0f771f6819528..8b290f75a8e48 100644
> --- a/drivers/input/touchscreen/novatek-nvt-ts.c
> +++ b/drivers/input/touchscreen/novatek-nvt-ts.c

[ ... ]

> @@ -145,6 +156,9 @@ static int nvt_ts_start(struct input_dev *dev)
>  	struct nvt_ts_data *data =3D input_get_drvdata(dev);
>  	int error;
> =20
> +	if (data->running)
> +		return 0;
> +
>  	error =3D regulator_bulk_enable(ARRAY_SIZE(data->regulators), data->reg=
ulators);

[Severity: High]
Does this bypass the panel follower power sequencing if userspace opens the
device independently?

Once the panel is prepared and the input device is registered, userspace can
open the input node (e.g. /dev/input/eventX) even if the panel has since be=
en
powered off.

When that happens, input_dev->open() calls nvt_ts_start(), which will
unconditionally enable the regulators and IRQ without checking if
data->is_panel_follower restricts power control.

Should this check if the panel is currently prepared before forcing the
hardware on?

[ ... ]

> @@ -292,10 +305,11 @@ static int nvt_ts_probe(struct i2c_client *client)
>  	data->input =3D input;
>  	input_set_drvdata(input, data);
> =20
> -	error =3D devm_request_threaded_irq(dev, client->irq, NULL, nvt_ts_irq,
> +	error =3D devm_request_threaded_irq(dev, data->client->irq, NULL,
> +					  nvt_ts_irq,
>  					  IRQF_ONESHOT | IRQF_NO_AUTOEN |
>  						nvt_ts_irq_type[irq_type],
> -					  client->name, data);
> +					  data->client->name, data);
>  	if (error) {
>  		dev_err(dev, "failed to request irq: %d\n", error);
>  		return error;
>  	}

[Severity: Medium]
Does an error here leave data->input as a dangling pointer?

Because data->input =3D input was already assigned above, if
devm_request_threaded_irq() or input_register_device() fails, the function
returns an error but leaves data->input populated.

When the panel retries initialization in on_novatek_panel_prepared(), it ch=
ecks
if (!data->input). Since it's no longer NULL, it will skip initialization a=
nd
attempt to interact with an unregistered or broken input device.

Should data->input be set back to NULL in these error paths, or assigned
only after everything succeeds?

[ ... ]

> @@ -310,6 +324,76 @@ static int nvt_ts_probe(struct i2c_client *client)
>  	return 0;
>  }
> =20
> +static int on_novatek_panel_prepared(struct drm_panel_follower *follower)
> +{
> +	struct nvt_ts_data *data =3D container_of(follower, struct nvt_ts_data,=
 panel_follower);
> +	int ret;
> +
> +	/* Is this the first power on? */
> +	if (!data->input) {
> +		ret =3D nvt_ts_initial_power_on_and_register_inputdev(data);
> +		if (ret)
> +			return ret;

[Severity: High]
Does calling devm allocation functions from a retryable callback cause perm=
anent
errors on failure?

If nvt_ts_initial_power_on_and_register_inputdev() fails partway through
(e.g., an I2C timeout), it will return an error, but any devm resources it
already acquired (like devm_gpiod_get) will remain attached to the device.

When the panel power-on is retried later, it will execute again and attempt
to acquire the same GPIO and regulators, which will fail with -EBUSY.

Should these devm allocations be moved back to the probe function, or clean=
ed
up manually on error?

> +	}
> +
> +	guard(mutex)(&data->input->mutex);
> +
> +	if (input_device_enabled(data->input))
> +		nvt_ts_start(data->input);
> +
> +	return 0;
> +}
> +
> +static int on_novatek_panel_unpreparing(struct drm_panel_follower *follo=
wer)
> +{
> +	struct nvt_ts_data *data =3D container_of(follower, struct nvt_ts_data,=
 panel_follower);
> +
> +	guard(mutex)(&data->input->mutex);

[Severity: Critical]
Is it possible for data->input to be NULL here?

If nvt_ts_initial_power_on_and_register_inputdev() fails during
on_novatek_panel_prepared() (for instance, due to an I2C error), data->input
will remain NULL.

Since the follower is still registered, the DRM framework will eventually c=
all
on_novatek_panel_unpreparing(), and this guard(mutex) will dereference the =
NULL
pointer.

Should this check if data->input is valid before attempting to lock its mut=
ex?

[Severity: High]
Could the devm lifecycle ordering cause a use-after-free here during unbind?

When nvt_ts_probe() calls devm_drm_panel_add_follower(), it registers the
follower cleanup action. Later, on_novatek_panel_prepared() calls
nvt_ts_initial_power_on_and_register_inputdev(), which allocates the input
device via devm_input_allocate_device() and the IRQ via
devm_request_threaded_irq().

Because devres cleans up in LIFO order, on unbind:
1. The IRQ and input device are freed first.
2. The follower is removed, which invokes on_novatek_panel_unpreparing().

This means on_novatek_panel_unpreparing() will try to lock the mutex of an
already freed input device, and nvt_ts_stop() will attempt to disable an
already freed IRQ.

> +
> +	if (input_device_enabled(data->input))
> +		nvt_ts_stop(data->input);
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718135316.7854=
67-1-morf3089@gmail.com?part=3D1

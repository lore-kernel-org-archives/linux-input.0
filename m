Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793798192;
	b=RCU5AGczPiqjnFkLLd7jiW0NcZLO7nF7GmyVSIFxScOw7LfEKsq6ia7Vtk8ipOMm7zy2
	 kubEXGPhTnU/LS4DgO9AG34iVzJzxbOj409UIceUGfT/7NU/8MQX7GPUZh/mD55x2hsKt
	 a3TpF1c/h2MYatkmMdA6fBr2LC6GKXi8LDuxE3fckloyYZrydHGtrnj3sfMtNUmjGMfmB
	 ql3perBvHeD0ylnP0WlEHH4Ctf6sqFoqCvfQctVeZuiQETxJQLmnZhHoUeklcQgcyFv6t
	 9sohopze3y5LI7jvnu3/p4KrXCuDaPniT+zhWxo1f1qQIlT2P9sOA/ki1jMQkBZLHDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793798192;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lX/zgBlv6QrbW6SNvI2CtatQivqS2JnaDWpcK5hxq8g=;
	b=mlUP6wOUiMI9SzLOkP/KcxSjTZG8HTIIqx3uD1LLmH0erEh1DrC0aJlcCGqg8AeIM2bH
	 oxOiNLHAWSlnvK+AXkYeV2B/nbOSj+3wWKpu2QpgptdGlWEXolQkNz8lA6OKSvU6yrh/E
	 hUqH3To6253u5GJXbAzZrVFHF/P4vKLTx1QB1Kbo5oR5+W9FWhECErzViXzf5NfwxsOOp
	 r74j7OXaxOcGaOMSHuUXXYxVNzZs9o2dQXP/2OheGVNJGyibGKyHxNxxZDuUE6rGti02U
	 Q42d1HXVn7EBvvBpsYwbd9/25AumKH+BKqxW0Qkeh8TgB5dt9Ujzg0wkHgZdaFJ8SfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UYwk0pYI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4541E606A32E;
	Wed,  4 Nov 2026 13:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UYwk0pYI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C7131F00A1A;
	Wed,  4 Nov 2026 13:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793798191;
	bh=lX/zgBlv6QrbW6SNvI2CtatQivqS2JnaDWpcK5hxq8g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UYwk0pYItSevvjMym9EowmzfEevUTuw8026wYBZDd4IRWEOh3WiwaHP0m3DfZiy2d
	 426uHmmFV3tu+wydc1Mi7o2DXtA1i7BXmJmm+Ub1iRnMHTgyoJ16bkoNzafwvBhqzb
	 Aiy0lcR4qB3C7P7b3Jxd0d+H6rncb53bRd5UPebYcaBlNl1wEvxhMWyBnEJt5bwrIW
	 TL9BXrBjY2tYyfSeEkS+WICu/gNyjDoHPKYVUD+BsGDgAR42gwNdE2wvZbeX1pGyUc
	 85qTwNNElqYgOMsPOb3hTPifyF7nlcpSNkGRBF1okj0mdcN1shH2Hbfl3IFy7hifT2
	 GFhsenGEf2q8g==
Message-ID: <sashiko-outbox-197330@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 2/3] Input: edt-ft5x06 - Add wakeup gesture support
 for FT5452
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Heidelberg" <david@ixit.cz>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261104-ft5x06-double-tap-v1-2-5a1bd80449cc@ixit.cz>
References: <20261104-ft5x06-double-tap-v1-0-5a1bd80449cc@ixit.cz>
 <20261104-ft5x06-double-tap-v1-2-5a1bd80449cc@ixit.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 13:16:30 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] Input: edt-ft5x06 - in_gesture_mode desync across non-wakeup sus=
pend/resume
- [Medium] Input: edt-ft5x06 - IRQ race in edt_ft5x06_ts_set_gesture_mode()
- [Medium] Input: edt-ft5x06: missing input->mutex serialization in suspend=
 and resume
- [Low] Input: edt-ft5x06 - use __free(fwnode_handle) and explicit error re=
turns
--

commit 3e641160614ae8cff0e8f98270a632d8f526b6a7
Author: David Heidelberg <david@ixit.cz>

Input: edt-ft5x06 - Add wakeup gesture support for FT5452

This commit adds wakeup gesture support for the FocalTech FT5452 touchscreen
controller by parsing event child nodes from the device tree and reporting
detected gestures as key events on a separate input device. Gesture mode is
entered when the touchscreen input device is closed or during system suspend
when wakeup is enabled.

> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touch=
screen/edt-ft5x06.c
> index e69d64c3db2dd..fc810d68409cf 100644
> --- a/drivers/input/touchscreen/edt-ft5x06.c
> +++ b/drivers/input/touchscreen/edt-ft5x06.c
[ ... ]
> @@ -303,6 +362,11 @@ static irqreturn_t edt_ft5x06_ts_isr(int irq, void *=
dev_id)
>  	int i, type, x, y, id;
>  	int error;
> =20
> +	if (tsdata->in_gesture_mode) {
> +		edt_ft5x06_ts_report_gesture(tsdata);
> +		return IRQ_HANDLED;
> +	}
> +
[ ... ]
> @@ -1113,6 +1177,110 @@ static void edt_ft5x06_disable_regulators(void *a=
rg)
>  	regulator_disable(data->iovcc);
>  }
> =20
> +static int edt_ft5x06_ts_set_gesture_mode(struct edt_ft5x06_ts_data *tsd=
ata,
> +					  bool enable)
> +{
> +	int err;
> +
> +	if (enable) {\
> +		err =3D regmap_write(tsdata->regmap, GESTURE_REGISTER_MASK,
> +				   tsdata->gesture_mask);
> +		if (err)
> +			return err;
> +	} else {
> +		/* let the IRQ thread read the gesture that woke us first */
> +		synchronize_irq(tsdata->client->irq);
> +	}
> +
> +	err =3D regmap_write(tsdata->regmap, GESTURE_REGISTER_EN, enable);
> +	if (err)
> +		return err;
> +
> +	tsdata->in_gesture_mode =3D enable;
> +
> +	return 0;
> +}

[Severity: Medium]
Can edt_ft5x06_ts_set_gesture_mode() race with the threaded interrupt handl=
er
edt_ft5x06_ts_isr() while client->irq remains enabled?

When enable is true, synchronize_irq() is not called before switching modes.
An already-triggered touch interrupt in edt_ft5x06_ts_isr() can observe
tsdata->in_gesture_mode as true after GESTURE_REGISTER_EN is written and re=
ad
GESTURE_REGISTER_OUTPUT instead of touch coordinates. Conversely, if a
gesture interrupt fires right after the sleeping regmap_write() to
GESTURE_REGISTER_EN completes on the I2C bus, edt_ft5x06_ts_isr() can run
before tsdata->in_gesture_mode =3D enable is stored and read normal touch d=
ata
instead of GESTURE_REGISTER_OUTPUT.

When enable is false, synchronize_irq() is called before writing 0 to
GESTURE_REGISTER_EN while the interrupt line is still enabled. Once the
controller receives GESTURE_REGISTER_EN =3D 0 over I2C, it resumes normal t=
ouch
scanning before regmap_write() returns to clear tsdata->in_gesture_mode, so=
 a
touch interrupt in that window will see tsdata->in_gesture_mode as true in
edt_ft5x06_ts_isr() and call edt_ft5x06_ts_report_gesture().

> +
> +/*
> + * The touchscreen is opened and closed by userspace, either by opening =
and
> + * closing its event device or through the "inhibited" attribute. Closin=
g it
> + * is the moment to start looking for the wakeup gestures.
> + */
> +static int edt_ft5x06_ts_open(struct input_dev *input)
> +{
> +	struct edt_ft5x06_ts_data *tsdata =3D input_get_drvdata(input);
> +
> +	if (!tsdata->in_gesture_mode)
> +		return 0;
> +
> +	return edt_ft5x06_ts_set_gesture_mode(tsdata, false);
> +}
> +
> +static void edt_ft5x06_ts_close(struct input_dev *input)
> +{
> +	struct edt_ft5x06_ts_data *tsdata =3D input_get_drvdata(input);
> +	struct device *dev =3D &tsdata->client->dev;
> +	int err;
> +
> +	if (!device_may_wakeup(dev))
> +		return;
> +
> +	err =3D edt_ft5x06_ts_set_gesture_mode(tsdata, true);
> +	if (err)
> +		dev_warn(dev, "Failed to enter gesture mode: %d\n", err);
> +}
> +
> +/*
> + * The gestures detected in gesture mode are reported on their own input
> + * device, so that they still reach userspace when the touchscreen input
> + * device has been closed.
> + */
> +static int edt_ft5x06_ts_setup_gestures(struct edt_ft5x06_ts_data *tsdat=
a)
> +{
> +	struct device *dev =3D &tsdata->client->dev;
> +	struct input_dev *input =3D NULL;
> +	struct fwnode_handle *child;
> +	int err;
> +
> +	for (int i =3D 0; i < ARRAY_SIZE(edt_ft5x06_gestures); i++) {
> +		const struct edt_ft5x06_gesture *gesture =3D &edt_ft5x06_gestures[i];
> +		unsigned int code;
> +
> +		child =3D device_get_named_child_node(dev, gesture->node);
> +		if (!child)
> +			continue;
> +
> +		err =3D fwnode_property_read_u32(child, "linux,code", &code);
> +		fwnode_handle_put(child);
> +		if (err)
> +			return dev_err_probe(dev, err, "%s: failed to read linux,code\n",
> +					     gesture->node);
> +
> +		if (code =3D=3D KEY_RESERVED)
> +			continue;
> +
> +		if (!input) {
> +			input =3D devm_input_allocate_device(dev);
> +			if (!input)
> +				return -ENOMEM;
> +
> +			input->name =3D EDT_GESTURE_DEV_NAME;
> +			input->id.bustype =3D BUS_I2C;
> +		}
> +
> +		input_set_capability(input, EV_KEY, code);
> +		tsdata->gesture_code[i] =3D code;
> +		tsdata->gesture_mask |=3D BIT(gesture->id - GESTURE_ID_FIRST);
> +	}
> +
> +	if (!input)
> +		return 0;
> +
> +	tsdata->gesture_input =3D input;
> +
> +	return input_register_device(input);
> +}

[Severity: Low]
This isn't a bug, but in edt_ft5x06_ts_setup_gestures(), could child be
declared inside the loop using __free(fwnode_handle):

	struct fwnode_handle *child __free(fwnode_handle) =3D
		device_get_named_child_node(dev, gesture->node);

instead of calling fwnode_handle_put(child) manually?

Also, in both edt_ft5x06_ts_setup_gestures() and edt_ft5x06_ts_resume(),
which have multiple failure points, could the final calls to
input_register_device(input) and edt_ft5x06_ts_set_gesture_mode(tsdata, fal=
se)
check err and explicitly return 0 on success to match input subsystem style
conventions?

[ ... ]
> @@ -1349,8 +1530,13 @@ static int edt_ft5x06_ts_suspend(struct device *de=
v)
>  	struct gpio_desc *reset_gpio =3D tsdata->reset_gpio;
>  	int ret;
> =20
> -	if (device_may_wakeup(dev))
> -		return 0;
> +	if (device_may_wakeup(dev)) {
> +		/* the IRQ stays enabled, the PM core arms it as the wake source */
> +		if (!tsdata->gesture_input || tsdata->in_gesture_mode)
> +			return 0;
> +
> +		return edt_ft5x06_ts_set_gesture_mode(tsdata, true);
> +	}
> =20
>  	if (tsdata->suspend_mode =3D=3D EDT_PMODE_NOT_SUPPORTED)
>  		return 0;
> @@ -1391,8 +1577,18 @@ static int edt_ft5x06_ts_resume(struct device *dev)
>  	struct edt_ft5x06_ts_data *tsdata =3D i2c_get_clientdata(client);
>  	int ret =3D 0;
> =20
> -	if (device_may_wakeup(dev))
> -		return 0;
> +	if (device_may_wakeup(dev)) {
> +		if (!tsdata->in_gesture_mode)
> +			return 0;
> +
> +		guard(mutex)(&tsdata->input->mutex);
> +
> +		/* stays armed until the input device is opened again */
> +		if (!input_device_enabled(tsdata->input))
> +			return 0;
> +
> +		return edt_ft5x06_ts_set_gesture_mode(tsdata, false);
> +	}

[Severity: Medium]
What happens if the touchscreen input device is closed while wakeup is
enabled, and userspace then disables wakeup via sysfs before suspending?

1. edt_ft5x06_ts_close() calls edt_ft5x06_ts_set_gesture_mode(tsdata, true),
   which sets tsdata->in_gesture_mode =3D true.
2. Userspace disables wakeup via power/wakeup while the input device remains
   closed, so device_may_wakeup(dev) becomes false.
3. On system suspend, edt_ft5x06_ts_suspend() takes the non-wakeup path and
   hibernates or powers off the controller (asserting reset_gpio and disabl=
ing
   vcc/iovcc) without clearing tsdata->in_gesture_mode.
4. On resume, edt_ft5x06_ts_resume() takes the non-wakeup path and resets or
   wakes the controller back into normal touch mode while
   tsdata->in_gesture_mode remains true.

While the input device remains closed, any touch interrupt will be handled =
by
edt_ft5x06_ts_isr() as a gesture via edt_ft5x06_ts_report_gesture(). In
addition, if wakeup is later re-enabled before a subsequent suspend while t=
he
device is still closed, edt_ft5x06_ts_suspend() will see
tsdata->in_gesture_mode =3D=3D true and return 0 without programming
GESTURE_REGISTER_MASK or GESTURE_REGISTER_EN.

[Severity: Medium]
Should edt_ft5x06_ts_suspend() and the initial tsdata->in_gesture_mode check
in edt_ft5x06_ts_resume() also be serialized under tsdata->input->mutex?

edt_ft5x06_ts_open() and edt_ft5x06_ts_close() are called under
tsdata->input->mutex from input_open_device(), input_close_device(),
input_inhibit_device(), and input_uninhibit_device(). However,
edt_ft5x06_ts_suspend() reads tsdata->in_gesture_mode and calls
edt_ft5x06_ts_set_gesture_mode(tsdata, true) without holding
tsdata->input->mutex, and edt_ft5x06_ts_resume() checks
!tsdata->in_gesture_mode before acquiring guard(mutex)(&tsdata->input->mute=
x).

If a deferred file release via delayed_fput_work (evdev_release() ->
evdev_close_device() -> input_close_device()) or an in-kernel input handler
runs concurrently with edt_ft5x06_ts_suspend() or edt_ft5x06_ts_resume(), c=
an
concurrent calls to edt_ft5x06_ts_set_gesture_mode() interleave I2C writes =
to
GESTURE_REGISTER_MASK and GESTURE_REGISTER_EN and leave
tsdata->in_gesture_mode out of sync with the hardware?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-ft5x06-dou=
ble-tap-v1-0-5a1bd80449cc@ixit.cz?part=3D2

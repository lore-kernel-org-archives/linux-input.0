Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E50D1C3318
	for <linux-input@vger.kernel.org>; Sat,  6 Jun 2026 12:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780748000; cv=none; b=mBnYYLxcCF4ghqIjaDaqBQHKHg9qgUlXealUpKwuAGBozEElst5lD4QHGA2oXjJZqhSF/yKG5vclHF5jIjn8DJVCyLK9lGSFgtJgXT501MuMd7N8f/5lU/+8Y4+KtLs9VAdcKDoE8klLqs6yvrEwgYNCzfC/nihCh7KMgh0JE0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780748000; c=relaxed/simple;
	bh=t0jF6mG9X9weQ3C4d5vVJ0KUciqTXBqGlujTb79BYAg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=emymLA8masY4vmpY0EJ+k8TNvYln5sU+VlxXR02XYkpU4aF8f4Qvl9Tc+pHhFcDOMgUJgf3En7ypy+0cdQxYGfAJ3uNVwJxRcqNWK2LA2bE8ykViuh9zUIXWkI6RDMz+AvaM7AtBKEKxmDrO4jvYt1IuDoLsTvTzhhKYvHC3zgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHuIacaG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHuIacaG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58171F00898;
	Sat,  6 Jun 2026 12:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780747999;
	bh=n9dmChT+teKF4wsvPGMI2l/R4XLGtoD4IfytNOKEfps=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oHuIacaG/vDWnFwV0HdXlhwm19ukzMW9DWzSzpiEfi6CTKhy86RXmLzsVBE3Vzqwl
	 y7B0oXeyJJWCyzSN1byEva+FLLewDoJ1pU/8v6Dm0enuaDpdLHrPoUhffvwhLM0Zh1
	 UwOF4z3azTJJdr4cCFTQPwN8dUo3zScvLRda+kkBDW8mkwAZ9YvSlAZeg5IQ74Fyi4
	 r63A2jWP6rAc2+OVJ62X+G09VAeP8U6eOqjA6Zy/N93f7FQ5Gt+MSsj+ntdKBDD0bG
	 9ynk8b0UIsowJJOp4GqWSq0FduUy2Na2Wq/0xtzcofUzKbMViZguw9rkTnY0vjWmc0
	 FqsxE7LcAcMvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 9/9] iio: accel: hid-sensor-accel-3d: Fix race between
 callback registration and device exposure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Chitroda" <sanjayembeddedse@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260606-5-june-hid-iio-race-fixes-v1-9-27a848c5758f@gmail.com>
References: <20260606-5-june-hid-iio-race-fixes-v1-9-27a848c5758f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 12:13:18 +0000
Message-Id: <20260606121318.D58171F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The patch introduces a Use-After-Free / NULL Pointer Dereference i=
n the `probe` error path by registering the sensor hub callback before IIO =
device registration.

Pre-existing issues:
- [High] Reordering IIO device unregistration before callback removal exace=
rbates a Use-After-Free vulnerability during driver teardown.
- [High] Reordering IIO device unregistration before callback removal widen=
s a severe data race leading to linked list corruption.
--

commit 538b7bb72b2f4da6c8de1d51d2852e714b2a2bcc
Author: Sanjay Chitroda <sanjayembeddedse@gmail.com>

iio: accel: hid-sensor-accel-3d: Fix race between callback registration and=
 device exposure

The driver registers the IIO device before completing sensor hub
callback registration and unregisters callbacks while the IIO device
is still exposed during teardown.

> diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/=
hid-sensor-accel-3d.c
> index 2bf05ab5235ef..c000e001c0015 100644
> --- a/drivers/iio/accel/hid-sensor-accel-3d.c
> +++ b/drivers/iio/accel/hid-sensor-accel-3d.c
[ ... ]
> @@ -399,13 +393,19 @@ static int hid_accel_3d_probe(struct platform_devic=
e *pdev)
>  					&accel_state->callbacks);
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

[Severity: High]
Does this new error path expose asynchronous event handlers to a
use-after-free or NULL pointer dereference?

When sensor_hub_register_callback() succeeds, it allows the hardware to
immediately dispatch events to accel_3d_proc_event(). If iio_device_registe=
r()
then fails, the code jumps to error_remove_callback.

While sensor_hub_remove_callback() removes the callback from the list, it
does not appear to synchronize with or wait for concurrently running handle=
rs.
When probe() returns, devres frees the indio_dev structure and the driver
core clears drvdata.

Any concurrently executing accel_3d_proc_event() might then fetch the clear=
ed
drvdata (causing a NULL pointer dereference) or access the freed indio_dev
(causing a use-after-free).

>  	}
> =20
>  	return ret;
> =20
> -error_iio_unreg:
> -	iio_device_unregister(indio_dev);
> +error_remove_callback:
> +	sensor_hub_remove_callback(hsdev, hsdev->usage);
>  error_remove_trigger:
>  	hid_sensor_remove_trigger(indio_dev, &accel_state->common_attributes);
>  	return ret;
> @@ -418,8 +418,8 @@ static void hid_accel_3d_remove(struct platform_devic=
e *pdev)
>  	struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
>  	struct accel_3d_state *accel_state =3D iio_priv(indio_dev);
> =20
> -	sensor_hub_remove_callback(hsdev, hsdev->usage);
>  	iio_device_unregister(indio_dev);

[Severity: High]
This is a pre-existing issue, but does moving iio_device_unregister() before
sensor_hub_remove_callback() widen a data race leading to linked list
corruption?

By calling iio_device_unregister() first, the sensor callback remains fully
active and eligible to receive new events during IIO teardown.

Hardware events trigger accel_3d_proc_event(), which calls
iio_push_to_buffers(). This traverses the buffer_list without holding locks
using list_for_each_entry(). Concurrently, iio_device_unregister() calls
iio_disable_all_buffers(), which modifies the same buffer_list.

Can this concurrent list modification corrupt the traversal pointer,
potentially causing an infinite loop or a panic?

> +	sensor_hub_remove_callback(hsdev, hsdev->usage);

[Severity: High]
This is a pre-existing issue, but does this reordering exacerbate a
use-after-free vulnerability during driver teardown?

sensor_hub_remove_callback() unlinks the callback from the internal list
without synchronizing with currently executing event handlers. When the
remove function returns, devres will immediately free indio_dev.

Previously, the slow iio_device_unregister() call was executed after callba=
ck
removal, providing an implicit grace period for in-flight events to finish.
By moving it before callback removal, this delay is eliminated, which might
cause any concurrent event handler to dereference the freed indio_dev
structure more reliably.

>  	hid_sensor_remove_trigger(indio_dev, &accel_state->common_attributes);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260606-5-june-hid=
-iio-race-fixes-v1-0-27a848c5758f@gmail.com?part=3D9

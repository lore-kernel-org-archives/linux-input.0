Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7501A704B
	for <linux-input@vger.kernel.org>; Thu,  6 Aug 2026 12:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786020058; cv=none; b=p23cyw9uwEnVdfFzWdQOBd18s5Q4uoPrY4GIPMkmRkZCmR2QRfem7piOrkS7I7BBlDRa1rN2bKResGQ7Fe/JfZKbDgzfF0uVI5732n6iHFT9KCGh8kXqDVPTUMaAs5UQDxbappHDGSU/HH0Z0F7WCkldCWNqUMcWhEwKxgwcl9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786020058; c=relaxed/simple;
	bh=qi4VRN6DWCw8AGQdjcBDgSwk/SYmgqYHknk8lElq7uk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gN5jmO996tKDEkQWalQSdQV63davvfw1AL2+kyMNosRfofFqGQJr9PeHZFmFiGkcXZukDbFe6w8VrRZIJN4XCLjatH5izXULEFc1hR6WQVc2AE7IXc3xhf/vT2XawYQQDWorDVneRe2kNDtuTMPlPDwU6KmQvnc/CR5c2rjAM2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSPVBaFd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSPVBaFd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EAAD1F000E9;
	Thu,  6 Aug 2026 12:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786020056;
	bh=ccaFfENfsc1OUmW3FEgE4zJ9zsSw/pqVPZ8ui9TebCs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NSPVBaFd5TxzonKA4Rke4iuU0h/Po5wS8IkejejbC0BnM22te3t508+cbe3DKc5zY
	 w54PyPk3t5l9CbgUMOnMZKGbR8NyOHqalcIhHV6jaKMpT3b6mVw7DXFStSdIuduUB0
	 ccPDvXRgUAZPFZPqhAYqwxSzLHeqTBMz7StzJk4W5EoGNu/96taKyYBNU77cVgZWmi
	 e0EV/VbMkrlutAQ5JoNJ6/lsege4XBLE2nsJBeRT2sEQlKTsN2tuOxQhcYRLqgifK0
	 LawI+ppLOZQmKl8MjKMjhfRxDyCvwFI5TMhiT3BL8BszW4Pp1wCmXsPxOxQX4SAiWA
	 hXwu15b22u0fQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 11/13] iio: orientation: hid-sensor-rotation: convert
 probe and teardown to devm-managed resources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Chitroda" <sanjayembeddedse@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260806-28-apr-iio-redundant-argument-v5-temp-v5-11-f1f92c1d830f@gmail.com>
References: <20260806-28-apr-iio-redundant-argument-v5-temp-v5-0-f1f92c1d830f@gmail.com>
 <20260806-28-apr-iio-redundant-argument-v5-temp-v5-11-f1f92c1d830f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 12:40:55 +0000
Message-Id: <20260806124056.4EAAD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Race condition between sensor_hub_raw_event() and driver unbind le=
ads to Use-After-Free.
--

--- Patch [11]: [PATCH v5 11/13] iio: orientation: hid-sensor-rotation: con=
vert probe and teardown to devm-managed resources ---
commit 3160b0601a08ac2a6833abd2c964d88a54dc98cc
Author: Sanjay Chitroda <sanjayembeddedse@gmail.com>

iio: orientation: hid-sensor-rotation: convert probe and teardown to devm-m=
anaged resources

This patch converts the HID IIO driver resource management to use
devm-managed helpers. It transitions HID trigger setup, IIO registration,
and sensor hub callback resources to devm APIs, simplifying probe error
handling and removing the remove callback.

> diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/=
orientation/hid-sensor-rotation.c
> index 67ffa4f4075e3..3ef89d66a88f9 100644
> --- a/drivers/iio/orientation/hid-sensor-rotation.c
> +++ b/drivers/iio/orientation/hid-sensor-rotation.c
[ ... ]
> @@ -330,38 +331,14 @@ static int hid_dev_rot_probe(struct platform_device=
 *pdev)
>  	rot_state->callbacks.send_event =3D dev_rot_proc_event;
>  	rot_state->callbacks.capture_sample =3D dev_rot_capture_sample;
>  	rot_state->callbacks.pdev =3D pdev;
> -	ret =3D sensor_hub_register_callback(hsdev, hsdev->usage,
> -					   &rot_state->callbacks);
> +	ret =3D devm_sensor_hub_register_callback(dev, hsdev, hsdev->usage,
> +						&rot_state->callbacks);

[Severity: High]
This isn't a bug introduced by this patch, but does removing the callback
registration here leave us vulnerable to a use-after-free during unbind?

When a user unbinds the driver or an error occurs during probe, devres begi=
ns
cleanup and calls sensor_hub_remove_callback().

However, this function does not appear to synchronize with concurrent reade=
rs:

drivers/hid/hid-sensor-hub.c:sensor_hub_remove_callback() {
    ...
    spin_lock_irqsave(&pdata->dyn_callback_lock, flags);
    ...
    spin_unlock_irqrestore(&pdata->dyn_callback_lock, flags);
    return 0;
}

Because it doesn't take pdata->lock to wait for executing callbacks, a
concurrent HID event running in sensor_hub_raw_event() can hold a pointer to
the callback.

Devres will then proceed to free the IIO device memory (indio_dev and
rot_state).

If the concurrent event then executes callback->capture_sample(), could it
access the freed memory?

drivers/iio/orientation/hid-sensor-rotation.c:dev_rot_capture_sample() {
    struct iio_dev *indio_dev =3D platform_get_drvdata(priv);
    struct dev_rot_state *rot_state =3D iio_priv(indio_dev);
    ...
}

>  	if (ret) {
>  		dev_err(&pdev->dev, "callback reg failed\n");
> -		goto error_remove_trigger;
> -	}
> -
> -	ret =3D iio_device_register(indio_dev);
> -	if (ret) {
> -		dev_err(&pdev->dev, "device register failed\n");
> -		goto error_remove_callback;
> +		return ret;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806-28-apr-iio=
-redundant-argument-v5-temp-v5-0-f1f92c1d830f@gmail.com?part=3D11

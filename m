Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793400453;
	b=FE5vWyWP32a2HAN5YtT0kqElqO6yH1dFg5lkP0+bRZEY/01S12LT8unZ9EuzqMgmkTua
	 1v/6PP0HjgrbQBNRxNtb2ZlELCzOkFN/v8rhBr8+NfrW2y/kPc3GXiVaVtVYMbSXuOOzk
	 jciYtwDyR6VwS5fhy4Be+SL/OGCz3P3V6OxF8V38cANxmM6hIJyw69wKiHXMo6XZah/lU
	 S1EoMa05tIGLcnWTiPrw8RBBEaZXA4NoiOM+AqS26UcVxbL/bFQgbcoOFzTddUMMSRBq9
	 gHpmrIFZWDz1Zh8bHHpVFrpKRiCfzJ6GquUUXWgmYQWwQHuMgRH5IhO4bRnRHi+V7jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793400453;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZbAZ8t+zP+UeJhIWs9txhpM7bLqTHuzaj/UTsU1m4uE=;
	b=qvtPUUPZVx5X9IHJyakYtQ6uEo/f/1hTRrPhGJZofvMHWUqlYYxMruqDoCTrAHyYC1kk
	 1oeYmbCCnjfnjHt8Ui8dgaZ54qpwEyfVzcUYLrqdwNIi2wGyl/o7/GZ9habyizxgz7U7m
	 np/vvDI48IxeGxRsJhDS/u/tXVVTVuxt3i4ML4u+nELD39MEdCYXAi79Ixac/4ptRpGH1
	 VPSSEI0ZHjBeFjt56IFInxIKMT87omuhKfyI3O3iAbBjs5xpqdynlB0WTSumYmTALu7Pe
	 D87wQgBBRQVLpk8E/fe1yn9Son62C+risTCZmMh/O0kplwr0MRwTyKr1e35HhIHciRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nfCwuYRC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD021606A324;
	Fri, 30 Oct 2026 22:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nfCwuYRC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB381F0093A;
	Fri, 30 Oct 2026 22:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793400452;
	bh=ZbAZ8t+zP+UeJhIWs9txhpM7bLqTHuzaj/UTsU1m4uE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nfCwuYRC4i4n8vHThr7q37QVHmhBNpAdvDL0Yxr2ZekHWFRxRVdj4vNRwVtFDprpv
	 VH7HLvnIskB42Q+8RQ1eUdflFjvN8/vHRsyHNyEGXgl7U9x/4WDJ7ZPC2FhDftigJl
	 D00v12nIse17hn8oYFcoNPU/QsHyA+jsS6ULEihSkwPPuNq4kNy1KxSX9EMwDBbJqY
	 iq5FczhyObLVAVZMEHFEbbWYP9ExeqBQT8AIvLUMLaLluKQdWaNLAAhs7Imz4KHSsi
	 ynCYyyNeAUGm2FgIaKM8co7ewfTHT/k/b+FmX/toCUDXWxD3/vv2vBpuJDuw0vKY2D
	 O3BrROSAhJWQQ==
Message-ID: <sashiko-outbox-191594@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/15] HID: ft260: i2c: silence sysfs store
 big-numbers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: linux-input@vger.kernel.org, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261030223637.86907-6-michael.zaidman@gmail.com>
References: <20261030223637.86907-1-michael.zaidman@gmail.com>
 <20261030223637.86907-6-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 22:47:31 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] HID: ft260: kfree() of dev before devres unregisters gpio_chip
--

commit 6921079604110581f3bdc063a11efc4ea28f578a
Author: Michael Zaidman <michael.zaidman@gmail.com>

HID: ft260: i2c: silence sysfs store big-numbers

This series adds UART and GPIO support to the FT260 HID driver, adjusts the
I2C read timeout, and updates FT260_ATTR_STORE to return the sysfs write by=
te
count and convert 16-bit attributes to little endian.

> diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
> index 64c9c940db46e..d2c5c9ed79276 100644
> --- a/drivers/hid/hid-ft260.c
> +++ b/drivers/hid/hid-ft260.c

[ ... ]

> @@ -1043,53 +2307,35 @@ static int ft260_probe(struct hid_device *hdev, c=
onst struct hid_device_id *id)
>  		 version.chip_code[0], version.chip_code[1],
>  		 version.chip_code[2], version.chip_code[3]);
> =20
> -	ret =3D ft260_is_interface_enabled(hdev);
> -	if (ret <=3D 0)
> +	ret =3D ft260_get_interface_type(dev, &cfg);
> +	if (ret <=3D FT260_IFACE_NONE)
>  		goto err_hid_close;
> =20
> -	hid_info(hdev, "USB HID v%x.%02x Device [%s] on %s\n",
> -		hdev->version >> 8, hdev->version & 0xff, hdev->name,
> -		hdev->phys);
> -
> -	hid_set_drvdata(hdev, dev);
> -	dev->hdev =3D hdev;
> -	dev->adap.owner =3D THIS_MODULE;
> -	dev->adap.class =3D I2C_CLASS_HWMON;
> -	dev->adap.algo =3D &ft260_i2c_algo;
> -	dev->adap.quirks =3D &ft260_i2c_quirks;
> -	dev->adap.dev.parent =3D &hdev->dev;
> -	snprintf(dev->adap.name, sizeof(dev->adap.name),
> -		 "FT260 usb-i2c bridge");
> -
> -	mutex_init(&dev->lock);
> -	spin_lock_init(&dev->read_lock);
> -	init_completion(&dev->wait);
> -
> -	ret =3D ft260_xfer_status(dev, FT260_I2C_STATUS_BUS_BUSY);
> -	if (ret)
> -		ft260_i2c_reset(hdev);
> -
> -	i2c_set_adapdata(&dev->adap, dev);
> -	ret =3D i2c_add_adapter(&dev->adap);
> -	if (ret) {
> -		hid_err(hdev, "failed to add i2c adapter\n");
> -		goto err_hid_close;
> -	}
> -
> -	ret =3D sysfs_create_group(&hdev->dev.kobj, &ft260_attr_group);
> -	if (ret < 0) {
> -		hid_err(hdev, "failed to create sysfs attrs\n");
> -		goto err_i2c_free;
> +	if (ret =3D=3D FT260_IFACE_I2C) {
> +		ret =3D ft260_i2c_probe(dev, &cfg);
> +		if (ret)
> +			goto err_hid_close;
> +	} else {
> +		ret =3D ft260_uart_probe(dev, &cfg);
> +		if (ret)
> +			goto err_uart;
>  	}
> =20
>  	return 0;
> =20
> -err_i2c_free:
> -	i2c_del_adapter(&dev->adap);
> +err_uart:
> +	hid_hw_close(hdev);
> +	hid_hw_stop(hdev);
> +	tty_port_put(&dev->port);
> +	return ret;
> +
>  err_hid_close:
>  	hid_hw_close(hdev);
>  err_hid_stop:
>  	hid_hw_stop(hdev);
> +hid_fail:
> +	kfree(dev);
> +alloc_fail:
>  	return ret;
>  }
> =20
> @@ -1100,25 +2346,47 @@ static void ft260_remove(struct hid_device *hdev)
>  	if (!dev)
>  		return;
> =20
> -	sysfs_remove_group(&hdev->dev.kobj, &ft260_attr_group);
> -	i2c_del_adapter(&dev->adap);
> +	if (dev->iface_type =3D=3D FT260_IFACE_UART) {
> +		timer_delete_sync(&dev->wakeup_timer);
> +		cancel_work_sync(&dev->wakeup_work);
> +		tty_port_unregister_device(&dev->port, ft260_tty_driver,
> +					   dev->index);
> +		ft260_uart_port_remove(dev);
> +		if (dev->iface_id =3D=3D 0)
> +			sysfs_remove_group(&hdev->dev.kobj, &ft260_attr_group);
> +	} else {
> +		sysfs_remove_group(&hdev->dev.kobj, &ft260_attr_group);
> +		i2c_del_adapter(&dev->adap);
> +	}
> =20
>  	hid_hw_close(hdev);
>  	hid_hw_stop(hdev);
> +
> +	if (dev->iface_type =3D=3D FT260_IFACE_UART)
> +		ft260_uart_port_put(dev);
> +	else
> +		kfree(dev);
>  }

[Severity: High]
As reported by Sashiko on v1 [1], in drivers/hid/hid-ft260.c, ft260_probe()
allocates struct ft260_device *dev using kzalloc_obj(*dev, GFP_KERNEL), whi=
le
ft260_gpio_init() registers the GPIO chip with devres on hdev->dev:

drivers/hid/hid-ft260.c:ft260_gpio_init() {
	...
	ret =3D devm_gpiochip_add_data(&hdev->dev, dev->gc, dev);
	...
}

In the HID core (drivers/hid/hid-core.c), __hid_device_probe() and
hid_device_remove() only release the devres group via devres_release_group()
after hdrv->probe() or hdrv->remove() returns.

When ft260_remove() runs (or when sysfs_create_group() fails after
ft260_gpio_init() in ft260_i2c_probe() or ft260_uart_probe() and unwinds
through ft260_probe()), dev is freed via kfree(dev) or tty_port_put() /
ft260_uart_port_put() before the devm-managed gpio_chip is unregistered.

Can a concurrent GPIO operation (such as ft260_gpio_get(),
ft260_gpio_get_direction(), ft260_gpio_set(), or ft260_gpio_direction_set())
retrieve the freed dev pointer via gpiochip_get_data(gc) during this window
and cause a use-after-free?

[1] https://lore.kernel.org/r/20260822213941.98882-6-michael.zaidman@gmail.=
com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030223637.8690=
7-1-michael.zaidman@gmail.com?part=3D5

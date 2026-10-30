Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793400535;
	b=tbjL9QbC5mnQpvlsimc8Nb3n295wua19BssxLgkVidBGH5IZVqpwNiQiPuZxfliXBDYM
	 SjnEJlSWCRwkXm4fuv0jUD93zAXrYJoqQ+0/1oHL1FBmEhc9OdBl8uIi/KZAUFxvPi4dL
	 A3O8VNO2STFkgDDYdRP2udlGpmu8On/dhzJP8IHeUIXg5G/Ruc4q4/kuH/L40SJd51MZ9
	 uZhK5WkApN7De5mGzCa0RShg+j3SSFO9ZXZnGwdlaEjR5ZeFXUKoNVjb5rb9xWFm4+/4B
	 edd+Ps0K3yWZMZiMSZMkq8Ptl5/o5IT0WiPSQWizh0fpTWs7pfyGn4nFV34iA+vPYtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793400535;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DfIYTJnsdA/ZjFgKC/H21fj9W/1Lbge082hDxqIRrRM=;
	b=cc0ri9bZ3euIH5MbNAJBAqSgHZcIf6voT0Y21kmBhQfnnrFMOcDXf/cAg4pNk4QuE0VB
	 1fWNANIjCNI1Y1v5rx2rZxNlFHY8godNEZIFjsNCiMjkcFvWVQofoGrEu9J/D9466upfy
	 KPgr8MGou1E8e8n89hCx3n5U+o3T+XVk87lBhgjGu82BaCyc9y4U2ZWw/+7KoOagOXNB5
	 nGXWCCahYPnPwZ6ux2oe7i4ZBu9isYMcR6x46uiiRmEilhSb3Whh/94mMnFlSCt5YqZNc
	 A7TFHAru4FrASVuPYmCAjbRX1lV1lhyFVTk+Dr+PWKPG5TZYIUniJRoa5ZQfPySSBIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cyynYT+o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B616C606A31A;
	Fri, 30 Oct 2026 22:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cyynYT+o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11EEE1F00A02;
	Fri, 30 Oct 2026 22:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793400534;
	bh=DfIYTJnsdA/ZjFgKC/H21fj9W/1Lbge082hDxqIRrRM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cyynYT+oFylJa5x9PAVFBqpM4rnW2Hd5QaMqQdNJmTs7kdmqWJhjM0/+1ibdQ0GVa
	 Xh9Dsc5HtsS3oZgnRtCowCiB8Fbac3zg+Z0uSkIiVLt1xOwn0VJQ5PbHuJ0Jy2LCcb
	 1+LICu/Y8r7GmN/UBTmviO5ZePAFVz5JnncvsJk7bZMZaO9G19/9h8QxMOyPJAybow
	 nD/fBzWARUXvkn6LgQTX+fHsuG+6pxlNkBqKSMLDi+UgzUuYOYq2oXMi/8O8SyXc8J
	 /lfWDlZDqc5hhGUI5P/R3fpzu7REhZFnperWU6Z+1cKZoKbP5orLDGwtLJPR+D4WHn
	 eKl9ep4soi5rw==
Message-ID: <sashiko-outbox-191599@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/15] HID: ft260: group sysfs attrs per HID
 interface
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: linux-input@vger.kernel.org, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261030223637.86907-10-michael.zaidman@gmail.com>
References: <20261030223637.86907-1-michael.zaidman@gmail.com>
 <20261030223637.86907-10-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 22:48:53 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] HID: ft260: use-after-free of dev before devres removes gpio_chip
- [High] HID: ft260: ft260_probe() returns 0 after freeing dev on unknown c=
hip_mode
- [High] HID: ft260: missing cancel_work_sync() on error path in ft260_uart=
_probe()
--

commit cc1ccb7f6680b5d859734f13042a3297303e344a
Author: Michael Zaidman <michael.zaidman@gmail.com>

HID: ft260: group sysfs attrs per HID interface

This commit splits the single FT260 sysfs attribute group into separate
per-interface attribute groups based on the active chip mode (I2C-only,
dual-mode, or UART-only) so each HID interface only exposes relevant
attributes.

> diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
> index 4106066b6a893..dca0250f2c259 100644
> --- a/drivers/hid/hid-ft260.c
> +++ b/drivers/hid/hid-ft260.c

[ ... ]

> @@ -2275,7 +2299,16 @@ static int ft260_i2c_probe(struct ft260_device *de=
v,
>  		if (ret)
>  			goto err_i2c_free;
> =20
> -		ret =3D sysfs_create_group(&hdev->dev.kobj, &ft260_attr_group);
> +		ret =3D sysfs_create_group(&hdev->dev.kobj,
> +					 &ft260_i2c_chip_mode_1_attr_group);
> +		if (ret < 0) {
> +			hid_err(hdev, "failed to create sysfs attrs\n");
> +			goto err_i2c_free;
> +		}
> +	} else if (cfg->chip_mode =3D=3D FT260_MODE_ALL ||
> +		   cfg->chip_mode =3D=3D FT260_MODE_BOTH) {
> +		ret =3D sysfs_create_group(&hdev->dev.kobj,
> +					 &ft260_i2c_chip_mode_0_3_attr_group);
>  		if (ret < 0) {
>  			hid_err(hdev, "failed to create sysfs attrs\n");
>  			goto err_i2c_free;

[Severity: High]
What happens in ft260_probe() -> ft260_get_interface_type() if the device
reports a cfg->chip_mode value outside 0..3 in the FT260_SYSTEM_SETTINGS
feature report?

In drivers/hid/hid-ft260.c, ft260_get_interface_type() initializes ret to 0
via ft260_get_system_config() and switches on cfg->chip_mode without a
default case:

drivers/hid/hid-ft260.c:ft260_get_interface_type() {
	ret =3D ft260_get_system_config(hdev, cfg);
	if (ret < 0)
		return ret;
	...
	switch (cfg->chip_mode) {
	case FT260_MODE_ALL:
	case FT260_MODE_BOTH:
		if (dev->iface_id =3D=3D 1)
			ret =3D FT260_IFACE_UART;
		else
			ret =3D FT260_IFACE_I2C;
		break;
	case FT260_MODE_UART:
		ret =3D FT260_IFACE_UART;
		break;
	case FT260_MODE_I2C:
		ret =3D FT260_IFACE_I2C;
		break;
	}

	return ret;
}

When cfg->chip_mode does not match any case, ft260_get_interface_type()
returns 0 (FT260_IFACE_NONE). In ft260_probe(), hid_set_drvdata(hdev, dev)
has already been called, and the check:

	ret =3D ft260_get_interface_type(dev, &cfg);
	if (ret <=3D FT260_IFACE_NONE)
		goto err_hid_close;

jumps to err_hid_close with ret =3D=3D 0. That unwind path calls kfree(dev)=
 and
returns 0 to the HID core while leaving hid_get_drvdata(hdev) pointing to
the freed struct ft260_device, which can then be dereferenced and freed a
second time in ft260_remove().

Should ft260_get_interface_type() return -EINVAL in a default branch when
cfg->chip_mode is unrecognized?

> @@ -2341,12 +2374,14 @@ static int ft260_uart_probe(struct ft260_device *=
dev,
>  	cfg->uart_mode =3D FT260_UART_CFG_FLOW_CTRL_NONE;
> =20
>  	if (dev->chip_mode & FT260_MODE_UART ||
> -	    dev->chip_mode =3D=3D FT260_MODE_ALL) {
> +	    dev->chip_mode =3D=3D FT260_MODE_ALL ||
> +	    dev->chip_mode =3D=3D FT260_MODE_BOTH) {
>  		ret =3D ft260_gpio_init(dev, cfg);
>  		if (ret)
>  			goto err_hid_report;
> =20
> -		ret =3D sysfs_create_group(&hdev->dev.kobj, &ft260_attr_group);
> +		ret =3D sysfs_create_group(&hdev->dev.kobj,
> +					 &ft260_uart_chip_mode_0_2_3_attr_group);
>  		if (ret < 0) {
>  			hid_err(hdev, "failed to create sysfs attrs\n");
>  			goto err_hid_report;

[Severity: High]
As reported by Sashiko on v1 [1], if ft260_hid_feature_report_set(),
ft260_gpio_init(), or sysfs_create_group() fails in ft260_uart_probe() and
jumps to err_hid_report, can dev->wakeup_work still be running or pending
when dev is torn down?

In ft260_uart_probe(), tty_port_register_device_attr() exposes the tty
device before those calls complete. If userspace opens the tty port during
that window, ft260_uart_port_activate() or ft260_uart_change_speed() arms
dev->wakeup_timer, and ft260_uart_start_wakeup() schedules dev->wakeup_work.

However, the error path in ft260_uart_probe() only deletes the timer without
cancelling the work item:

err_hid_report:
	tty_port_unregister_device(&dev->port, ft260_tty_driver, dev->index);
err_register_tty:
	ft260_uart_port_remove(dev);
err_port:
	timer_delete_sync(&dev->wakeup_timer);
	return ret;

ft260_probe() then stops the HID hardware and drops the port reference via
tty_port_put(&dev->port), which can free dev while ft260_uart_do_wakeup() is
still executing. Should the error unwind also call
cancel_work_sync(&dev->wakeup_work), matching ft260_remove()?

> @@ -2464,11 +2499,18 @@ static void ft260_remove(struct hid_device *hdev)
>  					   dev->index);
>  		ft260_uart_port_remove(dev);
>  		if (dev->chip_mode & FT260_MODE_UART ||
> -		    dev->chip_mode =3D=3D FT260_MODE_ALL)
> -			sysfs_remove_group(&hdev->dev.kobj, &ft260_attr_group);
> +		    dev->chip_mode =3D=3D FT260_MODE_ALL ||
> +		    dev->chip_mode =3D=3D FT260_MODE_BOTH)
> +			sysfs_remove_group(&hdev->dev.kobj,
> +					   &ft260_uart_chip_mode_0_2_3_attr_group);
>  	} else {
>  		if (dev->chip_mode =3D=3D FT260_MODE_I2C)
> -			sysfs_remove_group(&hdev->dev.kobj, &ft260_attr_group);
> +			sysfs_remove_group(&hdev->dev.kobj,
> +					   &ft260_i2c_chip_mode_1_attr_group);
> +		else if (dev->chip_mode =3D=3D FT260_MODE_ALL ||
> +			 dev->chip_mode =3D=3D FT260_MODE_BOTH)
> +			sysfs_remove_group(&hdev->dev.kobj,
> +					   &ft260_i2c_chip_mode_0_3_attr_group);
>  		i2c_del_adapter(&dev->adap);
>  	}

[Severity: High]
As reported by Sashiko on v1 [2], can freeing dev before devres unregisters
dev->gc cause a use-after-free in the GPIO callbacks?

In ft260_gpio_init(), the GPIO chip is registered with devres on &hdev->dev
and given dev as its driver data:

	ret =3D devm_gpiochip_add_data(&hdev->dev, dev->gc, dev);

However, dev itself is manually allocated with kzalloc_obj(*dev, GFP_KERNEL)
in ft260_probe(). In the HID core (__hid_device_probe() and
hid_device_remove()), devres_release_group() only runs after the driver's
probe or remove callback returns:

1. In ft260_i2c_probe() and ft260_uart_probe(), if sysfs_create_group()
   fails after ft260_gpio_init() succeeds, ft260_probe() closes and stops
   hdev and frees dev via kfree(dev) or tty_port_put(&dev->port) before
   returning to __hid_device_probe().

2. In ft260_remove(), hid_hw_close(hdev), hid_hw_stop(hdev), and
   ft260_uart_port_put(dev) or kfree(dev) all execute before ft260_remove()
   returns to hid_device_remove().

Until devres_release_group() unregisters dev->gc, any concurrent GPIO
access (such as ft260_gpio_get(), ft260_gpio_set(), or
ft260_gpio_direction_output()) can retrieve the already-freed struct
ft260_device pointer via gpiochip_get_data(gc). Should the gpio_chip be
explicitly unregistered before stopping the HID hardware and freeing dev in
both ft260_remove() and the probe error paths?

[1] https://lore.kernel.org/r/20260822213941.98882-10-michael.zaidman@gmail=
.com
[2] https://lore.kernel.org/r/20260822213941.98882-10-michael.zaidman@gmail=
.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030223637.8690=
7-1-michael.zaidman@gmail.com?part=3D9

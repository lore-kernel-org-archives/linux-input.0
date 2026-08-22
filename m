Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91925390992
	for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 21:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787435661; cv=none; b=PdzKzbzaUkSK9khkrHeTgrb/xeVzMomH+sEaPMXG5Zfgg+c6R0AVQsI8EXhSddDSSIqP0+CBxbfXDpimzhcNK+0NgjQy+x5zwmjrA94ZFIoPBN/eEdcLBtMFUbjz7Qi3H7Rkui6qO6JLALwGx6TOGlu1d0wrPjlV6NFJ95QO/Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787435661; c=relaxed/simple;
	bh=aSNHRFWMMS5pvFfPhkgbaUPwBrgZxbBQ/gBG56G4ExQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LaXnsisIXUF9E3jN72BTnvVjwKAGJF2I77IzFpZifg4HYL7fFV7LVVEtP9O0v7bZyyeRzjWY65F+Mm8GdObDGfTLbAqKH2bskxCPqZynGX2WgnCqCJbG0iLRLZlldVlA7G9QSd+gDHwN77kr7y8nArg4Lzx7soUOvLeqin2bBtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJmYUV9R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJmYUV9R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B781F000E9;
	Sat, 22 Aug 2026 21:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787435658;
	bh=SHLnWt7WST24Ebj2p5MU+o4Ukxl5JNGDPNgMIlTy67c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KJmYUV9RIJdw60ENEtLUjVt3+6jBkDOU/d0/bXhRIe1evY13xkEhpyidiE1tHk5C2
	 wNY0SycVqeiji5dI0BBrfNa7rHJUznFKDjK7JWUQ4WcRw1essL9ynfOG7Z2SLW0GYa
	 mu7MU0NPmfFypYHyq9ntFo8tzIQDuHCGvrfU1g77WZkJ6O/WU7ELJvFLCAYwzCI7/c
	 iBTzE22SjBDV85ogADny07hh/wgutZPiHGbPx2MZKndKGOeIj0WqRedGR2bM1D58wD
	 WA7mUsz6jMenGsceASBVUxOHRV6nf4P3PHDj7eJJfjEp2oXl+hN4rQjPAg8zu6BPE7
	 Y0ij5xGi6aO1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/13] HID: ft260: gpio: group sysfs attrs per HID
 interface
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260822213941.98882-10-michael.zaidman@gmail.com>
References: <20260822213941.98882-1-michael.zaidman@gmail.com>
 <20260822213941.98882-10-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 21:54:17 +0000
Message-Id: <20260822215417.F1B781F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

New issues:
- [Medium] The `i2c_enable` sysfs attribute is unintentionally removed for =
dual-mode devices.
- [Medium] The `i2c_reset` sysfs attribute is incorrectly exposed on the UA=
RT interface group.

Pre-existing issues:
- [High] Premature free of `dev` in `ft260_remove()` leads to multiple Use-=
After-Free conditions.
- [High] Double free and Use-After-Free of the `dev` structure in the probe=
 error paths.
- [High] Missing and incorrectly ordered teardown of timer and workqueue le=
ads to Use-After-Free.
- [High] On device hot-unplug, the driver frees critical resources before t=
he TTY port is completely hung up, allowing concurrent TTY operations to tr=
igger Use-After-Free.
- [High] Race condition Use-After-Free due to manual `kfree(dev)` before `d=
evres` cleans up the registered gpiochip.
--

--- Patch [9]: [PATCH 09/13] HID: ft260: gpio: group sysfs attrs per HID in=
terface ---
commit c899807eb1ab1f737fe08c45424f6b6a6de53615
Author: Michael Zaidman <michael.zaidman@gmail.com>

HID: ft260: gpio: group sysfs attrs per HID interface

Split the single sysfs attribute group into per-interface groups based
on chip mode (DCNF0/DCNF1).

> diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
> index 554d8e3ddb6db..0a1875a1a7eca 100644
> --- a/drivers/hid/hid-ft260.c
> +++ b/drivers/hid/hid-ft260.c

[ ... ]

> @@ -1603,11 +1603,35 @@ static const struct attribute_group ft260_attr_gr=
oup =3D {
>  		  &dev_attr_gpio2_func.attr,
>  		  &dev_attr_gpioa_func.attr,
>  		  &dev_attr_gpiog_func.attr,
> +		  &dev_attr_clock_ctl.attr,
> +		  &dev_attr_i2c_reset.attr,
> +		  &dev_attr_clock.attr,
> +		  NULL
> +	}
> +};
> +
> +static const struct attribute_group ft260_i2c_chip_mode_0_3_attr_group =
=3D {
> +	.attrs =3D (struct attribute *[]) {
> +		  &dev_attr_hid_over_i2c_en.attr,
> +		  &dev_attr_i2c_reset.attr,
> +		  &dev_attr_clock.attr,
> +		  NULL
> +	}
> +};

[Severity: Medium]
Is the omission of the dev_attr_i2c_enable.attr intentional for dual-mode
devices?

The commit message mentions splitting the groups per interface based on chip
mode, but it looks like the i2c_enable attribute was completely dropped from
the dual-mode I2C group here.=20

Could this silently break userspace applications relying on this sysfs entr=
y?

> +
> +static const struct attribute_group ft260_uart_chip_mode_0_2_3_attr_grou=
p =3D {
> +	.attrs =3D (struct attribute *[]) {
> +		  &dev_attr_chip_mode.attr,
> +		  &dev_attr_pwren_status.attr,
> +		  &dev_attr_suspend_status.attr,
> +		  &dev_attr_power_saving_en.attr,
> +		  &dev_attr_gpio2_func.attr,
> +		  &dev_attr_gpioa_func.attr,
> +		  &dev_attr_gpiog_func.attr,
>  		  &dev_attr_uart_mode.attr,
>  		  &dev_attr_uart_dcd_ri.attr,
>  		  &dev_attr_clock_ctl.attr,
>  		  &dev_attr_i2c_reset.attr,

[Severity: Medium]
Does this unintentionally expose the I2C reset attribute on the UART
interface?

According to the patch description, the UART interface should only contain
GPIO and UART attributes, but dev_attr_i2c_reset.attr is included here.

> -		  &dev_attr_clock.attr,
>  		  NULL
>  	}
>  };

[ ... ]

> @@ -2306,12 +2339,14 @@ static int ft260_uart_probe(struct ft260_device *=
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
This is a pre-existing issue, but can jumping to err_hid_report lead to a
double free or use-after-free of the dev structure?

If sysfs_create_group() fails, the error path goes to err_hid_report, which
calls ft260_uart_port_remove(dev). This drops the TTY port reference via
tty_port_put().

If the TTY is not open, the refcount drops to 0, and the port destructor
frees dev immediately. The function then returns the error code back to
ft260_probe(), which unconditionally jumps to hid_fail and executes
kfree(dev).

Also, does this error path bypass workqueue cancellation?

The error path here deletes the timer but appears to completely omit calling
cancel_work_sync(), which could trigger a use-after-free if the timer had
already scheduled the work before dev is freed.

Finally, does the manual kfree(dev) in ft260_probe() race with devres?

The ft260_gpio_init() function registers a gpiochip using
devm_gpiochip_add_data(). The devres cleanup won't run until after the probe
function fully returns, leaving a window where the active gpiochip can be
accessed by userspace while its private data (dev) has already been freed.

>  		}

[ ... ]

> @@ -2418,12 +2453,19 @@ static void ft260_remove(struct hid_device *hdev)
>  		ft260_uart_port_remove(dev);
>  		/* dev is still needed, so we will free it in _destroy func */
>  		if (dev->chip_mode & FT260_MODE_UART ||
> -		    dev->chip_mode =3D=3D FT260_MODE_ALL)
> -			sysfs_remove_group(&hdev->dev.kobj, &ft260_attr_group);
> +		    dev->chip_mode =3D=3D FT260_MODE_ALL ||
> +		    dev->chip_mode =3D=3D FT260_MODE_BOTH)
> +			sysfs_remove_group(&hdev->dev.kobj,
> +					   &ft260_uart_chip_mode_0_2_3_attr_group);

[Severity: High]
This is a pre-existing issue, but does checking dev->chip_mode here risk
dereferencing a freed pointer?

When ft260_uart_port_remove(dev) is called just above this block, it drops
the TTY port reference. If the port isn't open, the port destructor runs
and immediately frees dev. Accessing dev->chip_mode and removing the sysfs
group afterward would then be a use-after-free.

Does the order of operations in ft260_remove() also leave the device
vulnerable to incoming USB events after it is freed?

Because hid_hw_stop() is called much later in this function, there is a
window where incoming HID reports can trigger ft260_raw_event() on a
freed dev.

Are there concurrent teardown risks during device hot-unplug?

Looking at ft260_uart_port_remove(), kfifo_free() is called before the
asynchronous tty_port_tty_hangup(). If userspace writes to the TTY during
this window, ft260_uart_write() could push data into the explicitly
freed xmit_fifo.

Could the workqueue also be incorrectly rescheduled during unbind?

Earlier in ft260_remove(), cancel_work_sync(&dev->wakeup_work) is called
before timer_delete_sync() (which happens inside ft260_uart_port_remove).
This allows the timer to expire after the work is canceled, rescheduling
the work to execute after dev is freed.

> =20
>  	} else {
>  		if (dev->chip_mode =3D=3D FT260_MODE_I2C)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822213941.9888=
2-1-michael.zaidman@gmail.com?part=3D9

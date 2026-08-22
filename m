Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7C823FC41
	for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 21:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787435700; cv=none; b=bcNndiluONZ6/0ERlE9ZiQbXCGnbgwMb77fHRxJFg8J/KpbqNd8s/N+/YvPPh8RQMicsW0jIn9O0RDTelIELIscS+jIlo4aHo7NUKB/8M2Qgsw0/1oqGIk3XNPpEaU91SVX8wPdIGtwxWFmAGuQb6UnDwWf8FsfkqLhiXkOMteQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787435700; c=relaxed/simple;
	bh=K3CcmBFshPZ0hNzJ7KLblbYDT+PFoHo5fSEUYHrLFg8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oUcPxvaUrRy7Bi716H31xlo8Ac3Mu2VdVZtwMLR217M54yP54xPNIzGd0yyMgToHpbmVnqINMVQ7sX+1GoLF6502pHJqB1D2iip6UyU76QCRO/4l1kt0dmUGe8NHsPxKNxoLGdYEV4GX5FsaXzYNWzo2YEXUPFHdHb8Sj7MKemc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QsLhWt19; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QsLhWt19"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2AC71F000E9;
	Sat, 22 Aug 2026 21:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787435698;
	bh=yH/xk75cqyB3UWu6cnan9aAJ0xEzuSuV3shLw8VvHUo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QsLhWt19iaGJ/V4bSqF0/TD8g1Z9rgJnPSAelLKcWvcnOTSs0pwqYC3PG1VpcLaGS
	 rFVDLnZsiDNjpomTS86jwFK8YPsbwrWfEc/2rxwIdAYrg0heOzXu5TKVDLLn0k3+br
	 KD6i2euNC3s4/YUFaE5RQCB4VZyjJ8XLNK5Gyj6eQWcpZbX+SgT49Q3nL/Ol9t+7ky
	 SmibFrNCMpJ4PP1RBAZtSvrJ62Bm5HumZxuzNpBRMAX7PJJeFvNm09oqmbqdFsEmmM
	 lhDRzl4uYrFDWFWcfs5sVMO+ianyXxykQjEso0PwsJYKW0pcCCxpA9OZa3vFmCo/g+
	 0HKRGpLY4wvGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/13] HID: ft260: uart: add modem pins control via
 ioctl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260822213941.98882-9-michael.zaidman@gmail.com>
References: <20260822213941.98882-1-michael.zaidman@gmail.com>
 <20260822213941.98882-9-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 21:54:58 +0000
Message-Id: <20260822215458.B2AC71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

New issues:
- [Critical] tiocmget and tiocmset operations trigger a Use-After-Free if c=
alled after the USB device is unbound due to delayed TTY hangup.
- [High] In ft260_probe(), if ft260_get_interface_type() fails, the negativ=
e error code is discarded, causing probe to return success.
- [Medium] ft260_uart_tiocmget() fails to check the return value of ft260_g=
pio_get_all(), leading to corrupted TIOCM state on error.
- [Medium] ft260_uart_tiocmset() copies port->gpio outside of port->lock, c=
reating a race condition that leads to lost GPIO updates.
- [Medium] ft260_uart_tiocmset() and ft260_uart_tiocmget() silently ignore =
partial modem GPIO configurations and falsely return success.

Pre-existing issues:
- [Critical] Pre-existing memory safety bugs related to tty_port refcountin=
g cause a double-free on probe failure and a use-after-free on device remov=
al.
- [High] Pre-existing double byteswap of baudrate corrupts UART configurati=
on on big-endian hosts.
--

--- Patch [8]: [PATCH 08/13] HID: ft260: uart: add modem pins control via i=
octl ---
commit 847b0f46ee2404b8e4d020149c5d880eb06ffe61
Author: Michael Zaidman <michael.zaidman@gmail.com>

HID: ft260: uart: add modem pins control via ioctl
   =20
This commit adds TIOCMGET/TIOCMSET support so userspace can drive DTR/RTS
when the modem pins are in GPIO mode. It also modifies the GPIO sysfs
registration to rely on chip_mode instead of USB interface number.

> diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
> index 1da42b8756d8c..554d8e3ddb6db 100644
> --- a/drivers/hid/hid-ft260.c
> +++ b/drivers/hid/hid-ft260.c
[ ... ]
> @@ -1912,6 +1942,78 @@ static void ft260_uart_set_termios(struct tty_stru=
ct *tty,
>  	ft260_uart_change_speed(port, &tty->termios, NULL);
>  }
> =20
> +static int ft260_uart_tiocmget(struct tty_struct *tty)
> +{
> +	struct ft260_device *port =3D tty->driver_data;
> +	int gpios;
> +
> +	/*
> +	 * The modem lines control via ioctl is allowed only
> +	 * when the related pins are in the gpio mode.
> +	 */
> +	int mask =3D FT260_GPIO_UART_MODE_4_SET;
> +
> +	if ((port->gpio_en & mask) !=3D mask) {
> +		ft260_dbg("Illegal gpio config %#02x !=3D mask %#04x\n",
> +			  port->gpio_en, mask);
> +		return 0;
> +	}

[Severity: Medium]
Does this silently ignore the partial configuration by returning 0
(success) instead of an error code like -EINVAL? If userspace enables
hardware flow control, it might try to toggle DTR/DSR manually, and
it looks like this will silently return success without taking action.

> +
> +	gpios =3D ft260_gpio_get_all(port->gc, FT260_GPIO_VALUE);

[Severity: Critical]
Is there a use-after-free risk here if the USB device is unbound
but the TTY file descriptor is still open? It appears port->gc could be
freed by devres during removal, while the asynchronous TTY hangup might
not have completed yet.

> +
> +	return (((gpios & FT260_GPIO_B) ? TIOCM_RTS : 0) |

[Severity: Medium]
If ft260_gpio_get_all() returns a negative error code (e.g., due to a
USB transfer error), will the error value be directly evaluated by the
bitwise operators here instead of being propagated back to userspace?

> +		((gpios & FT260_GPIO_E) ? TIOCM_CTS : 0) |
> +		((gpios & FT260_GPIO_F) ? TIOCM_DTR : 0) |
> +		((gpios & FT260_GPIO_H) ? TIOCM_DSR : 0) |
> +		((gpios & FT260_GPIO_4) ? TIOCM_CAR : 0) |
> +		((gpios & FT260_GPIO_5) ? TIOCM_RNG : 0));
> +}
> +
> +static int ft260_uart_tiocmset(struct tty_struct *tty,
> +			       unsigned int set, unsigned int clear)
> +{
> +	int ret;
> +	struct ft260_device *port =3D tty->driver_data;
> +	struct ft260_gpio_write_request_report rep;
> +	struct hid_device *hdev =3D port->hdev;
> +	int mask =3D FT260_GPIO_UART_MODE_4_SET;
> +
> +	if ((port->gpio_en & mask) !=3D mask) {
> +		ft260_dbg("Illegal gpio config %#02x !=3D mask %#04x\n",
> +			  port->gpio_en, mask);
> +		return 0;
> +	}
> +	rep.report =3D FT260_GPIO;
> +	rep.gpio =3D port->gpio;
> +
> +	mutex_lock(&port->lock);

[Severity: Medium]
Is there a race condition with concurrent GPIO updates here? Since
port->gpio is copied into rep.gpio before acquiring port->lock, could
concurrent updates to the GPIO lines via sysfs or other ioctls be silently
overwritten when this stale copy is written back at the end of the function?

> +
> +	if (set & TIOCM_RTS)
> +		ft260_gpio_output_cfg(&rep.gpio, FT260_GPIO_UART_RTS, 1);
> +	if (set & TIOCM_DTR)
> +		ft260_gpio_output_cfg(&rep.gpio, FT260_GPIO_UART_DTR, 1);
> +	if (clear & TIOCM_RTS)
> +		ft260_gpio_output_cfg(&rep.gpio, FT260_GPIO_UART_RTS, 0);
> +	if (clear & TIOCM_DTR)
> +		ft260_gpio_output_cfg(&rep.gpio, FT260_GPIO_UART_DTR, 0);
> +
> +	ft260_dbg("dirs %#02x vals %#02x ex_dirs %#02x ex_vals %#02x\n",
> +		  rep.gpio.dirs, rep.gpio.vals,
> +		  rep.gpio.ex_dirs, rep.gpio.ex_vals);
> +
> +	ret =3D ft260_hid_feature_report_set(hdev, (u8 *)&rep, sizeof(rep));

[Severity: Critical]
Can this access a freed hdev if the USB device has been unplugged?
If the asynchronous TTY hangup work hasn't completed, a delayed
ioctl could potentially pass a destroyed hid_device pointer to
ft260_hid_feature_report_set().

> +	if (unlikely(ret < 0)) {
> +		hid_err(hdev, "%s: cannot set GPIO: %d\n", __func__, ret);
> +		mutex_unlock(&port->lock);
> +		return -EIO;
> +	}
> +
> +	port->gpio =3D rep.gpio;
> +	mutex_unlock(&port->lock);
> +
> +	return 0;
> +}
[ ... ]
> @@ -2199,7 +2305,8 @@ static int ft260_uart_probe(struct ft260_device *de=
v,
> =20
>  	cfg->uart_mode =3D FT260_UART_CFG_FLOW_CTRL_NONE;
> =20
> -	if (dev->iface_id =3D=3D 0) {
> +	if (dev->chip_mode & FT260_MODE_UART ||
> +	    dev->chip_mode =3D=3D FT260_MODE_ALL) {
>  		ret =3D ft260_gpio_init(dev, cfg);

[Severity: High]
This is a pre-existing issue, but in ft260_uart_change_speed() and earlier
in ft260_uart_probe(), put_unaligned_le32(cpu_to_le32(baud), ...) is used.
Since put_unaligned_le32() already performs a byte swap to little-endian,
does passing cpu_to_le32() result in a double byteswap that breaks UART
communications on big-endian hosts?

[ ... ]
> @@ -2274,11 +2381,11 @@ static int ft260_probe(struct hid_device *hdev, c=
onst struct hid_device_id *id)
>  	spin_lock_init(&dev->read_lock);
>  	init_completion(&dev->wait);
> =20
> -	ret =3D ft260_get_interface_type(dev, &cfg);
> -	if (ret <=3D FT260_IFACE_NONE)
> +	dev->iface_type =3D ft260_get_interface_type(dev, &cfg);
> +	if (dev->iface_type <=3D FT260_IFACE_NONE)
>  		goto err_hid_close;

[Severity: High]
Does this discard the negative error code by failing to update ret?
If ft260_get_interface_type() fails (for instance, during a USB control
transfer error), jumping to err_hid_close will cause the probe function
to return the previous positive value of ret, incorrectly signaling success
to the driver core.

[ ... ]
> @@ -2310,11 +2417,13 @@ static void ft260_remove(struct hid_device *hdev)
>  					   dev->index);
>  		ft260_uart_port_remove(dev);
>  		/* dev is still needed, so we will free it in _destroy func */
> -		if (dev->iface_id =3D=3D 0)
> +		if (dev->chip_mode & FT260_MODE_UART ||
> +		    dev->chip_mode =3D=3D FT260_MODE_ALL)

[Severity: Critical]
This is a pre-existing issue, but does ft260_uart_port_remove() drop
the final tty kref and free dev? If so, accessing dev->chip_mode right
afterward would be a use-after-free during normal unplug. Furthermore,
in the ft260_probe() error path, does this same kref drop lead to a
double-free when the outer error handling calls kfree(dev)?

>  			sysfs_remove_group(&hdev->dev.kobj, &ft260_attr_group);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822213941.9888=
2-1-michael.zaidman@gmail.com?part=3D8

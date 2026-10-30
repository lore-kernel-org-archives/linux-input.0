Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793400961;
	b=gEKpICkjK0kAZMTg+sweFIlwhF+MMqP0okUOGEovlR59Hz8KQZHsi67TrEgZOFAsQmX1
	 vIp8OdT/ACXGPc26wfwh7TVpxHXUkrpDL7WauzQzpv8X6rlSqvWwWD1VZWf8lFpdS492c
	 Tcc41WXSuLtMnC83phHuD+AolKsNnlCPgaRtUHxhLHwMQKyGnyyCvjKJ/FUXs86YoPgld
	 yiu9fwf7OJnGKI7nHmp1GJjPlvjXscLphXd801hP3SU41ySijKGLNvqQL518g/j8MudZJ
	 9eE08k1k15OmRrhrbNbLkYpGyYMprDczvI2RU+58iudlWjYKN2GHdTf+Chl2GSo5jkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793400961;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NJg3cIf4HECGFrLw6KctEYbEO1OLyX9E6KStbVed788=;
	b=PCnAKyUYyT6T6voWVCv6HepC65nA++bWOlHtAVIeWWNN0eWaHNK/LVjzHiVV3lFX8mEI
	 pm/Wg0bCefGkgMOTUtZ03/iw89w607Cc05DDEtJamIpKV42P0aDGkVc1O3vI5ML3vUesH
	 IdbRH9C1sPGgkK2XgR1KOyWhmX66UZNu/5mJRs8K8RorHYXhuyU0kldym4d3W0C9YnImL
	 gcMoGnW/Jtl6lkximFPFgfa6papbZHAX8eapM+cgGClIaHRSkR/YdyVm5ilxwfZRgv7Of
	 Ijnw+usukcR8RPzE7FA0DUsZ617y1LyO9+xykDSJneCfklcsD8WxSQ9BS9pLRoJ4RhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="eU8gb/+R";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB046606A31D;
	Fri, 30 Oct 2026 22:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eU8gb/+R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B1C1F000C1;
	Fri, 30 Oct 2026 22:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793400960;
	bh=NJg3cIf4HECGFrLw6KctEYbEO1OLyX9E6KStbVed788=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eU8gb/+RQr0F+BjpPuk7k0Ab2DFgkkRwPM+pkO5CqPSZjnXAPtdonN0/zGmySI2Sy
	 fjHrInuOidcrhFfue8cfrQh9/vc5N7RTcBaGhioIXX8CuP6dRkl0Epr27pXC4KkkoA
	 aY1lrRdkSu85noANiDELhMquwGNR4xacH8uPpufvnqp7QCe8wh2GLrKMzU/tSGdTXl
	 0iaYHeu/skh1fh1FyaryhsXt27A4uwEhTj/w9lNagjy7+pzH3p+S5H9oXw1HzWXV6I
	 mFl2opX9sSq4rVjx9D3elz492vSCBbJYyTbtvlGJXFEBqQqK2MQGtQQ03EVhHpMB9C
	 kFvGEQM1lefoA==
Message-ID: <sashiko-outbox-191607@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/15] HID: ft260: uart: add modem pins control via
 ioctl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: linux-input@vger.kernel.org, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261030223637.86907-9-michael.zaidman@gmail.com>
References: <20261030223637.86907-1-michael.zaidman@gmail.com>
 <20261030223637.86907-9-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 22:55:59 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] HID: ft260: NULL deref in ft260_uart_tiocmget() before ft260_gpio_=
init() ends
- [High] HID: ft260: UAF from devm_gpiochip_add_data() vs manual dev free o=
n teardown
- [High] HID: ft260: UAF in ft260_probe() when ft260_get_interface_type() r=
eturns 0
- [Medium] HID: ft260: ft260_gpio_en_update() clobbers DCD/RI pin state on =
mode change
- [Medium] HID: ft260: unlocked gpio_en check in ft260_uart_tiocmset() and =
tiocmget()
--

commit d2fce903f266a48f35e3fe9c315e488bfef07c36
Author: Michael Zaidman <michael.zaidman@gmail.com>

HID: ft260: uart: add modem pins control via ioctl

This commit adds TIOCMGET and TIOCMSET tty ioctl support to control FT260
UART modem pins when configured as GPIOs, updates GPIO and sysfs
registration to check chip_mode instead of USB interface 0, and preserves
the return value of ft260_get_interface_type() during probe.

> diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
> index 4b0b55c98f900..4106066b6a893 100644
> --- a/drivers/hid/hid-ft260.c
> +++ b/drivers/hid/hid-ft260.c
[ ... ]
> @@ -213,7 +214,8 @@ enum {
>  #define FT260_GPIO_UART_MODE_1_SET	FT260_GPIO_UART_DTR_DSR
>  #define FT260_GPIO_UART_MODE_2_SET	FT260_GPIO_UART_RTS_CTS
>  #define FT260_GPIO_UART_MODE_3_SET	(FT260_GPIO_UART_RTS_CTS | \
> -					 FT260_GPIO_UART_DTR_DSR)
> +					 FT260_GPIO_UART_DTR_DSR | \
> +					 FT260_GPIO_UART_DCD_RI)
>  #define FT260_GPIO_UART_MODE_4_SET	FT260_GPIO_UART_MODE_3_SET

[Severity: Medium]
Does adding FT260_GPIO_UART_DCD_RI unconditionally to
FT260_GPIO_UART_MODE_3_SET and FT260_GPIO_UART_MODE_4_SET cause
ft260_gpio_en_update() to clobber the DCD/RI pin state on subsequent UART
mode changes?

When a user enables UART DCD/RI via the uart_dcd_ri sysfs attribute,
ft260_byte_store() sends FT260_ENABLE_UART_DCD_RI and calls
ft260_gpio_en_update(hdev, FT260_ENABLE_UART_DCD_RI, 1), which clears
FT260_GPIO_UART_DCD_RI from dev->gpio_en without updating
dev->gpio_uart_mode[3] or dev->gpio_uart_mode[4].

When ft260_uart_change_speed() (or a write to the uart_mode sysfs attribute)
later configures XON_XOFF (3) or NONE (4) flow control,
ft260_gpio_en_update() executes:

	case FT260_SET_UART_MODE:
		...
		ft260_gpio_en_clr(dev, bitmap);
		bitmap =3D dev->gpio_uart_mode[value];
		ft260_gpio_en_set(dev, bitmap);
		goto exit;

Because dev->gpio_uart_mode[value] still contains FT260_GPIO_UART_DCD_RI,
ft260_gpio_en_set() sets the GPIO4 and GPIO5 bits back in dev->gpio_en even
though the hardware pins remain configured as UART DCD/RI.

[ ... ]
> @@ -1941,6 +1971,80 @@ static void ft260_uart_set_termios(struct tty_stru=
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
> +		return -EINVAL;
> +	}
> +
> +	gpios =3D ft260_gpio_get_all(port->gc, FT260_GPIO_VALUE);
> +	if (gpios < 0)
> +		return gpios;

[Severity: High]
As reported by Sashiko on v1 [1], can dereferencing port->gc here race with
device removal and cause a use-after-free or NULL pointer dereference?

In ft260_gpio_init(), dev->gc is allocated with devm_kzalloc() and register=
ed
via devm_gpiochip_add_data(&hdev->dev, dev->gc, dev), whereas dev (struct
ft260_device) is manually allocated with kzalloc_obj() and reference-counted
by dev->port in UART mode. This creates two lifetime mismatches during
teardown:

1. If a tty file descriptor is open when the USB device disconnects, struct
ft260_device remains alive until ft260_uart_port_destroy(), but
hid_device_remove() runs devres_release_group() as soon as ft260_remove()
returns. That unregisters and frees port->gc (setting gc->gpiodev->data to
NULL). Because tty_tiocmget() does not acquire tty_lock(tty) and
ft260_uart_tiocmget() passes port->gc into ft260_gpio_get_all() ->
gpiochip_get_data(gc), a concurrent TIOCMGET call during disconnect can
dereference freed port->gc or a NULL dev pointer returned by
gpiochip_get_data().

2. Conversely, when no tty is open (or in I2C mode, or when
sysfs_create_group() fails in probe after ft260_gpio_init()), ft260_remove()
and the ft260_probe() error paths call hid_hw_close(), hid_hw_stop(), and
free dev (via ft260_uart_port_put(), tty_port_put(), or kfree()) before
returning to the HID core, where devres_release_group() later unregisters
dev->gc. While dev->gc is still registered during that window,
gpiochip_get_data(gc) points to the freed struct ft260_device.

> +
> +	return ((!(gpios & FT260_GPIO_B) ? TIOCM_RTS : 0) |
> +		(!(gpios & FT260_GPIO_E) ? TIOCM_CTS : 0) |
> +		(!(gpios & FT260_GPIO_F) ? TIOCM_DTR : 0) |
> +		(!(gpios & FT260_GPIO_H) ? TIOCM_DSR : 0) |
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
> +		return -EINVAL;
> +	}
> +	rep.report =3D FT260_GPIO;
> +
> +	mutex_lock(&port->lock);
> +	rep.gpio =3D port->gpio;

[Severity: Medium]
Should the (port->gpio_en & mask) !=3D mask check in ft260_uart_tiocmset() =
and
ft260_uart_tiocmget() be performed while holding port->lock, matching
ft260_gpio_set() and ft260_gpio_direction_set()?

Updates to port->gpio_en in ft260_uart_change_speed() and FT260_ATTR_STORE()
occur under port->lock after a blocking ft260_hid_feature_report_set() call.
Checking port->gpio_en before acquiring mutex_lock(&port->lock) in
ft260_uart_tiocmset() leaves a window where a concurrent termios or sysfs
change can switch the pins to hardware flow control (clearing RTS/CTS or
DTR/DSR in port->gpio_en), after which ft260_uart_tiocmset() acquires
port->lock and sends an FT260_GPIO report driving those pins as outputs.

[ ... ]
> @@ -2232,7 +2340,8 @@ static int ft260_uart_probe(struct ft260_device *de=
v,
> =20
>  	cfg->uart_mode =3D FT260_UART_CFG_FLOW_CTRL_NONE;
> =20
> -	if (dev->iface_id =3D=3D 0) {
> +	if (dev->chip_mode & FT260_MODE_UART ||
> +	    dev->chip_mode =3D=3D FT260_MODE_ALL) {
>  		ret =3D ft260_gpio_init(dev, cfg);
>  		if (ret)
>  			goto err_hid_report;

[Severity: High]
Can userspace open the tty device and invoke ft260_uart_tiocmget(),
ft260_uart_tiocmset(), or ft260_uart_set_termios() before ft260_gpio_init()
finishes initializing dev->gc, dev->gpio, and dev->gpio_uart_mode[]?

In ft260_uart_probe(), ft260_uart_add_port() and
tty_port_register_device_attr() expose /dev/ttyFTx to userspace before the
blocking ft260_hid_feature_report_set() call and before ft260_gpio_init():

	devt =3D tty_port_register_device_attr(&dev->port,
					     ft260_tty_driver,
					     dev->index, &hdev->dev,
					     dev, NULL);
	...
	ret =3D ft260_hid_feature_report_set(hdev, (u8 *)&req, sizeof(req));
	...
	if (dev->chip_mode & FT260_MODE_UART ||
	    dev->chip_mode =3D=3D FT260_MODE_ALL) {
		ret =3D ft260_gpio_init(dev, cfg);

Inside ft260_gpio_init(), dev->gpio_en is populated with
FT260_GPIO_UART_MODE_4_SET before dev->gc is allocated, before two sleeping
ft260_hid_feature_report_get() calls populate dev->gpio (without holding
dev->lock), and before devm_gpiochip_add_data() initializes dev->gc->gpiode=
v:

	if (mode & FT260_MODE_UART) {
		if (cfg->uart_mode < FT260_GPIO_UART_MODES)
			dev->gpio_en |=3D dev->gpio_uart_mode[cfg->uart_mode];
		...
	}
	...
	dev->gc =3D devm_kzalloc(&hdev->dev, sizeof(*dev->gc), GFP_KERNEL);
	...
	(void)ft260_hid_feature_report_get(dev->hdev, FT260_CHIP_VERSION,
					(u8 *)&ver, sizeof(ver));

	ret =3D ft260_hid_feature_report_get(hdev, FT260_GPIO, (u8 *)&gbuf,
					   sizeof(gbuf));
	if (ret < 0)
		hid_warn(hdev, "cannot read GPIO state: %d\n", ret);
	else
		dev->gpio =3D gbuf.gpio;

	ret =3D devm_gpiochip_add_data(&hdev->dev, dev->gc, dev);

If userspace (such as udev or ModemManager) opens the tty and calls TIOCMGET
after dev->gpio_en is set but before devm_gpiochip_add_data() completes, the
(port->gpio_en & mask) !=3D mask check in ft260_uart_tiocmget() succeeds wh=
ile
port->gc or port->gc->gpiodev is still NULL, causing gpiochip_get_data() in
ft260_gpio_get_all() to dereference a NULL pointer. A concurrent TIOCMSET
in this window also sees an uninitialized zeroed port->gpio shadow, and a
concurrent set_termios call before ft260_gpio_init() populates
dev->gpio_uart_mode[] reads zeroed mode masks.

> @@ -2311,8 +2420,9 @@ static int ft260_probe(struct hid_device *hdev, con=
st struct hid_device_id *id)
>  	ret =3D ft260_get_interface_type(dev, &cfg);
>  	if (ret <=3D FT260_IFACE_NONE)
>  		goto err_hid_close;
> +	dev->iface_type =3D ret;

[Severity: High]
As reported by Sashiko on v1 [2], what happens if ft260_get_interface_type()
returns 0 (FT260_IFACE_NONE)?

In ft260_get_interface_type(), ft260_get_system_config() returns 0 on
success, and the switch on cfg->chip_mode has no default case:

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

If the device reports a cfg->chip_mode value outside 0..3,
ft260_get_interface_type() returns ret =3D=3D 0. In ft260_probe(),
if (ret <=3D FT260_IFACE_NONE) jumps to err_hid_close with ret =3D=3D 0, wh=
ich
calls kfree(dev) while leaving hdev->driver_data pointing to dev, and then
returns 0 (success) from ft260_probe(). Subsequent removal in ft260_remove()
will then dereference and double-free dev.

[1] https://lore.kernel.org/r/20260822213941.98882-9-michael.zaidman@gmail.=
com
[2] https://lore.kernel.org/r/20260822213941.98882-9-michael.zaidman@gmail.=
com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030223637.8690=
7-1-michael.zaidman@gmail.com?part=3D8

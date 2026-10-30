Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793401151;
	b=0YSeanoERF2zIOdOS6L7gjpBO2h0encd83njP60f0sDMYk4PfG5ohsDhpnUmFHqzO4Z1
	 0iNqKbOfvi4ChVLAwT9Kf51HtkFFQiGWlVJStN7dZWkn+7aSLkeSUMXlYeizw25gLZxjg
	 1MM2WbuXdaiEglvUo7LVPMvxMymSL0bJQiiuCY82ccjXzO6/W4k/z+ZQgM6ETLJcaUBra
	 Q5QBFElPJb52v3BXANUuzz7kl9+BXVJnjGKfTubbWx9oyHa7HSupsOkruzUsoK2vM5PuM
	 FLyRPKiPt1BHKje+ezmnNjxYS6BOh5pIhdu30wLs8meheK6Kjb/XPsmsq6lLTMahBag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793401151;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=c11L8tS23eFb6s3RBEAZGixRTlxXgsxHIoJ8clzC3xg=;
	b=hgg8wJXJSPD3rOZdZGE/xt9jp1wI6+3NMiYRbRCHZD7u+NtLfpxNcsQixhQ7tfBUUM4u
	 9vtOk6j6PfMV7wusWD4NeVzdpl7NUB1GhT9jpLQlbOjjGUhxnJHYkQgTeyAU1e0otlzit
	 qYmGYMhYtmNM43IichDTaIDFx/vQDLoxfVA0ujW9YeutjYWWHgCbJkev68xpBJs2vyQwS
	 TE/5zFO3HhunovT8AjNYuXnADQQjdEt8ov87m99hQ71JZnERWHm/6oTJ2w1XMfbJ11eo+
	 rkSV/mhuJHAaV8qL5ClWmvuN2+dOcjRw4ZTxEUfPXtIKBddc56oegbtRfYXFnXm376g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="LocYzV/d";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB41606A31A;
	Fri, 30 Oct 2026 22:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LocYzV/d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C22B51F000C1;
	Fri, 30 Oct 2026 22:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793401151;
	bh=c11L8tS23eFb6s3RBEAZGixRTlxXgsxHIoJ8clzC3xg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LocYzV/dVZyvJJ3wF4btAVDYquK/Olg0W73xGls3UpCACdu2sKacAAc3jdaME3UMI
	 jXnzyyVWyMsGB6GGuVyOOoQMVb7A0uejhpAB992vy/hcAYkfvKT3X2GkyBieW2s/EE
	 fT67VE72nedwTl2Xo2glZ62sqs5VdxRol8qk9r4XL1+A/e2kGDaY3UGo/mBorG7V2s
	 U9KkvygCyGwO1ZL5V0rVE34uuf/RUlfWruWn4Yq/+ffAw+ZybgNtZgg5BnXoEe3gqA
	 B+OoXQ5eejlBPC4+J1NQ3MGnKkd8KL5X9730TAyEyfcj7CUNLYOq58iM/cozZMJcjZ
	 KIyqKvhtlFmHg==
Message-ID: <sashiko-outbox-191609@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 15/15] HID: ft260: i2c: recover a bus held by a slave
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: linux-input@vger.kernel.org, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261030223637.86907-16-michael.zaidman@gmail.com>
References: <20261030223637.86907-1-michael.zaidman@gmail.com>
 <20261030223637.86907-16-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 22:59:10 +0000
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
- [Medium] HID: ft260: unsynchronized FT260_GPIO access across interfaces i=
n recovery
--

commit 1e0d001c06a246dc407bfd48dc94ce59eae220c5
Author: Michael Zaidman <michael.zaidman@gmail.com>

HID: ft260: i2c: recover a bus held by a slave

This commit adds I2C bus recovery using i2c_generic_scl_recovery() when the
I2C bus remains busy after resetting the controller in ft260_i2c_abort(). It
temporarily disables the I2C controller so GPIO0 and GPIO1 can be driven as
GPIOs via ft260_gpio_pin_set() and ft260_gpio_read_all().

> diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
> index cd1117c170e1d..faa1e12cd2d54 100644
> --- a/drivers/hid/hid-ft260.c
> +++ b/drivers/hid/hid-ft260.c

[ ... ]

> @@ -1237,34 +1291,23 @@ static int ft260_gpio_set(struct gpio_chip *gc, u=
32 offset, int value)
>  	return ret;
>  }
> =20
> -static int ft260_gpio_direction_set(struct gpio_chip *gc, u32 offset,
> -				    int value, int direction)
> +/*
> + * Set the direction and the value of one pin. Takes no lock and does
> + * not look at gpio_en, so the I2C bus recovery can drive SCL and SDA
> + * while it holds dev->lock and while the pins are not GPIOs.
> + */
> +static int ft260_gpio_pin_set(struct ft260_device *dev, u32 offset,
> +			      int value, int direction)
>  {
>  	int ret;
>  	struct ft260_gpio_read_request_report buf;
>  	struct ft260_gpio_write_request_report *rep;
> -	struct ft260_device *dev =3D gpiochip_get_data(gc);
>  	struct hid_device *hdev =3D dev->hdev;
> =20
> -	if (offset >=3D FT260_GPIO_TOTAL) {
> -		hid_err(hdev, "%s: invalid offset %d\n", __func__, offset);
> -		return -EINVAL;
> -	}
> -
> -	ft260_dbg("offset %d val %d direction %d\n", offset, value, direction);
> -
> -	mutex_lock(&dev->lock);
> -
> -	if (!(dev->gpio_en & BIT(offset))) {
> -		hid_err(hdev, "%s: wrong pin function %d\n", __func__, offset);
> -		ret =3D -EIO;
> -		goto exit;
> -	}
> -
>  	ret =3D ft260_hid_feature_report_get(hdev, FT260_GPIO, (u8 *)&buf, size=
of(buf));
>  	if (unlikely(ret < 0)) {
>  		hid_err(hdev, "%s: cannot get GPIO: %d\n", __func__, ret);
> -		goto exit;
> +		return ret;
>  	}
> =20
>  	rep =3D (struct ft260_gpio_write_request_report *)&buf;
> @@ -1298,12 +1341,36 @@ static int ft260_gpio_direction_set(struct gpio_c=
hip *gc, u32 offset,
>  	ret =3D ft260_hid_feature_report_set(hdev, (u8 *)rep, sizeof(*rep));
>  	if (unlikely(ret < 0)) {
>  		hid_err(hdev, "%s: cannot set GPIO: %d\n", __func__, ret);
> -		goto exit;
> +		return ret;
>  	}
> =20
>  	dev->gpio =3D rep->gpio;
> -	ret =3D 0;
> -exit:
> +	return 0;
> +}

[ ... ]

> @@ -1360,6 +1431,65 @@ static int ft260_gpio_get(struct gpio_chip *gc, u3=
2 offset)
>  	return (ret >> offset) & 1;
>  }
> =20
> +/*
> + * I2C bus recovery. Turning the I2C controller off gives GPIO0 and
> + * GPIO1 back their GPIO function, so i2c_generic_scl_recovery() can
> + * clock the slave out of the byte it holds and put a STOP on the bus.
> + * A pin is released by making it an input, the bus pull-ups then drive
> + * it high.
> + */
> +static void ft260_i2c_set_pin(struct i2c_adapter *adap, u32 offset, int =
val)
> +{
> +	struct ft260_device *dev =3D i2c_get_adapdata(adap);
> +
> +	ft260_gpio_pin_set(dev, offset, 0,
> +			   val ? FT260_GPIO_DIR_INPUT : FT260_GPIO_DIR_OUTPUT);
> +}

[Severity: Medium]
When the chip is in dual-interface mode (FT260_MODE_ALL or FT260_MODE_BOTH),
ft260_probe() allocates separate ft260_device instances for the I2C and UART
USB interfaces, each with its own dev->lock mutex and dev->gpio shadow stat=
e.

In those modes, ft260_uart_probe() registers the gpio_chip on the UART
interface's ft260_device:

drivers/hid/hid-ft260.c:ft260_uart_probe()
	if (dev->chip_mode & FT260_MODE_UART ||
	    dev->chip_mode =3D=3D FT260_MODE_ALL ||
	    dev->chip_mode =3D=3D FT260_MODE_BOTH) {
		ret =3D ft260_gpio_init(dev, cfg);

Meanwhile, ft260_i2c_abort() -> i2c_recover_bus() -> ft260_i2c_set_pin() ->
ft260_gpio_pin_set() runs on the I2C interface's ft260_device while holding
only the I2C interface's dev->lock.

Because both interfaces access the same chip-wide FT260_GPIO feature report,
can ft260_gpio_pin_set() race with concurrent FT260_GPIO operations on the
UART interface?

1. ft260_gpio_set() and ft260_gpio_direction_set() perform a non-atomic
   ft260_hid_feature_report_get() and ft260_hid_feature_report_set() cycle =
on
   FT260_GPIO while holding the UART interface's dev->lock. If this interle=
aves
   with ft260_gpio_pin_set() during bus recovery, one side's pin updates can
   be overwritten, or the UART interface's dev->gpio can record the transie=
nt
   output direction of GPIO0 (SCL) or GPIO1 (SDA).

2. ft260_uart_tiocmset() on the UART interface does not read FT260_GPIO from
   the chip before writing; it takes port->lock, copies the cached port->gp=
io,
   modifies RTS/DTR, and writes the full FT260_GPIO report:

drivers/hid/hid-ft260.c:ft260_uart_tiocmset()
	mutex_lock(&port->lock);
	rep.gpio =3D port->gpio;
	...
	ret =3D ft260_hid_feature_report_set(hdev, (u8 *)&rep, sizeof(rep));

   If called during recovery (or after the UART interface's port->gpio cach=
ed
   a transient SCL/SDA output direction), wouldn't ft260_uart_tiocmset()
   overwrite the SCL and SDA directions in FT260_GPIO?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030223637.8690=
7-1-michael.zaidman@gmail.com?part=3D15

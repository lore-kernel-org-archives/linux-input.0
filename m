Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3D23E0C7B
	for <linux-input@vger.kernel.org>; Mon, 29 Jun 2026 14:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782742217; cv=none; b=qfbiIyVf7JfcxfVMcCxF92l3YLZrk9IEQPEu2FAw9WakDjcF0xWckcjZU57AJq3HldTqN45ougahukX/wRFMbnx9EHYglGFuRq4BZg68uNs0Pg+T5FGyiXNClsTgrWaPEon08j1dNt8uE+jtiPATaLghBB2gbPwBnmQBBHLNqYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782742217; c=relaxed/simple;
	bh=Sx/HCGkO2WocpDxK+GZfJHbDPEgKm3J3BGfdALs2804=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rTycwQqxahq86yskvCoPHB0NrNsQo2lOoJ232G3RQvaRbiJHYcBL2IRzQtUvH4H4UM6RkTZcN/OOU+CcJ6mN7DQFuliMsmuhZP8coDXneWMqor9TFsA0Ky+bL3G6/ZHCJHHxmU+3HdcRChDPfbLM37RYZjeDX+vQBSAaa6KIpvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Et52j218; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Et52j218"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D45851F000E9;
	Mon, 29 Jun 2026 14:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782742213;
	bh=SKkUAgoS3h5nEkmbuI6vSXcSZvIEQ0cyvR2Cvxu5eG0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Et52j218Qe4P2/mxi7eXgxC8qQo2WgankqHGeGoZlamtXAV6h7YOSIVrf+EvXsLd3
	 uHrtbuf9JDDX8MZkQoZz3HS3wVljurmzfdjilJ67R3+T64t8uCR5vKf1XIz+CpszbH
	 WM7hN8MH9rmnqB4YBgUS8zu6pPrfx5fFjDeUA/cwqhcVFQdZarZJITe0a1HgvvKSPi
	 YpuZ5xrcJnf6iTxzWAeS5zuxudxozQCrZ6gq9aeYXftVOtt6fAuvf9EVbS8vocHx10
	 9ekCrl85VfmYMWtZGX+hpXr/GfKAwLGuG4HB2C5zJV4nW0mVzPnSQaeveYGDO/om0B
	 jY4esFcGcaSzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] [RFC] gpiolib: introduce gpio_name() helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260629135917.1308621-1-arnd@kernel.org>
References: <20260629135917.1308621-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 14:10:12 +0000
Message-Id: <20260629141012.D45851F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Uncanceled timer in the probe error path leads to a Use-After-Free=
 when the timer fires.
- [High] Uncanceled delayed work in the probe error path and early IRQ requ=
est lead to Use-After-Free.
- [High] The return value of extcon_rtk_type_c_edev_register() is assigned =
but never checked, leading to silent failures.
--

commit fd9fdd473dd5d54a8f94bae5e74133accbec590a
Author: Arnd Bergmann <arnd@arndb.de>

gpiolib: introduce gpio_name() helper

Most remaining users of desc_to_gpio() only call it for printing debug
information.

Replace this with a new gpiod_name() helper that returns the
gpio_desc->name string after checking the gpio_desc pointer.

> diff --git a/drivers/extcon/extcon-rtk-type-c.c b/drivers/extcon/extcon-r=
tk-type-c.c
> index 82b60b927e41a..fb57e9d7ddb63 100644
> --- a/drivers/extcon/extcon-rtk-type-c.c
> +++ b/drivers/extcon/extcon-rtk-type-c.c
> @@ -1356,8 +1356,8 @@ static int extcon_rtk_type_c_probe(struct platform_=
device *pdev)
>  				(int)PTR_ERR(gpio));
>  		} else {
>  			type_c->rd_ctrl_gpio_desc =3D gpio;
> -			dev_dbg(dev, "%s get rd-ctrl-gpios (id=3D%d) OK\n",
> -				__func__, desc_to_gpio(gpio));
> +			dev_dbg(dev, "%s get rd-ctrl-gpios (id=3D%s) OK\n",
> +				__func__, gpiod_name(gpio));
>  		}
>  	}

[Severity: High]
This is a pre-existing issue, but I noticed a potential use-after-free if
extcon_rtk_type_c_init() fails.

In extcon_rtk_type_c_probe(), the code requests an IRQ before the delayed
work is initialized:

	ret =3D devm_request_irq(dev, type_c->irq, type_c_detect_irq, ...);
	...
	INIT_DELAYED_WORK(&type_c->delayed_work, host_device_switch);

	ret =3D extcon_rtk_type_c_init(type_c);
	if (ret) {
		dev_err(dev, "%s failed to init type_c\n", __func__);
		goto err;
	}

Could an early interrupt schedule the uninitialized work?

Also, if extcon_rtk_type_c_init() fails, the code jumps to the err label
and returns without canceling the delayed work. Since the structure is
freed by devres, will this cause a use-after-free when the work executes?

[Severity: High]
This is also a pre-existing issue, but further down in the same function,
the return value of extcon_rtk_type_c_edev_register() is assigned to ret
but is not checked:

	ret =3D extcon_rtk_type_c_edev_register(type_c);

	create_debug_files(type_c);

	return 0;

Could this mask a registration failure, since the function unconditionally
returns 0?

[ ... ]

> diff --git a/drivers/usb/gadget/udc/at91_udc.c b/drivers/usb/gadget/udc/a=
t91_udc.c
> index 5aa360ba4f039..0993136043870 100644
> --- a/drivers/usb/gadget/udc/at91_udc.c
> +++ b/drivers/usb/gadget/udc/at91_udc.c
> @@ -1896,8 +1896,8 @@ static int at91udc_probe(struct platform_device *pd=
ev)
>  					gpiod_to_irq(udc->board.vbus_pin),
>  					at91_vbus_irq, 0, driver_name, udc);
>  			if (retval) {
> -				DBG("request vbus irq %d failed\n",
> -				    desc_to_gpio(udc->board.vbus_pin));
> +				DBG("request vbus irq %s failed\n",
> +				    gpiod_name(udc->board.vbus_pin));
>  				goto err_unprepare_iclk;
>  			}
>  		}

[Severity: High]
This is a pre-existing issue, but there appears to be a missing timer clean=
up
in the probe error path.

In at91udc_probe(), when vbus_polled is true, a timer is armed:

		if (udc->board.vbus_polled) {
			INIT_WORK(&udc->vbus_timer_work, at91_vbus_timer_work);
			timer_setup(&udc->vbus_timer, at91_vbus_timer, 0);
			mod_timer(&udc->vbus_timer,
				  jiffies + VBUS_POLL_TIMEOUT);
		}

If usb_add_gadget_udc() fails later, the code jumps to err_unprepare_iclk
and returns without deleting the timer:

	retval =3D usb_add_gadget_udc(dev, &udc->gadget);
	if (retval)
		goto err_unprepare_iclk;
	...
err_unprepare_iclk:
	clk_unprepare(udc->iclk);
err_unprepare_fclk:
	clk_unprepare(udc->fclk);

	return retval;

If the probe fails, devres will free the udc structure. Does this mean the
timer can still fire and access the freed udc memory, causing a
use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629135917.1308=
621-1-arnd@kernel.org?part=3D1

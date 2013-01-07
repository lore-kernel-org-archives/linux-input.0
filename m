From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: stmpe: Pull IRQ GPIO number from DT during DT-based
 probe
Date: Mon, 7 Jan 2013 15:03:41 +0000
Message-ID: <20130107150341.GT21994@gmail.com>
References: <1357568989-16237-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f45.google.com ([209.85.214.45]:62962 "EHLO
	mail-bk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469Ab3AGPDq (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Jan 2013 10:03:46 -0500
Received: by mail-bk0-f45.google.com with SMTP id jk13so8456633bkc.32
        for <linux-input@vger.kernel.org>; Mon, 07 Jan 2013 07:03:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1357568989-16237-1-git-send-email-marex@denx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Vipul Kumar Samar <vipulkumar.samar@st.com>, Viresh Kumar <viresh.kumar@linaro.org>

On Mon, 07 Jan 2013, Marek Vasut wrote:

> In case of a DT-based probe of the stmpe MFD driver, the irq_gpio was=
 zero,
> which resulted in the driver failing to probe.
>=20
> Implement DT properties "irq-over-gpio" and "irq-gpios" which are alr=
eady used
> in "arch/arm/boot/dts/spear320-hmi.dts" to circumvent these problems.=
=20

This must have slipped through the gaps. It should be removed.

> The new
> behaviour is the expected one and copies the behavior of platform_dat=
a-based
> probe.

Blindly copying platform data behaviour to DT bindings is seldom a good=
 idea.

> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Vipul Kumar Samar <vipulkumar.samar@st.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/mfd/stmpe.c |    5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
> index 4b11202..fb9cd6f 100644
> --- a/drivers/mfd/stmpe.c
> +++ b/drivers/mfd/stmpe.c
> @@ -1018,6 +1018,11 @@ void stmpe_of_probe(struct stmpe_platform_data=
 *pdata, struct device_node *np)
>  	pdata->id =3D -1;
>  	pdata->irq_trigger =3D IRQF_TRIGGER_NONE;
> =20
> +	pdata->irq_over_gpio =3D of_get_property(np, "irq-over-gpio", NULL)=
;

This is a new DT binding and you haven't provided any documentation for=
 it.

Also, there is no reason for the binding to exist.

Lots of drivers use GPIO pins as IRQs.

> +	pdata->irq_gpio =3D of_get_named_gpio(np, "irq-gpios", 0);
> +	if (!gpio_is_valid(pdata->irq_gpio))
> +		pdata->irq_gpio =3D -1;
> +
>  	of_property_read_u32(np, "st,autosleep-timeout",
>  			&pdata->autosleep_timeout);
> =20
> --=20
> 1.7.10.4
>=20

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

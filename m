From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: stmpe: Pull IRQ GPIO number from DT during DT-based
 probe
Date: Thu, 10 Jan 2013 12:57:35 +0000
Message-ID: <20130110125735.GB4964@gmail.com>
References: <1357568989-16237-1-git-send-email-marex@denx.de>
 <20130108094134.GA21994@gmail.com>
 <201301081044.14876.marex@denx.de>
 <201301081048.38149.marex@denx.de>
 <CAKohpo=YnLJN4_xA1WTiJaZeb-Oyc=RypYUyaSibmn6G4X9m4A@mail.gmail.com>
 <20130108111104.GF21994@gmail.com>
 <CAKohpomiS+UFzgiJaQbm8aZVPY0jeYhm1k7Yndk50z8=K4LvGQ@mail.gmail.com>
 <CACRpkdZWi4M3HmO_rq1O9aGTKYR0iMLXJo+nos3hYu3C_DFRHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f49.google.com ([209.85.214.49]:55384 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753771Ab3AJM5l (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Jan 2013 07:57:41 -0500
Received: by mail-bk0-f49.google.com with SMTP id jm19so276368bkc.22
        for <linux-input@vger.kernel.org>; Thu, 10 Jan 2013 04:57:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACRpkdZWi4M3HmO_rq1O9aGTKYR0iMLXJo+nos3hYu3C_DFRHQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Marek =?utf-8?B?VmHFoXV0?= <marex@denx.de>, vipul kumar samar <vipulkumar.samar@st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, devicetree-discuss@lists.ozlabs.org

On Thu, 10 Jan 2013, Linus Walleij wrote:

> On Tue, Jan 8, 2013 at 12:14 PM, Viresh Kumar <viresh.kumar@linaro.or=
g> wrote:
> > On 8 January 2013 16:41, Lee Jones <lee.jones@linaro.org> wrote:
> >>> Hmm.. I tried a bit, but couldn't find any such call :(
> >>> Probably an assumption is taken here. GPIO pins which are going t=
o be used as
> >>> interrupt lines, wouldn't be getting set in output mode at all. S=
o,
> >>> once they are put
> >>> in input mode in beginning, nobody would change it ever.
> >>>
> >>> Much of gpio controllers configure gpio pins in input mode in the=
ir probe().
> >>>
> >>> Maybe, there is something else :)
> >>
> >> Pinctrl?
> >
> > I don't think pinctrl is playing with it. I searched for
> > "direction_input" string and
> > pinctrl routine also had similar name. I couldn't fine use of
> > direction_input anywhere
> > in kernel, for setting them as irqs for OF cases.
>=20
> pinctrl has pinctrl_gpio_direction_input() and
> pinctrl_gpio_direction_output() which are supposed to
> be called *only* by GPIOlib frontends using pinctrl
> as backend to control the pins.
>=20
> But if it's a pinctrl driver using standard pinconfig from
> include/linux/pinctrl/pinconf-generic.h
> I'm all for adding a PIN_CONFIG_INPUT_ENABLE
> to these definintions so it can be set up as input
> at boot from the device tree using hogs or something,
> that make things easy when using GPIOs as IRQ
> providers only.
>=20
> So the alternative is to just set up the IRQ using the
> gpiolib functions for this: of_get_gpio() if you need the
> number from DT, then gpio_request() and
> gpio_direction_input() as on any GPIO. This can be
> done in the device driver or board code depending
> on use case.
>=20
> In the Nomadik I did this (maybe ugly) hack for a
> similar case:
>=20
> +/*
> + * The SMSC911x IRQ is connected to a GPIO pin, but the driver expec=
ts
> + * to simply request an IRQ passed as a resource. So the GPIO pin ne=
eds
> + * to be requested by this hog and set as input.
> + */
> +static int __init cpu8815_eth_init(void)
> +{
> +       struct device_node *eth;
> +       int gpio, irq, err;
> +
> +       eth =3D of_find_node_by_path("/external-bus@34000000/ethernet=
@300");
> +       if (!eth) {
> +               pr_info("could not find any ethernet controller\n");
> +               return 0;
> +       }
> +       gpio =3D of_get_gpio(eth, 0);
> +       err =3D gpio_request(gpio, "eth_irq");
> +       if (err) {
> +               pr_info("failed to request ethernet GPIO\n");
> +               return -ENODEV;
> +       }
> +       err =3D gpio_direction_input(gpio);
> +       if (err) {
> +               pr_info("failed to set ehernet GPIO as input\n");
> +               return -ENODEV;
> +       }
> +       irq =3D gpio_to_irq(gpio);
> +       pr_info("enabled ethernet GPIO %d, IRQ %d\n", gpio, irq);
> +       return 0;
> +}
> +device_initcall(cpu8815_eth_init);

Yep, that looks pretty gross!

> I haven't read review comments on that patch.
>=20
> Maybe it's not such a good idea to add the GPIO to the device itself
> when it's being hogged by board code like this. It's a bit of a grey =
area
> so I'm a bit confused here.
>=20
> Maybe the GPIO lib actually needs a "hog" mechanism that can
> request and set GPIO pins as input/output on boot and then
> forget about them.
>=20
> Yours,
> Linus Walleij

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

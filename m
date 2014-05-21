From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 0/7] mfd: AXP20x: Add support for AXP202
 and AXP209
Date: Wed, 21 May 2014 10:14:56 +0100
Message-ID: <20140521091456.GB6679@lee--X1>
References: <1400528868-5971-1-git-send-email-carlo@caione.org>
 <20140520222307.GK12304@sirena.org.uk>
 <CAOQ7t2aBc5tFYk2MkfL9QqvFf5fcebwKtO97F3S=WdJ2uFE_jg@mail.gmail.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDA7X7F2WUEBBGO56GNQKGQESBYAHEA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <CAOQ7t2aBc5tFYk2MkfL9QqvFf5fcebwKtO97F3S=WdJ2uFE_jg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
To: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Hans De Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, wens Tsai <wens-jdAy2FN1RRM@public.gmane.org>, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-input@vger.kernel.org

> >> This set of patches introduces the core driver and support for two dif=
ferent
> >> subsystems:
> >>       - Regulators
> >
> >>  .../ABI/testing/sysfs-driver-input-axp-pek         |  11 +
> >>  Documentation/devicetree/bindings/mfd/axp20x.txt   |  93 +++++++
> >>  .../devicetree/bindings/vendor-prefixes.txt        |   1 +
> >>  arch/arm/configs/multi_v7_defconfig                |   3 +
> >>  arch/arm/configs/sunxi_defconfig                   |   4 +
> >>  drivers/input/misc/Kconfig                         |  11 +
> >>  drivers/input/misc/Makefile                        |   1 +
> >>  drivers/input/misc/axp20x-pek.c                    | 281 ++++++++++++=
+++++++++
> >>  drivers/mfd/Kconfig                                |  12 +
> >>  drivers/mfd/Makefile                               |   1 +
> >>  drivers/mfd/axp20x.c                               | 258 ++++++++++++=
+++++++
> >>  include/linux/mfd/axp20x.h                         | 180 ++++++++++++=
+
> >>  12 files changed, 856 insertions(+)
> >
> > The regulator changes don't appear to be showing up in the diffstat or
> > obviously in the series?
>=20
> Right. Cut-and-paste error.
> You have already applied the regulator patches so I didn't include
> them here (in theory I posted this series to be picked up by Lee).

That's fine.  Just tell me which patches need to stay together and
which are able to be applied through their respective subsystem trees
separately.  Then, once I have all the Acks I can apply no problem.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

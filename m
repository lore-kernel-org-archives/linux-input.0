From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 1/9] mfd: AXP20x: Add mfd driver for
 AXP20x PMIC
Date: Wed, 16 Apr 2014 16:44:15 +0100
Message-ID: <20140416154415.GG19671@lee--X1>
References: <1397209093-10077-1-git-send-email-carlo@caione.org>
 <1397209093-10077-2-git-send-email-carlo@caione.org>
 <20140416154350.GF19671@lee--X1>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDA7X7F2WUEBBVOKXKNAKGQE63FXCVI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140416154350.GF19671@lee--X1>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
To: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: linux-input@vger.kernel.org

> > This patch introduces the preliminary support for PMICs X-Powers AXP202
> > and AXP209. The AXP209 and AXP202 are the PMUs (Power Management Unit)
> > used by A10, A13 and A20 SoCs and developed by X-Powers, a sister compa=
ny
> > of Allwinner.
> >=20
> > The core enables support for two subsystems:
> > - PEK (Power Enable Key)
> > - Regulators
> >=20
> > Signed-off-by: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
> > ---
> >  drivers/mfd/Kconfig        |  12 +++
> >  drivers/mfd/Makefile       |   1 +
> >  drivers/mfd/axp20x.c       | 249 +++++++++++++++++++++++++++++++++++++=
++++++++
> >  include/linux/mfd/axp20x.h | 180 ++++++++++++++++++++++++++++++++
> >  4 files changed, 442 insertions(+)
> >  create mode 100644 drivers/mfd/axp20x.c
> >  create mode 100644 include/linux/mfd/axp20x.h
>=20
> This looks good to me know.
>=20
> Once you have all the other Acks you need I'd be happy to create an
> immutable branch for the other maintainers to pull from.

Whoops, forgot this:
  Acked-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

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

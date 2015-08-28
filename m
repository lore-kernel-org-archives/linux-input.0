From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Subject: Re: [PATCH v3 1/5] input: touchscreen: add imx6ul_tsc driver
 support
Date: Fri, 28 Aug 2015 13:19:22 +0200
Message-ID: <20150828131922.79693714@ipc1.ka-ro>
References: <1440752976-9094-1-git-send-email-haibo.chen@freescale.com>
	<1440752976-9094-2-git-send-email-haibo.chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1440752976-9094-2-git-send-email-haibo.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Haibo Chen <haibo.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi,

> Freescale i.MX6UL contains a internal touchscreen controller,
> this patch add a driver to support this controller.
>=20
> Signed-off-by: Haibo Chen <haibo.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> ---
>  drivers/input/touchscreen/Kconfig      |  12 +
>  drivers/input/touchscreen/Makefile     |   1 +
>  drivers/input/touchscreen/imx6ul_tsc.c | 524 +++++++++++++++++++++++=
++++++++++
>  3 files changed, 537 insertions(+)
>  create mode 100644 drivers/input/touchscreen/imx6ul_tsc.c
>=20
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchs=
creen/Kconfig
> index 059edeb..50a42b8 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -479,6 +479,18 @@ config TOUCHSCREEN_MTOUCH
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called mtouch.
> =20
> +config TOUCHSCREEN_IMX6UL_TSC
> +	tristate "Freescale i.MX6UL touchscreen controller"
> +	depends on (OF && GPIOLIB) || COMPILE_TEST
> +	help
> +	  Say Y here if you have a Freescale i.MX6UL, and want to
> +	  use the internal touchscreen controller.
> +
> +	  If unsure, say N.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  moduel will be called imx6ul_tsc.
>
s/moduel/module/


Lothar Wa=C3=9Fmann

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

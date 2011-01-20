From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: [PATCH 1/3] Input: ad7877 - Convert to dev_pm_ops
Date: Thu, 20 Jan 2011 21:19:16 +0000
Message-ID: <544AC56F16B56944AEC3BD4E3D591771324C0A8BC0@LIMKCMBX1.ad.analog.com>
References: <1295557823-20907-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nwd2mail10.analog.com ([137.71.25.55]:34788 "EHLO
	nwd2mail10.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754625Ab1ATVT0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Jan 2011 16:19:26 -0500
In-Reply-To: <1295557823-20907-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mike Frysinger <vapier@gentoo.org>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>

Mark Brown wrote on 2011-01-20:
> There is a move to deprecate bus-specific PM operations and move to
> using dev_pm_ops instead in order to reduce the amount of boilerplate
> code in buses and facilitiate updates to the PM core. Do this move for
> the ad7879 SPI driver.
>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Acked-by: "Hennerich, Michael" <Michael.Hennerich@analog.com>
> ---
>  drivers/input/touchscreen/ad7877.c |   19 +++++++++----------
>  1 files changed, 9 insertions(+), 10 deletions(-)
> diff --git a/drivers/input/touchscreen/ad7877.c
> b/drivers/input/touchscreen/ad7877.c index a1952fc..714d4e0 100644 ---
> a/drivers/input/touchscreen/ad7877.c +++
> b/drivers/input/touchscreen/ad7877.c @@ -41,6 +41,7 @@
>  #include <linux/delay.h> #include <linux/input.h> #include
>  <linux/interrupt.h> +#include <linux/pm.h> #include <linux/slab.h>
>  #include <linux/spi/spi.h> #include <linux/spi/ad7877.h>
> @@ -826,39 +827,37 @@ static int __devexit ad7877_remove(struct
> spi_device *spi)
>       return 0;
>  }
> -#ifdef CONFIG_PM -static int ad7877_suspend(struct spi_device *spi,
> pm_message_t message) +#ifdef CONFIG_PM_SLEEP +static int
> ad7877_suspend(struct device *dev)
>  {
> -     struct ad7877 *ts = dev_get_drvdata(&spi->dev);
> +     struct ad7877 *ts = dev_get_drvdata(dev);
>
>       ad7877_disable(ts);
>
>       return 0;
>  }
> -static int ad7877_resume(struct spi_device *spi)
> +static int ad7877_resume(struct device *dev)
>  {
> -     struct ad7877 *ts = dev_get_drvdata(&spi->dev);
> +     struct ad7877 *ts = dev_get_drvdata(dev);
>
>       ad7877_enable(ts);
>
>       return 0;
>  }
> -#else
> -#define ad7877_suspend NULL
> -#define ad7877_resume  NULL
>  #endif
> +static SIMPLE_DEV_PM_OPS(ad7877_pm, ad7877_suspend, ad7877_resume);
> +
>  static struct spi_driver ad7877_driver = {   .driver = {             .name   =
>  "ad7877",            .bus    = &spi_bus_type,                .owner  = THIS_MODULE, +                .pm     =
>  &ad7877_pm,  },      .probe          = ad7877_probe,         .remove         =
>  __devexit_p(ad7877_remove),
> -     .suspend        = ad7877_suspend,
> -     .resume         = ad7877_resume,
>  };
>
>  static int __init ad7877_init(void)

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret Seif



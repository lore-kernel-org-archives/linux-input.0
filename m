From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: [PATCH 3/3] Input: ads7846 - Convert to dev_pm_ops
Date: Thu, 20 Jan 2011 21:20:46 +0000
Message-ID: <544AC56F16B56944AEC3BD4E3D591771324C0A8BC3@LIMKCMBX1.ad.analog.com>
References: <1295557823-20907-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1295557823-20907-3-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nwd2mail11.analog.com ([137.71.25.57]:39143 "EHLO
	nwd2mail11.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753838Ab1ATVUv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Jan 2011 16:20:51 -0500
In-Reply-To: <1295557823-20907-3-git-send-email-broonie@opensource.wolfsonmicro.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mike Frysinger <vapier@gentoo.org>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Mark Brown wrote on 2011-01-20:
> There is a move to deprecate bus-specific PM operations and move to
> using dev_pm_ops instead in order to reduce the amount of boilerplate
> code in buses and facilitiate updates to the PM core. Do this move for
> the ads7846 driver.
>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Looks good to me.

Acked-by: "Hennerich, Michael" <Michael.Hennerich@analog.com>

> ---
>  drivers/input/touchscreen/ads7846.c |   16 ++++++++++------
>  1 files changed, 10 insertions(+), 6 deletions(-)
> diff --git a/drivers/input/touchscreen/ads7846.c
> b/drivers/input/touchscreen/ads7846.c index 14ea54b..b31e90f 100644 ---
> a/drivers/input/touchscreen/ads7846.c +++
> b/drivers/input/touchscreen/ads7846.c @@ -26,6 +26,7 @@
>  #include <linux/input.h> #include <linux/interrupt.h> #include
>  <linux/slab.h> +#include <linux/pm.h> #include <linux/gpio.h> #include
>  <linux/spi/spi.h> #include <linux/spi/ads7846.h>
> @@ -892,9 +893,10 @@ static irqreturn_t ads7846_irq(int irq, void
> *handle)
>       return IRQ_HANDLED;
>  }
> -static int ads7846_suspend(struct spi_device *spi, pm_message_t
> message) +#ifdef CONFIG_PM_SLEEP +static int ads7846_suspend(struct
> device *dev)
>  {
> -     struct ads7846 *ts = dev_get_drvdata(&spi->dev);
> +     struct ads7846 *ts = dev_get_drvdata(dev);
>
>       mutex_lock(&ts->lock);
> @@ -914,9 +916,9 @@ static int ads7846_suspend(struct spi_device *spi,
> pm_message_t message)
>       return 0;
>  }
> -static int ads7846_resume(struct spi_device *spi)
> +static int ads7846_resume(struct device *dev)
>  {
> -     struct ads7846 *ts = dev_get_drvdata(&spi->dev);
> +     struct ads7846 *ts = dev_get_drvdata(dev);
>
>       mutex_lock(&ts->lock);
> @@ -935,6 +937,9 @@ static int ads7846_resume(struct spi_device *spi)
>
>       return 0;
>  }
> +#endif + +static SIMPLE_DEV_PM_OPS(ads7846_pm, ads7846_suspend,
> +ads7846_resume);
>
>  static int __devinit ads7846_setup_pendown(struct spi_device *spi,
> struct ads7846 *ts)  { @@ -1402,11 +1407,10 @@ static struct
> spi_driver ads7846_driver = {
>               .name   = "ads7846",            .bus    = &spi_bus_type,                .owner  = THIS_MODULE,
>  +            .pm     = &ads7846_pm,  },      .probe          = ads7846_probe,        .remove         =
>  __devexit_p(ads7846_remove),
> -     .suspend        = ads7846_suspend,
> -     .resume         = ads7846_resume,
>  };
>
>  static int __init ads7846_init(void)

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret Seif



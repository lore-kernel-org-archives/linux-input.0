From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: [PATCH 2/3] Input: ad7879 - Convert SPI to dev_pm_ops
Date: Thu, 20 Jan 2011 21:19:38 +0000
Message-ID: <544AC56F16B56944AEC3BD4E3D591771324C0A8BC1@LIMKCMBX1.ad.analog.com>
References: <1295557823-20907-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1295557823-20907-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nwd2mail11.analog.com ([137.71.25.57]:51628 "EHLO
	nwd2mail11.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754250Ab1ATVTn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Jan 2011 16:19:43 -0500
In-Reply-To: <1295557823-20907-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mike Frysinger <vapier@gentoo.org>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>

Mark Brown wrote on 2011-01-20:
> There is a move to deprecate bus-specific PM operations and move to
> using dev_pm_ops instead in order to reduce the amount of boilerplate
> code in buses and facilitiate updates to the PM core. Do this move for
> the ad7979 SPI driver.
>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Acked-by: "Hennerich, Michael" <Michael.Hennerich@analog.com>
> ---
>  drivers/input/touchscreen/ad7879-spi.c |   17 +++++++++--------
>  1 files changed, 9 insertions(+), 8 deletions(-)
> diff --git a/drivers/input/touchscreen/ad7879-spi.c
> b/drivers/input/touchscreen/ad7879-spi.c index 59c6e68..ddf732f 100644
> --- a/drivers/input/touchscreen/ad7879-spi.c +++
> b/drivers/input/touchscreen/ad7879-spi.c @@ -7,6 +7,7 @@
>   */
>  #include <linux/input.h>     /* BUS_SPI */ +#include <linux/pm.h> #include
>  <linux/spi/spi.h>
>
>  #include "ad7879.h" @@ -20,9 +21,10 @@ #define AD7879_WRITECMD(reg)
>  (AD7879_CMD(reg))  #define
> AD7879_READCMD(reg)  (AD7879_CMD(reg) | AD7879_CMD_READ)
>
> -#ifdef CONFIG_PM -static int ad7879_spi_suspend(struct spi_device *spi,
> pm_message_t message) +#ifdef CONFIG_PM_SLEEP +static int
> ad7879_spi_suspend(struct device *dev)
>  { +  struct spi_device *spi = to_spi_device(dev);    struct ad7879 *ts =
>  spi_get_drvdata(spi);
>
>       ad7879_suspend(ts);
> @@ -30,19 +32,19 @@ static int ad7879_spi_suspend(struct spi_device
> *spi, pm_message_t message)
>       return 0;
>  }
> -static int ad7879_spi_resume(struct spi_device *spi)
> +static int ad7879_spi_resume(struct device *dev)
>  { +  struct spi_device *spi = to_spi_device(dev);    struct ad7879 *ts =
>  spi_get_drvdata(spi);
>
>       ad7879_resume(ts);
>
>       return 0;
>  }
> -#else
> -# define ad7879_spi_suspend NULL
> -# define ad7879_spi_resume  NULL
>  #endif
> +static SIMPLE_DEV_PM_OPS(ad7879_spi_pm, ad7879_spi_suspend,
> +ad7879_spi_resume); +
>  /*
>   * ad7879_read/write are only used for initial setup and for sysfs
>   controls. * The main traffic is done in ad7879_collect().
> @@ -173,11 +175,10 @@ static struct spi_driver ad7879_spi_driver = {
>               .name   = "ad7879",             .bus    = &spi_bus_type,                .owner  = THIS_MODULE,
>  +            .pm     = &ad7879_spi_pm,       },      .probe          = ad7879_spi_probe,     .remove         =
>  __devexit_p(ad7879_spi_remove),
> -     .suspend        = ad7879_spi_suspend,
> -     .resume         = ad7879_spi_resume,
>  };
>
>  static int __init ad7879_spi_init(void)

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret Seif



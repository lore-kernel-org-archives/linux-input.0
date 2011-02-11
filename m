From: Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH 2/3] Input: adxl34x-spi - Convert to dev_pm_ops
Date: Fri, 11 Feb 2011 16:31:31 +0100
Message-ID: <4D555653.4000109@analog.com>
References: <1297438422-25838-1-git-send-email-broonie@opensource.wolfsonmicro.com>  <1297438422-25838-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Reply-To: michael.hennerich@analog.com
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nwd2mail10.analog.com ([137.71.25.55]:51274 "EHLO
	nwd2mail10.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754584Ab1BKPje (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Feb 2011 10:39:34 -0500
In-Reply-To: <1297438422-25838-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Dmitry Torokhov <dtor@mail.ru>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On 02/11/2011 04:33 PM, Mark Brown wrote:
> There is a general move to convert drivers to use dev_pm_ops rather than
> bus specific ones in order to facilitate core development. Do this
> conversion for adxl34x-spi.
>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
>   

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>  drivers/input/misc/adxl34x-spi.c |   16 +++++++++-------
>  1 files changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/input/misc/adxl34x-spi.c b/drivers/input/misc/adxl34x-spi.c
> index 782de9e..5231add 100644
> --- a/drivers/input/misc/adxl34x-spi.c
> +++ b/drivers/input/misc/adxl34x-spi.c
> @@ -10,6 +10,7 @@
>  #include <linux/input.h>	/* BUS_SPI */
>  #include <linux/module.h>
>  #include <linux/spi/spi.h>
> +#include <linux/pm.h>
>  #include <linux/types.h>
>  #include "adxl34x.h"
>  
> @@ -94,8 +95,9 @@ static int __devexit adxl34x_spi_remove(struct spi_device *spi)
>  }
>  
>  #ifdef CONFIG_PM
> -static int adxl34x_spi_suspend(struct spi_device *spi, pm_message_t message)
> +static int adxl34x_spi_suspend(struct device *dev)
>  {
> +	struct spi_device *spi = to_spi_device(dev);
>  	struct adxl34x *ac = dev_get_drvdata(&spi->dev);
>  
>  	adxl34x_suspend(ac);
> @@ -103,29 +105,29 @@ static int adxl34x_spi_suspend(struct spi_device *spi, pm_message_t message)
>  	return 0;
>  }
>  
> -static int adxl34x_spi_resume(struct spi_device *spi)
> +static int adxl34x_spi_resume(struct device *dev)
>  {
> +	struct spi_device *spi = to_spi_device(dev);
>  	struct adxl34x *ac = dev_get_drvdata(&spi->dev);
>  
>  	adxl34x_resume(ac);
>  
>  	return 0;
>  }
> -#else
> -# define adxl34x_spi_suspend NULL
> -# define adxl34x_spi_resume  NULL
>  #endif
>  
> +static SIMPLE_DEV_PM_OPS(adxl34x_spi_pm, adxl34x_spi_suspend,
> +			 adxl34x_spi_resume);
> +
>  static struct spi_driver adxl34x_driver = {
>  	.driver = {
>  		.name = "adxl34x",
>  		.bus = &spi_bus_type,
>  		.owner = THIS_MODULE,
> +		.pm = &adxl34x_spi_pm,
>  	},
>  	.probe   = adxl34x_spi_probe,
>  	.remove  = __devexit_p(adxl34x_spi_remove),
> -	.suspend = adxl34x_spi_suspend,
> -	.resume  = adxl34x_spi_resume,
>  };
>  
>  static int __init adxl34x_spi_init(void)
>   


-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif


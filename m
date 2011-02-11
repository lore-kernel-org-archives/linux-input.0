From: Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH 1/2] Input: ad714x-i2c - Convert to dev_pm_ops
Date: Fri, 11 Feb 2011 16:15:01 +0100
Message-ID: <4D555275.6020909@analog.com>
References: <1297437183-23648-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Reply-To: michael.hennerich@analog.com
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nwd2mail11.analog.com ([137.71.25.57]:3630 "EHLO
	nwd2mail11.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756811Ab1BKPXG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Feb 2011 10:23:06 -0500
In-Reply-To: <1297437183-23648-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Bryan Wu <cooloney@kernel.org>, Mike Frysinger <vapier@gentoo.org>, Dmitry Torokhov <dtor@mail.ru>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>

On 02/11/2011 04:13 PM, Mark Brown wrote:
> There is a general move to convert drivers to use dev_pm_ops rather than
> bus specific PM operations in order to facilitate core work. Do this
> conversion for ad714x-i2c.
>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
>   
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
> ---
>  drivers/input/misc/ad714x-i2c.c |   17 ++++++++---------
>  1 files changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/input/misc/ad714x-i2c.c b/drivers/input/misc/ad714x-i2c.c
> index 2bef8fa..e21deb1 100644
> --- a/drivers/input/misc/ad714x-i2c.c
> +++ b/drivers/input/misc/ad714x-i2c.c
> @@ -10,23 +10,23 @@
>  #include <linux/i2c.h>
>  #include <linux/module.h>
>  #include <linux/types.h>
> +#include <linux/pm.h>
>  #include "ad714x.h"
>  
>  #ifdef CONFIG_PM
> -static int ad714x_i2c_suspend(struct i2c_client *client, pm_message_t message)
> +static int ad714x_i2c_suspend(struct device *dev)
>  {
> -	return ad714x_disable(i2c_get_clientdata(client));
> +	return ad714x_disable(i2c_get_clientdata(to_i2c_client(dev)));
>  }
>  
> -static int ad714x_i2c_resume(struct i2c_client *client)
> +static int ad714x_i2c_resume(struct device *dev)
>  {
> -	return ad714x_enable(i2c_get_clientdata(client));
> +	return ad714x_enable(i2c_get_clientdata(to_i2c_client(dev)));
>  }
> -#else
> -# define ad714x_i2c_suspend NULL
> -# define ad714x_i2c_resume  NULL
>  #endif
>  
> +static SIMPLE_DEV_PM_OPS(ad714x_i2c_pm, ad714x_i2c_suspend, ad714x_i2c_resume);
> +
>  static int ad714x_i2c_write(struct device *dev, unsigned short reg,
>  				unsigned short data)
>  {
> @@ -114,11 +114,10 @@ MODULE_DEVICE_TABLE(i2c, ad714x_id);
>  static struct i2c_driver ad714x_i2c_driver = {
>  	.driver = {
>  		.name = "ad714x_captouch",
> +		.pm   = &ad714x_i2c_pm,
>  	},
>  	.probe    = ad714x_i2c_probe,
>  	.remove   = __devexit_p(ad714x_i2c_remove),
> -	.suspend  = ad714x_i2c_suspend,
> -	.resume	  = ad714x_i2c_resume,
>  	.id_table = ad714x_id,
>  };
>  
>   


-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif


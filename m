From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] Input: tsc200x - Report proper input_dev name
Date: Wed, 20 Jul 2016 08:31:06 +0200
Message-ID: <20160720063106.GB3792@amd>
References: <20160720014424.GI19250@dtor-ws>
 <1468986592-4973-1-git-send-email-mwelling@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1468986592-4973-1-git-send-email-mwelling@ieee.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Welling <mwelling@ieee.org>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, pali.rohar@gmail.com, sre@kernel.org, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-input@vger.kernel.org

Hi!

> Passes input_id struct to the the common probe function for the tsc200x drivers
> instead of just the bustype.
> 
> This allows for the use of the product variable to set the input_dev->name
> variable according to the type of touchscreen used.
> 
> Signed-off-by: Michael Welling <mwelling@ieee.org>
> ---
>  drivers/input/touchscreen/tsc2004.c      | 7 ++++++-
>  drivers/input/touchscreen/tsc2005.c      | 7 ++++++-
>  drivers/input/touchscreen/tsc200x-core.c | 7 ++++---
>  drivers/input/touchscreen/tsc200x-core.h | 2 +-
>  4 files changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/tsc2004.c b/drivers/input/touchscreen/tsc2004.c
> index 7295c19..6fe55d5 100644
> --- a/drivers/input/touchscreen/tsc2004.c
> +++ b/drivers/input/touchscreen/tsc2004.c
> @@ -22,6 +22,11 @@
>  #include <linux/regmap.h>
>  #include "tsc200x-core.h"
>  
> +static const struct input_id tsc2004_input_id = {
> +	.bustype = BUS_I2C,
> +	.product = 2004,
> +};
> +
>  static int tsc2004_cmd(struct device *dev, u8 cmd)
>  {
>  	u8 tx = TSC200X_CMD | TSC200X_CMD_12BIT | cmd;
> @@ -42,7 +47,7 @@ static int tsc2004_probe(struct i2c_client *i2c,
>  			 const struct i2c_device_id *id)
>  
>  {
> -	return tsc200x_probe(&i2c->dev, i2c->irq, BUS_I2C,
> +	return tsc200x_probe(&i2c->dev, i2c->irq, &tsc2004_input_id,
>  			     devm_regmap_init_i2c(i2c, &tsc200x_regmap_config),
>  			     tsc2004_cmd);
>  }
> diff --git a/drivers/input/touchscreen/tsc2005.c b/drivers/input/touchscreen/tsc2005.c
> index b9f593d..f2c5f0e 100644
> --- a/drivers/input/touchscreen/tsc2005.c
> +++ b/drivers/input/touchscreen/tsc2005.c
> @@ -24,6 +24,11 @@
>  #include <linux/regmap.h>
>  #include "tsc200x-core.h"
>  
> +static const struct input_id tsc2005_input_id = {
> +	.bustype = BUS_SPI,
> +	.product = 2005,
> +};
> +
>  static int tsc2005_cmd(struct device *dev, u8 cmd)
>  {
>  	u8 tx = TSC200X_CMD | TSC200X_CMD_12BIT | cmd;
> @@ -62,7 +67,7 @@ static int tsc2005_probe(struct spi_device *spi)
>  	if (error)
>  		return error;
>  
> -	return tsc200x_probe(&spi->dev, spi->irq, BUS_SPI,
> +	return tsc200x_probe(&spi->dev, spi->irq, &tsc2005_input_id,
>  			     devm_regmap_init_spi(spi, &tsc200x_regmap_config),
>  			     tsc2005_cmd);
>  }
> diff --git a/drivers/input/touchscreen/tsc200x-core.c b/drivers/input/touchscreen/tsc200x-core.c
> index 26e81d1b..5e625c4 100644
> --- a/drivers/input/touchscreen/tsc200x-core.c
> +++ b/drivers/input/touchscreen/tsc200x-core.c
> @@ -450,7 +450,7 @@ static void tsc200x_close(struct input_dev *input)
>  	mutex_unlock(&ts->mutex);
>  }
>  
> -int tsc200x_probe(struct device *dev, int irq, __u16 bustype,
> +int tsc200x_probe(struct device *dev, int irq, const struct input_id *tsc_id,
>  		  struct regmap *regmap,
>  		  int (*tsc200x_cmd)(struct device *dev, u8 cmd))
>  {
> @@ -547,9 +547,10 @@ int tsc200x_probe(struct device *dev, int irq, __u16 bustype,
>  	snprintf(ts->phys, sizeof(ts->phys),
>  		 "%s/input-ts", dev_name(dev));
>  
> -	input_dev->name = "TSC200X touchscreen";
> +	input_dev->name = devm_kasprintf(dev, GFP_KERNEL, "TSC%04d touchscreen",
> +					tsc_id->product);

What about:

     if (tsc_id->product == 2005)
          input_dev->name = "TSC2005 touchscreen";
     else
          input_dev->name = "TSC200X touchscreen";

We do want to use 'TSC2005' name for TSC2005, because compatibility,
but you should keep TSC200X.... because compatibility. You don't want
to break people's setups by going from TSC200X to TSC2004.

Best regards,
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

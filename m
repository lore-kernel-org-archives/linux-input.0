From: Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH 2/4] Input: ad7879 - return plain error code from
 ad7879_probe()
Date: Wed, 1 Mar 2017 08:40:08 +0100
Message-ID: <fa0a3d06-272f-3cd5-fb1e-b0ad837bf64a@analog.com>
References: <20170228220848.31185-1-dmitry.torokhov@gmail.com>
 <20170228220848.31185-2-dmitry.torokhov@gmail.com>
Reply-To: <michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170228220848.31185-2-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On 28.02.2017 23:08, Dmitry Torokhov wrote:
> With the switch to devm, there is no need for ad7879_probe() to return the
> touchscreen structure, we can use plain error code. This also fixes issue
> introduced with devm concersion, where we returned 0 on success (which
> worked OK since IS_ERR(0) would not trigger, but was not correct
> regardless).
>
> Fixes: 381f688eee3d ("Input: ad7879 - use more devm interfaces")
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>  drivers/input/touchscreen/ad7879-i2c.c |  9 ++-------
>  drivers/input/touchscreen/ad7879-spi.c |  7 +------
>  drivers/input/touchscreen/ad7879.c     | 28 ++++++++++++++--------------
>  drivers/input/touchscreen/ad7879.h     |  5 ++---
>  4 files changed, 19 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/input/touchscreen/ad7879-i2c.c b/drivers/input/touchscreen/ad7879-i2c.c
> index a282d1c9e2c6..49b902b10c5f 100644
> --- a/drivers/input/touchscreen/ad7879-i2c.c
> +++ b/drivers/input/touchscreen/ad7879-i2c.c
> @@ -27,7 +27,6 @@ static const struct regmap_config ad7879_i2c_regmap_config = {
>  static int ad7879_i2c_probe(struct i2c_client *client,
>  				      const struct i2c_device_id *id)
>  {
> -	struct ad7879 *ts;
>  	struct regmap *regmap;
>
>  	if (!i2c_check_functionality(client->adapter,
> @@ -40,12 +39,8 @@ static int ad7879_i2c_probe(struct i2c_client *client,
>  	if (IS_ERR(regmap))
>  		return PTR_ERR(regmap);
>
> -	ts = ad7879_probe(&client->dev, regmap, client->irq,
> -			  BUS_I2C, AD7879_DEVID);
> -	if (IS_ERR(ts))
> -		return PTR_ERR(ts);
> -
> -	return 0;
> +	return ad7879_probe(&client->dev, regmap, client->irq,
> +			    BUS_I2C, AD7879_DEVID);
>  }
>
>  static const struct i2c_device_id ad7879_id[] = {
> diff --git a/drivers/input/touchscreen/ad7879-spi.c b/drivers/input/touchscreen/ad7879-spi.c
> index 59486ccba37d..3457a5626d75 100644
> --- a/drivers/input/touchscreen/ad7879-spi.c
> +++ b/drivers/input/touchscreen/ad7879-spi.c
> @@ -32,7 +32,6 @@ static const struct regmap_config ad7879_spi_regmap_config = {
>
>  static int ad7879_spi_probe(struct spi_device *spi)
>  {
> -	struct ad7879 *ts;
>  	struct regmap *regmap;
>
>  	/* don't exceed max specified SPI CLK frequency */
> @@ -45,11 +44,7 @@ static int ad7879_spi_probe(struct spi_device *spi)
>  	if (IS_ERR(regmap))
>  		return PTR_ERR(regmap);
>
> -	ts = ad7879_probe(&spi->dev, regmap, spi->irq, BUS_SPI, AD7879_DEVID);
> -	if (IS_ERR(ts))
> -		return PTR_ERR(ts);
> -
> -	return 0;
> +	return ad7879_probe(&spi->dev, regmap, spi->irq, BUS_SPI, AD7879_DEVID);
>  }
>
>  #ifdef CONFIG_OF
> diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
> index 52daaa4edc67..7118f611e222 100644
> --- a/drivers/input/touchscreen/ad7879.c
> +++ b/drivers/input/touchscreen/ad7879.c
> @@ -531,8 +531,8 @@ static void ad7879_cleanup_sysfs(void *_ts)
>  	sysfs_remove_group(&ts->dev->kobj, &ad7879_attr_group);
>  }
>
> -struct ad7879 *ad7879_probe(struct device *dev, struct regmap *regmap,
> -			    int irq, u16 bustype, u8 devid)
> +int ad7879_probe(struct device *dev, struct regmap *regmap,
> +		 int irq, u16 bustype, u8 devid)
>  {
>  	struct ad7879_platform_data *pdata = dev_get_platdata(dev);
>  	struct ad7879 *ts;
> @@ -542,12 +542,12 @@ struct ad7879 *ad7879_probe(struct device *dev, struct regmap *regmap,
>
>  	if (irq <= 0) {
>  		dev_err(dev, "No IRQ specified\n");
> -		return ERR_PTR(-EINVAL);
> +		return -EINVAL;
>  	}
>
>  	ts = devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
>  	if (!ts)
> -		return ERR_PTR(-ENOMEM);
> +		return -ENOMEM;
>
>  	if (pdata) {
>  		/* Platform data use swapped axis (backward compatibility) */
> @@ -564,13 +564,13 @@ struct ad7879 *ad7879_probe(struct device *dev, struct regmap *regmap,
>  		ad7879_parse_dt(dev, ts);
>  	} else {
>  		dev_err(dev, "No platform data\n");
> -		return ERR_PTR(-EINVAL);
> +		return -EINVAL;
>  	}
>
>  	input_dev = devm_input_allocate_device(dev);
>  	if (!input_dev) {
>  		dev_err(dev, "Failed to allocate input device\n");
> -		return ERR_PTR(-ENOMEM);
> +		return -ENOMEM;
>  	}
>
>  	ts->dev = dev;
> @@ -618,14 +618,14 @@ struct ad7879 *ad7879_probe(struct device *dev, struct regmap *regmap,
>  		touchscreen_parse_properties(input_dev, false, NULL);
>  		if (!input_abs_get_max(input_dev, ABS_PRESSURE)) {
>  			dev_err(dev, "Touchscreen pressure is not specified\n");
> -			return ERR_PTR(-EINVAL);
> +			return -EINVAL;
>  		}
>  	}
>
>  	err = ad7879_write(ts, AD7879_REG_CTRL2, AD7879_RESET);
>  	if (err < 0) {
>  		dev_err(dev, "Failed to write %s\n", input_dev->name);
> -		return ERR_PTR(err);
> +		return err;
>  	}
>
>  	revid = ad7879_read(ts, AD7879_REG_REVID);
> @@ -634,7 +634,7 @@ struct ad7879 *ad7879_probe(struct device *dev, struct regmap *regmap,
>  	if (input_dev->id.product != devid) {
>  		dev_err(dev, "Failed to probe %s (%x vs %x)\n",
>  			input_dev->name, devid, revid);
> -		return ERR_PTR(-ENODEV);
> +		return -ENODEV;
>  	}
>
>  	ts->cmd_crtl3 = AD7879_YPLUS_BIT |
> @@ -659,26 +659,26 @@ struct ad7879 *ad7879_probe(struct device *dev, struct regmap *regmap,
>  					dev_name(dev), ts);
>  	if (err) {
>  		dev_err(dev, "Failed to request IRQ: %d\n", err);
> -		return ERR_PTR(err);
> +		return err;
>  	}
>
>  	__ad7879_disable(ts);
>
>  	err = sysfs_create_group(&dev->kobj, &ad7879_attr_group);
>  	if (err)
> -		return ERR_PTR(err);
> +		return err;
>
>  	err = devm_add_action_or_reset(dev, ad7879_cleanup_sysfs, ts);
>  	if (err)
> -		return ERR_PTR(err);
> +		return err;
>
>  	err = ad7879_gpio_add(ts, pdata);
>  	if (err)
> -		return ERR_PTR(err);
> +		return err;
>
>  	err = input_register_device(input_dev);
>  	if (err)
> -		return ERR_PTR(err);
> +		return err;
>
>  	dev_set_drvdata(dev, ts);
>
> diff --git a/drivers/input/touchscreen/ad7879.h b/drivers/input/touchscreen/ad7879.h
> index d3d2e9dc31ae..7e43066a4b68 100644
> --- a/drivers/input/touchscreen/ad7879.h
> +++ b/drivers/input/touchscreen/ad7879.h
> @@ -11,13 +11,12 @@
>
>  #include <linux/types.h>
>
> -struct ad7879;
>  struct device;
>  struct regmap;
>
>  extern const struct dev_pm_ops ad7879_pm_ops;
>
> -struct ad7879 *ad7879_probe(struct device *dev, struct regmap *regmap,
> -			    int irq, u16 bustype, u8 devid);
> +int ad7879_probe(struct device *dev, struct regmap *regmap,
> +		 int irq, u16 bustype, u8 devid);
>
>  #endif
>


-- 
Greetings,
Michael

--
Analog Devices GmbH      Otl-Aicher Strasse 60-64      80807 München
Sitz der Gesellschaft München, Registergericht München HRB 40368,
Geschäftsführer: Peter Kolberg, Ali Raza Husain, Eileen Wynne

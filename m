From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH 3/3] input: touchscreen: ad7879: add device tree support
Date: Tue, 26 Jan 2016 09:10:07 -0800
Message-ID: <3eaf451a0d0ecf5c5dfa0f5f6a40eba1@agner.ch>
References: <1453777477-29706-1-git-send-email-stefan@agner.ch>
 <1453777477-29706-3-git-send-email-stefan@agner.ch>
 <56A72AF1.1060706@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kmu-office.ch ([178.209.48.109]:50364 "EHLO
	mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965053AbcAZRM0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Jan 2016 12:12:26 -0500
In-Reply-To: <56A72AF1.1060706@analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: michael.hennerich@analog.com
Cc: dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, realmz6@gmail.com, broonie@kernel.org, jic23@kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On 2016-01-26 00:14, Michael Hennerich wrote:
> On 01/26/2016 04:04 AM, Stefan Agner wrote:
>> Add device tree support for the I2C variant of AD7879 (AD7879-1). This
>> allows to specify the touchscreen controller as a I2C client node.
>> Most of the options available as platform data are also available as
>> device tree properties. Exporting the GPIO is currently not possible
>> through device tree.
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
> 
> 
> Hi Stefan,
> 
> Thanks for the patch -
> There is something similar in our tree but I forgot to send it
> mainline a long time ago.
> 
> https://github.com/analogdevicesinc/linux/commit/69b16d4b616a4bbe9001d3f67d3ff54f3deb85ce

Yeah I saw that patch. I tried to use the standard touchscreen
properties where applicable.

Also, my implementation is currently only for I2C. However, when I now
think about it, I might as well move my code into ad7879.c which would
enable to use the same bindings for SPI devices too.

> 
> There are some build issues can you have a look?

Yeah I saw, shame on me. Will fix them.

> 
> I also don't understand why "exporting the GPIO is not possible
> through device tree"?
> 
> Can you explain?

I should have written "not implemented" instead of "not possible".

To implement proper device tree GPIO bindings it would need some more
changes. I did not look into that, hence the current device tree
bindings do not allow to enable the GPIO functionality.

--
Stefan

> 
> Regards,
> Michael
> 
> 
>> ---
>>   .../bindings/input/touchscreen/ad7879-i2c.txt      | 47 ++++++++++++++++
>>   drivers/input/touchscreen/ad7879-i2c.c             | 63 +++++++++++++++++++++-
>>   drivers/input/touchscreen/ad7879-spi.c             |  3 +-
>>   drivers/input/touchscreen/ad7879.c                 |  2 +-
>>   drivers/input/touchscreen/ad7879.h                 |  1 +
>>   5 files changed, 113 insertions(+), 3 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/input/touchscreen/ad7879-i2c.txt
>>
>> diff --git a/Documentation/devicetree/bindings/input/touchscreen/ad7879-i2c.txt b/Documentation/devicetree/bindings/input/touchscreen/ad7879-i2c.txt
>> new file mode 100644
>> index 0000000..bf169a2
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/input/touchscreen/ad7879-i2c.txt
>> @@ -0,0 +1,47 @@
>> +* Analog Devices AD7879-1/AD7889-1 touchscreen interface (I2C)
>> +
>> +Required properties:
>> +- compatible: must be "adi,ad7879-1"
>> +- reg: i2c slave address
>> +- interrupt-parent: the phandle for the interrupt controller
>> +- interrupts: touch controller interrupt
>> +- resistance-plate-x		: total resistance of X-plate (for pressure
>> +				  calculation)
>> +- touchscreen-max-pressure	: maximum reported pressure
>> +- touchscreen-swapped-x-y	: X and Y axis are swapped (boolean)
>> +				  Swapping is done after inverting the axis
>> +Optional properties:
>> +- first-conversion-delay	: 0-12 in 128us steps (starting with 128us)
>> +				  13: 2.560ms
>> +				  14: 3.584ms
>> +				  15: 4.096ms
>> +- acquisition-time		: 0: 2us
>> +				  1: 4us
>> +				  2: 8us
>> +				  3: 16us
>> +- median-filter-size		: 0: disabled
>> +				  1: 4 measurements
>> +				  2: 8 measurements
>> +				  3: 16 measurements
>> +- averaging			: 0: 2 middle values (1 if median disabled)
>> +				  1: 4 middle values
>> +				  2: 8 middle values
>> +				  3: 16 values
>> +- conversion-interval:		: 0: convert one time only
>> +				  1-255: 515us + val * 35us (up to 9.440ms)
>> +
>> +Example:
>> +
>> +	ad7879@2c {
>> +		compatible = "adi,ad7879-1";
>> +		reg = <0x2c>;
>> +		interrupt-parent = <&gpio1>;
>> +		interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
>> +		resistance-plate-x = <120>;
>> +		touchscreen-max-pressure = <4096>;
>> +		first-conversion-delay = /bits/ 8 <3>;
>> +		acquisition-time = /bits/ 8 <1>;
>> +		median-filter-size = /bits/ 8 <2>;
>> +		averaging = /bits/ 8 <1>;
>> +		conversion-interval = /bits/ 8 <255>;
>> +	};
>> diff --git a/drivers/input/touchscreen/ad7879-i2c.c b/drivers/input/touchscreen/ad7879-i2c.c
>> index d66962c..08a2c9a 100644
>> --- a/drivers/input/touchscreen/ad7879-i2c.c
>> +++ b/drivers/input/touchscreen/ad7879-i2c.c
>> @@ -11,6 +11,7 @@
>>   #include <linux/module.h>
>>   #include <linux/types.h>
>>   #include <linux/pm.h>
>> +#include <linux/input/ad7879.h>
>>
>>   #include "ad7879.h"
>>
>> @@ -54,9 +55,50 @@ static const struct ad7879_bus_ops ad7879_i2c_bus_ops = {
>>   	.write		= ad7879_i2c_write,
>>   };
>>
>> +static struct ad7879_platform_data *ad7879_parse_dt(struct device *dev)
>> +{
>> +	struct ad7879_platform_data *pdata;
>> +	struct device_node *np = dev->of_node;
>> +	int err;
>> +	u32 tmp;
>> +
>> +	if (!np)
>> +		return NULL;
>> +
>> +	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
>> +
>> +	if (!pdata)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	err = of_property_read_u32(np, "resistance-plate-x", &tmp);
>> +	if (err) {
>> +		dev_err(dev, "failed to get resistance-plate-x property\n");
>> +		return ERR_PTR(err);
>> +	}
>> +	pdata->x_plate_ohms = (u16)tmp;
>> +
>> +	err = of_property_read_u32(np, "touchscreen-max-pressure", &tmp);
>> +	if (err) {
>> +		dev_err(dev, "failed to get touchscreen-max-pressure property\n");
>> +		return ERR_PTR(err);
>> +	}
>> +	pdata->pressure_min = (u16)tmp;
>> +
>> +	of_property_read_u8(np, "first-conversion-delay", &pdata->first_conversion_delay);
>> +	of_property_read_u8(np, "acquisition-time", &pdata->acquisition_time);
>> +	of_property_read_u8(np, "median-filter-size", &pdata->median);
>> +	of_property_read_u8(np, "averaging", &pdata->averaging);
>> +	of_property_read_u8(np, "conversion-interval", &pdata->pen_down_acc_interval);
>> +
>> +	pdata->swap_xy = of_property_read_bool(np, "touchscreen-swapped-x-y");
>> +
>> +	return pdata;
>> +}
>> +
>>   static int ad7879_i2c_probe(struct i2c_client *client,
>>   				      const struct i2c_device_id *id)
>>   {
>> +	struct ad7879_platform_data *pdata;
>>   	struct ad7879 *ts;
>>
>>   	if (!i2c_check_functionality(client->adapter,
>> @@ -65,7 +107,17 @@ static int ad7879_i2c_probe(struct i2c_client *client,
>>   		return -EIO;
>>   	}
>>
>> -	ts = ad7879_probe(&client->dev, AD7879_DEVID, client->irq,
>> +	pdata = dev_get_platdata(&client->dev);
>> +
>> +	if (!pdata && IS_ENABLED(CONFIG_OF))
>> +		pdata = ad7879_parse_dt(&client->dev);
>> +
>> +	if (IS_ERR_OR_NULL(pdata)) {
>> +		dev_err(&client->dev, "Need platform data\n");
>> +		return PTR_ERR(pdata);
>> +	}
>> +
>> +	ts = ad7879_probe(&client->dev, AD7879_DEVID, client->irq, pdata,
>>   			  &ad7879_i2c_bus_ops);
>>   	if (IS_ERR(ts))
>>   		return PTR_ERR(ts);
>> @@ -91,10 +143,19 @@ static const struct i2c_device_id ad7879_id[] = {
>>   };
>>   MODULE_DEVICE_TABLE(i2c, ad7879_id);
>>
>> +#ifdef CONFIG_OF
>> +static const struct of_device_id ad7879_dt_ids[] = {
>> +	{ .compatible = "adi,ad7879-1", },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, st1232_ts_dt_ids);
>> +#endif
>> +
>>   static struct i2c_driver ad7879_i2c_driver = {
>>   	.driver = {
>>   		.name	= "ad7879",
>>   		.pm	= &ad7879_pm_ops,
>> +		.of_match_table = of_match_ptr(ad7879_dt_ids),
>>   	},
>>   	.probe		= ad7879_i2c_probe,
>>   	.remove		= ad7879_i2c_remove,
>> diff --git a/drivers/input/touchscreen/ad7879-spi.c b/drivers/input/touchscreen/ad7879-spi.c
>> index 48033c2..8ebe604 100644
>> --- a/drivers/input/touchscreen/ad7879-spi.c
>> +++ b/drivers/input/touchscreen/ad7879-spi.c
>> @@ -128,7 +128,8 @@ static int ad7879_spi_probe(struct spi_device *spi)
>>   	        return err;
>>   	}
>>
>> -	ts = ad7879_probe(&spi->dev, AD7879_DEVID, spi->irq, &ad7879_spi_bus_ops);
>> +	ts = ad7879_probe(&spi->dev, AD7879_DEVID, spi->irq, pdata,
>> +			  dev_get_platdata(&spi->dev), &ad7879_spi_bus_ops);
>>   	if (IS_ERR(ts))
>>   		return PTR_ERR(ts);
>>
>> diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
>> index e290e7b..e763c77 100644
>> --- a/drivers/input/touchscreen/ad7879.c
>> +++ b/drivers/input/touchscreen/ad7879.c
>> @@ -486,9 +486,9 @@ static inline void ad7879_gpio_remove(struct ad7879 *ts)
>>   #endif
>>
>>   struct ad7879 *ad7879_probe(struct device *dev, u8 devid, unsigned int irq,
>> +			    struct ad7879_platform_data *pdata,
>>   			    const struct ad7879_bus_ops *bops)
>>   {
>> -	struct ad7879_platform_data *pdata = dev_get_platdata(dev);
>>   	struct ad7879 *ts;
>>   	struct input_dev *input_dev;
>>   	int err;
>> diff --git a/drivers/input/touchscreen/ad7879.h b/drivers/input/touchscreen/ad7879.h
>> index 6fd13c4..fa363a0 100644
>> --- a/drivers/input/touchscreen/ad7879.h
>> +++ b/drivers/input/touchscreen/ad7879.h
>> @@ -24,6 +24,7 @@ struct ad7879_bus_ops {
>>   extern const struct dev_pm_ops ad7879_pm_ops;
>>
>>   struct ad7879 *ad7879_probe(struct device *dev, u8 devid, unsigned irq,
>> +			    struct ad7879_platform_data *pdata,
>>   			    const struct ad7879_bus_ops *bops);
>>   void ad7879_remove(struct ad7879 *);
>>
>>

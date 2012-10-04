From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH] input: touchscreen: mms114: Add device tree bindings
Date: Thu, 04 Oct 2012 10:21:49 +0900
Message-ID: <506CE4AD.8000608@samsung.com>
References: <1349170427-1625-1-git-send-email-t.figa@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1349170427-1625-1-git-send-email-t.figa@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Tomasz Figa <t.figa@samsung.com>
Cc: linux-input@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, kyungmin.park@samsung.com, m.szyprowski@samsung.com, tomasz.figa@gmail.com
List-Id: linux-input@vger.kernel.org

Hi, Tomasz.

On 10/02/2012 06:33 PM, Tomasz Figa wrote:
> This patch adds device tree bindings for mms114 touchscreen.
>
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
>
> ---
>   .../bindings/input/touchscreen/mms114.txt          | 34 ++++++++++++++
>   drivers/input/touchscreen/mms114.c                 | 52 +++++++++++++++++++++-
>   2 files changed, 84 insertions(+), 2 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/input/touchscreen/mms114.txt
>
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/mms114.txt b/Documentation/devicetree/bindings/input/touchscreen/mms114.txt
> new file mode 100644
> index 0000000..f89d382
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/mms114.txt
> @@ -0,0 +1,34 @@
> +* MELFAS MMS114 touchscreen controller
> +
> +Required properties:
> +- compatible: must be "melfas,mms114"
> +- reg: I2C address of the chip
> +- interrupts: interrupt to which the chip is connected
> +- x-size: horizontal resolution of touchscreen
> +- y-size: vertical resolution of touchscreen
> +
> +Optional properties:
> +- contact-threshold:
> +- moving-threshold:
> +- x-invert: invert X axis
> +- y-invert: invert Y axis
> +
> +Example:
> +
> +	i2c@00000000 {
> +		/* ... */
> +
> +		touchscreen@48 {
> +			compatible = "melfas,mms114";
> +			reg = <0x48>;
> +			interrupts = <39 0>;
> +			x-size = <720>;
> +			y-size = <1280>;
> +			contact-threshold = <10>;
> +			moving-threshold = <10>;
> +			x-invert;
> +			y-invert;
> +		};
> +
> +		/* ... */
> +	};
> diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
> index 49c44bb..fb66f7a 100644
> --- a/drivers/input/touchscreen/mms114.c
> +++ b/drivers/input/touchscreen/mms114.c
> @@ -10,6 +10,7 @@
>   #include <linux/module.h>
>   #include <linux/init.h>
>   #include <linux/delay.h>
> +#include <linux/of.h>
>   #include <linux/i2c.h>
>   #include <linux/i2c/mms114.h>
>   #include <linux/input/mt.h>
> @@ -360,14 +361,55 @@ static void mms114_input_close(struct input_dev *dev)
>   	mms114_stop(data);
>   }
>   
> +static struct mms114_platform_data *mms114_parse_dt(struct device *dev)
> +{
> +	struct mms114_platform_data *pdata;
> +	struct device_node *np = dev->of_node;
> +
> +	if (!np)
> +		return NULL;
> +
> +	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata) {
> +		dev_err(dev, "failed to allocate platform data\n");
> +		return NULL;
> +	}
> +
> +	if (of_property_read_u32(np, "x-size", &pdata->x_size)) {
> +		dev_err(dev, "failed to get x-size property\n");
> +		return NULL;
> +	};
> +
> +	if (of_property_read_u32(np, "y-size", &pdata->y_size)) {
> +		dev_err(dev, "failed to get y-size property\n");
> +		return NULL;
> +	};
> +
> +	of_property_read_u32(np, "contact-threshold",
> +						&pdata->contact_threshold);
> +	of_property_read_u32(np, "moving-threshold",
> +						&pdata->moving_threshold);
> +
> +	if (of_find_property(np, "x-invert", NULL))
> +		pdata->x_invert = true;
> +	if (of_find_property(np, "y-invert", NULL))
> +		pdata->y_invert = true;
> +
> +	return pdata;
> +}

#ifdef CONFIG_OF needs.

> +
>   static int __devinit mms114_probe(struct i2c_client *client,
>   				  const struct i2c_device_id *id)
>   {
>   	struct mms114_data *data;
>   	struct input_dev *input_dev;
> +	struct mms114_platform_data *pdata = client->dev.platform_data;
>   	int error;
>   
> -	if (!client->dev.platform_data) {
> +	if (!pdata)
> +		pdata = mms114_parse_dt(&client->dev);
> +
> +	if (!pdata) {
>   		dev_err(&client->dev, "Need platform data\n");
>   		return -EINVAL;
>   	}
> @@ -389,7 +431,7 @@ static int __devinit mms114_probe(struct i2c_client *client,
>   
>   	data->client = client;
>   	data->input_dev = input_dev;
> -	data->pdata = client->dev.platform_data;
> +	data->pdata = pdata;
>   
>   	input_dev->name = "MELPAS MMS114 Touchscreen";
>   	input_dev->id.bustype = BUS_I2C;
> @@ -525,11 +567,17 @@ static const struct i2c_device_id mms114_id[] = {
>   };
>   MODULE_DEVICE_TABLE(i2c, mms114_id);
>   
> +static struct of_device_id __devinitdata mms114_dt_match[] = {
> +	{ .compatible = "melfas,mms114" },
> +	{ }
> +};
> +
>   static struct i2c_driver mms114_driver = {
>   	.driver = {
>   		.name	= "mms114",
>   		.owner	= THIS_MODULE,
>   		.pm	= &mms114_pm_ops,
> +		.of_match_table = mms114_dt_match,
>   	},
>   	.probe		= mms114_probe,
>   	.remove		= __devexit_p(mms114_remove),

From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 2/6] Input: pixcir_i2c_ts - switch the device over to
 gpiod
Date: Tue, 7 Jul 2015 13:55:15 +0300
Message-ID: <559BB013.1060004@ti.com>
References: <1436229011-29655-1-git-send-email-dmitry.torokhov@gmail.com> <1436229011-29655-2-git-send-email-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54526 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756737AbbGGKzY (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 7 Jul 2015 06:55:24 -0400
In-Reply-To: <1436229011-29655-2-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Jianchun Bian <jcbian@pixcir.com.cn>, linux-kernel@vger.kernel.org

On 07/07/15 03:30, Dmitry Torokhov wrote:
> This allows uniform parsing on legacy, DT and ACPI systems.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Acked-by: Roger Quadros <rogerq@ti.com>

cheers,
-roger

> ---
>   drivers/input/touchscreen/pixcir_i2c_ts.c   | 26 +++++++++-----------------
>   include/linux/platform_data/pixcir_i2c_ts.h |  1 -
>   2 files changed, 9 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
> index ccafa75..9093aa9 100644
> --- a/drivers/input/touchscreen/pixcir_i2c_ts.c
> +++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
> @@ -25,8 +25,8 @@
>   #include <linux/input.h>
>   #include <linux/input/mt.h>
>   #include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>   #include <linux/of.h>
> -#include <linux/of_gpio.h>
>   #include <linux/of_device.h>
>   #include <linux/platform_data/pixcir_i2c_ts.h>
>
> @@ -35,6 +35,7 @@
>   struct pixcir_i2c_ts_data {
>   	struct i2c_client *client;
>   	struct input_dev *input;
> +	struct gpio_desc *gpio_attb;
>   	const struct pixcir_ts_platform_data *pdata;
>   	bool running;
>   	int max_fingers;	/* Max fingers supported in this instance */
> @@ -161,7 +162,6 @@ static void pixcir_ts_report(struct pixcir_i2c_ts_data *ts,
>   static irqreturn_t pixcir_ts_isr(int irq, void *dev_id)
>   {
>   	struct pixcir_i2c_ts_data *tsdata = dev_id;
> -	const struct pixcir_ts_platform_data *pdata = tsdata->pdata;
>   	struct pixcir_report_data report;
>
>   	while (tsdata->running) {
> @@ -171,7 +171,7 @@ static irqreturn_t pixcir_ts_isr(int irq, void *dev_id)
>   		/* report it */
>   		pixcir_ts_report(tsdata, &report);
>
> -		if (gpio_get_value(pdata->gpio_attb)) {
> +		if (gpiod_get_value(tsdata->gpio_attb)) {
>   			if (report.num_touches) {
>   				/*
>   				 * Last report with no finger up?
> @@ -427,9 +427,6 @@ static struct pixcir_ts_platform_data *pixcir_parse_dt(struct device *dev)
>
>   	pdata->chip = *(const struct pixcir_i2c_chip_data *)match->data;
>
> -	pdata->gpio_attb = of_get_named_gpio(np, "attb-gpio", 0);
> -	/* gpio_attb validity is checked in probe */
> -
>   	if (of_property_read_u32(np, "touchscreen-size-x", &pdata->x_max)) {
>   		dev_err(dev, "Failed to get touchscreen-size-x property\n");
>   		return ERR_PTR(-EINVAL);
> @@ -442,8 +439,8 @@ static struct pixcir_ts_platform_data *pixcir_parse_dt(struct device *dev)
>   	}
>   	pdata->y_max -= 1;
>
> -	dev_dbg(dev, "%s: x %d, y %d, gpio %d\n", __func__,
> -		pdata->x_max + 1, pdata->y_max + 1, pdata->gpio_attb);
> +	dev_dbg(dev, "%s: x %d, y %d\n", __func__,
> +		pdata->x_max + 1, pdata->y_max + 1);
>
>   	return pdata;
>   }
> @@ -476,11 +473,6 @@ static int pixcir_i2c_ts_probe(struct i2c_client *client,
>   		return -EINVAL;
>   	}
>
> -	if (!gpio_is_valid(pdata->gpio_attb)) {
> -		dev_err(dev, "Invalid gpio_attb in pdata\n");
> -		return -EINVAL;
> -	}
> -
>   	if (!pdata->chip.max_fingers) {
>   		dev_err(dev, "Invalid max_fingers in pdata\n");
>   		return -EINVAL;
> @@ -530,10 +522,10 @@ static int pixcir_i2c_ts_probe(struct i2c_client *client,
>
>   	input_set_drvdata(input, tsdata);
>
> -	error = devm_gpio_request_one(dev, pdata->gpio_attb,
> -				      GPIOF_DIR_IN, "pixcir_i2c_attb");
> -	if (error) {
> -		dev_err(dev, "Failed to request ATTB gpio\n");
> +	tsdata->gpio_attb = devm_gpiod_get(dev, "attb", GPIOD_IN);
> +	if (IS_ERR(tsdata->gpio_attb)) {
> +		error = PTR_ERR(tsdata->gpio_attb);
> +		dev_err(dev, "Failed to request ATTB gpio: %d\n", error);
>   		return error;
>   	}
>
> diff --git a/include/linux/platform_data/pixcir_i2c_ts.h b/include/linux/platform_data/pixcir_i2c_ts.h
> index 7bae83b..646af6f 100644
> --- a/include/linux/platform_data/pixcir_i2c_ts.h
> +++ b/include/linux/platform_data/pixcir_i2c_ts.h
> @@ -57,7 +57,6 @@ struct pixcir_i2c_chip_data {
>   struct pixcir_ts_platform_data {
>   	int x_max;
>   	int y_max;
> -	int gpio_attb;		/* GPIO connected to ATTB line */
>   	struct pixcir_i2c_chip_data chip;
>   };
>
>

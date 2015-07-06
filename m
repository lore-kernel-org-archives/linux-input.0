From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v2] Input: pixcir_i2c_ts - Add RESET gpio
Date: Mon, 6 Jul 2015 13:28:01 +0300
Message-ID: <559A5831.1010101@ti.com>
References: <1423227190-10943-1-git-send-email-rogerq@ti.com> <556D786E.60003@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56863 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751293AbbGFK2M (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 6 Jul 2015 06:28:12 -0400
In-Reply-To: <556D786E.60003@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, rydberg@bitmath.org
Cc: mugunthanvnm@ti.com, jg1.han@samsung.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Dmitry,

On 02/06/15 12:33, Roger Quadros wrote:
> The controller has a RESET pin which is usually controlled over
> a GPIO line. If such a GPIO is provided, perform a RESET
> during probe.
>
> Signed-off-by: Roger Quadros <rogerq@ti.com>

Could you please pick this up for v4.3? Thanks.

cheers,
-roger

> ---
>   .../bindings/input/touchscreen/pixcir_i2c_ts.txt   |  3 ++
>   drivers/input/touchscreen/pixcir_i2c_ts.c          | 37
> ++++++++++++++++++++--
>   include/linux/input/pixcir_ts.h                    |  1 +
>   3 files changed, 38 insertions(+), 3 deletions(-)
>
> diff --git
> a/Documentation/devicetree/bindings/input/touchscreen/pixcir_i2c_ts.txt
> b/Documentation/devicetree/bindings/input/touchscreen/pixcir_i2c_ts.txt
> index 6e55109..8eb240a 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/pixcir_i2c_ts.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/pixcir_i2c_ts.txt
> @@ -8,6 +8,9 @@ Required properties:
>   - touchscreen-size-x: horizontal resolution of touchscreen (in pixels)
>   - touchscreen-size-y: vertical resolution of touchscreen (in pixels)
>
> +Optional properties:
> +- reset-gpio: GPIO connected to the RESET line of the chip
> +
>   Example:
>
>       i2c@00000000 {
> diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c
> b/drivers/input/touchscreen/pixcir_i2c_ts.c
> index 2c21071..80c956d 100644
> --- a/drivers/input/touchscreen/pixcir_i2c_ts.c
> +++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
> @@ -51,6 +51,19 @@ struct pixcir_report_data {
>       struct pixcir_touch touches[PIXCIR_MAX_SLOTS];
>   };
>
> +static void pixcir_reset(struct pixcir_i2c_ts_data *tsdata)
> +{
> +    const struct pixcir_ts_platform_data *pdata = tsdata->pdata;
> +
> +    if (gpio_is_valid(pdata->gpio_reset)) {
> +        gpio_set_value(pdata->gpio_reset, 1);
> +        ndelay(100);    /* datasheet section 1.2.3 says 80ns min. */
> +        gpio_set_value(pdata->gpio_reset, 0);
> +        /* wait for controller ready. 100ms guess. */
> +        msleep(100);
> +    }
> +}
> +
>   static void pixcir_ts_parse(struct pixcir_i2c_ts_data *tsdata,
>                   struct pixcir_report_data *report)
>   {
> @@ -428,7 +441,8 @@ static struct pixcir_ts_platform_data
> *pixcir_parse_dt(struct device *dev)
>       pdata->chip = *(const struct pixcir_i2c_chip_data *)match->data;
>
>       pdata->gpio_attb = of_get_named_gpio(np, "attb-gpio", 0);
> -    /* gpio_attb validity is checked in probe */
> +    pdata->gpio_reset = of_get_named_gpio(np, "reset-gpio", 0);
> +    /* gpio validity is checked in probe */
>
>       if (of_property_read_u32(np, "touchscreen-size-x", &pdata->x_max)) {
>           dev_err(dev, "Failed to get touchscreen-size-x property\n");
> @@ -442,8 +456,9 @@ static struct pixcir_ts_platform_data
> *pixcir_parse_dt(struct device *dev)
>       }
>       pdata->y_max -= 1;
>
> -    dev_dbg(dev, "%s: x %d, y %d, gpio %d\n", __func__,
> -        pdata->x_max + 1, pdata->y_max + 1, pdata->gpio_attb);
> +    dev_dbg(dev, "%s: x %d, y %d, ATTB gpio %d, RESET gpio %d\n",
> __func__,
> +        pdata->x_max + 1, pdata->y_max + 1, pdata->gpio_attb,
> +        pdata->gpio_reset);
>
>       return pdata;
>   }
> @@ -481,6 +496,10 @@ static int pixcir_i2c_ts_probe(struct i2c_client
> *client,
>           return -EINVAL;
>       }
>
> +    /* RESET gpio is optional */
> +    if (!gpio_is_valid(pdata->gpio_reset))
> +        dev_info(dev, "Invalid gpio_reset in pdata\n");
> +
>       if (!pdata->chip.max_fingers) {
>           dev_err(dev, "Invalid max_fingers in pdata\n");
>           return -EINVAL;
> @@ -530,6 +549,16 @@ static int pixcir_i2c_ts_probe(struct i2c_client
> *client,
>
>       input_set_drvdata(input, tsdata);
>
> +    if (gpio_is_valid(pdata->gpio_reset)) {
> +        error = devm_gpio_request_one(dev, pdata->gpio_reset,
> +                          GPIOF_OUT_INIT_LOW,
> +                          "pixcir_i2c_reset");
> +        if (error) {
> +            dev_err(dev, "Failed to request RESET gpio\n");
> +            return error;
> +        }
> +    }
> +
>       error = devm_gpio_request_one(dev, pdata->gpio_attb,
>                         GPIOF_DIR_IN, "pixcir_i2c_attb");
>       if (error) {
> @@ -545,6 +574,8 @@ static int pixcir_i2c_ts_probe(struct i2c_client
> *client,
>           return error;
>       }
>
> +    pixcir_reset(tsdata);
> +
>       /* Always be in IDLE mode to save power, device supports auto wake */
>       error = pixcir_set_power_mode(tsdata, PIXCIR_POWER_IDLE);
>       if (error) {
> diff --git a/include/linux/input/pixcir_ts.h
> b/include/linux/input/pixcir_ts.h
> index 7bae83b..5b204dd 100644
> --- a/include/linux/input/pixcir_ts.h
> +++ b/include/linux/input/pixcir_ts.h
> @@ -58,6 +58,7 @@ struct pixcir_ts_platform_data {
>       int x_max;
>       int y_max;
>       int gpio_attb;        /* GPIO connected to ATTB line */
> +    int gpio_reset;        /* GPIO to RESET line. Set to -1 if unused */
>       struct pixcir_i2c_chip_data chip;
>   };
>

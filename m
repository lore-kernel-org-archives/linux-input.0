From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] Input: pixcir_i2c_ts: add wake and enable gpios
Date: Mon, 16 Nov 2015 09:39:06 -0600
Message-ID: <20151116153906.GA16052@rob-hp-laptop>
References: <1447603003-8130-1-git-send-email-sander@vermin.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48745 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751730AbbKPPjO (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Nov 2015 10:39:14 -0500
Content-Disposition: inline
In-Reply-To: <1447603003-8130-1-git-send-email-sander@vermin.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sander Vermin <sander@vermin.nl>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree <devicetree@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org

On Sun, Nov 15, 2015 at 04:56:43PM +0100, Sander Vermin wrote:
> This patch improves the pixcir_i2c_ts touchscreen controller which is used by the POV PROTAB2 tablet.
> 
> On POV PROTAB2 tablet the WAKE and ENABLE gpios are used, and the screen is rotated, so touchscreen-inverted-x and touchscreen-inverted-y are needed.
> 
> In this patch the WAKE and ENABLE gpios are implemented and furtermore the touchscreen-inverted-x/y and touchscreen-swapped-x-y devicetree options are implemented.

Need to fix the line wrapping.

> 
> Signed-off-by: Sander Vermin <sander@vermin.nl>
> ---
>  .../bindings/input/touchscreen/pixcir_i2c_ts.txt   |  24 ++--
>  drivers/input/touchscreen/pixcir_i2c_ts.c          | 125 +++++++++++++++++++--
>  2 files changed, 135 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/pixcir_i2c_ts.txt b/Documentation/devicetree/bindings/input/touchscreen/pixcir_i2c_ts.txt
> index 8eb240a..5f25e96 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/pixcir_i2c_ts.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/pixcir_i2c_ts.txt
> @@ -1,15 +1,25 @@
>  * Pixcir I2C touchscreen controllers
>  
>  Required properties:
> -- compatible: must be "pixcir,pixcir_ts" or "pixcir,pixcir_tangoc"
> -- reg: I2C address of the chip
> -- interrupts: interrupt to which the chip is connected
> -- attb-gpio: GPIO connected to the ATTB line of the chip
> -- touchscreen-size-x: horizontal resolution of touchscreen (in pixels)
> -- touchscreen-size-y: vertical resolution of touchscreen (in pixels)
> +- compatible		: must be "pixcir,pixcir_ts" or "pixcir,pixcir_tangoc"
> +- reg			: I2C address of the chip
> +- interrupts		: interrupt to which the chip is connected
> +- attb-gpio		: GPIO connected to the ATTB line of the chip
> +- touchscreen-size-x	: horizontal resolution of touchscreen (in pixels)
> +- touchscreen-size-y	: vertical resolution of touchscreen (in pixels)

Please do reformatting in a separate patch.

>  Optional properties:
> -- reset-gpio: GPIO connected to the RESET line of the chip
> +- reset-gpio		: GPIO connected to the RESET line of the chip
> +- enable-gpios		: GPIO connected to the ENABLE line of the chip
> +- wake-gpios		: GPIO connected to the WAKE line of the chip
> +- touchscreen-fuzz-x	: horizontal noise value of the absolute input
> +			    device (in pixels)
> +- touchscreen-fuzz-y	: vertical noise value of the absolute input
> +			    device (in pixels)
> +- touchscreen-inverted-x: X axis is inverted (boolean)
> +- touchscreen-inverted-y: Y axis is inverted (boolean)
> +- touchscreen-swapped-x-y	  : X and Y axis are swapped (boolean)
> +			    Swapping is done after inverting the axis

Adding these touchscreen properties are not mentioned in the subject.

>  
>  Example:
>  
> diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
> index 4b961ad..87f86b5 100644
> --- a/drivers/input/touchscreen/pixcir_i2c_ts.c
> +++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
> @@ -38,6 +38,13 @@ struct pixcir_i2c_ts_data {
>  	struct input_dev *input;
>  	struct gpio_desc *gpio_attb;
>  	struct gpio_desc *gpio_reset;
> +	struct gpio_desc *gpio_enable;
> +	struct gpio_desc *gpio_wake;
> +	u32 max_x;
> +	u32 max_y;
> +	bool invert_x;
> +	bool invert_y;
> +	bool swap_x_y;
>  	const struct pixcir_i2c_chip_data *chip;
>  	int max_fingers;	/* Max fingers supported in this instance */
>  	bool running;
> @@ -146,12 +153,27 @@ static void pixcir_ts_report(struct pixcir_i2c_ts_data *ts,
>  			slot = slots[i];
>  		}
>  
> +		if (ts->invert_x)
> +			touch->x = ts->max_x - touch->x;
> +
> +		if (ts->invert_y)
> +			touch->y = ts->max_y - touch->y;
> +
>  		input_mt_slot(ts->input, slot);
>  		input_mt_report_slot_state(ts->input,
>  					   MT_TOOL_FINGER, true);
>  
> -		input_event(ts->input, EV_ABS, ABS_MT_POSITION_X, touch->x);
> -		input_event(ts->input, EV_ABS, ABS_MT_POSITION_Y, touch->y);
> +		if (!ts->swap_x_y) {
> +			input_event(ts->input, EV_ABS, ABS_MT_POSITION_X,
> +					touch->x);
> +			input_event(ts->input, EV_ABS, ABS_MT_POSITION_Y,
> +					touch->y);
> +		} else {
> +			input_event(ts->input, EV_ABS, ABS_MT_POSITION_X,
> +					touch->y);
> +			input_event(ts->input, EV_ABS, ABS_MT_POSITION_Y,
> +					touch->x);
> +		}
>  
>  		dev_dbg(dev, "%d: slot %d, x %d, y %d\n",
>  			i, slot, touch->x, touch->y);
> @@ -194,6 +216,7 @@ static irqreturn_t pixcir_ts_isr(int irq, void *dev_id)
>  static void pixcir_reset(struct pixcir_i2c_ts_data *tsdata)
>  {
>  	if (!IS_ERR_OR_NULL(tsdata->gpio_reset)) {
> +		/* toggle reset pin */
>  		gpiod_set_value_cansleep(tsdata->gpio_reset, 1);
>  		ndelay(100);	/* datasheet section 1.2.3 says 80ns min. */
>  		gpiod_set_value_cansleep(tsdata->gpio_reset, 0);
> @@ -208,6 +231,14 @@ static int pixcir_set_power_mode(struct pixcir_i2c_ts_data *ts,
>  	struct device *dev = &ts->client->dev;
>  	int ret;
>  
> +	if (mode == PIXCIR_POWER_ACTIVE || mode == PIXCIR_POWER_IDLE) {
> +		if (!IS_ERR_OR_NULL(ts->gpio_wake)) {
> +			/* set wake pin */
> +			gpiod_set_value_cansleep(ts->gpio_wake, 1);
> +			dev_info(dev, "SET POWER: Set wake pin HIGH\n");
> +		}
> +	}
> +
>  	ret = i2c_smbus_read_byte_data(ts->client, PIXCIR_REG_POWER_MODE);
>  	if (ret < 0) {
>  		dev_err(dev, "%s: can't read reg 0x%x : %d\n",
> @@ -228,6 +259,14 @@ static int pixcir_set_power_mode(struct pixcir_i2c_ts_data *ts,
>  		return ret;
>  	}
>  
> +	if (mode == PIXCIR_POWER_HALT) {
> +		if (!IS_ERR_OR_NULL(ts->gpio_wake)) {
> +			/* set wake pin */
> +			gpiod_set_value_cansleep(ts->gpio_wake, 0);
> +			dev_info(dev, "SET POWER: Set wake pin LOW\n");
> +		}
> +	}
> +
>  	return 0;
>  }
>  
> @@ -302,6 +341,14 @@ static int pixcir_start(struct pixcir_i2c_ts_data *ts)
>  	struct device *dev = &ts->client->dev;
>  	int error;
>  
> +	if (!IS_ERR_OR_NULL(ts->gpio_enable)) {
> +		/* set enable pin */
> +		gpiod_set_value_cansleep(ts->gpio_enable, 1);
> +		dev_info(dev, "START: Set enable pin HIGH\n");
> +	}
> +
> +	msleep(100);
> +
>  	/* LEVEL_TOUCH interrupt with active low polarity */
>  	error = pixcir_set_int_mode(ts, PIXCIR_INT_LEVEL_TOUCH, 0);
>  	if (error) {
> @@ -325,6 +372,7 @@ static int pixcir_start(struct pixcir_i2c_ts_data *ts)
>  
>  static int pixcir_stop(struct pixcir_i2c_ts_data *ts)
>  {
> +	struct device *dev = &ts->client->dev;
>  	int error;
>  
>  	/* Disable interrupt generation */
> @@ -343,6 +391,12 @@ static int pixcir_stop(struct pixcir_i2c_ts_data *ts)
>  	/* Wait till running ISR is complete */
>  	synchronize_irq(ts->client->irq);
>  
> +	if (!IS_ERR_OR_NULL(ts->gpio_enable)) {
> +		/* set enable pin */
> +		gpiod_set_value_cansleep(ts->gpio_enable, 0);
> +		dev_info(dev, "STOP: Set enable pin LOW\n");
> +	}
> +
>  	return 0;
>  }
>  
> @@ -425,6 +479,7 @@ static int pixcir_parse_dt(struct device *dev,
>  			   struct pixcir_i2c_ts_data *tsdata)
>  {
>  	const struct of_device_id *match;
> +	struct device_node *np = dev->of_node;
>  
>  	match = of_match_device(of_match_ptr(pixcir_of_match), dev);
>  	if (!match)
> @@ -433,7 +488,12 @@ static int pixcir_parse_dt(struct device *dev,
>  	tsdata->chip = (const struct pixcir_i2c_chip_data *)match->data;
>  	if (!tsdata->chip)
>  		return -EINVAL;
> -
> +	
> +	/* Optional device tree properties */
> +	tsdata->swap_x_y = of_property_read_bool(np, "touchscreen-swapped-x-y");
> +	tsdata->invert_x = of_property_read_bool(np, "touchscreen-inverted-x");
> +	tsdata->invert_y = of_property_read_bool(np, "touchscreen-inverted-y");
> +	
>  	return 0;
>  }
>  #else
> @@ -490,19 +550,37 @@ static int pixcir_i2c_ts_probe(struct i2c_client *client,
>  	input->dev.parent = &client->dev;
>  
>  	if (pdata) {
> -		input_set_abs_params(input, ABS_MT_POSITION_X, 0, pdata->x_max, 0, 0);
> -		input_set_abs_params(input, ABS_MT_POSITION_Y, 0, pdata->y_max, 0, 0);
> +		if (!tsdata->swap_x_y) {
> +			input_set_abs_params(input, ABS_MT_POSITION_X, 0,
> +					     pdata->x_max, 0, 0);
> +			input_set_abs_params(input, ABS_MT_POSITION_Y, 0,
> +					     pdata->y_max, 0, 0);
> +		} else {
> +			input_set_abs_params(input, ABS_MT_POSITION_X, 0,
> +					     pdata->y_max, 0, 0);
> +			input_set_abs_params(input, ABS_MT_POSITION_Y, 0,
> +					     pdata->x_max, 0, 0);
> +		}
>  	} else {
>  		input_set_capability(input, EV_ABS, ABS_MT_POSITION_X);
>  		input_set_capability(input, EV_ABS, ABS_MT_POSITION_Y);
>  		touchscreen_parse_properties(input, true);
> -		if (!input_abs_get_max(input, ABS_MT_POSITION_X) ||
> -		    !input_abs_get_max(input, ABS_MT_POSITION_Y)) {
> +		tsdata->max_x = input_abs_get_max(input, ABS_MT_POSITION_X);
> +		tsdata->max_y = input_abs_get_max(input, ABS_MT_POSITION_Y);
> +		if (!tsdata->max_x || !tsdata->max_y) {
>  			dev_err(dev, "Touchscreen size is not specified\n");
>  			return -EINVAL;
>  		}
> +		if (tsdata->swap_x_y) {
> +			input_set_abs_params(input, ABS_MT_POSITION_X, 0,
> +					     tsdata->max_y, 0, 0);
> +			input_set_abs_params(input, ABS_MT_POSITION_Y, 0,
> +					     tsdata->max_x, 0, 0);
> +		}		
>  	}
>  
> +	
> +
>  	tsdata->max_fingers = tsdata->chip->max_fingers;
>  	if (tsdata->max_fingers > PIXCIR_MAX_SLOTS) {
>  		tsdata->max_fingers = PIXCIR_MAX_SLOTS;
> @@ -534,6 +612,24 @@ static int pixcir_i2c_ts_probe(struct i2c_client *client,
>  		return error;
>  	}
>  
> +	tsdata->gpio_wake = devm_gpiod_get(dev, "wake",
> +						     GPIOD_OUT_HIGH);
> +	if (IS_ERR(tsdata->gpio_wake)) {
> +		error = PTR_ERR(tsdata->gpio_wake);
> +		if (error != -EPROBE_DEFER)
> +			dev_err(dev, "Failed to request wake gpio: %d\n", error);
> +		return error;
> +	}
> +
> +	tsdata->gpio_enable = devm_gpiod_get(dev, "enable",
> +						     GPIOD_OUT_HIGH);
> +	if (IS_ERR(tsdata->gpio_enable)) {
> +		error = PTR_ERR(tsdata->gpio_enable);
> +		if (error != -EPROBE_DEFER)
> +			dev_err(dev, "Failed to request enable gpio: %d\n", error);
> +		return error;
> +	}
> +
>  	error = devm_request_threaded_irq(dev, client->irq, NULL, pixcir_ts_isr,
>  					  IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
>  					  client->name, tsdata);
> @@ -542,6 +638,21 @@ static int pixcir_i2c_ts_probe(struct i2c_client *client,
>  		return error;
>  	}
>  
> +
> +	if (!IS_ERR_OR_NULL(tsdata->gpio_enable)) {
> +		/* set enable pin */
> +		gpiod_set_value_cansleep(tsdata->gpio_enable, 1);
> +		dev_info(dev, "PROBE: Set enable pin HIGH\n");
> +	}
> +
> +	if (!IS_ERR_OR_NULL(tsdata->gpio_wake)) {
> +		/* set wake pin */
> +		gpiod_set_value_cansleep(tsdata->gpio_wake, 1);
> +		dev_info(dev, "PROBE: Set wake pin HIGH\n");
> +	}
> +
> +	msleep(100);
> +
>  	pixcir_reset(tsdata);
>  
>  	/* Always be in IDLE mode to save power, device supports auto wake */
> -- 
> 2.5.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

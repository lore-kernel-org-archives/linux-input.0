From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 7/7] Input: sx8654 - use common of_touchscreen functions
Date: Tue, 16 Oct 2018 10:52:00 -0700
Message-ID: <20181016175200.GE230131@dtor-ws>
References: <20181016091653.26896-1-richard.leitner@skidata.com>
 <20181016092310.27346-1-richard.leitner@skidata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181016092310.27346-1-richard.leitner@skidata.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Leitner <richard.leitner@skidata.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Oct 16, 2018 at 11:23:10AM +0200, Richard Leitner wrote:
> of_touchscreen.c provides a common interface for a axis invertion and
> swapping of touchscreens. Therefore use it in the sx8654 driver.
> 
> Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
> ---
>  drivers/input/touchscreen/sx8654.c | 37 +++++++++++++++++++------------------
>  1 file changed, 19 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/sx8654.c b/drivers/input/touchscreen/sx8654.c
> index 33f7a0be4ef8..08b064f96b4e 100644
> --- a/drivers/input/touchscreen/sx8654.c
> +++ b/drivers/input/touchscreen/sx8654.c
> @@ -36,6 +36,7 @@
>  #include <linux/gpio/consumer.h>
>  #include <linux/delay.h>
>  #include <linux/hrtimer.h>
> +#include <linux/input/touchscreen.h>
>  
>  /* register addresses */
>  #define I2C_REG_TOUCH0			0x00
> @@ -100,6 +101,7 @@ struct sx8654 {
>  	struct i2c_client *client;
>  	struct gpio_desc *gpio_reset;
>  	struct hrtimer timer;
> +	struct touchscreen_properties props;
>  
>  	const struct sx865x_data *data;
>  };
> @@ -168,8 +170,7 @@ static irqreturn_t sx8650_irq(int irq, void *handle)
>  				 chdata);
>  	}
>  
> -	input_report_abs(ts->input, ABS_X, x);
> -	input_report_abs(ts->input, ABS_Y, y);
> +	touchscreen_report_pos(ts->input, &ts->props, x, y, false);
>  	input_report_key(ts->input, BTN_TOUCH, 1);
>  	input_sync(ts->input);
>  	dev_dbg(dev, "point(%4d,%4d)\n", x, y);
> @@ -215,8 +216,8 @@ static irqreturn_t sx8654_irq(int irq, void *handle)
>  		x = ((data[0] & 0xf) << 8) | (data[1]);
>  		y = ((data[2] & 0xf) << 8) | (data[3]);
>  
> -		input_report_abs(sx8654->input, ABS_X, x);
> -		input_report_abs(sx8654->input, ABS_Y, y);
> +		touchscreen_report_pos(sx8654->input, &sx8654->props, x, y,
> +				       false);
>  		input_report_key(sx8654->input, BTN_TOUCH, 1);
>  		input_sync(sx8654->input);
>  
> @@ -355,6 +356,8 @@ static int sx8654_get_ofdata(struct sx8654 *ts)
>  	}
>  	dev_dbg(dev, "got GPIO reset pin\n");
>  

You need to mark axes used by the device before calling
touchscreen_parse_properties(), otherwise you'll get warnings if
corresponding property is present in DT.

> +	touchscreen_parse_properties(ts->input, false, &ts->props);
> +
>  	return 0;
>  }
>  #else /* CONFIG_OF */
> @@ -380,25 +383,11 @@ static int sx8654_probe(struct i2c_client *client,
>  	sx8654 = devm_kzalloc(&client->dev, sizeof(*sx8654), GFP_KERNEL);
>  	if (!sx8654)
>  		return -ENOMEM;
> -
>  	sx8654->client = client;
>  
> -	error = sx8654_get_ofdata(sx8654);
> -	if (error) {
> -		dev_err(&client->dev, "get_ofdata failed: %d\n", error);
> -		return error;
> -	}
> -
> -	if (!sx8654->data->has_irq_penrelease) {
> -		dev_dbg(&client->dev, "use timer for penrelease\n");
> -		hrtimer_init(&sx8654->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> -		sx8654->timer.function = sx865x_penrelease_timer_handler;
> -	}
> -
>  	input = devm_input_allocate_device(&client->dev);
>  	if (!input)
>  		return -ENOMEM;
> -
>  	sx8654->input = input;
>  
>  	input->name = "SX8654 I2C Touchscreen";
> @@ -414,6 +403,18 @@ static int sx8654_probe(struct i2c_client *client,
>  
>  	input_set_drvdata(sx8654->input, sx8654);
>  
> +	error = sx8654_get_ofdata(sx8654);
> +	if (error) {
> +		dev_err(&client->dev, "get_ofdata failed: %d\n", error);
> +		return error;
> +	}
> +
> +	if (!sx8654->data->has_irq_penrelease) {
> +		dev_dbg(&client->dev, "use timer for penrelease\n");
> +		hrtimer_init(&sx8654->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +		sx8654->timer.function = sx865x_penrelease_timer_handler;
> +	}
> +
>  	error = sx8654_reset(sx8654);
>  	if (error) {
>  		dev_err(&client->dev, "reset failed");
> -- 
> 2.11.0
> 

-- 
Dmitry

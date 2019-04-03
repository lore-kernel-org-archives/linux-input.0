From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v7 2/4] Input: goodix - Add regulators suppot
Date: Wed, 3 Apr 2019 16:09:22 -0700
Message-ID: <20190403230922.GG53104@dtor-ws>
References: <20190321082104.2874-1-jagan@amarulasolutions.com>
 <20190321082104.2874-3-jagan@amarulasolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190321082104.2874-3-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Bastien Nocera <hadess@hadess.net>, Rob Herring <robh+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, linux-amarula@amarulasolutions.com, Michael Trimarchi <michael@amarulasolutions.com>
List-Id: linux-input@vger.kernel.org

Hi Jagan,

On Thu, Mar 21, 2019 at 01:51:02PM +0530, Jagan Teki wrote:
> Goodix CTP controllers require AVDD28, VDDIO regulators for power-on
> sequence.
> 
> The delay between these regualtor operations as per Power-on Timing
> from datasheet[1] is 0 (T1 >= 0 usec).
> 
> So, enable and disable these regulators in proper order using normal
> regulator functions without any delay in between.
> 
> [1] GT5663 Datasheet_English_20151106_Rev.01
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  drivers/input/touchscreen/goodix.c | 58 ++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
> index f57d82220a88..de5b80a08f41 100644
> --- a/drivers/input/touchscreen/goodix.c
> +++ b/drivers/input/touchscreen/goodix.c
> @@ -27,6 +27,7 @@
>  #include <linux/delay.h>
>  #include <linux/irq.h>
>  #include <linux/interrupt.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
>  #include <linux/acpi.h>
>  #include <linux/of.h>
> @@ -47,6 +48,8 @@ struct goodix_ts_data {
>  	struct touchscreen_properties prop;
>  	unsigned int max_touch_num;
>  	unsigned int int_trigger_type;
> +	struct regulator *avdd28;
> +	struct regulator *vddio;
>  	struct gpio_desc *gpiod_int;
>  	struct gpio_desc *gpiod_rst;
>  	u16 id;
> @@ -532,6 +535,24 @@ static int goodix_get_gpio_config(struct goodix_ts_data *ts)
>  		return -EINVAL;
>  	dev = &ts->client->dev;
>  
> +	ts->avdd28 = devm_regulator_get(dev, "AVDD28");
> +	if (IS_ERR(ts->avdd28)) {
> +		error = PTR_ERR(ts->avdd28);
> +		if (error != -EPROBE_DEFER)
> +			dev_err(dev,
> +				"Failed to get AVDD28 regulator: %d\n", error);
> +		return error;
> +	}
> +
> +	ts->vddio = devm_regulator_get(dev, "VDDIO");
> +	if (IS_ERR(ts->vddio)) {
> +		error = PTR_ERR(ts->vddio);
> +		if (error != -EPROBE_DEFER)
> +			dev_err(dev,
> +				"Failed to get VDDIO regulator: %d\n", error);
> +		return error;
> +	}
> +
>  	/* Get the interrupt GPIO pin number */
>  	gpiod = devm_gpiod_get_optional(dev, GOODIX_GPIO_INT_NAME, GPIOD_IN);
>  	if (IS_ERR(gpiod)) {
> @@ -764,6 +785,17 @@ static void goodix_config_cb(const struct firmware *cfg, void *ctx)
>  	complete_all(&ts->firmware_loading_complete);
>  }
>  
> +static void goodix_disable_regulator(void *arg)
> +{
> +	struct goodix_ts_data *ts = arg;
> +
> +	if (!IS_ERR(ts->vddio))
> +		regulator_disable(ts->vddio);

We error out of goodix_get_gpio_config() and abort probe() if
devm_regulator_get() fails, so there is no need to check for errors
here.

> +
> +	if (!IS_ERR(ts->avdd28))
> +		regulator_disable(ts->avdd28);
> +}
> +
>  static int goodix_ts_probe(struct i2c_client *client,
>  			   const struct i2c_device_id *id)
>  {
> @@ -789,6 +821,32 @@ static int goodix_ts_probe(struct i2c_client *client,
>  	if (error)
>  		return error;
>  
> +	error = devm_add_action_or_reset(&client->dev,
> +					 goodix_disable_regulator, ts);
> +	if (error)
> +		return error;

We need to do this after enabling regulators, otherwise there is a risk
of unbalanced disable.

I adjusted and applied, thank you.

-- 
Dmitry

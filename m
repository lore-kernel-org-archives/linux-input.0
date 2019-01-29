From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RESEND PATCH v2 2/8] Input: sx8654 - add reset-gpio support
Date: Mon, 28 Jan 2019 16:26:17 -0800
Message-ID: <20190129002617.GJ34692@dtor-ws>
References: <20181218083606.25795-1-richard.leitner@skidata.com>
 <20181218083606.25795-3-richard.leitner@skidata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181218083606.25795-3-richard.leitner@skidata.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Leitner <richard.leitner@skidata.com>
Cc: mark.rutland@arm.com, robh+dt@kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Dec 18, 2018 at 09:36:00AM +0100, Richard Leitner wrote:
> The sx8654 features a NRST input which may be connected to a GPIO.
> Therefore add support for hard-resetting the sx8654 via this NRST.
> 
> If the reset-gpio property is provided the sx8654 is resetted via NRST
> instead of the soft-reset via I2C.
> 
> Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
> ---
>  drivers/input/touchscreen/sx8654.c | 40 +++++++++++++++++++++++++++++++++++---
>  1 file changed, 37 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/sx8654.c b/drivers/input/touchscreen/sx8654.c
> index ed29db3ec731..238f56b1581b 100644
> --- a/drivers/input/touchscreen/sx8654.c
> +++ b/drivers/input/touchscreen/sx8654.c
> @@ -33,6 +33,8 @@
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/delay.h>
>  
>  /* register addresses */
>  #define I2C_REG_TOUCH0			0x00
> @@ -74,6 +76,7 @@
>  struct sx8654 {
>  	struct input_dev *input;
>  	struct i2c_client *client;
> +	struct gpio_desc *gpio_reset;
>  };
>  
>  static irqreturn_t sx8654_irq(int irq, void *handle)
> @@ -124,6 +127,27 @@ static irqreturn_t sx8654_irq(int irq, void *handle)
>  	return IRQ_HANDLED;
>  }
>  
> +static int sx8654_reset(struct sx8654 *ts)
> +{
> +	int err;
> +
> +	if (ts->gpio_reset) {
> +		gpiod_set_value_cansleep(ts->gpio_reset, 1);
> +		udelay(2); /* Tpulse > 1µs */
> +		gpiod_set_value_cansleep(ts->gpio_reset, 0);
> +
> +		return 0;

I rearranged code a bit to avoid this early return and applied. Thank
you.

> +	}
> +
> +	dev_dbg(&ts->client->dev, "NRST unavailable, try softreset\n");
> +	err = i2c_smbus_write_byte_data(ts->client, I2C_REG_SOFTRESET,
> +					SOFTRESET_VALUE);
> +	if (err)
> +		return err;
> +	else
> +		return 0;
> +}
> +
>  static int sx8654_open(struct input_dev *dev)
>  {
>  	struct sx8654 *sx8654 = input_get_drvdata(dev);
> @@ -186,6 +210,17 @@ static int sx8654_probe(struct i2c_client *client,
>  	if (!sx8654)
>  		return -ENOMEM;
>  
> +	sx8654->gpio_reset = devm_gpiod_get_optional(&client->dev, "reset",
> +						     GPIOD_OUT_HIGH);
> +	if (IS_ERR(sx8654->gpio_reset)) {
> +		error = PTR_ERR(sx8654->gpio_reset);
> +		if (error != -EPROBE_DEFER)
> +			dev_err(&client->dev, "unable to get reset-gpio: %d\n",
> +				error);
> +		return error;
> +	}
> +	dev_dbg(&client->dev, "got GPIO reset pin\n");
> +
>  	input = devm_input_allocate_device(&client->dev);
>  	if (!input)
>  		return -ENOMEM;
> @@ -206,10 +241,9 @@ static int sx8654_probe(struct i2c_client *client,
>  
>  	input_set_drvdata(sx8654->input, sx8654);
>  
> -	error = i2c_smbus_write_byte_data(client, I2C_REG_SOFTRESET,
> -					  SOFTRESET_VALUE);
> +	error = sx8654_reset(sx8654);
>  	if (error) {
> -		dev_err(&client->dev, "writing softreset value failed");
> +		dev_err(&client->dev, "reset failed");
>  		return error;
>  	}
>  
> -- 
> 2.11.0
> 

-- 
Dmitry

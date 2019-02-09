From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: st1232 - switch to gpiod API
Date: Sat, 9 Feb 2019 08:54:56 -0800
Message-ID: <20190209165456.GD197782@dtor-ws>
References: <20190208161533.25230-1-martin.kepplinger@ginzinger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190208161533.25230-1-martin.kepplinger@ginzinger.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Kepplinger <martin.kepplinger@ginzinger.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Feb 08, 2019 at 05:15:33PM +0100, Martin Kepplinger wrote:
> Use devm_gpiod_get_optional() and gpiod_set_value_cansleep() instead
> of the old API. The st1232_ts_power() now passes on the inverted "poweron"
> value to reflect the correct logical value.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>

Applied, thank you.

> ---
> 
> ok. tested. If i get that right, assigning different gpio functions
> would now be difficult, but afaik isn't needed anyways.
> 
> thanks
>                                   martin
> 
> 
> 
> revision history
> ----------------
> v2: retain dts compatibility by allowing current reset-gpios setting
> 
> 
>  drivers/input/touchscreen/st1232.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
> index 634d6c243845..1fbc0847416b 100644
> --- a/drivers/input/touchscreen/st1232.c
> +++ b/drivers/input/touchscreen/st1232.c
> @@ -45,7 +45,7 @@ struct st1232_ts_data {
>  	struct i2c_client *client;
>  	struct input_dev *input_dev;
>  	struct dev_pm_qos_request low_latency_req;
> -	int reset_gpio;
> +	struct gpio_desc *reset_gpio;
>  	const struct st_chip_info *chip_info;
>  	int read_buf_len;
>  	u8 *read_buf;
> @@ -142,8 +142,8 @@ static irqreturn_t st1232_ts_irq_handler(int irq, void *dev_id)
>  
>  static void st1232_ts_power(struct st1232_ts_data *ts, bool poweron)
>  {
> -	if (gpio_is_valid(ts->reset_gpio))
> -		gpio_direction_output(ts->reset_gpio, poweron);
> +	if (ts->reset_gpio)
> +		gpiod_set_value_cansleep(ts->reset_gpio, !poweron);
>  }
>  
>  static const struct st_chip_info st1232_chip_info = {
> @@ -215,15 +215,13 @@ static int st1232_ts_probe(struct i2c_client *client,
>  	ts->client = client;
>  	ts->input_dev = input_dev;
>  
> -	ts->reset_gpio = of_get_gpio(client->dev.of_node, 0);
> -	if (gpio_is_valid(ts->reset_gpio)) {
> -		error = devm_gpio_request(&client->dev, ts->reset_gpio, NULL);
> -		if (error) {
> -			dev_err(&client->dev,
> -				"Unable to request GPIO pin %d.\n",
> -				ts->reset_gpio);
> -				return error;
> -		}
> +	ts->reset_gpio = devm_gpiod_get_optional(&client->dev, NULL,
> +						 GPIOD_OUT_HIGH);
> +	if (IS_ERR(ts->reset_gpio)) {
> +		error = PTR_ERR(ts->reset_gpio);
> +		dev_err(&client->dev, "Unable to request GPIO pin: %d.\n",
> +			error);
> +		return error;
>  	}
>  
>  	st1232_ts_power(ts, true);
> -- 
> 2.20.1
> 



-- 
Dmitry

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 1/1] cap11xx: add runtime PM support
Date: Sun, 16 Aug 2015 23:24:14 -0700
Message-ID: <20150817062414.GB31482@dtor-ws>
References: <1435292423-20895-1-git-send-email-mranostay@gmail.com>
 <1435292423-20895-2-git-send-email-mranostay@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1435292423-20895-2-git-send-email-mranostay@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Matt Ranostay <mranostay@gmail.com>
Cc: linux-input@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Matt,

On Thu, Jun 25, 2015 at 09:20:23PM -0700, Matt Ranostay wrote:
> Puts device into DEEP SLEEP when no LEDs are in in the on-state, and no
> input_handlers are in use. Also uses *_autosuspend to prevent a LED
> trigger from constantly suspending and resuming device.
> 
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
> ---
>  drivers/input/keyboard/cap11xx.c | 84 +++++++++++++++++++++++++++++++---------
>  1 file changed, 66 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/cap11xx.c
> index b983b5a..51aad6d 100644
> --- a/drivers/input/keyboard/cap11xx.c
> +++ b/drivers/input/keyboard/cap11xx.c
> @@ -14,6 +14,7 @@
>  #include <linux/input.h>
>  #include <linux/leds.h>
>  #include <linux/of_irq.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  #include <linux/i2c.h>
>  #include <linux/gpio/consumer.h>
> @@ -84,9 +85,9 @@ struct cap11xx_led {
>  struct cap11xx_priv {
>  	struct regmap *regmap;
>  	struct input_dev *idev;
> +	struct i2c_client *i2c_client;
>  
>  	struct cap11xx_led *leds;
> -	int num_leds;
>  
>  	/* config */
>  	u32 keycodes[];
> @@ -205,32 +206,34 @@ out:
>  	return IRQ_HANDLED;
>  }
>  
> +#ifdef CONFIG_PM
>  static int cap11xx_set_sleep(struct cap11xx_priv *priv, bool sleep)
>  {
> -#ifdef CONFIG_LEDS_CLASS
> -	/*
> -	 * DLSEEP mode will turn off all LEDS, prevent this
> -	 */
> -	if (priv->num_leds)
> -		return 0;
> -#endif
>  	return regmap_update_bits(priv->regmap, CAP11XX_REG_MAIN_CONTROL,
>  				  CAP11XX_REG_MAIN_CONTROL_DLSEEP,
>  				  sleep ? CAP11XX_REG_MAIN_CONTROL_DLSEEP : 0);
>  }
> +#else
> +static int cap11xx_set_sleep(struct cap11xx_priv *priv, bool sleep)
> +{
> +	return 0;
> +}
> +#endif
>  
>  static int cap11xx_input_open(struct input_dev *idev)
>  {
>  	struct cap11xx_priv *priv = input_get_drvdata(idev);
>  
> -	return cap11xx_set_sleep(priv, false);
> +	pm_runtime_get(&priv->i2c_client->dev);
> +
> +	return 0;
>  }
>  
>  static void cap11xx_input_close(struct input_dev *idev)
>  {
>  	struct cap11xx_priv *priv = input_get_drvdata(idev);
>  
> -	cap11xx_set_sleep(priv, true);
> +	pm_runtime_put_autosuspend(&priv->i2c_client->dev);
>  }
>  
>  #ifdef CONFIG_LEDS_CLASS
> @@ -252,10 +255,16 @@ static void cap11xx_led_set(struct led_classdev *cdev,
>  			   enum led_brightness value)
>  {
>  	struct cap11xx_led *led = container_of(cdev, struct cap11xx_led, cdev);
> +	struct cap11xx_priv *priv = led->priv;
>  
>  	if (led->new_brightness == value)
>  		return;
>  
> +	if (value)
> +		pm_runtime_get(&priv->i2c_client->dev);
> +	else
> +		pm_runtime_put_autosuspend(&priv->i2c_client->dev);
> +
>  	led->new_brightness = value;
>  	schedule_work(&led->work);
>  }
> @@ -312,7 +321,6 @@ static int cap11xx_init_leds(struct device *dev,
>  		error = devm_led_classdev_register(dev, &led->cdev);
>  		if (error < 0)
>  			return -EINVAL;
> -		priv->num_leds++;
>  		led++;
>  	};
>  
> @@ -446,17 +454,23 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_client,
>  	priv->idev->open = cap11xx_input_open;
>  	priv->idev->close = cap11xx_input_close;
>  
> -	error = cap11xx_init_leds(dev, priv, cap->num_leds);
> +	error = cap11xx_set_sleep(priv, true);
>  	if (error)
>  		return error;
>  
> -	input_set_drvdata(priv->idev, priv);
> +	error = pm_runtime_set_active(dev);
> +	if (error)
> +		return error;
>  
> -	/*
> -	 * Put the device in deep sleep mode for now.
> -	 * ->open() will bring it back once the it is actually needed.
> -	 */
> -	cap11xx_set_sleep(priv, true);
> +	pm_runtime_enable(dev);
> +	pm_runtime_set_autosuspend_delay(dev, 1000);
> +	pm_runtime_use_autosuspend(dev);
> +
> +	error = cap11xx_init_leds(dev, priv, cap->num_leds);
> +	if (error)
> +		return error;
> +	priv->i2c_client = i2c_client;
> +	input_set_drvdata(priv->idev, priv);
>  
>  	error = input_register_device(priv->idev);
>  	if (error)
> @@ -476,6 +490,17 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_client,
>  	return 0;
>  }
>  
> +static int cap11xx_i2c_remove(struct i2c_client *i2c_client)
> +{
> +	struct cap11xx_priv *priv = i2c_get_clientdata(i2c_client);
> +
> +	pm_runtime_disable(&i2c_client->dev);
> +	pm_runtime_set_suspended(&i2c_client->dev);
> +	cap11xx_set_sleep(priv, true);

This violates ordering: the leds and input device are still open and may
get requests while you are putting the device to sleep.

Thanks.

-- 
Dmitry

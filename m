From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [PATCH v2] Input: cap11xx - switch to using
 set_brightness_blocking()
Date: Fri, 8 Feb 2019 22:37:00 +0100
Message-ID: <1a610ebf-6fbd-2846-b57c-ef4e1f4e2dd5@gmail.com>
References: <20190208075739.GA95091@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190208075739.GA95091@dtor-ws>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sven Van Asbroeck <TheSven73@googlemail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

Thank you for the update.

On 2/8/19 8:57 AM, Dmitry Torokhov wrote:
> Updating LED state requires access to regmap and therefore we may sleep,
> so we could not do that directly form set_brightness() method.
> Historically we used private work to adjust the brightness, but with the
> introduction of set_brightness_blocking() we no longer need it.
> 
> As a bonus, not having our own work item means we do not have
> use-after-free issue as we neglected to cancel outstanding work on
> driver unbind.
> 
> Reported-by: Sven Van Asbroeck <thesven73@gmail.com>
> Reviewed-by: Sven Van Asbroeck <TheSven73@googlemail.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> 
> v2: no longer checking current brightness before trying to update since
>      regmap should take care of caching and skipping updates when needed
>      (Jacek).
> 
>   drivers/input/keyboard/cap11xx.c | 35 ++++++++++----------------------
>   1 file changed, 11 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/cap11xx.c
> index 312916f99597..73686c2460ce 100644
> --- a/drivers/input/keyboard/cap11xx.c
> +++ b/drivers/input/keyboard/cap11xx.c
> @@ -75,9 +75,7 @@
>   struct cap11xx_led {
>   	struct cap11xx_priv *priv;
>   	struct led_classdev cdev;
> -	struct work_struct work;
>   	u32 reg;
> -	enum led_brightness new_brightness;
>   };
>   #endif
>   
> @@ -233,30 +231,21 @@ static void cap11xx_input_close(struct input_dev *idev)
>   }
>   
>   #ifdef CONFIG_LEDS_CLASS
> -static void cap11xx_led_work(struct work_struct *work)
> +static int cap11xx_led_set(struct led_classdev *cdev,
> +			    enum led_brightness value)
>   {
> -	struct cap11xx_led *led = container_of(work, struct cap11xx_led, work);
> +	struct cap11xx_led *led = container_of(cdev, struct cap11xx_led, cdev);
>   	struct cap11xx_priv *priv = led->priv;
> -	int value = led->new_brightness;
>   
>   	/*
> -	 * All LEDs share the same duty cycle as this is a HW limitation.
> -	 * Brightness levels per LED are either 0 (OFF) and 1 (ON).
> +	 * All LEDs share the same duty cycle as this is a HW
> +	 * limitation. Brightness levels per LED are either
> +	 * 0 (OFF) and 1 (ON).
>   	 */
> -	regmap_update_bits(priv->regmap, CAP11XX_REG_LED_OUTPUT_CONTROL,
> -				BIT(led->reg), value ? BIT(led->reg) : 0);
> -}
> -
> -static void cap11xx_led_set(struct led_classdev *cdev,
> -			   enum led_brightness value)
> -{
> -	struct cap11xx_led *led = container_of(cdev, struct cap11xx_led, cdev);
> -
> -	if (led->new_brightness == value)
> -		return;
> -
> -	led->new_brightness = value;
> -	schedule_work(&led->work);
> +	return regmap_update_bits(priv->regmap,
> +				  CAP11XX_REG_LED_OUTPUT_CONTROL,
> +				  BIT(led->reg),
> +				  value ? BIT(led->reg) : 0);
>   }
>   
>   static int cap11xx_init_leds(struct device *dev,
> @@ -299,7 +288,7 @@ static int cap11xx_init_leds(struct device *dev,
>   		led->cdev.default_trigger =
>   			of_get_property(child, "linux,default-trigger", NULL);
>   		led->cdev.flags = 0;
> -		led->cdev.brightness_set = cap11xx_led_set;
> +		led->cdev.brightness_set_blocking = cap11xx_led_set;
>   		led->cdev.max_brightness = 1;
>   		led->cdev.brightness = LED_OFF;
>   
> @@ -312,8 +301,6 @@ static int cap11xx_init_leds(struct device *dev,
>   		led->reg = reg;
>   		led->priv = priv;
>   
> -		INIT_WORK(&led->work, cap11xx_led_work);
> -
>   		error = devm_led_classdev_register(dev, &led->cdev);
>   		if (error) {
>   			of_node_put(child);
> 

Acked-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>

-- 
Best regards,
Jacek Anaszewski

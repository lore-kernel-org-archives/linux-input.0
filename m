From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] cap11xx: add runtime PM support
Date: Thu, 25 Jun 2015 17:46:24 +0200
Message-ID: <CAPDyKFqy0=+C5HUYAQV0f1-n7dfgBc7a_v0eueJHKk=80-gJGQ@mail.gmail.com>
References: <1435203465-11592-1-git-send-email-mranostay@gmail.com>
	<1435203465-11592-2-git-send-email-mranostay@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1435203465-11592-2-git-send-email-mranostay@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Matt Ranostay <mranostay@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On 25 June 2015 at 05:37, Matt Ranostay <mranostay@gmail.com> wrote:
> Puts device into DEEP SLEEP when no LEDs are in in the on-state, and no
> input_handlers are in use. Also uses *_autosuspend to prevent a LED
> trigger from constantly suspending and resuming device.
>
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
> ---
>  drivers/input/keyboard/cap11xx.c | 75 ++++++++++++++++++++++++++++++----------
>  1 file changed, 57 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/cap11xx.c
> index b983b5a..4dc7690 100644
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
>         struct regmap *regmap;
>         struct input_dev *idev;
> +       struct i2c_client *i2c_client;
>
>         struct cap11xx_led *leds;
> -       int num_leds;
>
>         /* config */
>         u32 keycodes[];
> @@ -207,13 +208,6 @@ out:
>
>  static int cap11xx_set_sleep(struct cap11xx_priv *priv, bool sleep)
>  {
> -#ifdef CONFIG_LEDS_CLASS
> -       /*
> -        * DLSEEP mode will turn off all LEDS, prevent this
> -        */
> -       if (priv->num_leds)
> -               return 0;
> -#endif
>         return regmap_update_bits(priv->regmap, CAP11XX_REG_MAIN_CONTROL,
>                                   CAP11XX_REG_MAIN_CONTROL_DLSEEP,
>                                   sleep ? CAP11XX_REG_MAIN_CONTROL_DLSEEP : 0);
> @@ -223,14 +217,16 @@ static int cap11xx_input_open(struct input_dev *idev)
>  {
>         struct cap11xx_priv *priv = input_get_drvdata(idev);
>
> -       return cap11xx_set_sleep(priv, false);
> +       pm_runtime_get(&priv->i2c_client->dev);
> +
> +       return 0;
>  }
>
>  static void cap11xx_input_close(struct input_dev *idev)
>  {
>         struct cap11xx_priv *priv = input_get_drvdata(idev);
>
> -       cap11xx_set_sleep(priv, true);
> +       pm_runtime_put_autosuspend(&priv->i2c_client->dev);
>  }
>
>  #ifdef CONFIG_LEDS_CLASS
> @@ -252,10 +248,16 @@ static void cap11xx_led_set(struct led_classdev *cdev,
>                            enum led_brightness value)
>  {
>         struct cap11xx_led *led = container_of(cdev, struct cap11xx_led, cdev);
> +       struct cap11xx_priv *priv = led->priv;
>
>         if (led->new_brightness == value)
>                 return;
>
> +       if (value)
> +               pm_runtime_get(&priv->i2c_client->dev);
> +       else
> +               pm_runtime_put_autosuspend(&priv->i2c_client->dev);
> +
>         led->new_brightness = value;
>         schedule_work(&led->work);
>  }
> @@ -312,7 +314,6 @@ static int cap11xx_init_leds(struct device *dev,
>                 error = devm_led_classdev_register(dev, &led->cdev);
>                 if (error < 0)
>                         return -EINVAL;
> -               priv->num_leds++;
>                 led++;
>         };
>
> @@ -446,17 +447,23 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_client,
>         priv->idev->open = cap11xx_input_open;
>         priv->idev->close = cap11xx_input_close;
>
> -       error = cap11xx_init_leds(dev, priv, cap->num_leds);
> +       error = cap11xx_set_sleep(priv, true);
>         if (error)
>                 return error;
>
> -       input_set_drvdata(priv->idev, priv);
> +       error = pm_runtime_set_active(dev);
> +       if (error)
> +               return error;
>
> -       /*
> -        * Put the device in deep sleep mode for now.
> -        * ->open() will bring it back once the it is actually needed.
> -        */
> -       cap11xx_set_sleep(priv, true);
> +       pm_runtime_enable(dev);
> +       pm_runtime_set_autosuspend_delay(dev, 1000);
> +       pm_runtime_use_autosuspend(dev);
> +
> +       error = cap11xx_init_leds(dev, priv, cap->num_leds);
> +       if (error)
> +               return error;
> +       priv->i2c_client = i2c_client;
> +       input_set_drvdata(priv->idev, priv);
>
>         error = input_register_device(priv->idev);
>         if (error)
> @@ -476,6 +483,17 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_client,
>         return 0;
>  }
>
> +static int cap11xx_i2c_remove(struct i2c_client *i2c_client)
> +{
> +       struct cap11xx_priv *priv = i2c_get_clientdata(i2c_client);
> +
> +       pm_runtime_disable(&i2c_client->dev);
> +       pm_runtime_set_suspended(&i2c_client->dev);
> +       cap11xx_set_sleep(priv, true);
> +
> +       return 0;
> +}
> +
>  static const struct of_device_id cap11xx_dt_ids[] = {
>         { .compatible = "microchip,cap1106", },
>         { .compatible = "microchip,cap1126", },
> @@ -492,14 +510,35 @@ static const struct i2c_device_id cap11xx_i2c_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, cap11xx_i2c_ids);
>

You should add:

#ifdef CONFIG_PM

around the runtime PM callbacks. It will prevent compiler warnings
about unused functions when building with CONFIG_PM unset.

> +static int cap11xx_runtime_suspend(struct device *dev)
> +{
> +       struct cap11xx_priv *priv = i2c_get_clientdata(to_i2c_client(dev));
> +
> +       return cap11xx_set_sleep(priv, true);
> +}
> +
> +static int cap11xx_runtime_resume(struct device *dev)
> +{
> +       struct cap11xx_priv *priv = i2c_get_clientdata(to_i2c_client(dev));
> +
> +       return cap11xx_set_sleep(priv, false);
> +}
> +
> +static const struct dev_pm_ops cap11xx_pm_ops = {
> +       SET_RUNTIME_PM_OPS(cap11xx_runtime_suspend,
> +                          cap11xx_runtime_resume, NULL)
> +};
> +
>  static struct i2c_driver cap11xx_i2c_driver = {
>         .driver = {
>                 .name   = "cap11xx",
>                 .owner  = THIS_MODULE,
>                 .of_match_table = cap11xx_dt_ids,
> +               .pm     = &cap11xx_pm_ops,
>         },
>         .id_table       = cap11xx_i2c_ids,
>         .probe          = cap11xx_i2c_probe,
> +       .remove         = cap11xx_i2c_remove,
>  };
>
>  module_i2c_driver(cap11xx_i2c_driver);
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Kind regards
Uffe

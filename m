From: Matt Ranostay <mranostay@gmail.com>
Subject: Re: [PATCH v4 1/1] cap11xx: add runtime PM support
Date: Wed, 16 Sep 2015 23:39:26 -0700
Message-ID: <FAA0B6A7-6204-4E08-A422-E8A05B1EAFD3@gmail.com>
References: <1440364677-1016-1-git-send-email-mranostay@gmail.com> <1440364677-1016-2-git-send-email-mranostay@gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34175 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753355AbbIQGja convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Sep 2015 02:39:30 -0400
Received: by padhy16 with SMTP id hy16so11761741pad.1
        for <linux-input@vger.kernel.org>; Wed, 16 Sep 2015 23:39:30 -0700 (PDT)
In-Reply-To: <1440364677-1016-2-git-send-email-mranostay@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Poke for comments on this :)

> On Aug 23, 2015, at 14:17, Matt Ranostay <mranostay@gmail.com> wrote:
> 
> Puts device into DEEP SLEEP when no LEDs are in in the on-state, and no
> input_handlers are in use. Also uses *_autosuspend to prevent a LED
> trigger from constantly suspending and resuming device.
> 
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
> ---
> drivers/input/keyboard/cap11xx.c | 84 +++++++++++++++++++++++++++++++---------
> 1 file changed, 65 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/cap11xx.c
> index 378db10..13fae03 100644
> --- a/drivers/input/keyboard/cap11xx.c
> +++ b/drivers/input/keyboard/cap11xx.c
> @@ -14,6 +14,7 @@
> #include <linux/input.h>
> #include <linux/leds.h>
> #include <linux/of_irq.h>
> +#include <linux/pm_runtime.h>
> #include <linux/regmap.h>
> #include <linux/i2c.h>
> #include <linux/gpio/consumer.h>
> @@ -84,9 +85,9 @@ struct cap11xx_led {
> struct cap11xx_priv {
>    struct regmap *regmap;
>    struct input_dev *idev;
> +    struct i2c_client *i2c_client;
> 
>    struct cap11xx_led *leds;
> -    int num_leds;
> 
>    /* config */
>    u32 keycodes[];
> @@ -207,12 +208,6 @@ out:
> 
> static int cap11xx_set_sleep(struct cap11xx_priv *priv, bool sleep)
> {
> -    /*
> -     * DLSEEP mode will turn off all LEDS, prevent this
> -     */
> -    if (IS_ENABLED(CONFIG_LEDS_CLASS) && priv->num_leds)
> -        return 0;
> -
>    return regmap_update_bits(priv->regmap, CAP11XX_REG_MAIN_CONTROL,
>                  CAP11XX_REG_MAIN_CONTROL_DLSEEP,
>                  sleep ? CAP11XX_REG_MAIN_CONTROL_DLSEEP : 0);
> @@ -222,14 +217,16 @@ static int cap11xx_input_open(struct input_dev *idev)
> {
>    struct cap11xx_priv *priv = input_get_drvdata(idev);
> 
> -    return cap11xx_set_sleep(priv, false);
> +    pm_runtime_get(&priv->i2c_client->dev);
> +
> +    return 0;
> }
> 
> static void cap11xx_input_close(struct input_dev *idev)
> {
>    struct cap11xx_priv *priv = input_get_drvdata(idev);
> 
> -    cap11xx_set_sleep(priv, true);
> +    pm_runtime_put_autosuspend(&priv->i2c_client->dev);
> }
> 
> #ifdef CONFIG_LEDS_CLASS
> @@ -251,10 +248,16 @@ static void cap11xx_led_set(struct led_classdev *cdev,
>               enum led_brightness value)
> {
>    struct cap11xx_led *led = container_of(cdev, struct cap11xx_led, cdev);
> +    struct cap11xx_priv *priv = led->priv;
> 
>    if (led->new_brightness == value)
>        return;
> 
> +    if (value)
> +        pm_runtime_get(&priv->i2c_client->dev);
> +    else
> +        pm_runtime_put_autosuspend(&priv->i2c_client->dev);
> +
>    led->new_brightness = value;
>    schedule_work(&led->work);
> }
> @@ -315,8 +318,6 @@ static int cap11xx_init_leds(struct device *dev,
>        error = devm_led_classdev_register(dev, &led->cdev);
>        if (error)
>            return error;
> -
> -        priv->num_leds++;
>        led++;
>    }
> 
> @@ -330,6 +331,16 @@ static int cap11xx_init_leds(struct device *dev,
> }
> #endif
> 
> +static void cap11xx_shutdown_act(void *data)
> +{
> +    struct i2c_client *i2c_client = data;
> +    struct cap11xx_priv *priv = i2c_get_clientdata(i2c_client);
> +
> +    cap11xx_set_sleep(priv, true);
> +    pm_runtime_disable(&i2c_client->dev);
> +    pm_runtime_set_suspended(&i2c_client->dev);
> +}
> +
> static int cap11xx_i2c_probe(struct i2c_client *i2c_client,
>                 const struct i2c_device_id *id)
> {
> @@ -363,6 +374,14 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_client,
>    if (IS_ERR(priv->regmap))
>        return PTR_ERR(priv->regmap);
> 
> +    error = devm_add_action(dev, cap11xx_shutdown_act, i2c_client);
> +    if (error) {
> +        dev_err(dev, "failed to register remove action\n");
> +        return error;
> +    }
> +    i2c_set_clientdata(i2c_client, priv);
> +    priv->i2c_client = i2c_client;
> +
>    error = regmap_read(priv->regmap, CAP11XX_REG_PRODUCT_ID, &val);
>    if (error)
>        return error;
> @@ -388,7 +407,6 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_client,
>        return error;
> 
>    dev_info(dev, "CAP11XX detected, revision 0x%02x\n", rev);
> -    i2c_set_clientdata(i2c_client, priv);
>    node = dev->of_node;
> 
>    if (!of_property_read_u32(node, "microchip,sensor-gain", &gain32)) {
> @@ -450,22 +468,28 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_client,
>    priv->idev->open = cap11xx_input_open;
>    priv->idev->close = cap11xx_input_close;
> 
> -    error = cap11xx_init_leds(dev, priv, cap->num_leds);
> +    error = cap11xx_set_sleep(priv, true);
>    if (error)
>        return error;
> 
> -    input_set_drvdata(priv->idev, priv);
> +    error = pm_runtime_set_active(dev);
> +    if (error)
> +        return error;
> 
> -    /*
> -     * Put the device in deep sleep mode for now.
> -     * ->open() will bring it back once the it is actually needed.
> -     */
> -    cap11xx_set_sleep(priv, true);
> +    pm_runtime_enable(dev);
> +    pm_runtime_set_autosuspend_delay(dev, 1000);
> +    pm_runtime_use_autosuspend(dev);
> +
> +    input_set_drvdata(priv->idev, priv);
> 
>    error = input_register_device(priv->idev);
>    if (error)
>        return error;
> 
> +    error = cap11xx_init_leds(dev, priv, cap->num_leds);
> +    if (error)
> +        return error;
> +
>    irq = irq_of_parse_and_map(node, 0);
>    if (!irq) {
>        dev_err(dev, "Unable to parse or map IRQ\n");
> @@ -496,10 +520,32 @@ static const struct i2c_device_id cap11xx_i2c_ids[] = {
> };
> MODULE_DEVICE_TABLE(i2c, cap11xx_i2c_ids);
> 
> +#ifdef CONFIG_PM
> +static int cap11xx_runtime_suspend(struct device *dev)
> +{
> +    struct cap11xx_priv *priv = i2c_get_clientdata(to_i2c_client(dev));
> +
> +    return cap11xx_set_sleep(priv, true);
> +}
> +
> +static int cap11xx_runtime_resume(struct device *dev)
> +{
> +    struct cap11xx_priv *priv = i2c_get_clientdata(to_i2c_client(dev));
> +
> +    return cap11xx_set_sleep(priv, false);
> +}
> +#endif
> +
> +static const struct dev_pm_ops cap11xx_pm_ops = {
> +    SET_RUNTIME_PM_OPS(cap11xx_runtime_suspend,
> +               cap11xx_runtime_resume, NULL)
> +};
> +
> static struct i2c_driver cap11xx_i2c_driver = {
>    .driver = {
>        .name    = "cap11xx",
>        .of_match_table = cap11xx_dt_ids,
> +        .pm    = &cap11xx_pm_ops,
>    },
>    .id_table    = cap11xx_i2c_ids,
>    .probe        = cap11xx_i2c_probe,
> -- 
> 1.9.1
> 

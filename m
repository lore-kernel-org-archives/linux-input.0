From: Matt Ranostay <mranostay@gmail.com>
Subject: Re: [PATCH v5 2/2] cap11xx: add LED support
Date: Fri, 19 Jun 2015 19:32:22 -0700
Message-ID: <CAKzfze9=oVJ=fMF9RQ=9okcSZKRD+6owK7xmpOrUi3R19=+Jaw@mail.gmail.com>
References: <1434599897-22505-1-git-send-email-mranostay@gmail.com>
	<1434599897-22505-3-git-send-email-mranostay@gmail.com>
	<55826A5B.7030408@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:33534 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753821AbbFTCcX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Jun 2015 22:32:23 -0400
In-Reply-To: <55826A5B.7030408@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jacek Anaszewski <j.anaszewski@samsung.com>
Cc: Daniel Mack <zonque@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-leds@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Wed, Jun 17, 2015 at 11:51 PM, Jacek Anaszewski
<j.anaszewski@samsung.com> wrote:
> Hi Matt,
>
>
> On 06/18/2015 05:58 AM, Matt Ranostay wrote:
>>
>> Several cap11xx variants have LEDs that be can be controlled, this
>> patchset implements this functionality.
>>
>> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
>> ---
>>   drivers/input/keyboard/cap11xx.c | 141
>> ++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 138 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/input/keyboard/cap11xx.c
>> b/drivers/input/keyboard/cap11xx.c
>> index f07461a..b48d72f 100644
>> --- a/drivers/input/keyboard/cap11xx.c
>> +++ b/drivers/input/keyboard/cap11xx.c
>> @@ -12,6 +12,7 @@
>>   #include <linux/module.h>
>>   #include <linux/interrupt.h>
>>   #include <linux/input.h>
>> +#include <linux/leds.h>
>>   #include <linux/of_irq.h>
>>   #include <linux/regmap.h>
>>   #include <linux/i2c.h>
>> @@ -47,6 +48,20 @@
>>   #define CAP11XX_REG_CONFIG2           0x44
>>   #define CAP11XX_REG_CONFIG2_ALT_POL   BIT(6)
>>   #define CAP11XX_REG_SENSOR_BASE_CNT(X)        (0x50 + (X))
>> +#define CAP11XX_REG_LED_POLARITY       0x73
>> +#define CAP11XX_REG_LED_OUTPUT_CONTROL 0x74
>> +
>> +#define CAP11XX_REG_LED_DUTY_CYCLE_1   0x90
>> +#define CAP11XX_REG_LED_DUTY_CYCLE_2   0x91
>> +#define CAP11XX_REG_LED_DUTY_CYCLE_3   0x92
>> +#define CAP11XX_REG_LED_DUTY_CYCLE_4   0x93
>> +
>> +#define CAP11XX_REG_LED_DUTY_MIN_MASK  (0x0f)
>> +#define CAP11XX_REG_LED_DUTY_MIN_MASK_SHIFT    (0)
>> +#define CAP11XX_REG_LED_DUTY_MAX_MASK  (0xf0)
>> +#define CAP11XX_REG_LED_DUTY_MAX_MASK_SHIFT    (4)
>> +#define CAP11XX_REG_LED_DUTY_MAX_VALUE (15)
>> +
>>   #define CAP11XX_REG_SENSOR_CALIB      (0xb1 + (X))
>>   #define CAP11XX_REG_SENSOR_CALIB_LSB1 0xb9
>>   #define CAP11XX_REG_SENSOR_CALIB_LSB2 0xba
>> @@ -56,10 +71,24 @@
>>
>>   #define CAP11XX_MANUFACTURER_ID       0x5d
>>
>> +#ifdef CONFIG_LEDS_CLASS
>> +struct cap11xx_led {
>> +       struct cap11xx_priv *priv;
>> +       struct led_classdev cdev;
>> +       struct work_struct work;
>> +       u32 reg;
>> +       enum led_brightness new_brightness;
>> +};
>> +#endif
>> +
>>   struct cap11xx_priv {
>>         struct regmap *regmap;
>>         struct input_dev *idev;
>>
>> +#ifdef CONFIG_LEDS_CLASS
>> +       struct cap11xx_led *leds;
>> +       int num_leds;
>> +#endif
>>         /* config */
>>         u32 keycodes[];
>>   };
>> @@ -67,6 +96,7 @@ struct cap11xx_priv {
>>   struct cap11xx_hw_model {
>>         u8 product_id;
>>         unsigned int num_channels;
>> +       unsigned int num_leds;
>>   };
>>
>>   enum {
>> @@ -76,9 +106,9 @@ enum {
>>   };
>>
>>   static const struct cap11xx_hw_model cap11xx_devices[] = {
>> -       [CAP1106] = { .product_id = 0x55, .num_channels = 6 },
>> -       [CAP1126] = { .product_id = 0x53, .num_channels = 6 },
>> -       [CAP1188] = { .product_id = 0x50, .num_channels = 8 },
>> +       [CAP1106] = { .product_id = 0x55, .num_channels = 6, .num_leds = 0
>> },
>> +       [CAP1126] = { .product_id = 0x53, .num_channels = 6, .num_leds = 2
>> },
>> +       [CAP1188] = { .product_id = 0x50, .num_channels = 8, .num_leds = 8
>> },
>>   };
>>
>>   static const struct reg_default cap11xx_reg_defaults[] = {
>> @@ -111,6 +141,7 @@ static const struct reg_default cap11xx_reg_defaults[]
>> = {
>>         { CAP11XX_REG_STANDBY_SENSITIVITY,      0x02 },
>>         { CAP11XX_REG_STANDBY_THRESH,           0x40 },
>>         { CAP11XX_REG_CONFIG2,                  0x40 },
>> +       { CAP11XX_REG_LED_POLARITY,             0x00 },
>>         { CAP11XX_REG_SENSOR_CALIB_LSB1,        0x00 },
>>         { CAP11XX_REG_SENSOR_CALIB_LSB2,        0x00 },
>>   };
>> @@ -177,6 +208,13 @@ out:
>>
>>   static int cap11xx_set_sleep(struct cap11xx_priv *priv, bool sleep)
>>   {
>> +#ifdef CONFIG_LEDS_CLASS
>> +       /*
>> +        * DLSEEP mode will turn off all LEDS, prevent this
>> +        */
>> +       if (priv->num_leds)
>> +               return 0;
>> +#endif
>>         return regmap_update_bits(priv->regmap, CAP11XX_REG_MAIN_CONTROL,
>>                                   CAP11XX_REG_MAIN_CONTROL_DLSEEP,
>>                                   sleep ? CAP11XX_REG_MAIN_CONTROL_DLSEEP
>> : 0);
>> @@ -196,6 +234,98 @@ static void cap11xx_input_close(struct input_dev
>> *idev)
>>         cap11xx_set_sleep(priv, true);
>>   }
>>
>> +#ifdef CONFIG_LEDS_CLASS
>> +static void cap11xx_led_work(struct work_struct *work)
>> +{
>> +       struct cap11xx_led *led = container_of(work, struct cap11xx_led,
>> work);
>> +       struct cap11xx_priv *priv = led->priv;
>> +       int value = led->new_brightness;
>> +
>> +       /*
>> +        * All LEDs share the same duty cycle as this is a HW limitation.
>> +        * Brightness levels per LED are either 0 (OFF) and 1 (ON).
>> +        *
>> +        * Actual brightness level for the ON state for all LEDS is set
>> via the
>> +        * "linux,led-brightness" DT property.
>> +        */
>> +       regmap_update_bits(priv->regmap, CAP11XX_REG_LED_OUTPUT_CONTROL,
>> +                               BIT(led->reg), value ? BIT(led->reg) : 0);
>> +}
>> +
>> +static void cap11xx_led_set(struct led_classdev *cdev,
>> +                          enum led_brightness value)
>> +{
>> +       struct cap11xx_led *led = container_of(cdev, struct cap11xx_led,
>> cdev);
>> +
>> +       if (led->new_brightness == value)
>> +               return;
>> +
>> +       led->new_brightness = value;
>> +       schedule_work(&led->work);
>> +}
>> +
>> +static int cap11xx_init_leds(struct device *dev,
>> +                            struct cap11xx_priv *priv, int num_leds)
>> +{
>> +       struct device_node *node = dev->of_node, *child;
>> +       struct cap11xx_led *led;
>> +       int cnt = of_get_child_count(node);
>> +       u32 reg = 0;
>> +       int error;
>> +
>> +       if (!num_leds || !cnt)
>> +               return 0;
>> +       if (cnt > num_leds)
>> +               return -EINVAL;
>> +
>> +       led = devm_kcalloc(dev, cnt,
>> +               sizeof(struct cap11xx_led), GFP_KERNEL);
>> +       if (!led)
>> +               return -ENOMEM;
>> +
>> +       priv->leds = led;
>> +       error = of_property_read_u32(node, "linux,led-brightness", &reg);
>> +       if (error || reg == 0 || reg > CAP11XX_REG_LED_DUTY_MAX_VALUE)
>> +               reg = CAP11XX_REG_LED_DUTY_MAX_VALUE;
>> +
>> +       error = regmap_update_bits(priv->regmap,
>> +                               CAP11XX_REG_LED_OUTPUT_CONTROL, 0xff, 0);
>> +       if (error)
>> +               return error;
>> +       error = regmap_update_bits(priv->regmap,
>> CAP11XX_REG_LED_DUTY_CYCLE_4,
>> +                               CAP11XX_REG_LED_DUTY_MAX_MASK,
>> +                               reg <<
>> CAP11XX_REG_LED_DUTY_MAX_MASK_SHIFT);
>> +       if (error)
>> +               return error;
>> +
>> +       for_each_child_of_node(node, child) {
>> +               led->cdev.name =
>> +                       of_get_property(child, "label", NULL) ? :
>> child->name;
>> +               led->cdev.default_trigger =
>> +                       of_get_property(child, "linux,default-trigger",
>> NULL);
>> +               led->cdev.flags = 0;
>> +               led->cdev.brightness_set = cap11xx_led_set;
>> +               led->cdev.max_brightness = 1;
>> +               led->cdev.brightness = LED_OFF;
>> +
>> +               error = of_property_read_u32(child, "reg", &reg);
>> +               if (error != 0 || reg >= num_leds)
>> +                       continue;
>> +               led->reg = reg;
>> +               led->priv = priv;
>> +
>> +               INIT_WORK(&led->work, cap11xx_led_work);
>> +               error = devm_led_classdev_register(dev, &led->cdev);
>> +               if (error < 0)
>> +                       return -EINVAL;
>
>
> I would add empty line here and after INIT_WORK.
> With this addressed:
>
> Acked-by: Jacek Anaszewski <j.anaszewski@samsung.com>

Dmitry do you have any input for this rev? If not will you fix the
newline issue here? Seems silly to do a v6 for this

I plan to do a runtime PM patchset to clean up this crude check within
a week or two.

Thanks,

MAtt

>
>> +               priv->num_leds++;
>> +               led++;
>> +       };
>> +
>> +       return 0;
>> +}
>> +#endif
>> +
>>   static int cap11xx_i2c_probe(struct i2c_client *i2c_client,
>>                              const struct i2c_device_id *id)
>>   {
>> @@ -316,6 +446,11 @@ static int cap11xx_i2c_probe(struct i2c_client
>> *i2c_client,
>>         priv->idev->open = cap11xx_input_open;
>>         priv->idev->close = cap11xx_input_close;
>>
>> +#ifdef CONFIG_LEDS_CLASS
>> +       error = cap11xx_init_leds(dev, priv, cap->num_leds);
>> +       if (error)
>> +               return error;
>> +#endif
>>         input_set_drvdata(priv->idev, priv);
>>
>>         /*
>>
>
>
> --
> Best Regards,
> Jacek Anaszewski
--
To unsubscribe from this list: send the line "unsubscribe linux-input" in

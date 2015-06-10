From: Matt Ranostay <mranostay@gmail.com>
Subject: Re: [PATCH v2] cap11xx: add LED support
Date: Wed, 10 Jun 2015 15:07:25 -0700
Message-ID: <CAKzfze_+XEQB5VTiH6BcyU297OnEWc3JK0m2hLuVsqhykCfPAw@mail.gmail.com>
References: <1433920083-31869-1-git-send-email-mranostay@gmail.com>
	<5577EF58.60706@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <5577EF58.60706@samsung.com>
Sender: linux-leds-owner@vger.kernel.org
To: Jacek Anaszewski <j.anaszewski@samsung.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Mack <zonque@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-leds@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Jun 10, 2015 at 1:03 AM, Jacek Anaszewski
<j.anaszewski@samsung.com> wrote:
> Hi Matt,
>
> On 06/10/2015 09:08 AM, Matt Ranostay wrote:
>>
>> Several cap11xx variants have LEDs that be can be controlled, this
>> patchset implements this functionality.
>>
>> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
>> ---
>>   drivers/input/keyboard/cap11xx.c | 90
>> ++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 87 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/input/keyboard/cap11xx.c
>> b/drivers/input/keyboard/cap11xx.c
>> index f07461a..af1daa0 100644
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
>
>
> These include directives aren't arranged in an alphabetical order.
> You could fix that as you are modifying this file.
>
>> @@ -47,6 +48,8 @@
>>   #define CAP11XX_REG_CONFIG2           0x44
>>   #define CAP11XX_REG_CONFIG2_ALT_POL   BIT(6)
>>   #define CAP11XX_REG_SENSOR_BASE_CNT(X)        (0x50 + (X))
>> +#define CAP11XX_REG_LED_POLARITY       0x73
>> +#define CAP11XX_REG_LED_OUTPUT_CONTROL 0x74
>>   #define CAP11XX_REG_SENSOR_CALIB      (0xb1 + (X))
>>   #define CAP11XX_REG_SENSOR_CALIB_LSB1 0xb9
>>   #define CAP11XX_REG_SENSOR_CALIB_LSB2 0xba
>> @@ -56,10 +59,25 @@
>>
>>   #define CAP11XX_MANUFACTURER_ID       0x5d
>>
>> +#ifdef CONFIG_LEDS_CLASS
>> +struct cap11xx_led {
>> +       struct cap11xx_priv *priv;
>> +       struct led_classdev cdev;
>> +       struct work_struct work;
>> +       char name[32];
>
>
> This 'name' field is not needed. Instead the 'name' field of struct
> led_classdev should be initialized with the address of either a 'label'
> property from DT child node representing a LED, or the DT child node
> name if the label is absent. Please refer to
> Documentation/devicetree/bindings/leds/common.txt.
>
> This is usually accomplished in the LED subsystem with following
> instruction:
>
> led_cdev->name = of_get_property(child_node, "label", NULL) ? :
>                                                 child_node->name;
>
>
>
>> +       int id;
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
>> @@ -67,6 +85,7 @@ struct cap11xx_priv {
>>   struct cap11xx_hw_model {
>>         u8 product_id;
>>         unsigned int num_channels;
>> +       unsigned int num_leds;
>>   };
>>
>>   enum {
>> @@ -76,9 +95,9 @@ enum {
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
>
>
> The number of LEDs should be determined by the number of DT child nodes
> representing each LED. Please refer to
> Documentation/devicetree/bindings/leds/common.txt and other LED
> subsystem drivers to find out how it should be implemented.
>
Ok but this is still needed as a check so you don't "overflow" the
number the chipset supports, correct?

>
>
>>   static const struct reg_default cap11xx_reg_defaults[] = {
>> @@ -111,6 +130,7 @@ static const struct reg_default cap11xx_reg_defaults[]
>> = {
>>         { CAP11XX_REG_STANDBY_SENSITIVITY,      0x02 },
>>         { CAP11XX_REG_STANDBY_THRESH,           0x40 },
>>         { CAP11XX_REG_CONFIG2,                  0x40 },
>> +       { CAP11XX_REG_LED_POLARITY,             0x00 },
>>         { CAP11XX_REG_SENSOR_CALIB_LSB1,        0x00 },
>>         { CAP11XX_REG_SENSOR_CALIB_LSB2,        0x00 },
>>   };
>> @@ -196,6 +216,58 @@ static void cap11xx_input_close(struct input_dev
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
>> +       regmap_update_bits(priv->regmap, CAP11XX_REG_LED_OUTPUT_CONTROL,
>> +                               BIT(led->id), !!value ? BIT(led->id) : 0);
>> +}
>> +
>> +static void cap11xx_led_set(struct led_classdev *cdev,
>> +                          enum led_brightness value)
>> +{
>> +       struct cap11xx_led *led = container_of(cdev, struct cap11xx_led,
>> cdev);
>> +
>> +       led->new_brightness = value;
>> +       schedule_work(&led->work);
>> +}
>> +
>> +static int cap11xx_register_leds(struct device *dev, struct cap11xx_priv
>> *priv)
>> +{
>> +       int ret;
>> +       int i;
>> +
>> +       /*
>> +        * Be sure all LEDS are in off-state
>> +        */
>> +       regmap_update_bits(priv->regmap,
>> +                       CAP11XX_REG_LED_OUTPUT_CONTROL, 0xff, 0);
>> +
>> +       for (i = 0; i < priv->num_leds; i++) {
>> +               struct cap11xx_led *led = &priv->leds[i];
>> +
>> +               snprintf(led->name, sizeof(led->name), "cap11xx:led%d", i
>> + 1);
>> +               led->cdev.name = led->name;
>> +               led->cdev.brightness_set = cap11xx_led_set;
>> +               led->cdev.brightness = LED_OFF;
>> +               led->cdev.max_brightness = 1;
>> +               led->id = i;
>> +               led->priv = priv;
>> +
>> +               ret = devm_led_classdev_register(dev, &led->cdev);
>> +               if (ret < 0)
>> +                       return ret;
>> +
>> +               INIT_WORK(&led->work, cap11xx_led_work);
>> +       };
>> +       return 0;
>> +}
>> +#endif
>> +
>>   static int cap11xx_i2c_probe(struct i2c_client *i2c_client,
>>                              const struct i2c_device_id *id)
>>   {
>> @@ -316,6 +388,18 @@ static int cap11xx_i2c_probe(struct i2c_client
>> *i2c_client,
>>         priv->idev->open = cap11xx_input_open;
>>         priv->idev->close = cap11xx_input_close;
>>
>> +#ifdef CONFIG_LEDS_CLASS
>> +       if (cap->num_leds > 0) {
>> +               priv->leds = devm_kcalloc(dev, cap->num_leds,
>> +                               sizeof(struct cap11xx_led), GFP_KERNEL);
>> +               if (!priv->leds)
>> +                       return -ENOMEM;
>> +               priv->num_leds = cap->num_leds;
>> +               error = cap11xx_register_leds(dev, priv);
>> +               if (error)
>> +                       return error;
>> +       }
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

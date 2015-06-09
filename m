From: Matt Ranostay <mranostay@gmail.com>
Subject: Re: [PATCH] cap11xx: add LED support
Date: Tue, 9 Jun 2015 10:30:30 -0700
Message-ID: <CAKzfze_ijYtRfaZ7QinFEQFT2EGP5+VQbbkJPTGxEzzY9DpQ1g@mail.gmail.com>
References: <1433821584-20102-1-git-send-email-mranostay@gmail.com>
	<557678D6.1020804@zonque.org>
	<20150609171254.GF6338@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:34974 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752213AbbFIRab (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Jun 2015 13:30:31 -0400
Received: by iesa3 with SMTP id a3so18766745ies.2
        for <linux-input@vger.kernel.org>; Tue, 09 Jun 2015 10:30:30 -0700 (PDT)
In-Reply-To: <20150609171254.GF6338@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Daniel Mack <daniel@zonque.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Tue, Jun 9, 2015 at 10:12 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Tue, Jun 09, 2015 at 07:25:42AM +0200, Daniel Mack wrote:
>> Hi Matt,
>>
>> On 06/09/2015 05:46 AM, Matt Ranostay wrote:
>> > Several cap11xx variants have LEDs that be can be controlled, this
>> > patchset implements this functionality.
>> >
>> > Signed-off-by: Matt Ranostay <mranostay@gmail.com>
>> > ---
>> >  drivers/input/keyboard/cap11xx.c | 102 +++++++++++++++++++++++++++++++++++++--
>> >  1 file changed, 99 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/cap11xx.c
>> > index f07461a..dc48936 100644
>> > --- a/drivers/input/keyboard/cap11xx.c
>> > +++ b/drivers/input/keyboard/cap11xx.c
>> > @@ -12,6 +12,7 @@
>> >  #include <linux/module.h>
>> >  #include <linux/interrupt.h>
>> >  #include <linux/input.h>
>> > +#include <linux/leds.h>
>> >  #include <linux/of_irq.h>
>> >  #include <linux/regmap.h>
>> >  #include <linux/i2c.h>
>> > @@ -47,6 +48,8 @@
>> >  #define CAP11XX_REG_CONFIG2                0x44
>> >  #define CAP11XX_REG_CONFIG2_ALT_POL        BIT(6)
>> >  #define CAP11XX_REG_SENSOR_BASE_CNT(X)     (0x50 + (X))
>> > +#define CAP11XX_REG_LED_POLARITY   0x73
>> > +#define CAP11XX_REG_LED_OUTPUT_CONTROL     0x74
>> >  #define CAP11XX_REG_SENSOR_CALIB   (0xb1 + (X))
>> >  #define CAP11XX_REG_SENSOR_CALIB_LSB1      0xb9
>> >  #define CAP11XX_REG_SENSOR_CALIB_LSB2      0xba
>> > @@ -56,10 +59,25 @@
>> >
>> >  #define CAP11XX_MANUFACTURER_ID    0x5d
>> >
>> > +#ifdef CONFIG_LEDS_CLASS
>> > +struct cap11xx_led {
>> > +   struct cap11xx_priv *priv;
>> > +   struct led_classdev cdev;
>> > +   struct work_struct work;
>> > +   char name[32];
>> > +   int id;
>> > +   enum led_brightness new_brightness;
>> > +};
>> > +#endif
>> > +
>> >  struct cap11xx_priv {
>> >     struct regmap *regmap;
>> >     struct input_dev *idev;
>> >
>> > +#ifdef CONFIG_LEDS_CLASS
>> > +   struct cap11xx_led *leds;
>> > +   int num_leds;
>> > +#endif
>> >     /* config */
>> >     u32 keycodes[];
>> >  };
>> > @@ -67,6 +85,7 @@ struct cap11xx_priv {
>> >  struct cap11xx_hw_model {
>> >     u8 product_id;
>> >     unsigned int num_channels;
>> > +   unsigned int num_leds;
>> >  };
>> >
>> >  enum {
>> > @@ -76,9 +95,9 @@ enum {
>> >  };
>> >
>> >  static const struct cap11xx_hw_model cap11xx_devices[] = {
>> > -   [CAP1106] = { .product_id = 0x55, .num_channels = 6 },
>> > -   [CAP1126] = { .product_id = 0x53, .num_channels = 6 },
>> > -   [CAP1188] = { .product_id = 0x50, .num_channels = 8 },
>> > +   [CAP1106] = { .product_id = 0x55, .num_channels = 6, .num_leds = 0 },
>> > +   [CAP1126] = { .product_id = 0x53, .num_channels = 6, .num_leds = 2 },
>> > +   [CAP1188] = { .product_id = 0x50, .num_channels = 8, .num_leds = 8 },
>> >  };
>> >
>> >  static const struct reg_default cap11xx_reg_defaults[] = {
>> > @@ -111,6 +130,8 @@ static const struct reg_default cap11xx_reg_defaults[] = {
>> >     { CAP11XX_REG_STANDBY_SENSITIVITY,      0x02 },
>> >     { CAP11XX_REG_STANDBY_THRESH,           0x40 },
>> >     { CAP11XX_REG_CONFIG2,                  0x40 },
>> > +   { CAP11XX_REG_LED_POLARITY,             0x00 },
>> > +   { CAP11XX_REG_LED_OUTPUT_CONTROL,       0x00 },
>> >     { CAP11XX_REG_SENSOR_CALIB_LSB1,        0x00 },
>> >     { CAP11XX_REG_SENSOR_CALIB_LSB2,        0x00 },
>> >  };
>> > @@ -196,6 +217,69 @@ static void cap11xx_input_close(struct input_dev *idev)
>> >     cap11xx_set_sleep(priv, true);
>> >  }
>> >
>> > +#ifdef CONFIG_LEDS_CLASS
>> > +static void cap11xx_led_work(struct work_struct *work)
>> > +{
>> > +   struct cap11xx_led *led = container_of(work, struct cap11xx_led, work);
>> > +   struct cap11xx_priv *priv = led->priv;
>> > +   int value = led->new_brightness;
>> > +
>> > +   regmap_update_bits(priv->regmap, CAP11XX_REG_LED_OUTPUT_CONTROL,
>> > +                           BIT(led->id), !!value ? BIT(led->id) : 0);
>> > +}
>> > +
>> > +static void cap11xx_led_set(struct led_classdev *cdev,
>> > +                      enum led_brightness value)
>> > +{
>> > +   struct cap11xx_led *led = container_of(cdev, struct cap11xx_led, cdev);
>> > +
>> > +   led->new_brightness = value;
>> > +   schedule_work(&led->work);
>> > +}
>> > +
>> > +static int cap11xx_register_leds(struct device *dev, struct cap11xx_priv *priv)
>> > +{
>> > +   int ret;
>> > +   int i;
>> > +
>> > +   for (i = 0; i < priv->num_leds; i++) {
>> > +           struct cap11xx_led *led = &priv->leds[i];
>> > +
>> > +           snprintf(led->name, sizeof(led->name), "cap11xx:led%d", i + 1);
>> > +           led->cdev.name = led->name;
>> > +           led->cdev.brightness_set = cap11xx_led_set;
>>
>> Use the .brightness_set_sync callback, so you don't have to dance around
>> with the workers at all.
>
> Umm, how will it help? You still can't sleep in set_brightness().
> brightness_set_sync() just says that the driver guarantees that the LED
> state will be set (or error returned) when the function returns.
>
Yeah the worker queues are for sure needed.

> Thanks.
>
> --
> Dmitry

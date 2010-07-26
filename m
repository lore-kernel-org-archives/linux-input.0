From: Xiaolong Chen <xiaolong.chen@gmail.com>
Subject: Re: Fwd: [RFC] [PATCH] Input: ADP5588 - Support gpio function on
 unused pin
Date: Mon, 26 Jul 2010 23:45:43 +0800
Message-ID: <4C4DADA7.9000201@gmail.com>
References: <4c459b70.0aee8c0a.1c29.3e9e@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:53422 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228Ab0GZPqR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Jul 2010 11:46:17 -0400
Received: by pxi14 with SMTP id 14so107583pxi.19
        for <linux-input@vger.kernel.org>; Mon, 26 Jul 2010 08:46:16 -0700 (PDT)
In-Reply-To: <4c459b70.0aee8c0a.1c29.3e9e@mx.google.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Michael <Michael.Hennerich@analog.com>, david-b@pacbell.net, Michael Hennerich <hennerich@blackfin.uclinux.org>, linux-input@vger.kernel.org, TAO HU <taohu@motorola.com>, "Yuan.Bo YE" <yuan-bo.ye@motorola.com>, Xiaolong CHEN <a21785@motorola.com>

  Hi, Dmitry

Following your comments, add the CONFIG_GPIOLIB and update the
patch based on the linux-next. If there is any comments and
suggestion, please feel free let me know.

I think we need to protect the code you are adding with #ifdef
CONFIG_GPIOLIBi and provide the stubs in case gpiolib is not
available. This will also force splitting the gpio hanlding code
into separate functions so that it is easier to read. Please see
how it is done in ad7879 driver.
Done.

Also if would be great if you generated the patch against the
version of the driver that is ither in linux-next or in the 'next'
branch of my tree as there a few changes clashing with yours.
Done.

 From ac2b85cbf0452015f3a19b08d50bcd8ff97db25e Mon Sep 17 00:00:00 2001
From: xiaolong <a21785@motorola.com>
Date: Thu, 22 Jul 2010 05:47:46 -0400
Subject: [PATCH] Input: ADP5588 - Support gpio function on unused pin

This implements an optional gpio function on unused pin by adp5588
kpad.

adp5588_kpad_platform_data has been extended with gpio_data,
support gpio function if gpio_data is not NULL.

Signed-off-by: Xiaolong Chen <xiao-long.chen@motorola.com>
Signed-off-by: Yuanbo Ye <yuan-bo.ye@motorola.com>
Signed-off-by: Tao Hu <taohu@motorola.com>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
  drivers/input/keyboard/adp5588-keys.c |  218 
+++++++++++++++++++++++++++++++++
  include/linux/i2c/adp5588.h           |    1 +
  2 files changed, 219 insertions(+), 0 deletions(-)

diff --git a/drivers/input/keyboard/adp5588-keys.c 
b/drivers/input/keyboard/adp5588-keys.c
index 9096db7..f19c7ce 100644
--- a/drivers/input/keyboard/adp5588-keys.c
+++ b/drivers/input/keyboard/adp5588-keys.c
@@ -19,6 +19,7 @@
  #include <linux/platform_device.h>
  #include <linux/input.h>
  #include <linux/i2c.h>
+#include <linux/gpio.h>
  #include <linux/slab.h>

  #include <linux/i2c/adp5588.h>
@@ -54,6 +55,10 @@

  #define KEYP_MAX_EVENT        10

+#define MAXGPIO            18
+#define ADP_BANK(offs)        ((offs) >> 3)
+#define ADP_BIT(offs)        (1u << ((offs) & 0x7))
+
  /*
   * Early pre 4.0 Silicon required to delay readout by at least 25ms,
   * since the Event Counter Register updated 25ms after the interrupt
@@ -69,6 +74,14 @@ struct adp5588_kpad {
      unsigned short keycode[ADP5588_KEYMAPSIZE];
      const struct adp5588_gpi_map *gpimap;
      unsigned short gpimapsize;
+    unsigned char gpiomap[MAXGPIO];
+    bool support_gpio;
+#ifdef CONFIG_GPIOLIB
+    struct gpio_chip gc;
+#endif
+    struct mutex gpio_lock;    /* Protect cached dir, dat_out */
+    uint8_t dat_out[3];
+    uint8_t dir[3];
  };

  static int adp5588_read(struct i2c_client *client, u8 reg)
@@ -86,6 +99,194 @@ static int adp5588_write(struct i2c_client *client, 
u8 reg, u8 val)
      return i2c_smbus_write_byte_data(client, reg, val);
  }

+#ifdef CONFIG_GPIOLIB
+static int adp5588_gpio_get_value(struct gpio_chip *chip, unsigned off)
+{
+    unsigned bank, bit;
+    struct adp5588_kpad *kpad =
+        container_of(chip, struct adp5588_kpad, gc);
+
+    bank = ADP_BANK(kpad->gpiomap[off]);
+    bit = ADP_BIT(kpad->gpiomap[off]);
+
+    return !!(adp5588_read(kpad->client, GPIO_DAT_STAT1 + bank) & bit);
+}
+
+static void adp5588_gpio_set_value(struct gpio_chip *chip,
+                   unsigned off, int val)
+{
+    unsigned bank, bit;
+    struct adp5588_kpad *kpad =
+        container_of(chip, struct adp5588_kpad, gc);
+
+    bank = ADP_BANK(kpad->gpiomap[off]);
+    bit = ADP_BIT(kpad->gpiomap[off]);
+
+    mutex_lock(&kpad->gpio_lock);
+    if (val)
+        kpad->dat_out[bank] |= bit;
+    else
+        kpad->dat_out[bank] &= ~bit;
+
+    adp5588_write(kpad->client, GPIO_DAT_OUT1 + bank,
+               kpad->dat_out[bank]);
+    mutex_unlock(&kpad->gpio_lock);
+}
+
+static int adp5588_gpio_direction_input(struct gpio_chip *chip, 
unsigned off)
+{
+    int ret;
+    unsigned bank, bit;
+    struct adp5588_kpad *kpad =
+        container_of(chip, struct adp5588_kpad, gc);
+
+    bank = ADP_BANK(kpad->gpiomap[off]);
+    bit = ADP_BIT(kpad->gpiomap[off]);
+
+    mutex_lock(&kpad->gpio_lock);
+    kpad->dir[bank] &= ~bit;
+    ret = adp5588_write(kpad->client, GPIO_DIR1 + bank, kpad->dir[bank]);
+    mutex_unlock(&kpad->gpio_lock);
+
+    return ret;
+}
+
+static int adp5588_gpio_direction_output(struct gpio_chip *chip,
+                     unsigned off, int val)
+{
+    int ret;
+    unsigned bank, bit;
+    struct adp5588_kpad *kpad =
+        container_of(chip, struct adp5588_kpad, gc);
+
+    bank = ADP_BANK(kpad->gpiomap[off]);
+    bit = ADP_BIT(kpad->gpiomap[off]);
+
+    mutex_lock(&kpad->gpio_lock);
+    kpad->dir[bank] |= bit;
+
+    if (val)
+        kpad->dat_out[bank] |= bit;
+    else
+        kpad->dat_out[bank] &= ~bit;
+
+    ret = adp5588_write(kpad->client, GPIO_DAT_OUT1 + bank,
+                 kpad->dat_out[bank]);
+    ret |= adp5588_write(kpad->client, GPIO_DIR1 + bank,
+                 kpad->dir[bank]);
+    mutex_unlock(&kpad->gpio_lock);
+
+    return ret;
+}
+
+static int __devinit adp5588_gpio_add(struct device *dev)
+{
+    int i, ret = 0;
+    struct adp5588_kpad *kpad = dev_get_drvdata(dev);
+    struct adp5588_kpad_platform_data *pdata = dev->platform_data;
+
+    if (pdata->gpio_data) {
+        int j = 0;
+        bool pin_used[MAXGPIO];
+
+        for (i = 0; i < pdata->rows; i++)
+            pin_used[i] = true;
+
+        for (i = 0; i < pdata->cols; i++)
+            pin_used[i + GPI_PIN_COL_BASE - GPI_PIN_BASE] = true;
+
+        for (i = 0; i < kpad->gpimapsize; i++)
+            pin_used[kpad->gpimap[i].pin - GPI_PIN_BASE] = true;
+
+        for (i = 0; i < MAXGPIO; i++) {
+            if (!pin_used[i])
+                kpad->gpiomap[j++] = i;
+        }
+        kpad->gc.ngpio = j;
+
+        if (kpad->gc.ngpio)
+            kpad->support_gpio = true;
+    }
+
+    if (!kpad->support_gpio) {
+        dev_info(dev, "Don't support gpio function\n");
+        return 0;
+    }
+
+    kpad->gc.direction_input = adp5588_gpio_direction_input;
+    kpad->gc.direction_output = adp5588_gpio_direction_output;
+    kpad->gc.get = adp5588_gpio_get_value;
+    kpad->gc.set = adp5588_gpio_set_value;
+    kpad->gc.can_sleep = 1;
+
+    kpad->gc.base = pdata->gpio_data->gpio_start;
+    kpad->gc.label = kpad->client->name;
+    kpad->gc.owner = THIS_MODULE;
+
+    mutex_init(&kpad->gpio_lock);
+
+    ret = gpiochip_add(&kpad->gc);
+    if (ret) {
+        dev_err(dev, "gpiochip_add err: %d\n", ret);
+        return ret;
+    }
+
+    for (i = 0; i <= ADP_BANK(MAXGPIO); i++) {
+        kpad->dat_out[i] = adp5588_read(kpad->client,
+                        GPIO_DAT_OUT1 + i);
+        kpad->dir[i] = adp5588_read(kpad->client, GPIO_DIR1 + i);
+    }
+
+    if (pdata->gpio_data->setup) {
+        ret = pdata->gpio_data->setup(kpad->client,
+                    kpad->gc.base, kpad->gc.ngpio,
+                    pdata->gpio_data->context);
+        if (ret < 0)
+            dev_warn(dev, "setup failed, %d\n", ret);
+    }
+
+    return 0;
+}
+
+static inline int adp5588_gpio_remove(struct device *dev)
+{
+    int ret = 0;
+    struct adp5588_kpad *kpad = dev_get_drvdata(dev);
+    struct adp5588_kpad_platform_data *pdata = dev->platform_data;
+
+    if (!kpad->support_gpio)
+        return 0;
+
+    if (pdata->gpio_data->teardown) {
+        ret = pdata->gpio_data->teardown(kpad->client,
+                kpad->gc.base, kpad->gc.ngpio,
+                pdata->gpio_data->context);
+        if (ret < 0) {
+            dev_err(dev, "teardown failed %d\n", ret);
+            return ret;
+        }
+    }
+
+    ret = gpiochip_remove(&kpad->gc);
+    if (ret) {
+        dev_err(dev, "gpiochip_remove failed %d\n", ret);
+        return ret;
+    }
+
+    return 0;
+}
+#else
+static inline int adp5588_gpio_add(struct device *dev)
+{
+    return 0;
+}
+
+static inline int adp5588_gpio_remove(struct device *dev)
+{
+    return 0;
+}
+#endif
+
  static void adp5588_report_events(struct adp5588_kpad *kpad, int ev_cnt)
  {
      int i, j;
@@ -184,6 +385,15 @@ static int __devinit adp5588_setup(struct 
i2c_client *client)
          ret |= adp5588_write(client, GPI_EM3, evt_mode3);
      }

+    if (pdata->gpio_data) {
+        for (i = 0; i <= ADP_BANK(MAXGPIO); i++) {
+            int pull_mask = pdata->gpio_data->pullup_dis_mask;
+
+            ret |= adp5588_write(client, GPIO_PULL1 + i,
+                (pull_mask >> (8 * i)) & 0xFF);
+        }
+    }
+
      ret |= adp5588_write(client, INT_STAT, CMP2_INT | CMP1_INT |
                      OVR_FLOW_INT | K_LCK_INT |
                      GPI_INT | KE_INT); /* Status is W1C */
@@ -384,6 +594,10 @@ static int __devinit adp5588_probe(struct 
i2c_client *client,
      device_init_wakeup(&client->dev, 1);
      i2c_set_clientdata(client, kpad);

+    error = adp5588_gpio_add(&client->dev);
+    if (error)
+        goto err_free_irq;
+
      dev_info(&client->dev, "Rev.%d keypad, irq %d\n", revid, client->irq);
      return 0;

@@ -401,12 +615,16 @@ static int __devinit adp5588_probe(struct 
i2c_client *client,

  static int __devexit adp5588_remove(struct i2c_client *client)
  {
+    int ret;
      struct adp5588_kpad *kpad = i2c_get_clientdata(client);

      adp5588_write(client, CFG, 0);
      free_irq(client->irq, kpad);
      cancel_delayed_work_sync(&kpad->work);
      input_unregister_device(kpad->input);
+    ret = adp5588_gpio_remove(&client->dev);
+    if (ret)
+        return ret;
      kfree(kpad);

      return 0;
diff --git a/include/linux/i2c/adp5588.h b/include/linux/i2c/adp5588.h
index b5f57c4..2e7d465 100644
--- a/include/linux/i2c/adp5588.h
+++ b/include/linux/i2c/adp5588.h
@@ -123,6 +123,7 @@ struct adp5588_kpad_platform_data {
      unsigned short unlock_key2;    /* Unlock Key 2 */
      const struct adp5588_gpi_map *gpimap;
      unsigned short gpimapsize;
+    struct adp5588_gpio_platform_data *gpio_data;
  };

  struct adp5588_gpio_platform_data {
-- 
1.5.4.3

Thanks,
Xiaolong

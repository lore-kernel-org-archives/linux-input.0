From: Xiaolong CHEN <a21785@motorola.com>
Subject: [RFC] [PATCH] Input: ADP5588 - Support gpio function on unused pin
Date: Wed, 14 Jul 2010 15:23:37 +0800
Message-ID: <AANLkTikJKMYajxh799evj7Xv_HV3DFhabCZgYDkhuokh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exprod5og108.obsmtp.com ([64.18.0.186]:38068 "EHLO
	exprod5og108.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426Ab0GNHXk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Jul 2010 03:23:40 -0400
Received: from az10vts04.mot.com (il27vts04.cig.mot.com [10.17.196.88])
	by mdgate2.corp.mot.com (8.14.3/8.14.3) with SMTP id o6E7Mw7E021837
	for <linux-input@vger.kernel.org>; Wed, 14 Jul 2010 01:22:58 -0600 (MDT)
Received: from mail-iw0-f182.google.com (mail-iw0-f182.google.com [209.85.214.182])
	by mdgate2.corp.mot.com (8.14.3/8.14.3) with ESMTP id o6E7MwjG021829
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-input@vger.kernel.org>; Wed, 14 Jul 2010 01:22:58 -0600 (MDT)
Received: by iwn35 with SMTP id 35so9452135iwn.27
        for <linux-input@vger.kernel.org>; Wed, 14 Jul 2010 00:23:38 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Torokhov <dtor@mail.ru>, Michael Hennerich <hennerich@blackfin.uclinux.org>, TAO HU <taohu@motorola.com>, "Yuan.Bo YE" <yuan-bo.ye@motorola.com>

Hi,

This patch depends on the patch, "Input: ADP5588 - Support GPI event
for ADP5588 devices", it supports gpio function on unused pin.

Usage:
Set Support_gpio = 1 to enable gpio function, and set gpio_start for
the gpio_chip base.

If there is any comments and suggestion please let me know.

Patch:

>From 5b442d7d7cc5307dcfaea8f3d1494b87da6182de Mon Sep 17 00:00:00 2001
From: Xiaolong Chen <a21785@motorola.com>
Date: Tue, 13 Jul 2010 23:55:12 +0800
Subject: [PATCH] Input: ADP5588 - Support gpio function on unused pin

This implements an optional gpio function on unused pin by adp5588
kpad.

adp5588_kpad_platform_data has been extended with support_gpio,
support gpio function if it equals 1, and gpio_start, the gpio chip
base for this module.

Signed-off-by: Xiaolong Chen <xiao-long.chen@motorola.com>
Signed-off-by: Yuanbo Ye <yuan-bo.ye@motorola.com>
Signed-off-by: Tao Hu <taohu@motorola.com>
---
 drivers/input/keyboard/adp5588-keys.c |  141 +++++++++++++++++++++++++++++++++
 include/linux/i2c/adp5588.h           |    2 +
 2 files changed, 143 insertions(+), 0 deletions(-)

diff --git a/drivers/input/keyboard/adp5588-keys.c
b/drivers/input/keyboard/adp5588-keys.c
index 3c8876a..e1455f8 100644
--- a/drivers/input/keyboard/adp5588-keys.c
+++ b/drivers/input/keyboard/adp5588-keys.c
@@ -18,6 +18,7 @@
 #include <linux/platform_device.h>
 #include <linux/input.h>
 #include <linux/i2c.h>
+#include <linux/gpio.h>

 #include <linux/i2c/adp5588.h>

@@ -52,6 +53,10 @@

 #define KEYP_MAX_EVENT		10

+#define MAXGPIO			18
+#define ADP_BANK(offs)		((offs) >> 3)
+#define ADP_BIT(offs)		(1u << ((offs) & 0x7))
+
 /*
  * Early pre 4.0 Silicon required to delay readout by at least 25ms,
  * since the Event Counter Register updated 25ms after the interrupt
@@ -67,6 +72,12 @@ struct adp5588_kpad {
 	unsigned short keycode[ADP5588_KEYMAPSIZE];
 	const struct adp5588_gpi_map *gpimap;
 	unsigned short gpimapsize;
+	unsigned char pin_used[MAXGPIO];
+	unsigned support_gpio;
+	struct gpio_chip gpio_chip;
+	struct mutex gpio_lock;	/* Protect cached dir, dat_out */
+	uint8_t dat_out[3];
+	uint8_t dir[3];
 };

 static int adp5588_read(struct i2c_client *client, u8 reg)
@@ -84,6 +95,81 @@ static int adp5588_write(struct i2c_client *client,
u8 reg, u8 val)
 	return i2c_smbus_write_byte_data(client, reg, val);
 }

+static int adp5588_gpio_get_value(struct gpio_chip *chip, unsigned off)
+{
+	struct adp5588_kpad *dev =
+	    container_of(chip, struct adp5588_kpad, gpio_chip);
+
+	return !!(adp5588_read(dev->client, GPIO_DAT_STAT1 + ADP_BANK(off))
+		  & ADP_BIT(off));
+}
+
+static void adp5588_gpio_set_value(struct gpio_chip *chip,
+				   unsigned off, int val)
+{
+	unsigned bank, bit;
+	struct adp5588_kpad *dev =
+	    container_of(chip, struct adp5588_kpad, gpio_chip);
+
+	bank = ADP_BANK(off);
+	bit = ADP_BIT(off);
+
+	mutex_lock(&dev->gpio_lock);
+	if (val)
+		dev->dat_out[bank] |= bit;
+	else
+		dev->dat_out[bank] &= ~bit;
+
+	adp5588_write(dev->client, GPIO_DAT_OUT1 + bank,
+			   dev->dat_out[bank]);
+	mutex_unlock(&dev->gpio_lock);
+}
+
+static int adp5588_gpio_direction_input(struct gpio_chip *chip, unsigned off)
+{
+	int ret;
+	unsigned bank;
+	struct adp5588_kpad *dev =
+	    container_of(chip, struct adp5588_kpad, gpio_chip);
+
+	bank = ADP_BANK(off);
+
+	mutex_lock(&dev->gpio_lock);
+	dev->dir[bank] &= ~ADP_BIT(off);
+	ret = adp5588_write(dev->client, GPIO_DIR1 + bank, dev->dir[bank]);
+	mutex_unlock(&dev->gpio_lock);
+
+	return ret;
+}
+
+static int adp5588_gpio_direction_output(struct gpio_chip *chip,
+					 unsigned off, int val)
+{
+	int ret;
+	unsigned bank, bit;
+	struct adp5588_kpad *dev =
+	    container_of(chip, struct adp5588_kpad, gpio_chip);
+
+	bank = ADP_BANK(off);
+	bit = ADP_BIT(off);
+
+	mutex_lock(&dev->gpio_lock);
+	dev->dir[bank] |= bit;
+
+	if (val)
+		dev->dat_out[bank] |= bit;
+	else
+		dev->dat_out[bank] &= ~bit;
+
+	ret = adp5588_write(dev->client, GPIO_DAT_OUT1 + bank,
+				 dev->dat_out[bank]);
+	ret |= adp5588_write(dev->client, GPIO_DIR1 + bank,
+				 dev->dir[bank]);
+	mutex_unlock(&dev->gpio_lock);
+
+	return ret;
+}
+
 static void adp5588_work(struct work_struct *work)
 {
 	struct adp5588_kpad *kpad = container_of(work,
@@ -204,6 +290,7 @@ static int __devinit adp5588_probe(struct
i2c_client *client,
 	int ret, i;
 	int error;
 	int gpi_stat1 = 0, gpi_stat2 = 0, gpi_stat3 = 0;
+	struct gpio_chip *gc;

 	if (!i2c_check_functionality(client->adapter,
 					I2C_FUNC_SMBUS_BYTE_DATA)) {
@@ -273,6 +360,24 @@ static int __devinit adp5588_probe(struct
i2c_client *client,
 	kpad->input = input;
 	INIT_DELAYED_WORK(&kpad->work, adp5588_work);

+	kpad->support_gpio = pdata->support_gpio;
+
+	if (kpad->support_gpio) {
+		gc = &kpad->gpio_chip;
+		gc->direction_input = adp5588_gpio_direction_input;
+		gc->direction_output = adp5588_gpio_direction_output;
+		gc->get = adp5588_gpio_get_value;
+		gc->set = adp5588_gpio_set_value;
+		gc->can_sleep = 1;
+
+		gc->base = pdata->gpio_start;
+		gc->ngpio = MAXGPIO;
+		gc->label = client->name;
+		gc->owner = THIS_MODULE;
+
+		mutex_init(&kpad->gpio_lock);
+	}
+
 	ret = adp5588_read(client, DEV_ID);
 	if (ret < 0) {
 		error = ret;
@@ -340,6 +445,35 @@ static int __devinit adp5588_probe(struct
i2c_client *client,
 	device_init_wakeup(&client->dev, 1);
 	i2c_set_clientdata(client, kpad);

+	if (kpad->support_gpio) {
+		ret = gpiochip_add(&kpad->gpio_chip);
+		if (ret) {
+			dev_err(&client->dev, "gpiochip_add err: %d\n", ret);
+			goto err_free_irq;
+		}
+
+		for (i = 0; i <= ADP_BANK(MAXGPIO); i++) {
+			kpad->dat_out[i] = adp5588_read(client,
+						GPIO_DAT_OUT1 + i);
+			kpad->dir[i] = adp5588_read(client, GPIO_DIR1 + i);
+		}
+
+		for (i = 0; i < pdata->rows; i++)
+			kpad->pin_used[i] = 1;
+
+		for (i = 0; i < pdata->cols; i++)
+			kpad->pin_used[i + GPI_PIN_COL_BASE - GPI_PIN_BASE] = 1;
+
+		for (i = 0; i < kpad->gpimapsize; i++)
+			kpad->pin_used[kpad->gpimap[i].pin - GPI_PIN_BASE] = 1;
+
+		for (i = 0; i < MAXGPIO; i++) {
+			if (kpad->pin_used[i])
+				ret = gpio_request(pdata->gpio_start + i,
+						"adp5588-kpad");
+		}
+	}
+
 	if (kpad->gpimapsize) {
 		gpi_stat1 = adp5588_read(client, GPIO_DAT_STAT1);
 		gpi_stat2 = adp5588_read(client, GPIO_DAT_STAT2);
@@ -389,12 +523,19 @@ static int __devinit adp5588_probe(struct
i2c_client *client,

 static int __devexit adp5588_remove(struct i2c_client *client)
 {
+	int i, ret;
 	struct adp5588_kpad *kpad = i2c_get_clientdata(client);

 	adp5588_write(client, CFG, 0);
 	free_irq(client->irq, kpad);
 	cancel_delayed_work_sync(&kpad->work);
 	input_unregister_device(kpad->input);
+	if (kpad->support_gpio) {
+		for (i = 0; i < MAXGPIO; i++)
+			if (kpad->pin_used[i])
+				gpio_free(kpad->gpio_chip.base + i);
+		ret = gpiochip_remove(&kpad->gpio_chip);
+	}
 	i2c_set_clientdata(client, NULL);
 	kfree(kpad);

diff --git a/include/linux/i2c/adp5588.h b/include/linux/i2c/adp5588.h
index a00686c..35078c3 100644
--- a/include/linux/i2c/adp5588.h
+++ b/include/linux/i2c/adp5588.h
@@ -123,6 +123,8 @@ struct adp5588_kpad_platform_data {
 	unsigned short unlock_key2;	/* Unlock Key 2 */
 	const struct adp5588_gpi_map *gpimap;
 	unsigned short gpimapsize;
+	unsigned support_gpio:1;	/* Support gpio on unused pin */
+	unsigned gpio_start;
 };

 #endif
-- 
1.7.0.4

Thanks,
Xiaolong

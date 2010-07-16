From: Xiaolong CHEN <a21785@motorola.com>
Subject: Re: [RFC] [PATCH] Input: ADP5588 - Support gpio function on unused
	pin
Date: Fri, 16 Jul 2010 19:48:07 +0800
Message-ID: <AANLkTimCA8gNc6aQW46ESbSbqxT6UGoqbT5PWC3vwkBc@mail.gmail.com>
References: <AANLkTikJKMYajxh799evj7Xv_HV3DFhabCZgYDkhuokh@mail.gmail.com>
	<AANLkTimbg9yhPvR8vya2dN4MIOF0JxyKbOrpQ_T0R_T3@mail.gmail.com>
	<544AC56F16B56944AEC3BD4E3D5917712E7EA5A357@LIMKCMBX1.ad.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exprod5og102.obsmtp.com ([64.18.0.143]:34271 "EHLO
	exprod5og102.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965166Ab0GPLsK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Jul 2010 07:48:10 -0400
Received: from az10vts04.mot.com (il27vts04.cig.mot.com [10.17.196.88])
	by mdgate2.corp.mot.com (8.14.3/8.14.3) with SMTP id o6GBlSQB019355
	for <linux-input@vger.kernel.org>; Fri, 16 Jul 2010 05:47:28 -0600 (MDT)
Received: from mail-iw0-f182.google.com (mail-iw0-f182.google.com [209.85.214.182])
	by mdgate2.corp.mot.com (8.14.3/8.14.3) with ESMTP id o6GBlRV0019344
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-input@vger.kernel.org>; Fri, 16 Jul 2010 05:47:28 -0600 (MDT)
Received: by iwn35 with SMTP id 35so2917323iwn.27
        for <linux-input@vger.kernel.org>; Fri, 16 Jul 2010 04:48:07 -0700 (PDT)
In-Reply-To: <544AC56F16B56944AEC3BD4E3D5917712E7EA5A357@LIMKCMBX1.ad.analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Torokhov <dtor@mail.ru>, david-b@pacbell.net
Cc: Xiaolong CHEN <xiao-long.chen@motorola.com>, Michael Hennerich <hennerich@blackfin.uclinux.org>, linux-input@vger.kernel.org, TAO HU <taohu@motorola.com>, "Yuan.Bo YE" <yuan-bo.ye@motorola.com>

Hi, Michael,

Thanks for your comments, I agree with you, it's a better way to
export only the spare pins as GPIO.
I update this patch, any comments and suggestion, feel free let me know=
=2E

Patch:

=46rom 027a344b0fc49f87edd325d5896c3d0985ec5869 Mon Sep 17 00:00:00 200=
1
=46rom: Xiaolong Chen <a21785@motorola.com>
Date: Sat, 17 Jul 2010 03:18:28 +0800
Subject: [PATCH] Input: ADP5588 - Support gpio function on unused pin

This implements an optional gpio function on unused pin by adp5588
kpad.

adp5588_kpad_platform_data has been extended with support_gpio,
support gpio function if it equals 1, and gpio_start, the gpio chip
base for this module.

Signed-off-by: Xiaolong Chen <xiao-long.chen@motorola.com>
Signed-off-by: Yuanbo Ye <yuan-bo.ye@motorola.com>
Signed-off-by: Tao Hu <taohu@motorola.com>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/input/keyboard/adp5588-keys.c |  144 +++++++++++++++++++++++++=
++++++++
 include/linux/i2c/adp5588.h           |    2 +
 2 files changed, 146 insertions(+), 0 deletions(-)

diff --git a/drivers/input/keyboard/adp5588-keys.c
b/drivers/input/keyboard/adp5588-keys.c
index 3c8876a..ed18c93 100644
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
+	unsigned char gpiomap[MAXGPIO];
+	unsigned support_gpio;
+	struct gpio_chip gpio_chip;
+	struct mutex gpio_lock;	/* Protect cached dir, dat_out */
+	uint8_t dat_out[3];
+	uint8_t dir[3];
 };

 static int adp5588_read(struct i2c_client *client, u8 reg)
@@ -84,6 +95,85 @@ static int adp5588_write(struct i2c_client *client,
u8 reg, u8 val)
 	return i2c_smbus_write_byte_data(client, reg, val);
 }

+static int adp5588_gpio_get_value(struct gpio_chip *chip, unsigned off=
)
+{
+	unsigned bank, bit;
+	struct adp5588_kpad *dev =3D
+	    container_of(chip, struct adp5588_kpad, gpio_chip);
+
+	bank =3D ADP_BANK(dev->gpiomap[off]);
+	bit =3D ADP_BIT(dev->gpiomap[off]);
+
+	return !!(adp5588_read(dev->client, GPIO_DAT_STAT1 + bank) & bit);
+}
+
+static void adp5588_gpio_set_value(struct gpio_chip *chip,
+				   unsigned off, int val)
+{
+	unsigned bank, bit;
+	struct adp5588_kpad *dev =3D
+	    container_of(chip, struct adp5588_kpad, gpio_chip);
+
+	bank =3D ADP_BANK(dev->gpiomap[off]);
+	bit =3D ADP_BIT(dev->gpiomap[off]);
+
+	mutex_lock(&dev->gpio_lock);
+	if (val)
+		dev->dat_out[bank] |=3D bit;
+	else
+		dev->dat_out[bank] &=3D ~bit;
+
+	adp5588_write(dev->client, GPIO_DAT_OUT1 + bank,
+			   dev->dat_out[bank]);
+	mutex_unlock(&dev->gpio_lock);
+}
+
+static int adp5588_gpio_direction_input(struct gpio_chip *chip, unsign=
ed off)
+{
+	int ret;
+	unsigned bank, bit;
+	struct adp5588_kpad *dev =3D
+	    container_of(chip, struct adp5588_kpad, gpio_chip);
+
+	bank =3D ADP_BANK(dev->gpiomap[off]);
+	bit =3D ADP_BIT(dev->gpiomap[off]);
+
+	mutex_lock(&dev->gpio_lock);
+	dev->dir[bank] &=3D ~bit;
+	ret =3D adp5588_write(dev->client, GPIO_DIR1 + bank, dev->dir[bank]);
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
+	struct adp5588_kpad *dev =3D
+	    container_of(chip, struct adp5588_kpad, gpio_chip);
+
+	bank =3D ADP_BANK(dev->gpiomap[off]);
+	bit =3D ADP_BIT(dev->gpiomap[off]);
+
+	mutex_lock(&dev->gpio_lock);
+	dev->dir[bank] |=3D bit;
+
+	if (val)
+		dev->dat_out[bank] |=3D bit;
+	else
+		dev->dat_out[bank] &=3D ~bit;
+
+	ret =3D adp5588_write(dev->client, GPIO_DAT_OUT1 + bank,
+				 dev->dat_out[bank]);
+	ret |=3D adp5588_write(dev->client, GPIO_DIR1 + bank,
+				 dev->dir[bank]);
+	mutex_unlock(&dev->gpio_lock);
+
+	return ret;
+}
+
 static void adp5588_work(struct work_struct *work)
 {
 	struct adp5588_kpad *kpad =3D container_of(work,
@@ -204,6 +294,7 @@ static int __devinit adp5588_probe(struct
i2c_client *client,
 	int ret, i;
 	int error;
 	int gpi_stat1 =3D 0, gpi_stat2 =3D 0, gpi_stat3 =3D 0;
+	struct gpio_chip *gc;

 	if (!i2c_check_functionality(client->adapter,
 					I2C_FUNC_SMBUS_BYTE_DATA)) {
@@ -273,6 +364,24 @@ static int __devinit adp5588_probe(struct
i2c_client *client,
 	kpad->input =3D input;
 	INIT_DELAYED_WORK(&kpad->work, adp5588_work);

+	kpad->support_gpio =3D pdata->support_gpio;
+
+	if (kpad->support_gpio) {
+		gc =3D &kpad->gpio_chip;
+		gc->direction_input =3D adp5588_gpio_direction_input;
+		gc->direction_output =3D adp5588_gpio_direction_output;
+		gc->get =3D adp5588_gpio_get_value;
+		gc->set =3D adp5588_gpio_set_value;
+		gc->can_sleep =3D 1;
+
+		gc->base =3D pdata->gpio_start;
+		gc->ngpio =3D MAXGPIO;
+		gc->label =3D client->name;
+		gc->owner =3D THIS_MODULE;
+
+		mutex_init(&kpad->gpio_lock);
+	}
+
 	ret =3D adp5588_read(client, DEV_ID);
 	if (ret < 0) {
 		error =3D ret;
@@ -340,6 +449,38 @@ static int __devinit adp5588_probe(struct
i2c_client *client,
 	device_init_wakeup(&client->dev, 1);
 	i2c_set_clientdata(client, kpad);

+	if (kpad->support_gpio) {
+		int j =3D 0;
+		unsigned char pin_used[MAXGPIO];
+
+		for (i =3D 0; i < pdata->rows; i++)
+			pin_used[i] =3D 1;
+
+		for (i =3D 0; i < pdata->cols; i++)
+			pin_used[i + GPI_PIN_COL_BASE - GPI_PIN_BASE] =3D 1;
+
+		for (i =3D 0; i < kpad->gpimapsize; i++)
+			pin_used[kpad->gpimap[i].pin - GPI_PIN_BASE] =3D 1;
+
+		for (i =3D 0; i < MAXGPIO; i++) {
+			if (!pin_used[i])
+				kpad->gpiomap[j++] =3D i;
+		}
+		kpad->gpio_chip.ngpio =3D j;
+
+		ret =3D gpiochip_add(&kpad->gpio_chip);
+		if (ret) {
+			dev_err(&client->dev, "gpiochip_add err: %d\n", ret);
+			goto err_free_irq;
+		}
+
+		for (i =3D 0; i <=3D ADP_BANK(MAXGPIO); i++) {
+			kpad->dat_out[i] =3D adp5588_read(client,
+						GPIO_DAT_OUT1 + i);
+			kpad->dir[i] =3D adp5588_read(client, GPIO_DIR1 + i);
+		}
+	}
+
 	if (kpad->gpimapsize) {
 		gpi_stat1 =3D adp5588_read(client, GPIO_DAT_STAT1);
 		gpi_stat2 =3D adp5588_read(client, GPIO_DAT_STAT2);
@@ -389,12 +530,15 @@ static int __devinit adp5588_probe(struct
i2c_client *client,

 static int __devexit adp5588_remove(struct i2c_client *client)
 {
+	int ret;
 	struct adp5588_kpad *kpad =3D i2c_get_clientdata(client);

 	adp5588_write(client, CFG, 0);
 	free_irq(client->irq, kpad);
 	cancel_delayed_work_sync(&kpad->work);
 	input_unregister_device(kpad->input);
+	if (kpad->support_gpio)
+		ret =3D gpiochip_remove(&kpad->gpio_chip);
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
--=20
1.7.0.4

Thanks,
Xiaolong

On Fri, Jul 16, 2010 at 4:48 PM, Hennerich, Michael
<Michael.Hennerich@analog.com> wrote:
> Xiaolong CHEN wrote on 2010-07-16:
>> Hi, Michael and Dmitry
>>
>> Do you have any comments and suggestion?
>
> Hi Xiaolong,
>
> First of all - great idea to export unused pins as GPIOs.
> This closed the gap between adp5588-gpio and adp5588-keys.
>
> But I wonder why you gpio_request() and free inside the driver.
> I would export only the spare pins as GPIO. I see that this will
> complicate things a little bit by adding some mapping.
> But first exporting as GPIO and then reserving them by
> gpio_request doesn't look like a straight approach.
>
> If no one else complains (adding David) I'm fine with the way it is n=
ow.
>
> Acked-by: Michael Hennerich <michael.hennerich@analog.com>
>
> Greetings,
> Michael
>
> Analog Devices GmbH =A0 =A0 =A0Wilhelm-Wagenfeld-Str. 6 =A0 =A0 =A080=
807 Muenchen
> Sitz der Gesellschaft Muenchen, Registergericht Muenchen HRB 4036 Ges=
chaeftsfuehrer Thomas Wessel, William A. Martin, Margaret Seif
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

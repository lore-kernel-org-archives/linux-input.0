From: Xiaolong CHEN <a21785@motorola.com>
Subject: Re: [RFC] [PATCH] Input: ADP5588 - Support gpio function on unused
	pin
Date: Mon, 19 Jul 2010 21:00:55 +0800
Message-ID: <AANLkTinXdwVcUBcE8GySK_5ELkuQKiaB4D5l74lVWr3j@mail.gmail.com>
References: <AANLkTikJKMYajxh799evj7Xv_HV3DFhabCZgYDkhuokh@mail.gmail.com>
	<AANLkTimbg9yhPvR8vya2dN4MIOF0JxyKbOrpQ_T0R_T3@mail.gmail.com>
	<544AC56F16B56944AEC3BD4E3D5917712E7EA5A357@LIMKCMBX1.ad.analog.com>
	<AANLkTimCA8gNc6aQW46ESbSbqxT6UGoqbT5PWC3vwkBc@mail.gmail.com>
	<20100716162017.GA9232@core.coreip.homeip.net>
	<20100716164239.GC9232@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exprod5og114.obsmtp.com ([64.18.0.28]:40737 "EHLO
	exprod5og114.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932190Ab0GSNBF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Jul 2010 09:01:05 -0400
Received: from il27vts01 (il27vts01.cig.mot.com [10.17.196.85])
	by mdgate2.corp.mot.com (8.14.3/8.14.3) with SMTP id o6JD0GOt018244
	for <linux-input@vger.kernel.org>; Mon, 19 Jul 2010 07:00:16 -0600 (MDT)
Received: from mail-gx0-f182.google.com (mail-gx0-f182.google.com [209.85.161.182])
	by mdgate2.corp.mot.com (8.14.3/8.14.3) with ESMTP id o6JD0Gqc018230
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-input@vger.kernel.org>; Mon, 19 Jul 2010 07:00:16 -0600 (MDT)
Received: by gxk24 with SMTP id 24so3092025gxk.27
        for <linux-input@vger.kernel.org>; Mon, 19 Jul 2010 06:00:57 -0700 (PDT)
In-Reply-To: <20100716164239.GC9232@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Xiaolong CHEN <xiao-long.chen@motorola.com>, "Hennerich, Michael" <Michael.Hennerich@analog.com>, david-b@pacbell.net, Michael Hennerich <hennerich@blackfin.uclinux.org>, linux-input@vger.kernel.org, TAO HU <taohu@motorola.com>, "Yuan.Bo YE" <yuan-bo.ye@motorola.com>

Hi Dmitry,

Thanks for your comments, update the patch, using
adp5588_gpio_platform_data instead of support_gpio and gpio_start. If
there is any comments and suggestion, please feel free let me know.

Why do we do this conditionally? Is there a reason why exporting unused
gpio pins would be unwelcome?
At the beginning, I think anyone who don't want the gpio function,
could disable it by support_gpio, if haven't this var, the gpio_start
have to be set correctly, otherwise, the keypad driver might be failed
when probe.
I update the patch, now using the gpio_data instead of it, if the
gpio_data =3D NULL, the gpio function will be disabled.

Throughout the driver we normally name struct adp5588_kpad variables as
kpad, not dev. In fact, when I see dev I think "driver model
abstraction" and not "this particular hardware". Care to rename to kpad
here (and below) as well?
Done.

Looks like your e-mail miight be line-wrapped...
Yes, it should be the e-mail system issue.

Make it bool (now that we have it)  and use boolean values below.
Done.

What happens if we end up with ngpio =3D=3D 0?
Yes, it might be a issue, I correct it in the new patch.

Bool here as well. In theory bools might cause to waste a byte or 2 but
it's ok (and in this case you are not saving anything...).
Done.

You need to actually handle this (add an error message) since we can't
simply ignore errors.
Handle this issue in the new patch, porting the setup() and teardown()
from adp5588_gpio.c.

Patch:

=46rom bfd7f4e6abd73b00a5f1ad667c6119312784f9b0 Mon Sep 17 00:00:00 200=
1
=46rom: Xiaolong Chen <a21785@motorola.com>
Date: Tue, 20 Jul 2010 03:58:52 +0800
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
 drivers/input/keyboard/adp5588-keys.c |  184 +++++++++++++++++++++++++=
++++++++
 include/linux/i2c/adp5588.h           |    1 +
 2 files changed, 185 insertions(+), 0 deletions(-)

diff --git a/drivers/input/keyboard/adp5588-keys.c
b/drivers/input/keyboard/adp5588-keys.c
index 3c8876a..66d1e4a 100644
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
+	bool support_gpio;
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
+	struct adp5588_kpad *kpad =3D
+	    container_of(chip, struct adp5588_kpad, gpio_chip);
+
+	bank =3D ADP_BANK(kpad->gpiomap[off]);
+	bit =3D ADP_BIT(kpad->gpiomap[off]);
+
+	return !!(adp5588_read(kpad->client, GPIO_DAT_STAT1 + bank) & bit);
+}
+
+static void adp5588_gpio_set_value(struct gpio_chip *chip,
+				   unsigned off, int val)
+{
+	unsigned bank, bit;
+	struct adp5588_kpad *kpad =3D
+	    container_of(chip, struct adp5588_kpad, gpio_chip);
+
+	bank =3D ADP_BANK(kpad->gpiomap[off]);
+	bit =3D ADP_BIT(kpad->gpiomap[off]);
+
+	mutex_lock(&kpad->gpio_lock);
+	if (val)
+		kpad->dat_out[bank] |=3D bit;
+	else
+		kpad->dat_out[bank] &=3D ~bit;
+
+	adp5588_write(kpad->client, GPIO_DAT_OUT1 + bank,
+			   kpad->dat_out[bank]);
+	mutex_unlock(&kpad->gpio_lock);
+}
+
+static int adp5588_gpio_direction_input(struct gpio_chip *chip, unsign=
ed off)
+{
+	int ret;
+	unsigned bank, bit;
+	struct adp5588_kpad *kpad =3D
+	    container_of(chip, struct adp5588_kpad, gpio_chip);
+
+	bank =3D ADP_BANK(kpad->gpiomap[off]);
+	bit =3D ADP_BIT(kpad->gpiomap[off]);
+
+	mutex_lock(&kpad->gpio_lock);
+	kpad->dir[bank] &=3D ~bit;
+	ret =3D adp5588_write(kpad->client, GPIO_DIR1 + bank, kpad->dir[bank]=
);
+	mutex_unlock(&kpad->gpio_lock);
+
+	return ret;
+}
+
+static int adp5588_gpio_direction_output(struct gpio_chip *chip,
+					 unsigned off, int val)
+{
+	int ret;
+	unsigned bank, bit;
+	struct adp5588_kpad *kpad =3D
+	    container_of(chip, struct adp5588_kpad, gpio_chip);
+
+	bank =3D ADP_BANK(kpad->gpiomap[off]);
+	bit =3D ADP_BIT(kpad->gpiomap[off]);
+
+	mutex_lock(&kpad->gpio_lock);
+	kpad->dir[bank] |=3D bit;
+
+	if (val)
+		kpad->dat_out[bank] |=3D bit;
+	else
+		kpad->dat_out[bank] &=3D ~bit;
+
+	ret =3D adp5588_write(kpad->client, GPIO_DAT_OUT1 + bank,
+				 kpad->dat_out[bank]);
+	ret |=3D adp5588_write(kpad->client, GPIO_DIR1 + bank,
+				 kpad->dir[bank]);
+	mutex_unlock(&kpad->gpio_lock);
+
+	return ret;
+}
+
 static void adp5588_work(struct work_struct *work)
 {
 	struct adp5588_kpad *kpad =3D container_of(work,
@@ -180,6 +270,15 @@ static int __devinit adp5588_setup(struct
i2c_client *client)
 		ret |=3D adp5588_write(client, GPI_EM3, evt_mode3);
 	}

+	if (pdata->gpio_data) {
+		for (i =3D 0; i <=3D ADP_BANK(MAXGPIO); i++) {
+			int pull_mask =3D pdata->gpio_data->pullup_dis_mask;
+
+			ret |=3D adp5588_write(client, GPIO_PULL1 + i,
+				(pull_mask >> (8 * i)) & 0xFF);
+		}
+	}
+
 	ret |=3D adp5588_write(client, INT_STAT, CMP2_INT | CMP1_INT |
 					OVR_FLOW_INT | K_LCK_INT |
 					GPI_INT | KE_INT); /* Status is W1C */
@@ -204,6 +303,7 @@ static int __devinit adp5588_probe(struct
i2c_client *client,
 	int ret, i;
 	int error;
 	int gpi_stat1 =3D 0, gpi_stat2 =3D 0, gpi_stat3 =3D 0;
+	struct gpio_chip *gc;

 	if (!i2c_check_functionality(client->adapter,
 					I2C_FUNC_SMBUS_BYTE_DATA)) {
@@ -273,6 +373,44 @@ static int __devinit adp5588_probe(struct
i2c_client *client,
 	kpad->input =3D input;
 	INIT_DELAYED_WORK(&kpad->work, adp5588_work);

+	if (pdata->gpio_data) {
+		int j =3D 0;
+		bool pin_used[MAXGPIO];
+
+		for (i =3D 0; i < pdata->rows; i++)
+			pin_used[i] =3D true;
+
+		for (i =3D 0; i < pdata->cols; i++)
+			pin_used[i + GPI_PIN_COL_BASE - GPI_PIN_BASE] =3D true;
+
+		for (i =3D 0; i < kpad->gpimapsize; i++)
+			pin_used[kpad->gpimap[i].pin - GPI_PIN_BASE] =3D true;
+
+		for (i =3D 0; i < MAXGPIO; i++) {
+			if (!pin_used[i])
+				kpad->gpiomap[j++] =3D i;
+		}
+		kpad->gpio_chip.ngpio =3D j;
+
+		if (kpad->gpio_chip.ngpio)
+			kpad->support_gpio =3D true;
+	}
+
+	if (kpad->support_gpio) {
+		gc =3D &kpad->gpio_chip;
+		gc->direction_input =3D adp5588_gpio_direction_input;
+		gc->direction_output =3D adp5588_gpio_direction_output;
+		gc->get =3D adp5588_gpio_get_value;
+		gc->set =3D adp5588_gpio_set_value;
+		gc->can_sleep =3D 1;
+
+		gc->base =3D pdata->gpio_data->gpio_start;
+		gc->label =3D client->name;
+		gc->owner =3D THIS_MODULE;
+
+		mutex_init(&kpad->gpio_lock);
+	}
+
 	ret =3D adp5588_read(client, DEV_ID);
 	if (ret < 0) {
 		error =3D ret;
@@ -340,6 +478,31 @@ static int __devinit adp5588_probe(struct
i2c_client *client,
 	device_init_wakeup(&client->dev, 1);
 	i2c_set_clientdata(client, kpad);

+	if (kpad->support_gpio) {
+		ret =3D gpiochip_add(&kpad->gpio_chip);
+		if (ret) {
+			dev_err(&client->dev, "gpiochip_add err: %d\n",
+						ret);
+			goto err_free_irq;
+		}
+
+		for (i =3D 0; i <=3D ADP_BANK(MAXGPIO); i++) {
+			kpad->dat_out[i] =3D adp5588_read(client,
+						GPIO_DAT_OUT1 + i);
+			kpad->dir[i] =3D adp5588_read(client,
+						GPIO_DIR1 + i);
+		}
+
+		if (pdata->gpio_data->setup) {
+			ret =3D pdata->gpio_data->setup(client,
+				kpad->gpio_chip.base, kpad->gpio_chip.ngpio,
+				pdata->gpio_data->context);
+			if (ret < 0)
+				dev_warn(&client->dev,
+						"setup failed, %d\n", ret);
+		}
+	}
+
 	if (kpad->gpimapsize) {
 		gpi_stat1 =3D adp5588_read(client, GPIO_DAT_STAT1);
 		gpi_stat2 =3D adp5588_read(client, GPIO_DAT_STAT2);
@@ -389,12 +552,33 @@ static int __devinit adp5588_probe(struct
i2c_client *client,

 static int __devexit adp5588_remove(struct i2c_client *client)
 {
+	int ret;
+	struct adp5588_kpad_platform_data *pdata =3D client->dev.platform_dat=
a;
 	struct adp5588_kpad *kpad =3D i2c_get_clientdata(client);

 	adp5588_write(client, CFG, 0);
 	free_irq(client->irq, kpad);
 	cancel_delayed_work_sync(&kpad->work);
 	input_unregister_device(kpad->input);
+	if (kpad->support_gpio) {
+		if (pdata->gpio_data->teardown) {
+			ret =3D pdata->gpio_data->teardown(client,
+				kpad->gpio_chip.base, kpad->gpio_chip.ngpio,
+				pdata->gpio_data->context);
+			if (ret < 0) {
+				dev_err(&client->dev,
+						"teardown failed %d\n", ret);
+				return ret;
+			}
+		}
+
+		ret =3D gpiochip_remove(&kpad->gpio_chip);
+		if (ret) {
+			dev_err(&client->dev,
+					"gpiochip_remove failed %d\n", ret);
+			return ret;
+		}
+	}
 	i2c_set_clientdata(client, NULL);
 	kfree(kpad);

diff --git a/include/linux/i2c/adp5588.h b/include/linux/i2c/adp5588.h
index b6e8807..ede3cd2 100644
--- a/include/linux/i2c/adp5588.h
+++ b/include/linux/i2c/adp5588.h
@@ -123,6 +123,7 @@ struct adp5588_kpad_platform_data {
 	unsigned short unlock_key2;	/* Unlock Key 2 */
 	const struct adp5588_gpi_map *gpimap;
 	unsigned short gpimapsize;
+	struct adp5588_gpio_platform_data *gpio_data;
 };

 struct adp5588_gpio_platform_data {
--=20
1.7.0.4

Thanks,
Xiaolong



On Sat, Jul 17, 2010 at 12:42 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> One more thing...
>
> On Fri, Jul 16, 2010 at 09:20:18AM -0700, Dmitry Torokhov wrote:
>> On Fri, Jul 16, 2010 at 07:48:07PM +0800, Xiaolong CHEN wrote:
>> > =A0static int __devexit adp5588_remove(struct i2c_client *client)
>> > =A0{
>> > + =A0 int ret;
>> > =A0 =A0 struct adp5588_kpad *kpad =3D i2c_get_clientdata(client);
>> >
>> > =A0 =A0 adp5588_write(client, CFG, 0);
>> > =A0 =A0 free_irq(client->irq, kpad);
>> > =A0 =A0 cancel_delayed_work_sync(&kpad->work);
>> > =A0 =A0 input_unregister_device(kpad->input);
>> > + =A0 if (kpad->support_gpio)
>> > + =A0 =A0 =A0 =A0 =A0 ret =3D gpiochip_remove(&kpad->gpio_chip);
>
> You need to actually handle this (add an error message) since we can'=
t
> simply ignore errors.
>
> However I think that having gpiochip_remove() __must_check while
> gpiochip_add is quite silly.
>
> I'd argue that gpiochip_remove() should wither WARN or BUG if we tryi=
ng
> to remove a chip that still has GPIOs requested and return void since
> callers normally can't do anything about the failure. Many simply abo=
rt
> device teardown leaving device a zombie and report failure up the sta=
ck,
> to the driver core, where it is ignored. Not very helpful.
>
> --
> Dmitry
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Xiaolong CHEN <a21785@motorola.com>
Subject: Re: [RFC] [PATCH] Input: ADP5588 - Support gpio function on unused
	pin
Date: Fri, 16 Jul 2010 16:05:11 +0800
Message-ID: <AANLkTimbg9yhPvR8vya2dN4MIOF0JxyKbOrpQ_T0R_T3@mail.gmail.com>
References: <AANLkTikJKMYajxh799evj7Xv_HV3DFhabCZgYDkhuokh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exprod5og102.obsmtp.com ([64.18.0.143]:47023 "EHLO
	exprod5og102.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935904Ab0GPIFP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Jul 2010 04:05:15 -0400
Received: from il27vts03 (il27vts03.cig.mot.com [10.17.196.87])
	by mdgate2.corp.mot.com (8.14.3/8.14.3) with SMTP id o6G84Uui013487
	for <linux-input@vger.kernel.org>; Fri, 16 Jul 2010 02:04:30 -0600 (MDT)
Received: from mail-iw0-f182.google.com (mail-iw0-f182.google.com [209.85.214.182])
	by mdgate2.corp.mot.com (8.14.3/8.14.3) with ESMTP id o6G84TWc013482
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-input@vger.kernel.org>; Fri, 16 Jul 2010 02:04:30 -0600 (MDT)
Received: by iwn35 with SMTP id 35so2693003iwn.27
        for <linux-input@vger.kernel.org>; Fri, 16 Jul 2010 01:05:11 -0700 (PDT)
In-Reply-To: <AANLkTikJKMYajxh799evj7Xv_HV3DFhabCZgYDkhuokh@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Torokhov <dtor@mail.ru>, Michael Hennerich <hennerich@blackfin.uclinux.org>
Cc: linux-input@vger.kernel.org, TAO HU <taohu@motorola.com>, "Yuan.Bo YE" <yuan-bo.ye@motorola.com>

Hi, Michael and Dmitry

Do you have any comments and suggestion?

Thanks,
Xiaolong

On Wed, Jul 14, 2010 at 3:23 PM, Xiaolong CHEN <a21785@motorola.com> wr=
ote:
> Hi,
>
> This patch depends on the patch, "Input: ADP5588 - Support GPI event
> for ADP5588 devices", it supports gpio function on unused pin.
>
> Usage:
> Set Support_gpio =3D 1 to enable gpio function, and set gpio_start fo=
r
> the gpio_chip base.
>
> If there is any comments and suggestion please let me know.
>
> Patch:
>
> From 5b442d7d7cc5307dcfaea8f3d1494b87da6182de Mon Sep 17 00:00:00 200=
1
> From: Xiaolong Chen <a21785@motorola.com>
> Date: Tue, 13 Jul 2010 23:55:12 +0800
> Subject: [PATCH] Input: ADP5588 - Support gpio function on unused pin
>
> This implements an optional gpio function on unused pin by adp5588
> kpad.
>
> adp5588_kpad_platform_data has been extended with support_gpio,
> support gpio function if it equals 1, and gpio_start, the gpio chip
> base for this module.
>
> Signed-off-by: Xiaolong Chen <xiao-long.chen@motorola.com>
> Signed-off-by: Yuanbo Ye <yuan-bo.ye@motorola.com>
> Signed-off-by: Tao Hu <taohu@motorola.com>
> ---
> =A0drivers/input/keyboard/adp5588-keys.c | =A0141 +++++++++++++++++++=
++++++++++++++
> =A0include/linux/i2c/adp5588.h =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +
> =A02 files changed, 143 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/input/keyboard/adp5588-keys.c
> b/drivers/input/keyboard/adp5588-keys.c
> index 3c8876a..e1455f8 100644
> --- a/drivers/input/keyboard/adp5588-keys.c
> +++ b/drivers/input/keyboard/adp5588-keys.c
> @@ -18,6 +18,7 @@
> =A0#include <linux/platform_device.h>
> =A0#include <linux/input.h>
> =A0#include <linux/i2c.h>
> +#include <linux/gpio.h>
>
> =A0#include <linux/i2c/adp5588.h>
>
> @@ -52,6 +53,10 @@
>
> =A0#define KEYP_MAX_EVENT =A0 =A0 =A0 =A0 10
>
> +#define MAXGPIO =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A018
> +#define ADP_BANK(offs) =A0 =A0 =A0 =A0 ((offs) >> 3)
> +#define ADP_BIT(offs) =A0 =A0 =A0 =A0 =A0(1u << ((offs) & 0x7))
> +
> =A0/*
> =A0* Early pre 4.0 Silicon required to delay readout by at least 25ms=
,
> =A0* since the Event Counter Register updated 25ms after the interrup=
t
> @@ -67,6 +72,12 @@ struct adp5588_kpad {
> =A0 =A0 =A0 =A0unsigned short keycode[ADP5588_KEYMAPSIZE];
> =A0 =A0 =A0 =A0const struct adp5588_gpi_map *gpimap;
> =A0 =A0 =A0 =A0unsigned short gpimapsize;
> + =A0 =A0 =A0 unsigned char pin_used[MAXGPIO];
> + =A0 =A0 =A0 unsigned support_gpio;
> + =A0 =A0 =A0 struct gpio_chip gpio_chip;
> + =A0 =A0 =A0 struct mutex gpio_lock; /* Protect cached dir, dat_out =
*/
> + =A0 =A0 =A0 uint8_t dat_out[3];
> + =A0 =A0 =A0 uint8_t dir[3];
> =A0};
>
> =A0static int adp5588_read(struct i2c_client *client, u8 reg)
> @@ -84,6 +95,81 @@ static int adp5588_write(struct i2c_client *client=
,
> u8 reg, u8 val)
> =A0 =A0 =A0 =A0return i2c_smbus_write_byte_data(client, reg, val);
> =A0}
>
> +static int adp5588_gpio_get_value(struct gpio_chip *chip, unsigned o=
ff)
> +{
> + =A0 =A0 =A0 struct adp5588_kpad *dev =3D
> + =A0 =A0 =A0 =A0 =A0 container_of(chip, struct adp5588_kpad, gpio_ch=
ip);
> +
> + =A0 =A0 =A0 return !!(adp5588_read(dev->client, GPIO_DAT_STAT1 + AD=
P_BANK(off))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & ADP_BIT(off));
> +}
> +
> +static void adp5588_gpio_set_value(struct gpio_chip *chip,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
unsigned off, int val)
> +{
> + =A0 =A0 =A0 unsigned bank, bit;
> + =A0 =A0 =A0 struct adp5588_kpad *dev =3D
> + =A0 =A0 =A0 =A0 =A0 container_of(chip, struct adp5588_kpad, gpio_ch=
ip);
> +
> + =A0 =A0 =A0 bank =3D ADP_BANK(off);
> + =A0 =A0 =A0 bit =3D ADP_BIT(off);
> +
> + =A0 =A0 =A0 mutex_lock(&dev->gpio_lock);
> + =A0 =A0 =A0 if (val)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->dat_out[bank] |=3D bit;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->dat_out[bank] &=3D ~bit;
> +
> + =A0 =A0 =A0 adp5588_write(dev->client, GPIO_DAT_OUT1 + bank,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev->dat_out[ban=
k]);
> + =A0 =A0 =A0 mutex_unlock(&dev->gpio_lock);
> +}
> +
> +static int adp5588_gpio_direction_input(struct gpio_chip *chip, unsi=
gned off)
> +{
> + =A0 =A0 =A0 int ret;
> + =A0 =A0 =A0 unsigned bank;
> + =A0 =A0 =A0 struct adp5588_kpad *dev =3D
> + =A0 =A0 =A0 =A0 =A0 container_of(chip, struct adp5588_kpad, gpio_ch=
ip);
> +
> + =A0 =A0 =A0 bank =3D ADP_BANK(off);
> +
> + =A0 =A0 =A0 mutex_lock(&dev->gpio_lock);
> + =A0 =A0 =A0 dev->dir[bank] &=3D ~ADP_BIT(off);
> + =A0 =A0 =A0 ret =3D adp5588_write(dev->client, GPIO_DIR1 + bank, de=
v->dir[bank]);
> + =A0 =A0 =A0 mutex_unlock(&dev->gpio_lock);
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static int adp5588_gpio_direction_output(struct gpio_chip *chip,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0unsigned off, int val)
> +{
> + =A0 =A0 =A0 int ret;
> + =A0 =A0 =A0 unsigned bank, bit;
> + =A0 =A0 =A0 struct adp5588_kpad *dev =3D
> + =A0 =A0 =A0 =A0 =A0 container_of(chip, struct adp5588_kpad, gpio_ch=
ip);
> +
> + =A0 =A0 =A0 bank =3D ADP_BANK(off);
> + =A0 =A0 =A0 bit =3D ADP_BIT(off);
> +
> + =A0 =A0 =A0 mutex_lock(&dev->gpio_lock);
> + =A0 =A0 =A0 dev->dir[bank] |=3D bit;
> +
> + =A0 =A0 =A0 if (val)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->dat_out[bank] |=3D bit;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->dat_out[bank] &=3D ~bit;
> +
> + =A0 =A0 =A0 ret =3D adp5588_write(dev->client, GPIO_DAT_OUT1 + bank=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev-=
>dat_out[bank]);
> + =A0 =A0 =A0 ret |=3D adp5588_write(dev->client, GPIO_DIR1 + bank,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev-=
>dir[bank]);
> + =A0 =A0 =A0 mutex_unlock(&dev->gpio_lock);
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> =A0static void adp5588_work(struct work_struct *work)
> =A0{
> =A0 =A0 =A0 =A0struct adp5588_kpad *kpad =3D container_of(work,
> @@ -204,6 +290,7 @@ static int __devinit adp5588_probe(struct
> i2c_client *client,
> =A0 =A0 =A0 =A0int ret, i;
> =A0 =A0 =A0 =A0int error;
> =A0 =A0 =A0 =A0int gpi_stat1 =3D 0, gpi_stat2 =3D 0, gpi_stat3 =3D 0;
> + =A0 =A0 =A0 struct gpio_chip *gc;
>
> =A0 =A0 =A0 =A0if (!i2c_check_functionality(client->adapter,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0I2C_FUNC_SMBUS_BYTE_DATA)) {
> @@ -273,6 +360,24 @@ static int __devinit adp5588_probe(struct
> i2c_client *client,
> =A0 =A0 =A0 =A0kpad->input =3D input;
> =A0 =A0 =A0 =A0INIT_DELAYED_WORK(&kpad->work, adp5588_work);
>
> + =A0 =A0 =A0 kpad->support_gpio =3D pdata->support_gpio;
> +
> + =A0 =A0 =A0 if (kpad->support_gpio) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gc =3D &kpad->gpio_chip;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gc->direction_input =3D adp5588_gpio_di=
rection_input;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gc->direction_output =3D adp5588_gpio_d=
irection_output;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gc->get =3D adp5588_gpio_get_value;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gc->set =3D adp5588_gpio_set_value;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gc->can_sleep =3D 1;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gc->base =3D pdata->gpio_start;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gc->ngpio =3D MAXGPIO;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gc->label =3D client->name;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gc->owner =3D THIS_MODULE;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_init(&kpad->gpio_lock);
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0ret =3D adp5588_read(client, DEV_ID);
> =A0 =A0 =A0 =A0if (ret < 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0error =3D ret;
> @@ -340,6 +445,35 @@ static int __devinit adp5588_probe(struct
> i2c_client *client,
> =A0 =A0 =A0 =A0device_init_wakeup(&client->dev, 1);
> =A0 =A0 =A0 =A0i2c_set_clientdata(client, kpad);
>
> + =A0 =A0 =A0 if (kpad->support_gpio) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D gpiochip_add(&kpad->gpio_chip);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "=
gpiochip_add err: %d\n", ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_irq;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i <=3D ADP_BANK(MAXGPIO);=
 i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kpad->dat_out[i] =3D ad=
p5588_read(client,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 GPIO_DAT_OUT1 + i);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kpad->dir[i] =3D adp558=
8_read(client, GPIO_DIR1 + i);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < pdata->rows; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kpad->pin_used[i] =3D 1=
;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < pdata->cols; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kpad->pin_used[i + GPI_=
PIN_COL_BASE - GPI_PIN_BASE] =3D 1;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < kpad->gpimapsize; i++=
)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kpad->pin_used[kpad->gp=
imap[i].pin - GPI_PIN_BASE] =3D 1;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < MAXGPIO; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (kpad->pin_used[i])
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D=
 gpio_request(pdata->gpio_start + i,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 "adp5588-kpad");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0if (kpad->gpimapsize) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gpi_stat1 =3D adp5588_read(client, GPI=
O_DAT_STAT1);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gpi_stat2 =3D adp5588_read(client, GPI=
O_DAT_STAT2);
> @@ -389,12 +523,19 @@ static int __devinit adp5588_probe(struct
> i2c_client *client,
>
> =A0static int __devexit adp5588_remove(struct i2c_client *client)
> =A0{
> + =A0 =A0 =A0 int i, ret;
> =A0 =A0 =A0 =A0struct adp5588_kpad *kpad =3D i2c_get_clientdata(clien=
t);
>
> =A0 =A0 =A0 =A0adp5588_write(client, CFG, 0);
> =A0 =A0 =A0 =A0free_irq(client->irq, kpad);
> =A0 =A0 =A0 =A0cancel_delayed_work_sync(&kpad->work);
> =A0 =A0 =A0 =A0input_unregister_device(kpad->input);
> + =A0 =A0 =A0 if (kpad->support_gpio) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < MAXGPIO; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (kpad->pin_used[i])
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_fr=
ee(kpad->gpio_chip.base + i);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D gpiochip_remove(&kpad->gpio_chi=
p);
> + =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0i2c_set_clientdata(client, NULL);
> =A0 =A0 =A0 =A0kfree(kpad);
>
> diff --git a/include/linux/i2c/adp5588.h b/include/linux/i2c/adp5588.=
h
> index a00686c..35078c3 100644
> --- a/include/linux/i2c/adp5588.h
> +++ b/include/linux/i2c/adp5588.h
> @@ -123,6 +123,8 @@ struct adp5588_kpad_platform_data {
> =A0 =A0 =A0 =A0unsigned short unlock_key2; =A0 =A0 /* Unlock Key 2 */
> =A0 =A0 =A0 =A0const struct adp5588_gpi_map *gpimap;
> =A0 =A0 =A0 =A0unsigned short gpimapsize;
> + =A0 =A0 =A0 unsigned support_gpio:1; =A0 =A0 =A0 =A0/* Support gpio=
 on unused pin */
> + =A0 =A0 =A0 unsigned gpio_start;
> =A0};
>
> =A0#endif
> --
> 1.7.0.4
>
> Thanks,
> Xiaolong
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

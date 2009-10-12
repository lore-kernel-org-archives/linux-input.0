From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [PATCH 6/6] haptic: ISA1200 haptic device support
Date: Tue, 13 Oct 2009 00:26:53 +0530
Message-ID: <5d5443650910121156x37ba6cd7w230bda9aef4df55@mail.gmail.com>
References: <20091007061830.GA7606@july>
	 <5d5443650910080244m59d4519u289450a0e8ae3454@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f186.google.com ([209.85.221.186]:48902 "EHLO
	mail-qy0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757886AbZJLS5a convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Oct 2009 14:57:30 -0400
In-Reply-To: <5d5443650910080244m59d4519u289450a0e8ae3454@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kyungmin Park <kyungmin.park@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org, ben-linux@fluff.org

Hi Kyungmin,

On Thu, Oct 8, 2009 at 3:14 PM, Trilok Soni <soni.trilok@gmail.com> wro=
te:
> Hi Kyungmin,
>
> Adding linux-i2c as it is i2c client driver and Ben Dooks for samsung
> pwm driver API usage.
>
> On Wed, Oct 7, 2009 at 11:48 AM, Kyungmin Park
> <kyungmin.park@samsung.com> wrote:
>> I2C based ISA1200 haptic driver support.
>> This chip supports both internal and external.
>> But only external configuration are implemented.
>
> Probably following text would look better:
>
> Add Imagis ISA1200 haptics chip driver support. This chip supports
> internal and external PWM configuration. This patch only supports
> external PWM configuration.
>
>> new file mode 100644
>> index 0000000..51c4ea4
>> --- /dev/null
>> +++ b/drivers/haptic/isa1200.c
>> @@ -0,0 +1,429 @@
>> +/*
>> + * =A0isa1200.c - Haptic Motor
>> + *
>> + * =A0Copyright (C) 2009 Samsung Electronics
>> + * =A0Kyungmin Park <kyungmin.park@samsung.com>
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License version 2 a=
s
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/init.h>
>> +#include <linux/i2c.h>
>> +#include <linux/gpio.h>
>> +#include <linux/haptic.h>
>> +#include <linux/delay.h>
>> +#include <linux/err.h>
>> +#include <linux/pwm.h>
>> +#include <linux/ctype.h>
>> +#include <linux/workqueue.h>
>> +#include <linux/i2c/isa1200.h>
>> +#include "haptic.h"
>> +
>> +struct isa1200_chip {
>> + =A0 =A0 =A0 struct i2c_client *client;
>> + =A0 =A0 =A0 struct pwm_device *pwm;
>> + =A0 =A0 =A0 struct haptic_classdev cdev;
>> + =A0 =A0 =A0 struct work_struct work;
>> + =A0 =A0 =A0 struct timer_list timer;
>> +
>> + =A0 =A0 =A0 unsigned int =A0 =A0len; =A0 =A0 =A0 =A0 =A0 =A0/* LDO=
 enable */
>> + =A0 =A0 =A0 unsigned int =A0 =A0hen; =A0 =A0 =A0 =A0 =A0 =A0/* Hap=
tic enable */
>> +
>> + =A0 =A0 =A0 int enable;
>> + =A0 =A0 =A0 int powered;
>> +
>> + =A0 =A0 =A0 int level;
>> + =A0 =A0 =A0 int level_max;
>> +
>> + =A0 =A0 =A0 int ldo_level;
>> +};
>> +
>> +
>> +static void isa1200_chip_power_on(struct isa1200_chip *haptic)
>> +{
>> + =A0 =A0 =A0 if (haptic->powered)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 =A0 haptic->powered =3D 1;
>> + =A0 =A0 =A0 /* Use smart mode enable control */
>
> You mean here that, enabling smart mode control by writing ISA1200
> register over I2C will be added later, right?
>
>> +
>> +static void isa1200_setup(struct i2c_client *client)
>> +{
>> + =A0 =A0 =A0 struct isa1200_chip *chip =3D i2c_get_clientdata(clien=
t);
>> + =A0 =A0 =A0 int value;
>> +
>> + =A0 =A0 =A0 gpio_set_value(chip->len, 1);
>> + =A0 =A0 =A0 udelay(250);
>> + =A0 =A0 =A0 gpio_set_value(chip->len, 1);
>> +
>
> Please clarify:
>
> In your hardware configuration, you are enabling internal LDO above?
> It may not be true for all the hardware configuration and it might be
> grounded. If true, please make this as platform data so that it can b=
e
> selected run time.
>
>> + =A0 =A0 =A0 value =3D isa1200_read_reg(client, ISA1200_SCTRL0);
>> + =A0 =A0 =A0 value &=3D ~ISA1200_LDOADJ_MASK;
>> + =A0 =A0 =A0 value |=3D chip->ldo_level;
>> + =A0 =A0 =A0 isa1200_write_reg(client, ISA1200_SCTRL0, value);
>> +
>> + =A0 =A0 =A0 value =3D ISA1200_HAPDREN | ISA1200_OVERHL | ISA1200_H=
APDIGMOD_PWM_IN |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ISA1200_PWMMOD_DIVIDER_128;
>> + =A0 =A0 =A0 isa1200_write_reg(client, ISA1200_HCTRL0, value);
>> +
>> + =A0 =A0 =A0 value =3D ISA1200_EXTCLKSEL | ISA1200_BIT6_ON | ISA120=
0_MOTTYP_LRA |
>
> Probably motor type could be different too. Please see what other
> parameters you could become as platform data for this chip and can be
> tuned by h/w designer for the product design.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ISA1200_SMARTEN | ISA1200_SMARTOFFT_64=
;
>
> Oh. You are enabling smart control here.
>
>> + =A0 =A0 =A0 isa1200_write_reg(client, ISA1200_HCTRL1, value);
>> +
>> + =A0 =A0 =A0 value =3D isa1200_read_reg(client, ISA1200_HCTRL2);
>> + =A0 =A0 =A0 value |=3D ISA1200_SEEN;
>> + =A0 =A0 =A0 isa1200_write_reg(client, ISA1200_HCTRL2, value);
>> + =A0 =A0 =A0 isa1200_chip_power_off(chip);
>> + =A0 =A0 =A0 isa1200_chip_power_on(chip);
>> +
>> + =A0 =A0 =A0 /* TODO */
>
> ?? some todo text?
>
>> +}
>> +
>> +static int __devinit isa1200_probe(struct i2c_client *client,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const struct i2c_devic=
e_id *id)
>> +{
>> + =A0 =A0 =A0 struct isa1200_chip *chip;
>> + =A0 =A0 =A0 struct haptic_platform_data *pdata;
>> + =A0 =A0 =A0 int ret;
>> +
>
> You need to add i2c_check_functionality call with smbus_byte_data.
>
>> + =A0 =A0 =A0 pdata =3D client->dev.platform_data;
>> + =A0 =A0 =A0 if (!pdata) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "%s: no platform=
 data\n", __func__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 chip =3D kzalloc(sizeof(struct isa1200_chip), GFP_KERN=
EL);
>> + =A0 =A0 =A0 if (!chip)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> +
>> + =A0 =A0 =A0 chip->client =3D client;
>> + =A0 =A0 =A0 chip->cdev.set =3D isa1200_chip_set;
>> + =A0 =A0 =A0 chip->cdev.get =3D isa1200_chip_get;
>> + =A0 =A0 =A0 chip->cdev.show_enable =3D isa1200_chip_show_enable;
>> + =A0 =A0 =A0 chip->cdev.store_enable =3D isa1200_chip_store_enable;
>> + =A0 =A0 =A0 chip->cdev.store_oneshot =3D isa1200_chip_store_onesho=
t;
>> + =A0 =A0 =A0 chip->cdev.show_level =3D isa1200_chip_show_level;
>> + =A0 =A0 =A0 chip->cdev.store_level =3D isa1200_chip_store_level;
>> + =A0 =A0 =A0 chip->cdev.show_level_max =3D isa1200_chip_show_level_=
max;
>> + =A0 =A0 =A0 chip->cdev.name =3D pdata->name;
>> + =A0 =A0 =A0 chip->enable =3D 0;
>> + =A0 =A0 =A0 chip->level =3D PWM_HAPTIC_DEFAULT_LEVEL;
>> + =A0 =A0 =A0 chip->level_max =3D PWM_HAPTIC_DEFAULT_LEVEL;
>> + =A0 =A0 =A0 chip->ldo_level =3D pdata->ldo_level;
>> +
>> + =A0 =A0 =A0 if (pdata->setup_pin)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->setup_pin();
>> + =A0 =A0 =A0 chip->len =3D pdata->gpio;
>> + =A0 =A0 =A0 chip->hen =3D pdata->gpio;
>> + =A0 =A0 =A0 chip->pwm =3D pwm_request(pdata->pwm_timer, "haptic");
>> + =A0 =A0 =A0 if (IS_ERR(chip->pwm)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "unable to reque=
st PWM for haptic.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(chip->pwm);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error_pwm;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 INIT_WORK(&chip->work, isa1200_chip_work);
>> +
>> + =A0 =A0 =A0 /* register our new haptic device */
>> + =A0 =A0 =A0 ret =3D haptic_classdev_register(&client->dev, &chip->=
cdev);
>> + =A0 =A0 =A0 if (ret < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "haptic_classdev=
_register failed\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error_classdev;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 ret =3D sysfs_create_group(&chip->cdev.dev->kobj, &hap=
tic_group);
>> + =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error_enable;
>
> Why the user of haptics class has to call this? I assume that once th=
e
> user of haptics class registers with it, the class itself should
> create the necessary sysfs files and user driver doesn't have to worr=
y
> about it except providing necessary hooks.
>
>> +
>> + =A0 =A0 =A0 init_timer(&chip->timer);
>> + =A0 =A0 =A0 chip->timer.data =3D (unsigned long)chip;
>> + =A0 =A0 =A0 chip->timer.function =3D &isa1200_chip_timer;
>
> like to use setup_timer?
>
>> +
>> + =A0 =A0 =A0 i2c_set_clientdata(client, chip);
>> +
>> + =A0 =A0 =A0 if (gpio_is_valid(pdata->gpio)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D gpio_request(pdata->gpio, "hap=
tic enable");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error_gpio;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_direction_output(pdata->gpio, 1);
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 isa1200_setup(client);
>> +
>> + =A0 =A0 =A0 printk(KERN_INFO "isa1200 %s registered\n", pdata->nam=
e);
>> + =A0 =A0 =A0 return 0;
>> +
>> +error_gpio:
>> + =A0 =A0 =A0 gpio_free(pdata->gpio);
>> +error_enable:
>> + =A0 =A0 =A0 sysfs_remove_group(&chip->cdev.dev->kobj, &haptic_grou=
p);
>> +error_classdev:
>> + =A0 =A0 =A0 haptic_classdev_unregister(&chip->cdev);
>> +error_pwm:
>> + =A0 =A0 =A0 pwm_free(chip->pwm);
>> + =A0 =A0 =A0 kfree(chip);
>> + =A0 =A0 =A0 return ret;
>> +}
>> +
>> +static int __devexit isa1200_remove(struct i2c_client *client)
>> +{
>> + =A0 =A0 =A0 struct isa1200_chip *chip =3D i2c_get_clientdata(clien=
t);
>> +
>> + =A0 =A0 =A0 if (gpio_is_valid(chip->len))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_free(chip->len);
>> +
>> + =A0 =A0 =A0 sysfs_remove_group(&chip->cdev.dev->kobj, &haptic_grou=
p);
>> + =A0 =A0 =A0 haptic_classdev_unregister(&chip->cdev);
>
> Where is del_timer_sync and cancel_work ?
>
>> + =A0 =A0 =A0 pwm_free(chip->pwm);
>> + =A0 =A0 =A0 kfree(chip);
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +#ifdef CONFIG_PM
>> +static int isa1200_suspend(struct i2c_client *client, pm_message_t =
mesg)
>> +{
>> + =A0 =A0 =A0 struct isa1200_chip *chip =3D i2c_get_clientdata(clien=
t);
>> + =A0 =A0 =A0 isa1200_chip_power_off(chip);
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +static int isa1200_resume(struct i2c_client *client)
>> +{
>> + =A0 =A0 =A0 isa1200_setup(client);
>> + =A0 =A0 =A0 return 0;
>> +}
>> +#else
>> +#define isa1200_suspend =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0NULL
>> +#define isa1200_resume =A0 =A0 =A0 =A0 NULL
>> +#endif
>> +
>> +static const struct i2c_device_id isa1200_id[] =3D {
>> + =A0 =A0 =A0 { "isa1200", 0 },

=46or haptics use-case it is very natural to have multiple instance of
these chips to driver different say top-bottom or right-and-left
mounted motors to create various patterns. I hope haptics class and
this isa1200 is safe for such usage including sysfs naming
conventions.


--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

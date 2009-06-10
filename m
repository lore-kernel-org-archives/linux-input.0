From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [PATCH] input: add support for generic GPIO-based matrix keypad
Date: Wed, 10 Jun 2009 09:40:31 +0530
Message-ID: <5d5443650906092110j1ed0914fn791039c4a4746bda@mail.gmail.com>
References: <f17812d70905070100u406614cag1ea1ea913577bbd8@mail.gmail.com>
	 <f17812d70905310712n4aa12acfm6c8d5c9cab4c3179@mail.gmail.com>
	 <200906021655.18476.u.luckas@road.de>
	 <200906021714.42186.u.luckas@road.de>
	 <f17812d70906022324x160dfcf2x5c89830341abff15@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f180.google.com ([209.85.221.180]:34681 "EHLO
	mail-qy0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941AbZFJEKa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Jun 2009 00:10:30 -0400
Received: by qyk10 with SMTP id 10so271144qyk.33
        for <linux-input@vger.kernel.org>; Tue, 09 Jun 2009 21:10:31 -0700 (PDT)
In-Reply-To: <f17812d70906022324x160dfcf2x5c89830341abff15@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Uli Luckas <u.luckas@road.de>, linux-arm-kernel@lists.arm.linux.org.uk, Marek Vasut <marek.vasut@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Dmitry,

>
> Sounds good, patch updated again, with attachment.
>
> >From 76776dfc468dc35f0d8394a2331e1a91f390e642 Mon Sep 17 00:00:00 20=
01
> From: Marek Vasut <marek.vasut@gmail.com>
> Date: Thu, 7 May 2009 15:49:32 +0800
> Subject: [PATCH] input: add support for generic GPIO-based matrix key=
pad
>

Could you please review this patch and see if it can be acked as merge
window will open in couple of days? Thanks.


> Original patch by Marek Vasut, modified by Eric in:
>
> 1. use delayed work to simplify the debouncing process
>
> 2. build keycode array for fast lookup
>
> 3. combine col_polarity/row_polarity into a single active_low
> =A0 field (are there some cases where the GPIOs are externally
> =A0 connected with an inverter and thus causing two different
> =A0 polarity requirement??)
>
> 4. use a generic bit array based XOR algorithm to detect key
> =A0 press/release, which should make the column assertion time
> =A0 shorter and code a bit cleaner
>
> 5. remove the ALT_FN handling, which is no way generic, ALT_FN
> =A0 key should be treated as no different from other keys, and
> =A0 translation can be done by commands like 'loadkeys'.
>
> 6. explicitly disable row IRQs and flush potential pending work,
> =A0 and schedule an immediate scan after resuming as suggested
> =A0 by Uli Luckas
>
> 7. incorporate review comments from many others
>
> Patch tested on Littleton/PXA310 (though PXA310 has a dedicate keypad
> controller, I have to configure those pins as generic GPIO to use thi=
s
> driver, works quite well, though ;-), and Sharp Zaurus model SL-C7x0
> and SL-C1000.
>
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> Reviewed-by: Trilok Soni <soni.trilok@gmail.com>
> Reviewed-by: Uli Luckas <u.luckas@road.de>
> Reviewed-by: Russell King <linux@arm.linux.org.uk>
> Reviewed-by: Robert Jarzmik <robert.jarzmik@free.fr>
> Signed-off-by: Eric Miao <eric.miao@marvell.com>
> ---
> =A0drivers/input/keyboard/Kconfig =A0 =A0 =A0 =A0 | =A0 10 +
> =A0drivers/input/keyboard/Makefile =A0 =A0 =A0 =A0| =A0 =A01 +
> =A0drivers/input/keyboard/matrix_keypad.c | =A0379 ++++++++++++++++++=
++++++++++++++
> =A0include/linux/input/matrix_keypad.h =A0 =A0| =A0 34 +++
> =A04 files changed, 424 insertions(+), 0 deletions(-)
> =A0create mode 100644 drivers/input/keyboard/matrix_keypad.c
> =A0create mode 100644 include/linux/input/matrix_keypad.h
>
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/=
Kconfig
> index ea2638b..6b9f89c 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -332,4 +332,14 @@ config KEYBOARD_SH_KEYSC
>
> =A0 =A0 =A0 =A0 =A0To compile this driver as a module, choose M here:=
 the
> =A0 =A0 =A0 =A0 =A0module will be called sh_keysc.
> +
> +config KEYBOARD_MATRIX
> + =A0 =A0 =A0 tristate "GPIO driven matrix keypad support"
> + =A0 =A0 =A0 depends on GENERIC_GPIO
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 Enable support for GPIO driven matrix keypad
> +
> + =A0 =A0 =A0 =A0 To compile this driver as a module, choose M here: =
the
> + =A0 =A0 =A0 =A0 module will be called matrix_keypad.
> +
> =A0endif
> diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard=
/Makefile
> index 36351e1..1349408 100644
> --- a/drivers/input/keyboard/Makefile
> +++ b/drivers/input/keyboard/Makefile
> @@ -28,3 +28,4 @@ obj-$(CONFIG_KEYBOARD_HP7XX) =A0 =A0 =A0 =A0 =A0+=3D=
 jornada720_kbd.o
> =A0obj-$(CONFIG_KEYBOARD_MAPLE) =A0 =A0 =A0 =A0 =A0 +=3D maple_keyb.o
> =A0obj-$(CONFIG_KEYBOARD_BFIN) =A0 =A0 =A0 =A0 =A0 =A0+=3D bf54x-keys=
=2Eo
> =A0obj-$(CONFIG_KEYBOARD_SH_KEYSC) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D=
 sh_keysc.o
> +obj-$(CONFIG_KEYBOARD_MATRIX) =A0 =A0 =A0 =A0 =A0+=3D matrix_keypad.=
o
> diff --git a/drivers/input/keyboard/matrix_keypad.c
> b/drivers/input/keyboard/matrix_keypad.c
> new file mode 100644
> index 0000000..2078d64
> --- /dev/null
> +++ b/drivers/input/keyboard/matrix_keypad.c
> @@ -0,0 +1,379 @@
> +/*
> + * drivers/input/keyboard/matrix_keypad.c
> + *
> + * =A0GPIO driven matrix keyboard driver
> + *
> + * =A0Copyright (c) 2008 Marek Vasut <marek.vasut@gmail.com>
> + *
> + * =A0Based on corgikbd.c
> + *
> + * =A0This program is free software; you can redistribute it and/or =
modify
> + * =A0it under the terms of the GNU General Public License version 2=
 as
> + * =A0published by the Free Software Foundation.
> + *
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/platform_device.h>
> +#include <linux/init.h>
> +#include <linux/input.h>
> +#include <linux/irq.h>
> +#include <linux/interrupt.h>
> +#include <linux/jiffies.h>
> +#include <linux/module.h>
> +#include <linux/gpio.h>
> +#include <linux/input/matrix_keypad.h>
> +
> +struct matrix_keypad {
> + =A0 =A0 =A0 struct matrix_keypad_platform_data *pdata;
> + =A0 =A0 =A0 struct input_dev *input_dev;
> +
> + =A0 =A0 =A0 uint32_t last_key_state[MATRIX_MAX_COLS];
> + =A0 =A0 =A0 uint32_t *keycodes;
> + =A0 =A0 =A0 struct delayed_work work;
> +};
> +
> +static int __devinit build_keycodes(struct matrix_keypad *keypad)
> +{
> + =A0 =A0 =A0 struct matrix_keypad_platform_data *pdata =3D keypad->p=
data;
> + =A0 =A0 =A0 struct input_dev *input_dev =3D keypad->input_dev;
> + =A0 =A0 =A0 uint32_t *key;
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 keypad->keycodes =3D kzalloc(MATRIX_MAX_KEYS * sizeof(i=
nt), GFP_KERNEL);
> + =A0 =A0 =A0 if (keypad->keycodes =3D=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> +
> + =A0 =A0 =A0 key =3D &pdata->key_map[0];
> + =A0 =A0 =A0 for (i =3D 0; i < pdata->key_map_size; i++, key++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad->keycodes[KEY_ROWCOL(*key)] =3D =
KEY_VAL(*key);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_bit(KEY_VAL(*key), input_dev->keybi=
t);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static unsigned int lookup_keycode(struct matrix_keypad *keypad,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
int row, int col)
> +{
> + =A0 =A0 =A0 return keypad->keycodes[(row << 4) + col];
> +}
> +
> +/* NOTE: normally the GPIO has to be put into HiZ when de-activated =
to cause
> + * minimum side effect when scanning other columns, here it is confi=
gured to
> + * be input, and it should work on most platforms.
> + */
> +static void __activate_col(struct matrix_keypad_platform_data *pdata=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int col, int on)
> +{
> + =A0 =A0 =A0 int level_on =3D !pdata->active_low;
> +
> + =A0 =A0 =A0 if (on)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_direction_output(pdata->col_gpios[=
col], level_on);
> + =A0 =A0 =A0 else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_value_cansleep(pdata->col_gpio=
s[col], !level_on);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_direction_input(pdata->col_gpios[c=
ol]);
> + =A0 =A0 =A0 }
> +}
> +
> +static void activate_all_cols(struct matrix_keypad_platform_data
> *pdata, int on)
> +{
> + =A0 =A0 =A0 int col;
> +
> + =A0 =A0 =A0 for (col =3D 0; col < pdata->num_col_gpios; col++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __activate_col(pdata, col, on);
> +}
> +
> +static void activate_col(struct matrix_keypad_platform_data *pdata,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int col, int on)
> +{
> + =A0 =A0 =A0 __activate_col(pdata, col, on);
> +
> + =A0 =A0 =A0 if (on && pdata->col_scan_delay_us)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(pdata->col_scan_delay_us);
> +}
> +
> +static int row_asserted(struct matrix_keypad_platform_data *pdata, i=
nt row)
> +{
> + =A0 =A0 =A0 return gpio_get_value_cansleep(pdata->row_gpios[row]) ?
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !pdata->active_low : pd=
ata->active_low;
> +}
> +
> +static void enable_row_irqs(struct matrix_keypad *keypad)
> +{
> + =A0 =A0 =A0 struct matrix_keypad_platform_data *pdata =3D keypad->p=
data;
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 for (i =3D 0; i < pdata->num_row_gpios; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 enable_irq(gpio_to_irq(pdata->row_gpios=
[i]));
> +}
> +
> +static void disable_row_irqs(struct matrix_keypad *keypad)
> +{
> + =A0 =A0 =A0 struct matrix_keypad_platform_data *pdata =3D keypad->p=
data;
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 for (i =3D 0; i < pdata->num_row_gpios; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 disable_irq_nosync(gpio_to_irq(pdata->r=
ow_gpios[i]));
> +}
> +
> +/*
> + * This gets the keys from keyboard and reports it to input subsyste=
m
> + */
> +static void matrix_keypad_scan(struct work_struct *work)
> +{
> + =A0 =A0 =A0 struct matrix_keypad *keypad =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 container_of(work, stru=
ct matrix_keypad, work.work);
> + =A0 =A0 =A0 struct matrix_keypad_platform_data *pdata =3D keypad->p=
data;
> + =A0 =A0 =A0 uint32_t new_state[MATRIX_MAX_COLS];
> + =A0 =A0 =A0 int row, col;
> +
> + =A0 =A0 =A0 /* de-activate all columns for scanning */
> + =A0 =A0 =A0 activate_all_cols(pdata, 0);
> +
> + =A0 =A0 =A0 memset(new_state, 0, sizeof(new_state));
> +
> + =A0 =A0 =A0 /* assert each column and read the row status out */
> + =A0 =A0 =A0 for (col =3D 0; col < pdata->num_col_gpios; col++) {
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 activate_col(pdata, col, 1);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (row =3D 0; row < pdata->num_row_gp=
ios; row++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 new_state[col] |=3D row=
_asserted(pdata, row) ?
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 (1 << row) : 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 activate_col(pdata, col, 0);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 for (col =3D 0; col < pdata->num_col_gpios; col++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uint32_t bits_changed;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bits_changed =3D keypad->last_key_state=
[col] ^ new_state[col];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (bits_changed =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (row =3D 0; row < pdata->num_row_gp=
ios; row++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((bits_changed & (1 =
<< row)) =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continu=
e;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(keypad=
->input_dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 lookup_keycode(keypad, row, col),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 new_state[col] & (1 << row));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 input_sync(keypad->input_dev);
> + =A0 =A0 =A0 memcpy(keypad->last_key_state, new_state, sizeof(new_st=
ate));
> +
> + =A0 =A0 =A0 activate_all_cols(pdata, 1);
> + =A0 =A0 =A0 enable_row_irqs(keypad);
> +}
> +
> +static irqreturn_t matrix_keypad_interrupt(int irq, void *id)
> +{
> + =A0 =A0 =A0 struct matrix_keypad *keypad =3D id;
> +
> + =A0 =A0 =A0 disable_row_irqs(keypad);
> + =A0 =A0 =A0 schedule_delayed_work(&keypad->work,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msecs_to_jiffies(keypad=
->pdata->debounce_ms));
> + =A0 =A0 =A0 return IRQ_HANDLED;
> +}
> +
> +#ifdef CONFIG_PM
> +static int matrix_keypad_suspend(struct platform_device *pdev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pm_m=
essage_t state)
> +{
> + =A0 =A0 =A0 struct matrix_keypad *keypad =3D platform_get_drvdata(p=
dev);
> + =A0 =A0 =A0 struct matrix_keypad_platform_data *pdata =3D keypad->p=
data;
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 disable_row_irqs(keypad);
> + =A0 =A0 =A0 flush_work(&keypad->work.work);
> +
> + =A0 =A0 =A0 if (device_may_wakeup(&pdev->dev))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < pdata->num_row_gpios;=
 i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 enable_irq_wake(gpio_to=
_irq(pdata->row_gpios[i]));
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int matrix_keypad_resume(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct matrix_keypad *keypad =3D platform_get_drvdata(p=
dev);
> + =A0 =A0 =A0 struct matrix_keypad_platform_data *pdata =3D keypad->p=
data;
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 if (device_may_wakeup(&pdev->dev))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < pdata->num_row_gpios;=
 i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 disable_irq_wake(gpio_t=
o_irq(pdata->row_gpios[i]));
> +
> + =A0 =A0 =A0 /* Uli Luckas: schedule an immediate key scan as all ke=
y state changes
> + =A0 =A0 =A0 =A0* were lost while the device was suspended, columns =
will be activated
> + =A0 =A0 =A0 =A0* and IRQs be enabled after the scan.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 schedule_delayed_work(&keypad->work, 0);
> + =A0 =A0 =A0 return 0;
> +}
> +#else
> +#define matrix_keypad_suspend =A0NULL
> +#define matrix_keypad_resume =A0 NULL
> +#endif
> +
> +static int __devinit init_matrix_gpio(struct matrix_keypad *keypad)
> +{
> + =A0 =A0 =A0 struct matrix_keypad_platform_data *pdata =3D keypad->p=
data;
> + =A0 =A0 =A0 int i, err =3D -EINVAL;
> +
> + =A0 =A0 =A0 /* initialized strobe lines as outputs, activated */
> + =A0 =A0 =A0 for (i =3D 0; i < pdata->num_col_gpios; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D gpio_request(pdata->col_gpios[i=
], "matrix_kbd_col");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("failed to reque=
st GPIO%d for COL%d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 pdata->col_gpios[i], i);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_cols;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_direction_output(pdata->col_gpios[=
i], !pdata->active_low);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 for (i =3D 0; i < pdata->num_row_gpios; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D gpio_request(pdata->row_gpios[i=
], "matrix_kbd_row");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("failed to reque=
st GPIO%d for ROW%d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 pdata->row_gpios[i], i);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_rows;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_direction_input(pdata->row_gpios[i=
]);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 for (i =3D 0; i < pdata->num_row_gpios; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D request_irq(gpio_to_irq(pdata->=
row_gpios[i]),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 matrix_=
keypad_interrupt, IRQF_DISABLED |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IRQF_TR=
IGGER_RISING | IRQF_TRIGGER_FALLING,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "matrix=
-keypad", keypad);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Unable to acqui=
re interrupt for GPIO line %i\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->=
row_gpios[i]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_irqs;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return 0;
> +
> +err_free_irqs:
> + =A0 =A0 =A0 for (i =3D i - 1; i >=3D 0; i--)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(gpio_to_irq(pdata->row_gpios[i=
]), keypad);
> +
> +err_free_rows:
> + =A0 =A0 =A0 for (i =3D i - 1; i >=3D 0; i--)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_free(pdata->row_gpios[i]);
> +
> +err_free_cols:
> + =A0 =A0 =A0 for (i =3D i - 1; i >=3D 0; i--)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_free(pdata->col_gpios[i]);
> +
> + =A0 =A0 =A0 return err;
> +}
> +
> +static int __devinit matrix_keypad_probe(struct platform_device *pde=
v)
> +{
> + =A0 =A0 =A0 struct matrix_keypad_platform_data *pdata;
> + =A0 =A0 =A0 struct matrix_keypad *keypad;
> + =A0 =A0 =A0 struct input_dev *input_dev;
> + =A0 =A0 =A0 int err =3D -ENOMEM;
> +
> + =A0 =A0 =A0 pdata =3D pdev->dev.platform_data;
> + =A0 =A0 =A0 if (pdata =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "no platform data d=
efined\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 keypad =3D kzalloc(sizeof(struct matrix_keypad), GFP_KE=
RNEL);
> + =A0 =A0 =A0 if (keypad =3D=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> +
> + =A0 =A0 =A0 input_dev =3D input_allocate_device();
> + =A0 =A0 =A0 if (!input_dev)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_keypad;
> +
> + =A0 =A0 =A0 platform_set_drvdata(pdev, keypad);
> +
> + =A0 =A0 =A0 keypad->input_dev =3D input_dev;
> + =A0 =A0 =A0 keypad->pdata =3D pdata;
> + =A0 =A0 =A0 INIT_DELAYED_WORK(&keypad->work, matrix_keypad_scan);
> +
> + =A0 =A0 =A0 input_dev->name =A0 =A0 =A0 =A0 =3D pdev->name;
> + =A0 =A0 =A0 input_dev->id.bustype =A0 =3D BUS_HOST;
> + =A0 =A0 =A0 input_dev->dev.parent =A0 =3D &pdev->dev;
> + =A0 =A0 =A0 input_dev->evbit[0] =A0 =A0 =3D BIT_MASK(EV_KEY) | BIT_=
MASK(EV_REP);
> +
> + =A0 =A0 =A0 err =3D build_keycodes(keypad);
> + =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_input;
> +
> + =A0 =A0 =A0 err =3D input_register_device(keypad->input_dev);
> + =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_keycodes;
> +
> + =A0 =A0 =A0 err =3D init_matrix_gpio(keypad);
> + =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_unregister;
> +
> + =A0 =A0 =A0 device_init_wakeup(&pdev->dev, 1);
> + =A0 =A0 =A0 return 0;
> +
> +err_unregister:
> + =A0 =A0 =A0 input_unregister_device(input_dev);
> +err_free_keycodes:
> + =A0 =A0 =A0 kfree(keypad->keycodes);
> +err_free_input:
> + =A0 =A0 =A0 input_free_device(input_dev);
> +err_free_keypad:
> + =A0 =A0 =A0 kfree(keypad);
> + =A0 =A0 =A0 return err;
> +}
> +
> +static int __devexit matrix_keypad_remove(struct platform_device *pd=
ev)
> +{
> + =A0 =A0 =A0 struct matrix_keypad *keypad =3D platform_get_drvdata(p=
dev);
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 for (i =3D 0; i < keypad->pdata->num_row_gpios; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(gpio_to_irq(keypad->pdata->row=
_gpios[i]), keypad);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_free(keypad->pdata->row_gpios[i]);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 for (i =3D 0; i < keypad->pdata->num_col_gpios; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_free(keypad->pdata->col_gpios[i]);
> +
> + =A0 =A0 =A0 input_unregister_device(keypad->input_dev);
> + =A0 =A0 =A0 kfree(keypad->keycodes);
> + =A0 =A0 =A0 kfree(keypad);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static struct platform_driver matrix_keypad_driver =3D {
> + =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D matrix_keypad_probe,
> + =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __devexit_p(matrix_keypad_r=
emove),
> + =A0 =A0 =A0 .suspend =A0 =A0 =A0 =A0=3D matrix_keypad_suspend,
> + =A0 =A0 =A0 .resume =A0 =A0 =A0 =A0 =3D matrix_keypad_resume,
> + =A0 =A0 =A0 .driver =A0 =A0 =A0 =A0 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "matrix-keypad",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
> + =A0 =A0 =A0 },
> +};
> +
> +static int __init matrix_keypad_init(void)
> +{
> + =A0 =A0 =A0 return platform_driver_register(&matrix_keypad_driver);
> +}
> +
> +static void __exit matrix_keypad_exit(void)
> +{
> + =A0 =A0 =A0 platform_driver_unregister(&matrix_keypad_driver);
> +}
> +
> +module_init(matrix_keypad_init);
> +module_exit(matrix_keypad_exit);
> +
> +MODULE_AUTHOR("Marek Vasut <marek.vasut@gmail.com>");
> +MODULE_DESCRIPTION("GPIO Driven Matrix Keypad Driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:matrix-keypad");
> diff --git a/include/linux/input/matrix_keypad.h
> b/include/linux/input/matrix_keypad.h
> new file mode 100644
> index 0000000..8b661cb
> --- /dev/null
> +++ b/include/linux/input/matrix_keypad.h
> @@ -0,0 +1,34 @@
> +#ifndef _MATRIX_KEYPAD_H
> +#define _MATRIX_KEYPAD_H
> +
> +#include <linux/input.h>
> +
> +#define MATRIX_MAX_ROWS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A016
> +#define MATRIX_MAX_COLS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A016
> +#define MATRIX_MAX_KEYS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(MATRIX_MAX_R=
OWS * MATRIX_MAX_COLS)
> +
> +struct matrix_keypad_platform_data {
> + =A0 =A0 =A0 /* scancode map for the matrix keys */
> + =A0 =A0 =A0 uint32_t =A0 =A0 =A0 =A0*key_map;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 key_map_size;
> +
> + =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0row_gpios[MATRIX_MAX_ROWS];
> + =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0col_gpios[MATRIX_MAX_COLS];
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 num_row_gpios;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 num_col_gpios;
> +
> + =A0 =A0 =A0 unsigned int =A0 =A0active_low;
> + =A0 =A0 =A0 unsigned int =A0 =A0col_scan_delay_us;
> +
> + =A0 =A0 =A0 /* key debounce interval in milli-second */
> + =A0 =A0 =A0 unsigned int =A0 =A0debounce_ms;
> +};
> +
> +#define KEY(row, col, val) =A0 =A0 ((((row) & (MATRIX_MAX_ROWS - 1))=
 << 28) |\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(((c=
ol) & (MATRIX_MAX_COLS - 1)) << 24) |\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(val=
 & 0xffffff))
> +
> +#define KEY_ROWCOL(k) =A0 =A0 =A0 =A0 =A0(((k) >> 24) & 0xff)
> +#define KEY_VAL(k) =A0 =A0 =A0 =A0 =A0 =A0 ((k) & 0xffffff)
> +
> +#endif /* _MATRIX_KEYPAD_H */
> --
> 1.6.0.4
>




--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

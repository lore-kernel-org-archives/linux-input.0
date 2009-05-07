From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [PATCH] input: add support for generic GPIO-based matrix keypad
Date: Thu, 7 May 2009 14:11:24 +0530
Message-ID: <5d5443650905070141k2d6e3cb8r9e923c71c5474e43@mail.gmail.com>
References: <f17812d70905070100u406614cag1ea1ea913577bbd8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f125.google.com ([209.85.221.125]:61079 "EHLO
	mail-qy0-f125.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753887AbZEGIlY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 May 2009 04:41:24 -0400
Received: by qyk31 with SMTP id 31so1122666qyk.33
        for <linux-input@vger.kernel.org>; Thu, 07 May 2009 01:41:24 -0700 (PDT)
In-Reply-To: <f17812d70905070100u406614cag1ea1ea913577bbd8@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: Marek Vasut <marek.vasut@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>

Hi Eric,

On Thu, May 7, 2009 at 1:30 PM, Eric Miao <eric.y.miao@gmail.com> wrote=
:
> Original patch by Marek Vasut, modified by Eric in:
>
> 1. use delayed work to simplify the debouncing
> 2. build keycode array for fast lookup
> 3. combine col_polarity/row_polarity into a single active_low field
> (are there some cases where the GPIOs are externally connected
> with an inverter and thus causing two different polarity requirement?=
?)
> 4. use a generic bit array based XOR algorithm to detect key press/re=
lease,
> which should make the column assertion time shorter and code a bit
> cleaner
> 5. remove the ALT_FN handling, which is no way generic, the ALT_FN
> key should be treated as no different from other keys, and translatio=
n
> will be done by user space by commands like 'loadkeys'.
>
> Patch tested on Littleton/PXA310 (though PXA310 has a dedicate keypad
> controller, I have to configure those pins as generic GPIO to use thi=
s
> driver, works quite well, though ;-)

Any support about removing/clearing ghost/phantom keys? Also we assume
that all gpios in the matrix should be able to generate interrupts so
no polldev support required.


> diff --git a/drivers/input/keyboard/matrix_keypad.c
> b/drivers/input/keyboard/matrix_keypad.c
> new file mode 100644
> index 0000000..da9a3fc
> --- /dev/null
> +++ b/drivers/input/keyboard/matrix_keypad.c
> @@ -0,0 +1,345 @@
> +/*
> + * drivers/input/keyboard/matrix_keypad.c
> + *

Better to remove full path and just write matrix_keypad.c

> + * =A0GPIO driven matrix keyboard driver
> + *
> + * =A0Copyright (c) 2008 Marek Vasut <marek.vasut@gmail.com>

You may want to add your Copyright here.

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


> +
> +static void build_keycodes(struct matrix_keypad *keypad)
> +{
> + =A0 =A0 =A0 struct matrix_keypad_platform_data *pdata =3D keypad->p=
data;
> + =A0 =A0 =A0 struct input_dev *input_dev =3D keypad->input_dev;
> + =A0 =A0 =A0 uint32_t *key;
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 keypad->keycodes =3D kzalloc(MATRIX_MAX_KEYS * sizeof(i=
nt), GFP_KERNEL);
> +
> + =A0 =A0 =A0 key =3D &pdata->key_map[0];
> + =A0 =A0 =A0 for (i =3D 0; i < pdata->key_map_size; i++, key++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 keypad->keycodes[KEY_ROWCOL(*key)] =3D =
KEY_VAL(*key);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_bit(KEY_VAL(*key), input_dev->keybi=
t);

__set_bit


> +
> +
> +#ifdef CONFIG_PM
> +static int matrix_keypad_suspend(struct platform_device *pdev,
> pm_message_t state)
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

I think I have not seen device_init_wakeup anywhere in this code.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < pdata->num_row_gpios;=
 i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 disable_irq_wake(gpio_t=
o_irq(pdata->row_gpios[i]));
> +
> + =A0 =A0 =A0 return 0;
> +}
> +#else
> +#define matrix_keypad_suspend =A0NULL
> +#define matrix_keypad_resume =A0 NULL
> +#endif
> +
> +
> +static int __devinit matrix_keypad_probe(struct platform_device *pde=
v)
> +{


> +
> +err_unregister:
> + =A0 =A0 =A0 input_unregister_device(input_dev);
> +err_free_input:
> + =A0 =A0 =A0 input_free_device(input_dev);

No need of input_free_device after input_unregister_device(..). You
can just do input_dev =3D NULL after input_unregister_device instead?


> +
> +static struct platform_driver matrix_keypad_driver =3D {
> + =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D matrix_keypad_probe,
> + =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D matrix_keypad_remove,

__exit_p ?




--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

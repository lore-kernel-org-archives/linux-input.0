From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: Re: [PATCH 09/18] input: add input driver for polled GPIO buttons
Date: Wed, 24 Nov 2010 12:24:15 -0500
Message-ID: <AANLkTikQ=oen3jmz=BfY7y=s6Qo7R8DQ1-79puby-Snt@mail.gmail.com>
References: <1290524800-21419-1-git-send-email-juhosg@openwrt.org>
	<1290524800-21419-10-git-send-email-juhosg@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:41625 "HELO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756121Ab0KXRYR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Nov 2010 12:24:17 -0500
Received: by mail-qw0-f53.google.com with SMTP id 4so300548qwi.12
        for <linux-input@vger.kernel.org>; Wed, 24 Nov 2010 09:24:16 -0800 (PST)
In-Reply-To: <1290524800-21419-10-git-send-email-juhosg@openwrt.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gabor Juhos <juhosg@openwrt.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, kaloz@openwrt.org, "Luis R. Rodriguez" <lrodriguez@atheros.com>, Cliff Holden <Cliff.Holden@atheros.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mike Frysinger <vapier@gentoo.org>, linux-input@vger.kernel.org

Hello Gabor,

On Tue, Nov 23, 2010 at 10:06 AM, Gabor Juhos <juhosg@openwrt.org> wrot=
e:
> The existing gpio-keys driver can be usable only for GPIO lines with
> interrupt support. Several devices have buttons connected to a GPIO
> line which is not capable to generate interrupts. This patch adds a
> new input driver using the generic GPIO layer and the input-polldev
> to support such buttons.
>
> Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Mike Frysinger <vapier@gentoo.org>
> Cc: linux-input@vger.kernel.org
> ---

I've tested this driver with the da850-evm pushbuttons and switches
connected to i2c gpio expanders. It works well. The changes to the
patch series were straightforward: .config, "gpio-keys" ->
"gpio-buttons", struct gpio_key -> struct gpio_button etc.

I do have some comments about this patch. But the new driver is
functional as-is.

Tested-by: Ben Gardiner <bengardiner@nanometrics.ca>

> =A0drivers/input/misc/Kconfig =A0 =A0 =A0 =A0| =A0 16 +++
> =A0drivers/input/misc/Makefile =A0 =A0 =A0 | =A0 =A01 +
> =A0drivers/input/misc/gpio_buttons.c | =A0232 +++++++++++++++++++++++=
++++++++++++++

Since the new gpio_buttons.c driver presents the same input event
device as the gpio_keys.c driver, I think it should also be a
drivers/input/keys device.

> =A0[...]
> diff --git a/drivers/input/misc/gpio_buttons.c b/drivers/input/misc/g=
pio_buttons.c

When I was converting the da850-evm platform code to use the new
driver I felt that the changes did not indicate a switch to a polled
driver as seems to be the intent with the introduction of a separate
driver. All that was different in the platform code was 'button' where
there use to be 'key' and button does not itself convey the knowledge
that it is a polled input device.

I know names of drivers can be contentions but I will propose
regardless that this driver be called gpio-polled-keys /
gpio_polled_keys.c

> new file mode 100644
> index 0000000..51288a3
> --- /dev/null
> +++ b/drivers/input/misc/gpio_buttons.c
> [...]
> +static void gpio_buttons_poll(struct input_polled_dev *dev)
> +{
> + =A0 =A0 =A0 struct gpio_buttons_dev *bdev =3D dev->private;
> + =A0 =A0 =A0 struct gpio_buttons_platform_data *pdata =3D bdev->pdat=
a;
> + =A0 =A0 =A0 struct input_dev *input =3D dev->input;
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 for (i =3D 0; i < bdev->pdata->nbuttons; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct gpio_button *button =3D &pdata->=
buttons[i];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct gpio_button_data *bdata =3D &bde=
v->data[i];
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (bdata->count < button->threshold)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bdata->count++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_buttons_check_stat=
e(input, button, bdata);

I think that a count-theshold can still be performed here, but using
the debounce_interval and polling_interval field specified in the
gpio_button and gpio_buttons_platform_data structures, respectively,
to calculate a threshold value.

In this way the gpio_button and gpio_keys_button structs are made more
similar -- differing only in the presence of .wakeup in
gpio_keys_button but not in gpio_button. Which may make it possible to
re-use the gpio_keys_button structure.

> [...]
> diff --git a/include/linux/gpio_buttons.h b/include/linux/gpio_button=
s.h
> new file mode 100644
> index 0000000..f85b993
> --- /dev/null
> +++ b/include/linux/gpio_buttons.h
> @@ -0,0 +1,33 @@
> +/*
> + * =A0Definitions for the GPIO buttons interface driver
> + *
> + * =A0Copyright (C) 2007-2010 Gabor Juhos <juhosg@openwrt.org>
> + *
> + * =A0This file was based on: /include/linux/gpio_keys.h
> + * =A0 =A0 The original gpio_keys.h seems not to have a license.
> + *
> + * =A0This program is free software; you can redistribute it and/or =
modify
> + * =A0it under the terms of the GNU General Public License version 2=
 as
> + * =A0published by the Free Software Foundation.
> + *
> + */
> +
> +#ifndef _GPIO_BUTTONS_H_
> +#define _GPIO_BUTTONS_H_
> +
> +struct gpio_button {
> + =A0 =A0 =A0 int =A0 =A0 gpio; =A0 =A0 =A0 =A0 =A0 /* GPIO line numb=
er */
> + =A0 =A0 =A0 int =A0 =A0 active_low;
> + =A0 =A0 =A0 char =A0 =A0*desc; =A0 =A0 =A0 =A0 =A0/* button descrip=
tion */
> + =A0 =A0 =A0 int =A0 =A0 type; =A0 =A0 =A0 =A0 =A0 /* input event ty=
pe (EV_KEY, EV_SW) */
> + =A0 =A0 =A0 int =A0 =A0 code; =A0 =A0 =A0 =A0 =A0 /* input event co=
de (KEY_*, SW_*) */
> + =A0 =A0 =A0 int =A0 =A0 threshold; =A0 =A0 =A0/* count threshold */

Could we instead use the existing struct gpio_keys_button; we could
transform debounce_interval into a threshold as described above and
add an error when a gpio_button_probe() sees a gpio_key with .wakeup
=3D=3D TRUE? It seems that this structure duplicates alot of the
gpio_keys_button structure.

> [...]
> +struct gpio_buttons_platform_data {
> + =A0 =A0 =A0 struct gpio_button *buttons;
> + =A0 =A0 =A0 int =A0 =A0 nbuttons; =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* nu=
mber of buttons */
> + =A0 =A0 =A0 int =A0 =A0 poll_interval; =A0 =A0 =A0 =A0 =A0/* pollin=
g interval */
> +};

I think the units of poll_interval should be included in the comment.
i.e. /* polling interval in msecs */

Best Regards,
Ben Gardiner

---
Nanometrics Inc.
http://www.nanometrics.ca
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

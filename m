From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: HTC Dream for staging: add support for input on GPIO pins
Date: Sat, 8 Aug 2009 22:12:46 +0530
Message-ID: <5d5443650908080942l50d91d31qb23c494affdf6850@mail.gmail.com>
References: <20090808130315.GA12930@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.25]:11240 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752437AbZHHQmr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 8 Aug 2009 12:42:47 -0400
In-Reply-To: <20090808130315.GA12930@elf.ucw.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Greg KH <greg@kroah.com>, kernel list <linux-kernel@vger.kernel.org>, swetland@google.com, linux-input@vger.kernel.org

Hi Pavel,

On Sat, Aug 8, 2009 at 6:33 PM, Pavel Machek<pavel@ucw.cz> wrote:
> From: Arve Hj?nnev?g <arve@android.com>
>
> Support for input devices connected to GPIO pins. This adds support
> for HTC Dream's keyboard and its trackball. Generic support already
> exists for keyboard on GPIO, but this one is more advanced because it
> can detect shadow key presses (and actually works with Dream :-).
>
> (It also contains Kconfig/Makefile changes, including some that were
> missing from previous commit. Sorry.)

I don't see any importance of gpio_matrix.c when we already have
generic gpio matrix driver mainlined. I would suggest to remove those
bits from this patch. I have added linux-input ML.

>
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
>
> diff --git a/drivers/staging/dream/Kconfig b/drivers/staging/dream/Kc=
onfig
> new file mode 100644
> index 0000000..52bd187
> --- /dev/null
> +++ b/drivers/staging/dream/Kconfig
> @@ -0,0 +1,12 @@
> +source "drivers/staging/dream/smd/Kconfig"
> +
> +source "drivers/staging/dream/camera/Kconfig"
> +
> +
> +config INPUT_GPIO
> + =A0 =A0 =A0 tristate "GPIO driver support"
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 Say Y here if you want to support gpio based keys, =
wheels etc...
> +
> +
> +
> diff --git a/drivers/staging/dream/Makefile b/drivers/staging/dream/M=
akefile
> new file mode 100644
> index 0000000..083bb67
> --- /dev/null
> +++ b/drivers/staging/dream/Makefile
> @@ -0,0 +1,4 @@
> +obj-$(CONFIG_MSM_ADSP) =A0 =A0 =A0 =A0 +=3D qdsp5/ smd/
> +obj-$(CONFIG_MSM_CAMERA) =A0 =A0 =A0 +=3D camera/
> +obj-$(CONFIG_INPUT_GPIO) =A0 =A0 =A0 +=3D gpio_axis.o gpio_event.o g=
pio_input.o gpio_matrix.o gpio_output.o
> +
> \ No newline at end of file
> diff --git a/drivers/staging/dream/gpio_axis.c b/drivers/staging/drea=
m/gpio_axis.c
> new file mode 100644
> index 0000000..c801172
> --- /dev/null
> +++ b/drivers/staging/dream/gpio_axis.c
> @@ -0,0 +1,180 @@
> +/* drivers/input/misc/gpio_axis.c
> + *
> + * Copyright (C) 2007 Google, Inc.
> + *
> + * This software is licensed under the terms of the GNU General Publ=
ic
> + * License version 2, as published by the Free Software Foundation, =
and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/gpio.h>
> +#include <linux/gpio_event.h>
> +#include <linux/interrupt.h>
> +
> +struct gpio_axis_state {
> + =A0 =A0 =A0 struct input_dev *input_dev;
> + =A0 =A0 =A0 struct gpio_event_axis_info *info;
> + =A0 =A0 =A0 uint32_t pos;
> +};
> +
> +uint16_t gpio_axis_4bit_gray_map_table[] =3D {
> + =A0 =A0 =A0 [0x0] =3D 0x0, [0x1] =3D 0x1, /* 0000 0001 */
> + =A0 =A0 =A0 [0x3] =3D 0x2, [0x2] =3D 0x3, /* 0011 0010 */
> + =A0 =A0 =A0 [0x6] =3D 0x4, [0x7] =3D 0x5, /* 0110 0111 */
> + =A0 =A0 =A0 [0x5] =3D 0x6, [0x4] =3D 0x7, /* 0101 0100 */
> + =A0 =A0 =A0 [0xc] =3D 0x8, [0xd] =3D 0x9, /* 1100 1101 */
> + =A0 =A0 =A0 [0xf] =3D 0xa, [0xe] =3D 0xb, /* 1111 1110 */
> + =A0 =A0 =A0 [0xa] =3D 0xc, [0xb] =3D 0xd, /* 1010 1011 */
> + =A0 =A0 =A0 [0x9] =3D 0xe, [0x8] =3D 0xf, /* 1001 1000 */
> +};
> +uint16_t gpio_axis_4bit_gray_map(struct gpio_event_axis_info *info, =
uint16_t in)
> +{
> + =A0 =A0 =A0 return gpio_axis_4bit_gray_map_table[in];
> +}
> +
> +uint16_t gpio_axis_5bit_singletrack_map_table[] =3D {
> + =A0 =A0 =A0 [0x10] =3D 0x00, [0x14] =3D 0x01, [0x1c] =3D 0x02, /* =A0=
 =A0 10000 10100 11100 */
> + =A0 =A0 =A0 [0x1e] =3D 0x03, [0x1a] =3D 0x04, [0x18] =3D 0x05, /* =A0=
 =A0 11110 11010 11000 */
> + =A0 =A0 =A0 [0x08] =3D 0x06, [0x0a] =3D 0x07, [0x0e] =3D 0x08, /* =A0=
 =A001000 01010 01110 =A0*/
> + =A0 =A0 =A0 [0x0f] =3D 0x09, [0x0d] =3D 0x0a, [0x0c] =3D 0x0b, /* =A0=
 =A001111 01101 01100 =A0*/
> + =A0 =A0 =A0 [0x04] =3D 0x0c, [0x05] =3D 0x0d, [0x07] =3D 0x0e, /* =A0=
 00100 00101 00111 =A0 */
> + =A0 =A0 =A0 [0x17] =3D 0x0f, [0x16] =3D 0x10, [0x06] =3D 0x11, /* =A0=
 10111 10110 00110 =A0 */
> + =A0 =A0 =A0 [0x02] =3D 0x12, [0x12] =3D 0x13, [0x13] =3D 0x14, /* =A0=
00010 10010 10011 =A0 =A0*/
> + =A0 =A0 =A0 [0x1b] =3D 0x15, [0x0b] =3D 0x16, [0x03] =3D 0x17, /* =A0=
11011 01011 00011 =A0 =A0*/
> + =A0 =A0 =A0 [0x01] =3D 0x18, [0x09] =3D 0x19, [0x19] =3D 0x1a, /* 0=
0001 01001 11001 =A0 =A0 */
> + =A0 =A0 =A0 [0x1d] =3D 0x1b, [0x15] =3D 0x1c, [0x11] =3D 0x1d, /* 1=
1101 10101 10001 =A0 =A0 */
> +};
> +uint16_t gpio_axis_5bit_singletrack_map(
> + =A0 =A0 =A0 struct gpio_event_axis_info *info, uint16_t in)
> +{
> + =A0 =A0 =A0 return gpio_axis_5bit_singletrack_map_table[in];
> +}
> +
> +static void gpio_event_update_axis(struct gpio_axis_state *as, int r=
eport)
> +{
> + =A0 =A0 =A0 struct gpio_event_axis_info *ai =3D as->info;
> + =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 int change;
> + =A0 =A0 =A0 uint16_t state =3D 0;
> + =A0 =A0 =A0 uint16_t pos;
> + =A0 =A0 =A0 uint16_t old_pos =3D as->pos;
> + =A0 =A0 =A0 for (i =3D ai->count - 1; i >=3D 0; i--)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 state =3D (state << 1) | gpio_get_value=
(ai->gpio[i]);
> + =A0 =A0 =A0 pos =3D ai->map(ai, state);
> + =A0 =A0 =A0 if (ai->flags & GPIOEAF_PRINT_RAW)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info("axis %d-%d raw %x, pos %d -> %=
d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ai->type, ai->code, sta=
te, old_pos, pos);
> + =A0 =A0 =A0 if (report && pos !=3D old_pos) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ai->type =3D=3D EV_REL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 change =3D (ai->decoded=
_size + pos - old_pos) %
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ai-=
>decoded_size;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (change > ai->decode=
d_size / 2)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 change =
-=3D ai->decoded_size;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (change =3D=3D ai->d=
ecoded_size / 2) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ai-=
>flags & GPIOEAF_PRINT_EVENT)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 pr_info("axis %d-%d unknown direction, "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 "pos %d -> %d\n", ai->type,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 ai->code, old_pos, pos);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 change =
=3D 0; /* no closest direction */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ai->flags & GPIOEAF=
_PRINT_EVENT)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info=
("axis %d-%d change %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 ai->type, ai->code, change);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_rel(as->in=
put_dev, ai->code, change);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ai->flags & GPIOEAF=
_PRINT_EVENT)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info=
("axis %d-%d now %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 ai->type, ai->code, pos);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_event(as->input_d=
ev, ai->type, ai->code, pos);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_sync(as->input_dev);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 as->pos =3D pos;
> +}
> +
> +static irqreturn_t gpio_axis_irq_handler(int irq, void *dev_id)
> +{
> + =A0 =A0 =A0 struct gpio_axis_state *as =3D dev_id;
> + =A0 =A0 =A0 gpio_event_update_axis(as, 1);
> + =A0 =A0 =A0 return IRQ_HANDLED;
> +}
> +
> +int gpio_event_axis_func(struct input_dev *input_dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct gpio_event_in=
fo *info, void **data, int func)
> +{
> + =A0 =A0 =A0 int ret;
> + =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 int irq;
> + =A0 =A0 =A0 struct gpio_event_axis_info *ai;
> + =A0 =A0 =A0 struct gpio_axis_state *as;
> +
> + =A0 =A0 =A0 ai =3D container_of(info, struct gpio_event_axis_info, =
info);
> + =A0 =A0 =A0 if (func =3D=3D GPIO_EVENT_FUNC_SUSPEND) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < ai->count; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 disable_irq(gpio_to_irq=
(ai->gpio[i]));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (func =3D=3D GPIO_EVENT_FUNC_RESUME) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < ai->count; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 enable_irq(gpio_to_irq(=
ai->gpio[i]));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (func =3D=3D GPIO_EVENT_FUNC_INIT) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *data =3D as =3D kmalloc(sizeof(*as), G=
=46P_KERNEL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (as =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_alloc_axis_sta=
te_failed;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 as->input_dev =3D input_dev;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 as->info =3D ai;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_capability(input_dev, ai->typ=
e, ai->code);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ai->type =3D=3D EV_ABS) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(in=
put_dev, ai->code, 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0ai->decoded_size - 1, 0, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < ai->count; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D gpio_request(ai=
->gpio[i], "gpio_event_axis");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto er=
r_request_gpio_failed;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D gpio_direction_=
input(ai->gpio[i]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto er=
r_gpio_direction_input_failed;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D irq =3D gpio_to=
_irq(ai->gpio[i]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto er=
r_get_irq_num_failed;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D request_irq(irq=
, gpio_axis_irq_handler,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 IRQF_TRIGGER_RISING |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 IRQF_TRIGGER_FALLING,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 "gpio_event_axis", as);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto er=
r_request_irq_failed;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_event_update_axis(as, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ret =3D 0;
> + =A0 =A0 =A0 as =3D *data;
> + =A0 =A0 =A0 for (i =3D ai->count - 1; i >=3D 0; i--) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(gpio_to_irq(ai->gpio[i]), as);
> +err_request_irq_failed:
> +err_get_irq_num_failed:
> +err_gpio_direction_input_failed:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_free(ai->gpio[i]);
> +err_request_gpio_failed:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 kfree(as);
> + =A0 =A0 =A0 *data =3D NULL;
> +err_alloc_axis_state_failed:
> + =A0 =A0 =A0 return ret;
> +}
> diff --git a/drivers/staging/dream/gpio_event.c b/drivers/staging/dre=
am/gpio_event.c
> new file mode 100644
> index 0000000..8b64c1e
> --- /dev/null
> +++ b/drivers/staging/dream/gpio_event.c
> @@ -0,0 +1,224 @@
> +/* drivers/input/misc/gpio_event.c
> + *
> + * Copyright (C) 2007 Google, Inc.
> + *
> + * This software is licensed under the terms of the GNU General Publ=
ic
> + * License version 2, as published by the Free Software Foundation, =
and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/earlysuspend.h>
> +#include <linux/module.h>
> +#include <linux/input.h>
> +#include <linux/gpio_event.h>
> +#include <linux/hrtimer.h>
> +#include <linux/platform_device.h>
> +
> +struct gpio_event {
> + =A0 =A0 =A0 struct input_dev *input_dev;
> + =A0 =A0 =A0 const struct gpio_event_platform_data *info;
> + =A0 =A0 =A0 struct early_suspend early_suspend;
> + =A0 =A0 =A0 void *state[0];
> +};
> +
> +static int gpio_input_event(
> + =A0 =A0 =A0 struct input_dev *dev, unsigned int type, unsigned int =
code, int value)
> +{
> + =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 int ret =3D 0;
> + =A0 =A0 =A0 int tmp_ret;
> + =A0 =A0 =A0 struct gpio_event_info **ii;
> + =A0 =A0 =A0 struct gpio_event *ip =3D input_get_drvdata(dev);
> +
> + =A0 =A0 =A0 for (i =3D 0, ii =3D ip->info->info; i < ip->info->info=
_count; i++, ii++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((*ii)->event) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp_ret =3D (*ii)->even=
t(ip->input_dev, *ii,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 &ip->state[i], type, code, value);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (tmp_ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D=
 tmp_ret;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static int gpio_event_call_all_func(struct gpio_event *ip, int func)
> +{
> + =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 int ret;
> + =A0 =A0 =A0 struct gpio_event_info **ii;
> +
> + =A0 =A0 =A0 if (func =3D=3D GPIO_EVENT_FUNC_INIT || func =3D=3D GPI=
O_EVENT_FUNC_RESUME) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ii =3D ip->info->info;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < ip->info->info_count;=
 i++, ii++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((*ii)->func =3D=3D =
NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D=
 -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err(=
"gpio_event_probe: Incomplete pdata, "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "no function\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto er=
r_no_func;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D (*ii)->func(ip-=
>input_dev, *ii, &ip->state[i],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 func);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err(=
"gpio_event_probe: function failed\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto er=
r_func_failed;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ret =3D 0;
> + =A0 =A0 =A0 i =3D ip->info->info_count;
> + =A0 =A0 =A0 ii =3D ip->info->info + i;
> + =A0 =A0 =A0 while (i > 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i--;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ii--;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (*ii)->func(ip->input_dev, *ii, &ip->st=
ate[i], func & ~1);
> +err_func_failed:
> +err_no_func:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return ret;
> +}
> +
> +#ifdef CONFIG_HAS_EARLYSUSPEND
> +void gpio_event_suspend(struct early_suspend *h)
> +{
> + =A0 =A0 =A0 struct gpio_event *ip;
> + =A0 =A0 =A0 ip =3D container_of(h, struct gpio_event, early_suspend=
);
> + =A0 =A0 =A0 gpio_event_call_all_func(ip, GPIO_EVENT_FUNC_SUSPEND);
> + =A0 =A0 =A0 ip->info->power(ip->info, 0);
> +}
> +
> +void gpio_event_resume(struct early_suspend *h)
> +{
> + =A0 =A0 =A0 struct gpio_event *ip;
> + =A0 =A0 =A0 ip =3D container_of(h, struct gpio_event, early_suspend=
);
> + =A0 =A0 =A0 ip->info->power(ip->info, 1);
> + =A0 =A0 =A0 gpio_event_call_all_func(ip, GPIO_EVENT_FUNC_RESUME);
> +}
> +#endif
> +
> +static int __init gpio_event_probe(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 int err;
> + =A0 =A0 =A0 struct gpio_event *ip;
> + =A0 =A0 =A0 struct input_dev *input_dev;
> + =A0 =A0 =A0 struct gpio_event_platform_data *event_info;
> +
> + =A0 =A0 =A0 event_info =3D pdev->dev.platform_data;
> + =A0 =A0 =A0 if (event_info =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("gpio_event_probe: No pdata\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (event_info->name =3D=3D NULL ||
> + =A0 =A0 =A0 =A0 =A0event_info->info =3D=3D NULL ||
> + =A0 =A0 =A0 =A0 =A0event_info->info_count =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("gpio_event_probe: Incomplete pd=
ata\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 ip =3D kzalloc(sizeof(*ip) +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sizeof(ip->state[0]) * event=
_info->info_count, GFP_KERNEL);
> + =A0 =A0 =A0 if (ip =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("gpio_event_probe: Failed to all=
ocate private data\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_kp_alloc_failed;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 platform_set_drvdata(pdev, ip);
> +
> + =A0 =A0 =A0 input_dev =3D input_allocate_device();
> + =A0 =A0 =A0 if (input_dev =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("gpio_event_probe: Failed to all=
ocate input device\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_input_dev_alloc_failed;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 input_set_drvdata(input_dev, ip);
> + =A0 =A0 =A0 ip->input_dev =3D input_dev;
> + =A0 =A0 =A0 ip->info =3D event_info;
> + =A0 =A0 =A0 if (event_info->power) {
> +#ifdef CONFIG_HAS_EARLYSUSPEND
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ip->early_suspend.level =3D EARLY_SUSPE=
ND_LEVEL_BLANK_SCREEN + 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ip->early_suspend.suspend =3D gpio_even=
t_suspend;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ip->early_suspend.resume =3D gpio_event=
_resume;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 register_early_suspend(&ip->early_suspe=
nd);
> +#endif
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ip->info->power(ip->info, 1);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 input_dev->name =3D ip->info->name;
> + =A0 =A0 =A0 input_dev->event =3D gpio_input_event;
> +
> + =A0 =A0 =A0 err =3D gpio_event_call_all_func(ip, GPIO_EVENT_FUNC_IN=
IT);
> + =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_call_all_func_failed;
> +
> + =A0 =A0 =A0 err =3D input_register_device(input_dev);
> + =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("gpio_event_probe: Unable to reg=
ister %s input device\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_dev->name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_input_register_device_failed;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +
> +err_input_register_device_failed:
> + =A0 =A0 =A0 gpio_event_call_all_func(ip, GPIO_EVENT_FUNC_UNINIT);
> +err_call_all_func_failed:
> + =A0 =A0 =A0 if (event_info->power) {
> +#ifdef CONFIG_HAS_EARLYSUSPEND
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unregister_early_suspend(&ip->early_sus=
pend);
> +#endif
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ip->info->power(ip->info, 0);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 input_free_device(input_dev);
> +err_input_dev_alloc_failed:
> + =A0 =A0 =A0 kfree(ip);
> +err_kp_alloc_failed:
> + =A0 =A0 =A0 return err;
> +}
> +
> +static int gpio_event_remove(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct gpio_event *ip =3D platform_get_drvdata(pdev);
> +
> + =A0 =A0 =A0 gpio_event_call_all_func(ip, GPIO_EVENT_FUNC_UNINIT);
> + =A0 =A0 =A0 if (ip->info->power) {
> +#ifdef CONFIG_HAS_EARLYSUSPEND
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unregister_early_suspend(&ip->early_sus=
pend);
> +#endif
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ip->info->power(ip->info, 0);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 input_unregister_device(ip->input_dev);
> + =A0 =A0 =A0 kfree(ip);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static struct platform_driver gpio_event_driver =3D {
> + =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D gpio_event_probe,
> + =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D gpio_event_remove,
> + =A0 =A0 =A0 .driver =A0 =A0 =A0 =A0 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D GPIO_EVENT_DEV_NAME,
> + =A0 =A0 =A0 },
> +};
> +
> +static int __devinit gpio_event_init(void)
> +{
> + =A0 =A0 =A0 return platform_driver_register(&gpio_event_driver);
> +}
> +
> +static void __exit gpio_event_exit(void)
> +{
> + =A0 =A0 =A0 platform_driver_unregister(&gpio_event_driver);
> +}
> +
> +module_init(gpio_event_init);
> +module_exit(gpio_event_exit);
> +
> +MODULE_DESCRIPTION("GPIO Event Driver");
> +MODULE_LICENSE("GPL");
> +
> diff --git a/drivers/staging/dream/gpio_input.c b/drivers/staging/dre=
am/gpio_input.c
> new file mode 100644
> index 0000000..7e307f2
> --- /dev/null
> +++ b/drivers/staging/dream/gpio_input.c
> @@ -0,0 +1,343 @@
> +/* drivers/input/misc/gpio_input.c
> + *
> + * Copyright (C) 2007 Google, Inc.
> + *
> + * This software is licensed under the terms of the GNU General Publ=
ic
> + * License version 2, as published by the Free Software Foundation, =
and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/gpio.h>
> +#include <linux/gpio_event.h>
> +#include <linux/hrtimer.h>
> +#include <linux/input.h>
> +#include <linux/interrupt.h>
> +#include <linux/wakelock.h>
> +
> +enum {
> + =A0 =A0 =A0 DEBOUNCE_UNSTABLE =A0 =A0 =3D BIT(0), /* Got irq, while=
 debouncing */
> + =A0 =A0 =A0 DEBOUNCE_PRESSED =A0 =A0 =A0=3D BIT(1),
> + =A0 =A0 =A0 DEBOUNCE_NOTPRESSED =A0 =3D BIT(2),
> + =A0 =A0 =A0 DEBOUNCE_WAIT_IRQ =A0 =A0 =3D BIT(3), /* Stable irq sta=
te */
> + =A0 =A0 =A0 DEBOUNCE_POLL =A0 =A0 =A0 =A0 =3D BIT(4), /* Stable pol=
ling state */
> +
> + =A0 =A0 =A0 DEBOUNCE_UNKNOWN =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DEBOUNCE_PRESSED | DEBOUNCE_NOTPRESSED,
> +};
> +
> +struct gpio_key_state {
> + =A0 =A0 =A0 struct gpio_input_state *ds;
> + =A0 =A0 =A0 uint8_t debounce;
> +};
> +
> +struct gpio_input_state {
> + =A0 =A0 =A0 struct input_dev *input_dev;
> + =A0 =A0 =A0 const struct gpio_event_input_info *info;
> + =A0 =A0 =A0 struct hrtimer timer;
> + =A0 =A0 =A0 int use_irq;
> + =A0 =A0 =A0 int debounce_count;
> + =A0 =A0 =A0 spinlock_t irq_lock;
> + =A0 =A0 =A0 struct wake_lock wake_lock;
> + =A0 =A0 =A0 struct gpio_key_state key_state[0];
> +};
> +
> +static enum hrtimer_restart gpio_event_input_timer_func(struct hrtim=
er *timer)
> +{
> + =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 int pressed;
> + =A0 =A0 =A0 struct gpio_input_state *ds =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 container_of(timer, struct gpio_input_s=
tate, timer);
> + =A0 =A0 =A0 unsigned gpio_flags =3D ds->info->flags;
> + =A0 =A0 =A0 unsigned npolarity;
> + =A0 =A0 =A0 int nkeys =3D ds->info->keymap_size;
> + =A0 =A0 =A0 const struct gpio_event_direct_entry *key_entry;
> + =A0 =A0 =A0 struct gpio_key_state *key_state;
> + =A0 =A0 =A0 unsigned long irqflags;
> + =A0 =A0 =A0 uint8_t debounce;
> +
> +#if 0
> + =A0 =A0 =A0 key_entry =3D kp->keys_info->keymap;
> + =A0 =A0 =A0 key_state =3D kp->key_state;
> + =A0 =A0 =A0 for (i =3D 0; i < nkeys; i++, key_entry++, key_state++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info("gpio_read_detect_status %d %d\=
n", key_entry->gpio,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_read_detect_status=
(key_entry->gpio));
> +#endif
> + =A0 =A0 =A0 key_entry =3D ds->info->keymap;
> + =A0 =A0 =A0 key_state =3D ds->key_state;
> + =A0 =A0 =A0 spin_lock_irqsave(&ds->irq_lock, irqflags);
> + =A0 =A0 =A0 for (i =3D 0; i < nkeys; i++, key_entry++, key_state++)=
 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 debounce =3D key_state->debounce;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (debounce & DEBOUNCE_WAIT_IRQ)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (key_state->debounce & DEBOUNCE_UNST=
ABLE) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 debounce =3D key_state-=
>debounce =3D DEBOUNCE_UNKNOWN;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 enable_irq(gpio_to_irq(=
key_entry->gpio));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info("gpio_keys_scan=
_keys: key %x-%x, %d "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "(%d) c=
ontinue debounce\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ds->inf=
o->type, key_entry->code,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i, key_=
entry->gpio);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 npolarity =3D !(gpio_flags & GPIOEDF_AC=
TIVE_HIGH);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pressed =3D gpio_get_value(key_entry->g=
pio) ^ npolarity;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (debounce & DEBOUNCE_POLL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pressed =3D=3D !(de=
bounce & DEBOUNCE_PRESSED)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ds->deb=
ounce_count++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 key_sta=
te->debounce =3D DEBOUNCE_UNKNOWN;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (gpi=
o_flags & GPIOEDF_PRINT_KEY_DEBOUNCE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 pr_info("gpio_keys_scan_keys: key %x-"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 "%x, %d (%d) start debounce\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 ds->info->type, key_entry->code,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 i, key_entry->gpio);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pressed && (debounce & DEBOUNCE_NOT=
PRESSED)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (gpio_flags & GPIOED=
=46_PRINT_KEY_DEBOUNCE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info=
("gpio_keys_scan_keys: key %x-%x, %d "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "(%d) debounce pressed 1\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 ds->info->type, key_entry->code,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 i, key_entry->gpio);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 key_state->debounce =3D=
 DEBOUNCE_PRESSED;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!pressed && (debounce & DEBOUNCE_PR=
ESSED)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (gpio_flags & GPIOED=
=46_PRINT_KEY_DEBOUNCE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info=
("gpio_keys_scan_keys: key %x-%x, %d "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "(%d) debounce pressed 0\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 ds->info->type, key_entry->code,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 i, key_entry->gpio);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 key_state->debounce =3D=
 DEBOUNCE_NOTPRESSED;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* key is stable */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ds->debounce_count--;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ds->use_irq)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 key_state->debounce |=3D=
 DEBOUNCE_WAIT_IRQ;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 key_state->debounce |=3D=
 DEBOUNCE_POLL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (gpio_flags & GPIOEDF_PRINT_KEYS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info("gpio_keys_scan=
_keys: key %x-%x, %d (%d) "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "change=
d to %d\n", ds->info->type,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 key_ent=
ry->code, i, key_entry->gpio, pressed);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_event(ds->input_dev, ds->info->ty=
pe,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 key_entry->code=
, pressed);
> + =A0 =A0 =A0 }
> +
> +#if 0
> + =A0 =A0 =A0 key_entry =3D kp->keys_info->keymap;
> + =A0 =A0 =A0 key_state =3D kp->key_state;
> + =A0 =A0 =A0 for (i =3D 0; i < nkeys; i++, key_entry++, key_state++)=
 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info("gpio_read_detect_status %d %d\=
n", key_entry->gpio,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_read_detect_status=
(key_entry->gpio));
> + =A0 =A0 =A0 }
> +#endif
> +
> + =A0 =A0 =A0 if (ds->debounce_count)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hrtimer_start(timer, ds->info->debounce=
_time, HRTIMER_MODE_REL);
> + =A0 =A0 =A0 else if (!ds->use_irq)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hrtimer_start(timer, ds->info->poll_tim=
e, HRTIMER_MODE_REL);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wake_unlock(&ds->wake_lock);
> +
> + =A0 =A0 =A0 spin_unlock_irqrestore(&ds->irq_lock, irqflags);
> +
> + =A0 =A0 =A0 return HRTIMER_NORESTART;
> +}
> +
> +static irqreturn_t gpio_event_input_irq_handler(int irq, void *dev_i=
d)
> +{
> + =A0 =A0 =A0 struct gpio_key_state *ks =3D dev_id;
> + =A0 =A0 =A0 struct gpio_input_state *ds =3D ks->ds;
> + =A0 =A0 =A0 int keymap_index =3D ks - ds->key_state;
> + =A0 =A0 =A0 const struct gpio_event_direct_entry *key_entry;
> + =A0 =A0 =A0 unsigned long irqflags;
> + =A0 =A0 =A0 int pressed;
> +
> + =A0 =A0 =A0 if (!ds->use_irq)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_HANDLED;
> +
> + =A0 =A0 =A0 key_entry =3D &ds->info->keymap[keymap_index];
> +
> + =A0 =A0 =A0 if (ds->info->debounce_time.tv64) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&ds->irq_lock, irqfla=
gs);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ks->debounce & DEBOUNCE_WAIT_IRQ) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ks->debounce =3D DEBOUN=
CE_UNKNOWN;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ds->debounce_count+=
+ =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wake_lo=
ck(&ds->wake_lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hrtimer=
_start(
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 &ds->timer, ds->info->debounce_time,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 HRTIMER_MODE_REL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ds->info->flags & G=
PIOEDF_PRINT_KEY_DEBOUNCE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info=
("gpio_event_input_irq_handler: "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "key %x-%x, %d (%d) start debounce\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 ds->info->type, key_entry->code,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 keymap_index, key_entry->gpio);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 disable_irq(irq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ks->debounce =3D DEBOUN=
CE_UNSTABLE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&ds->irq_lock, i=
rqflags);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pressed =3D gpio_get_value(key_entry->g=
pio) ^
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !(ds->info->flags & GPI=
OEDF_ACTIVE_HIGH);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ds->info->flags & GPIOEDF_PRINT_KEY=
S)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info("gpio_event_inp=
ut_irq_handler: key %x-%x, %d "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "(%d) c=
hanged to %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ds->inf=
o->type, key_entry->code, keymap_index,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 key_ent=
ry->gpio, pressed);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_event(ds->input_dev, ds->info->ty=
pe,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 key_entry->code=
, pressed);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return IRQ_HANDLED;
> +}
> +
> +static int gpio_event_input_request_irqs(struct gpio_input_state *ds=
)
> +{
> + =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 int err;
> + =A0 =A0 =A0 unsigned int irq;
> + =A0 =A0 =A0 unsigned long req_flags =3D IRQF_TRIGGER_RISING | IRQF_=
TRIGGER_FALLING;
> +
> + =A0 =A0 =A0 for (i =3D 0; i < ds->info->keymap_size; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D irq =3D gpio_to_irq(ds->info->k=
eymap[i].gpio);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_gpio_get_irq_n=
um_failed;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D request_irq(irq, gpio_event_inp=
ut_irq_handler,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 req=
_flags, "gpio_keys", &ds->key_state[i]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("gpio_event_inpu=
t_request_irqs: request_irq "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "failed=
 for input %d, irq %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ds->inf=
o->keymap[i].gpio, irq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_request_irq_fa=
iled;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 enable_irq_wake(irq);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 for (i =3D ds->info->keymap_size - 1; i >=3D 0; i--) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(gpio_to_irq(ds->info->keymap[i=
].gpio),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&ds->key_state[i]);
> +err_request_irq_failed:
> +err_gpio_get_irq_num_failed:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return err;
> +}
> +
> +int gpio_event_input_func(struct input_dev *input_dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct gpio_event_info =
*info, void **data, int func)
> +{
> + =A0 =A0 =A0 int ret;
> + =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 unsigned long irqflags;
> + =A0 =A0 =A0 struct gpio_event_input_info *di;
> + =A0 =A0 =A0 struct gpio_input_state *ds =3D *data;
> +
> + =A0 =A0 =A0 di =3D container_of(info, struct gpio_event_input_info,=
 info);
> +
> + =A0 =A0 =A0 if (func =3D=3D GPIO_EVENT_FUNC_SUSPEND) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&ds->irq_lock, irqfla=
gs);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ds->use_irq)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < di->k=
eymap_size; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 disable=
_irq(gpio_to_irq(di->keymap[i].gpio));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&ds->irq_lock, i=
rqflags);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hrtimer_cancel(&ds->timer);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (func =3D=3D GPIO_EVENT_FUNC_RESUME) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&ds->irq_lock, irqfla=
gs);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ds->use_irq)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < di->k=
eymap_size; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 enable_=
irq(gpio_to_irq(di->keymap[i].gpio));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hrtimer_start(&ds->timer, ktime_set(0, =
0), HRTIMER_MODE_REL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&ds->irq_lock, i=
rqflags);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (func =3D=3D GPIO_EVENT_FUNC_INIT) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ktime_to_ns(di->poll_time) <=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 di->poll_time =3D ktime=
_set(0, 20 * NSEC_PER_MSEC);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *data =3D ds =3D kzalloc(sizeof(*ds) + =
sizeof(ds->key_state[0]) *
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 di->keymap_size, GFP_KERNEL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ds =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("gpio_event_inpu=
t_func: "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Failed=
 to allocate private data\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_ds_alloc_faile=
d;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ds->debounce_count =3D di->keymap_size;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ds->input_dev =3D input_dev;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ds->info =3D di;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wake_lock_init(&ds->wake_lock, WAKE_LOC=
K_SUSPEND, "gpio_input");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_init(&ds->irq_lock);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < di->keymap_size; i++)=
 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_capability(in=
put_dev, di->type,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0di->keymap[i].code);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ds->key_state[i].ds =3D=
 ds;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ds->key_state[i].deboun=
ce =3D DEBOUNCE_UNKNOWN;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < di->keymap_size; i++)=
 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D gpio_request(di=
->keymap[i].gpio, "gpio_kp_in");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err(=
"gpio_event_input_func: gpio_request "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "failed for %d\n", di->keymap[i].gpio);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto er=
r_gpio_request_failed;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D gpio_direction_=
input(di->keymap[i].gpio);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err(=
"gpio_event_input_func: "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "gpio_direction_input failed for %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 di->keymap[i].gpio);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto er=
r_gpio_configure_failed;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D gpio_event_input_request_irqs(d=
s);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&ds->irq_lock, irqfla=
gs);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ds->use_irq =3D ret =3D=3D 0;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info("GPIO Input Driver: Start gpio =
inputs for %s in %s "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "mode\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_dev->name, ret =3D=
=3D 0 ? "interrupt" : "polling");
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hrtimer_init(&ds->timer, CLOCK_MONOTONI=
C, HRTIMER_MODE_REL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ds->timer.function =3D gpio_event_input=
_timer_func;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hrtimer_start(&ds->timer, ktime_set(0, =
0), HRTIMER_MODE_REL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&ds->irq_lock, i=
rqflags);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ret =3D 0;
> + =A0 =A0 =A0 spin_lock_irqsave(&ds->irq_lock, irqflags);
> + =A0 =A0 =A0 hrtimer_cancel(&ds->timer);
> + =A0 =A0 =A0 if (ds->use_irq) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D di->keymap_size - 1; i >=3D =
0; i--) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(gpio_to_irq(di=
->keymap[i].gpio),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&ds-=
>key_state[i]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 spin_unlock_irqrestore(&ds->irq_lock, irqflags);
> +
> + =A0 =A0 =A0 for (i =3D di->keymap_size - 1; i >=3D 0; i--) {
> +err_gpio_configure_failed:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_free(di->keymap[i].gpio);
> +err_gpio_request_failed:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 wake_lock_destroy(&ds->wake_lock);
> + =A0 =A0 =A0 kfree(ds);
> +err_ds_alloc_failed:
> + =A0 =A0 =A0 return ret;
> +}
> diff --git a/drivers/staging/dream/gpio_matrix.c b/drivers/staging/dr=
eam/gpio_matrix.c
> new file mode 100644
> index 0000000..c1f4765
> --- /dev/null
> +++ b/drivers/staging/dream/gpio_matrix.c
> @@ -0,0 +1,406 @@
> +/* drivers/input/misc/gpio_matrix.c
> + *
> + * Copyright (C) 2007 Google, Inc.
> + *
> + * This software is licensed under the terms of the GNU General Publ=
ic
> + * License version 2, as published by the Free Software Foundation, =
and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/gpio.h>
> +#include <linux/gpio_event.h>
> +#include <linux/hrtimer.h>
> +#include <linux/interrupt.h>
> +#include <linux/wakelock.h>
> +
> +struct gpio_kp {
> + =A0 =A0 =A0 struct input_dev *input_dev;
> + =A0 =A0 =A0 struct gpio_event_matrix_info *keypad_info;
> + =A0 =A0 =A0 struct hrtimer timer;
> + =A0 =A0 =A0 struct wake_lock wake_lock;
> + =A0 =A0 =A0 int current_output;
> + =A0 =A0 =A0 unsigned int use_irq:1;
> + =A0 =A0 =A0 unsigned int key_state_changed:1;
> + =A0 =A0 =A0 unsigned int last_key_state_changed:1;
> + =A0 =A0 =A0 unsigned int some_keys_pressed:2;
> + =A0 =A0 =A0 unsigned long keys_pressed[0];
> +};
> +
> +static void clear_phantom_key(struct gpio_kp *kp, int out, int in)
> +{
> + =A0 =A0 =A0 struct gpio_event_matrix_info *mi =3D kp->keypad_info;
> + =A0 =A0 =A0 int key_index =3D out * mi->ninputs + in;
> + =A0 =A0 =A0 unsigned short keycode =3D mi->keymap[key_index];;
> +
> + =A0 =A0 =A0 if (!test_bit(keycode, kp->input_dev->key)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mi->flags & GPIOKPF_PRINT_PHANTOM_K=
EYS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info("gpiomatrix: ph=
antom key %x, %d-%d (%d-%d) "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "cleare=
d\n", keycode, out, in,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mi->out=
put_gpios[out], mi->input_gpios[in]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __clear_bit(key_index, kp->keys_pressed=
);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mi->flags & GPIOKPF_PRINT_PHANTOM_K=
EYS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info("gpiomatrix: ph=
antom key %x, %d-%d (%d-%d) "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "not cl=
eared\n", keycode, out, in,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mi->out=
put_gpios[out], mi->input_gpios[in]);
> + =A0 =A0 =A0 }
> +}
> +
> +static int restore_keys_for_input(struct gpio_kp *kp, int out, int i=
n)
> +{
> + =A0 =A0 =A0 int rv =3D 0;
> + =A0 =A0 =A0 int key_index;
> +
> + =A0 =A0 =A0 key_index =3D out * kp->keypad_info->ninputs + in;
> + =A0 =A0 =A0 while (out < kp->keypad_info->noutputs) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (test_bit(key_index, kp->keys_presse=
d)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rv =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clear_phantom_key(kp, o=
ut, in);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 key_index +=3D kp->keypad_info->ninputs=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out++;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return rv;
> +}
> +
> +static void remove_phantom_keys(struct gpio_kp *kp)
> +{
> + =A0 =A0 =A0 int out, in, inp;
> + =A0 =A0 =A0 int key_index;
> +
> + =A0 =A0 =A0 if (kp->some_keys_pressed < 3)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 for (out =3D 0; out < kp->keypad_info->noutputs; out++)=
 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 inp =3D -1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 key_index =3D out * kp->keypad_info->ni=
nputs;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (in =3D 0; in < kp->keypad_info->ni=
nputs; in++, key_index++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (test_bit(key_index,=
 kp->keys_pressed)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (inp=
 =3D=3D -1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 inp =3D in;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 continue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (inp=
 >=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 if (!restore_keys_for_input(kp, out + 1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 inp))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 clear_phantom_key(kp, out, inp);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 inp =3D -2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 restore=
_keys_for_input(kp, out, in);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +}
> +
> +static void report_key(struct gpio_kp *kp, int key_index, int out, i=
nt in)
> +{
> + =A0 =A0 =A0 struct gpio_event_matrix_info *mi =3D kp->keypad_info;
> + =A0 =A0 =A0 int pressed =3D test_bit(key_index, kp->keys_pressed);
> + =A0 =A0 =A0 unsigned short keycode =3D mi->keymap[key_index];
> + =A0 =A0 =A0 if (pressed !=3D test_bit(keycode, kp->input_dev->key))=
 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (keycode =3D=3D KEY_RESERVED) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mi->flags & GPIOKPF=
_PRINT_UNMAPPED_KEYS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info=
("gpiomatrix: unmapped key, %d-%d "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "(%d-%d) changed to %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 out, in, mi->output_gpios[out],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 mi->input_gpios[in], pressed);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mi->flags & GPIOKPF=
_PRINT_MAPPED_KEYS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info=
("gpiomatrix: key %x, %d-%d (%d-%d) "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "changed to %d\n", keycode,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 out, in, mi->output_gpios[out],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 mi->input_gpios[in], pressed);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(kp->in=
put_dev, keycode, pressed);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +}
> +
> +static enum hrtimer_restart gpio_keypad_timer_func(struct hrtimer *t=
imer)
> +{
> + =A0 =A0 =A0 int out, in;
> + =A0 =A0 =A0 int key_index;
> + =A0 =A0 =A0 int gpio;
> + =A0 =A0 =A0 struct gpio_kp *kp =3D container_of(timer, struct gpio_=
kp, timer);
> + =A0 =A0 =A0 struct gpio_event_matrix_info *mi =3D kp->keypad_info;
> + =A0 =A0 =A0 unsigned gpio_keypad_flags =3D mi->flags;
> + =A0 =A0 =A0 unsigned polarity =3D !!(gpio_keypad_flags & GPIOKPF_AC=
TIVE_HIGH);
> +
> + =A0 =A0 =A0 out =3D kp->current_output;
> + =A0 =A0 =A0 if (out =3D=3D mi->noutputs) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kp->last_key_state_changed =3D kp->key_=
state_changed;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kp->key_state_changed =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kp->some_keys_pressed =3D 0;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 key_index =3D out * mi->ninputs;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (in =3D 0; in < mi->ninputs; in++, =
key_index++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio =3D mi->input_gpio=
s[in];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (gpio_get_value(gpio=
) ^ !polarity) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (kp-=
>some_keys_pressed < 3)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 kp->some_keys_pressed++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kp->key=
_state_changed |=3D !__test_and_set_bit(
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 key_index, kp->keys_pressed);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kp->key=
_state_changed |=3D __test_and_clear_bit(
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 key_index, kp->keys_pressed);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio =3D mi->output_gpios[out];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (gpio_keypad_flags & GPIOKPF_DRIVE_I=
NACTIVE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_value(gpio, !p=
olarity);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_direction_input(gp=
io);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out++;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 kp->current_output =3D out;
> + =A0 =A0 =A0 if (out < mi->noutputs) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio =3D mi->output_gpios[out];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (gpio_keypad_flags & GPIOKPF_DRIVE_I=
NACTIVE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_value(gpio, po=
larity);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_direction_output(g=
pio, polarity);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hrtimer_start(timer, mi->settle_time, H=
RTIMER_MODE_REL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return HRTIMER_NORESTART;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (gpio_keypad_flags & GPIOKPF_DEBOUNCE) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (kp->key_state_changed) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hrtimer_start(&kp->time=
r, mi->debounce_delay,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 HRTIMER_MODE_REL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return HRTIMER_NORESTAR=
T;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kp->key_state_changed =3D kp->last_key_=
state_changed;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (kp->key_state_changed) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (gpio_keypad_flags & GPIOKPF_REMOVE_=
SOME_PHANTOM_KEYS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 remove_phantom_keys(kp)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 key_index =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (out =3D 0; out < mi->noutputs; out=
++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (in =3D 0; in < mi-=
>ninputs; in++, key_index++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 report_=
key(kp, key_index, out, in);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (!kp->use_irq || kp->some_keys_pressed) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hrtimer_start(timer, mi->poll_time, HRT=
IMER_MODE_REL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return HRTIMER_NORESTART;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* No keys are pressed, reenable interrupt */
> + =A0 =A0 =A0 for (out =3D 0; out < mi->noutputs; out++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (gpio_keypad_flags & GPIOKPF_DRIVE_I=
NACTIVE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_value(mi->outp=
ut_gpios[out], polarity);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_direction_output(m=
i->output_gpios[out], polarity);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 for (in =3D 0; in < mi->ninputs; in++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 enable_irq(gpio_to_irq(mi->input_gpios[=
in]));
> + =A0 =A0 =A0 wake_unlock(&kp->wake_lock);
> + =A0 =A0 =A0 return HRTIMER_NORESTART;
> +}
> +
> +static irqreturn_t gpio_keypad_irq_handler(int irq_in, void *dev_id)
> +{
> + =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 struct gpio_kp *kp =3D dev_id;
> + =A0 =A0 =A0 struct gpio_event_matrix_info *mi =3D kp->keypad_info;
> + =A0 =A0 =A0 unsigned gpio_keypad_flags =3D mi->flags;
> +
> + =A0 =A0 =A0 if (!kp->use_irq) /* ignore interrupt while registering=
 the handler */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_HANDLED;
> +
> + =A0 =A0 =A0 for (i =3D 0; i < mi->ninputs; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 disable_irq(gpio_to_irq(mi->input_gpios=
[i]));
> + =A0 =A0 =A0 for (i =3D 0; i < mi->noutputs; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (gpio_keypad_flags & GPIOKPF_DRIVE_I=
NACTIVE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_value(mi->outp=
ut_gpios[i],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !(gpio_=
keypad_flags & GPIOKPF_ACTIVE_HIGH));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_direction_input(mi=
->output_gpios[i]);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 wake_lock(&kp->wake_lock);
> + =A0 =A0 =A0 hrtimer_start(&kp->timer, ktime_set(0, 0), HRTIMER_MODE=
_REL);
> + =A0 =A0 =A0 return IRQ_HANDLED;
> +}
> +
> +static int gpio_keypad_request_irqs(struct gpio_kp *kp)
> +{
> + =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 int err;
> + =A0 =A0 =A0 unsigned int irq;
> + =A0 =A0 =A0 unsigned long request_flags;
> + =A0 =A0 =A0 struct gpio_event_matrix_info *mi =3D kp->keypad_info;
> +
> + =A0 =A0 =A0 switch (mi->flags & (GPIOKPF_ACTIVE_HIGH|GPIOKPF_LEVEL_=
TRIGGERED_IRQ)) {
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 request_flags =3D IRQF_TRIGGER_FALLING;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case GPIOKPF_ACTIVE_HIGH:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 request_flags =3D IRQF_TRIGGER_RISING;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case GPIOKPF_LEVEL_TRIGGERED_IRQ:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 request_flags =3D IRQF_TRIGGER_LOW;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case GPIOKPF_LEVEL_TRIGGERED_IRQ | GPIOKPF_ACTIVE_HIGH:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 request_flags =3D IRQF_TRIGGER_HIGH;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 for (i =3D 0; i < mi->ninputs; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D irq =3D gpio_to_irq(mi->input_g=
pios[i]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_gpio_get_irq_n=
um_failed;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D request_irq(irq, gpio_keypad_ir=
q_handler, request_flags,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "gp=
io_kp", kp);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("gpiomatrix: req=
uest_irq failed for input %d, "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "irq %d=
\n", mi->input_gpios[i], irq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_request_irq_fa=
iled;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D set_irq_wake(irq, 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("gpiomatrix: set=
_irq_wake failed for input %d, "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "irq %d=
\n", mi->input_gpios[i], irq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 disable_irq(irq);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 for (i =3D mi->noutputs - 1; i >=3D 0; i--) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(gpio_to_irq(mi->input_gpios[i]=
), kp);
> +err_request_irq_failed:
> +err_gpio_get_irq_num_failed:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return err;
> +}
> +
> +int gpio_event_matrix_func(struct input_dev *input_dev,
> + =A0 =A0 =A0 struct gpio_event_info *info, void **data, int func)
> +{
> + =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 int err;
> + =A0 =A0 =A0 int key_count;
> + =A0 =A0 =A0 struct gpio_kp *kp;
> + =A0 =A0 =A0 struct gpio_event_matrix_info *mi;
> +
> + =A0 =A0 =A0 mi =3D container_of(info, struct gpio_event_matrix_info=
, info);
> + =A0 =A0 =A0 if (func =3D=3D GPIO_EVENT_FUNC_SUSPEND || func =3D=3D =
GPIO_EVENT_FUNC_RESUME) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* TODO: disable scanning */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (func =3D=3D GPIO_EVENT_FUNC_INIT) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mi->keymap =3D=3D NULL ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mi->input_gpios =3D=3D NULL ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mi->output_gpios =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("gpiomatrix: Inc=
omplete pdata\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_invalid_platfo=
rm_data;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 key_count =3D mi->ninputs * mi->noutput=
s;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *data =3D kp =3D kzalloc(sizeof(*kp) + =
sizeof(kp->keys_pressed[0]) *
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0BITS_TO_LONGS(key_count), GFP_KERNEL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (kp =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("gpiomatrix: Fai=
led to allocate private data\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_kp_alloc_faile=
d;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kp->input_dev =3D input_dev;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kp->keypad_info =3D mi;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_bit(EV_KEY, input_dev->evbit);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < key_count; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mi->keymap[i])
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_bit=
(mi->keymap[i] & KEY_MAX,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 input_dev->keybit);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < mi->noutputs; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (gpio_cansleep(mi->o=
utput_gpios[i])) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err(=
"gpiomatrix: unsupported output gpio %d,"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 " can sleep\n", mi->output_gpios[i]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D=
 -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto er=
r_request_output_gpio_failed;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D gpio_request(mi=
->output_gpios[i], "gpio_kp_out");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err(=
"gpiomatrix: gpio_request failed for "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "output %d\n", mi->output_gpios[i]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto er=
r_request_output_gpio_failed;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mi->flags & GPIOKPF=
_DRIVE_INACTIVE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D=
 gpio_direction_output(mi->output_gpios[i],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 !(mi->flags & GPIOKPF_ACTIVE_HIGH));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D=
 gpio_direction_input(mi->output_gpios[i]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err(=
"gpiomatrix: gpio_configure failed for "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "output %d\n", mi->output_gpios[i]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto er=
r_output_gpio_configure_failed;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < mi->ninputs; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D gpio_request(mi=
->input_gpios[i], "gpio_kp_in");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err(=
"gpiomatrix: gpio_request failed for "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "input %d\n", mi->input_gpios[i]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto er=
r_request_input_gpio_failed;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D gpio_direction_=
input(mi->input_gpios[i]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err(=
"gpiomatrix: gpio_direction_input failed"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 " for input %d\n", mi->input_gpios[i]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto er=
r_gpio_direction_input_failed;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kp->current_output =3D mi->noutputs;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kp->key_state_changed =3D 1;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hrtimer_init(&kp->timer, CLOCK_MONOTONI=
C, HRTIMER_MODE_REL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kp->timer.function =3D gpio_keypad_time=
r_func;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wake_lock_init(&kp->wake_lock, WAKE_LOC=
K_SUSPEND, "gpio_kp");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D gpio_keypad_request_irqs(kp);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kp->use_irq =3D err =3D=3D 0;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info("GPIO Matrix Keypad Driver: Sta=
rt keypad matrix for %s "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "in %s mode\n", input_d=
ev->name,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kp->use_irq ? "interrup=
t" : "polling");
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (kp->use_irq)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wake_lock(&kp->wake_loc=
k);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 hrtimer_start(&kp->timer, ktime_set(0, =
0), HRTIMER_MODE_REL);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 err =3D 0;
> + =A0 =A0 =A0 kp =3D *data;
> +
> + =A0 =A0 =A0 if (kp->use_irq)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D mi->noutputs - 1; i >=3D 0; =
i--)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(gpio_to_irq(mi=
->input_gpios[i]), kp);
> +
> + =A0 =A0 =A0 hrtimer_cancel(&kp->timer);
> + =A0 =A0 =A0 wake_lock_destroy(&kp->wake_lock);
> + =A0 =A0 =A0 for (i =3D mi->noutputs - 1; i >=3D 0; i--) {
> +err_gpio_direction_input_failed:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_free(mi->input_gpios[i]);
> +err_request_input_gpio_failed:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 for (i =3D mi->noutputs - 1; i >=3D 0; i--) {
> +err_output_gpio_configure_failed:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_free(mi->output_gpios[i]);
> +err_request_output_gpio_failed:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 kfree(kp);
> +err_kp_alloc_failed:
> +err_invalid_platform_data:
> + =A0 =A0 =A0 return err;
> +}
> diff --git a/drivers/staging/dream/gpio_output.c b/drivers/staging/dr=
eam/gpio_output.c
> new file mode 100644
> index 0000000..6f8453c
> --- /dev/null
> +++ b/drivers/staging/dream/gpio_output.c
> @@ -0,0 +1,84 @@
> +/* drivers/input/misc/gpio_output.c
> + *
> + * Copyright (C) 2007 Google, Inc.
> + *
> + * This software is licensed under the terms of the GNU General Publ=
ic
> + * License version 2, as published by the Free Software Foundation, =
and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/gpio.h>
> +#include <linux/gpio_event.h>
> +
> +int gpio_event_output_event(
> + =A0 =A0 =A0 struct input_dev *input_dev, struct gpio_event_info *in=
fo, void **data,
> + =A0 =A0 =A0 unsigned int type, unsigned int code, int value)
> +{
> + =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 struct gpio_event_output_info *oi;
> + =A0 =A0 =A0 oi =3D container_of(info, struct gpio_event_output_info=
, info);
> + =A0 =A0 =A0 if (type !=3D oi->type)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 if (!(oi->flags & GPIOEDF_ACTIVE_HIGH))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 value =3D !value;
> + =A0 =A0 =A0 for (i =3D 0; i < oi->keymap_size; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (code =3D=3D oi->keymap[i].code)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_value(oi->keym=
ap[i].gpio, value);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +int gpio_event_output_func(
> + =A0 =A0 =A0 struct input_dev *input_dev, struct gpio_event_info *in=
fo, void **data,
> + =A0 =A0 =A0 int func)
> +{
> + =A0 =A0 =A0 int ret;
> + =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 struct gpio_event_output_info *oi;
> + =A0 =A0 =A0 oi =3D container_of(info, struct gpio_event_output_info=
, info);
> +
> + =A0 =A0 =A0 if (func =3D=3D GPIO_EVENT_FUNC_SUSPEND || func =3D=3D =
GPIO_EVENT_FUNC_RESUME)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 if (func =3D=3D GPIO_EVENT_FUNC_INIT) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int output_level =3D !(oi->flags & GPIO=
EDF_ACTIVE_HIGH);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < oi->keymap_size; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_capability(in=
put_dev, oi->type,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0oi->keymap[i].code);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < oi->keymap_size; i++)=
 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D gpio_request(oi=
->keymap[i].gpio,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0"gpio_event_output");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err(=
"gpio_event_output_func: gpio_request "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "failed for %d\n", oi->keymap[i].gpio);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto er=
r_gpio_request_failed;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D gpio_direction_=
output(oi->keymap[i].gpio,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 output_level);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err(=
"gpio_event_output_func: "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "gpio_direction_output failed for %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 oi->keymap[i].gpio);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto er=
r_gpio_direction_output_failed;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ret =3D 0;
> + =A0 =A0 =A0 for (i =3D oi->keymap_size - 1; i >=3D 0; i--) {
> +err_gpio_direction_output_failed:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_free(oi->keymap[i].gpio);
> +err_gpio_request_failed:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return ret;
> +}
> +
>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/hors=
es/blog.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
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

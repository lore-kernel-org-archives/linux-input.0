From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [RFC][PATCH] DM365 Keypad Support
Date: Mon, 22 Jun 2009 11:55:11 +0530
Message-ID: <5d5443650906212325m35e71559i412a44407541f606@mail.gmail.com>
References: <1245596804-28718-1-git-send-email-s-paulraj@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f171.google.com ([209.85.221.171]:52725 "EHLO
	mail-qy0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752772AbZFVGZJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Jun 2009 02:25:09 -0400
Received: by qyk1 with SMTP id 1so803700qyk.33
        for <linux-input@vger.kernel.org>; Sun, 21 Jun 2009 23:25:11 -0700 (PDT)
In-Reply-To: <1245596804-28718-1-git-send-email-s-paulraj@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: s-paulraj@ti.com
Cc: davinci-linux-open-source@linux.davincidsp.com, linux-input@vger.kernel.org

Hi Sandeep,

CCing linux-input. You have to submit only keypad driver to
linux-input again, once all the dependencies are mainlined first.

On Sun, Jun 21, 2009 at 8:36 PM, <s-paulraj@ti.com> wrote:
> From: Sandeep Paulraj <s-paulraj@ti.com>
>
> Patch adds support for the Keypad on the DM365 EVM.
> At present the driver comes up fine and the device gets
> registered.
>

This is anyway expected. Do you want to keep this in commit text?

> For the keypad to work, we need to enable with the help of the
> CPLD on the DM365 EVM.
> David Brownell has a patch ready(Thanks for sending me the patch Davi=
d)
>
> The CPLD patch adds on top of my DM365 patches and also
> re arranges a lot of my code that i submitted.

All dependencies plus platform data header files should be first
mainlined through davinci GIT tree and then you need to submit this
keypad driver only to linux-input so that it go mainline through
Dmitry's tree.

> =A0create mode 100644 arch/arm/mach-davinci/include/mach/dm365_keypad=
=2Eh
> =A0create mode 100755 drivers/input/keyboard/dm365evm_keypad.c

=46ile mode problem. Looks like you are editing from different $OS.


>
> +static int dm365evm_keymap[] =3D {
> + =A0 =A0 =A0 KEY_DM365_KEY2,
> + =A0 =A0 =A0 KEY_DM365_LEFT,
> + =A0 =A0 =A0 KEY_DM365_EXIT,
> + =A0 =A0 =A0 KEY_DM365_DOWN,
> + =A0 =A0 =A0 KEY_DM365_ENTER,
> + =A0 =A0 =A0 KEY_DM365_UP,
> + =A0 =A0 =A0 KEY_DM365_KEY1,
> + =A0 =A0 =A0 KEY_DM365_RIGHT,
> + =A0 =A0 =A0 KEY_DM365_MENU,
> + =A0 =A0 =A0 KEY_DM365_REC,
> + =A0 =A0 =A0 KEY_DM365_REW,
> + =A0 =A0 =A0 KEY_DM365_SKIPMINUS,
> + =A0 =A0 =A0 KEY_DM365_STOP,
> + =A0 =A0 =A0 KEY_DM365_FF,
> + =A0 =A0 =A0 KEY_DM365_SKIPPLUL,
> + =A0 =A0 =A0 KEY_DM365_PLAYPAUSE,
> + =A0 =A0 =A0 0
> +};

As David suggested, it is better to convert it into the keymap format
like other input driver do. You can grep for gpio matrix driver on
linux-input archives.

> +
> +static struct dm365_kp_platform_data dm365evm_kp_data =3D {
> + =A0 =A0 =A0 .keymap =A0 =A0 =A0 =A0 =3D dm365evm_keymap,
> + =A0 =A0 =A0 .keymapsize =A0 =A0 =3D ARRAY_SIZE(dm365evm_keymap),
> + =A0 =A0 =A0 .rep =A0 =A0 =A0 =A0 =A0 =A0=3D 1,
> +};

You might want to add more platform data here, like "scan time",
"debounce_time" if your keypad controller has those configurable
parameters.

> =A0static struct davinci_uart_config uart_config __initdata =3D {
> diff --git a/arch/arm/mach-davinci/include/mach/dm365_keypad.h b/arch=
/arm/mach-davinci/include/mach/dm365_keypad.h
> new file mode 100644
> index 0000000..3d0b348
> --- /dev/null
> +++ b/arch/arm/mach-davinci/include/mach/dm365_keypad.h
> @@ -0,0 +1,81 @@
> +/*
> + *
> + * Copyright (C) 2009 Texas Instruments, Inc.
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License as published=
 by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA =A002111=
-1307 =A0USA
> + */
> +
> +#ifndef __DM365_KEYPAD_H__
> +#define __DM365_KEYPAD_H__
> +
> +struct dm365_kp_platform_data {
> + =A0 =A0 =A0 int *keymap;
> + =A0 =A0 =A0 unsigned int keymapsize;
> + =A0 =A0 =A0 unsigned int rep:1;
> +};
> +
> +/* Keypad registers */
> +#define DM365_KEYSCAN_BASE =A0 =A0 =A0 =A0 =A0 =A0 0x01C69400
> +#define KEYPAD_BASE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DM365_KEY=
SCAN_BASE
> +#define DM365_KEYPAD_KEYCTRL =A0 =A0 =A0 =A0 =A0 (0x0000)
> +#define DM365_KEYPAD_INTENA =A0 =A0 =A0 =A0 =A0 =A0(0x0004)
> +#define DM365_KEYPAD_INTFLAG =A0 =A0 =A0 =A0 =A0 (0x0008)
> +#define DM365_KEYPAD_INTCLR =A0 =A0 =A0 =A0 =A0 =A0(0x000c)
> +#define DM365_KEYPAD_STRBWIDTH =A0 =A0 =A0 =A0 (0x0010)
> +#define DM365_KEYPAD_INTERVAL =A0 =A0 =A0 =A0 =A0(0x0014)
> +#define DM365_KEYPAD_CONTTIME =A0 =A0 =A0 =A0 =A0(0x0018)
> +#define DM365_KEYPAD_CURRENTST =A0 =A0 =A0 =A0 (0x001c)
> +#define DM365_KEYPAD_PREVSTATE =A0 =A0 =A0 =A0 (0x0020)
> +#define DM365_KEYPAD_EMUCTRL =A0 =A0 =A0 =A0 =A0 (0x0024)
> +#define DM365_KEYPAD_IODFTCTRL =A0 =A0 =A0 =A0 (0x002c)
> +
> +/*Key Control Register (KEYCTRL)*/
> +
> +#define DM365_KEYPAD_KEYEN =A0 =A0 =A0 =A0 =A0 =A0 0x00000001
> +#define DM365_KEYPAD_PREVMODE =A0 =A0 =A0 =A0 =A00x00000002
> +#define DM365_KEYPAD_CHATOFF =A0 =A0 =A0 =A0 =A0 0x00000004
> +#define DM365_KEYPAD_AUTODET =A0 =A0 =A0 =A0 =A0 0x00000008
> +#define DM365_KEYPAD_SCANMODE =A0 =A0 =A0 =A0 =A00x00000010
> +#define DM365_KEYPAD_OUTTYPE =A0 =A0 =A0 =A0 =A0 0x00000020
> +#define DM365_KEYPAD_4X4 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x00000040
> +
> +/*Masks for the interrupts*/
> +
> +#define DM365_KEYPAD_INT_CONT =A0 =A0 =A0 =A0 =A0 0x00000008
> +#define DM365_KEYPAD_INT_OFF =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0=
0000004
> +#define DM365_KEYPAD_INT_ON =A0 =A0 =A0 =A0 =A0 =A0 0x00000002
> +#define DM365_KEYPAD_INT_CHANGE =A0 =A0 =A0 =A0 0x00000001
> +#define DM365_KEYPAD_INT_ALL =A0 =A0 =A0 =A0 =A0 0x0000000f
> +

This is a wrong file for registers. You should keep them in ".c" file
of driver itself.

> +/*Masks for the various keys on the DM365*/
> +
> +#define =A0 =A0 =A0 =A0KEY_DM365_KEY2 =A0 =A0 =A0 =A0 =A00
> +#define =A0 =A0 =A0 =A0KEY_DM365_LEFT =A0 =A0 =A0 =A0 =A01
> +#define =A0 =A0 =A0 =A0KEY_DM365_EXIT =A0 =A0 =A0 =A0 =A02
> +#define =A0 =A0 =A0 =A0KEY_DM365_DOWN =A0 =A0 =A0 =A0 =A03
> +#define =A0 =A0 =A0 =A0KEY_DM365_ENTER =A0 =A0 =A0 =A0 4
> +#define =A0 =A0 =A0 =A0KEY_DM365_UP =A0 =A0 =A0 =A0 =A0 =A05
> +#define =A0 =A0 =A0 =A0KEY_DM365_KEY1 =A0 =A0 =A0 =A0 =A06
> +#define =A0 =A0 =A0 =A0KEY_DM365_RIGHT =A0 =A0 =A0 =A0 7
> +#define =A0 =A0 =A0 =A0KEY_DM365_MENU =A0 =A0 =A0 =A0 =A08
> +#define =A0 =A0 =A0 =A0KEY_DM365_REC =A0 =A0 =A0 =A0 =A0 9
> +#define =A0 =A0 =A0 =A0KEY_DM365_REW =A0 =A0 =A0 =A0 =A0 10
> +#define =A0 =A0 =A0 =A0KEY_DM365_SKIPMINUS =A0 =A0 11
> +#define =A0 =A0 =A0 =A0KEY_DM365_STOP =A0 =A0 =A0 =A0 =A012
> +#define =A0 =A0 =A0 =A0KEY_DM365_FF =A0 =A0 =A0 =A0 =A0 =A013
> +#define =A0 =A0 =A0 =A0KEY_DM365_SKIPPLUL =A0 =A0 =A014
> +#define =A0 =A0 =A0 =A0KEY_DM365_PLAYPAUSE =A0 =A0 15
> +
> +#endif
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/=
Kconfig
> index 5f09663..aee1790 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -340,4 +340,10 @@ config KEYBOARD_DM355EVM
> =A0 =A0 =A0 =A0 =A0Supports the pushbuttons and IR remote used with
> =A0 =A0 =A0 =A0 =A0the DM355 EVM board.
>
> +config KEYBOARD_DM365EVM
> + =A0 =A0 =A0 tristate "TI DaVinci DM365 EVM Keypad"
> + =A0 =A0 =A0 depends on ARCH_DAVINCI_DM365
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 Supports only the keypad Module on the DM365 EVM
> +
> =A0endif
> diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard=
/Makefile
> index a698caa..77d547d 100644
> --- a/drivers/input/keyboard/Makefile
> +++ b/drivers/input/keyboard/Makefile
> @@ -29,3 +29,4 @@ obj-$(CONFIG_KEYBOARD_MAPLE) =A0 =A0 =A0 =A0 =A0+=3D=
 maple_keyb.o
> =A0obj-$(CONFIG_KEYBOARD_BFIN) =A0 =A0 =A0 =A0 =A0 =A0+=3D bf54x-keys=
=2Eo
> =A0obj-$(CONFIG_KEYBOARD_SH_KEYSC) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D=
 sh_keysc.o
> =A0obj-$(CONFIG_KEYBOARD_DM355EVM) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D=
 dm355evm_keys.o
> +obj-$(CONFIG_KEYBOARD_DM365EVM) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D =
dm365evm_keypad.o
> diff --git a/drivers/input/keyboard/dm365evm_keypad.c b/drivers/input=
/keyboard/dm365evm_keypad.c
> new file mode 100755
> index 0000000..99b12e2
> --- /dev/null
> +++ b/drivers/input/keyboard/dm365evm_keypad.c
> @@ -0,0 +1,279 @@
> +/*
> + *
> + * Copyright (C) 2009 Texas Instruments, Inc
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License as published=
 by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-13=
07 USA
> + */
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/types.h>
> +#include <linux/input.h>
> +#include <linux/kernel.h>
> +#include <linux/delay.h>
> +#include <linux/platform_device.h>
> +#include <linux/errno.h>
> +#include <linux/mutex.h>
> +#include <linux/io.h>
> +#include <asm/irq.h>
> +#include <mach/dm365_keypad.h>
> +#include <mach/hardware.h>
> +#include <mach/irqs.h>
> +#include <mach/mux.h>
> +
> +#define dm365_keypad_write(val, addr) =A0__raw_writel(val, \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned int *)((u32)dm365_kp_base + (=
u32)(addr)))
> +#define dm365_keypad_read(addr) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__raw=
_readl(\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned int *)((u32)dm365_kp_base + (=
u32)(addr)))
> +

Please convert them into functions, so that you can have benefit of
type checking.

> +struct davinci_kp {
> + =A0 =A0 =A0 struct input_dev =A0 =A0 =A0 =A0*input;
> + =A0 =A0 =A0 int irq;
> +};
> +
> +static void __iomem =A0 =A0*dm365_kp_base;
> +static resource_size_t dm365_kp_pbase;
> +static size_t =A0 =A0 =A0 =A0 =A0dm365_kp_base_size;
> +static int *keymap;

Someof this should go into your driver structure "davinci_kp" instead.

> +
> +void dm365_keypad_initialize(void)
> +{
> + =A0 =A0 =A0 /*Initializing the Keypad Module */
> +
> + =A0 =A0 =A0 /* Enable all interrupts */
> + =A0 =A0 =A0 dm365_keypad_write(DM365_KEYPAD_INT_ALL, DM365_KEYPAD_I=
NTENA);
> +
> + =A0 =A0 =A0 /* Clear interrupts if any */
> + =A0 =A0 =A0 dm365_keypad_write(DM365_KEYPAD_INT_ALL, DM365_KEYPAD_I=
NTCLR);
> +
> + =A0 =A0 =A0 /* Setup the scan period */
> + =A0 =A0 =A0 dm365_keypad_write(0x05, DM365_KEYPAD_STRBWIDTH);
> + =A0 =A0 =A0 dm365_keypad_write(0x02, DM365_KEYPAD_INTERVAL);
> + =A0 =A0 =A0 dm365_keypad_write(0x01, DM365_KEYPAD_CONTTIME);

As said above "scan" period should come from platform data instead.

> +
> + =A0 =A0 =A0 /* Enable Keyscan module and enable */
> + =A0 =A0 =A0 dm365_keypad_write(DM365_KEYPAD_AUTODET | DM365_KEYPAD_=
KEYEN,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DM365_KEYPAD_KEY=
CTRL);
> +}
> +
> +static irqreturn_t dm365_kp_interrupt(int irq, void *dev_id)
> +{
> + =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 unsigned int status, temp, temp1;
> + =A0 =A0 =A0 int keycode =3D KEY_UNKNOWN;
> + =A0 =A0 =A0 struct davinci_kp *dm365_kp =3D dev_id;
> +
> + =A0 =A0 =A0 /* Reading the status of the Keypad */
> + =A0 =A0 =A0 status =3D dm365_keypad_read(DM365_KEYPAD_PREVSTATE);
> +
> + =A0 =A0 =A0 temp =3D ~status;
> +
> + =A0 =A0 =A0 for (i =3D 0; i < 16; i++) {

What is "16"?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp1 =3D temp >> i;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (temp1 & 0x1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 keycode =3D keymap[i];
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* report press + relea=
se */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(dm365_=
kp->input, keycode, 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_sync(dm365_kp->in=
put);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(dm365_=
kp->input, keycode, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_sync(dm365_kp->in=
put);

Why you want to send "release" just after "press"? This code needs some=
 comment.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* clearing interrupts */
> + =A0 =A0 =A0 dm365_keypad_write(DM365_KEYPAD_INT_ALL, DM365_KEYPAD_I=
NTCLR);
> +
> + =A0 =A0 =A0 return IRQ_HANDLED;
> +}
> +
> +/*
> + * Registers keypad device with input sub system
> + * and configures DM365 keypad registers
> + */
> +static int dm365_kp_probe(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct davinci_kp *dm365_kp;
> + =A0 =A0 =A0 struct input_dev *key_dev;
> + =A0 =A0 =A0 struct resource *res, *mem;
> + =A0 =A0 =A0 int ret, i;
> + =A0 =A0 =A0 unsigned int val;
> + =A0 =A0 =A0 struct dm365_kp_platform_data *pdata =3D pdev->dev.plat=
form_data;
> +
> + =A0 =A0 =A0 /* Enabling pins for Keypad */
> + =A0 =A0 =A0 davinci_cfg_reg(DM365_KEYPAD);
> +
> + =A0 =A0 =A0 /* TODO
> + =A0 =A0 =A0 =A0* Enable the Keypad Module by writing appropriate va=
lue
> + =A0 =A0 =A0 =A0* to CPLD Register 3
> + =A0 =A0 =A0 =A0* Will wait for David Brownell's CPLD patch
> + =A0 =A0 =A0 =A0*/
> +
> + =A0 =A0 =A0 if (!pdata->keymap) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "No keymap from pdata\n=
");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 dm365_kp =3D kzalloc(sizeof *dm365_kp, GFP_KERNEL);
> + =A0 =A0 =A0 key_dev =3D input_allocate_device();
> +
> + =A0 =A0 =A0 if (!dm365_kp || !key_dev) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Could not allocate inp=
ut device\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 platform_set_drvdata(pdev, dm365_kp);
> +
> + =A0 =A0 =A0 dm365_kp->input =3D key_dev;
> +
> + =A0 =A0 =A0 dm365_kp->irq =3D platform_get_irq(pdev, 0);
> + =A0 =A0 =A0 if (dm365_kp->irq <=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s: No DM365 Keypad irq\n", p=
dev->name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +
> + =A0 =A0 =A0 dm365_kp_pbase =3D res->start;
> + =A0 =A0 =A0 dm365_kp_base_size =3D res->end - res->start + 1;

Please use resource_size.

> +
> + =A0 =A0 =A0 if (res)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mem =3D request_mem_region(res->start,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0dm365_kp_base_size, pdev->name);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mem =3D NULL;
> +
> + =A0 =A0 =A0 if (!mem) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s: KEYSCAN registers at %08x=
 are not free\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pdev->name, DM365_KE=
YSCAN_BASE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 dm365_kp_base =3D ioremap(res->start, dm365_kp_base_siz=
e);
> + =A0 =A0 =A0 if (dm365_kp_base =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s: Can't ioremap MEM resourc=
e.\n", pdev->name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail2;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Enable auto repeat feature of Linux input subsystem =
*/
> + =A0 =A0 =A0 if (pdata->rep)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_bit(EV_REP, key_dev->evbit);

Please use non-atomic version of this. __set_bit.

> +
> + =A0 =A0 =A0 /* setup input device */
> + =A0 =A0 =A0 set_bit(EV_KEY, key_dev->evbit);

__set_bit.

> +
> + =A0 =A0 =A0 /* Setup the keymap */
> + =A0 =A0 =A0 keymap =3D pdata->keymap;
> +
> + =A0 =A0 =A0 for (i =3D 0; i < 16; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_bit(keymap[i], key_dev->keybit);

__set_bit.

> +
> + =A0 =A0 =A0 key_dev->name =3D "dm365_keypad";
> + =A0 =A0 =A0 key_dev->phys =3D "dm365_keypad/input0";
> + =A0 =A0 =A0 key_dev->dev.parent =3D &pdev->dev;
> +
> + =A0 =A0 =A0 key_dev->id.bustype =3D BUS_HOST;
> + =A0 =A0 =A0 key_dev->id.vendor =3D 0x0001;
> + =A0 =A0 =A0 key_dev->id.product =3D 0x0365;
> + =A0 =A0 =A0 key_dev->id.version =3D 0x0001;
> +
> + =A0 =A0 =A0 key_dev->keycode =3D keymap;
> + =A0 =A0 =A0 key_dev->keycodesize =3D sizeof(unsigned int);
> + =A0 =A0 =A0 key_dev->keycodemax =3D pdata->keymapsize;

Instead you should define max_keymap_size, which is supported for
controller itself.

> +
> + =A0 =A0 =A0 ret =3D input_register_device(dm365_kp->input);
> + =A0 =A0 =A0 if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Unable to register DaVi=
nci DM365 keypad device\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail3;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ret =3D request_irq(dm365_kp->irq, dm365_kp_interrupt, =
IRQF_DISABLED,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "dm365_keypad", dm3=
65_kp);
> + =A0 =A0 =A0 if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Unable to register DaVi=
nci DM365 keypad Interrupt\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail4;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 dm365_keypad_initialize();
> +
> + =A0 =A0 =A0 return 0;
> +fail4:
> + =A0 =A0 =A0 input_unregister_device(dm365_kp->input);
> +fail3:
> + =A0 =A0 =A0 iounmap(dm365_kp_base);
> +fail2:
> + =A0 =A0 =A0 release_mem_region(dm365_kp_pbase, dm365_kp_base_size);
> +fail1:
> + =A0 =A0 =A0 kfree(dm365_kp);
> + =A0 =A0 =A0 input_free_device(key_dev);

input_free_device after input_unregister_device is not required,
before input_dev is refcounted. In above code put dm365_kp->input =3D
NULL after input_unregister_device.

> +
> + =A0 =A0 =A0 /* TODO
> + =A0 =A0 =A0 =A0* Re enabling other modules by doing a CPLD write
> + =A0 =A0 =A0 =A0* Will wait for David Brownell's patch
> + =A0 =A0 =A0 =A0*/
> +
> + =A0 =A0 =A0 return -EINVAL;
> +}
> +
> +static int __devexit dm365_kp_remove(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct davinci_kp *dm365_kp =3D platform_get_drvdata(pd=
ev);
> +
> + =A0 =A0 =A0 input_unregister_device(dm365_kp->input);
> + =A0 =A0 =A0 free_irq(dm365_kp->irq, dm365_kp);
> + =A0 =A0 =A0 kfree(dm365_kp);
> +
> + =A0 =A0 =A0 iounmap(dm365_kp_base);
> + =A0 =A0 =A0 release_mem_region(dm365_kp_pbase, dm365_kp_base_size);
> +
> + =A0 =A0 =A0 platform_set_drvdata(pdev, NULL);
> +
> + =A0 =A0 =A0 /* TODO
> + =A0 =A0 =A0 =A0* Re enabling other modules by doing a CPLD write
> + =A0 =A0 =A0 =A0* Will wait for David Brownell's patch
> + =A0 =A0 =A0 =A0*/
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static struct platform_driver dm365_kp_driver =3D {
> + =A0 =A0 =A0 .probe =3D dm365_kp_probe,
> + =A0 =A0 =A0 .remove =3D __devexit_p(dm365_kp_remove),
> + =A0 =A0 =A0 .driver =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =3D "dm365_keypad",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.owner =3D THIS_MODULE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0},
> +};
> +
> +static int __init dm365_kp_init(void)
> +{
> + =A0 =A0 =A0 printk(KERN_INFO "DaVinci DM365 Keypad Driver\n");
> +

No need of banner.

> + =A0 =A0 =A0 return platform_driver_register(&dm365_kp_driver);
> +}
> +
> +static void __exit dm365_kp_exit(void)
> +{
> + =A0 =A0 =A0 platform_driver_unregister(&dm365_kp_driver);
> +}
> +
> +module_init(dm365_kp_init);
> +module_exit(dm365_kp_exit);
> +
> +MODULE_AUTHOR("Sandeep Paulraj");
> +MODULE_DESCRIPTION("Texas Instruments DaVinci DM365 EVM Keypad Drive=
r");
> +MODULE_LICENSE("GPL");

--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: "Nori, Sekhar" <nsekhar@ti.com>
Subject: RE: [PATCH v3 1/2] Input: Add DaVinci DM365 Keypad support
Date: Tue, 22 Sep 2009 12:35:29 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DD991DD8@dbde02.ent.ti.com>
References: <1253217996-11548-1-git-send-email-miguel.aguilar@ridgerun.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301DD916A60@dbde02.ent.ti.com>
 <4AB39A00.8080405@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53418 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755264AbZIVHFm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Sep 2009 03:05:42 -0400
In-Reply-To: <4AB39A00.8080405@ridgerun.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Miguel Aguilar <miguel.aguilar@ridgerun.com>
Cc: "Narnakaje, Snehaprabha" <nsnehaprabha@ti.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "santiago.nunez@ridgerun.com" <santiago.nunez@ridgerun.com>, "todd.fischer@ridgerun.com" <todd.fischer@ridgerun.com>, "clark.becker@ridgerun.com" <clark.becker@ridgerun.com>

On Fri, Sep 18, 2009 at 20:02:32, Miguel Aguilar wrote:
> Sekhar,
>
> See the comments below.
>
> Nori, Sekhar wrote:
> > On Fri, Sep 18, 2009 at 01:36:36, miguel.aguilar@ridgerun.com wrote:

[...]

> >> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> >> index a6b989a..08ed7d4 100644
> >> --- a/drivers/input/keyboard/Kconfig
> >> +++ b/drivers/input/keyboard/Kconfig
> >> @@ -361,4 +361,10 @@ config KEYBOARD_XTKBD
> >>         To compile this driver as a module, choose M here: the
> >>         module will be called xtkbd.
> >>
> >> +config KEYBOARD_DAVINCI_DM365
> >
> > How about calling it just KEYBOARD_DAVINCI in honor of this
> > being the first DaVinci keypad driver in drivers/input/keyboard?
> > Also, in the hope that this will get reused on a future DaVinci.
> >
> > Unless, there is something that makes it really DM365 specific..
> [MA] It is better keep it specific since that symbols refers to a driver which
> is DM365 specific at the moment.

Okay. There is no device which reuses the keyscan module at
present, but there has been a lot of IP reuse in the DaVinci
family before (emac, mmc/sd, i2c, spi etc.).

> >
> >> +     tristate "TI DaVinci DM365 Keypad"
> >> +     depends on ARCH_DAVINCI_DM365
> >> +     help
> >> +      Supports the keypad module on the DM365
> >> +
> >>  endif
> >
> > [...]
> >
> >> diff --git a/drivers/input/keyboard/davinci_dm365_keypad.c b/drivers/input/keyboard/davinci_dm365_keypad.c
> >> new file mode 100644
> >> index 0000000..5db8eed
> >> --- /dev/null
> >> +++ b/drivers/input/keyboard/davinci_dm365_keypad.c
> >> @@ -0,0 +1,331 @@
> >> +/*
> >> + * DaVinci DM365 Keypad Driver
> >> + *
> >> + * Copyright (C) 2009 Texas Instruments, Inc
> >> + *
> >> + * Author: Miguel Aguilar <miguel.aguilar@ridgerun.com>
> >> + *
> >> + * Intial Code: Sandeep Paulraj <s-paulraj@ti.com>
> >> + *
> >> + * This program is free software; you can redistribute it and/or modify
> >> + * it under the terms of the GNU General Public License as published by
> >> + * the Free Software Foundation; either version 2 of the License, or
> >> + * (at your option) any later version.
> >> + *
> >> + * This program is distributed in the hope that it will be useful,
> >> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> >> + * GNU General Public License for more details.
> >> + *
> >> + * You should have received a copy of the GNU General Public License
> >> + * along with this program; if not, write to the Free Software
> >> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
> >> + */
> >> +#include <linux/module.h>
> >> +#include <linux/init.h>
> >> +#include <linux/interrupt.h>
> >> +#include <linux/types.h>
> >> +#include <linux/input.h>
> >> +#include <linux/kernel.h>
> >> +#include <linux/delay.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/errno.h>
> >> +
> >> +#include <asm/irq.h>
> >> +
> >> +#include <mach/hardware.h>
> >> +#include <mach/irqs.h>
> >> +#include <mach/keypad.h>
> >> +
> >> +/* Keypad registers */
> >> +#define DM365_KEYPAD_KEYCTRL         0x0000
> >
> > There are many places in the driver (functions, macros) which
> > probably can just be called DAVINCI_ instead of DM365_
> [MA]Again, these are DM365 specific definitions, If your proposal is to make
> this driver generic to Davinci instead of DM365 specific, I should get rid of
> all dm365 labels, messages, function names, etc in this driver, even the
> driver's name should be davinci_keypad instead of dm365_keypad, so in that sense
> not only the macros and the config symbol should be changed; but for doing that
> we are assuming that future chips of the Davinci family will include the same
> keypad module, so they would be compatible among them to use the same driver.

Yes, typically attempt is made to reuse the IP as-is.
Slight changes in the IPs re-used have previously been
taken care use a "version" field coming from the platform
data.

The product number population below seems to be a bigger
sore than the variable/macro/Kconfig naming.

> >> +static irqreturn_t dm365_kp_interrupt(int irq, void *dev_id)
> >> +{
> >> +     int i;
> >> +     u32 prev_status, new_status, changed;
> >> +     int keycode = KEY_UNKNOWN;
> >> +     struct davinci_kp *dm365_kp = dev_id;
> >> +     int *keymap = dm365_kp->pdata->keymap;
> >> +     u32 keymapsize = dm365_kp->pdata->keymapsize;
> >> +     struct device *dev = &dm365_kp->input->dev;
> >> +
> >> +     /* Disable interrupt */
> >> +     dm365_kp_write(dm365_kp, 0x0, DM365_KEYPAD_INTENA);
> >> +
> >> +     /* Reading previous and new status of the keypad */
> >> +     prev_status = dm365_kp_read(dm365_kp, DM365_KEYPAD_PREVSTATE);
> >> +     new_status = dm365_kp_read(dm365_kp, DM365_KEYPAD_CURRENTST);
> >> +
> >> +     changed = prev_status ^ new_status;
> >> +
> >> +     for (i = 0; i < keymapsize; i++) {
> >> +             if ((changed >> i) & 0x1) {
> >
> > Using ffs(changed) will probably lead to a faster ISR, especially
> > because only one key would have changed in most cases.
> [MA] OK, I will try ffs.
> >
> >> +                     keycode = keymap[i];
> >> +                     if((new_status >> i) & 0x1) {
> >> +                             /* Report release */
> >> +                             input_report_key(dm365_kp->input, keycode, 0);
> >> +                             input_sync(dm365_kp->input);
> >> +                             dev_dbg(dev, "dm365_keypad: key %d released\n",
> >> +                                             keycode);
> >> +                     } else {
> >> +                             /* Report press */
> >> +                             input_report_key(dm365_kp->input, keycode, 1);
> >> +                             input_sync(dm365_kp->input);
> >> +                             dev_dbg(dev, "dm365_keypad: key %d pressed\n",
> >> +                                             keycode);
> >> +                     }
> >> +             }
> >> +     }
> >> +
> >> +     /* Clearing interrupt */
> >> +     dm365_kp_write(dm365_kp, DM365_KEYPAD_INT_ALL, DM365_KEYPAD_INTCLR);
> >> +
> >> +     /* Enable interrupts */
> >> +     dm365_kp_write(dm365_kp, 0x1, DM365_KEYPAD_INTENA);
> >> +
> >> +     return IRQ_HANDLED;

I missed this before, if the loop above turns up nothing,
then the IRQ was not handled. IRQ_NONE will be a better return
in that case.

[...]

> >> +     dm365_kp->irq = platform_get_irq(pdev, 0);
> >> +     if (dm365_kp->irq <= 0) {
> >> +             dev_err(dev, "%s: No DM365 Keypad irq\n", pdev->name);
> >> +             ret = dm365_kp->irq;
> >
> > Probe will return success when dm365_kp->irq is 0, but you actually
> > want a failure.
> [MA] What is the proper error code for this case?.

platform_get_irq() returns an error which should be propagated. The
question is: Why is 0 not a valid IRQ number for keyscan module?

Thanks,
Sekhar


From: Miguel Aguilar <miguel.aguilar@ridgerun.com>
Subject: Re: [PATCH v3 1/2] Input: Add DaVinci DM365 Keypad support
Date: Fri, 18 Sep 2009 08:32:32 -0600
Message-ID: <4AB39A00.8080405@ridgerun.com>
References: <1253217996-11548-1-git-send-email-miguel.aguilar@ridgerun.com> <B85A65D85D7EB246BE421B3FB0FBB59301DD916A60@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.navvo.net ([74.208.67.6]:36341 "EHLO mail.navvo.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752970AbZIROcf (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Sep 2009 10:32:35 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DD916A60@dbde02.ent.ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Nori, Sekhar" <nsekhar@ti.com>
Cc: "Narnakaje, Snehaprabha" <nsnehaprabha@ti.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "santiago.nunez@ridgerun.com" <santiago.nunez@ridgerun.com>, "todd.fischer@ridgerun.com" <todd.fischer@ridgerun.com>, "clark.becker@ridgerun.com" <clark.becker@ridgerun.com>

Sekhar,

See the comments below.

Nori, Sekhar wrote:
> On Fri, Sep 18, 2009 at 01:36:36, miguel.aguilar@ridgerun.com wrote:
>> From: Miguel Aguilar <miguel.aguilar@ridgerun.com>
>>
>> Adds the driver for enabling keypad support on DM365 platform.
>>
>> This driver was tested on DM365 EVM rev c.
>>
>> Signed-off-by: Miguel Aguilar <miguel.aguilar@ridgerun.com>
>> ---
> 
> [...]
> 
>> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
>> index a6b989a..08ed7d4 100644
>> --- a/drivers/input/keyboard/Kconfig
>> +++ b/drivers/input/keyboard/Kconfig
>> @@ -361,4 +361,10 @@ config KEYBOARD_XTKBD
>>         To compile this driver as a module, choose M here: the
>>         module will be called xtkbd.
>>
>> +config KEYBOARD_DAVINCI_DM365
> 
> How about calling it just KEYBOARD_DAVINCI in honor of this
> being the first DaVinci keypad driver in drivers/input/keyboard?
> Also, in the hope that this will get reused on a future DaVinci.
> 
> Unless, there is something that makes it really DM365 specific..
[MA] It is better keep it specific since that symbols refers to a driver which 
is DM365 specific at the moment.
> 
>> +     tristate "TI DaVinci DM365 Keypad"
>> +     depends on ARCH_DAVINCI_DM365
>> +     help
>> +      Supports the keypad module on the DM365
>> +
>>  endif
> 
> [...]
> 
>> diff --git a/drivers/input/keyboard/davinci_dm365_keypad.c b/drivers/input/keyboard/davinci_dm365_keypad.c
>> new file mode 100644
>> index 0000000..5db8eed
>> --- /dev/null
>> +++ b/drivers/input/keyboard/davinci_dm365_keypad.c
>> @@ -0,0 +1,331 @@
>> +/*
>> + * DaVinci DM365 Keypad Driver
>> + *
>> + * Copyright (C) 2009 Texas Instruments, Inc
>> + *
>> + * Author: Miguel Aguilar <miguel.aguilar@ridgerun.com>
>> + *
>> + * Intial Code: Sandeep Paulraj <s-paulraj@ti.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
>> + */
>> +#include <linux/module.h>
>> +#include <linux/init.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/types.h>
>> +#include <linux/input.h>
>> +#include <linux/kernel.h>
>> +#include <linux/delay.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/errno.h>
>> +
>> +#include <asm/irq.h>
>> +
>> +#include <mach/hardware.h>
>> +#include <mach/irqs.h>
>> +#include <mach/keypad.h>
>> +
>> +/* Keypad registers */
>> +#define DM365_KEYPAD_KEYCTRL         0x0000
> 
> There are many places in the driver (functions, macros) which
> probably can just be called DAVINCI_ instead of DM365_
[MA]Again, these are DM365 specific definitions, If your proposal is to make 
this driver generic to Davinci instead of DM365 specific, I should get rid of 
all dm365 labels, messages, function names, etc in this driver, even the 
driver's name should be davinci_keypad instead of dm365_keypad, so in that sense 
not only the macros and the config symbol should be changed; but for doing that 
we are assuming that future chips of the Davinci family will include the same 
keypad module, so they would be compatible among them to use the same driver.
> 
>> +#define DM365_KEYPAD_INTENA          0x0004
>> +#define DM365_KEYPAD_INTFLAG         0x0008
>> +#define DM365_KEYPAD_INTCLR          0x000c
>> +#define DM365_KEYPAD_STRBWIDTH               0x0010
>> +#define DM365_KEYPAD_INTERVAL                0x0014
>> +#define DM365_KEYPAD_CONTTIME                0x0018
>> +#define DM365_KEYPAD_CURRENTST               0x001c
>> +#define DM365_KEYPAD_PREVSTATE               0x0020
>> +#define DM365_KEYPAD_EMUCTRL         0x0024
>> +#define DM365_KEYPAD_IODFTCTRL               0x002c
>> +
>> +/* Key Control Register (KEYCTRL) */
>> +#define DM365_KEYPAD_KEYEN           0x00000001
>> +#define DM365_KEYPAD_PREVMODE                0x00000002
>> +#define DM365_KEYPAD_CHATOFF         0x00000004
>> +#define DM365_KEYPAD_AUTODET         0x00000008
>> +#define DM365_KEYPAD_SCANMODE                0x00000010
>> +#define DM365_KEYPAD_OUTTYPE         0x00000020
>> +#define DM365_KEYPAD_4X4             0x00000040
>> +
>> +/* Masks for the interrupts */
>> +#define DM365_KEYPAD_INT_CONT                0x00000008
>> +#define DM365_KEYPAD_INT_OFF         0x00000004
>> +#define DM365_KEYPAD_INT_ON          0x00000002
>> +#define DM365_KEYPAD_INT_CHANGE              0x00000001
>> +#define DM365_KEYPAD_INT_ALL         0x0000000f
>> +
>> +struct davinci_kp {
>> +     struct input_dev                *input;
>> +     struct davinci_kp_platform_data *pdata;
>> +     int                             irq;
>> +     void __iomem                    *base;
>> +     resource_size_t                 pbase;
>> +     size_t                          base_size;
>> +};
>> +
>> +static void dm365_kp_write(struct davinci_kp *dm365_kp, u32 val, u32 addr)
>> +{
>> +     u32 base = (u32)dm365_kp->base;
>> +
>> +     __raw_writel(val,(u32 *)(base + addr));
>> +}
>> +
>> +static u32 dm365_kp_read(struct davinci_kp *dm365_kp, u32 addr)
>> +{
>> +     u32 base = (u32)dm365_kp->base;
>> +
>> +     return __raw_readl((u32 *)(base + addr));
>> +}
>> +
>> +/* Initializing the kp Module */
>> +static void dm365_kp_initialize(struct davinci_kp *dm365_kp)
>> +{
>> +     u32 strobe = dm365_kp->pdata->strobe;
>> +     u32 interval = dm365_kp->pdata->interval;
>> +
>> +     /* Enable all interrupts */
>> +     dm365_kp_write(dm365_kp, DM365_KEYPAD_INT_ALL, DM365_KEYPAD_INTENA);
>> +
>> +     /* Clear interrupts if any */
>> +     dm365_kp_write(dm365_kp, DM365_KEYPAD_INT_ALL, DM365_KEYPAD_INTCLR);
>> +
>> +     /* Setup the scan period = strobe + interval */
>> +     dm365_kp_write(dm365_kp, strobe, DM365_KEYPAD_STRBWIDTH);
>> +     dm365_kp_write(dm365_kp, interval, DM365_KEYPAD_INTERVAL);
>> +     dm365_kp_write(dm365_kp, 0x01, DM365_KEYPAD_CONTTIME);
>> +
>> +     /* Enable Keyscan module and enable */
>> +     dm365_kp_write(dm365_kp, DM365_KEYPAD_AUTODET | DM365_KEYPAD_KEYEN,
>> +                     DM365_KEYPAD_KEYCTRL);
>> +}
>> +
>> +static irqreturn_t dm365_kp_interrupt(int irq, void *dev_id)
>> +{
>> +     int i;
>> +     u32 prev_status, new_status, changed;
>> +     int keycode = KEY_UNKNOWN;
>> +     struct davinci_kp *dm365_kp = dev_id;
>> +     int *keymap = dm365_kp->pdata->keymap;
>> +     u32 keymapsize = dm365_kp->pdata->keymapsize;
>> +     struct device *dev = &dm365_kp->input->dev;
>> +
>> +     /* Disable interrupt */
>> +     dm365_kp_write(dm365_kp, 0x0, DM365_KEYPAD_INTENA);
>> +
>> +     /* Reading previous and new status of the keypad */
>> +     prev_status = dm365_kp_read(dm365_kp, DM365_KEYPAD_PREVSTATE);
>> +     new_status = dm365_kp_read(dm365_kp, DM365_KEYPAD_CURRENTST);
>> +
>> +     changed = prev_status ^ new_status;
>> +
>> +     for (i = 0; i < keymapsize; i++) {
>> +             if ((changed >> i) & 0x1) {
> 
> Using ffs(changed) will probably lead to a faster ISR, especially
> because only one key would have changed in most cases.
[MA] OK, I will try ffs.
> 
>> +                     keycode = keymap[i];
>> +                     if((new_status >> i) & 0x1) {
>> +                             /* Report release */
>> +                             input_report_key(dm365_kp->input, keycode, 0);
>> +                             input_sync(dm365_kp->input);
>> +                             dev_dbg(dev, "dm365_keypad: key %d released\n",
>> +                                             keycode);
>> +                     } else {
>> +                             /* Report press */
>> +                             input_report_key(dm365_kp->input, keycode, 1);
>> +                             input_sync(dm365_kp->input);
>> +                             dev_dbg(dev, "dm365_keypad: key %d pressed\n",
>> +                                             keycode);
>> +                     }
>> +             }
>> +     }
>> +
>> +     /* Clearing interrupt */
>> +     dm365_kp_write(dm365_kp, DM365_KEYPAD_INT_ALL, DM365_KEYPAD_INTCLR);
>> +
>> +     /* Enable interrupts */
>> +     dm365_kp_write(dm365_kp, 0x1, DM365_KEYPAD_INTENA);
>> +
>> +     return IRQ_HANDLED;
>> +}
>> +
>> +/*
>> + * Registers keypad device with input sub system and configures
>> + * DM365 keypad registers
>> + */
>> +static int dm365_kp_probe(struct platform_device *pdev)
> 
> This should be __init function.
[MA] OK
> 
>> +{
>> +     struct davinci_kp *dm365_kp;
>> +     struct input_dev *key_dev;
>> +     struct resource *res, *mem;
>> +     int ret, i;
>> +     struct device * dev = &pdev->dev;
>> +     struct davinci_kp_platform_data *pdata = pdev->dev.platform_data;
>> +
>> +     dev_info(dev, "DaVinci DM365 Keypad Driver\n");
>> +
>> +     if (!pdata->keymap) {
>> +             dev_dbg(dev, "%s: No keymap from pdata\n", pdev->name);
>> +             return -EINVAL;
>> +     }
>> +
>> +     dm365_kp = kzalloc(sizeof *dm365_kp, GFP_KERNEL);
>> +     if(!dm365_kp) {
>> +             dev_dbg(dev, "%s: Could not allocate memory for private data\n",
>> +                     pdev->name);
>> +             return -ENOMEM;
>> +     }
>> +
>> +     key_dev = input_allocate_device();
>> +     if (!key_dev) {
>> +             dev_dbg(dev, "%s: Could not allocate input device\n",
>> +                     pdev->name);
>> +             ret = -ENOMEM;
>> +             goto fail1;
>> +     }
>> +
>> +     platform_set_drvdata(pdev, dm365_kp);
>> +
>> +     dm365_kp->input = key_dev;
>> +
>> +     dm365_kp->irq = platform_get_irq(pdev, 0);
>> +     if (dm365_kp->irq <= 0) {
>> +             dev_err(dev, "%s: No DM365 Keypad irq\n", pdev->name);
>> +             ret = dm365_kp->irq;
> 
> Probe will return success when dm365_kp->irq is 0, but you actually
> want a failure.
[MA] What is the proper error code for this case?.
> 
>> +             goto fail2;
>> +     }
>> +
> 
> [...]
> 
>> +     key_dev->name = "dm365_keypad";
>> +     key_dev->phys = "dm365_keypad/input0";
> ...
>> +     key_dev->id.vendor = 0x0001;
>> +     key_dev->id.product = 0x0365;
> 
> These initializations seem to make the driver's use on future SoCs
> a little uncomfortable..
> 
>> +     key_dev->id.version = 0x0001;
>> +     key_dev->keycode = dm365_kp->pdata->keymap;
>> +     key_dev->keycodesize = sizeof(unsigned int);
>> +     key_dev->keycodemax = dm365_kp->pdata->keymapsize;
>> +
>> +     ret = input_register_device(dm365_kp->input);
>> +     if (ret < 0) {
>> +             dev_err(dev, "%s: Unable to register DaVinci DM365 keypad device\n",
> 
> Can avoid hard coding "DM365" in error messages too...
[MA] Same issue about DM365 specific driver.
> 
>> +                     pdev->name);
>> +             goto fail4;
>> +     }
>> +
>> +     ret = request_irq(dm365_kp->irq, dm365_kp_interrupt, IRQF_DISABLED,
>> +                         "dm365_keypad", dm365_kp);
>> +     if (ret < 0) {
>> +             dev_err(dev, "%s: Unable to register DaVinci DM365 keypad Interrupt\n",
>> +                     pdev->name);
>> +             goto fail5;
>> +     }
>> +
>> +     dm365_kp_initialize(dm365_kp);
>> +
>> +     return 0;
>> +fail5:
>> +     input_unregister_device(dm365_kp->input);
>> +     key_dev = NULL;
>> +fail4:
>> +     iounmap(dm365_kp->base);
>> +fail3:
>> +     release_mem_region(dm365_kp->pbase, dm365_kp->base_size);
>> +fail2:
>> +     input_free_device(key_dev);
>> +fail1:
>> +     kfree(dm365_kp);
>> +
>> +     return ret;
>> +}
>> +
>> +static int __exit dm365_kp_remove(struct platform_device *pdev)
>> +{
>> +     struct davinci_kp *dm365_kp = platform_get_drvdata(pdev);
>> +
>> +     free_irq(dm365_kp->irq, dm365_kp);
>> +
>> +     iounmap(dm365_kp->base);
>> +     release_mem_region(dm365_kp->pbase, dm365_kp->base_size);
>> +
>> +     platform_set_drvdata(pdev, NULL);
>> +
>> +     input_unregister_device(dm365_kp->input);
> 
> It would be nice to see the remove happen in reverse order of probe,
> ie. unregister device first and unmap memory later.
[MA] Yes, it was supposed to be in the reverse order however it seem that 
unregister device is not after free irq and before iounmap.
> 
>> +
>> +     kfree(dm365_kp);
>> +
>> +     return 0;
>> +}
>> +
>> +static struct platform_driver dm365_kp_driver = {
>> +     .driver = {
>> +                     .name = "dm365_keypad",
>> +                     .owner = THIS_MODULE,
>> +             },
>> +     .remove = __exit_p(dm365_kp_remove),
>> +};
>> +
>> +static int __init dm365_kp_init(void)
>> +{
>> +
>> +
> 
> Extra lines here.
[MA] Typo!
> 
>> +     return platform_driver_probe(&dm365_kp_driver, dm365_kp_probe);
>> +}
>> +module_init(dm365_kp_init);
>> +
>> +static void __exit dm365_kp_exit(void)
>> +{
>> +     platform_driver_unregister(&dm365_kp_driver);
>> +}
>> +module_exit(dm365_kp_exit);
>> +
>> +MODULE_AUTHOR("Miguel Aguilar");
>> +MODULE_DESCRIPTION("Texas Instruments DaVinci DM365 EVM Keypad Driver");
> 
> The driver is definitely not specific to the EVM.
[MA] Typo!
> 
> Thanks,
> Sekhar


Thanks,

Miguel Aguilar

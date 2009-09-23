From: Miguel Aguilar <miguel.aguilar@ridgerun.com>
Subject: Re: [PATCH 1/2] Input: DaVinci Keypad Driver
Date: Wed, 23 Sep 2009 08:52:40 -0600
Message-ID: <4ABA3638.5070609@ridgerun.com>
References: <1253654850-11983-1-git-send-email-miguel.aguilar@ridgerun.com> <20090923034643.GB1458@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.navvo.net ([74.208.67.6]:53964 "EHLO mail.navvo.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751782AbZIWOwk (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Sep 2009 10:52:40 -0400
In-Reply-To: <20090923034643.GB1458@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: nsnehaprabha@ti.com, davinci-linux-open-source@linux.davincidsp.com, linux-input@vger.kernel.org, todd.fischer@ridgerun.com, diego.dompe@ridgerun.com, clark.becker@ridgerun.com, santiago.nunez@ridgerun.com

Dmitry,

Dmitry Torokhov wrote:
> Hi Miguel,
> 
> On Tue, Sep 22, 2009 at 03:27:30PM -0600, miguel.aguilar@ridgerun.com wrote:
>> From: Miguel Aguilar <miguel.aguilar@ridgerun.com>
>>
>> Adds the driver for enabling keypad support for DaVinci platforms.
>>
>> DM365 is the only platform that uses this driver at the moment.
>>
>> This driver was tested on DM365 EVM rev C.
>>
>> Signed-off-by: Miguel Aguilar <miguel.aguilar@ridgerun.com>
>> ---
>>  arch/arm/configs/davinci_all_defconfig      |    1 +
>>  arch/arm/mach-davinci/include/mach/keypad.h |   35 +++
>>  drivers/input/keyboard/Kconfig              |    7 +
>>  drivers/input/keyboard/Makefile             |    1 +
>>  drivers/input/keyboard/davinci_keypad.c     |  319 +++++++++++++++++++++++++++
>>  5 files changed, 363 insertions(+), 0 deletions(-)
>>  create mode 100644 arch/arm/mach-davinci/include/mach/keypad.h
>>  create mode 100644 drivers/input/keyboard/davinci_keypad.c
>>
>> diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
>> index ec63c15..e994c83 100644
>> --- a/arch/arm/configs/davinci_all_defconfig
>> +++ b/arch/arm/configs/davinci_all_defconfig
>> @@ -763,6 +763,7 @@ CONFIG_KEYBOARD_GPIO=y
>>  # CONFIG_KEYBOARD_STOWAWAY is not set
>>  # CONFIG_KEYBOARD_SUNKBD is not set
>>  CONFIG_KEYBOARD_XTKBD=m
>> +CONFIG_KEYBOARD_DAVINCI_DM365=m
>>  # CONFIG_INPUT_MOUSE is not set
>>  # CONFIG_INPUT_JOYSTICK is not set
>>  # CONFIG_INPUT_TABLET is not set
> 
> 
> If you want to merge the driver through input tree the defconfig chunk
> has to go elsewhere.
[MA] So, Where it should go?
> 
>> diff --git a/arch/arm/mach-davinci/include/mach/keypad.h b/arch/arm/mach-davinci/include/mach/keypad.h
>> new file mode 100644
>> index 0000000..922d20e
>> --- /dev/null
>> +++ b/arch/arm/mach-davinci/include/mach/keypad.h
>> @@ -0,0 +1,35 @@
>> +/*
>> + * Copyright (C) 2009 Texas Instruments, Inc
>> + *
>> + * Author: Miguel Aguilar <miguel.aguilar@ridgerun.com>
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
>> +
>> +#ifndef DAVINCI_KEYPAD_H
>> +#define DAVINCI_KEYPAD_H
>> +
>> +#include <linux/io.h>
>> +
>> +struct davinci_kp_platform_data {
>> +	int	*keymap;
>> +	u32	keymapsize;
>> +	u32	rep:1;
>> +	u32	strobe;
>> +	u32	interval;
>> +};
>> +
>> +#endif
>> +
>> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
>> index a6b989a..b6b9517 100644
>> --- a/drivers/input/keyboard/Kconfig
>> +++ b/drivers/input/keyboard/Kconfig
>> @@ -361,4 +361,11 @@ config KEYBOARD_XTKBD
>>  	  To compile this driver as a module, choose M here: the
>>  	  module will be called xtkbd.
>>  
>> +config KEYBOARD_DAVINCI
>> +	tristate "TI DaVinci Keypad"
>> +	depends on ARCH_DAVINCI_DM365
>> +	help
>> +	  Say Y to enable keypad module support for the TI DaVinci
>> +	  platforms (DM365)
>> +
> 
> "To compile this driver as a module..."
[MA] Ok.
> 
>>  endif
>> diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
>> index b5b5eae..0b0274e 100644
>> --- a/drivers/input/keyboard/Makefile
>> +++ b/drivers/input/keyboard/Makefile
>> @@ -31,3 +31,4 @@ obj-$(CONFIG_KEYBOARD_STOWAWAY)		+= stowaway.o
>>  obj-$(CONFIG_KEYBOARD_SUNKBD)		+= sunkbd.o
>>  obj-$(CONFIG_KEYBOARD_TOSA)		+= tosakbd.o
>>  obj-$(CONFIG_KEYBOARD_XTKBD)		+= xtkbd.o
>> +obj-$(CONFIG_KEYBOARD_DAVINCI)		+= davinci_keypad.o
>> diff --git a/drivers/input/keyboard/davinci_keypad.c b/drivers/input/keyboard/davinci_keypad.c
>> new file mode 100644
>> index 0000000..6f0e793
>> --- /dev/null
>> +++ b/drivers/input/keyboard/davinci_keypad.c
>> @@ -0,0 +1,319 @@
>> +/*
>> + * DaVinci Keypad Driver for TI platforms
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
>> +#define DAVINCI_KEYPAD_KEYCTRL		0x0000
>> +#define DAVINCI_KEYPAD_INTENA		0x0004
>> +#define DAVINCI_KEYPAD_INTFLAG		0x0008
>> +#define DAVINCI_KEYPAD_INTCLR		0x000c
>> +#define DAVINCI_KEYPAD_STRBWIDTH	0x0010
>> +#define DAVINCI_KEYPAD_INTERVAL		0x0014
>> +#define DAVINCI_KEYPAD_CONTTIME		0x0018
>> +#define DAVINCI_KEYPAD_CURRENTST	0x001c
>> +#define DAVINCI_KEYPAD_PREVSTATE	0x0020
>> +#define DAVINCI_KEYPAD_EMUCTRL		0x0024
>> +#define DAVINCI_KEYPAD_IODFTCTRL	0x002c
>> +
>> +/* Key Control Register (KEYCTRL) */
>> +#define DAVINCI_KEYPAD_KEYEN		0x00000001
>> +#define DAVINCI_KEYPAD_PREVMODE		0x00000002
>> +#define DAVINCI_KEYPAD_CHATOFF		0x00000004
>> +#define DAVINCI_KEYPAD_AUTODET		0x00000008
>> +#define DAVINCI_KEYPAD_SCANMODE		0x00000010
>> +#define DAVINCI_KEYPAD_OUTTYPE		0x00000020
>> +#define DAVINCI_KEYPAD_4X4		0x00000040
>> +
>> +/* Masks for the interrupts */
>> +#define DAVINCI_KEYPAD_INT_CONT		0x00000008
>> +#define DAVINCI_KEYPAD_INT_OFF		0x00000004
>> +#define DAVINCI_KEYPAD_INT_ON		0x00000002
>> +#define DAVINCI_KEYPAD_INT_CHANGE	0x00000001
>> +#define DAVINCI_KEYPAD_INT_ALL		0x0000000f
>> +
>> +struct davinci_kp {
>> +	struct input_dev		*input;
>> +	struct davinci_kp_platform_data	*pdata;
>> +	int				irq;
>> +	void __iomem			*base;
>> +	resource_size_t			pbase;
>> +	size_t				base_size;
>> +};
>> +
>> +static void davinci_kp_write(struct davinci_kp *davinci_kp, u32 val, u32 addr)
>> +{
>> +	u32 base = (u32)davinci_kp->base;
>> +
>> +	__raw_writel(val,(u32 *)(base + addr));
>> +}
>> +
>> +static u32 davinci_kp_read(struct davinci_kp *davinci_kp, u32 addr)
>> +{
>> +	u32 base = (u32)davinci_kp->base;
>> +
>> +	return __raw_readl((u32 *)(base + addr));
>> +}
>> +
>> +/* Initializing the kp Module */
>> +static void davinci_kp_initialize(struct davinci_kp *davinci_kp)
>> +{
>> +	u32 strobe = davinci_kp->pdata->strobe;
>> +	u32 interval = davinci_kp->pdata->interval;
>> +
>> +	/* Enable all interrupts */
>> +	davinci_kp_write(davinci_kp, DAVINCI_KEYPAD_INT_ALL, DAVINCI_KEYPAD_INTENA);
>> +
>> +	/* Clear interrupts if any */
>> +	davinci_kp_write(davinci_kp, DAVINCI_KEYPAD_INT_ALL, DAVINCI_KEYPAD_INTCLR);
>> +
>> +	/* Setup the scan period = strobe + interval */
>> +	davinci_kp_write(davinci_kp, strobe, DAVINCI_KEYPAD_STRBWIDTH);
>> +	davinci_kp_write(davinci_kp, interval, DAVINCI_KEYPAD_INTERVAL);
>> +	davinci_kp_write(davinci_kp, 0x01, DAVINCI_KEYPAD_CONTTIME);
>> +
>> +	/* Enable Keyscan module and enable */
>> +	davinci_kp_write(davinci_kp, DAVINCI_KEYPAD_AUTODET | DAVINCI_KEYPAD_KEYEN,
>> +			DAVINCI_KEYPAD_KEYCTRL);
>> +}
>> +
>> +static irqreturn_t davinci_kp_interrupt(int irq, void *dev_id)
>> +{
>> +	struct davinci_kp *davinci_kp = dev_id;
>> +	struct device *dev = &davinci_kp->input->dev;
>> +	int *keymap = davinci_kp->pdata->keymap;
>> +		u32 prev_status, new_status, changed, position;
>> +	int keycode = KEY_UNKNOWN;
>> +	int ret = IRQ_NONE;
>> +
>> +	/* Disable interrupt */
>> +	davinci_kp_write(davinci_kp, 0x0, DAVINCI_KEYPAD_INTENA);
>> +
>> +	/* Reading previous and new status of the keypad */
>> +	prev_status = davinci_kp_read(davinci_kp, DAVINCI_KEYPAD_PREVSTATE);
>> +	new_status = davinci_kp_read(davinci_kp, DAVINCI_KEYPAD_CURRENTST);
>> +
>> +	changed = prev_status ^ new_status;
>> +	position = ffs(changed) - 1;
>> +
>> +	if (changed) {
> 
> Can there be several buttons that change status at once?
[MA] It is not suppose to change several buttons at once.
> 
>> +		keycode = keymap[position];
>> +		if((new_status >> position) & 0x1) {
> 
> bool release = (new_status >> position) & 0x1;
> input_report_key(davinci_kp->input, keycode, !release);
> dev_dbg(dev, "davinci_keypad: key %d %s\n",
> 	keycode, release ? "released" : "pressed");
> 
[MA] Ok I'll try that.
> is shorter.
> 
>> +			/* Report release */
>> +			dev_dbg(dev, "davinci_keypad: key %d released\n",
>> +				    keycode);
>> +			input_report_key(davinci_kp->input, keycode, 0);
>> +		} else {
>> +			/* Report press */
>> +			dev_dbg(dev, "davinci_keypad: key %d pressed\n",
>> +				    keycode);
>> +			input_report_key(davinci_kp->input, keycode, 1);
>> +		}
>> +		input_sync(davinci_kp->input);
>> +		ret = IRQ_HANDLED;
>> +	}
>> +
>> +	/* Clearing interrupt */
>> +	davinci_kp_write(davinci_kp, DAVINCI_KEYPAD_INT_ALL, DAVINCI_KEYPAD_INTCLR);
> 
> You return IRQ_HANDLED only if keypad state changed but clear interrupt
> regardless. This is suspicious.
[MA] Ok. I'll clear the irq status only if IRQ_HANDLED.
> 
>> +
>> +	/* Enable interrupts */
>> +	davinci_kp_write(davinci_kp, 0x1, DAVINCI_KEYPAD_INTENA);
>> +
>> +	return ret;
>> +}
>> +
>> +static int __init davinci_kp_probe(struct platform_device *pdev)
>> +{
>> +	struct davinci_kp *davinci_kp;
>> +	struct input_dev *key_dev;
>> +	struct resource *res, *mem;
>> +	int ret, i;
>> +	struct device * dev = &pdev->dev;
>> +	struct davinci_kp_platform_data *pdata = pdev->dev.platform_data;
>> +
>> +	dev_info(dev, "DaVinci Keypad Driver\n");
>> +
>> +	if (!pdata->keymap) {
>> +		dev_dbg(dev, "no keymap from pdata\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	davinci_kp = kzalloc(sizeof *davinci_kp, GFP_KERNEL);
>> +	if(!davinci_kp) {
>> +		dev_dbg(dev, "could not allocate memory for private data\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	key_dev = input_allocate_device();
>> +	if (!key_dev) {
>> +		dev_dbg(dev, "could not allocate input device\n");
>> +		ret = -ENOMEM;
>> +		goto fail1;
>> +	}
>> +
>> +	platform_set_drvdata(pdev, davinci_kp);
>> +
>> +	davinci_kp->input = key_dev;
>> +
>> +	davinci_kp->irq = platform_get_irq(pdev, 0);
>> +	if (davinci_kp->irq < 0) {
>> +		dev_err(dev, "no keypad irq\n");
>> +		ret = davinci_kp->irq;
>> +		goto fail2;
>> +	}
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (!res) {
>> +		dev_err(dev, "no mem resource\n");
>> +		ret = -ENODEV;
> 
> -EINVAL I'd say.
[MA] platform_get_resource should fail with -ENODEV.
> 
>> +		goto fail2;
>> +	}
>> +
>> +	davinci_kp->pbase = res->start;
>> +	davinci_kp->base_size = resource_size(res);
>> +
>> +	mem = request_mem_region(davinci_kp->pbase, davinci_kp->base_size, pdev->name);
>> +	if (!mem) {
>> +		dev_err(dev, "KEYSCAN registers at %08x are not free\n",
>> +			davinci_kp->pbase);
>> +		ret = -EBUSY;
>> +		goto fail2;
>> +	}
>> +
>> +	davinci_kp->base = ioremap(davinci_kp->pbase, davinci_kp->base_size);
>> +	if (!davinci_kp->base) {
>> +		dev_err(dev, "can't ioremap MEM resource.\n");
>> +		ret = -ENOMEM;
>> +		goto fail3;
>> +	}
>> +
>> +	/* Enable auto repeat feature of Linux input subsystem */
>> +	if (pdata->rep)
>> +		__set_bit(EV_REP, key_dev->evbit);
>> +
>> +	/* Setup input device */
>> +	__set_bit(EV_KEY, key_dev->evbit);
>> +
>> +	/* Setup the keymap */
>> +	davinci_kp->pdata = pdata;
>> +
>> +	for (i = 0; i < davinci_kp->pdata->keymapsize; i++)
>> +		__set_bit(davinci_kp->pdata->keymap[i], key_dev->keybit);
>> +
>> +	key_dev->name = "davinci_keypad";
>> +	key_dev->phys = "davinci_keypad/input0";
>> +	key_dev->dev.parent = &pdev->dev;
>> +	key_dev->id.bustype = BUS_HOST;
>> +	key_dev->id.vendor = 0x0001;
>> +	key_dev->id.product = 0x0001;
>> +	key_dev->id.version = 0x0001;
>> +	key_dev->keycode = davinci_kp->pdata->keymap;
> 
> Please kopy keymap into the davinci_kp stucture and use it so that
> platform data is never changed and can be declared const.
Do you mean something like this?

struct davinci_kp {
	...
	const int	*keymap;
	...
};

> 
>> +	key_dev->keycodesize = sizeof(unsigned int);
> 
> sizeof(davinci_kp->keymap[0]) is safer. Plus make it unsigned short.
[MA] Ok.
> 
>> +	key_dev->keycodemax = davinci_kp->pdata->keymapsize;
>> +
>> +	ret = input_register_device(davinci_kp->input);
>> +	if (ret < 0) {
>> +		dev_err(dev, "unable to register DaVinci keypad device\n");
>> +		goto fail4;
>> +	}
>> +
>> +	ret = request_irq(davinci_kp->irq, davinci_kp_interrupt, IRQF_DISABLED,
>> +                         "davinci_keypad", davinci_kp);
>> +	if (ret < 0) {
>> +		dev_err(dev, "unable to register DaVinci keypad Interrupt\n");
>> +		goto fail5;
>> +	}
>> +
>> +	davinci_kp_initialize(davinci_kp);
>> +
>> +	return 0;
>> +fail5:
>> +	input_unregister_device(davinci_kp->input);
>> +	key_dev = NULL;
>> +fail4:
>> +	iounmap(davinci_kp->base);
>> +fail3:
>> +	release_mem_region(davinci_kp->pbase, davinci_kp->base_size);
>> +fail2:
>> +	input_free_device(key_dev);
>> +fail1:
>> +	kfree(davinci_kp);
>> +
>> +	return ret;
>> +}
>> +
>> +static int __exit davinci_kp_remove(struct platform_device *pdev)
> 
> __devexit?
[MA] According to comments from David Brownell to the first version of this 
patch the __exit should be used.

" - Use platform_driver_probe() and __exit/__exit_p();
    there's no point in keeping that code around in
    typical configs, it'd just waste memory. "

> 
>> +{
>> +	struct davinci_kp *davinci_kp = platform_get_drvdata(pdev);
>> +
>> +	free_irq(davinci_kp->irq, davinci_kp);
>> +
>> +	input_unregister_device(davinci_kp->input);
>> +
>> +	iounmap(davinci_kp->base);
>> +	release_mem_region(davinci_kp->pbase, davinci_kp->base_size);
>> +
>> +	platform_set_drvdata(pdev, NULL);
>> +
>> +	kfree(davinci_kp);
>> +
>> +	return 0;
>> +}
>> +
>> +static struct platform_driver davinci_kp_driver = {
>> +	.driver = {
>> +			.name = "davinci_keypad",
>> +			.owner = THIS_MODULE,
>> +		},
>> +	.remove = __exit_p(davinci_kp_remove),
> 
> __devexit_p(). I think you can still unbind the device even if you use
> platform_driver_probe.
[MA] Same.
> 
>> +};
>> +
>> +static int __init davinci_kp_init(void)
>> +{
>> +	return platform_driver_probe(&davinci_kp_driver, davinci_kp_probe);
>> +}
>> +module_init(davinci_kp_init);
>> +
>> +static void __exit davinci_kp_exit(void)
>> +{
>> +	platform_driver_unregister(&davinci_kp_driver);
>> +}
>> +module_exit(davinci_kp_exit);
>> +
>> +MODULE_AUTHOR("Miguel Aguilar");
>> +MODULE_DESCRIPTION("Texas Instruments DaVinci Keypad Driver");
>> +MODULE_LICENSE("GPL");
>> -- 
>> 1.6.0.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-input" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 



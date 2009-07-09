From: Wan ZongShun <mcuos.com@gmail.com>
Subject: Re: [PATCH] input: Add keypad support for w90p910 evb
Date: Thu, 09 Jul 2009 14:37:15 +0800
Message-ID: <4A55901B.6070805@gmail.com>
References: <4A546443.9030907@gmail.com> <5d5443650907080332t4156cabdu267d28c6c486f372@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.226]:48714 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751266AbZGIGh3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Jul 2009 02:37:29 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1339825rvb.5
        for <linux-input@vger.kernel.org>; Wed, 08 Jul 2009 23:37:27 -0700 (PDT)
In-Reply-To: <5d5443650907080332t4156cabdu267d28c6c486f372@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>

Dear Trilok,

Thanks for your advice, Before resubmit this new patch fixed, there are some questions need your help for clarifying, following:


> Hi Wan ZongShun,
> 
>>
>> Add keypad driver for w90p910 evb.
> 
> This commit text not sufficient to describe this driver. Please add more detail.
> 
>> +config KEYBOARD_W90P910
>> +       tristate "W90P910 Matrix Keypad support"
>> +       depends on ARCH_W90X900
>> +       help
>> +         Say Y here to enable the matrix keypad on the W90P910 evb.
> 
> EVB? Evaluation Board? If yes, please write evaluation board instead,
> and I hope it should even work with other boards designed with this
> core.
> 
>> diff --git a/drivers/input/keyboard/w90p910_keypad.c b/drivers/input/keyboard/w90p910_keypad.c
>> new file mode 100644
>> index 0000000..e8dfcc8
>> --- /dev/null
>> +++ b/drivers/input/keyboard/w90p910_keypad.c
>> @@ -0,0 +1,315 @@
>> +/*
>> + * Copyright (c) 2008 Nuvoton technology corporation.
>> + *
> 
> Want to update this to 2008-2009 ?
> 
>> + * Wan ZongShun <mcuos.com@gmail.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation;version 2 of the License.
>> + *
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/init.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/input.h>
>> +#include <linux/device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/clk.h>
>> +#include <linux/err.h>
>> +
>> +#include <asm/mach/arch.h>
>> +#include <asm/mach/map.h>
> 
> Why map.h?
> 
>> +
>> +#include <mach/hardware.h>
>> +#include <mach/w90p910_keypad.h>
>> +#include <mach/regs-clock.h>
> 
> Do you need this regs-clock.h and hardware.h?
> 
>> +
>> +/* Keypad Interface Control Registers */
>> +#define KPI_CONF               0x00
>> +#define KPI_3KCONF             0x04
>> +#define KPI_LPCONF             0x08
>> +#define KPI_STATUS             0x0C
>> +
>> +#define IS1KEY                 (0x01 << 16)
>> +#define INTTR                  (0x01 << 21)
>> +#define KEY0R                  (0x0f << 3)
>> +#define KEY0C                  0x07
>> +#define RESET                  0x00
>> +#define PRESCALE               0xfa
>> +#define DEBOUNCE               (0x50 << 8)
>> +#define KSIZE0                 (0x01 << 16)
>> +#define KSIZE1                 (0x01 << 17)
>> +#define KPSEL                  (0x01 << 19)
>> +#define ENKP                   (0x01 << 18)
>> +
>> +#define KGET_RAW(n)            (((n) & KEY0R) >> 3)
>> +#define KGET_COLUMN(n)         ((n) & KEY0C)
>> +
>> +#define keypad_readl(off)      __raw_readl(keypad->mmio_base + (off))
>> +#define keypad_writel(off, v)  __raw_writel((v), keypad->mmio_base + (off))
>> +#define res_size(res)          ((res)->end - (res)->start + 1)
>> +
> 
> Use resource_size please.
> 
>> +#define MAX_MATRIX_KEY_NUM     (8 * 8)
>> +
> 
>> +struct w90p910_keypad {
>> +       struct w90p910_keypad_platform_data *pdata;
>> +       struct clk *clk;
>> +       struct input_dev *input_dev;
>> +       void __iomem *mmio_base;
>> +       int irq;
>> +       unsigned int matrix_keycodes[MAX_MATRIX_KEY_NUM];
>> +};
>> +
>> +static void w90p910_keypad_build_keycode(struct w90p910_keypad *keypad)
>> +{
>> +       struct w90p910_keypad_platform_data *pdata = keypad->pdata;
>> +       struct input_dev *input_dev = keypad->input_dev;
>> +       unsigned int *key;
>> +       int i;
>> +
>> +       key = &pdata->matrix_key_map[0];
>> +       for (i = 0; i < pdata->matrix_key_map_size; i++, key++) {
>> +               int row = ((*key) >> 28) & 0xf;
>> +               int col = ((*key) >> 24) & 0xf;
>> +               int code = (*key) & 0xffffff;
>> +
>> +               keypad->matrix_keycodes[(row << 3) + col] = code;
>> +               set_bit(code, input_dev->keybit);
> 
> __set_bit please.
> 
>> +       }
>> +
>> +}
>> +
>> +static inline unsigned int lookup_matrix_keycode(
>> +               struct w90p910_keypad *keypad, int row, int col)
>> +{
>> +       return keypad->matrix_keycodes[(row << 3) + col];
>> +}
>> +
>> +static void w90p910_keypad_scan_matrix(struct w90p910_keypad *keypad,
>> +                                                       unsigned int status)
>> +{
>> +       unsigned int row, col, val;
>> +
>> +       row = KGET_RAW(status);
>> +       col = KGET_COLUMN(status);
>> +
>> +       val = lookup_matrix_keycode(keypad, row, col);
>> +
>> +       input_report_key(keypad->input_dev, val, 1);
>> +
>> +       input_sync(keypad->input_dev);
>> +
>> +       input_report_key(keypad->input_dev, val, 0);
> 
> So, we don't get interrupt on key release?

In w90p910,there is no way to identify whether the key was released or not,so I have to put above code here to report the key has been released.

> 
>> +
>> +       input_sync(keypad->input_dev);
>> +}
>> +
>> +static irqreturn_t w90p910_keypad_irq_handler(int irq, void *dev_id)
>> +{
>> +       struct w90p910_keypad *keypad = dev_id;
>> +       unsigned int  kstatus, val;
>> +
>> +        kstatus = keypad_readl(KPI_STATUS);
>> +
>> +       val = INTTR | IS1KEY;
>> +
>> +       if (kstatus & val)
>> +               w90p910_keypad_scan_matrix(keypad, kstatus);
>> +
>> +       return IRQ_HANDLED;
>> +}
>> +
>> +static int w90p910_keypad_open(struct input_dev *dev)
>> +{
>> +       struct w90p910_keypad *keypad = input_get_drvdata(dev);
>> +       unsigned int val;
>> +
>> +       /* Enable unit clock */
>> +       clk_enable(keypad->clk);
>> +
>> +       keypad_writel(KPI_CONF, RESET);
>> +       keypad_writel(KPI_3KCONF, RESET);
>> +       keypad_writel(KPI_LPCONF, RESET);
>> +       keypad_writel(KPI_STATUS, RESET);
>> +
>> +       val = keypad_readl(KPI_CONF);
>> +       val |= (PRESCALE | DEBOUNCE | KPSEL | ENKP);
> 
> Care to make someof  this configurable through platform data? May be
> debounce and prescale can be configured.
> 
>> +       val &= ~(KSIZE0 | KSIZE1);
>> +
>> +       keypad_writel(KPI_CONF, val);
>> +
>> +       return 0;
>> +}
>> +
>> +static void w90p910_keypad_close(struct input_dev *dev)
>> +{
>> +       struct w90p910_keypad *keypad = input_get_drvdata(dev);
>> +
>> +       /* Disable clock unit */
>> +       clk_disable(keypad->clk);
> 
> So this controller doesn't support putting controller FSM into IDLE
> state by writing some bits into it or is it doing auto-sleep?

What you said not be supporting in w90p910,
When to disable this clk,I think the controller will be power down.

> 
>> +}
>> +
>> +static int __devinit w90p910_keypad_probe(struct platform_device *pdev)
>> +{
>> +       struct w90p910_keypad *keypad;
>> +       struct input_dev *input_dev;
>> +       struct resource *res;
>> +       int irq, error;
>> +
>> +       keypad = kzalloc(sizeof(struct w90p910_keypad), GFP_KERNEL);
>> +       if (keypad == NULL) {
>> +               dev_err(&pdev->dev, "failed to allocate driver data\n");
>> +               return -ENOMEM;
>> +       }
>> +
>> +       keypad->pdata = pdev->dev.platform_data;
>> +       if (keypad->pdata == NULL) {
>> +               dev_err(&pdev->dev, "no platform data defined\n");
>> +               error = -EINVAL;
>> +               goto failed_free;
>> +       }
>> +
>> +       irq = platform_get_irq(pdev, 0);
>> +       if (irq < 0) {
>> +               dev_err(&pdev->dev, "failed to get keypad irq\n");
>> +               error = -ENXIO;
>> +               goto failed_free;
>> +       }
>> +
>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +       if (res == NULL) {
>> +               dev_err(&pdev->dev, "failed to get I/O memory\n");
>> +               error = -ENXIO;
>> +               goto failed_free;
>> +       }
>> +
>> +       res = request_mem_region(res->start, res_size(res), pdev->name);
>> +       if (res == NULL) {
>> +               dev_err(&pdev->dev, "failed to request I/O memory\n");
>> +               error = -EBUSY;
>> +               goto failed_free;
>> +       }
>> +
>> +       keypad->mmio_base = ioremap(res->start, res_size(res));
>> +       if (keypad->mmio_base == NULL) {
>> +               dev_err(&pdev->dev, "failed to remap I/O memory\n");
>> +               error = -ENXIO;
>> +               goto failed_free_mem;
>> +       }
>> +
>> +       keypad->clk = clk_get(&pdev->dev, NULL);
>> +       if (IS_ERR(keypad->clk)) {
>> +               dev_err(&pdev->dev, "failed to get keypad clock\n");
>> +               error = PTR_ERR(keypad->clk);
>> +               goto failed_free_io;
>> +       }
>> +
>> +       /* Create and register the input driver. */
>> +       input_dev = input_allocate_device();
>> +       if (!input_dev) {
>> +               dev_err(&pdev->dev, "failed to allocate input device\n");
>> +               error = -ENOMEM;
>> +               goto failed_put_clk;
>> +       }
>> +
>> +       /* set multi-function pin for w90p910 kpi. */
>> +       mfp_set_groupi(&pdev->dev);
>> +
> 
> Could you please point me to implementation of this API? I believe
> this is pin-multiplexing code.

Sure, it is a muti-function pin API, which was defined in /mach-w90x900/mfp-w90p910.c.
What's wrong?

> 
>> +       input_dev->name = pdev->name;
>> +       input_dev->id.bustype = BUS_HOST;
>> +       input_dev->open = w90p910_keypad_open;
>> +       input_dev->close = w90p910_keypad_close;
>> +       input_dev->dev.parent = &pdev->dev;
>> +
>> +       keypad->input_dev = input_dev;
>> +       input_set_drvdata(input_dev, keypad);
>> +
>> +       input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REP);
> 
> EV_REP can be done as per platform data, but not a problem to enable
> by default if keypad controller itself is not supporting it


This is not suitable to w90p910? 
Maybe I have a mistake to understand EV_REP, how to do for me here?.
.
> 
>> +       w90p910_keypad_build_keycode(keypad);
>> +       platform_set_drvdata(pdev, keypad);
>> +
>> +       error = request_irq(irq, w90p910_keypad_irq_handler, IRQF_DISABLED,
>> +                           pdev->name, keypad);
>> +       if (error) {
>> +               dev_err(&pdev->dev, "failed to request IRQ\n");
>> +               goto failed_free_dev;
>> +       }
>> +
>> +       keypad->irq = irq;
>> +
>> +       /* Register the input device */
>> +       error = input_register_device(input_dev);
>> +       if (error) {
>> +               dev_err(&pdev->dev, "failed to register input device\n");
>> +               goto failed_free_irq;
>> +       }
>> +
>> +       return 0;
>> +
>> +failed_free_irq:
>> +       free_irq(irq, pdev);
>> +       platform_set_drvdata(pdev, NULL);
>> +failed_free_dev:
>> +       input_free_device(input_dev);
>> +failed_put_clk:
>> +       clk_put(keypad->clk);
>> +failed_free_io:
>> +       iounmap(keypad->mmio_base);
>> +failed_free_mem:
>> +       release_mem_region(res->start, res_size(res));
>> +failed_free:
>> +       kfree(keypad);
>> +       return error;
>> +}
>> +
>> +static int __devexit w90p910_keypad_remove(struct platform_device *pdev)
>> +{
>> +       struct w90p910_keypad *keypad = platform_get_drvdata(pdev);
>> +       struct resource *res;
>> +
>> +       free_irq(keypad->irq, pdev);
>> +
>> +       clk_disable(keypad->clk);
>> +       clk_put(keypad->clk);
>> +
>> +       input_unregister_device(keypad->input_dev);
>> +       input_free_device(keypad->input_dev);
> 
> input_free_device not needed after input_unregister_device.
> 
>> +
>> +       iounmap(keypad->mmio_base);
>> +
>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +       release_mem_region(res->start, res_size(res));
>> +
>> +       platform_set_drvdata(pdev, NULL);
>> +       kfree(keypad);
>> +       return 0;
>> +}
>> +
>> +static struct platform_driver w90p910_keypad_driver = {
>> +       .probe          = w90p910_keypad_probe,
>> +       .remove         = __devexit_p(w90p910_keypad_remove),
> 
> Care to add suspend/resume support?
> 
>> +       .driver         = {
>> +               .name   = "w90p910-keypad",
>> +               .owner  = THIS_MODULE,
>> +       },
>> +};
>> +
> 


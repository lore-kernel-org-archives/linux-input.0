From: "Patil, Rachna" <rachna@ti.com>
Subject: RE: [PATCH v3] input: add support for TI Touchscreen controller.
Date: Tue, 2 Aug 2011 19:16:40 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024DE786DB@dbde02.ent.ti.com>
References: <1311326009-8590-1-git-send-email-rachna@ti.com>
	<CAM=Q2cunVNO92ngc0_YaiH8Eikk66xqSUrRU4eLm8xB2n4Y8og@mail.gmail.com>
 <CAM=Q2csKJBaOrTG2-6im+b-UpexMs33wqK6DK6gpmRhScxidww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35181 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096Ab1HBNrv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 2 Aug 2011 09:47:51 -0400
In-Reply-To: <CAM=Q2csKJBaOrTG2-6im+b-UpexMs33wqK6DK6gpmRhScxidww@mail.gmail.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Shubhrajyoti,


On Mon, Aug 01, 2011 at 17:33:26, Shubhrajyoti Datta wrote:
> 
> Hello,
> 
> 
> On Fri, Jul 22, 2011 at 2:43 PM, Patil, Rachna <rachna@ti.com> wrote:
> 
> 
> 	This patch adds support for TI's touchscreen
> 	controller for a 4/5/8 wire resistive panel
> 	that is directly fed to the ADC.
> 	
> 	This touchscreen controller will be part of
> 	an upcoming TI SoC and has been tested on
> 	an emulation platform.
> 	
> 
> Is it possible to move to runtime pm instead of the clock calls. 

As discussed earlier, at present we are not handling PM related
issues. This will be added in patches submitted in days to come.

> 
>  
> 
> 
> 	ChangeLog:
> 	
> 	v2: fixed comments from Dimitry
> 	v3: made the driver depend on HAVE_CLK for build
> 	
> 
> 	Signed-off-by: Patil, Rachna <rachna@ti.com>
> 	---
> 	
> 	 drivers/input/touchscreen/Kconfig     |   12 +
> 	
> 	 drivers/input/touchscreen/Makefile    |    1 +
> 	 drivers/input/touchscreen/ti_tscadc.c |  431
> +++++++++++++++++++++++++++++++++
> 	 include/linux/input/ti_tscadc.h       |   10 +
> 	
> 	 4 files changed, 454 insertions(+), 0 deletions(-)
> 	
> 	 create mode 100644 drivers/input/touchscreen/ti_tscadc.c
> 	 create mode 100644 include/linux/input/ti_tscadc.h
> 	
> 	diff --git a/drivers/input/touchscreen/Kconfig
> b/drivers/input/touchscreen/Kconfig
> 	
> 	index 44589f5..69d367a 100644
> 	
> 	--- a/drivers/input/touchscreen/Kconfig
> 	+++ b/drivers/input/touchscreen/Kconfig
> 	
> 	@@ -395,6 +395,18 @@ config TOUCHSCREEN_TOUCHWIN
> 	
> 	         To compile this driver as a module, choose M here: the
> 	         module will be called touchwin.
> 	
> 	+config TOUCHSCREEN_TI_TSCADC
> 	+       tristate "TI Touchscreen Interface"
> 	
> 	+       depends on HAVE_CLK
> 	+       help
> 	
> 	+         Say Y here if you have 4/5/8 wire touchscreen
> controller
> 	+         to be connected to the ADC controller on your TI SoC.
> 	+
> 	+         If unsure, say N.
> 	+
> 	+         To compile this driver as a module, choose M here: the
> 	+         module will be called ti_tscadc.
> 	+
> 	 config TOUCHSCREEN_ATMEL_TSADCC
> 	       tristate "Atmel Touchscreen Interface"
> 	       depends on ARCH_AT91SAM9RL || ARCH_AT91SAM9G45
> 	diff --git a/drivers/input/touchscreen/Makefile
> b/drivers/input/touchscreen/Makefile
> 	index 51b08b0..86b7ab6 100644
> 	--- a/drivers/input/touchscreen/Makefile
> 	+++ b/drivers/input/touchscreen/Makefile
> 	@@ -41,6 +41,7 @@ obj-$(CONFIG_TOUCHSCREEN_QT602240)    +=
> qt602240_ts.o
> 	 obj-$(CONFIG_TOUCHSCREEN_S3C2410)      += s3c2410_ts.o
> 	 obj-$(CONFIG_TOUCHSCREEN_ST1232)       += st1232.o
> 	 obj-$(CONFIG_TOUCHSCREEN_STMPE)                += stmpe-ts.o
> 	+obj-$(CONFIG_TOUCHSCREEN_TI_TSCADC)     += ti_tscadc.o
> 	 obj-$(CONFIG_TOUCHSCREEN_TNETV107X)    += tnetv107x-ts.o
> 	 obj-$(CONFIG_TOUCHSCREEN_TOUCHIT213)   += touchit213.o
> 	 obj-$(CONFIG_TOUCHSCREEN_TOUCHRIGHT)   += touchright.o
> 	
> 	diff --git a/drivers/input/touchscreen/ti_tscadc.c
> b/drivers/input/touchscreen/ti_tscadc.c
> 	
> 	new file mode 100644
> 	index 0000000..86264fc
> 	--- /dev/null
> 	+++ b/drivers/input/touchscreen/ti_tscadc.c
> 	@@ -0,0 +1,431 @@
> 	+/*
> 	+ * TI Touch Screen driver
> 	+ *
> 	+ * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
> 	+ *
> 	+ * This program is free software; you can redistribute it and/or
> 	+ * modify it under the terms of the GNU General Public License as
> 	+ * published by the Free Software Foundation version 2.
> 	+ *
> 	+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> 	+ * kind, whether express or implied; without even the implied warranty
> 	+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> 	+ * GNU General Public License for more details.
> 	+ */
> 	+
> 	+
> 	+#include <linux/init.h>
> 	+#include <linux/kernel.h>
> 	+#include <linux/err.h>
> 	+#include <linux/module.h>
> 	+#include <linux/input.h>
> 	+#include <linux/slab.h>
> 	+#include <linux/interrupt.h>
> 	+#include <linux/clk.h>
> 	+#include <linux/platform_device.h>
> 	+#include <linux/io.h>
> 	+#include <linux/input/ti_tscadc.h>
> 	
> 	
> 
> <snip> 
> 
> 
> 	+static int __devinit tscadc_probe(struct platform_device *pdev)
> 	+{
> 	+       struct tscadc                   *ts_dev;
> 	+       struct input_dev                *input_dev;
> 	+       int                             err;
> 	+       int                             clk_value;
> 	+       int                             clock_rate, irqenable,
> ctrl;
> 	+       struct  tsc_data                *pdata =
> pdev->dev.platform_data;
> 	+       struct resource                 *res;
> 	+
> 	+       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> 	+       if (!res) {
> 	+               dev_err(&pdev->dev, "no memory resource
> defined.\n");
> 	+               return -EINVAL;
> 	+       }
> 	+
> 	+       /* Allocate memory for device */
> 	+       ts_dev = kzalloc(sizeof(struct tscadc), GFP_KERNEL);
> 	+       if (!ts_dev) {
> 	+               dev_err(&pdev->dev, "failed to allocate
> memory.\n");
> 	+               return -ENOMEM;
> 	+       }
> 	+
> 	+       ts_dev->irq = platform_get_irq(pdev, 0);
> 	+       if (ts_dev->irq < 0) {
> 	+               dev_err(&pdev->dev, "no irq ID is
> specified.\n");
> 	
> 
> 
> why not free the earlier allocated memory?

Ok. I will add this.

> 
>  
> 
> 	+               return -ENODEV;
> 
> 	+       }
> 	+
> 	+       input_dev = input_allocate_device();
> 	+       if (!input_dev) {
> 	+               dev_err(&pdev->dev, "failed to allocate input
> device.\n");
> 	+               err = -ENOMEM;
> 	+               goto err_free_mem;
> 	+       }
> 	+       ts_dev->input = input_dev;
> 	+
> 	+       ts_dev->tsc_base = ioremap(res->start,
> resource_size(res));
> 	+       if (!ts_dev->tsc_base) {
> 	+               dev_err(&pdev->dev, "failed to map
> registers.\n");
> 	+               err = -ENOMEM;
> 	+               goto err_release_mem;
> 	+       }
> 	+
> 	+       err = request_irq(ts_dev->irq, tscadc_interrupt,
> IRQF_DISABLED,
> 	+                               pdev->dev.driver->name, ts_dev);
> 	+       if (err) {
> 	+               dev_err(&pdev->dev, "failed to allocate
> irq.\n");
> 	+               goto err_unmap_regs;
> 	+       }
> 	+
> 	+       ts_dev->clk = clk_get(&pdev->dev, "tsc_clk");
> 	+       if (IS_ERR(ts_dev->clk)) {
> 	+               dev_err(&pdev->dev, "failed to get ts_clk\n");
> 	+               err = PTR_ERR(ts_dev->clk);
> 	+               goto err_free_irq;
> 	+       }
> 	+       clk_enable(ts_dev->clk);
> 	+
> 	+       clock_rate = clk_get_rate(ts_dev->clk);
> 	+       clk_value = clock_rate / ADC_CLK;
> 	+       if (clk_value < 7) {
> 	+               dev_err(&pdev->dev, "clock input less than min
> clock requirement\n");
> 	+               goto err_fail;
> 	+       }
> 	+       /* TSCADC_CLKDIV needs to be configured to the value
> minus 1 */
> 	+       clk_value = clk_value - 1;
> 	+       tscadc_writel(ts_dev, TSCADC_REG_CLKDIV, clk_value);
> 	+
> 	+        /* Enable wake-up of the SoC using touchscreen */
> 	+       tscadc_writel(ts_dev, TSCADC_REG_IRQWAKEUP,
> TSCADC_IRQWKUP_ENB);
> 	+
> 	+       ts_dev->wires = pdata->wires;
> 	+
> 	+       /* Set the control register bits */
> 	+       ctrl = TSCADC_CNTRLREG_STEPCONFIGWRT |
> 	+                       TSCADC_CNTRLREG_TSCENB |
> 	+                       TSCADC_CNTRLREG_STEPID;
> 	+       switch (ts_dev->wires) {
> 	+       case 4:
> 	+               ctrl |= TSCADC_CNTRLREG_4WIRE;
> 	+               break;
> 	+       case 5:
> 	+               ctrl |= TSCADC_CNTRLREG_5WIRE;
> 	+               break;
> 	+       case 8:
> 	+               ctrl |= TSCADC_CNTRLREG_8WIRE;
> 	+               break;
> 	+       }
> 	+       tscadc_writel(ts_dev, TSCADC_REG_CTRL, ctrl);
> 	+
> 	+       /* Set register bits for Idel Config Mode */
> 	+       tsc_idle_config(ts_dev);
> 	+
> 	+       /* IRQ Enable */
> 	+       irqenable = TSCADC_IRQENB_IRQHWPEN |
> 	+                       TSCADC_IRQENB_IRQEOS |
> 	+                       TSCADC_IRQENB_PENUP |
> TSCADC_IRQENB_FIFO_OVERFLOW;
> 	+       tscadc_writel(ts_dev, TSCADC_REG_IRQENABLE, irqenable);
> 	+
> 	+       tsc_step_config(ts_dev);
> 	+
> 	+       ctrl |= TSCADC_CNTRLREG_TSCSSENB;
> 	+       tscadc_writel(ts_dev, TSCADC_REG_CTRL, ctrl);
> 	+
> 	+       input_dev->name = "ti-tsc-adcc";
> 	+       input_dev->dev.parent = &pdev->dev;
> 	+
> 	+       input_dev->evbit[0] = BIT_MASK(EV_KEY) |
> BIT_MASK(EV_ABS);
> 	+       input_dev->keybit[BIT_WORD(BTN_TOUCH)] =
> BIT_MASK(BTN_TOUCH);
> 	+
> 	+       input_set_abs_params(input_dev, ABS_X, 0, MAX_12BIT, 0,
> 0);
> 	+       input_set_abs_params(input_dev, ABS_Y, 0, MAX_12BIT, 0,
> 0);
> 	+
> 	+       /* register to the input system */
> 	+       err = input_register_device(input_dev);
> 	+       if (err)
> 	+               goto err_fail;
> 	+
> 	+       return 0;
> 	+
> 	+err_fail:
> 	+       clk_disable(ts_dev->clk);
> 	+       clk_put(ts_dev->clk);
> 	+err_free_irq:
> 	+       free_irq(ts_dev->irq, ts_dev);
> 	+err_unmap_regs:
> 	+       iounmap(ts_dev->tsc_base);
> 	+err_release_mem:
> 	+       release_mem_region(res->start, resource_size(res));
> 	+       input_free_device(ts_dev->input);
> 	+err_free_mem:
> 	+       kfree(ts_dev);
> 	+       return err;
> 	+}
> 	+
> 	+static int __devexit tscadc_remove(struct platform_device
> *pdev)
> 	+{
> 	+       struct tscadc           *ts_dev =
> dev_get_drvdata(&pdev->dev);
> 	+       struct resource         *res;
> 	+
> 	+       free_irq(ts_dev->irq, ts_dev);
> 	+
> 	+       input_unregister_device(ts_dev->input);
> 	+
> 	+       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> 	+       iounmap(ts_dev->tsc_base);
> 	+       release_mem_region(res->start, resource_size(res));
> 	+
> 	+       clk_disable(ts_dev->clk);
> 	+       clk_put(ts_dev->clk);
> 	+
> 	+       kfree(ts_dev);
> 	+
> 	+       return 0;
> 	+}
> 	+
> 	+static struct platform_driver ti_tsc_driver = {
> 	+       .probe    = tscadc_probe,
> 	+       .remove  = __devexit_p(tscadc_remove),
> 	+       .driver  = {
> 	+               .name   = "tsc",
> 	+       },
> 	+};
> 	+
> 	+static int __init ti_tsc_init(void)
> 	+{
> 	+       return platform_driver_register(&ti_tsc_driver);
> 	+}
> 	+
> 	+static void __exit ti_tsc_exit(void)
> 	+{
> 	+       platform_driver_unregister(&ti_tsc_driver);
> 	+}
> 	+
> 	+module_init(ti_tsc_init);
> 	+module_exit(ti_tsc_exit);
> 	diff --git a/include/linux/input/ti_tscadc.h b/include/linux/input/ti_tscadc.h
> 	new file mode 100644
> 	index 0000000..29f87db
> 	--- /dev/null
> 	+++ b/include/linux/input/ti_tscadc.h
> 	@@ -0,0 +1,10 @@
> 	+/**
> 	+ * struct tsc_data     Touchscreen wire configuration
> 	+ * @wires:             Wires refer to application modes
> 	+ *                     i.e. 4/5/8 wire touchscreen support
> 	+ *                     on the platform
> 	+ */
> 	+
> 	+struct tsc_data {
> 	+       int wires;
> 	+};
> 	--
> 	1.6.2.4
> 	
> 	--
> 	
> 	To unsubscribe from this list: send the line "unsubscribe linux-input" in
> 	the body of a message to majordomo@vger.kernel.org
> 	More majordomo info at
> http://vger.kernel.org/majordomo-info.html
> 	
> 
> 

Regards,
Rachna.
 


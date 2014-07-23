From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] input: driver for touchscreen on iPaq h3xxx
Date: Wed, 23 Jul 2014 10:32:23 -0700
Message-ID: <20140723173223.GA25132@core.coreip.homeip.net>
References: <1406103614-12438-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:54057 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756793AbaGWRc2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Jul 2014 13:32:28 -0400
Received: by mail-pd0-f171.google.com with SMTP id z10so2008618pdj.2
        for <linux-input@vger.kernel.org>; Wed, 23 Jul 2014 10:32:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1406103614-12438-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-input@vger.kernel.org, Dmitry Artamonow <mad_soft@inbox.ru>, Alessandro GARDICH <gremlin@gremlin.it>

Hi Linus,

On Wed, Jul 23, 2014 at 10:20:14AM +0200, Linus Walleij wrote:
> From: Dmitry Artamonow <mad_soft@inbox.ru>
> 
> This adds a driver for the touchscreen connected to the
> Atmel microcontroller on the iPAQ h3xxx series.
> 
> Based on a driver from handhelds.org 2.6.21 kernel, written
> by Alessandro GARDICH, with the bulk of the code for the
> new input architecture rewritten by Dmitry Atamonow, and
> the final polish by Linus Walleij.
> 
> Signed-off-by: Alessandro GARDICH <gremlin@gremlin.it>
> Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - More verbose Kconfig selection text including module info.
> - Use be16_to_cpup() to deserialize protocol.
> - Cut fake pressure event reporting.
> - Report button events properly.
> - Use devm_input_allocate_device() to allocate input device.
> - Use input_set_capability() to set up capabilities.
> ---
>  drivers/input/touchscreen/Kconfig         |  12 +++
>  drivers/input/touchscreen/Makefile        |   1 +
>  drivers/input/touchscreen/ipaq-micro-ts.c | 141 ++++++++++++++++++++++++++++++
>  3 files changed, 154 insertions(+)
>  create mode 100644 drivers/input/touchscreen/ipaq-micro-ts.c
> 
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index a23a94bb4bcb..6bb9a7dd23b6 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -471,6 +471,18 @@ config TOUCHSCREEN_HP7XX
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called jornada720_ts.
>  
> +config TOUCHSCREEN_IPAQ_MICRO
> +	tristate "HP iPAQ Atmel Micro ASIC touchscreen"
> +	depends on MFD_IPAQ_MICRO
> +	help
> +	  Say Y here to enable support for the touchscreen attached to
> +	  the Atmel Micro peripheral controller on iPAQ h3100/h3600/h3700
> +
> +	  If unsure, say N.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ipaq-micro-ts.
> +
>  config TOUCHSCREEN_HTCPEN
>  	tristate "HTC Shift X9500 touchscreen"
>  	depends on ISA
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> index 126479d8c29a..4be94fce41af 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -46,6 +46,7 @@ obj-$(CONFIG_TOUCHSCREEN_MTOUCH)	+= mtouch.o
>  obj-$(CONFIG_TOUCHSCREEN_MK712)		+= mk712.o
>  obj-$(CONFIG_TOUCHSCREEN_HP600)		+= hp680_ts_input.o
>  obj-$(CONFIG_TOUCHSCREEN_HP7XX)		+= jornada720_ts.o
> +obj-$(CONFIG_TOUCHSCREEN_IPAQ_MICRO)	+= ipaq-micro-ts.o
>  obj-$(CONFIG_TOUCHSCREEN_HTCPEN)	+= htcpen.o
>  obj-$(CONFIG_TOUCHSCREEN_USB_COMPOSITE)	+= usbtouchscreen.o
>  obj-$(CONFIG_TOUCHSCREEN_PCAP)		+= pcap_ts.o
> diff --git a/drivers/input/touchscreen/ipaq-micro-ts.c b/drivers/input/touchscreen/ipaq-micro-ts.c
> new file mode 100644
> index 000000000000..d044b06b1bfb
> --- /dev/null
> +++ b/drivers/input/touchscreen/ipaq-micro-ts.c
> @@ -0,0 +1,141 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * h3600 atmel micro companion support, touchscreen subdevice
> + * Author : Alessandro Gardich <gremlin@gremlin.it>
> + * Author : Dmitry Artamonow <mad_soft@inbox.ru>
> + * Author : Linus Walleij <linus.walleij@linaro.org>
> + *
> + */
> +
> +#include <asm/byteorder.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/pm.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/input.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/mfd/ipaq-micro.h>
> +
> +struct touchscreen_data {
> +	struct input_dev *input;
> +	struct ipaq_micro *micro;
> +};
> +
> +static void micro_ts_receive(void *data, int len, unsigned char *msg)
> +{
> +	struct touchscreen_data *ts = data;
> +
> +	if (len == 4) {
> +		input_report_abs(ts->input, ABS_X,
> +				 be16_to_cpup((__be16 *) &msg[2]));
> +		input_report_abs(ts->input, ABS_Y,
> +				 be16_to_cpup((__be16 *) &msg[0]));
> +		input_report_key(ts->input, BTN_TOUCH, 1);
> +	}
> +	if (len == 0) {
> +		input_report_abs(ts->input, ABS_X, 0);
> +		input_report_abs(ts->input, ABS_Y, 0);
> +		input_report_key(ts->input, BTN_TOUCH, 0);
> +	}
> +	input_sync(ts->input);

We should probably pull input_sync() up into these 2 branches so that we
do not try to send sync on empty packets.

> +}
> +
> +
> +static int micro_ts_probe(struct platform_device *pdev)
> +{
> +	struct touchscreen_data *ts;
> +	int ret;
> +
> +	ts = devm_kzalloc(&pdev->dev, sizeof(*ts), GFP_KERNEL);
> +	if (!ts)
> +		return -ENOMEM;
> +	ts->micro = dev_get_drvdata(pdev->dev.parent);
> +
> +	platform_set_drvdata(pdev, ts);
> +
> +	ts->input = devm_input_allocate_device(&pdev->dev);
> +	if (!ts->input) {
> +		dev_err(&pdev->dev, "failed to allocate input device\n");
> +		return -ENOMEM;
> +        }
> +
> +	input_set_capability(ts->input, EV_KEY, BTN_TOUCH);
> +	input_set_capability(ts->input, EV_ABS, ABS_X);
> +	input_set_capability(ts->input, EV_ABS, ABS_Y);
> +	input_set_abs_params(ts->input, ABS_X, 0, 1023, 0, 0);
> +	input_set_abs_params(ts->input, ABS_Y, 0, 1023, 0, 0);
> +
> +	ts->input->name = "ipaq micro ts";
> +
> +	ret = input_register_device(ts->input);
> +	if (ret) {
> +		dev_err(&pdev->dev, "error registering touch input\n");
> +		return ret;
> +	}
> +
> +	spin_lock(&ts->micro->lock);
> +	ts->micro->ts = micro_ts_receive;
> +	ts->micro->ts_data = ts;
> +	spin_unlock(&ts->micro->lock);

The receiver callback is called form interrupt context, as far as I can
see, so these must be _irq() or _irqsave().

> +
> +	dev_info(&pdev->dev, "iPAQ micro touchscreen\n");
> +	return 0;
> +}
> +
> +static int micro_ts_remove(struct platform_device *pdev)
> +{
> +	struct touchscreen_data *ts = platform_get_drvdata(pdev);
> +
> +	spin_lock(&ts->micro->lock);
> +	ts->micro->ts = NULL;
> +	ts->micro->ts_data = NULL;
> +	spin_unlock(&ts->micro->lock);
> +
> +	return 0;
> +}
> +
> +static int micro_ts_suspend(struct device *dev)
> +{
> +	struct touchscreen_data *ts = dev_get_drvdata(dev);
> +
> +	spin_lock(&ts->micro->lock);
> +	ts->micro->ts = NULL;
> +	ts->micro->ts_data = NULL;
> +	spin_unlock(&ts->micro->lock);
> +	return 0;
> +}
> +
> +static int micro_ts_resume(struct device *dev)
> +{
> +	struct touchscreen_data *ts = dev_get_drvdata(dev);
> +
> +	spin_lock(&ts->micro->lock);
> +	ts->micro->ts = micro_ts_receive;
> +	ts->micro->ts_data = ts;
> +	spin_unlock(&ts->micro->lock);
> +	return 0;
> +}

We should protect these with CONFIG_PM_SLEEP to avoid "unused" warnings.

> +
> +static const struct dev_pm_ops micro_ts_dev_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(micro_ts_suspend, micro_ts_resume)
> +};
> +
> +struct platform_driver micro_ts_device_driver = {
> +	.driver  = {
> +		.name    = "ipaq-micro-ts",
> +		.pm	= &micro_ts_dev_pm_ops,
> +	},
> +	.probe   = micro_ts_probe,
> +	.remove  = micro_ts_remove,
> +};
> +module_platform_driver(micro_ts_device_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("driver for iPAQ Atmel micro touchscreen");
> +MODULE_ALIAS("platform:ipaq-micro-ts");

I've done the changes locally, please take a look.

Thanks.

-- 
Dmitry


Input: driver for touchscreen on iPaq h3xxx

From: Dmitry Artamonow <mad_soft@inbox.ru>

This adds a driver for the touchscreen connected to the Atmel
microcontroller on the iPAQ h3xxx series.

Based on a driver from handhelds.org 2.6.21 kernel, written by Alessandro
GARDICH, with the bulk of the code for the new input architecture rewritten
by Dmitry Atamonow, and the final polish by Linus Walleij.

Signed-off-by: Alessandro GARDICH <gremlin@gremlin.it>
Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/Kconfig         |   12 ++
 drivers/input/touchscreen/Makefile        |    1 
 drivers/input/touchscreen/ipaq-micro-ts.c |  142 +++++++++++++++++++++++++++++
 3 files changed, 155 insertions(+)
 create mode 100644 drivers/input/touchscreen/ipaq-micro-ts.c

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index a23a94b..6bb9a7d 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -471,6 +471,18 @@ config TOUCHSCREEN_HP7XX
 	  To compile this driver as a module, choose M here: the
 	  module will be called jornada720_ts.
 
+config TOUCHSCREEN_IPAQ_MICRO
+	tristate "HP iPAQ Atmel Micro ASIC touchscreen"
+	depends on MFD_IPAQ_MICRO
+	help
+	  Say Y here to enable support for the touchscreen attached to
+	  the Atmel Micro peripheral controller on iPAQ h3100/h3600/h3700
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ipaq-micro-ts.
+
 config TOUCHSCREEN_HTCPEN
 	tristate "HTC Shift X9500 touchscreen"
 	depends on ISA
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 126479d..4be94fc 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -46,6 +46,7 @@ obj-$(CONFIG_TOUCHSCREEN_MTOUCH)	+= mtouch.o
 obj-$(CONFIG_TOUCHSCREEN_MK712)		+= mk712.o
 obj-$(CONFIG_TOUCHSCREEN_HP600)		+= hp680_ts_input.o
 obj-$(CONFIG_TOUCHSCREEN_HP7XX)		+= jornada720_ts.o
+obj-$(CONFIG_TOUCHSCREEN_IPAQ_MICRO)	+= ipaq-micro-ts.o
 obj-$(CONFIG_TOUCHSCREEN_HTCPEN)	+= htcpen.o
 obj-$(CONFIG_TOUCHSCREEN_USB_COMPOSITE)	+= usbtouchscreen.o
 obj-$(CONFIG_TOUCHSCREEN_PCAP)		+= pcap_ts.o
diff --git a/drivers/input/touchscreen/ipaq-micro-ts.c b/drivers/input/touchscreen/ipaq-micro-ts.c
new file mode 100644
index 0000000..53fa5c3
--- /dev/null
+++ b/drivers/input/touchscreen/ipaq-micro-ts.c
@@ -0,0 +1,142 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * h3600 atmel micro companion support, touchscreen subdevice
+ * Author : Alessandro Gardich <gremlin@gremlin.it>
+ * Author : Dmitry Artamonow <mad_soft@inbox.ru>
+ * Author : Linus Walleij <linus.walleij@linaro.org>
+ *
+ */
+
+#include <asm/byteorder.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/pm.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/input.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/mfd/ipaq-micro.h>
+
+struct touchscreen_data {
+	struct input_dev *input;
+	struct ipaq_micro *micro;
+};
+
+static void micro_ts_receive(void *data, int len, unsigned char *msg)
+{
+	struct touchscreen_data *ts = data;
+
+	if (len == 4) {
+		input_report_abs(ts->input, ABS_X,
+				 be16_to_cpup((__be16 *) &msg[2]));
+		input_report_abs(ts->input, ABS_Y,
+				 be16_to_cpup((__be16 *) &msg[0]));
+		input_report_key(ts->input, BTN_TOUCH, 1);
+		input_sync(ts->input);
+	} else if (len == 0) {
+		input_report_abs(ts->input, ABS_X, 0);
+		input_report_abs(ts->input, ABS_Y, 0);
+		input_report_key(ts->input, BTN_TOUCH, 0);
+		input_sync(ts->input);
+	}
+}
+
+static int micro_ts_probe(struct platform_device *pdev)
+{
+	struct touchscreen_data *ts;
+	int ret;
+
+	ts = devm_kzalloc(&pdev->dev, sizeof(*ts), GFP_KERNEL);
+	if (!ts)
+		return -ENOMEM;
+	ts->micro = dev_get_drvdata(pdev->dev.parent);
+
+	platform_set_drvdata(pdev, ts);
+
+	ts->input = devm_input_allocate_device(&pdev->dev);
+	if (!ts->input) {
+		dev_err(&pdev->dev, "failed to allocate input device\n");
+		return -ENOMEM;
+	}
+
+	input_set_capability(ts->input, EV_KEY, BTN_TOUCH);
+	input_set_capability(ts->input, EV_ABS, ABS_X);
+	input_set_capability(ts->input, EV_ABS, ABS_Y);
+	input_set_abs_params(ts->input, ABS_X, 0, 1023, 0, 0);
+	input_set_abs_params(ts->input, ABS_Y, 0, 1023, 0, 0);
+
+	ts->input->name = "ipaq micro ts";
+
+	ret = input_register_device(ts->input);
+	if (ret) {
+		dev_err(&pdev->dev, "error registering touch input\n");
+		return ret;
+	}
+
+	spin_lock_irq(&ts->micro->lock);
+	ts->micro->ts = micro_ts_receive;
+	ts->micro->ts_data = ts;
+	spin_unlock_irq(&ts->micro->lock);
+
+	dev_info(&pdev->dev, "iPAQ micro touchscreen\n");
+	return 0;
+}
+
+static int micro_ts_remove(struct platform_device *pdev)
+{
+	struct touchscreen_data *ts = platform_get_drvdata(pdev);
+
+	spin_lock_irq(&ts->micro->lock);
+	ts->micro->ts = NULL;
+	ts->micro->ts_data = NULL;
+	spin_unlock_irq(&ts->micro->lock);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int micro_ts_suspend(struct device *dev)
+{
+	struct touchscreen_data *ts = dev_get_drvdata(dev);
+
+	spin_lock_irq(&ts->micro->lock);
+	ts->micro->ts = NULL;
+	ts->micro->ts_data = NULL;
+	spin_unlock_irq(&ts->micro->lock);
+	return 0;
+}
+
+static int micro_ts_resume(struct device *dev)
+{
+	struct touchscreen_data *ts = dev_get_drvdata(dev);
+
+	spin_lock_irq(&ts->micro->lock);
+	ts->micro->ts = micro_ts_receive;
+	ts->micro->ts_data = ts;
+	spin_unlock_irq(&ts->micro->lock);
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops micro_ts_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(micro_ts_suspend, micro_ts_resume)
+};
+
+static struct platform_driver micro_ts_device_driver = {
+	.driver	= {
+		.name	= "ipaq-micro-ts",
+		.pm	= &micro_ts_dev_pm_ops,
+	},
+	.probe	= micro_ts_probe,
+	.remove	= micro_ts_remove,
+};
+module_platform_driver(micro_ts_device_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("driver for iPAQ Atmel micro touchscreen");
+MODULE_ALIAS("platform:ipaq-micro-ts");

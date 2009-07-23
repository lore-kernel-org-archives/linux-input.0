From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] input/joystick: new Blackfin rotary input driver
Date: Wed, 22 Jul 2009 21:43:38 -0700
Message-ID: <20090723044338.GB2782@dtor-d630.eng.vmware.com>
References: <1247592827-16878-1-git-send-email-vapier@gentoo.org> <1247592827-16878-2-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.225]:46154 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334AbZGWEnm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jul 2009 00:43:42 -0400
Received: by rv-out-0506.google.com with SMTP id f6so188516rvb.1
        for <linux-input@vger.kernel.org>; Wed, 22 Jul 2009 21:43:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1247592827-16878-2-git-send-email-vapier@gentoo.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: linux-input@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, Michael Hennerich <michael.hennerich@analog.com>, Bryan Wu <cooloney@kernel.org>

Hi Mike,

On Tue, Jul 14, 2009 at 01:33:47PM -0400, Mike Frysinger wrote:
> +
> +	if (pdata->rotary_up_key && pdata->rotary_down_key) {
> +		__set_bit(EV_KEY, input->evbit);
> +		__set_bit(pdata->rotary_up_key, input->keybit);
> +		__set_bit(pdata->rotary_down_key, input->keybit);
> +	} else if (pdata->rotary_rel_code) {
> +		__set_bit(EV_REL, input->evbit);
> +		__set_bit(pdata->rotary_rel_code, input->relbit);
> +	} else {
> +		ret = -EINVAL;
> +		goto out4;


This will trigger on REL_X which is 0. I think we'll just have to assume
that if keys are not set then device should emit relative axis events.

> +
> +struct platform_driver bfin_rotary_device_driver = {
> +	.probe		= bfin_rotary_probe,
> +	.remove		= __devexit_p(bfin_rotary_remove),
> +	.suspend	= bfin_rotary_suspend,
> +	.resume		= bfin_rotary_resume,

Need to use dev_pm_ops so platform code won;t yell at us.

> +	.driver		= {
> +		.name	= "bfin-rotary",
> +		.owner	= THIS_MODULE,
> +	},
> +};
> +

I also think that this driver should too live in drivers/input/misc so I
moved it there. I did a bit of reshuffling in the patch, could you
please give it a try and if it still works I'll apply to the 'next'
branch.

Thanks!

-- 
Dmitry


Input: add Blackfin rotary input driver

From: Michael Hennerich <michael.hennerich@analog.com>

This driver handles the Blackfin on-chip rotary peripheral.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Bryan Wu <cooloney@kernel.org>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 arch/blackfin/include/asm/bfin_rotary.h |   39 ++++
 drivers/input/misc/Kconfig              |   10 +
 drivers/input/misc/Makefile             |    1 
 drivers/input/misc/bfin_rotary.c        |  283 +++++++++++++++++++++++++++++++
 4 files changed, 333 insertions(+), 0 deletions(-)
 create mode 100644 arch/blackfin/include/asm/bfin_rotary.h
 create mode 100644 drivers/input/misc/bfin_rotary.c


diff --git a/arch/blackfin/include/asm/bfin_rotary.h b/arch/blackfin/include/asm/bfin_rotary.h
new file mode 100644
index 0000000..425ece6
--- /dev/null
+++ b/arch/blackfin/include/asm/bfin_rotary.h
@@ -0,0 +1,39 @@
+/*
+ * board initialization should put one of these structures into platform_data
+ * and place the bfin-rotary onto platform_bus named "bfin-rotary".
+ */
+
+#ifndef _BFIN_ROTARY_H
+#define _BFIN_ROTARY_H
+
+/* mode bitmasks */
+#define ROT_QUAD_ENC	CNTMODE_QUADENC	/* quadrature/grey code encoder mode */
+#define ROT_BIN_ENC	CNTMODE_BINENC	/* binary encoder mode */
+#define ROT_UD_CNT	CNTMODE_UDCNT	/* rotary counter mode */
+#define ROT_DIR_CNT	CNTMODE_DIRCNT	/* direction counter mode */
+
+#define ROT_DEBE	DEBE		/* Debounce Enable */
+
+#define ROT_CDGINV	CDGINV		/* CDG Pin Polarity Invert */
+#define ROT_CUDINV	CUDINV		/* CUD Pin Polarity Invert */
+#define ROT_CZMINV	CZMINV		/* CZM Pin Polarity Invert */
+
+struct bfin_rotary_platform_data {
+	/* set rotary UP KEY_### or BTN_### in case you prefer
+	 * bfin-rotary to send EV_KEY otherwise set 0
+	 */
+	unsigned int rotary_up_key;
+	/* set rotary DOWN KEY_### or BTN_### in case you prefer
+	 * bfin-rotary to send EV_KEY otherwise set 0
+	 */
+	unsigned int rotary_down_key;
+	/* set rotary BUTTON KEY_### or BTN_### */
+	unsigned int rotary_button_key;
+	/* set rotary Relative Axis REL_### in case you prefer
+	 * bfin-rotary to send EV_REL otherwise set 0
+	 */
+	unsigned int rotary_rel_code;
+	unsigned short debounce;	/* 0..17 */
+	unsigned short mode;
+};
+#endif
diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 1acfa3a..cbe21bc 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -269,4 +269,14 @@ config INPUT_DM355EVM
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called dm355evm_keys.
+
+config INPUT_BFIN_ROTARY
+	tristate "Blackfin Rotary support"
+	depends on BF54x || BF52x
+	help
+	  Say Y here if you want to use the Blackfin Rotary.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called bfin-rotary.
+
 endif
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 0d979fd..79c1e9a 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_INPUT_APANEL)		+= apanel.o
 obj-$(CONFIG_INPUT_ATI_REMOTE)		+= ati_remote.o
 obj-$(CONFIG_INPUT_ATI_REMOTE2)		+= ati_remote2.o
 obj-$(CONFIG_INPUT_ATLAS_BTNS)		+= atlas_btns.o
+obj-$(CONFIG_INPUT_BFIN_ROTARY)		+= bfin_rotary.o
 obj-$(CONFIG_INPUT_CM109)		+= cm109.o
 obj-$(CONFIG_INPUT_COBALT_BTNS)		+= cobalt_btns.o
 obj-$(CONFIG_INPUT_DM355EVM)		+= dm355evm_keys.o
diff --git a/drivers/input/misc/bfin_rotary.c b/drivers/input/misc/bfin_rotary.c
new file mode 100644
index 0000000..690f3fa
--- /dev/null
+++ b/drivers/input/misc/bfin_rotary.c
@@ -0,0 +1,283 @@
+/*
+ * Rotary counter driver for Analog Devices Blackfin Processors
+ *
+ * Copyright 2008-2009 Analog Devices Inc.
+ * Licensed under the GPL-2 or later.
+ */
+
+#include <linux/module.h>
+#include <linux/version.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/pm.h>
+#include <linux/platform_device.h>
+#include <linux/input.h>
+
+#include <asm/portmux.h>
+#include <asm/bfin_rotary.h>
+
+static const u16 per_cnt[] = {
+	P_CNT_CUD,
+	P_CNT_CDG,
+	P_CNT_CZM,
+	0
+};
+
+struct bfin_rot {
+	struct input_dev *input;
+	int irq;
+	unsigned int up_key;
+	unsigned int down_key;
+	unsigned int button_key;
+	unsigned int rel_code;
+	unsigned short cnt_config;
+	unsigned short cnt_imask;
+	unsigned short cnt_debounce;
+};
+
+static void report_key_event(struct input_dev *input, int keycode)
+{
+	/* simulate a press-n-release */
+	input_report_key(input, keycode, 1);
+	input_sync(input);
+	input_report_key(input, keycode, 0);
+	input_sync(input);
+}
+
+static void report_rotary_event(struct bfin_rot *rotary, int delta)
+{
+	struct input_dev *input = rotary->input;
+
+	if (rotary->up_key) {
+		report_key_event(input,
+				 delta > 0 ? rotary->up_key : rotary->down_key);
+	} else {
+		input_report_rel(input, rotary->rel_code, delta);
+		input_sync(input);
+	}
+}
+
+static irqreturn_t bfin_rotary_isr(int irq, void *dev_id)
+{
+	struct platform_device *pdev = dev_id;
+	struct bfin_rot *rotary = platform_get_drvdata(pdev);
+	int delta;
+
+	switch (bfin_read_CNT_STATUS()) {
+
+	case ICII:
+		break;
+
+	case UCII:
+	case DCII:
+		delta = bfin_read_CNT_COUNTER();
+		if (delta)
+			report_rotary_event(rotary, delta);
+		break;
+
+	case CZMII:
+		report_key_event(rotary->input, rotary->button_key);
+		break;
+
+	default:
+		break;
+	}
+
+	bfin_write_CNT_COMMAND(W1LCNT_ZERO);	/* Clear COUNTER */
+	bfin_write_CNT_STATUS(-1);	/* Clear STATUS */
+
+	return IRQ_HANDLED;
+}
+
+static int __devinit bfin_rotary_probe(struct platform_device *pdev)
+{
+	struct bfin_rotary_platform_data *pdata = pdev->dev.platform_data;
+	struct bfin_rot *rotary;
+	struct input_dev *input;
+	int error;
+
+	/* Basic validation */
+	if ((pdata->rotary_up_key && !pdata->rotary_down_key) ||
+	    (!pdata->rotary_up_key && pdata->rotary_down_key)) {
+		return -EINVAL;
+	}
+
+	error = peripheral_request_list(per_cnt, dev_name(&pdev->dev));
+	if (error) {
+		dev_err(&pdev->dev, "requesting peripherals failed\n");
+		return error;
+	}
+
+	rotary = kzalloc(sizeof(struct bfin_rot), GFP_KERNEL);
+	input = input_allocate_device();
+	if (!rotary || !input) {
+		error = -ENOMEM;
+		goto out1;
+	}
+
+	rotary->input = input;
+
+	rotary->up_key = pdata->rotary_up_key;
+	rotary->down_key = pdata->rotary_down_key;
+	rotary->button_key = pdata->rotary_button_key;
+	rotary->rel_code = pdata->rotary_rel_code;
+
+	error = rotary->irq = platform_get_irq(pdev, 0);
+	if (error < 0)
+		goto out1;
+
+	input->name = pdev->name;
+	input->phys = "bfin-rotary/input0";
+	input->dev.parent = &pdev->dev;
+
+	input_set_drvdata(input, rotary);
+
+	input->id.bustype = BUS_HOST;
+	input->id.vendor = 0x0001;
+	input->id.product = 0x0001;
+	input->id.version = 0x0100;
+
+	if (rotary->up_key) {
+		__set_bit(EV_KEY, input->evbit);
+		__set_bit(rotary->up_key, input->keybit);
+		__set_bit(rotary->down_key, input->keybit);
+	} else {
+		__set_bit(EV_REL, input->evbit);
+		__set_bit(rotary->rel_code, input->relbit);
+	}
+
+	if (rotary->button_key) {
+		__set_bit(EV_KEY, input->evbit);
+		__set_bit(rotary->button_key, input->keybit);
+	}
+
+	error = request_irq(rotary->irq, bfin_rotary_isr,
+			    0, dev_name(&pdev->dev), pdev);
+	if (error) {
+		dev_err(&pdev->dev,
+			"unable to claim irq %d; error %d\n",
+			rotary->irq, error);
+		goto out1;
+	}
+
+	error = input_register_device(input);
+	if (error) {
+		dev_err(&pdev->dev,
+			"unable to register input device (%d)\n", error);
+		goto out2;
+	}
+
+	if (pdata->rotary_button_key)
+		bfin_write_CNT_IMASK(CZMIE);
+
+	if (pdata->mode & ROT_DEBE)
+		bfin_write_CNT_DEBOUNCE(pdata->debounce & DPRESCALE);
+
+	if (pdata->mode)
+		bfin_write_CNT_CONFIG(bfin_read_CNT_CONFIG() |
+					(pdata->mode & ~CNTE));
+
+	bfin_write_CNT_IMASK(bfin_read_CNT_IMASK() | UCIE | DCIE);
+	bfin_write_CNT_CONFIG(bfin_read_CNT_CONFIG() | CNTE);
+
+	platform_set_drvdata(pdev, rotary);
+	device_init_wakeup(&pdev->dev, 1);
+
+	return 0;
+
+out2:
+	free_irq(rotary->irq, pdev);
+out1:
+	input_free_device(input);
+	kfree(rotary);
+	peripheral_free_list(per_cnt);
+
+	return error;
+}
+
+static int __devexit bfin_rotary_remove(struct platform_device *pdev)
+{
+	struct bfin_rot *rotary = platform_get_drvdata(pdev);
+
+	bfin_write_CNT_CONFIG(0);
+	bfin_write_CNT_IMASK(0);
+
+	free_irq(rotary->irq, pdev);
+	input_unregister_device(rotary->input);
+	peripheral_free_list(per_cnt);
+
+	kfree(rotary);
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int bfin_rotary_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct bfin_rot *rotary = platform_get_drvdata(pdev);
+
+	rotary->cnt_config = bfin_read_CNT_CONFIG();
+	rotary->cnt_imask = bfin_read_CNT_IMASK();
+	rotary->cnt_debounce = bfin_read_CNT_DEBOUNCE();
+
+	if (device_may_wakeup(&pdev->dev))
+		enable_irq_wake(rotary->irq);
+
+	return 0;
+}
+
+static int bfin_rotary_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct bfin_rot *rotary = platform_get_drvdata(pdev);
+
+	bfin_write_CNT_DEBOUNCE(rotary->cnt_debounce);
+	bfin_write_CNT_IMASK(rotary->cnt_imask);
+	bfin_write_CNT_CONFIG(rotary->cnt_config & ~CNTE);
+
+	if (device_may_wakeup(&pdev->dev))
+		disable_irq_wake(rotary->irq);
+
+	if (rotary->cnt_config & CNTE)
+		bfin_write_CNT_CONFIG(rotary->cnt_config);
+
+	return 0;
+}
+
+static struct dev_pm_ops bfin_rotary_pm_ops = {
+	.suspend	= bfin_rotary_suspend,
+	.resume		= bfin_rotary_resume,
+};
+#endif
+
+static struct platform_driver bfin_rotary_device_driver = {
+	.probe		= bfin_rotary_probe,
+	.remove		= __devexit_p(bfin_rotary_remove),
+	.driver		= {
+		.name	= "bfin-rotary",
+		.owner	= THIS_MODULE,
+#ifdef CONFIG_PM
+		.pm	= &bfin_rotary_pm_ops,
+#endif
+	},
+};
+
+static int __init bfin_rotary_init(void)
+{
+	return platform_driver_register(&bfin_rotary_device_driver);
+}
+module_init(bfin_rotary_init);
+
+static void __exit bfin_rotary_exit(void)
+{
+	platform_driver_unregister(&bfin_rotary_device_driver);
+}
+module_exit(bfin_rotary_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
+MODULE_DESCRIPTION("Rotary Counter driver for Blackfin Processors");
+MODULE_ALIAS("platform:bfin-rotary");

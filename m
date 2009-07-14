From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH 2/2] input/joystick: new Blackfin rotary input driver
Date: Tue, 14 Jul 2009 13:33:47 -0400
Message-ID: <1247592827-16878-2-git-send-email-vapier@gentoo.org>
References: <1247592827-16878-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:55388 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752361AbZGNRdu (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Jul 2009 13:33:50 -0400
In-Reply-To: <1247592827-16878-1-git-send-email-vapier@gentoo.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: uclinux-dist-devel@blackfin.uclinux.org, Michael Hennerich <michael.hennerich@analog.com>, Bryan Wu <cooloney@kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

New driver for the Blackfin on-chip rotary peripheral.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Bryan Wu <cooloney@kernel.org>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 arch/blackfin/include/asm/bfin_rotary.h |   39 ++++
 drivers/input/joystick/Kconfig          |    9 +
 drivers/input/joystick/Makefile         |    1 +
 drivers/input/joystick/bfin_rotary.c    |  288 +++++++++++++++++++++++++++++++
 4 files changed, 337 insertions(+), 0 deletions(-)
 create mode 100644 arch/blackfin/include/asm/bfin_rotary.h
 create mode 100644 drivers/input/joystick/bfin_rotary.c

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
diff --git a/drivers/input/joystick/Kconfig b/drivers/input/joystick/Kconfig
index 0014bd1..875e373 100644
--- a/drivers/input/joystick/Kconfig
+++ b/drivers/input/joystick/Kconfig
@@ -327,4 +327,13 @@ config JOYSTICK_AD7142
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad7142.
 
+config JOYSTICK_BFIN_ROTARY
+	tristate "Blackfin Rotary support"
+	depends on (BF54x || BF52x)
+	help
+	  Say Y here if you want to use the Blackfin Rotary.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called bfin-rotary.
+
 endif
diff --git a/drivers/input/joystick/Makefile b/drivers/input/joystick/Makefile
index a62a667..0bf4cbc 100644
--- a/drivers/input/joystick/Makefile
+++ b/drivers/input/joystick/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_JOYSTICK_AD7142)		+= ad7142.o
 obj-$(CONFIG_JOYSTICK_ADI)		+= adi.o
 obj-$(CONFIG_JOYSTICK_AMIGA)		+= amijoy.o
 obj-$(CONFIG_JOYSTICK_ANALOG)		+= analog.o
+obj-$(CONFIG_JOYSTICK_BFIN_ROTARY)	+= bfin_rotary.o
 obj-$(CONFIG_JOYSTICK_COBRA)		+= cobra.o
 obj-$(CONFIG_JOYSTICK_DB9)		+= db9.o
 obj-$(CONFIG_JOYSTICK_GAMECON)		+= gamecon.o
diff --git a/drivers/input/joystick/bfin_rotary.c b/drivers/input/joystick/bfin_rotary.c
new file mode 100644
index 0000000..d75365c
--- /dev/null
+++ b/drivers/input/joystick/bfin_rotary.c
@@ -0,0 +1,288 @@
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
+	unsigned int rotary_up_key;
+	unsigned int rotary_down_key;
+	unsigned int rotary_button_key;
+	unsigned int rotary_rel_code;
+	unsigned short cnt_config;
+	unsigned short cnt_imask;
+	unsigned short cnt_debounce;
+};
+
+static inline void report_marker_event(struct bfin_rot *rotary)
+{
+	struct input_dev *input = rotary->input;
+	int keycode = rotary->rotary_button_key;
+
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
+	if (delta == 0)
+		return;
+
+	if (rotary->rotary_up_key && rotary->rotary_down_key) {
+		int keycode = (delta > 0) ? rotary->rotary_up_key :
+					    rotary->rotary_down_key;
+
+		/* simulate a press-n-release */
+		input_report_key(input, keycode, 1);
+		input_sync(input);
+		input_report_key(input, keycode, 0);
+		input_sync(input);
+	} else {
+		input_report_rel(input, rotary->rotary_rel_code, delta);
+		input_sync(input);
+	}
+}
+
+static irqreturn_t bfin_rotary_isr(int irq, void *dev_id)
+{
+	struct platform_device *pdev = dev_id;
+	struct bfin_rot *rotary = platform_get_drvdata(pdev);
+	unsigned short status = bfin_read_CNT_STATUS();
+
+	switch (status) {
+	case ICII:
+		break;
+	case UCII:
+	case DCII:
+		report_rotary_event(rotary, bfin_read_CNT_COUNTER());
+		break;
+	case CZMII:
+		report_marker_event(rotary);
+		break;
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
+	struct bfin_rot *rotary;
+	struct bfin_rotary_platform_data *pdata = pdev->dev.platform_data;
+	struct input_dev *input;
+	int ret;
+
+	rotary = kzalloc(sizeof(struct bfin_rot), GFP_KERNEL);
+	if (!rotary)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, rotary);
+
+	ret = peripheral_request_list(per_cnt, dev_name(&pdev->dev));
+	if (ret) {
+		dev_err(&pdev->dev, "requesting peripherals failed\n");
+		goto out1;
+	}
+
+	ret = rotary->irq = platform_get_irq(pdev, 0);
+	if (ret < 0)
+		goto out2;
+
+	ret = request_irq(rotary->irq, bfin_rotary_isr,
+				 0, dev_name(&pdev->dev), pdev);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"unable to claim irq %d; error %d\n",
+			rotary->irq, ret);
+		goto out2;
+	}
+
+	input = input_allocate_device();
+	if (!input) {
+		ret = -ENOMEM;
+		goto out3;
+	}
+
+	rotary->input = input;
+
+	input->name = pdev->name;
+	input->phys = "bfin-rotary/inputX";
+	input->dev.parent = &pdev->dev;
+
+	input_set_drvdata(input, rotary);
+
+	input->id.bustype = BUS_HOST;
+	input->id.vendor = 0x0001;
+	input->id.product = 0x0001;
+	input->id.version = 0x0100;
+
+	/* setup input device */
+
+	rotary->rotary_up_key = pdata->rotary_up_key;
+	rotary->rotary_down_key = pdata->rotary_down_key;
+	rotary->rotary_button_key = pdata->rotary_button_key;
+	rotary->rotary_rel_code = pdata->rotary_rel_code;
+
+	if (pdata->rotary_up_key && pdata->rotary_down_key) {
+		__set_bit(EV_KEY, input->evbit);
+		__set_bit(pdata->rotary_up_key, input->keybit);
+		__set_bit(pdata->rotary_down_key, input->keybit);
+	} else if (pdata->rotary_rel_code) {
+		__set_bit(EV_REL, input->evbit);
+		__set_bit(pdata->rotary_rel_code, input->relbit);
+	} else {
+		ret = -EINVAL;
+		goto out4;
+	}
+
+	if (pdata->rotary_button_key) {
+		__set_bit(EV_KEY, input->evbit);
+		__set_bit(pdata->rotary_button_key, input->keybit);
+		bfin_write_CNT_IMASK(CZMIE);
+	}
+
+	if (pdata->mode & ROT_DEBE)
+		bfin_write_CNT_DEBOUNCE(pdata->debounce & DPRESCALE);
+
+	if (pdata->mode)
+		bfin_write_CNT_CONFIG(bfin_read_CNT_CONFIG() |
+					(pdata->mode & ~CNTE));
+
+	ret = input_register_device(input);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"unable to register input device (%d)\n", ret);
+		goto out4;
+	}
+
+	bfin_write_CNT_IMASK(bfin_read_CNT_IMASK() | UCIE | DCIE);
+	bfin_write_CNT_CONFIG(bfin_read_CNT_CONFIG() | CNTE);
+	device_init_wakeup(&pdev->dev, 1);
+
+	dev_info(&pdev->dev,
+		"Blackfin Rotary Driver registered IRQ %d\n", rotary->irq);
+	return 0;
+
+out4:
+	input_free_device(input);
+out3:
+	free_irq(rotary->irq, pdev);
+out2:
+	peripheral_free_list(per_cnt);
+out1:
+	kfree(rotary);
+	platform_set_drvdata(pdev, NULL);
+
+	return ret;
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
+static int bfin_rotary_suspend(struct platform_device *pdev, pm_message_t state)
+{
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
+static int bfin_rotary_resume(struct platform_device *pdev)
+{
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
+#else
+#define bfin_rotary_suspend NULL
+#define bfin_rotary_resume  NULL
+#endif
+
+struct platform_driver bfin_rotary_device_driver = {
+	.probe		= bfin_rotary_probe,
+	.remove		= __devexit_p(bfin_rotary_remove),
+	.suspend	= bfin_rotary_suspend,
+	.resume		= bfin_rotary_resume,
+	.driver		= {
+		.name	= "bfin-rotary",
+		.owner	= THIS_MODULE,
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
-- 
1.6.3.3


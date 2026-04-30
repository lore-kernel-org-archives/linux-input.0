Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CED33EB10;
	Thu, 30 Apr 2026 16:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777567431; cv=none; b=LD8YLj++m8Yur7/+ecC2GEmfgjfFddbb/xdUwwGIr6TQ/EjLkDxT8UC65E/btc6tSiCo3fzTK92Xq9R+D8CymjSmbENjI3CDOy4fZKwXy5zlV4kRh6s6JrPOc9sHiLCiQrbcFfgmUOfX3XQfSaznmK9cfHICzRVJKinae3QH3Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777567431; c=relaxed/simple;
	bh=W60QlEGQY7R/p2X61VGSVCKKfosx5mD7nj7fHtSbTfg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JWgsLYVyJ66/4qE5WKXwBtm2b0MKn9JiKVFhuYFsj8SUZSBKR5bo2cm5YUvtLAAkiBml+YmGMxWltxvjIF9GG9HpASq4lxQvqH0G/csN0EgS9RE532omveJ8CNOQfBrrHj7qvlvS2LjwyUXEC11sbif+G3hC7EeQGYboxR/LDQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JLJNRqzf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLJNRqzf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9876CC2BCB3;
	Thu, 30 Apr 2026 16:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777567430;
	bh=W60QlEGQY7R/p2X61VGSVCKKfosx5mD7nj7fHtSbTfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JLJNRqzfN9G1N2QwYeooMDOvkDXNOvV7na3Y+pYdRvaCR6W0WYF6x9yhz1TsGORxp
	 IhNg+9IW7uxAvlEJdEHg2dkxtJ0ccQx0n2VPguh+WaWibO6AniZRBOedgRskrWaGlx
	 kYiha8G0sCqhK7LU74rXZH5fYpRWBTwNQDuQc2/9irmeCNwbPZArhNdoKm3QWQZeh6
	 XJwaT3TXj345rOjlc/3/9BIoWrKZWpVHJn6DIdUPkXh8FvMa/6fgEXGQTZzlT+GN2G
	 jnLTlmQ0/jRCrWNC3lGY9Dhy3jKDy4U3yrKAmhl7aEnfKpxqZ/X86ysmkWViriOdE+
	 nzPIiHVIZ3uYw==
From: Arnd Bergmann <arnd@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: [PATCH 2/2] input: pcap_ts - remove unused driver
Date: Thu, 30 Apr 2026 18:42:48 +0200
Message-Id: <20260430164326.2766500-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260430164326.2766500-1-arnd@kernel.org>
References: <20260430164326.2766500-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Support for the ezx series of phones was removed in 2022, this
driver is just dead code.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/input/touchscreen/Kconfig   |  10 --
 drivers/input/touchscreen/Makefile  |   1 -
 drivers/input/touchscreen/pcap_ts.c | 252 ----------------------------
 3 files changed, 263 deletions(-)
 delete mode 100644 drivers/input/touchscreen/pcap_ts.c

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index aeaf9a9cbb41..484522d8d675 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -1178,16 +1178,6 @@ config TOUCHSCREEN_TSC2007_IIO
 	  or ambient light monitoring), temperature and raw input
 	  values.
 
-config TOUCHSCREEN_PCAP
-	tristate "Motorola PCAP touchscreen"
-	depends on EZX_PCAP
-	help
-	  Say Y here if you have a Motorola EZX telephone and
-	  want to enable support for the built-in touchscreen.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called pcap_ts.
-
 config TOUCHSCREEN_RM_TS
 	tristate "Raydium I2C Touchscreen"
 	depends on I2C
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index f2b002abebe8..6d397268d2e3 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -74,7 +74,6 @@ obj-$(CONFIG_TOUCHSCREEN_HP7XX)		+= jornada720_ts.o
 obj-$(CONFIG_TOUCHSCREEN_IPAQ_MICRO)	+= ipaq-micro-ts.o
 obj-$(CONFIG_TOUCHSCREEN_HTCPEN)	+= htcpen.o
 obj-$(CONFIG_TOUCHSCREEN_USB_COMPOSITE)	+= usbtouchscreen.o
-obj-$(CONFIG_TOUCHSCREEN_PCAP)		+= pcap_ts.o
 obj-$(CONFIG_TOUCHSCREEN_PENMOUNT)	+= penmount.o
 obj-$(CONFIG_TOUCHSCREEN_PIXCIR)	+= pixcir_i2c_ts.o
 obj-$(CONFIG_TOUCHSCREEN_RM_TS)		+= raydium_i2c_ts.o
diff --git a/drivers/input/touchscreen/pcap_ts.c b/drivers/input/touchscreen/pcap_ts.c
deleted file mode 100644
index 7b89eb74b9de..000000000000
--- a/drivers/input/touchscreen/pcap_ts.c
+++ /dev/null
@@ -1,252 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Driver for Motorola PCAP2 touchscreen as found in the EZX phone platform.
- *
- *  Copyright (C) 2006 Harald Welte <laforge@openezx.org>
- *  Copyright (C) 2009 Daniel Ribeiro <drwyrm@gmail.com>
- */
-
-#include <linux/module.h>
-#include <linux/fs.h>
-#include <linux/string.h>
-#include <linux/slab.h>
-#include <linux/pm.h>
-#include <linux/timer.h>
-#include <linux/interrupt.h>
-#include <linux/platform_device.h>
-#include <linux/input.h>
-#include <linux/mfd/ezx-pcap.h>
-
-struct pcap_ts {
-	struct pcap_chip *pcap;
-	struct input_dev *input;
-	struct delayed_work work;
-	u16 x, y;
-	u16 pressure;
-	u8 read_state;
-};
-
-#define SAMPLE_DELAY	20 /* msecs */
-
-#define X_AXIS_MIN	0
-#define X_AXIS_MAX	1023
-#define Y_AXIS_MAX	X_AXIS_MAX
-#define Y_AXIS_MIN	X_AXIS_MIN
-#define PRESSURE_MAX	X_AXIS_MAX
-#define PRESSURE_MIN	X_AXIS_MIN
-
-static void pcap_ts_read_xy(void *data, u16 res[2])
-{
-	struct pcap_ts *pcap_ts = data;
-
-	switch (pcap_ts->read_state) {
-	case PCAP_ADC_TS_M_PRESSURE:
-		/* pressure reading is unreliable */
-		if (res[0] > PRESSURE_MIN && res[0] < PRESSURE_MAX)
-			pcap_ts->pressure = res[0];
-		pcap_ts->read_state = PCAP_ADC_TS_M_XY;
-		schedule_delayed_work(&pcap_ts->work, 0);
-		break;
-	case PCAP_ADC_TS_M_XY:
-		pcap_ts->y = res[0];
-		pcap_ts->x = res[1];
-		if (pcap_ts->x <= X_AXIS_MIN || pcap_ts->x >= X_AXIS_MAX ||
-		    pcap_ts->y <= Y_AXIS_MIN || pcap_ts->y >= Y_AXIS_MAX) {
-			/* pen has been released */
-			input_report_abs(pcap_ts->input, ABS_PRESSURE, 0);
-			input_report_key(pcap_ts->input, BTN_TOUCH, 0);
-
-			pcap_ts->read_state = PCAP_ADC_TS_M_STANDBY;
-			schedule_delayed_work(&pcap_ts->work, 0);
-		} else {
-			/* pen is touching the screen */
-			input_report_abs(pcap_ts->input, ABS_X, pcap_ts->x);
-			input_report_abs(pcap_ts->input, ABS_Y, pcap_ts->y);
-			input_report_key(pcap_ts->input, BTN_TOUCH, 1);
-			input_report_abs(pcap_ts->input, ABS_PRESSURE,
-						pcap_ts->pressure);
-
-			/* switch back to pressure read mode */
-			pcap_ts->read_state = PCAP_ADC_TS_M_PRESSURE;
-			schedule_delayed_work(&pcap_ts->work,
-					msecs_to_jiffies(SAMPLE_DELAY));
-		}
-		input_sync(pcap_ts->input);
-		break;
-	default:
-		dev_warn(&pcap_ts->input->dev,
-				"pcap_ts: Warning, unhandled read_state %d\n",
-				pcap_ts->read_state);
-		break;
-	}
-}
-
-static void pcap_ts_work(struct work_struct *work)
-{
-	struct delayed_work *dw = to_delayed_work(work);
-	struct pcap_ts *pcap_ts = container_of(dw, struct pcap_ts, work);
-	u8 ch[2];
-
-	pcap_set_ts_bits(pcap_ts->pcap,
-			pcap_ts->read_state << PCAP_ADC_TS_M_SHIFT);
-
-	if (pcap_ts->read_state == PCAP_ADC_TS_M_STANDBY)
-		return;
-
-	/* start adc conversion */
-	ch[0] = PCAP_ADC_CH_TS_X1;
-	ch[1] = PCAP_ADC_CH_TS_Y1;
-	pcap_adc_async(pcap_ts->pcap, PCAP_ADC_BANK_1, 0, ch,
-						pcap_ts_read_xy, pcap_ts);
-}
-
-static irqreturn_t pcap_ts_event_touch(int pirq, void *data)
-{
-	struct pcap_ts *pcap_ts = data;
-
-	if (pcap_ts->read_state == PCAP_ADC_TS_M_STANDBY) {
-		pcap_ts->read_state = PCAP_ADC_TS_M_PRESSURE;
-		schedule_delayed_work(&pcap_ts->work, 0);
-	}
-	return IRQ_HANDLED;
-}
-
-static int pcap_ts_open(struct input_dev *dev)
-{
-	struct pcap_ts *pcap_ts = input_get_drvdata(dev);
-
-	pcap_ts->read_state = PCAP_ADC_TS_M_STANDBY;
-	schedule_delayed_work(&pcap_ts->work, 0);
-
-	return 0;
-}
-
-static void pcap_ts_close(struct input_dev *dev)
-{
-	struct pcap_ts *pcap_ts = input_get_drvdata(dev);
-
-	cancel_delayed_work_sync(&pcap_ts->work);
-
-	pcap_ts->read_state = PCAP_ADC_TS_M_NONTS;
-	pcap_set_ts_bits(pcap_ts->pcap,
-				pcap_ts->read_state << PCAP_ADC_TS_M_SHIFT);
-}
-
-static int pcap_ts_probe(struct platform_device *pdev)
-{
-	struct input_dev *input_dev;
-	struct pcap_ts *pcap_ts;
-	int err = -ENOMEM;
-
-	pcap_ts = kzalloc_obj(*pcap_ts);
-	if (!pcap_ts)
-		return err;
-
-	pcap_ts->pcap = dev_get_drvdata(pdev->dev.parent);
-	platform_set_drvdata(pdev, pcap_ts);
-
-	input_dev = input_allocate_device();
-	if (!input_dev)
-		goto fail;
-
-	INIT_DELAYED_WORK(&pcap_ts->work, pcap_ts_work);
-
-	pcap_ts->read_state = PCAP_ADC_TS_M_NONTS;
-	pcap_set_ts_bits(pcap_ts->pcap,
-				pcap_ts->read_state << PCAP_ADC_TS_M_SHIFT);
-
-	pcap_ts->input = input_dev;
-	input_set_drvdata(input_dev, pcap_ts);
-
-	input_dev->name = "pcap-touchscreen";
-	input_dev->phys = "pcap_ts/input0";
-	input_dev->id.bustype = BUS_HOST;
-	input_dev->id.vendor = 0x0001;
-	input_dev->id.product = 0x0002;
-	input_dev->id.version = 0x0100;
-	input_dev->dev.parent = &pdev->dev;
-	input_dev->open = pcap_ts_open;
-	input_dev->close = pcap_ts_close;
-
-	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
-	input_dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
-	input_set_abs_params(input_dev, ABS_X, X_AXIS_MIN, X_AXIS_MAX, 0, 0);
-	input_set_abs_params(input_dev, ABS_Y, Y_AXIS_MIN, Y_AXIS_MAX, 0, 0);
-	input_set_abs_params(input_dev, ABS_PRESSURE, PRESSURE_MIN,
-			     PRESSURE_MAX, 0, 0);
-
-	err = input_register_device(pcap_ts->input);
-	if (err)
-		goto fail_allocate;
-
-	err = request_irq(pcap_to_irq(pcap_ts->pcap, PCAP_IRQ_TS),
-			pcap_ts_event_touch, 0, "Touch Screen", pcap_ts);
-	if (err)
-		goto fail_register;
-
-	return 0;
-
-fail_register:
-	input_unregister_device(input_dev);
-	goto fail;
-fail_allocate:
-	input_free_device(input_dev);
-fail:
-	kfree(pcap_ts);
-
-	return err;
-}
-
-static void pcap_ts_remove(struct platform_device *pdev)
-{
-	struct pcap_ts *pcap_ts = platform_get_drvdata(pdev);
-
-	free_irq(pcap_to_irq(pcap_ts->pcap, PCAP_IRQ_TS), pcap_ts);
-	cancel_delayed_work_sync(&pcap_ts->work);
-
-	input_unregister_device(pcap_ts->input);
-
-	kfree(pcap_ts);
-}
-
-#ifdef CONFIG_PM
-static int pcap_ts_suspend(struct device *dev)
-{
-	struct pcap_ts *pcap_ts = dev_get_drvdata(dev);
-
-	pcap_set_ts_bits(pcap_ts->pcap, PCAP_ADC_TS_REF_LOWPWR);
-	return 0;
-}
-
-static int pcap_ts_resume(struct device *dev)
-{
-	struct pcap_ts *pcap_ts = dev_get_drvdata(dev);
-
-	pcap_set_ts_bits(pcap_ts->pcap,
-				pcap_ts->read_state << PCAP_ADC_TS_M_SHIFT);
-	return 0;
-}
-
-static const struct dev_pm_ops pcap_ts_pm_ops = {
-	.suspend	= pcap_ts_suspend,
-	.resume		= pcap_ts_resume,
-};
-#define PCAP_TS_PM_OPS (&pcap_ts_pm_ops)
-#else
-#define PCAP_TS_PM_OPS NULL
-#endif
-
-static struct platform_driver pcap_ts_driver = {
-	.probe		= pcap_ts_probe,
-	.remove		= pcap_ts_remove,
-	.driver		= {
-		.name	= "pcap-ts",
-		.pm	= PCAP_TS_PM_OPS,
-	},
-};
-module_platform_driver(pcap_ts_driver);
-
-MODULE_DESCRIPTION("Motorola PCAP2 touchscreen driver");
-MODULE_AUTHOR("Daniel Ribeiro / Harald Welte");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:pcap_ts");
-- 
2.39.5


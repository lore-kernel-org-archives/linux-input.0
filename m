From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v8] input: Add Synaptics NavPoint (PXA27x SSP/SPI) driver
Date: Wed, 9 May 2012 01:00:06 -0700
Message-ID: <20120509080006.GJ10514@core.coreip.homeip.net>
References: <1334576221.72161.YahooMailClassic@web29005.mail.ird.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:61239 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757Ab2EIIAM (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 May 2012 04:00:12 -0400
Received: by dady13 with SMTP id y13so3719401dad.19
        for <linux-input@vger.kernel.org>; Wed, 09 May 2012 01:00:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1334576221.72161.YahooMailClassic@web29005.mail.ird.yahoo.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Paul Parsons <lost.distance@yahoo.com>
Cc: philipp.zabel@gmail.com, linux-input@vger.kernel.org

Hi Paul,

On Mon, Apr 16, 2012 at 12:37:01PM +0100, Paul Parsons wrote:
> This driver adds support for the Synaptics NavPoint touchpad connected
> to a PXA27x SSP port in SPI slave mode. The device emulates a mouse;
> a tap or tap-and-a-half drag gesture emulates the left mouse button.
> For example, use the xf86-input-evdev driver for an X pointing device.
> 

The driver looks excellent now, I have just a few nits:

- you do not need separate mutex and counter; it is perfectly fine to
  use input device's ones;

- we don't really need min/max for coordinates: the defaults are good
  for your device and if more devices come with different limits one
  could adjust limits via EVIOCSABS ioctls.

I also took libertu if rearranging the code a bit so it flows more like
the rest of the input drivers. Could you please tell me if the patch
below breaks your device or if it still works?

Thanks!

-- 
Dmitry


Input: navpoint - misc changes

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/mouse/navpoint.c |  291 +++++++++++++++++++---------------------
 1 files changed, 140 insertions(+), 151 deletions(-)


diff --git a/drivers/input/mouse/navpoint.c b/drivers/input/mouse/navpoint.c
index 7d5db52..c29ae76 100644
--- a/drivers/input/mouse/navpoint.c
+++ b/drivers/input/mouse/navpoint.c
@@ -1,9 +1,11 @@
 /*
- *  Copyright (C) 2012 Paul Parsons <lost.distance@yahoo.com>
+ * Synaptics NavPoint (PXA27x SSP/SPI) driver.
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
+ * Copyright (C) 2012 Paul Parsons <lost.distance@yahoo.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
  */
 
 #include <linux/kernel.h>
@@ -21,31 +23,26 @@
 #include <linux/slab.h>
 
 /*
- *	Synaptics NavPoint (PXA27x SSP/SPI) driver.
- */
-
-/*
- *	Synaptics Modular Embedded Protocol: Module Packet Format.
- *	Module header byte 2:0 = Length (# bytes that follow)
- *	Module header byte 4:3 = Control
- *	Module header byte 7:5 = Module Address
+ * Synaptics Modular Embedded Protocol: Module Packet Format.
+ * Module header byte 2:0 = Length (# bytes that follow)
+ * Module header byte 4:3 = Control
+ * Module header byte 7:5 = Module Address
  */
 #define HEADER_LENGTH(byte)	((byte) & 0x07)
 #define HEADER_CONTROL(byte)	(((byte) >> 3) & 0x03)
 #define HEADER_ADDRESS(byte)	((byte) >> 5)
 
-struct driver_data {
-	struct mutex		mutex;
-	int			opened;
+struct navpoint {
 	struct ssp_device	*ssp;
-	int			gpio;
 	struct input_dev	*input;
+	struct device		*dev;
+	int			gpio;
 	int			index;
-	uint8_t			data[1+HEADER_LENGTH(0xff)];
+	u8			data[1 + HEADER_LENGTH(0xff)];
 };
 
 /*
- *	Initialization values for SSCR0_x, SSCR1_x, SSSR_x.
+ * Initialization values for SSCR0_x, SSCR1_x, SSSR_x.
  */
 static const u32 sscr0 = 0
 	| SSCR0_TUM		/* TIM = 1; No TUR interrupts */
@@ -73,78 +70,65 @@ static const u32 sssr = 0
 	;
 
 /*
- *	MEP Query $22: Touchpad Coordinate Range Query is not supported by
- *	the NavPoint module, so sampled values provide the default limits.
+ * MEP Query $22: Touchpad Coordinate Range Query is not supported by
+ * the NavPoint module, so sampled values provide the default limits.
  */
-static int xmin = 1278;
-module_param(xmin, int, 0644);
-MODULE_PARM_DESC(xmin, "Minimum X coordinate. Default = 1278");
-static int xmax = 5340;
-module_param(xmax, int, 0644);
-MODULE_PARM_DESC(xmax, "Maximum X coordinate. Default = 5340");
-static int ymin = 1572;
-module_param(ymin, int, 0644);
-MODULE_PARM_DESC(ymin, "Minimum Y coordinate. Default = 1572");
-static int ymax = 4396;
-module_param(ymax, int, 0644);
-MODULE_PARM_DESC(ymax, "Maximum Y coordinate. Default = 4396");
-static int pmin = 0;
-module_param(pmin, int, 0644);
-MODULE_PARM_DESC(pmin, "Minimum pressure. Default = 0");
-static int pmax = 255;
-module_param(pmax, int, 0644);
-MODULE_PARM_DESC(pmax, "Maximum pressure. Default = 255");
-
-static void navpoint_packet(struct device *dev)
+#define NAVPOINT_X_MIN		1278
+#define NAVPOINT_X_MAX		5340
+#define NAVPOINT_Y_MIN		1572
+#define NAVPOINT_Y_MAX		4396
+#define NAVPOINT_PRESSURE_MIN	0
+#define NAVPOINT_PRESSURE_MAX	255
+
+static void navpoint_packet(struct navpoint *navpoint)
 {
-	struct driver_data *drv_data = dev_get_drvdata(dev);
 	int finger;
 	int gesture;
 	int x, y, z;
 
-	switch (drv_data->data[0]) {
+	switch (navpoint->data[0]) {
 	case 0xff:	/* Garbage (packet?) between reset and Hello packet */
 	case 0x00:	/* Module 0, NULL packet */
 		break;
+
 	case 0x0e:	/* Module 0, Absolute packet */
-		finger = (drv_data->data[1] & 0x01);
-		gesture = (drv_data->data[1] & 0x02);
-		x = ((drv_data->data[2] & 0x1f) << 8) | drv_data->data[3];
-		y = ((drv_data->data[4] & 0x1f) << 8) | drv_data->data[5];
-		z = drv_data->data[6];
-		input_report_key(drv_data->input, BTN_TOUCH, finger);
-		input_report_abs(drv_data->input, ABS_X, x);
-		input_report_abs(drv_data->input, ABS_Y, y);
-		input_report_abs(drv_data->input, ABS_PRESSURE, z);
-		input_report_key(drv_data->input, BTN_TOOL_FINGER, finger);
-		input_report_key(drv_data->input, BTN_LEFT, gesture);
-		input_sync(drv_data->input);
+		finger = (navpoint->data[1] & 0x01);
+		gesture = (navpoint->data[1] & 0x02);
+		x = ((navpoint->data[2] & 0x1f) << 8) | navpoint->data[3];
+		y = ((navpoint->data[4] & 0x1f) << 8) | navpoint->data[5];
+		z = navpoint->data[6];
+		input_report_key(navpoint->input, BTN_TOUCH, finger);
+		input_report_abs(navpoint->input, ABS_X, x);
+		input_report_abs(navpoint->input, ABS_Y, y);
+		input_report_abs(navpoint->input, ABS_PRESSURE, z);
+		input_report_key(navpoint->input, BTN_TOOL_FINGER, finger);
+		input_report_key(navpoint->input, BTN_LEFT, gesture);
+		input_sync(navpoint->input);
 		break;
+
 	case 0x19:	/* Module 0, Hello packet */
-		if ((drv_data->data[1] & 0xf0) == 0x10)
+		if ((navpoint->data[1] & 0xf0) == 0x10)
 			break;
 		/* FALLTHROUGH */
 	default:
-		dev_warn(dev, "spurious packet: data=0x%02x,0x%02x,...\n",
-			drv_data->data[0],
-			drv_data->data[1]);
+		dev_warn(navpoint->dev,
+			 "spurious packet: data=0x%02x,0x%02x,...\n",
+			 navpoint->data[0], navpoint->data[1]);
 		break;
 	}
 }
 
-static irqreturn_t navpoint_int(int irq, void *dev_id)
+static irqreturn_t navpoint_irq(int irq, void *dev_id)
 {
-	struct device *dev = dev_id;
-	struct driver_data *drv_data = dev_get_drvdata(dev);
-	struct ssp_device *ssp = drv_data->ssp;
+	struct navpoint *navpoint = dev_id;
+	struct ssp_device *ssp = navpoint->ssp;
+	irqreturn_t ret = IRQ_NONE;
 	u32 status;
-	irqreturn_t ret;
 
 	status = pxa_ssp_read_reg(ssp, SSSR);
-	ret = IRQ_NONE;
-
 	if (status & sssr) {
-		dev_warn(dev, "unexpected interrupt: status=0x%08x\n", status);
+		dev_warn(navpoint->dev,
+			 "unexpected interrupt: status=0x%08x\n", status);
 		pxa_ssp_write_reg(ssp, SSSR, (status & sssr));
 		ret = IRQ_HANDLED;
 	}
@@ -153,12 +137,12 @@ static irqreturn_t navpoint_int(int irq, void *dev_id)
 		u32 data;
 
 		data = pxa_ssp_read_reg(ssp, SSDR);
-		drv_data->data[drv_data->index + 0] = (data >> 8);
-		drv_data->data[drv_data->index + 1] = data;
-		drv_data->index += 2;
-		if (HEADER_LENGTH(drv_data->data[0]) < drv_data->index) {
-			navpoint_packet(dev);
-			drv_data->index = 0;
+		navpoint->data[navpoint->index + 0] = (data >> 8);
+		navpoint->data[navpoint->index + 1] = data;
+		navpoint->index += 2;
+		if (HEADER_LENGTH(navpoint->data[0]) < navpoint->index) {
+			navpoint_packet(navpoint);
+			navpoint->index = 0;
 		}
 		status = pxa_ssp_read_reg(ssp, SSSR);
 		ret = IRQ_HANDLED;
@@ -167,10 +151,9 @@ static irqreturn_t navpoint_int(int irq, void *dev_id)
 	return ret;
 }
 
-static void navpoint_up(struct device *dev)
+static void navpoint_up(struct navpoint *navpoint)
 {
-	struct driver_data *drv_data = dev_get_drvdata(dev);
-	struct ssp_device *ssp = drv_data->ssp;
+	struct ssp_device *ssp = navpoint->ssp;
 	int timeout;
 
 	clk_prepare_enable(ssp->clk);
@@ -186,20 +169,21 @@ static void navpoint_up(struct device *dev)
 			break;
 		msleep(1);
 	}
+
 	if (timeout == 0)
-		dev_err(dev, "timeout waiting for SSSR[CSS] to clear\n");
+		dev_err(navpoint->dev,
+			"timeout waiting for SSSR[CSS] to clear\n");
 
-	if (gpio_is_valid(drv_data->gpio))
-		gpio_set_value(drv_data->gpio, 1);
+	if (gpio_is_valid(navpoint->gpio))
+		gpio_set_value(navpoint->gpio, 1);
 }
 
-static void navpoint_down(struct device *dev)
+static void navpoint_down(struct navpoint *navpoint)
 {
-	struct driver_data *drv_data = dev_get_drvdata(dev);
-	struct ssp_device *ssp = drv_data->ssp;
+	struct ssp_device *ssp = navpoint->ssp;
 
-	if (gpio_is_valid(drv_data->gpio))
-		gpio_set_value(drv_data->gpio, 0);
+	if (gpio_is_valid(navpoint->gpio))
+		gpio_set_value(navpoint->gpio, 0);
 
 	pxa_ssp_write_reg(ssp, SSCR0, 0);
 
@@ -208,32 +192,28 @@ static void navpoint_down(struct device *dev)
 
 static int navpoint_open(struct input_dev *input)
 {
-	struct driver_data *drv_data = dev_get_drvdata(input->dev.parent);
+	struct navpoint *navpoint = input_get_drvdata(input);
+
+	navpoint_up(navpoint);
 
-	mutex_lock(&drv_data->mutex);
-	navpoint_up(input->dev.parent);
-	drv_data->opened = 1;
-	mutex_unlock(&drv_data->mutex);
 	return 0;
 }
 
 static void navpoint_close(struct input_dev *input)
 {
-	struct driver_data *drv_data = dev_get_drvdata(input->dev.parent);
+	struct navpoint *navpoint = input_get_drvdata(input);
 
-	mutex_lock(&drv_data->mutex);
-	navpoint_down(input->dev.parent);
-	drv_data->opened = 0;
-	mutex_unlock(&drv_data->mutex);
+	navpoint_down(navpoint);
 }
 
 static int __devinit navpoint_probe(struct platform_device *pdev)
 {
-	struct navpoint_platform_data *pdata = pdev->dev.platform_data;
-	int ret;
+	const struct navpoint_platform_data *pdata =
+					dev_get_platdata(&pdev->dev);
 	struct ssp_device *ssp;
 	struct input_dev *input;
-	struct driver_data *drv_data;
+	struct navpoint *navpoint;
+	int error;
 
 	if (!pdata) {
 		dev_err(&pdev->dev, "no platform data\n");
@@ -241,16 +221,16 @@ static int __devinit navpoint_probe(struct platform_device *pdev)
 	}
 
 	if (gpio_is_valid(pdata->gpio)) {
-		ret = gpio_request_one(pdata->gpio, GPIOF_OUT_INIT_LOW,
-			"SYNAPTICS_ON");
-		if (ret)
-			return ret;
+		error = gpio_request_one(pdata->gpio, GPIOF_OUT_INIT_LOW,
+					 "SYNAPTICS_ON");
+		if (error)
+			return error;
 	}
 
 	ssp = pxa_ssp_request(pdata->port, pdev->name);
 	if (!ssp) {
-		ret = -ENODEV;
-		goto ret1;
+		error = -ENODEV;
+		goto err_free_gpio;
 	}
 
 	/* HaRET does not disable devices before jumping into Linux */
@@ -259,74 +239,77 @@ static int __devinit navpoint_probe(struct platform_device *pdev)
 		dev_warn(&pdev->dev, "ssp%d already enabled\n", pdata->port);
 	}
 
+	navpoint = kzalloc(sizeof(*navpoint), GFP_KERNEL);
 	input = input_allocate_device();
-	if (!input) {
-		ret = -ENOMEM;
-		goto ret2;
+	if (!navpoint || !input) {
+		error = -ENOMEM;
+		goto err_free_mem;
 	}
+
+	navpoint->ssp = ssp;
+	navpoint->input = input;
+	navpoint->dev = &pdev->dev;
+	navpoint->gpio = pdata->gpio;
+
 	input->name = pdev->name;
+	input->dev.parent = &pdev->dev;
+
 	__set_bit(EV_KEY, input->evbit);
 	__set_bit(EV_ABS, input->evbit);
+	__set_bit(BTN_LEFT, input->keybit);
 	__set_bit(BTN_TOUCH, input->keybit);
-	input_set_abs_params(input, ABS_X, xmin, xmax, 0, 0);
-	input_set_abs_params(input, ABS_Y, ymin, ymax, 0, 0);
-	input_set_abs_params(input, ABS_PRESSURE, pmin, pmax, 0, 0);
 	__set_bit(BTN_TOOL_FINGER, input->keybit);
-	__set_bit(BTN_LEFT, input->keybit);
+
+	input_set_abs_params(input, ABS_X,
+			     NAVPOINT_X_MIN, NAVPOINT_X_MAX, 0, 0);
+	input_set_abs_params(input, ABS_Y,
+			     NAVPOINT_Y_MIN, NAVPOINT_Y_MAX, 0, 0);
+	input_set_abs_params(input, ABS_PRESSURE,
+			     NAVPOINT_PRESSURE_MIN, NAVPOINT_PRESSURE_MAX,
+			     0, 0);
+
 	input->open = navpoint_open;
 	input->close = navpoint_close;
-	input->dev.parent = &pdev->dev;
 
-	drv_data = kzalloc(sizeof(*drv_data), GFP_KERNEL);
-	if (!drv_data) {
-		ret = -ENOMEM;
-		goto ret3;
-	}
-	mutex_init(&drv_data->mutex);
-	drv_data->ssp = ssp;
-	drv_data->gpio = pdata->gpio;
-	drv_data->input = input;
-	platform_set_drvdata(pdev, drv_data);
+	input_set_drvdata(input, navpoint);
 
-	ret = request_irq(ssp->irq, navpoint_int, 0, pdev->name, &pdev->dev);
-	if (ret)
-		goto ret4;
+	error = request_irq(ssp->irq, navpoint_irq, 0, pdev->name, navpoint);
+	if (error)
+		goto err_free_mem;
 
-	ret = input_register_device(input);
-	if (ret)
-		goto ret5;
+	error = input_register_device(input);
+	if (error)
+		goto err_free_irq;
 
+	platform_set_drvdata(pdev, navpoint);
 	dev_dbg(&pdev->dev, "ssp%d, irq %d\n", pdata->port, ssp->irq);
 
 	return 0;
 
-ret5:
+err_free_irq:
 	free_irq(ssp->irq, &pdev->dev);
-ret4:
-	kfree(drv_data);
-ret3:
+err_free_mem:
 	input_free_device(input);
-ret2:
+	kfree(navpoint);
 	pxa_ssp_free(ssp);
-ret1:
+err_free_gpio:
 	if (gpio_is_valid(pdata->gpio))
 		gpio_free(pdata->gpio);
 
-	return ret;
+	return error;
 }
 
 static int __devexit navpoint_remove(struct platform_device *pdev)
 {
-	struct driver_data *drv_data = platform_get_drvdata(pdev);
-	struct input_dev *input = drv_data->input;
-	struct ssp_device *ssp = drv_data->ssp;
-	struct navpoint_platform_data *pdata = pdev->dev.platform_data;
-
-	input_unregister_device(input);
+	const struct navpoint_platform_data *pdata =
+					dev_get_platdata(&pdev->dev);
+	struct navpoint *navpoint = platform_get_drvdata(pdev);
+	struct ssp_device *ssp = navpoint->ssp;
 
-	free_irq(ssp->irq, &pdev->dev);
+	free_irq(ssp->irq, navpoint);
 
-	kfree(drv_data);
+	input_unregister_device(navpoint->input);
+	kfree(navpoint);
 
 	pxa_ssp_free(ssp);
 
@@ -339,23 +322,29 @@ static int __devexit navpoint_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int navpoint_suspend(struct device *dev)
 {
-	struct driver_data *drv_data = dev_get_drvdata(dev);
+	struct platform_device *pdev = to_platform_device(dev);
+	struct navpoint *navpoint = platform_get_drvdata(pdev);
+	struct input_dev *input = navpoint->input;
+
+	mutex_lock(&input->mutex);
+	if (input->users)
+		navpoint_down(navpoint);
+	mutex_unlock(&input->mutex);
 
-	mutex_lock(&drv_data->mutex);
-	if (drv_data->opened)
-		navpoint_down(dev);
-	mutex_unlock(&drv_data->mutex);
 	return 0;
 }
 
 static int navpoint_resume(struct device *dev)
 {
-	struct driver_data *drv_data = dev_get_drvdata(dev);
+	struct platform_device *pdev = to_platform_device(dev);
+	struct navpoint *navpoint = platform_get_drvdata(pdev);
+	struct input_dev *input = navpoint->input;
+
+	mutex_lock(&input->mutex);
+	if (input->users)
+		navpoint_up(navpoint);
+	mutex_unlock(&input->mutex);
 
-	mutex_lock(&drv_data->mutex);
-	if (drv_data->opened)
-		navpoint_up(dev);
-	mutex_unlock(&drv_data->mutex);
 	return 0;
 }
 #endif

From: Christopher Heiny <cheiny@synaptics.com>
Subject: [PATCH 01/02] input synaptics-rmi4: remove rmi_f01 interrupt enable handling
Date: Tue, 4 Mar 2014 19:39:19 -0800
Message-ID: <1393990760-2587-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:14770 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755658AbaCEDj1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Mar 2014 22:39:27 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Christopher Heiny <cheiny@synaptics.com>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>

This functionality has been moved to rmi_driver.c.

Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Linux Walleij <linus.walleij@linaro.org>
Cc: David Herrmann <dh.herrmann@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>

---
 drivers/input/rmi4/rmi_f01.c | 35 +++--------------------------------
 1 file changed, 3 insertions(+), 32 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f01.c b/drivers/input/rmi4/rmi_f01.c
index be68ae2..ee5f4a1 100644
--- a/drivers/input/rmi4/rmi_f01.c
+++ b/drivers/input/rmi4/rmi_f01.c
@@ -105,7 +105,6 @@ struct f01_basic_properties {
 
 /**
  * @ctrl0 - see the bit definitions above.
- * @interrupt_enable - A mask of per-function interrupts on the touch sensor.
  * @doze_interval - controls the interval between checks for finger presence
  * when the touch sensor is in doze mode, in units of 10ms.
  * @wakeup_threshold - controls the capacitance threshold at which the touch
@@ -115,7 +114,6 @@ struct f01_basic_properties {
  */
 struct f01_device_control {
 	u8 ctrl0;
-	u8 *interrupt_enable;
 	u8 doze_interval;
 	u8 wakeup_threshold;
 	u8 doze_holdoff;
@@ -126,7 +124,6 @@ struct f01_data {
 
 	struct f01_device_control device_control;
 
-	u16 interrupt_enable_addr;
 	u16 doze_interval_addr;
 	u16 wakeup_threshold_addr;
 	u16 doze_holdoff_addr;
@@ -137,7 +134,6 @@ struct f01_data {
 #endif
 
 	unsigned int num_of_irq_regs;
-	u8 interrupt_enable[];
 };
 
 static int rmi_f01_read_properties(struct rmi_device *rmi_dev,
@@ -186,22 +182,18 @@ static int rmi_f01_probe(struct rmi_function *fn)
 	struct rmi_driver_data *driver_data = dev_get_drvdata(&rmi_dev->dev);
 	const struct rmi_device_platform_data *pdata = rmi_get_platform_data(rmi_dev);
 	struct f01_data *f01;
-	size_t f01_size;
 	int error;
 	u16 ctrl_base_addr = fn->fd.control_base_addr;
 	u8 device_status;
 	u8 temp;
 
-	f01_size = sizeof(struct f01_data) +
-				sizeof(u8) * driver_data->num_of_irq_regs;
-	f01 = devm_kzalloc(&fn->dev, f01_size, GFP_KERNEL);
+	f01 = devm_kzalloc(&fn->dev, sizeof(struct f01_data), GFP_KERNEL);
 	if (!f01) {
 		dev_err(&fn->dev, "Failed to allocate fn01_data.\n");
 		return -ENOMEM;
 	}
 
 	f01->num_of_irq_regs = driver_data->num_of_irq_regs;
-	f01->device_control.interrupt_enable = f01->interrupt_enable;
 
 	/*
 	 * Set the configured bit and (optionally) other important stuff
@@ -247,20 +239,6 @@ static int rmi_f01_probe(struct rmi_function *fn)
 		return error;
 	}
 
-	/* Advance to interrupt control registers */
-	ctrl_base_addr++;
-	f01->interrupt_enable_addr = ctrl_base_addr;
-
-	error = rmi_read_block(rmi_dev, f01->interrupt_enable_addr,
-				f01->device_control.interrupt_enable,
-				sizeof(u8) * (f01->num_of_irq_regs));
-	if (error) {
-		dev_err(&fn->dev,
-			"Failed to read F01 control interrupt enable register: %d\n",
-			error);
-		return error;
-	}
-
 	/* Dummy read in order to clear irqs */
 	error = rmi_read(rmi_dev, fn->fd.data_base_addr + 1, &temp);
 	if (error < 0) {
@@ -279,6 +257,8 @@ static int rmi_f01_probe(struct rmi_function *fn)
 		 f01->properties.manufacturer_id == 1 ? "Synaptics" : "unknown",
 		 f01->properties.product_id);
 
+	/* Advance to interrupt control registers, then skip over them. */
+	ctrl_base_addr++;
 	ctrl_base_addr += f01->num_of_irq_regs;
 
 	/* read control register */
@@ -396,15 +376,6 @@ static int rmi_f01_config(struct rmi_function *fn)
 		return error;
 	}
 
-	error = rmi_write_block(fn->rmi_dev, f01->interrupt_enable_addr,
-				f01->device_control.interrupt_enable,
-				sizeof(u8) * f01->num_of_irq_regs);
-	if (error) {
-		dev_err(&fn->dev,
-			"Failed to write interrupt enable: %d\n", error);
-		return error;
-	}
-
 	if (f01->properties.has_adjustable_doze) {
 		error = rmi_write(fn->rmi_dev, f01->doze_interval_addr,
 				  f01->device_control.doze_interval);

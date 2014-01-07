From: Christopher Heiny <cheiny@synaptics.com>
Subject: [PATCH] input synaptics-rmi4: PDT scan cleanup
Date: Tue, 7 Jan 2014 12:33:41 -0800
Message-ID: <1389126821-4066-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:58623 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753365AbaAGUdo (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 Jan 2014 15:33:44 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Christopher Heiny <cheiny@synaptics.com>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

Eliminates copy-paste code that handled scans of the Page Descriptor Table,
replacing it with a single PDT scan routine that invokes a callback function.
The scan routine is not static so that it can be used by the firmware update
code (under development, not yet submitted).

Updated the copyright dates while we were at it.

Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

 drivers/input/rmi4/rmi_driver.c | 155 ++++++++++++++++++++--------------------
 drivers/input/rmi4/rmi_driver.h |   6 +-
 2 files changed, 83 insertions(+), 78 deletions(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index eb790ff..cbd6485 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2011-2013 Synaptics Incorporated
+ * Copyright (c) 2011-2014 Synaptics Incorporated
  * Copyright (c) 2011 Unixphere
  *
  * This driver provides the core support for a single RMI4-based device.
@@ -566,85 +566,80 @@ err_free_mem:
 	return error;
 }
 
-/*
- * Scan the PDT for F01 so we can force a reset before anything else
- * is done.  This forces the sensor into a known state, and also
- * forces application of any pending updates from reflashing the
- * firmware or configuration.
- *
- * We have to do this before actually building the PDT because the reflash
- * updates (if any) might cause various registers to move around.
- */
-static int rmi_initial_reset(struct rmi_device *rmi_dev)
+
+#define RMI_SCAN_CONTINUE	0
+#define RMI_SCAN_DONE		1
+
+static int rmi_initial_reset(struct rmi_device *rmi_dev,
+		void *clbk_ctx, struct pdt_entry *pdt_entry, int page)
 {
-	struct pdt_entry pdt_entry;
-	int page;
-	struct device *dev = &rmi_dev->dev;
-	bool done = false;
-	bool has_f01 = false;
-	int i;
 	int retval;
-	const struct rmi_device_platform_data *pdata =
-			to_rmi_platform_data(rmi_dev);
 
-	dev_dbg(dev, "Initial reset.\n");
+	if (pdt_entry->function_number == 0x01) {
+		u16 cmd_addr = page + pdt_entry->command_base_addr;
+		u8 cmd_buf = RMI_DEVICE_RESET_CMD;
+		const struct rmi_device_platform_data *pdata =
+				to_rmi_platform_data(rmi_dev);
 
-	for (page = 0; (page <= RMI4_MAX_PAGE) && !done; page++) {
-		u16 page_start = RMI4_PAGE_SIZE * page;
-		u16 pdt_start = page_start + PDT_START_SCAN_LOCATION;
-		u16 pdt_end = page_start + PDT_END_SCAN_LOCATION;
+		retval = rmi_write_block(rmi_dev, cmd_addr, &cmd_buf, 1);
+		if (retval < 0) {
+			dev_err(&rmi_dev->dev,
+				"Initial reset failed. Code = %d.\n", retval);
+			return retval;
+		}
+		mdelay(pdata->reset_delay_ms);
 
-		done = true;
-		for (i = pdt_start; i >= pdt_end; i -= RMI_PDT_ENTRY_SIZE) {
-			retval = rmi_read_pdt_entry(rmi_dev, &pdt_entry, i);
-			if (retval < 0)
-				return retval;
+		return RMI_SCAN_DONE;
+	}
 
-			if (RMI4_END_OF_PDT(pdt_entry.function_number))
-				break;
-			done = false;
+	/* F01 should always be on page 0. If we don't find it there, fail. */
+	return (!page) ? RMI_SCAN_CONTINUE : -ENODEV;
+}
 
-			if (pdt_entry.function_number == 0x01) {
-				u16 cmd_addr = page_start +
-					pdt_entry.command_base_addr;
-				u8 cmd_buf = RMI_DEVICE_RESET_CMD;
-				retval = rmi_write_block(rmi_dev, cmd_addr,
-						&cmd_buf, 1);
-				if (retval < 0) {
-					dev_err(dev, "Initial reset failed. Code = %d.\n",
-						retval);
-					return retval;
-				}
-				mdelay(pdata->reset_delay_ms);
-				done = true;
-				has_f01 = true;
-				break;
-			}
-		}
-	}
+static int rmi_create_functions_clbk(struct rmi_device *rmi_dev,
+		void *clbk_ctx, struct pdt_entry *entry, int page)
+{
+	int *irq_count = (int *)clbk_ctx;
 
-	if (!has_f01) {
-		dev_warn(dev, "WARNING: Failed to find F01 for initial reset.\n");
-		return -ENODEV;
-	}
+	return create_function(rmi_dev, entry, irq_count,
+				RMI4_PAGE_SIZE * page);
+}
+
+static int rmi_create_functions(struct rmi_device *rmi_dev)
+{
+	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
+	struct device *dev = &rmi_dev->dev;
+	int irq_count = 0;
+	int retval;
+
+	// XXX need to make sure we create F01 first...
+	// XXX or do we?  It might not be required in the updated structure.
+	retval = rmi_scan_pdt(rmi_dev, &irq_count, rmi_create_functions_clbk);
+
+	if (retval)
+		return retval;
+
+	// TODO: I think we need to count the IRQs before creating the
+	// functions.
+	data->irq_count = irq_count;
+	data->num_of_irq_regs = (irq_count + 7) / 8;
 
 	return 0;
 }
 
-static int rmi_scan_pdt(struct rmi_device *rmi_dev)
+int rmi_scan_pdt(struct rmi_device *rmi_dev, void *ctx,
+		int (*rmi_pdt_scan_clbk)(struct rmi_device *rmi_dev,
+		void *clbk_ctx, struct pdt_entry *entry, int page))
 {
-	struct rmi_driver_data *data;
+	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
 	struct pdt_entry pdt_entry;
 	int page;
-	struct device *dev = &rmi_dev->dev;
-	int irq_count = 0;
-	bool done = false;
 	int i;
-	int retval;
-
-	dev_dbg(dev, "Scanning PDT...\n");
+	bool done = false;
+	int retval = 0;
 
-	data = dev_get_drvdata(&rmi_dev->dev);
+	// TODO: With F01 and reflash as part of the core now, is this
+	// lock still required?
 	mutex_lock(&data->pdt_mutex);
 
 	for (page = 0; (page <= RMI4_MAX_PAGE) && !done; page++) {
@@ -656,27 +651,27 @@ static int rmi_scan_pdt(struct rmi_device *rmi_dev)
 		for (i = pdt_start; i >= pdt_end; i -= RMI_PDT_ENTRY_SIZE) {
 			retval = rmi_read_pdt_entry(rmi_dev, &pdt_entry, i);
 			if (retval < 0)
-				goto error_exit;
+				return retval;
 
 			if (RMI4_END_OF_PDT(pdt_entry.function_number))
 				break;
 
-			dev_dbg(dev, "Found F%02X on page %#04x\n",
+			dev_dbg(&rmi_dev->dev, "Found F%02X on page %#04x\n",
 					pdt_entry.function_number, page);
 			done = false;
 
-			// XXX need to make sure we create F01 first...
-			retval = create_function(rmi_dev,
-					&pdt_entry, &irq_count, page_start);
-
-			if (retval)
+			retval = rmi_pdt_scan_clbk(rmi_dev, ctx,
+							&pdt_entry, page);
+			if (retval < 0) {
 				goto error_exit;
+			} else if (retval == RMI_SCAN_DONE) {
+				done = true;
+				break;
+			}
 		}
 		done = done || data->f01_bootloader_mode;
 	}
-	data->irq_count = irq_count;
-	data->num_of_irq_regs = (irq_count + 7) / 8;
-	dev_dbg(dev, "%s: Done with PDT scan.\n", __func__);
+
 	retval = 0;
 
 error_exit:
@@ -684,6 +679,7 @@ error_exit:
 	return retval;
 }
 
+
 #ifdef CONFIG_PM_SLEEP
 static int rmi_driver_suspend(struct device *dev)
 {
@@ -797,10 +793,15 @@ static int rmi_driver_probe(struct device *dev)
 
 	/*
 	 * Right before a warm boot, the sensor might be in some unusual state,
-	 * such as F54 diagnostics, or F34 bootloader mode.  In order to clear
-	 * the sensor to a known state, we issue a initial reset to clear any
+	 * such as F54 diagnostics, or F34 bootloader mode after a firmware
+	 * or configuration update.  In order to clear the sensor to a known
+	 * state and/or apply any updates, we issue a initial reset to clear any
 	 * previous settings and force it into normal operation.
 	 *
+	 * We have to do this before actually building the PDT because
+	 * the reflash updates (if any) might cause various registers to move
+	 * around.
+	 *
 	 * For a number of reasons, this initial reset may fail to return
 	 * within the specified time, but we'll still be able to bring up the
 	 * driver normally after that failure.  This occurs most commonly in
@@ -813,11 +814,11 @@ static int rmi_driver_probe(struct device *dev)
 	 */
 	if (!pdata->reset_delay_ms)
 		pdata->reset_delay_ms = DEFAULT_RESET_DELAY_MS;
-	retval = rmi_initial_reset(rmi_dev);
+	retval = rmi_scan_pdt(rmi_dev, NULL, rmi_initial_reset);
 	if (retval)
 		dev_warn(dev, "RMI initial reset failed! Continuing in spite of this.\n");
 
-	retval = rmi_scan_pdt(rmi_dev);
+	retval = rmi_create_functions(rmi_dev);
 	if (retval) {
 		dev_err(dev, "PDT scan for %s failed with code %d.\n",
 			pdata->sensor_name, retval);
diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_driver.h
index df9ddd8..f73be73 100644
--- a/drivers/input/rmi4/rmi_driver.h
+++ b/drivers/input/rmi4/rmi_driver.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2011-2013 Synaptics Incorporated
+ * Copyright (c) 2011-2014 Synaptics Incorporated
  * Copyright (c) 2011 Unixphere
  *
  * This program is free software; you can redistribute it and/or modify it
@@ -108,6 +108,10 @@ struct pdt_entry {
 int rmi_read_pdt_entry(struct rmi_device *rmi_dev, struct pdt_entry *entry,
 			u16 pdt_address);
 
+int rmi_scan_pdt(struct rmi_device *rmi_dev, void *ctx,
+	int (*rmi_pdt_scan_clbk)(struct rmi_device *rmi_dev,
+	void *clbk_ctx, struct pdt_entry *entry, int page));
+
 bool rmi_is_physical_driver(struct device_driver *);
 int rmi_register_physical_driver(void);
 void rmi_unregister_physical_driver(void);

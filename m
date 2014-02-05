From: Christopher Heiny <cheiny@synaptics.com>
Subject: [PATCH v3] input synaptics-rmi4: PDT scan cleanup
Date: Tue, 4 Feb 2014 17:33:17 -0800
Message-ID: <1391563997-11155-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:38968 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754204AbaBEBdg (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Feb 2014 20:33:36 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Christopher Heiny <cheiny@synaptics.com>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>

This builds on Dmitry's patch of 2014-01-27, with some bug fixes.  It's been
tested on a Nexus 4.

Eliminates copy-paste code that handled scans of the Page Descriptor
Table, replacing it with a single PDT scan routine that invokes a 
callback function.

Updated the copyright dates and eliminate C++ style comments while we
were at it.

Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Linux Walleij <linus.walleij@linaro.org>
Cc: David Herrmann <dh.herrmann@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>

---

 drivers/input/rmi4/rmi_driver.c | 254 ++++++++++++++++++++--------------------
 drivers/input/rmi4/rmi_driver.h |   3 +-
 2 files changed, 129 insertions(+), 128 deletions(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 3483e5b..0bca63d 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2011-2013 Synaptics Incorporated
+ * Copyright (c) 2011-2014 Synaptics Incorporated
  * Copyright (c) 2011 Unixphere
  *
  * This driver provides the core support for a single RMI4-based device.
@@ -35,6 +35,7 @@
 #define HAS_NONSTANDARD_PDT_MASK 0x40
 #define RMI4_MAX_PAGE 0xff
 #define RMI4_PAGE_SIZE 0x100
+#define RMI4_PAGE_MASK 0xFF00
 
 #define RMI_DEVICE_RESET_CMD	0x01
 #define DEFAULT_RESET_DELAY_MS	100
@@ -467,7 +468,8 @@ static int rmi_driver_reset_handler(struct rmi_device *rmi_dev)
  * Construct a function's IRQ mask. This should be called once and stored.
  */
 int rmi_driver_irq_get_mask(struct rmi_device *rmi_dev,
-		struct rmi_function *fn) {
+			   struct rmi_function *fn)
+{
 	int i;
 	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
 
@@ -491,12 +493,13 @@ int rmi_read_pdt_entry(struct rmi_device *rmi_dev, struct pdt_entry *entry,
 	int error;
 
 	error = rmi_read_block(rmi_dev, pdt_address, buf, RMI_PDT_ENTRY_SIZE);
-	if (error < 0) {
+	if (error) {
 		dev_err(&rmi_dev->dev, "Read PDT entry at %#06x failed, code: %d.\n",
 				pdt_address, error);
 		return error;
 	}
 
+	entry->page_start = pdt_address & RMI4_PAGE_MASK;
 	entry->query_base_addr = buf[0];
 	entry->command_base_addr = buf[1];
 	entry->control_base_addr = buf[2];
@@ -509,27 +512,113 @@ int rmi_read_pdt_entry(struct rmi_device *rmi_dev, struct pdt_entry *entry,
 }
 EXPORT_SYMBOL_GPL(rmi_read_pdt_entry);
 
-static void rmi_driver_copy_pdt_to_fd(struct pdt_entry *pdt,
-				      struct rmi_function_descriptor *fd,
-				      u16 page_start)
+static void rmi_driver_copy_pdt_to_fd(const struct pdt_entry *pdt,
+				      struct rmi_function_descriptor *fd)
 {
-	fd->query_base_addr = pdt->query_base_addr + page_start;
-	fd->command_base_addr = pdt->command_base_addr + page_start;
-	fd->control_base_addr = pdt->control_base_addr + page_start;
-	fd->data_base_addr = pdt->data_base_addr + page_start;
+	fd->query_base_addr = pdt->query_base_addr + pdt->page_start;
+	fd->command_base_addr = pdt->command_base_addr + pdt->page_start;
+	fd->control_base_addr = pdt->control_base_addr + pdt->page_start;
+	fd->data_base_addr = pdt->data_base_addr + pdt->page_start;
 	fd->function_number = pdt->function_number;
 	fd->interrupt_source_count = pdt->interrupt_source_count;
 	fd->function_version = pdt->function_version;
 }
 
-static int create_function(struct rmi_device *rmi_dev,
-				     struct pdt_entry *pdt,
-				     int *current_irq_count,
-				     u16 page_start)
+#define RMI_SCAN_CONTINUE	0
+#define RMI_SCAN_DONE		1
+
+static int rmi_scan_pdt_page(struct rmi_device *rmi_dev,
+			     int page,
+			     void *ctx,
+			     int (*callback)(struct rmi_device *rmi_dev,
+					     void *ctx,
+					     const struct pdt_entry *entry))
+{
+	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
+	struct pdt_entry pdt_entry;
+	u16 page_start = RMI4_PAGE_SIZE * page;
+	u16 pdt_start = page_start + PDT_START_SCAN_LOCATION;
+	u16 pdt_end = page_start + PDT_END_SCAN_LOCATION;
+	u16 addr;
+	int error;
+	int retval;
+
+	for (addr = pdt_start; addr >= pdt_end; addr -= RMI_PDT_ENTRY_SIZE) {
+		error = rmi_read_pdt_entry(rmi_dev, &pdt_entry, addr);
+		if (error)
+			return error;
+
+		if (RMI4_END_OF_PDT(pdt_entry.function_number))
+			break;
+
+		retval = callback(rmi_dev, ctx, &pdt_entry);
+		if (retval != RMI_SCAN_CONTINUE)
+			return retval;
+	}
+
+	return data->f01_bootloader_mode ? RMI_SCAN_DONE : RMI_SCAN_CONTINUE;
+}
+
+static int rmi_scan_pdt(struct rmi_device *rmi_dev, void *ctx,
+			int (*callback)(struct rmi_device *rmi_dev,
+					void *ctx,
+					const struct pdt_entry *entry))
+{
+	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
+	int page;
+	int retval = RMI_SCAN_DONE;
+
+	/*
+	 * TODO: With F01 and reflash as part of the core now, is this
+	 * lock still required?
+	 */
+	mutex_lock(&data->pdt_mutex);
+
+	for (page = 0; page <= RMI4_MAX_PAGE; page++) {
+		retval = rmi_scan_pdt_page(rmi_dev, page, ctx, callback);
+		if (retval != RMI_SCAN_CONTINUE)
+			break;
+	}
+
+	mutex_unlock(&data->pdt_mutex);
+
+	return retval < 0 ? retval : 0;
+}
+
+static int rmi_initial_reset(struct rmi_device *rmi_dev,
+			     void *ctx, const struct pdt_entry *pdt)
+{
+	int error;
+
+	if (pdt->function_number == 0x01) {
+		u16 cmd_addr = pdt->page_start + pdt->command_base_addr;
+		u8 cmd_buf = RMI_DEVICE_RESET_CMD;
+		const struct rmi_device_platform_data *pdata =
+				to_rmi_platform_data(rmi_dev);
+
+		error = rmi_write_block(rmi_dev, cmd_addr, &cmd_buf, 1);
+		if (error) {
+			dev_err(&rmi_dev->dev,
+				"Initial reset failed. Code = %d.\n", error);
+			return error;
+		}
+
+		mdelay(pdata->reset_delay_ms);
+
+		return RMI_SCAN_DONE;
+	}
+
+	/* F01 should always be on page 0. If we don't find it there, fail. */
+	return pdt->page_start == 0 ? RMI_SCAN_CONTINUE : -ENODEV;
+}
+
+static int rmi_create_function(struct rmi_device *rmi_dev,
+			      void *ctx, const struct pdt_entry *pdt)
 {
 	struct device *dev = &rmi_dev->dev;
 	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
 	struct rmi_device_platform_data *pdata = to_rmi_platform_data(rmi_dev);
+	int *current_irq_count = ctx;
 	struct rmi_function *fn;
 	int error;
 
@@ -551,7 +640,7 @@ static int create_function(struct rmi_device *rmi_dev,
 	fn->irq_pos = *current_irq_count;
 	*current_irq_count += fn->num_of_irqs;
 
-	rmi_driver_copy_pdt_to_fd(pdt, &fn->fd, page_start);
+	rmi_driver_copy_pdt_to_fd(pdt, &fn->fd);
 
 	error = rmi_register_function(fn);
 	if (error)
@@ -566,122 +655,28 @@ err_free_mem:
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
-{
-	struct pdt_entry pdt_entry;
-	int page;
-	struct device *dev = &rmi_dev->dev;
-	bool done = false;
-	bool has_f01 = false;
-	int i;
-	int retval;
-	const struct rmi_device_platform_data *pdata =
-			to_rmi_platform_data(rmi_dev);
-
-	dev_dbg(dev, "Initial reset.\n");
-
-	for (page = 0; (page <= RMI4_MAX_PAGE) && !done; page++) {
-		u16 page_start = RMI4_PAGE_SIZE * page;
-		u16 pdt_start = page_start + PDT_START_SCAN_LOCATION;
-		u16 pdt_end = page_start + PDT_END_SCAN_LOCATION;
-
-		done = true;
-		for (i = pdt_start; i >= pdt_end; i -= RMI_PDT_ENTRY_SIZE) {
-			retval = rmi_read_pdt_entry(rmi_dev, &pdt_entry, i);
-			if (retval < 0)
-				return retval;
-
-			if (RMI4_END_OF_PDT(pdt_entry.function_number))
-				break;
-			done = false;
-
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
-
-	if (!has_f01) {
-		dev_warn(dev, "WARNING: Failed to find F01 for initial reset.\n");
-		return -ENODEV;
-	}
-
-	return 0;
-}
-
-static int rmi_scan_pdt(struct rmi_device *rmi_dev)
+static int rmi_create_functions(struct rmi_device *rmi_dev)
 {
-	struct rmi_driver_data *data;
-	struct pdt_entry pdt_entry;
-	int page;
-	struct device *dev = &rmi_dev->dev;
+	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
 	int irq_count = 0;
-	bool done = false;
-	int i;
 	int retval;
 
-	dev_dbg(dev, "Scanning PDT...\n");
-
-	data = dev_get_drvdata(&rmi_dev->dev);
-	mutex_lock(&data->pdt_mutex);
-
-	for (page = 0; (page <= RMI4_MAX_PAGE) && !done; page++) {
-		u16 page_start = RMI4_PAGE_SIZE * page;
-		u16 pdt_start = page_start + PDT_START_SCAN_LOCATION;
-		u16 pdt_end = page_start + PDT_END_SCAN_LOCATION;
-
-		done = true;
-		for (i = pdt_start; i >= pdt_end; i -= RMI_PDT_ENTRY_SIZE) {
-			retval = rmi_read_pdt_entry(rmi_dev, &pdt_entry, i);
-			if (retval < 0)
-				goto error_exit;
-
-			if (RMI4_END_OF_PDT(pdt_entry.function_number))
-				break;
-
-			dev_dbg(dev, "Found F%02X on page %#04x\n",
-					pdt_entry.function_number, page);
-			done = false;
-
-			// XXX need to make sure we create F01 first...
-			retval = create_function(rmi_dev,
-					&pdt_entry, &irq_count, page_start);
+	/*
+	 * XXX need to make sure we create F01 first...
+	 * XXX or do we?  It might not be required in the updated structure.
+	 */
+	retval = rmi_scan_pdt(rmi_dev, &irq_count, rmi_create_function);
+	if (retval < 0)
+		return retval;
 
-			if (retval)
-				goto error_exit;
-		}
-		done = done || data->f01_bootloader_mode;
-	}
+	/*
+	 * TODO: I think we need to count the IRQs before creating the
+	 * functions.
+	 */
 	data->irq_count = irq_count;
 	data->num_of_irq_regs = (irq_count + 7) / 8;
-	dev_dbg(dev, "%s: Done with PDT scan.\n", __func__);
-	retval = 0;
 
-error_exit:
-	mutex_unlock(&data->pdt_mutex);
-	return retval;
+	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -797,10 +792,15 @@ static int rmi_driver_probe(struct device *dev)
 
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
@@ -813,11 +813,11 @@ static int rmi_driver_probe(struct device *dev)
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
index 4f44a54..9ecd31b 100644
--- a/drivers/input/rmi4/rmi_driver.h
+++ b/drivers/input/rmi4/rmi_driver.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2011-2013 Synaptics Incorporated
+ * Copyright (c) 2011-2014 Synaptics Incorporated
  * Copyright (c) 2011 Unixphere
  *
  * This program is free software; you can redistribute it and/or modify it
@@ -94,6 +94,7 @@ struct rmi_driver_data {
 #define RMI4_END_OF_PDT(id) ((id) == 0x00 || (id) == 0xff)
 
 struct pdt_entry {
+	u16 page_start;
 	u8 query_base_addr;
 	u8 command_base_addr;
 	u8 control_base_addr;

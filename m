From: Christopher Heiny <cheiny@synaptics.com>
Subject: [PATCH v2] input: synaptics-rmi4 - Count IRQs before creating functions; save F01 container.
Date: Wed, 22 Jan 2014 17:35:37 -0800
Message-ID: <1390440937-14856-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:41030 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331AbaAWBfq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Jan 2014 20:35:46 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Christopher Heiny <cheiny@synaptics.com>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

Because creating a function can trigger events that result in the IRQ
related storage being accessed, we need to count the IRQs and allocate
their storage before the functions are created, rather than counting
them as the functions are created and allocating them afterwards. Since
we know the number of IRQs already, we can allocate the mask at 
function creation time, rather than in a post-creation loop.  Also, the
F01 function_container is needed elsewhere, so we need to save it here.

In order to keep the IRQ count logic sane in bootloader mode, we move
the check for bootloader mode from F01 initialization to the IRQ
counting routine.

Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

 drivers/input/rmi4/rmi_driver.c | 122 ++++++++++++++++++++++++++++++----------
 drivers/input/rmi4/rmi_driver.h |   1 -
 drivers/input/rmi4/rmi_f01.c    |  11 +---
 3 files changed, 92 insertions(+), 42 deletions(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index ce0520c..5d338ef 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -560,10 +560,19 @@ static int create_function(struct rmi_device *rmi_dev, void *clbk_ctx,
 
 	rmi_driver_copy_pdt_to_fd(pdt, &fn->fd, page_start);
 
+	error = rmi_driver_irq_get_mask(rmi_dev, fn);
+	if (error < 0) {
+		dev_err(dev, "%s: Failed to create irq_mask for F%02X.\n",
+			__func__, pdt->function_number);
+		return error;
+	}
+
 	error = rmi_register_function(fn);
 	if (error)
 		goto err_free_mem;
 
+	if (pdt->function_number == 0x01)
+		data->f01_container = fn;
 	list_add_tail(&fn->node, &data->function_list);
 
 	return RMI_SCAN_CONTINUE;
@@ -573,6 +582,30 @@ err_free_mem:
 	return RMI_SCAN_ERROR;
 }
 
+/* Indicates that flash programming is enabled (bootloader mode). */
+#define RMI_F01_STATUS_BOOTLOADER(status)	(!!((status) & 0x40))
+
+/*
+ * Given the PDT entry for F01, read the device status register to determine
+ * if we're stuck in bootloader mode or not.
+ *
+ */
+static int check_bootloader_mode(struct rmi_device *rmi_dev, struct pdt_entry *pdt,
+				     u16 page_start)
+{
+	u8 device_status;
+	int retval = 0;
+
+	retval = rmi_read(rmi_dev, pdt->data_base_addr + page_start,
+			  &device_status);
+	if (retval < 0) {
+		dev_err(&rmi_dev->dev, "Failed to read device status.\n");
+		return retval;
+	}
+
+	return RMI_F01_STATUS_BOOTLOADER(device_status);
+}
+
 static int rmi_initial_reset(struct rmi_device *rmi_dev,
 		void *clbk_ctx, struct pdt_entry *pdt_entry, int page)
 {
@@ -599,6 +632,23 @@ static int rmi_initial_reset(struct rmi_device *rmi_dev,
 	return (!page) ? RMI_SCAN_CONTINUE : RMI_SCAN_ERROR;
 }
 
+static int rmi_count_irqs(struct rmi_device *rmi_dev,
+		void * clbk_ctx, struct pdt_entry *pdt_entry, int page)
+{
+	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
+
+	data->irq_count += pdt_entry->interrupt_source_count;
+	if (pdt_entry->function_number == 0x01) {
+		data->f01_bootloader_mode = check_bootloader_mode(rmi_dev,
+					pdt_entry, page);
+		if (data->f01_bootloader_mode)
+			dev_warn(&rmi_dev->dev,
+				"WARNING: RMI4 device is in bootloader mode!\n");
+	}
+
+	return RMI_SCAN_CONTINUE;
+}
+
 static int rmi_create_functions(struct rmi_device *rmi_dev)
 {
 	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
@@ -766,7 +816,6 @@ static int rmi_driver_probe(struct device *dev)
 {
 	struct rmi_driver *rmi_driver;
 	struct rmi_driver_data *data = NULL;
-	struct rmi_function *fn;
 	struct rmi_device_platform_data *pdata;
 	int retval = 0;
 	struct rmi_device *rmi_dev;
@@ -821,28 +870,6 @@ static int rmi_driver_probe(struct device *dev)
 	if (retval)
 		dev_warn(dev, "RMI initial reset failed! Continuing in spite of this.\n");
 
-	retval = rmi_create_functions(rmi_dev);
-	if (retval) {
-		dev_err(dev, "PDT scan for %s failed.\n", pdata->sensor_name);
-		retval = -ENODEV;
-		goto err_free_data;
-	}
-
-	if (!data->f01_container) {
-		dev_err(dev, "missing F01 container!\n");
-		retval = -EINVAL;
-		goto err_free_data;
-	}
-
-	list_for_each_entry(fn, &data->function_list, node) {
-		retval = rmi_driver_irq_get_mask(rmi_dev, fn);
-		if (retval < 0) {
-			dev_err(dev, "%s: Failed to create irq_mask.\n",
-				__func__);
-			goto err_free_data;
-		}
-	}
-
 	retval = rmi_read(rmi_dev, PDT_PROPERTIES_LOCATION, &data->pdt_props);
 	if (retval < 0) {
 		/*
@@ -853,6 +880,22 @@ static int rmi_driver_probe(struct device *dev)
 			 PDT_PROPERTIES_LOCATION);
 	}
 
+	/*
+	 * We need to count the IRQs and allocate their storage before scanning
+	 * the PDT and creating the function entries, because adding a new
+	 * function can trigger events that result in the IRQ related storage
+	 * being accessed.
+	 */
+	dev_dbg(dev, "Counting IRQs.\n");
+	retval = rmi_scan_pdt(rmi_dev, NULL, rmi_count_irqs);
+	if (retval) {
+		retval = -ENODEV;
+		dev_err(dev, "IRQ counting for %s.\n",
+			pdata->sensor_name);
+		goto err_free_data;
+	}
+	data->num_of_irq_regs = (data->irq_count + 7) / 8;
+
 	mutex_init(&data->irq_mutex);
 	data->irq_status = devm_kzalloc(dev,
 		BITS_TO_LONGS(data->irq_count)*sizeof(unsigned long),
@@ -872,6 +915,28 @@ static int rmi_driver_probe(struct device *dev)
 		goto err_free_data;
 	}
 
+	data->irq_mask_store = devm_kzalloc(dev,
+		BITS_TO_LONGS(data->irq_count) * sizeof(unsigned long),
+		GFP_KERNEL);
+	if (!data->irq_mask_store) {
+		dev_err(dev, "Failed to allocate irq_mask_store.\n");
+		retval = -ENOMEM;
+		goto err_free_data;
+	}
+
+	retval = rmi_create_functions(rmi_dev);
+	if (retval) {
+		retval = -ENODEV;
+		dev_err(dev, "Function creation failed.\n");
+		goto err_free_data;
+	}
+
+	if (!data->f01_container) {
+		dev_err(dev, "missing F01 container!\n");
+		retval = -EINVAL;
+		goto err_free_data;
+	}
+
 	retval = rmi_read_block(rmi_dev,
 				data->f01_container->fd.control_base_addr+1,
 				data->current_irq_mask, data->num_of_irq_regs);
@@ -881,14 +946,6 @@ static int rmi_driver_probe(struct device *dev)
 		goto err_free_data;
 	}
 
-	data->irq_mask_store = devm_kzalloc(dev,
-		BITS_TO_LONGS(data->irq_count)*sizeof(unsigned long),
-		GFP_KERNEL);
-	if (!data->irq_mask_store) {
-		dev_err(dev, "Failed to allocate mask store.\n");
-		retval = -ENOMEM;
-		goto err_free_data;
-	}
 	if (IS_ENABLED(CONFIG_PM)) {
 		data->pm_data = pdata->pm_data;
 		data->pre_suspend = pdata->pre_suspend;
@@ -954,6 +1011,9 @@ static int rmi_driver_probe(struct device *dev)
 	return 0;
 
 err_free_data:
+	rmi_free_function_list(rmi_dev);
+	if (gpio_is_valid(pdata->attn_gpio))
+		gpio_free(pdata->attn_gpio);
 	return retval;
 }
 
diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_driver.h
index 2c1c63f..e5566c4 100644
--- a/drivers/input/rmi4/rmi_driver.h
+++ b/drivers/input/rmi4/rmi_driver.h
@@ -100,7 +100,6 @@ struct pdt_entry {
 #define RMI_SCAN_ERROR		-1
 #define RMI_SCAN_CONTINUE	0
 #define RMI_SCAN_DONE		1
-
 int rmi_scan_pdt(struct rmi_device *rmi_dev, void *ctx,
 	int (*rmi_pdt_scan_clbk)(struct rmi_device *rmi_dev,
 	void *clbk_ctx, struct pdt_entry *entry, int page));
diff --git a/drivers/input/rmi4/rmi_f01.c b/drivers/input/rmi4/rmi_f01.c
index 628b082..c7f2360 100644
--- a/drivers/input/rmi4/rmi_f01.c
+++ b/drivers/input/rmi4/rmi_f01.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2011-2012 Synaptics Incorporated
+ * Copyright (c) 2011-2014 Synaptics Incorporated
  * Copyright (c) 2011 Unixphere
  *
  * This program is free software; you can redistribute it and/or modify it
@@ -59,8 +59,6 @@ struct f01_basic_properties {
 
 /* Most recent device status event */
 #define RMI_F01_STATUS_CODE(status)		((status) & 0x0f)
-/* Indicates that flash programming is enabled (bootloader mode). */
-#define RMI_F01_STATUS_BOOTLOADER(status)	(!!((status) & 0x40))
 /* The device has lost its configuration for some reason. */
 #define RMI_F01_STATUS_UNCONFIGURED(status)	(!!((status) & 0x80))
 
@@ -358,13 +356,6 @@ static int rmi_f01_initialize(struct rmi_function *fn)
 		goto error_exit;
 	}
 
-	driver_data->f01_bootloader_mode =
-			RMI_F01_STATUS_BOOTLOADER(data->device_status);
-	if (driver_data->f01_bootloader_mode)
-		dev_warn(&rmi_dev->dev,
-			 "WARNING: RMI4 device is in bootloader mode!\n");
-
-
 	if (RMI_F01_STATUS_UNCONFIGURED(data->device_status)) {
 		dev_err(&fn->dev,
 			"Device was reset during configuration process, status: %#02x!\n",

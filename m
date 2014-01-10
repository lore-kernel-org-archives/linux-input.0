From: Christopher Heiny <cheiny@synaptics.com>
Subject: [PATCH] input: synaptics-rmi4 - Count IRQs before creating functions; save F01 container.
Date: Fri, 10 Jan 2014 13:53:34 -0800
Message-ID: <1389390814-4063-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:62486 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524AbaAJVxl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Jan 2014 16:53:41 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Christopher Heiny <cheiny@synaptics.com>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

Because creating a function can trigger events that result in the IRQ related
storage being accessed, we need to count the IRQs and allocate their storage
before the functions are created, rather than counting them as the functions
are created and allocating them afterwards. Since we know the number of IRQs
already, we can allocate the mask at function creation time, rather than in
a post-creation loop.  Also, the F01 function_container is needed elsewhere,
so we need to save it here.

In order to keep the IRQ count logic sane in bootloader mode, we move the
check for bootloader mode from F01 initialization to the IRQ counting routine.

Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

 drivers/input/rmi4/rmi_driver.c | 129 +++++++++++++++++++++++++++++-----------
 drivers/input/rmi4/rmi_f01.c    |  11 +---
 2 files changed, 96 insertions(+), 44 deletions(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index f5970f4..f2acd3a 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2011-2013 Synaptics Incorporated
+ * Copyright (c) 2011-2014 Synaptics Incorporated
  * Copyright (c) 2011 Unixphere
  *
  * This driver provides the core support for a single RMI4-based device.
@@ -553,10 +553,19 @@ static int create_function(struct rmi_device *rmi_dev,
 
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
 
 	return 0;
@@ -566,10 +575,33 @@ err_free_mem:
 	return error;
 }
 
-
 #define RMI_SCAN_CONTINUE	0
 #define RMI_SCAN_DONE		1
 
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
@@ -596,6 +628,23 @@ static int rmi_initial_reset(struct rmi_device *rmi_dev,
 	return (!page) ? RMI_SCAN_CONTINUE : -ENODEV;
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
 static int rmi_create_functions_clbk(struct rmi_device *rmi_dev,
 		void *clbk_ctx, struct pdt_entry *entry, int page)
 {
@@ -608,7 +657,6 @@ static int rmi_create_functions_clbk(struct rmi_device *rmi_dev,
 static int rmi_create_functions(struct rmi_device *rmi_dev)
 {
 	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
-	struct device *dev = &rmi_dev->dev;
 	int irq_count = 0;
 	int retval;
 
@@ -763,7 +811,6 @@ static int rmi_driver_probe(struct device *dev)
 {
 	struct rmi_driver *rmi_driver;
 	struct rmi_driver_data *data = NULL;
-	struct rmi_function *fn;
 	struct rmi_device_platform_data *pdata;
 	int retval = 0;
 	struct rmi_device *rmi_dev;
@@ -818,28 +865,6 @@ static int rmi_driver_probe(struct device *dev)
 	if (retval)
 		dev_warn(dev, "RMI initial reset failed! Continuing in spite of this.\n");
 
-	retval = rmi_create_functions(rmi_dev);
-	if (retval) {
-		dev_err(dev, "PDT scan for %s failed with code %d.\n",
-			pdata->sensor_name, retval);
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
@@ -850,6 +875,21 @@ static int rmi_driver_probe(struct device *dev)
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
+		dev_err(dev, "IRQ counting for %s failed with code %d.\n",
+			pdata->sensor_name, retval);
+		goto err_free_data;
+	}
+	data->num_of_irq_regs = (data->irq_count + 7) / 8;
+
 	mutex_init(&data->irq_mutex);
 	data->irq_status = devm_kzalloc(dev,
 		BITS_TO_LONGS(data->irq_count)*sizeof(unsigned long),
@@ -869,6 +909,28 @@ static int rmi_driver_probe(struct device *dev)
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
+		dev_err(dev, "Function creation failed with code %d.\n",
+			retval);
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
@@ -878,14 +940,6 @@ static int rmi_driver_probe(struct device *dev)
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
@@ -951,6 +1005,13 @@ static int rmi_driver_probe(struct device *dev)
 	return 0;
 
  err_free_data:
+	rmi_free_function_list(rmi_dev);
+	if (gpio_is_valid(pdata->attn_gpio))
+		gpio_free(pdata->attn_gpio);
+	devm_kfree(&rmi_dev->dev, data->irq_status);
+	devm_kfree(&rmi_dev->dev, data->current_irq_mask);
+	devm_kfree(&rmi_dev->dev, data->irq_mask_store);
+	devm_kfree(&rmi_dev->dev, data);
 	return retval;
 }
 
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

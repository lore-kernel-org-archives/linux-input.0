From: Christopher Heiny <cheiny@synaptics.com>
Subject: [PATCH v2 04/06] input synaptics-rmi4: rmi_driver - Export some symbols and functions
Date: Wed, 12 Mar 2014 18:53:55 -0700
Message-ID: <1394675637-23853-4-git-send-email-cheiny@synaptics.com>
References: <1394675637-23853-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:30313 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752588AbaCMByJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Mar 2014 21:54:09 -0400
In-Reply-To: <1394675637-23853-1-git-send-email-cheiny@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Christopher Heiny <cheiny@synaptics.com>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>

Firmware update functionality will need to unload the existing
functions and rescan the PDT before starting the update process;
then reload the functions afterwards.

Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
Signed-off-by: Vincent Huang <vincent.huang@tw.synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Linux Walleij <linus.walleij@linaro.org>
Cc: David Herrmann <dh.herrmann@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>

---

 drivers/input/rmi4/rmi_driver.c | 165 ++++++++++++++++++++++------------------
 drivers/input/rmi4/rmi_driver.h |  22 +++---
 2 files changed, 101 insertions(+), 86 deletions(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 2172c80..70410e8 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -31,14 +31,20 @@
 #include <uapi/linux/input.h>
 #include "rmi_bus.h"
 #include "rmi_driver.h"
+#include "rmi_f01.h"
 
 #define HAS_NONSTANDARD_PDT_MASK 0x40
 #define RMI4_MAX_PAGE 0xff
 #define RMI4_PAGE_SIZE 0x100
 #define RMI4_PAGE_MASK 0xFF00
 
-#define RMI_DEVICE_RESET_CMD	0x01
-#define DEFAULT_RESET_DELAY_MS	100
+#define RMI_PDT_ENTRY_SIZE 6
+#define RMI_PDT_FUNCTION_VERSION_MASK   0x60
+#define RMI_PDT_INT_SOURCE_COUNT_MASK   0x07
+
+#define PDT_START_SCAN_LOCATION 0x00e9
+#define PDT_END_SCAN_LOCATION	0x0005
+#define RMI4_END_OF_PDT(id) ((id) == 0x00 || (id) == 0xff)
 
 #define DEFAULT_POLL_INTERVAL_MS	13
 
@@ -174,7 +180,7 @@ static int enable_sensor(struct rmi_device *rmi_dev)
 	return process_interrupt_requests(rmi_dev);
 }
 
-static void rmi_free_function_list(struct rmi_device *rmi_dev)
+void rmi_free_function_list(struct rmi_device *rmi_dev)
 {
 	struct rmi_function *fn, *tmp;
 	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
@@ -435,8 +441,8 @@ static int rmi_driver_reset_handler(struct rmi_device *rmi_dev)
 	return 0;
 }
 
-int rmi_read_pdt_entry(struct rmi_device *rmi_dev, struct pdt_entry *entry,
-			u16 pdt_address)
+static int rmi_read_pdt_entry(struct rmi_device *rmi_dev,
+			      struct pdt_entry *entry, u16 pdt_address)
 {
 	u8 buf[RMI_PDT_ENTRY_SIZE];
 	int error;
@@ -459,7 +465,6 @@ int rmi_read_pdt_entry(struct rmi_device *rmi_dev, struct pdt_entry *entry,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(rmi_read_pdt_entry);
 
 static void rmi_driver_copy_pdt_to_fd(const struct pdt_entry *pdt,
 				      struct rmi_function_descriptor *fd)
@@ -473,9 +478,6 @@ static void rmi_driver_copy_pdt_to_fd(const struct pdt_entry *pdt,
 	fd->function_version = pdt->function_version;
 }
 
-#define RMI_SCAN_CONTINUE	0
-#define RMI_SCAN_DONE		1
-
 static int rmi_scan_pdt_page(struct rmi_device *rmi_dev,
 			     int page,
 			     void *ctx,
@@ -508,10 +510,9 @@ static int rmi_scan_pdt_page(struct rmi_device *rmi_dev,
 	return data->f01_bootloader_mode ? RMI_SCAN_DONE : RMI_SCAN_CONTINUE;
 }
 
-static int rmi_scan_pdt(struct rmi_device *rmi_dev, void *ctx,
-			int (*callback)(struct rmi_device *rmi_dev,
-					void *ctx,
-					const struct pdt_entry *entry))
+int rmi_scan_pdt(struct rmi_device *rmi_dev, void *ctx,
+		 int (*callback)(struct rmi_device *rmi_dev,
+				 void *ctx, const struct pdt_entry *entry))
 {
 	int page;
 	int retval = RMI_SCAN_DONE;
@@ -525,16 +526,13 @@ static int rmi_scan_pdt(struct rmi_device *rmi_dev, void *ctx,
 	return retval < 0 ? retval : 0;
 }
 
-/* Indicates that flash programming is enabled (bootloader mode). */
-#define RMI_F01_STATUS_BOOTLOADER(status)	(!!((status) & 0x40))
-
 /*
  * Given the PDT entry for F01, read the device status register to determine
  * if we're stuck in bootloader mode or not.
  *
  */
-static int rmi_check_bootloader_mode(struct rmi_device *rmi_dev,
-				     const struct pdt_entry *pdt)
+int rmi_check_bootloader_mode(struct rmi_device *rmi_dev,
+			      const struct pdt_entry *pdt)
 {
 	int error;
 	u8 device_status;
@@ -575,7 +573,7 @@ static int rmi_initial_reset(struct rmi_device *rmi_dev,
 
 	if (pdt->function_number == 0x01) {
 		u16 cmd_addr = pdt->page_start + pdt->command_base_addr;
-		u8 cmd_buf = RMI_DEVICE_RESET_CMD;
+		u8 cmd_buf = RMI_F01_CMD_DEVICE_RESET;
 		const struct rmi_device_platform_data *pdata =
 				rmi_get_platform_data(rmi_dev);
 
@@ -586,7 +584,7 @@ static int rmi_initial_reset(struct rmi_device *rmi_dev,
 			return error;
 		}
 
-		mdelay(pdata->reset_delay_ms ?: DEFAULT_RESET_DELAY_MS);
+		mdelay(pdata->reset_delay_ms ?: RMI_F01_DEFAULT_RESET_DELAY_MS);
 
 		return RMI_SCAN_DONE;
 	}
@@ -728,15 +726,80 @@ static int rmi_driver_remove(struct device *dev)
 	return 0;
 }
 
+int rmi_driver_detect_functions(struct rmi_device *rmi_dev)
+{
+	int error;
+	int irq_count;
+	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
+	void *irq_memory;
+	size_t size;
+
+	/*
+	 * We need to count the IRQs and allocate their storage before scanning
+	 * the PDT and creating the function entries, because adding a new
+	 * function can trigger events that result in the IRQ related storage
+	 * being accessed.
+	 */
+	dev_dbg(&rmi_dev->dev, "Counting IRQs.\n");
+	irq_count = 0;
+	error = rmi_scan_pdt(rmi_dev, &irq_count, rmi_count_irqs);
+	if (error) {
+		error = -ENODEV;
+		dev_err(&rmi_dev->dev, "IRQ counting failed with code %d.\n",
+			error);
+		goto err_free_mem;
+	}
+	data->irq_count = irq_count;
+	data->num_of_irq_regs = (data->irq_count + 7) / 8;
+
+	size = BITS_TO_LONGS(data->irq_count) * sizeof(unsigned long);
+	irq_memory = kzalloc(size * 4, GFP_KERNEL);
+	if (!irq_memory) {
+		dev_err(&rmi_dev->dev, "Failed to allocate memory for irq masks.\n");
+		goto err_free_mem;
+	}
+	kfree(data->irq_status); /* free the memory if it's allocated already */
+	data->irq_status	= irq_memory + size * 0;
+	data->fn_irq_bits	= irq_memory + size * 1;
+	data->current_irq_mask	= irq_memory + size * 2;
+	data->new_irq_mask	= irq_memory + size * 3;
+
+	irq_count = 0;
+	dev_dbg(&rmi_dev->dev, "Creating functions.");
+	error = rmi_scan_pdt(rmi_dev, &irq_count, rmi_create_function);
+	if (error < 0) {
+		dev_err(&rmi_dev->dev, "Function creation failed with code %d.\n",
+			error);
+		goto err_destroy_functions;
+	}
+	if (!data->f01_container) {
+		dev_err(&rmi_dev->dev, "missing F01 container!\n");
+		error = -EINVAL;
+		goto err_destroy_functions;
+	}
+	error = rmi_read_block(rmi_dev,
+				data->f01_container->fd.control_base_addr+1,
+				data->current_irq_mask, data->num_of_irq_regs);
+	if (error) {
+		dev_err(&rmi_dev->dev, "%s: Failed to read current IRQ mask.\n",
+			__func__);
+		goto err_destroy_functions;
+	}
+	return 0;
+
+err_destroy_functions:
+	rmi_free_function_list(rmi_dev);
+	kfree(irq_memory);
+err_free_mem:
+	return error;
+}
+
 static int rmi_driver_probe(struct device *dev)
 {
 	struct rmi_driver *rmi_driver;
 	struct rmi_driver_data *data;
 	const struct rmi_device_platform_data *pdata;
 	struct rmi_device *rmi_dev;
-	size_t size;
-	void *irq_memory;
-	int irq_count;
 	int retval;
 
 	dev_dbg(dev, "%s: Starting probe.\n", __func__);
@@ -796,59 +859,11 @@ static int rmi_driver_probe(struct device *dev)
 		dev_warn(dev, "Could not read PDT properties from %#06x (code %d). Assuming 0x00.\n",
 			 PDT_PROPERTIES_LOCATION, retval);
 	}
-
-	/*
-	 * We need to count the IRQs and allocate their storage before scanning
-	 * the PDT and creating the function entries, because adding a new
-	 * function can trigger events that result in the IRQ related storage
-	 * being accessed.
-	 */
-	dev_dbg(dev, "Counting IRQs.\n");
-	irq_count = 0;
-	retval = rmi_scan_pdt(rmi_dev, &irq_count, rmi_count_irqs);
-	if (retval < 0) {
-		dev_err(dev, "IRQ counting for %s failed with code %d.\n",
-			pdata->sensor_name, retval);
-		goto err_free_mem;
-	}
-	data->irq_count = irq_count;
-	data->num_of_irq_regs = (data->irq_count + 7) / 8;
-
 	mutex_init(&data->irq_mutex);
 
-	size = BITS_TO_LONGS(data->irq_count) * sizeof(unsigned long);
-	irq_memory = kzalloc(size * 4, GFP_KERNEL);
-	if (!irq_memory) {
-		dev_err(dev, "Failed to allocate memory for irq masks.\n");
-		goto err_free_mem;
-	}
-
-	data->irq_status	= irq_memory + size * 0;
-	data->fn_irq_bits	= irq_memory + size * 1;
-	data->current_irq_mask	= irq_memory + size * 2;
-	data->new_irq_mask	= irq_memory + size * 3;
-
-	irq_count = 0;
-	dev_dbg(dev, "Creating functions.");
-	retval = rmi_scan_pdt(rmi_dev, &irq_count, rmi_create_function);
-	if (retval < 0) {
-		dev_err(dev, "Function creation failed with code %d.\n",
-			retval);
-		goto err_destroy_functions;
-	}
-
-	if (!data->f01_container) {
-		dev_err(dev, "Missing F01 container!\n");
-		retval = -EINVAL;
-		goto err_destroy_functions;
-	}
-
-	retval = rmi_read_block(rmi_dev,
-				data->f01_container->fd.control_base_addr + 1,
-				data->current_irq_mask, data->num_of_irq_regs);
-	if (retval < 0) {
-		dev_err(dev, "%s: Failed to read current IRQ mask.\n",
-			__func__);
+	retval = rmi_driver_detect_functions(rmi_dev);
+	if (retval) {
+		dev_err(dev, "Failed to detect functions!\n");
 		goto err_destroy_functions;
 	}
 
@@ -918,8 +933,6 @@ static int rmi_driver_probe(struct device *dev)
 
 err_destroy_functions:
 	rmi_free_function_list(rmi_dev);
-	kfree(irq_memory);
-err_free_mem:
 	if (data->gpio_held)
 		gpio_free(pdata->attn_gpio);
 	kfree(data);
diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_driver.h
index 34f7a7d..2291591 100644
--- a/drivers/input/rmi4/rmi_driver.h
+++ b/drivers/input/rmi4/rmi_driver.h
@@ -84,14 +84,6 @@ struct rmi_driver_data {
 	void *data;
 };
 
-#define RMI_PDT_ENTRY_SIZE 6
-#define RMI_PDT_FUNCTION_VERSION_MASK   0x60
-#define RMI_PDT_INT_SOURCE_COUNT_MASK   0x07
-
-#define PDT_START_SCAN_LOCATION 0x00e9
-#define PDT_END_SCAN_LOCATION	0x0005
-#define RMI4_END_OF_PDT(id) ((id) == 0x00 || (id) == 0xff)
-
 struct pdt_entry {
 	u16 page_start;
 	u8 query_base_addr;
@@ -103,8 +95,12 @@ struct pdt_entry {
 	u8 function_number;
 };
 
-int rmi_read_pdt_entry(struct rmi_device *rmi_dev, struct pdt_entry *entry,
-			u16 pdt_address);
+#define RMI_SCAN_CONTINUE	0
+#define RMI_SCAN_DONE		1
+
+int rmi_scan_pdt(struct rmi_device *rmi_dev, void *ctx,
+		 int (*callback)(struct rmi_device *rmi_dev,
+				 void *ctx, const struct pdt_entry *entry));
 
 bool rmi_is_physical_driver(struct device_driver *);
 int rmi_register_physical_driver(void);
@@ -113,4 +109,10 @@ void rmi_unregister_physical_driver(void);
 int rmi_register_f01_handler(void);
 void rmi_unregister_f01_handler(void);
 
+int rmi_check_bootloader_mode(struct rmi_device *rmi_dev,
+			      const struct pdt_entry *pdt);
+void rmi_free_function_list(struct rmi_device *rmi_dev);
+int rmi_driver_detect_functions(struct rmi_device *rmi_dev);
+
+
 #endif

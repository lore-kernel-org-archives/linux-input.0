From: Nick Dyer <nick@shmanahar.org>
Subject: [PATCH v4 3/7] Input: synaptics-rmi4 - add support for F34 device reflash
Date: Wed, 19 Oct 2016 00:26:04 +0100
Message-ID: <1476833168-12880-3-git-send-email-nick@shmanahar.org>
References: <1476833168-12880-1-git-send-email-nick@shmanahar.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avasout06.plus.net ([212.159.14.18]:46786 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756200AbcJRX0Q (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 18 Oct 2016 19:26:16 -0400
In-Reply-To: <1476833168-12880-1-git-send-email-nick@shmanahar.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>
Cc: Chris Healy <cphealy@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Nick Dyer <nick@shmanahar.org>

Add support for updating firmware, triggered by a sysfs attribute.

This patch has been tested on Synaptics S7300.

Signed-off-by: Nick Dyer <nick@shmanahar.org>
Tested-by: Chris Healy <cphealy@gmail.com>
---
 drivers/input/rmi4/Kconfig      |  11 +
 drivers/input/rmi4/Makefile     |   1 +
 drivers/input/rmi4/rmi_bus.c    |   3 +
 drivers/input/rmi4/rmi_driver.c |  85 +++++--
 drivers/input/rmi4/rmi_driver.h |  24 ++
 drivers/input/rmi4/rmi_f01.c    |   6 +
 drivers/input/rmi4/rmi_f34.c    | 486 ++++++++++++++++++++++++++++++++++++++++
 drivers/input/rmi4/rmi_f34.h    |  64 ++++++
 include/linux/rmi.h             |   1 +
 9 files changed, 657 insertions(+), 24 deletions(-)
 create mode 100644 drivers/input/rmi4/rmi_f34.c
 create mode 100644 drivers/input/rmi4/rmi_f34.h

diff --git a/drivers/input/rmi4/Kconfig b/drivers/input/rmi4/Kconfig
index 4c8a558..9f10b1f 100644
--- a/drivers/input/rmi4/Kconfig
+++ b/drivers/input/rmi4/Kconfig
@@ -62,6 +62,17 @@ config RMI4_F30
 	  Function 30 provides GPIO and LED support for RMI4 devices. This
 	  includes support for buttons on TouchPads and ClickPads.
 
+config RMI4_F34
+	bool "RMI4 Function 34 (Device reflash)"
+	depends on RMI4_CORE
+	select FW_LOADER
+	help
+	  Say Y here if you want to add support for RMI4 function 34.
+
+	  Function 34 provides support for upgrading the firmware on the RMI4
+	  device via the firmware loader interface. This is triggered using a
+	  sysfs attribute.
+
 config RMI4_F54
 	bool "RMI4 Function 54 (Analog diagnostics)"
 	depends on RMI4_CORE
diff --git a/drivers/input/rmi4/Makefile b/drivers/input/rmi4/Makefile
index 0bafc85..5f165ad 100644
--- a/drivers/input/rmi4/Makefile
+++ b/drivers/input/rmi4/Makefile
@@ -7,6 +7,7 @@ rmi_core-$(CONFIG_RMI4_2D_SENSOR) += rmi_2d_sensor.o
 rmi_core-$(CONFIG_RMI4_F11) += rmi_f11.o
 rmi_core-$(CONFIG_RMI4_F12) += rmi_f12.o
 rmi_core-$(CONFIG_RMI4_F30) += rmi_f30.o
+rmi_core-$(CONFIG_RMI4_F34) += rmi_f34.o
 rmi_core-$(CONFIG_RMI4_F54) += rmi_f54.o
 
 # Transports
diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
index 3c6a1b5..178d388 100644
--- a/drivers/input/rmi4/rmi_bus.c
+++ b/drivers/input/rmi4/rmi_bus.c
@@ -314,6 +314,9 @@ static struct rmi_function_handler *fn_handlers[] = {
 #ifdef CONFIG_RMI4_F30
 	&rmi_f30_handler,
 #endif
+#ifdef CONFIG_RMI4_F34
+	&rmi_f34_handler,
+#endif
 #ifdef CONFIG_RMI4_F54
 	&rmi_f54_handler,
 #endif
diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index adb3ee8..78fdcef 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -33,14 +33,21 @@
 #define RMI_DEVICE_RESET_CMD	0x01
 #define DEFAULT_RESET_DELAY_MS	100
 
-static void rmi_free_function_list(struct rmi_device *rmi_dev)
+void rmi_free_function_list(struct rmi_device *rmi_dev)
 {
 	struct rmi_function *fn, *tmp;
 	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
 
 	rmi_dbg(RMI_DEBUG_CORE, &rmi_dev->dev, "Freeing function list\n");
 
+	mutex_lock(&data->irq_mutex);
+
 	data->f01_container = NULL;
+	data->f34_container = NULL;
+	data->irq_status = NULL;
+	data->fn_irq_bits = NULL;
+	data->current_irq_mask = NULL;
+	data->new_irq_mask = NULL;
 
 	/* Doing it in the reverse order so F01 will be removed last */
 	list_for_each_entry_safe_reverse(fn, tmp,
@@ -48,7 +55,10 @@ static void rmi_free_function_list(struct rmi_device *rmi_dev)
 		list_del(&fn->node);
 		rmi_unregister_function(fn);
 	}
+
+	mutex_unlock(&data->irq_mutex);
 }
+EXPORT_SYMBOL_GPL(rmi_free_function_list);
 
 static int reset_one_function(struct rmi_function *fn)
 {
@@ -142,8 +152,11 @@ int rmi_process_interrupt_requests(struct rmi_device *rmi_dev)
 	struct rmi_function *entry;
 	int error;
 
-	if (!data)
+	mutex_lock(&data->irq_mutex);
+	if (!data || !data->irq_status || !data->f01_container) {
+		mutex_unlock(&data->irq_mutex);
 		return 0;
+	}
 
 	if (!rmi_dev->xport->attn_data) {
 		error = rmi_read_block(rmi_dev,
@@ -151,18 +164,13 @@ int rmi_process_interrupt_requests(struct rmi_device *rmi_dev)
 				data->irq_status, data->num_of_irq_regs);
 		if (error < 0) {
 			dev_err(dev, "Failed to read irqs, code=%d\n", error);
+			mutex_unlock(&data->irq_mutex);
 			return error;
 		}
 	}
 
-	mutex_lock(&data->irq_mutex);
 	bitmap_and(data->irq_status, data->irq_status, data->current_irq_mask,
 	       data->irq_count);
-	/*
-	 * At this point, irq_status has all bits that are set in the
-	 * interrupt status register and are enabled.
-	 */
-	mutex_unlock(&data->irq_mutex);
 
 	/*
 	 * It would be nice to be able to use irq_chip to handle these
@@ -178,6 +186,8 @@ int rmi_process_interrupt_requests(struct rmi_device *rmi_dev)
 	if (data->input)
 		input_sync(data->input);
 
+	mutex_unlock(&data->irq_mutex);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(rmi_process_interrupt_requests);
@@ -207,12 +217,18 @@ static int rmi_suspend_functions(struct rmi_device *rmi_dev)
 	struct rmi_function *entry;
 	int retval;
 
+	mutex_lock(&data->irq_mutex);
+
 	list_for_each_entry(entry, &data->function_list, node) {
 		retval = suspend_one_function(entry);
-		if (retval < 0)
+		if (retval < 0) {
+			mutex_unlock(&data->irq_mutex);
 			return retval;
+		}
 	}
 
+	mutex_unlock(&data->irq_mutex);
+
 	return 0;
 }
 
@@ -241,16 +257,21 @@ static int rmi_resume_functions(struct rmi_device *rmi_dev)
 	struct rmi_function *entry;
 	int retval;
 
+	mutex_lock(&data->irq_mutex);
+
 	list_for_each_entry(entry, &data->function_list, node) {
 		retval = resume_one_function(entry);
 		if (retval < 0)
+			mutex_unlock(&data->irq_mutex);
 			return retval;
 	}
 
+	mutex_unlock(&data->irq_mutex);
+
 	return 0;
 }
 
-static int enable_sensor(struct rmi_device *rmi_dev)
+int rmi_enable_sensor(struct rmi_device *rmi_dev)
 {
 	int retval = 0;
 
@@ -260,6 +281,7 @@ static int enable_sensor(struct rmi_device *rmi_dev)
 
 	return rmi_process_interrupt_requests(rmi_dev);
 }
+EXPORT_SYMBOL_GPL(rmi_enable_sensor);
 
 /**
  * rmi_driver_set_input_params - set input device id and other data.
@@ -455,10 +477,9 @@ static int rmi_scan_pdt_page(struct rmi_device *rmi_dev,
 					RMI_SCAN_DONE : RMI_SCAN_CONTINUE;
 }
 
-static int rmi_scan_pdt(struct rmi_device *rmi_dev, void *ctx,
-			int (*callback)(struct rmi_device *rmi_dev,
-					void *ctx,
-					const struct pdt_entry *entry))
+int rmi_scan_pdt(struct rmi_device *rmi_dev, void *ctx,
+		 int (*callback)(struct rmi_device *rmi_dev,
+		 void *ctx, const struct pdt_entry *entry))
 {
 	int page;
 	int retval = RMI_SCAN_DONE;
@@ -471,6 +492,7 @@ static int rmi_scan_pdt(struct rmi_device *rmi_dev, void *ctx,
 
 	return retval < 0 ? retval : 0;
 }
+EXPORT_SYMBOL_GPL(rmi_scan_pdt);
 
 int rmi_read_register_desc(struct rmi_device *d, u16 addr,
 				struct rmi_register_descriptor *rdesc)
@@ -691,19 +713,15 @@ static int rmi_count_irqs(struct rmi_device *rmi_dev,
 	int *irq_count = ctx;
 
 	*irq_count += pdt->interrupt_source_count;
-	if (pdt->function_number == 0x01) {
+	if (pdt->function_number == 0x01)
 		data->f01_bootloader_mode =
 			rmi_check_bootloader_mode(rmi_dev, pdt);
-		if (data->f01_bootloader_mode)
-			dev_warn(&rmi_dev->dev,
-				"WARNING: RMI4 device is in bootloader mode!\n");
-	}
 
 	return RMI_SCAN_CONTINUE;
 }
 
-static int rmi_initial_reset(struct rmi_device *rmi_dev,
-			     void *ctx, const struct pdt_entry *pdt)
+int rmi_initial_reset(struct rmi_device *rmi_dev, void *ctx,
+		      const struct pdt_entry *pdt)
 {
 	int error;
 
@@ -738,6 +756,7 @@ static int rmi_initial_reset(struct rmi_device *rmi_dev,
 	/* F01 should always be on page 0. If we don't find it there, fail. */
 	return pdt->page_start == 0 ? RMI_SCAN_CONTINUE : -ENODEV;
 }
+EXPORT_SYMBOL_GPL(rmi_initial_reset);
 
 static int rmi_create_function(struct rmi_device *rmi_dev,
 			       void *ctx, const struct pdt_entry *pdt)
@@ -779,6 +798,8 @@ static int rmi_create_function(struct rmi_device *rmi_dev,
 
 	if (pdt->function_number == 0x01)
 		data->f01_container = fn;
+	else if (pdt->function_number == 0x34)
+		data->f34_container = fn;
 
 	list_add_tail(&fn->node, &data->function_list);
 
@@ -819,6 +840,7 @@ static int rmi_driver_remove(struct device *dev)
 {
 	struct rmi_device *rmi_dev = to_rmi_device(dev);
 
+	rmi_f34_remove_sysfs(rmi_dev);
 	rmi_free_function_list(rmi_dev);
 
 	return 0;
@@ -845,7 +867,7 @@ static inline int rmi_driver_of_probe(struct device *dev,
 }
 #endif
 
-static int rmi_probe_interrupts(struct rmi_driver_data *data)
+int rmi_probe_interrupts(struct rmi_driver_data *data)
 {
 	struct rmi_device *rmi_dev = data->rmi_dev;
 	struct device *dev = &rmi_dev->dev;
@@ -867,6 +889,10 @@ static int rmi_probe_interrupts(struct rmi_driver_data *data)
 		dev_err(dev, "IRQ counting failed with code %d.\n", retval);
 		return retval;
 	}
+
+	if (data->f01_bootloader_mode)
+		dev_warn(&rmi_dev->dev, "Device in bootloader mode.\n");
+
 	data->irq_count = irq_count;
 	data->num_of_irq_regs = (data->irq_count + 7) / 8;
 
@@ -884,14 +910,17 @@ static int rmi_probe_interrupts(struct rmi_driver_data *data)
 
 	return retval;
 }
+EXPORT_SYMBOL_GPL(rmi_probe_interrupts);
 
-static int rmi_init_functions(struct rmi_driver_data *data)
+int rmi_init_functions(struct rmi_driver_data *data)
 {
 	struct rmi_device *rmi_dev = data->rmi_dev;
 	struct device *dev = &rmi_dev->dev;
 	int irq_count;
 	int retval;
 
+	mutex_lock(&data->irq_mutex);
+
 	irq_count = 0;
 	rmi_dbg(RMI_DEBUG_CORE, dev, "%s: Creating functions.\n", __func__);
 	retval = rmi_scan_pdt(rmi_dev, &irq_count, rmi_create_function);
@@ -916,12 +945,16 @@ static int rmi_init_functions(struct rmi_driver_data *data)
 		goto err_destroy_functions;
 	}
 
+	mutex_unlock(&data->irq_mutex);
+
 	return 0;
 
 err_destroy_functions:
 	rmi_free_function_list(rmi_dev);
+	mutex_unlock(&data->irq_mutex);
 	return retval;
 }
+EXPORT_SYMBOL_GPL(rmi_init_functions);
 
 static int rmi_driver_probe(struct device *dev)
 {
@@ -1026,6 +1059,10 @@ static int rmi_driver_probe(struct device *dev)
 	if (retval)
 		goto err;
 
+	retval = rmi_f34_create_sysfs(rmi_dev);
+	if (retval)
+		goto err;
+
 	if (data->input) {
 		rmi_driver_set_input_name(rmi_dev, data->input);
 		if (!rmi_dev->xport->input) {
@@ -1039,7 +1076,7 @@ static int rmi_driver_probe(struct device *dev)
 
 	if (data->f01_container->dev.driver)
 		/* Driver already bound, so enable ATTN now. */
-		return enable_sensor(rmi_dev);
+		return rmi_enable_sensor(rmi_dev);
 
 	return 0;
 
diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_driver.h
index 8dfbebe..e627a3a 100644
--- a/drivers/input/rmi4/rmi_driver.h
+++ b/drivers/input/rmi4/rmi_driver.h
@@ -95,12 +95,36 @@ bool rmi_register_desc_has_subpacket(const struct rmi_register_desc_item *item,
 bool rmi_is_physical_driver(struct device_driver *);
 int rmi_register_physical_driver(void);
 void rmi_unregister_physical_driver(void);
+void rmi_free_function_list(struct rmi_device *rmi_dev);
+int rmi_enable_sensor(struct rmi_device *rmi_dev);
+int rmi_scan_pdt(struct rmi_device *rmi_dev, void *ctx,
+		 int (*callback)(struct rmi_device *rmi_dev, void *ctx,
+		 const struct pdt_entry *entry));
+int rmi_probe_interrupts(struct rmi_driver_data *data);
+int rmi_init_functions(struct rmi_driver_data *data);
+int rmi_initial_reset(struct rmi_device *rmi_dev, void *ctx,
+		      const struct pdt_entry *pdt);
 
 char *rmi_f01_get_product_ID(struct rmi_function *fn);
 
+#ifdef CONFIG_RMI4_F34
+int rmi_f34_create_sysfs(struct rmi_device *rmi_dev);
+void rmi_f34_remove_sysfs(struct rmi_device *rmi_dev);
+#else
+static inline int rmi_f34_create_sysfs(struct rmi_device *rmi_dev)
+{
+	return 0;
+}
+
+static inline void rmi_f34_remove_sysfs(struct rmi_device *rmi_dev)
+{
+}
+#endif /* CONFIG_RMI_F34 */
+
 extern struct rmi_function_handler rmi_f01_handler;
 extern struct rmi_function_handler rmi_f11_handler;
 extern struct rmi_function_handler rmi_f12_handler;
 extern struct rmi_function_handler rmi_f30_handler;
+extern struct rmi_function_handler rmi_f34_handler;
 extern struct rmi_function_handler rmi_f54_handler;
 #endif
diff --git a/drivers/input/rmi4/rmi_f01.c b/drivers/input/rmi4/rmi_f01.c
index b5d2dfc..b64d1cd 100644
--- a/drivers/input/rmi4/rmi_f01.c
+++ b/drivers/input/rmi4/rmi_f01.c
@@ -62,6 +62,8 @@ struct f01_basic_properties {
 #define RMI_F01_STATUS_CODE(status)		((status) & 0x0f)
 /* The device has lost its configuration for some reason. */
 #define RMI_F01_STATUS_UNCONFIGURED(status)	(!!((status) & 0x80))
+/* The device is in bootloader mode */
+#define RMI_F01_STATUS_BOOTLOADER(status)	((status) & 0x40)
 
 /* Control register bits */
 
@@ -593,6 +595,10 @@ static int rmi_f01_attention(struct rmi_function *fn,
 		return error;
 	}
 
+	if (RMI_F01_STATUS_BOOTLOADER(device_status))
+		dev_warn(&fn->dev,
+			 "Device in bootloader mode, please update firmware\n");
+
 	if (RMI_F01_STATUS_UNCONFIGURED(device_status)) {
 		dev_warn(&fn->dev, "Device reset detected.\n");
 		error = rmi_dev->driver->reset_handler(rmi_dev);
diff --git a/drivers/input/rmi4/rmi_f34.c b/drivers/input/rmi4/rmi_f34.c
new file mode 100644
index 0000000..9e4cf34
--- /dev/null
+++ b/drivers/input/rmi4/rmi_f34.c
@@ -0,0 +1,486 @@
+/*
+ * Copyright (c) 2007-2016, Synaptics Incorporated
+ * Copyright (C) 2016 Zodiac Inflight Innovations
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/rmi.h>
+#include <linux/firmware.h>
+#include <asm/unaligned.h>
+#include <asm/unaligned.h>
+
+#include "rmi_driver.h"
+#include "rmi_f34.h"
+
+static int rmi_f34_write_bootloader_id(struct f34_data *f34)
+{
+	struct rmi_function *fn = f34->fn;
+	struct rmi_device *rmi_dev = fn->rmi_dev;
+	u8 bootloader_id[F34_BOOTLOADER_ID_LEN];
+	int ret;
+
+	ret = rmi_read_block(rmi_dev, fn->fd.query_base_addr,
+			     bootloader_id, sizeof(bootloader_id));
+	if (ret) {
+		dev_err(&fn->dev, "%s: Reading bootloader ID failed: %d\n",
+				__func__, ret);
+		return ret;
+	}
+
+	rmi_dbg(RMI_DEBUG_FN, &fn->dev, "%s: writing bootloader id '%c%c'\n",
+			__func__, bootloader_id[0], bootloader_id[1]);
+
+	ret = rmi_write_block(rmi_dev,
+			      fn->fd.data_base_addr + F34_BLOCK_DATA_OFFSET,
+			      bootloader_id, sizeof(bootloader_id));
+	if (ret) {
+		dev_err(&fn->dev, "Failed to write bootloader ID: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int rmi_f34_command(struct f34_data *f34, u8 command,
+			   unsigned int timeout, bool write_bl_id)
+{
+	struct rmi_function *fn = f34->fn;
+	struct rmi_device *rmi_dev = fn->rmi_dev;
+	int ret;
+
+	if (write_bl_id) {
+		ret = rmi_f34_write_bootloader_id(f34);
+		if (ret)
+			return ret;
+	}
+
+	init_completion(&f34->cmd_done);
+
+	ret = rmi_read(rmi_dev, f34->ctrl_address, &f34->status);
+	if (ret) {
+		dev_err(&f34->fn->dev,
+			"%s: Failed to read cmd register: %d (command %#02x)\n",
+			__func__, ret, command);
+		return ret;
+	}
+
+	f34->status |= command & 0x0f;
+
+	ret = rmi_write(rmi_dev, f34->ctrl_address, f34->status);
+	if (ret < 0) {
+		dev_err(&f34->fn->dev,
+			"Failed to write F34 command %#02x: %d\n",
+			command, ret);
+		return ret;
+	}
+
+	if (!wait_for_completion_timeout(&f34->cmd_done,
+				msecs_to_jiffies(timeout))) {
+
+		ret = rmi_read(rmi_dev, f34->ctrl_address, &f34->status);
+		if (ret) {
+			dev_err(&f34->fn->dev,
+				"%s: cmd %#02x timed out: %d\n",
+				__func__, command, ret);
+			return ret;
+		}
+
+		if (f34->status & 0x7f) {
+			dev_err(&f34->fn->dev,
+				"%s: cmd %#02x timed out, status: %#02x\n",
+				__func__, command, f34->status);
+			return -ETIMEDOUT;
+		}
+	}
+
+	return 0;
+}
+
+static int rmi_f34_attention(struct rmi_function *fn, unsigned long *irq_bits)
+{
+	struct f34_data *f34 = dev_get_drvdata(&fn->dev);
+	int ret;
+
+	ret = rmi_read(f34->fn->rmi_dev, f34->ctrl_address, &f34->status);
+	rmi_dbg(RMI_DEBUG_FN, &fn->dev, "%s: status: %#02x, ret: %d\n",
+		__func__, f34->status, ret);
+
+	if (!ret && !(f34->status & 0x7f))
+		complete(&f34->cmd_done);
+
+	return 0;
+}
+
+static int rmi_f34_write_blocks(struct f34_data *f34, const void *data,
+				int block_count, u8 command)
+{
+	struct rmi_function *fn = f34->fn;
+	struct rmi_device *rmi_dev = fn->rmi_dev;
+	u16 address = fn->fd.data_base_addr + F34_BLOCK_DATA_OFFSET;
+	u8 start_address[] = { 0, 0 };
+	int i;
+	int ret;
+
+	ret = rmi_write_block(rmi_dev, fn->fd.data_base_addr,
+			      start_address, sizeof(start_address));
+	if (ret) {
+		dev_err(&fn->dev, "Failed to write initial zeros: %d\n", ret);
+		return ret;
+	}
+
+	for (i = 0; i < block_count; i++) {
+		ret = rmi_write_block(rmi_dev, address, data, f34->block_size);
+		if (ret) {
+			dev_err(&fn->dev,
+				"failed to write block #%d: %d\n", i, ret);
+			return ret;
+		}
+
+		ret = rmi_f34_command(f34, command, F34_IDLE_WAIT_MS, false);
+		if (ret) {
+			dev_err(&fn->dev,
+				"Failed to write command for block #%d: %d\n",
+				i, ret);
+			return ret;
+		}
+
+		rmi_dbg(RMI_DEBUG_FN, &fn->dev, "wrote block %d of %d\n",
+			i + 1, block_count);
+
+		data += f34->block_size;
+	}
+
+	return 0;
+}
+
+static int rmi_f34_write_firmware(struct f34_data *f34, const void *data)
+{
+	return rmi_f34_write_blocks(f34, data, f34->fw_blocks,
+				    F34_WRITE_FW_BLOCK);
+}
+
+static int rmi_f34_write_config(struct f34_data *f34, const void *data)
+{
+	return rmi_f34_write_blocks(f34, data, f34->config_blocks,
+				    F34_WRITE_CONFIG_BLOCK);
+}
+
+int rmi_f34_enable_flash(struct rmi_function *fn)
+{
+	struct f34_data *f34 = dev_get_drvdata(&fn->dev);
+
+	return rmi_f34_command(f34, F34_ENABLE_FLASH_PROG,
+			       F34_ENABLE_WAIT_MS, true);
+}
+
+static int rmi_f34_flash_firmware(struct f34_data *f34,
+					 const struct rmi_f34_firmware *syn_fw)
+{
+	struct rmi_function *fn = f34->fn;
+	int ret;
+
+	if (syn_fw->image_size) {
+		dev_info(&fn->dev, "Erasing firmware...\n");
+		ret = rmi_f34_command(f34, F34_ERASE_ALL,
+				      F34_ERASE_WAIT_MS, true);
+		if (ret)
+			return ret;
+
+		dev_info(&fn->dev, "Writing firmware (%d bytes)...\n",
+			 syn_fw->image_size);
+		ret = rmi_f34_write_firmware(f34, syn_fw->data);
+		if (ret)
+			return ret;
+	}
+
+	if (syn_fw->config_size) {
+		/*
+		 * We only need to erase config if we haven't updated
+		 * firmware.
+		 */
+		if (!syn_fw->image_size) {
+			dev_info(&fn->dev, "Erasing config...\n");
+			ret = rmi_f34_command(f34, F34_ERASE_CONFIG,
+					      F34_ERASE_WAIT_MS, true);
+			if (ret)
+				return ret;
+		}
+
+		dev_info(&fn->dev, "Writing config (%d bytes)...\n",
+			 syn_fw->config_size);
+		ret = rmi_f34_write_config(f34,
+				&syn_fw->data[syn_fw->image_size]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+int rmi_f34_update_firmware(struct rmi_function *fn, const struct firmware *fw)
+{
+	struct f34_data *f34 = dev_get_drvdata(&fn->dev);
+	const struct rmi_f34_firmware *syn_fw;
+	int ret;
+
+	syn_fw = (const struct rmi_f34_firmware *)fw->data;
+	BUILD_BUG_ON(offsetof(struct rmi_f34_firmware, data) !=
+			F34_FW_IMAGE_OFFSET);
+
+	rmi_dbg(RMI_DEBUG_FN, &fn->dev,
+		"FW size:%d, checksum:%08x, image_size:%d, config_size:%d\n",
+		(int)fw->size,
+		le32_to_cpu(syn_fw->checksum),
+		le32_to_cpu(syn_fw->image_size),
+		le32_to_cpu(syn_fw->config_size));
+
+	rmi_dbg(RMI_DEBUG_FN, &fn->dev,
+		"FW bootloader_id:%02x, product_id:%.*s, info: %02x%02x\n",
+		syn_fw->bootloader_version,
+		(int)sizeof(syn_fw->product_id), syn_fw->product_id,
+		syn_fw->product_info[0], syn_fw->product_info[1]);
+
+	if (syn_fw->image_size &&
+	    syn_fw->image_size != f34->fw_blocks * f34->block_size) {
+		dev_err(&fn->dev,
+			"Bad firmware image: fw size %d, expected %d\n",
+			syn_fw->image_size,
+			f34->fw_blocks * f34->block_size);
+		ret = -EILSEQ;
+		goto out;
+	}
+
+	if (syn_fw->config_size &&
+	    syn_fw->config_size != f34->config_blocks * f34->block_size) {
+		dev_err(&fn->dev,
+			"Bad firmware image: config size %d, expected %d\n",
+			syn_fw->config_size,
+			f34->config_blocks * f34->block_size);
+		ret = -EILSEQ;
+		goto out;
+	}
+
+	if (syn_fw->image_size && !syn_fw->config_size) {
+		dev_err(&fn->dev, "Bad firmware image: no config data\n");
+		ret = -EILSEQ;
+		goto out;
+	}
+
+	dev_info(&f34->fn->dev, "Firmware image OK\n");
+	mutex_lock(&f34->flash_mutex);
+
+	ret = rmi_f34_flash_firmware(f34, syn_fw);
+
+	mutex_unlock(&f34->flash_mutex);
+
+out:
+	return ret;
+}
+
+int rmi_f34_check_supported(struct rmi_function *fn)
+{
+	u8 version = fn->fd.function_version;
+
+	/* Only version 0 currently supported */
+	if (version == 0)
+		return 0;
+
+	dev_warn(&fn->dev, "F34 V%d not supported!\n", version);
+	return -ENODEV;
+}
+
+static int rmi_firmware_update(struct rmi_driver_data *data,
+			       const struct firmware *fw)
+{
+	struct device *dev = &data->rmi_dev->dev;
+	int ret;
+
+	if (!data->f34_container) {
+		dev_warn(dev, "%s: No F34 present!\n", __func__);
+		return -EINVAL;
+	}
+
+	ret = rmi_f34_check_supported(data->f34_container);
+	if (ret)
+		return ret;
+
+	/* Enter flash mode */
+	rmi_dbg(RMI_DEBUG_FN, dev, "Enabling flash\n");
+	ret = rmi_f34_enable_flash(data->f34_container);
+	if (ret)
+		return ret;
+
+	/* Tear down functions and re-probe */
+	rmi_free_function_list(data->rmi_dev);
+
+	ret = rmi_probe_interrupts(data);
+	if (ret)
+		return ret;
+
+	ret = rmi_init_functions(data);
+	if (ret)
+		return ret;
+
+	if (!data->f01_bootloader_mode || !data->f34_container) {
+		dev_warn(dev, "%s: No F34 present or not in bootloader!\n",
+			 __func__);
+		return -EINVAL;
+	}
+
+	/* Perform firmware update */
+	ret = rmi_f34_update_firmware(data->f34_container, fw);
+
+	/* Re-probe */
+	rmi_dbg(RMI_DEBUG_FN, dev, "Re-probing device\n");
+	rmi_free_function_list(data->rmi_dev);
+
+	ret = rmi_scan_pdt(data->rmi_dev, NULL, rmi_initial_reset);
+	if (ret < 0)
+		dev_warn(dev, "RMI reset failed!\n");
+
+	ret = rmi_probe_interrupts(data);
+	if (ret)
+		return ret;
+
+	ret = rmi_init_functions(data);
+	if (ret)
+		return ret;
+
+	if (data->f01_container->dev.driver)
+		/* Driver already bound, so enable ATTN now. */
+		return rmi_enable_sensor(data->rmi_dev);
+
+	rmi_dbg(RMI_DEBUG_FN, dev, "%s complete\n", __func__);
+
+	return ret;
+}
+
+static ssize_t rmi_driver_update_fw_store(struct device *dev,
+					  struct device_attribute *dattr,
+					  const char *buf, size_t count)
+{
+	struct rmi_driver_data *data = dev_get_drvdata(dev);
+	char fw_name[NAME_MAX];
+	const struct firmware *fw;
+	size_t copy_count = count;
+	int ret;
+
+	if (count == 0 || count >= NAME_MAX)
+		return -EINVAL;
+
+	if (buf[count - 1] == '\0' || buf[count - 1] == '\n')
+		copy_count -= 1;
+
+	strncpy(fw_name, buf, copy_count);
+	fw_name[copy_count] = '\0';
+
+	ret = request_firmware(&fw, fw_name, dev);
+	if (ret)
+		return ret;
+
+	dev_info(dev, "Flashing %s\n", fw_name);
+
+	ret = rmi_firmware_update(data, fw);
+
+	release_firmware(fw);
+
+	return ret ?: count;
+}
+
+static DEVICE_ATTR(update_fw, 0200, NULL, rmi_driver_update_fw_store);
+
+static struct attribute *rmi_firmware_attrs[] = {
+	&dev_attr_update_fw.attr,
+	NULL
+};
+
+static struct attribute_group rmi_firmware_attr_group = {
+	.attrs = rmi_firmware_attrs,
+};
+
+static int rmi_f34_probe(struct rmi_function *fn)
+{
+	struct f34_data *f34;
+	unsigned char f34_queries[9];
+	bool has_config_id;
+	int ret;
+
+	ret = rmi_f34_check_supported(fn);
+	if (ret)
+		return ret;
+
+	f34 = devm_kzalloc(&fn->dev, sizeof(struct f34_data), GFP_KERNEL);
+	if (!f34)
+		return -ENOMEM;
+
+	f34->fn = fn;
+	dev_set_drvdata(&fn->dev, f34);
+
+	mutex_init(&f34->flash_mutex);
+	init_completion(&f34->cmd_done);
+
+	ret = rmi_read_block(fn->rmi_dev, fn->fd.query_base_addr,
+			     f34_queries, sizeof(f34_queries));
+	if (ret) {
+		dev_err(&fn->dev, "%s: Failed to query properties\n",
+				__func__);
+		return ret;
+	}
+
+	snprintf(f34->bootloader_id, sizeof(f34->bootloader_id),
+		 "%c%c", f34_queries[0], f34_queries[1]);
+
+	f34->block_size = get_unaligned_le16(&f34_queries[3]);
+	f34->fw_blocks = get_unaligned_le16(&f34_queries[5]);
+	f34->config_blocks = get_unaligned_le16(&f34_queries[7]);
+	f34->ctrl_address = fn->fd.data_base_addr + F34_BLOCK_DATA_OFFSET +
+		f34->block_size;
+	has_config_id = f34_queries[2] & (1 << 2);
+
+	rmi_dbg(RMI_DEBUG_FN, &fn->dev, "Bootloader ID: %s\n", f34->bootloader_id);
+	rmi_dbg(RMI_DEBUG_FN, &fn->dev, "Block size: %d\n", f34->block_size);
+	rmi_dbg(RMI_DEBUG_FN, &fn->dev, "FW blocks: %d\n", f34->fw_blocks);
+	rmi_dbg(RMI_DEBUG_FN, &fn->dev, "CFG blocks: %d\n", f34->config_blocks);
+
+	if (has_config_id) {
+		ret = rmi_read_block(fn->rmi_dev, fn->fd.control_base_addr,
+				     f34_queries, sizeof(f34_queries));
+		if (ret) {
+			dev_err(&fn->dev, "Failed to read F34 config ID\n");
+			return ret;
+		}
+
+		snprintf(f34->configuration_id, sizeof(f34->configuration_id),
+			 "%02x%02x%02x%02x",
+			 f34_queries[0], f34_queries[1],
+			 f34_queries[2], f34_queries[3]);
+
+		rmi_dbg(RMI_DEBUG_FN, &fn->dev, "Configuration ID: %s\n",
+			 f34->configuration_id);
+	}
+
+	return 0;
+}
+
+int rmi_f34_create_sysfs(struct rmi_device *rmi_dev)
+{
+	return sysfs_create_group(&rmi_dev->dev.kobj, &rmi_firmware_attr_group);
+}
+
+void rmi_f34_remove_sysfs(struct rmi_device *rmi_dev)
+{
+	sysfs_remove_group(&rmi_dev->dev.kobj, &rmi_firmware_attr_group);
+}
+
+struct rmi_function_handler rmi_f34_handler = {
+	.driver = {
+		.name = "rmi4_f34",
+	},
+	.func = 0x34,
+	.probe = rmi_f34_probe,
+	.attention = rmi_f34_attention,
+};
diff --git a/drivers/input/rmi4/rmi_f34.h b/drivers/input/rmi4/rmi_f34.h
new file mode 100644
index 0000000..0c19a58
--- /dev/null
+++ b/drivers/input/rmi4/rmi_f34.h
@@ -0,0 +1,64 @@
+/*
+ * Copyright (c) 2007-2016, Synaptics Incorporated
+ * Copyright (C) 2016 Zodiac Inflight Innovations
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#ifndef _RMI_F34_H
+#define _RMI_F34_H
+
+/* F34 image file offsets. */
+#define F34_FW_IMAGE_OFFSET	0x100
+
+/* F34 register offsets. */
+#define F34_BLOCK_DATA_OFFSET	2
+
+/* F34 commands */
+#define F34_WRITE_FW_BLOCK	0x2
+#define F34_ERASE_ALL		0x3
+#define F34_READ_CONFIG_BLOCK	0x5
+#define F34_WRITE_CONFIG_BLOCK	0x6
+#define F34_ERASE_CONFIG	0x7
+#define F34_ENABLE_FLASH_PROG	0xf
+
+#define F34_STATUS_IN_PROGRESS	0xff
+#define F34_STATUS_IDLE		0x80
+
+#define F34_IDLE_WAIT_MS	500
+#define F34_ENABLE_WAIT_MS	300
+#define F34_ERASE_WAIT_MS	5000
+
+#define F34_BOOTLOADER_ID_LEN	2
+
+struct rmi_f34_firmware {
+	__le32 checksum;
+	u8 pad1[3];
+	u8 bootloader_version;
+	__le32 image_size;
+	__le32 config_size;
+	u8 product_id[10];
+	u8 product_info[2];
+	u8 pad2[228];
+	u8 data[];
+};
+
+struct f34_data {
+	struct rmi_function *fn;
+
+	u16 block_size;
+	u16 fw_blocks;
+	u16 config_blocks;
+	u16 ctrl_address;
+	u8 status;
+
+	struct completion cmd_done;
+	struct mutex flash_mutex;
+
+	unsigned char bootloader_id[5];
+	unsigned char configuration_id[9];
+};
+
+#endif /* _RMI_F34_H */
diff --git a/include/linux/rmi.h b/include/linux/rmi.h
index e0aca14..a283a67 100644
--- a/include/linux/rmi.h
+++ b/include/linux/rmi.h
@@ -330,6 +330,7 @@ struct rmi_driver_data {
 	struct rmi_device *rmi_dev;
 
 	struct rmi_function *f01_container;
+	struct rmi_function *f34_container;
 	bool f01_bootloader_mode;
 
 	u32 attn_count;
-- 
2.7.4


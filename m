From: Nick Dyer <nick@shmanahar.org>
Subject: [PATCH v1] Input: synaptics-rmi4 - convert irq distribution to irq_domain
Date: Wed, 24 Jan 2018 21:26:33 +0000
Message-ID: <1516829193-27590-1-git-send-email-nick@shmanahar.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avasout06.plus.net ([212.159.14.18]:52252 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932238AbeAXV0u (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 24 Jan 2018 16:26:50 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, linux-input@vger.kernel.org, Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, Nick Dyer <nick@shmanahar.org>

Convert the RMI driver to use the standard mechanism for
distributing IRQs to the various functions.

Tested on:
* S7300 (F11, F34, F54)
* S7817 (F12, F34, F54)

Signed-off-by: Nick Dyer <nick@shmanahar.org>
---
 drivers/input/rmi4/Kconfig      |  1 +
 drivers/input/rmi4/rmi_bus.c    | 13 ++++++++-
 drivers/input/rmi4/rmi_bus.h    |  3 +-
 drivers/input/rmi4/rmi_driver.c | 65 ++++++++++++++++++++---------------------
 drivers/input/rmi4/rmi_f01.c    | 10 +++----
 drivers/input/rmi4/rmi_f03.c    |  9 +++---
 drivers/input/rmi4/rmi_f11.c    | 25 +++++++---------
 drivers/input/rmi4/rmi_f12.c    |  8 ++---
 drivers/input/rmi4/rmi_f30.c    |  9 +++---
 drivers/input/rmi4/rmi_f34.c    |  5 ++--
 drivers/input/rmi4/rmi_f54.c    |  6 ----
 include/linux/rmi.h             |  2 ++
 12 files changed, 81 insertions(+), 75 deletions(-)

diff --git a/drivers/input/rmi4/Kconfig b/drivers/input/rmi4/Kconfig
index 7172b88..fad2eae 100644
--- a/drivers/input/rmi4/Kconfig
+++ b/drivers/input/rmi4/Kconfig
@@ -3,6 +3,7 @@
 #
 config RMI4_CORE
 	tristate "Synaptics RMI4 bus support"
+	select IRQ_DOMAIN
 	help
 	  Say Y here if you want to support the Synaptics RMI4 bus.  This is
 	  required for all RMI4 device support.
diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
index ae1bffe..ae288d6 100644
--- a/drivers/input/rmi4/rmi_bus.c
+++ b/drivers/input/rmi4/rmi_bus.c
@@ -178,7 +178,18 @@ static int rmi_function_probe(struct device *dev)
 
 	if (handler->probe) {
 		error = handler->probe(fn);
-		return error;
+		if (error)
+			return error;
+	}
+
+	if (fn->irq_base && handler->attention) {
+		error = devm_request_threaded_irq(&fn->dev, fn->irq_base, NULL,
+					handler->attention, IRQF_ONESHOT,
+					dev_name(&fn->dev), fn);
+		if (error) {
+			dev_err(dev, "Failed registering IRQ %d\n", error);
+			return error;
+		}
 	}
 
 	return 0;
diff --git a/drivers/input/rmi4/rmi_bus.h b/drivers/input/rmi4/rmi_bus.h
index b7625a9..745a030 100644
--- a/drivers/input/rmi4/rmi_bus.h
+++ b/drivers/input/rmi4/rmi_bus.h
@@ -35,6 +35,7 @@ struct rmi_function {
 	struct device dev;
 	struct list_head node;
 
+	unsigned int irq_base;
 	unsigned int num_of_irqs;
 	unsigned int irq_pos;
 	unsigned long irq_mask[];
@@ -76,7 +77,7 @@ struct rmi_function_handler {
 	void (*remove)(struct rmi_function *fn);
 	int (*config)(struct rmi_function *fn);
 	int (*reset)(struct rmi_function *fn);
-	int (*attention)(struct rmi_function *fn, unsigned long *irq_bits);
+	irqreturn_t (*attention)(int irq, void *ctx);
 	int (*suspend)(struct rmi_function *fn);
 	int (*resume)(struct rmi_function *fn);
 };
diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 141ea22..b7ef1f5a 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -21,6 +21,7 @@
 #include <linux/pm.h>
 #include <linux/slab.h>
 #include <linux/of.h>
+#include <linux/irqdomain.h>
 #include <uapi/linux/input.h>
 #include <linux/rmi.h>
 #include "rmi_bus.h"
@@ -127,28 +128,11 @@ static int rmi_driver_process_config_requests(struct rmi_device *rmi_dev)
 	return 0;
 }
 
-static void process_one_interrupt(struct rmi_driver_data *data,
-				  struct rmi_function *fn)
-{
-	struct rmi_function_handler *fh;
-
-	if (!fn || !fn->dev.driver)
-		return;
-
-	fh = to_rmi_function_handler(fn->dev.driver);
-	if (fh->attention) {
-		bitmap_and(data->fn_irq_bits, data->irq_status, fn->irq_mask,
-				data->irq_count);
-		if (!bitmap_empty(data->fn_irq_bits, data->irq_count))
-			fh->attention(fn, data->fn_irq_bits);
-	}
-}
-
 static int rmi_process_interrupt_requests(struct rmi_device *rmi_dev)
 {
 	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
 	struct device *dev = &rmi_dev->dev;
-	struct rmi_function *entry;
+	int i;
 	int error;
 
 	if (!data)
@@ -173,16 +157,8 @@ static int rmi_process_interrupt_requests(struct rmi_device *rmi_dev)
 	 */
 	mutex_unlock(&data->irq_mutex);
 
-	/*
-	 * It would be nice to be able to use irq_chip to handle these
-	 * nested IRQs.  Unfortunately, most of the current customers for
-	 * this driver are using older kernels (3.0.x) that don't support
-	 * the features required for that.  Once they've shifted to more
-	 * recent kernels (say, 3.3 and higher), this should be switched to
-	 * use irq_chip.
-	 */
-	list_for_each_entry(entry, &data->function_list, node)
-		process_one_interrupt(data, entry);
+	for_each_set_bit(i, data->irq_status, data->irq_count)
+		handle_nested_irq(irq_find_mapping(data->irqdomain, i));
 
 	if (data->input)
 		input_sync(data->input);
@@ -847,6 +823,10 @@ int rmi_initial_reset(struct rmi_device *rmi_dev, void *ctx,
 	return pdt->page_start == 0 ? RMI_SCAN_CONTINUE : -ENODEV;
 }
 
+static struct irq_chip rmi_irq_chip = {
+	.name = "rmi4",
+};
+
 static int rmi_create_function(struct rmi_device *rmi_dev,
 			       void *ctx, const struct pdt_entry *pdt)
 {
@@ -878,9 +858,18 @@ static int rmi_create_function(struct rmi_device *rmi_dev,
 	fn->irq_pos = *current_irq_count;
 	*current_irq_count += fn->num_of_irqs;
 
-	for (i = 0; i < fn->num_of_irqs; i++)
+	for (i = 0; i < fn->num_of_irqs; i++) {
 		set_bit(fn->irq_pos + i, fn->irq_mask);
 
+		fn->irq_base = irq_create_mapping(data->irqdomain,
+						  fn->irq_pos + i);
+
+
+		irq_set_chip_data(fn->irq_base, data);
+		irq_set_chip_and_handler(fn->irq_base, &rmi_irq_chip,
+					 handle_simple_irq);
+	}
+
 	error = rmi_register_function(fn);
 	if (error)
 		goto err_put_fn;
@@ -1000,9 +989,12 @@ EXPORT_SYMBOL_GPL(rmi_driver_resume);
 static int rmi_driver_remove(struct device *dev)
 {
 	struct rmi_device *rmi_dev = to_rmi_device(dev);
+	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
 
 	rmi_disable_irq(rmi_dev, false);
 
+	irq_domain_remove(data->irqdomain);
+
 	rmi_f34_remove_sysfs(rmi_dev);
 	rmi_free_function_list(rmi_dev);
 
@@ -1034,7 +1026,8 @@ int rmi_probe_interrupts(struct rmi_driver_data *data)
 {
 	struct rmi_device *rmi_dev = data->rmi_dev;
 	struct device *dev = &rmi_dev->dev;
-	int irq_count;
+	struct device_node *rmi_of_node = rmi_dev->xport->dev->of_node;
+	int irq_count = 0;
 	size_t size;
 	int retval;
 
@@ -1045,7 +1038,6 @@ int rmi_probe_interrupts(struct rmi_driver_data *data)
 	 * being accessed.
 	 */
 	rmi_dbg(RMI_DEBUG_CORE, dev, "%s: Counting IRQs.\n", __func__);
-	irq_count = 0;
 	data->bootloader_mode = false;
 
 	retval = rmi_scan_pdt(rmi_dev, &irq_count, rmi_count_irqs);
@@ -1057,6 +1049,14 @@ int rmi_probe_interrupts(struct rmi_driver_data *data)
 	if (data->bootloader_mode)
 		dev_warn(dev, "Device in bootloader mode.\n");
 
+	/* Allocate and register a linear revmap irq_domain */
+	data->irqdomain = irq_domain_add_linear(rmi_of_node, irq_count,
+					        &irq_domain_simple_ops, data);
+	if (!data->irqdomain) {
+		dev_err(&rmi_dev->dev, "Failed to create IRQ domain\n");
+		return PTR_ERR(data->irqdomain);
+	}
+
 	data->irq_count = irq_count;
 	data->num_of_irq_regs = (data->irq_count + 7) / 8;
 
@@ -1079,10 +1079,9 @@ int rmi_init_functions(struct rmi_driver_data *data)
 {
 	struct rmi_device *rmi_dev = data->rmi_dev;
 	struct device *dev = &rmi_dev->dev;
-	int irq_count;
+	int irq_count = 0;
 	int retval;
 
-	irq_count = 0;
 	rmi_dbg(RMI_DEBUG_CORE, dev, "%s: Creating functions.\n", __func__);
 	retval = rmi_scan_pdt(rmi_dev, &irq_count, rmi_create_function);
 	if (retval < 0) {
diff --git a/drivers/input/rmi4/rmi_f01.c b/drivers/input/rmi4/rmi_f01.c
index 8a07ae1..4edaa14 100644
--- a/drivers/input/rmi4/rmi_f01.c
+++ b/drivers/input/rmi4/rmi_f01.c
@@ -681,9 +681,9 @@ static int rmi_f01_resume(struct rmi_function *fn)
 	return 0;
 }
 
-static int rmi_f01_attention(struct rmi_function *fn,
-			     unsigned long *irq_bits)
+static irqreturn_t rmi_f01_attention(int irq, void *ctx)
 {
+	struct rmi_function *fn = ctx;
 	struct rmi_device *rmi_dev = fn->rmi_dev;
 	int error;
 	u8 device_status;
@@ -692,7 +692,7 @@ static int rmi_f01_attention(struct rmi_function *fn,
 	if (error) {
 		dev_err(&fn->dev,
 			"Failed to read device status: %d.\n", error);
-		return error;
+		return IRQ_RETVAL(error);
 	}
 
 	if (RMI_F01_STATUS_BOOTLOADER(device_status))
@@ -704,11 +704,11 @@ static int rmi_f01_attention(struct rmi_function *fn,
 		error = rmi_dev->driver->reset_handler(rmi_dev);
 		if (error) {
 			dev_err(&fn->dev, "Device reset failed: %d\n", error);
-			return error;
+			return IRQ_RETVAL(error);
 		}
 	}
 
-	return 0;
+	return IRQ_HANDLED;
 }
 
 struct rmi_function_handler rmi_f01_handler = {
diff --git a/drivers/input/rmi4/rmi_f03.c b/drivers/input/rmi4/rmi_f03.c
index ad71a5e..b9f07c9 100644
--- a/drivers/input/rmi4/rmi_f03.c
+++ b/drivers/input/rmi4/rmi_f03.c
@@ -199,8 +199,9 @@ static int rmi_f03_config(struct rmi_function *fn)
 	return 0;
 }
 
-static int rmi_f03_attention(struct rmi_function *fn, unsigned long *irq_bits)
+static irqreturn_t rmi_f03_attention(int irq, void *ctx)
 {
+	struct rmi_function *fn = ctx;
 	struct rmi_device *rmi_dev = fn->rmi_dev;
 	struct rmi_driver_data *drvdata = dev_get_drvdata(&rmi_dev->dev);
 	struct f03_data *f03 = dev_get_drvdata(&fn->dev);
@@ -217,7 +218,7 @@ static int rmi_f03_attention(struct rmi_function *fn, unsigned long *irq_bits)
 		/* First grab the data passed by the transport device */
 		if (drvdata->attn_data.size < ob_len) {
 			dev_warn(&fn->dev, "F03 interrupted, but data is missing!\n");
-			return 0;
+			return IRQ_HANDLED;
 		}
 
 		memcpy(obs, drvdata->attn_data.data, ob_len);
@@ -233,7 +234,7 @@ static int rmi_f03_attention(struct rmi_function *fn, unsigned long *irq_bits)
 				"%s: Failed to read F03 output buffers: %d\n",
 				__func__, error);
 			serio_interrupt(f03->serio, 0, SERIO_TIMEOUT);
-			return error;
+			return IRQ_RETVAL(error);
 		}
 	}
 
@@ -259,7 +260,7 @@ static int rmi_f03_attention(struct rmi_function *fn, unsigned long *irq_bits)
 		serio_interrupt(f03->serio, ob_data, serio_flags);
 	}
 
-	return 0;
+	return IRQ_HANDLED;
 }
 
 static void rmi_f03_remove(struct rmi_function *fn)
diff --git a/drivers/input/rmi4/rmi_f11.c b/drivers/input/rmi4/rmi_f11.c
index bc5e37f..e587c87 100644
--- a/drivers/input/rmi4/rmi_f11.c
+++ b/drivers/input/rmi4/rmi_f11.c
@@ -571,8 +571,7 @@ static inline u8 rmi_f11_parse_finger_state(const u8 *f_state, u8 n_finger)
 
 static void rmi_f11_finger_handler(struct f11_data *f11,
 				   struct rmi_2d_sensor *sensor,
-				   unsigned long *irq_bits, int num_irq_regs,
-				   int size)
+				   int num_irq_regs, int size)
 {
 	const u8 *f_state = f11->data.f_state;
 	u8 finger_state;
@@ -581,12 +580,7 @@ static void rmi_f11_finger_handler(struct f11_data *f11,
 	int rel_fingers;
 	int abs_size = sensor->nbr_fingers * RMI_F11_ABS_BYTES;
 
-	int abs_bits = bitmap_and(f11->result_bits, irq_bits, f11->abs_mask,
-				  num_irq_regs * 8);
-	int rel_bits = bitmap_and(f11->result_bits, irq_bits, f11->rel_mask,
-				  num_irq_regs * 8);
-
-	if (abs_bits) {
+	if (sensor->report_abs) {
 		if (abs_size > size)
 			abs_fingers = size / RMI_F11_ABS_BYTES;
 		else
@@ -606,7 +600,7 @@ static void rmi_f11_finger_handler(struct f11_data *f11,
 		}
 	}
 
-	if (rel_bits) {
+	if (sensor->report_rel) {
 		if ((abs_size + sensor->nbr_fingers * RMI_F11_REL_BYTES) > size)
 			rel_fingers = (size - abs_size) / RMI_F11_REL_BYTES;
 		else
@@ -616,7 +610,7 @@ static void rmi_f11_finger_handler(struct f11_data *f11,
 			rmi_f11_rel_pos_report(f11, i);
 	}
 
-	if (abs_bits) {
+	if (sensor->report_abs) {
 		/*
 		 * the absolute part is made in 2 parts to allow the kernel
 		 * tracking to take place.
@@ -1275,8 +1269,9 @@ static int rmi_f11_config(struct rmi_function *fn)
 	return 0;
 }
 
-static int rmi_f11_attention(struct rmi_function *fn, unsigned long *irq_bits)
+static irqreturn_t rmi_f11_attention(int irq, void *ctx)
 {
+	struct rmi_function *fn = ctx;
 	struct rmi_device *rmi_dev = fn->rmi_dev;
 	struct rmi_driver_data *drvdata = dev_get_drvdata(&rmi_dev->dev);
 	struct f11_data *f11 = dev_get_drvdata(&fn->dev);
@@ -1302,13 +1297,13 @@ static int rmi_f11_attention(struct rmi_function *fn, unsigned long *irq_bits)
 				data_base_addr, f11->sensor.data_pkt,
 				f11->sensor.pkt_size);
 		if (error < 0)
-			return error;
+			return IRQ_RETVAL(error);
 	}
 
-	rmi_f11_finger_handler(f11, &f11->sensor, irq_bits,
-				drvdata->num_of_irq_regs, valid_bytes);
+	rmi_f11_finger_handler(f11, &f11->sensor,
+			       drvdata->num_of_irq_regs, valid_bytes);
 
-	return 0;
+	return IRQ_HANDLED;
 }
 
 static int rmi_f11_resume(struct rmi_function *fn)
diff --git a/drivers/input/rmi4/rmi_f12.c b/drivers/input/rmi4/rmi_f12.c
index 8b0db08..e226def 100644
--- a/drivers/input/rmi4/rmi_f12.c
+++ b/drivers/input/rmi4/rmi_f12.c
@@ -197,10 +197,10 @@ static void rmi_f12_process_objects(struct f12_data *f12, u8 *data1, int size)
 		rmi_2d_sensor_abs_report(sensor, &sensor->objs[i], i);
 }
 
-static int rmi_f12_attention(struct rmi_function *fn,
-			     unsigned long *irq_nr_regs)
+static irqreturn_t rmi_f12_attention(int irq, void *ctx)
 {
 	int retval;
+	struct rmi_function *fn = ctx;
 	struct rmi_device *rmi_dev = fn->rmi_dev;
 	struct rmi_driver_data *drvdata = dev_get_drvdata(&rmi_dev->dev);
 	struct f12_data *f12 = dev_get_drvdata(&fn->dev);
@@ -222,7 +222,7 @@ static int rmi_f12_attention(struct rmi_function *fn,
 		if (retval < 0) {
 			dev_err(&fn->dev, "Failed to read object data. Code: %d.\n",
 				retval);
-			return retval;
+			return IRQ_RETVAL(retval);
 		}
 	}
 
@@ -232,7 +232,7 @@ static int rmi_f12_attention(struct rmi_function *fn,
 
 	input_mt_sync_frame(sensor->input);
 
-	return 0;
+	return IRQ_HANDLED;
 }
 
 static int rmi_f12_write_control_regs(struct rmi_function *fn)
diff --git a/drivers/input/rmi4/rmi_f30.c b/drivers/input/rmi4/rmi_f30.c
index 82e0f0d..5e3ed5a 100644
--- a/drivers/input/rmi4/rmi_f30.c
+++ b/drivers/input/rmi4/rmi_f30.c
@@ -122,8 +122,9 @@ static void rmi_f30_report_button(struct rmi_function *fn,
 	}
 }
 
-static int rmi_f30_attention(struct rmi_function *fn, unsigned long *irq_bits)
+static irqreturn_t rmi_f30_attention(int irq, void *ctx)
 {
+	struct rmi_function *fn = ctx;
 	struct f30_data *f30 = dev_get_drvdata(&fn->dev);
 	struct rmi_driver_data *drvdata = dev_get_drvdata(&fn->rmi_dev->dev);
 	int error;
@@ -134,7 +135,7 @@ static int rmi_f30_attention(struct rmi_function *fn, unsigned long *irq_bits)
 		if (drvdata->attn_data.size < f30->register_count) {
 			dev_warn(&fn->dev,
 				 "F30 interrupted, but data is missing\n");
-			return 0;
+			return IRQ_HANDLED;
 		}
 		memcpy(f30->data_regs, drvdata->attn_data.data,
 			f30->register_count);
@@ -147,7 +148,7 @@ static int rmi_f30_attention(struct rmi_function *fn, unsigned long *irq_bits)
 			dev_err(&fn->dev,
 				"%s: Failed to read F30 data registers: %d\n",
 				__func__, error);
-			return error;
+			return IRQ_RETVAL(error);
 		}
 	}
 
@@ -159,7 +160,7 @@ static int rmi_f30_attention(struct rmi_function *fn, unsigned long *irq_bits)
 			rmi_f03_commit_buttons(f30->f03);
 	}
 
-	return 0;
+	return IRQ_HANDLED;
 }
 
 static int rmi_f30_config(struct rmi_function *fn)
diff --git a/drivers/input/rmi4/rmi_f34.c b/drivers/input/rmi4/rmi_f34.c
index 4cfe970..7268cf9 100644
--- a/drivers/input/rmi4/rmi_f34.c
+++ b/drivers/input/rmi4/rmi_f34.c
@@ -101,8 +101,9 @@ static int rmi_f34_command(struct f34_data *f34, u8 command,
 	return 0;
 }
 
-static int rmi_f34_attention(struct rmi_function *fn, unsigned long *irq_bits)
+static irqreturn_t rmi_f34_attention(int irq, void *ctx)
 {
+	struct rmi_function *fn = ctx;
 	struct f34_data *f34 = dev_get_drvdata(&fn->dev);
 	int ret;
 	u8 status;
@@ -127,7 +128,7 @@ static int rmi_f34_attention(struct rmi_function *fn, unsigned long *irq_bits)
 			complete(&f34->v7.cmd_done);
 	}
 
-	return 0;
+	return IRQ_HANDLED;
 }
 
 static int rmi_f34_write_blocks(struct f34_data *f34, const void *data,
diff --git a/drivers/input/rmi4/rmi_f54.c b/drivers/input/rmi4/rmi_f54.c
index 5343f2c..98a935e 100644
--- a/drivers/input/rmi4/rmi_f54.c
+++ b/drivers/input/rmi4/rmi_f54.c
@@ -610,11 +610,6 @@ static void rmi_f54_work(struct work_struct *work)
 	mutex_unlock(&f54->data_mutex);
 }
 
-static int rmi_f54_attention(struct rmi_function *fn, unsigned long *irqbits)
-{
-	return 0;
-}
-
 static int rmi_f54_config(struct rmi_function *fn)
 {
 	struct rmi_driver *drv = fn->rmi_dev->driver;
@@ -756,6 +751,5 @@ struct rmi_function_handler rmi_f54_handler = {
 	.func = 0x54,
 	.probe = rmi_f54_probe,
 	.config = rmi_f54_config,
-	.attention = rmi_f54_attention,
 	.remove = rmi_f54_remove,
 };
diff --git a/include/linux/rmi.h b/include/linux/rmi.h
index 64125443..5ef5c7c 100644
--- a/include/linux/rmi.h
+++ b/include/linux/rmi.h
@@ -354,6 +354,8 @@ struct rmi_driver_data {
 	struct mutex irq_mutex;
 	struct input_dev *input;
 
+	struct irq_domain *irqdomain;
+
 	u8 pdt_props;
 
 	u8 num_rx_electrodes;
-- 
2.7.4


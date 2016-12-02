From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 1/7] Input: synaptics-rmi4 - add support for F03
Date: Fri,  2 Dec 2016 12:41:50 +0100
Message-ID: <1480678916-6469-2-git-send-email-benjamin.tissoires@redhat.com>
References: <1480678916-6469-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1480678916-6469-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Lyude Paul <thatslyude@gmail.com>, Nick Dyer <nick@shmanahar.org>, Dennis Wassenberg <dennis.wassenberg@secunet.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Lyude Paul <thatslyude@gmail.com>

This adds basic functionality for PS/2 passthrough on Synaptics
Touchpads using RMI4 through smbus.

Reviewed-by: Andrew Duggan <aduggan@synaptics.com>
Signed-off-by: Lyude Paul <thatslyude@gmail.com>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

changes in v2:
- amended according to Dmitry's suggestions
- add a depend on SERIO in the Kconfig
---
 drivers/input/rmi4/Kconfig      |   9 ++
 drivers/input/rmi4/Makefile     |   1 +
 drivers/input/rmi4/rmi_bus.c    |   3 +
 drivers/input/rmi4/rmi_driver.h |   1 +
 drivers/input/rmi4/rmi_f03.c    | 233 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 247 insertions(+)
 create mode 100644 drivers/input/rmi4/rmi_f03.c

diff --git a/drivers/input/rmi4/Kconfig b/drivers/input/rmi4/Kconfig
index a9c36a5..30cc627 100644
--- a/drivers/input/rmi4/Kconfig
+++ b/drivers/input/rmi4/Kconfig
@@ -39,6 +39,15 @@ config RMI4_SMB
 	  To compile this driver as a module, choose M here: the module will be
 	  called rmi_smbus.
 
+config RMI4_F03
+        bool "RMI4 Function 03 (PS2 Guest)"
+        depends on RMI4_CORE && SERIO
+        help
+          Say Y here if you want to add support for RMI4 function 03.
+
+          Function 03 provides PS2 guest support for RMI4 devices. This
+          includes support for TrackPoints on TouchPads.
+
 config RMI4_2D_SENSOR
 	bool
 	depends on RMI4_CORE
diff --git a/drivers/input/rmi4/Makefile b/drivers/input/rmi4/Makefile
index e7f4ca6..a199cbe 100644
--- a/drivers/input/rmi4/Makefile
+++ b/drivers/input/rmi4/Makefile
@@ -4,6 +4,7 @@ rmi_core-y := rmi_bus.o rmi_driver.o rmi_f01.o
 rmi_core-$(CONFIG_RMI4_2D_SENSOR) += rmi_2d_sensor.o
 
 # Function drivers
+rmi_core-$(CONFIG_RMI4_F03) += rmi_f03.o
 rmi_core-$(CONFIG_RMI4_F11) += rmi_f11.o
 rmi_core-$(CONFIG_RMI4_F12) += rmi_f12.o
 rmi_core-$(CONFIG_RMI4_F30) += rmi_f30.o
diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
index 81be9c1..1c40d94 100644
--- a/drivers/input/rmi4/rmi_bus.c
+++ b/drivers/input/rmi4/rmi_bus.c
@@ -305,6 +305,9 @@ struct bus_type rmi_bus_type = {
 
 static struct rmi_function_handler *fn_handlers[] = {
 	&rmi_f01_handler,
+#ifdef CONFIG_RMI4_F03
+	&rmi_f03_handler,
+#endif
 #ifdef CONFIG_RMI4_F11
 	&rmi_f11_handler,
 #endif
diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_driver.h
index cc94585..24f8f76 100644
--- a/drivers/input/rmi4/rmi_driver.h
+++ b/drivers/input/rmi4/rmi_driver.h
@@ -121,6 +121,7 @@ static inline void rmi_f34_remove_sysfs(struct rmi_device *rmi_dev)
 #endif /* CONFIG_RMI_F34 */
 
 extern struct rmi_function_handler rmi_f01_handler;
+extern struct rmi_function_handler rmi_f03_handler;
 extern struct rmi_function_handler rmi_f11_handler;
 extern struct rmi_function_handler rmi_f12_handler;
 extern struct rmi_function_handler rmi_f30_handler;
diff --git a/drivers/input/rmi4/rmi_f03.c b/drivers/input/rmi4/rmi_f03.c
new file mode 100644
index 0000000..fd8f6e5
--- /dev/null
+++ b/drivers/input/rmi4/rmi_f03.c
@@ -0,0 +1,233 @@
+/*
+ * Copyright (C) 2015-2016 Red Hat
+ * Copyright (C) 2015 Lyude Paul <thatslyude@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/serio.h>
+#include <linux/notifier.h>
+#include "rmi_driver.h"
+
+#define RMI_F03_RX_DATA_OFB		0x01
+#define RMI_F03_OB_SIZE			2
+
+#define RMI_F03_OB_OFFSET		2
+#define RMI_F03_OB_DATA_OFFSET		1
+#define RMI_F03_OB_FLAG_TIMEOUT		BIT(6)
+#define RMI_F03_OB_FLAG_PARITY		BIT(7)
+
+#define RMI_F03_DEVICE_COUNT		0x07
+#define RMI_F03_BYTES_PER_DEVICE_MASK	0x70
+#define RMI_F03_BYTES_PER_DEVICE_SHIFT	4
+#define RMI_F03_QUEUE_LENGTH		0x0F
+
+struct f03_data {
+	struct rmi_function *fn;
+
+	struct serio *serio;
+
+	u8 device_count;
+	u8 rx_queue_length;
+};
+
+static int rmi_f03_pt_write(struct serio *id, unsigned char val)
+{
+	struct f03_data *f03 = id->port_data;
+	int error;
+
+	rmi_dbg(RMI_DEBUG_FN, &f03->fn->dev,
+		"%s: Wrote %.2hhx to PS/2 passthrough address",
+		__func__, val);
+
+	error = rmi_write(f03->fn->rmi_dev, f03->fn->fd.data_base_addr, val);
+	if (error) {
+		dev_err(&f03->fn->dev,
+			"%s: Failed to write to F03 TX register (%d).\n",
+			__func__, error);
+		return error;
+	}
+
+	return 0;
+}
+
+static int rmi_f03_initialize(struct f03_data *f03)
+{
+	struct rmi_function *fn = f03->fn;
+	struct device *dev = &fn->dev;
+	int error;
+	u8 bytes_per_device;
+	u8 query1;
+	size_t query2_len;
+
+	error = rmi_read(fn->rmi_dev, fn->fd.query_base_addr, &query1);
+	if (error) {
+		dev_err(dev, "Failed to read query register (%d).\n", error);
+		return error;
+	}
+
+	f03->device_count = query1 & RMI_F03_DEVICE_COUNT;
+	bytes_per_device = (query1 & RMI_F03_BYTES_PER_DEVICE_MASK) >>
+		RMI_F03_BYTES_PER_DEVICE_SHIFT;
+
+	query2_len = f03->device_count * bytes_per_device;
+
+	/*
+	 * The first generation of image sensors don't have a second part to
+	 * their f03 query, as such we have to set some of these values manually
+	 */
+	if (query2_len < 1) {
+		f03->device_count = 1;
+		f03->rx_queue_length = 7;
+	} else {
+		u8 query2[query2_len];
+
+		error = rmi_read_block(fn->rmi_dev, fn->fd.query_base_addr + 1,
+				       query2, query2_len);
+		if (error) {
+			dev_err(dev,
+				"Failed to read second set of query registers (%d).\n",
+				error);
+			return error;
+		}
+
+		f03->rx_queue_length = query2[0] & RMI_F03_QUEUE_LENGTH;
+	}
+
+	return 0;
+}
+
+static int rmi_f03_register_pt(struct rmi_function *fn)
+{
+	struct f03_data *f03 = dev_get_drvdata(&fn->dev);
+	struct serio *serio;
+
+	serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
+	if (!serio)
+		return -ENOMEM;
+
+	serio->id.type = SERIO_8042;
+	serio->write = rmi_f03_pt_write;
+	serio->port_data = f03;
+
+	strlcpy(serio->name, "Synaptics RMI4 PS2 pass-through",
+		sizeof(serio->name));
+	strlcpy(serio->phys, "synaptics-rmi4-pt/serio1",
+		sizeof(serio->phys));
+	serio->dev.parent = &fn->dev;
+
+	f03->serio = serio;
+
+	serio_register_port(serio);
+
+	return 0;
+}
+
+static int rmi_f03_probe(struct rmi_function *fn)
+{
+	struct device *dev = &fn->dev;
+	struct f03_data *f03;
+	int error;
+
+	f03 = devm_kzalloc(dev, sizeof(struct f03_data), GFP_KERNEL);
+	if (!f03)
+		return -ENOMEM;
+
+	f03->fn = fn;
+
+	error = rmi_f03_initialize(f03);
+	if (error < 0)
+		return error;
+
+	dev_set_drvdata(dev, f03);
+
+	if (f03->device_count != 1)
+		dev_warn(dev, "found %d devices on PS/2 passthrough",
+			 f03->device_count);
+
+	error = rmi_f03_register_pt(fn);
+	if (error)
+		return error;
+
+	return 0;
+}
+
+static int rmi_f03_config(struct rmi_function *fn)
+{
+	fn->rmi_dev->driver->set_irq_bits(fn->rmi_dev, fn->irq_mask);
+
+	return 0;
+}
+
+static int rmi_f03_attention(struct rmi_function *fn, unsigned long *irq_bits)
+{
+	struct f03_data *f03 = dev_get_drvdata(&fn->dev);
+	u16 data_addr = fn->fd.data_base_addr;
+	const u8 ob_len = f03->rx_queue_length * RMI_F03_OB_SIZE;
+	u8 obs[ob_len];
+	u8 ob_status;
+	u8 ob_data;
+	unsigned int serio_flags;
+	int i;
+	int retval;
+
+	/* Grab all of the data registers, and check them for data */
+	retval = rmi_read_block(fn->rmi_dev, data_addr + RMI_F03_OB_OFFSET,
+				&obs, ob_len);
+	if (retval) {
+		dev_err(&fn->dev, "%s: Failed to read F03 output buffers.\n",
+			__func__);
+		serio_interrupt(f03->serio, 0, SERIO_TIMEOUT);
+		return retval;
+	}
+
+	for (i = 0; i < ob_len; i += RMI_F03_OB_SIZE) {
+		ob_status = obs[i];
+		ob_data = obs[i + RMI_F03_OB_DATA_OFFSET];
+		serio_flags = 0;
+
+		if (!(ob_status & RMI_F03_RX_DATA_OFB))
+			continue;
+
+		if (ob_status & RMI_F03_OB_FLAG_TIMEOUT)
+			serio_flags |= SERIO_TIMEOUT;
+		if (ob_status & RMI_F03_OB_FLAG_PARITY)
+			serio_flags |= SERIO_PARITY;
+
+		rmi_dbg(RMI_DEBUG_FN, &fn->dev,
+			"%s: Received %.2hhx from PS2 guest T: %c P: %c\n",
+			__func__, ob_data,
+			serio_flags & SERIO_TIMEOUT ?  'Y' : 'N',
+			serio_flags & SERIO_PARITY ? 'Y' : 'N');
+
+		serio_interrupt(f03->serio, ob_data, serio_flags);
+	}
+
+	return 0;
+}
+
+static void rmi_f03_remove(struct rmi_function *fn)
+{
+	struct f03_data *f03 = dev_get_drvdata(&fn->dev);
+
+	serio_unregister_port(f03->serio);
+}
+
+struct rmi_function_handler rmi_f03_handler = {
+	.driver = {
+		.name = "rmi4_f03",
+	},
+	.func = 0x03,
+	.probe = rmi_f03_probe,
+	.config = rmi_f03_config,
+	.attention = rmi_f03_attention,
+	.remove = rmi_f03_remove,
+};
+
+MODULE_AUTHOR("Lyude Paul <thatslyude@gmail.com>");
+MODULE_DESCRIPTION("RMI F03 module");
+MODULE_LICENSE("GPL");
-- 
2.9.3

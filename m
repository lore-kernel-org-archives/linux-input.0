From: Nick Dyer <nick@shmanahar.org>
Subject: [PATCH v1 2/2] Input: synaptics-rmi4 - add support for F34 device reflash
Date: Tue,  5 Jul 2016 17:11:15 +0100
Message-ID: <1467735075-530-3-git-send-email-nick@shmanahar.org>
References: <1467735075-530-1-git-send-email-nick@shmanahar.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467735075-530-1-git-send-email-nick@shmanahar.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>, Chris Healy <cphealy@gmail.com>
Cc: Henrik Rydberg <rydberg@bitmath.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jon Older <jon.older@itdev.co.uk>, nick.dyer@itdev.co.uk, Nick Dyer <nick@shmanahar.org>
List-Id: linux-input@vger.kernel.org

Signed-off-by: Nick Dyer <nick@shmanahar.org>
---
 drivers/input/rmi4/Kconfig      |  11 ++
 drivers/input/rmi4/Makefile     |   1 +
 drivers/input/rmi4/rmi_bus.c    |   3 +
 drivers/input/rmi4/rmi_driver.c | 146 +++++++++++++-
 drivers/input/rmi4/rmi_driver.h |   6 +
 drivers/input/rmi4/rmi_f01.c    |   6 +
 drivers/input/rmi4/rmi_f34.c    | 428 ++++++++++++++++++++++++++++++++++++++++
 include/linux/rmi.h             |   1 +
 8 files changed, 601 insertions(+), 1 deletion(-)
 create mode 100644 drivers/input/rmi4/rmi_f34.c

diff --git a/drivers/input/rmi4/Kconfig b/drivers/input/rmi4/Kconfig
index f3418b6..580e1e5 100644
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
index 3aedc65..588288f 100644
--- a/drivers/input/rmi4/rmi_bus.c
+++ b/drivers/input/rmi4/rmi_bus.c
@@ -315,6 +315,9 @@ static struct rmi_function_handler *fn_handlers[] = {
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
index 543cf7a..d4cce1c 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -21,6 +21,7 @@
 #include <linux/pm.h>
 #include <linux/slab.h>
 #include <linux/of.h>
+#include <linux/firmware.h>
 #include <uapi/linux/input.h>
 #include <linux/rmi.h>
 #include "rmi_bus.h"
@@ -42,6 +43,11 @@ static void rmi_free_function_list(struct rmi_device *rmi_dev)
 	rmi_dbg(RMI_DEBUG_CORE, &rmi_dev->dev, "Freeing function list\n");
 
 	data->f01_container = NULL;
+	data->f34_container = NULL;
+	data->irq_status = NULL;
+	data->fn_irq_bits = NULL;
+	data->current_irq_mask = NULL;
+	data->new_irq_mask = NULL;
 
 	/* Doing it in the reverse order so F01 will be removed last */
 	list_for_each_entry_safe_reverse(fn, tmp,
@@ -143,7 +149,7 @@ int rmi_process_interrupt_requests(struct rmi_device *rmi_dev)
 	struct rmi_function *entry;
 	int error;
 
-	if (!data)
+	if (!data || !data->irq_status)
 		return 0;
 
 	if (!rmi_dev->xport->attn_data) {
@@ -722,6 +728,7 @@ static int rmi_initial_reset(struct rmi_device *rmi_dev,
 			return RMI_SCAN_DONE;
 		}
 
+		rmi_dbg(RMI_DEBUG_CORE, &rmi_dev->dev, "Sending reset\n");
 		error = rmi_write_block(rmi_dev, cmd_addr, &cmd_buf, 1);
 		if (error) {
 			dev_err(&rmi_dev->dev,
@@ -778,6 +785,8 @@ static int rmi_create_function(struct rmi_device *rmi_dev,
 
 	if (pdt->function_number == 0x01)
 		data->f01_container = fn;
+	else if (pdt->function_number == 0x34)
+		data->f34_container = fn;
 
 	list_add_tail(&fn->node, &data->function_list);
 
@@ -814,10 +823,76 @@ int rmi_driver_resume(struct rmi_device *rmi_dev)
 }
 EXPORT_SYMBOL_GPL(rmi_driver_resume);
 
+#ifdef CONFIG_RMI4_F34
+static int rmi_firmware_update(struct rmi_driver_data *data,
+			       const struct firmware *fw);
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
+	ret = rmi_firmware_update(data, fw);
+
+	release_firmware(fw);
+
+	return ret ?: count;
+}
+
+static DEVICE_ATTR(update_fw, S_IWUSR, NULL, rmi_driver_update_fw_store);
+
+static ssize_t rmi_driver_update_fw_status_show(struct device *dev,
+						struct device_attribute *dattr,
+						char *buf)
+{
+	struct rmi_driver_data *data = dev_get_drvdata(dev);
+	int update_status = 0;
+
+	if (data->f34_container)
+		update_status = rmi_f34_status(data->f34_container);
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", update_status);
+}
+
+static DEVICE_ATTR(update_fw_status, S_IRUGO,
+		   rmi_driver_update_fw_status_show, NULL);
+
+static struct attribute *rmi_firmware_attrs[] = {
+	&dev_attr_update_fw.attr,
+	&dev_attr_update_fw_status.attr,
+	NULL
+};
+
+static struct attribute_group rmi_firmware_attr_group = {
+	.attrs = rmi_firmware_attrs,
+};
+#endif /* CONFIG_RMI4_F34 */
+
 static int rmi_driver_remove(struct device *dev)
 {
 	struct rmi_device *rmi_dev = to_rmi_device(dev);
 
+#ifdef CONFIG_RMI4_F34
+	sysfs_remove_group(&rmi_dev->dev.kobj, &rmi_firmware_attr_group);
+#endif
 	rmi_free_function_list(rmi_dev);
 
 	return 0;
@@ -922,6 +997,69 @@ err_destroy_functions:
 	return retval;
 }
 
+#ifdef CONFIG_RMI4_F34
+static int rmi_firmware_update(struct rmi_driver_data *data,
+			       const struct firmware *fw)
+{
+	struct device *dev = &data->rmi_dev->dev;
+	int ret;
+
+	if (!data->f34_container) {
+		dev_warn(dev, "%s: No F34 present!\n",
+			 __func__);
+		return -EINVAL;
+	}
+
+	/* Enter flash mode */
+	rmi_dbg(RMI_DEBUG_CORE, dev, "Enabling flash\n");
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
+	rmi_dbg(RMI_DEBUG_CORE, dev, "Re-probing device\n");
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
+		return enable_sensor(data->rmi_dev);
+
+	return ret;
+}
+#endif
+
 static int rmi_driver_probe(struct device *dev)
 {
 	struct rmi_driver *rmi_driver;
@@ -1021,6 +1159,12 @@ static int rmi_driver_probe(struct device *dev)
 						"%s/input0", dev_name(dev));
 	}
 
+#ifdef CONFIG_RMI4_F34
+	retval = sysfs_create_group(&dev->kobj, &rmi_firmware_attr_group);
+	if (retval)
+		goto err_destroy_functions;
+#endif
+
 	retval = rmi_init_functions(data);
 	if (retval)
 		goto err;
diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_driver.h
index 8dfbebe..617e08a 100644
--- a/drivers/input/rmi4/rmi_driver.h
+++ b/drivers/input/rmi4/rmi_driver.h
@@ -96,11 +96,17 @@ bool rmi_is_physical_driver(struct device_driver *);
 int rmi_register_physical_driver(void);
 void rmi_unregister_physical_driver(void);
 
+struct firmware;
+
 char *rmi_f01_get_product_ID(struct rmi_function *fn);
+int rmi_f34_update_firmware(struct rmi_function *fn, const struct firmware *fw);
+int rmi_f34_enable_flash(struct rmi_function *fn);
+int rmi_f34_status(struct rmi_function *fn);
 
 extern struct rmi_function_handler rmi_f01_handler;
 extern struct rmi_function_handler rmi_f11_handler;
 extern struct rmi_function_handler rmi_f12_handler;
 extern struct rmi_function_handler rmi_f30_handler;
+extern struct rmi_function_handler rmi_f34_handler;
 extern struct rmi_function_handler rmi_f54_handler;
 #endif
diff --git a/drivers/input/rmi4/rmi_f01.c b/drivers/input/rmi4/rmi_f01.c
index eb362bc..2fb86ec 100644
--- a/drivers/input/rmi4/rmi_f01.c
+++ b/drivers/input/rmi4/rmi_f01.c
@@ -63,6 +63,8 @@ struct f01_basic_properties {
 #define RMI_F01_STATUS_CODE(status)		((status) & 0x0f)
 /* The device has lost its configuration for some reason. */
 #define RMI_F01_STATUS_UNCONFIGURED(status)	(!!((status) & 0x80))
+/* The device is in bootloader mode */
+#define RMI_F01_STATUS_BOOTLOADER(status)	((status) & 0x40)
 
 /* Control register bits */
 
@@ -594,6 +596,10 @@ static int rmi_f01_attention(struct rmi_function *fn,
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
index 0000000..8aba89f
--- /dev/null
+++ b/drivers/input/rmi4/rmi_f34.c
@@ -0,0 +1,428 @@
+/*
+ * Copyright (c) 2007-2016, Synaptics Incorporated
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
+	struct completion cmd_done;
+
+	struct mutex flash_mutex;
+
+	int update_status;
+	int update_progress;
+	int update_size;
+	struct completion async_firmware_done;
+
+	unsigned char bootloader_id[5];
+	unsigned char configuration_id[9];
+};
+
+static int rmi_f34_write_bootloader_id(struct f34_data *f34)
+{
+	struct rmi_function *fn = f34->fn;
+        struct rmi_device *rmi_dev = fn->rmi_dev;
+        u8 bootloader_id[F34_BOOTLOADER_ID_LEN];
+        int ret;
+
+        ret = rmi_read_block(rmi_dev, fn->fd.query_base_addr,
+			     bootloader_id, sizeof(bootloader_id));
+        if (ret) {
+                dev_err(&fn->dev, "%s: Reading bootloader ID failed: %d\n",
+                        __func__, ret);
+                return ret;
+        }
+
+        rmi_dbg(RMI_DEBUG_FN, &fn->dev, "%s: writing bootloader id '%c%c'\n",
+                __func__, bootloader_id[0], bootloader_id[1]);
+
+        ret = rmi_write_block(rmi_dev,
+			      fn->fd.data_base_addr + F34_BLOCK_DATA_OFFSET,
+			      bootloader_id, sizeof(bootloader_id));
+        if (ret) {
+                dev_err(&fn->dev, "Failed to write bootloader ID: %d\n", ret);
+                return ret;
+        }
+
+        return 0;
+}
+
+static int rmi_f34_command(struct f34_data *f34, u8 command,
+			   unsigned int timeout, bool write_bl_id)
+{
+	struct rmi_function *fn = f34->fn;
+        struct rmi_device *rmi_dev = fn->rmi_dev;
+        int ret;
+
+        if (write_bl_id) {
+                ret = rmi_f34_write_bootloader_id(f34);
+                if (ret)
+                        return ret;
+        }
+
+        init_completion(&f34->cmd_done);
+
+        ret = rmi_read(rmi_dev, f34->ctrl_address, &f34->status);
+        if (ret) {
+                dev_err(&f34->fn->dev,
+                        "%s: Failed to read cmd register: %d (command %#02x)\n",
+                        __func__, ret, command);
+                return ret;
+        }
+
+        f34->status |= command & 0x0f;
+
+        ret = rmi_write(rmi_dev, f34->ctrl_address, f34->status);
+        if (ret < 0) {
+                dev_err(&f34->fn->dev,
+                        "Failed to write F34 command %#02x: %d\n",
+                        command, ret);
+                return ret;
+        }
+
+        if (!wait_for_completion_timeout(&f34->cmd_done,
+                                         msecs_to_jiffies(timeout))) {
+
+                ret = rmi_read(rmi_dev, f34->ctrl_address, &f34->status);
+                if (ret) {
+                        dev_err(&f34->fn->dev,
+                                "%s: failed to read status after command %#02x timed out: %d\n",
+                                __func__, command, ret);
+                        return ret;
+                }
+
+                if (f34->status & 0x7f) {
+                        dev_err(&f34->fn->dev,
+                                "%s: command %#02x timed out, fw status: %#02x\n",
+                                __func__, command, f34->status);
+                        return -ETIMEDOUT;
+                }
+        }
+
+        return 0;
+}
+
+static int rmi_f34_attention(struct rmi_function *fn, unsigned long *irq_bits)
+{
+	struct f34_data *f34 = dev_get_drvdata(&fn->dev);
+        int ret;
+
+        ret = rmi_read(f34->fn->rmi_dev, f34->ctrl_address,
+                                             &f34->status);
+        rmi_dbg(RMI_DEBUG_FN, &fn->dev, "%s: status: %#02x, ret: %d\n",
+                __func__, f34->status, ret);
+
+        if (!ret && !(f34->status & 0x7f))
+                complete(&f34->cmd_done);
+
+        return 0;
+}
+
+static int rmi_f34_write_blocks(struct f34_data *f34, const void *data,
+				int block_count, u8 command)
+{
+	struct rmi_function *fn = f34->fn;
+	struct rmi_device *rmi_dev = fn->rmi_dev;
+        u16 address = fn->fd.data_base_addr + F34_BLOCK_DATA_OFFSET;
+        u8 start_address[] = { 0, 0 };
+        int i;
+        int ret;
+
+        ret = rmi_write_block(rmi_dev, fn->fd.data_base_addr,
+			start_address, sizeof(start_address));
+        if (ret) {
+                dev_err(&fn->dev, "Failed to write initial zeros: %d\n", ret);
+                return ret;
+        }
+
+        for (i = 0; i < block_count; i++) {
+                ret = rmi_write_block(rmi_dev, address, data, f34->block_size);
+                if (ret) {
+                        dev_err(&fn->dev,
+                                "failed to write block #%d: %d\n", i, ret);
+                        return ret;
+                }
+
+                ret = rmi_f34_command(f34, command, F34_IDLE_WAIT_MS, false);
+                if (ret) {
+                        dev_err(&fn->dev,
+                                "Failed to write command for block #%d: %d\n",
+                                i, ret);
+                        return ret;
+                }
+
+                rmi_dbg(RMI_DEBUG_FN, &fn->dev, "wrote block %d of %d\n",
+                        i + 1, block_count);
+
+                data += f34->block_size;
+                f34->update_progress += f34->block_size;
+                f34->update_status = (f34->update_progress * 100) /
+				     f34->update_size;
+        }
+
+        return 0;
+}
+
+static int rmi_f34_write_firmware(struct f34_data *f34, const void *data)
+{
+        return rmi_f34_write_blocks(f34, data, f34->fw_blocks,
+				F34_WRITE_FW_BLOCK);
+}
+
+static int rmi_f34_write_config(struct f34_data *f34, const void *data)
+{
+        return rmi_f34_write_blocks(f34, data, f34->config_blocks,
+				F34_WRITE_CONFIG_BLOCK);
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
+	f34->update_progress = 0;
+	f34->update_size = syn_fw->image_size + syn_fw->config_size;
+	if (syn_fw->image_size) {
+		dev_info(&fn->dev, "Erasing FW...\n");
+		ret = rmi_f34_command(f34, F34_ERASE_ALL,
+				      F34_ERASE_WAIT_MS, true);
+		if (ret)
+			return ret;
+
+		dev_info(&fn->dev, "Writing firmware data (%d bytes)...\n",
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
+			dev_info(&fn->dev, "%s: Erasing config data...\n",
+					__func__);
+			ret = rmi_f34_command(f34, F34_ERASE_CONFIG,
+					      F34_ERASE_WAIT_MS, true);
+			if (ret)
+				return ret;
+		}
+
+		dev_info(&fn->dev, "%s: Writing config data (%d bytes)...\n",
+				__func__, syn_fw->config_size);
+		ret = rmi_f34_write_config(f34,
+				&syn_fw->data[syn_fw->image_size]);
+		if (ret)
+			return ret;
+	}
+
+	dev_info(&fn->dev, "%s: Firmware update complete\n", __func__);
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
+        BUILD_BUG_ON(offsetof(struct rmi_f34_firmware, data) !=
+                     F34_FW_IMAGE_OFFSET);
+
+        rmi_dbg(RMI_DEBUG_FN, &fn->dev,
+                 "FW size:%d, checksum:%08x, image_size:%d, config_size:%d\n",
+                 (int)fw->size,
+                 le32_to_cpu(syn_fw->checksum),
+                 le32_to_cpu(syn_fw->image_size),
+                 le32_to_cpu(syn_fw->config_size));
+
+        dev_info(&fn->dev,
+                 "FW bootloader_id:%02x, product_id:%.*s, info: %02x%02x\n",
+                 syn_fw->bootloader_version,
+                 (int)sizeof(syn_fw->product_id), syn_fw->product_id,
+                 syn_fw->product_info[0], syn_fw->product_info[1]);
+
+        if (syn_fw->image_size &&
+            syn_fw->image_size != f34->fw_blocks * f34->block_size) {
+                dev_err(&fn->dev,
+                        "Bad firmware image: fw size %d, expected %d\n",
+                        syn_fw->image_size,
+                        f34->fw_blocks * f34->block_size);
+                ret = -EILSEQ;
+                goto out;
+        }
+
+        if (syn_fw->config_size &&
+            syn_fw->config_size != f34->config_blocks * f34->block_size) {
+                dev_err(&fn->dev,
+                        "Bad firmware image: config size %d, expected %d\n",
+                        syn_fw->config_size,
+                        f34->config_blocks * f34->block_size);
+                ret = -EILSEQ;
+                goto out;
+        }
+
+        if (syn_fw->image_size && !syn_fw->config_size) {
+                dev_err(&fn->dev,
+                        "Bad firmware image: no config data\n");
+                ret = -EILSEQ;
+                goto out;
+        }
+
+	dev_info(&fn->dev, "Starting firmware update\n");
+	mutex_lock(&f34->flash_mutex);
+
+	ret = rmi_f34_flash_firmware(f34, syn_fw);
+	dev_info(&fn->dev, "Firmware update complete, status:%d\n", ret);
+
+	f34->update_status = ret;
+	mutex_unlock(&f34->flash_mutex);
+
+out:
+	return ret;
+}
+
+int rmi_f34_status(struct rmi_function *fn)
+{
+	struct f34_data *f34 = dev_get_drvdata(&fn->dev);
+
+	/*
+	 * The status is the percentage complete, or once complete,
+	 * zero for success or a negative return code.
+	 */
+	return f34->update_status;
+}
+
+static int rmi_f34_probe(struct rmi_function *fn)
+{
+	struct f34_data *f34;
+	unsigned char f34_queries[9];
+	bool has_config_id;
+	int ret;
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
+	init_completion(&f34->async_firmware_done);
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
+	dev_info(&fn->dev, "Bootloader ID: %s\n", f34->bootloader_id);
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
+		snprintf(f34->configuration_id,
+				sizeof(f34->configuration_id),
+				"%02x%02x%02x%02x", f34_queries[0],
+				f34_queries[1], f34_queries[2],
+				f34_queries[3]);
+		dev_info(&fn->dev, "Configuration ID: %s\n",
+			 f34->configuration_id);
+	}
+
+	return 0;
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
2.5.0

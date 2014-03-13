From: Christopher Heiny <cheiny@synaptics.com>
Subject: [PATCH v2 05/06] input synaptics-rmi4: Add firmware update support
Date: Wed, 12 Mar 2014 18:53:56 -0700
Message-ID: <1394675637-23853-5-git-send-email-cheiny@synaptics.com>
References: <1394675637-23853-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:45258 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752608AbaCMByL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Mar 2014 21:54:11 -0400
In-Reply-To: <1394675637-23853-1-git-send-email-cheiny@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Christopher Heiny <cheiny@synaptics.com>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>

Add support for updating firmware on RMI4 devices with V5 bootloader.

Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
Signed-off-by: Vincent Huang <vincent.huang@tw.synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Linux Walleij <linus.walleij@linaro.org>
Cc: David Herrmann <dh.herrmann@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>

---

The next patch in this series converts this code to use 
request_firmware_nowait().  We split that change off to
make it easier to check differences between this and the
v1 patch.

diff --git a/drivers/input/rmi4/Kconfig b/drivers/input/rmi4/Kconfig
index d0c7b6e..ac0c2b1 100644
--- a/drivers/input/rmi4/Kconfig
+++ b/drivers/input/rmi4/Kconfig
@@ -25,6 +25,24 @@ config RMI4_DEBUG
 
 	  If unsure, say N.
 
+config RMI4_FW_UPDATE
+	bool "RMI4 Firmware Update"
+	depends on RMI4_CORE
+	help
+	  Say Y here to enable in-kernel firmware update capability.
+
+	  This allows you to update an RMI4 device's firmware using the
+	  kernel request_firmware() facility.  Control is provided via
+	  a sysfs interface.  Write 1 to /sys/devices/sensorXX/update_fw
+	  to cause an update.  The image file name will be derived from
+	  the F01 product ID value; write a different name to
+	  .../sensorXX/fw_img_name override that.  The update will only
+	  happen if the provided image appears to be newer than the
+	  one currently running on the RMI4 device; write 1 to
+	  ../sensorXX/fw_force_update to override that (this might be
+	  required for older devices that don't implement the
+	  necessary RMI4 queries).
+
 config RMI4_I2C
 	tristate "RMI4 I2C Support"
 	depends on RMI4_CORE && I2C
diff --git a/drivers/input/rmi4/Makefile b/drivers/input/rmi4/Makefile
index 5c6bad5..ce9a7b6 100644
--- a/drivers/input/rmi4/Makefile
+++ b/drivers/input/rmi4/Makefile
@@ -1,5 +1,6 @@
 obj-$(CONFIG_RMI4_CORE) += rmi_core.o
 rmi_core-y := rmi_bus.o rmi_driver.o rmi_f01.o
+rmi_core-$(CONFIG_RMI4_FW_UPDATE) += rmi_fw_update.o
 
 # Function drivers
 obj-$(CONFIG_RMI4_F11) += rmi_f11.o
diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
index 6e0454a..aaff1e9 100644
--- a/drivers/input/rmi4/rmi_bus.c
+++ b/drivers/input/rmi4/rmi_bus.c
@@ -117,6 +117,8 @@ int rmi_register_transport_device(struct rmi_transport_dev *xport)
 	if (error)
 		goto err_put_device;
 
+	rmi_fw_update_init(rmi_dev);
+
 	dev_dbg(xport->dev, "%s: Registered %s as %s.\n", __func__,
 		pdata->sensor_name, dev_name(&rmi_dev->dev));
 
@@ -139,6 +141,7 @@ void rmi_unregister_transport_device(struct rmi_transport_dev *xport)
 	struct rmi_device *rmi_dev = xport->rmi_dev;
 
 	device_del(&rmi_dev->dev);
+	rmi_fw_update_cleanup(rmi_dev);
 	rmi_physical_teardown_debugfs(rmi_dev);
 	put_device(&rmi_dev->dev);
 }
diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 70410e8..822aa43 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -833,7 +833,7 @@ static int rmi_driver_probe(struct device *dev)
 	 * previous settings and force it into normal operation.
 	 *
 	 * We have to do this before actually building the PDT because
-	 * the reflash updates (if any) might cause various registers to move
+	 * the firmware updates (if any) might cause various registers to move
 	 * around.
 	 *
 	 * For a number of reasons, this initial reset may fail to return
diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_driver.h
index 2291591..f3c0605 100644
--- a/drivers/input/rmi4/rmi_driver.h
+++ b/drivers/input/rmi4/rmi_driver.h
@@ -29,6 +29,8 @@
 
 #define RMI_PDT_PROPS_HAS_BSR 0x02
 
+struct rmi_fw_update_data;
+
 struct rmi_driver_data {
 	struct list_head function_list;
 
@@ -81,6 +83,8 @@ struct rmi_driver_data {
 	u8 reg_debug_size;
 #endif
 
+	struct rmi_fw_update_data *fw_update_data;
+
 	void *data;
 };
 
@@ -114,5 +118,17 @@ int rmi_check_bootloader_mode(struct rmi_device *rmi_dev,
 void rmi_free_function_list(struct rmi_device *rmi_dev);
 int rmi_driver_detect_functions(struct rmi_device *rmi_dev);
 
+#ifdef CONFIG_RMI4_FW_UPDATE
+void rmi_fw_update_init(struct rmi_device *rmi_dev);
+void rmi_fw_update_cleanup(struct rmi_device *rmi_dev);
+#else
+static inline void rmi_fw_update_init(struct rmi_device *rmi_dev)
+{
+}
+
+static inline void rmi_fw_update_cleanup(struct rmi_device *rmi_dev)
+{
+}
+#endif
 
 #endif
diff --git a/drivers/input/rmi4/rmi_fw_update.c b/drivers/input/rmi4/rmi_fw_update.c
new file mode 100644
index 0000000..382aff3
--- /dev/null
+++ b/drivers/input/rmi4/rmi_fw_update.c
@@ -0,0 +1,942 @@
+/*
+ * Copyright (c) 2012-2014 Synaptics Incorporated
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/firmware.h>
+#include <linux/ihex.h>
+#include <linux/kernel.h>
+#include <linux/rmi.h>
+#include <linux/slab.h>
+#include <linux/time.h>
+#include "rmi_driver.h"
+#include "rmi_f01.h"
+
+/* F34 Query register defs. */
+
+#define RMI_F34_QUERY_SIZE		7
+#define RMI_F34_HAS_NEW_REG_MAP		(1 << 0)
+#define RMI_F34_IS_UNLOCKED		(1 << 1)
+#define RMI_F34_HAS_CONFIG_ID		(1 << 2)
+#define RMI_F34_BLOCK_SIZE_OFFSET	1
+#define RMI_F34_FW_BLOCKS_OFFSET	3
+#define RMI_F34_CONFIG_BLOCKS_OFFSET	5
+
+struct rmi_f34_queries {
+	bool	new_reg_map;
+	bool	unlocked;
+	bool	has_config_id;
+	u16	block_size;
+	u16	fw_block_count;
+	u16	config_block_count;
+};
+
+/* F34 Data register defs. */
+
+#define RMI_F34_BLOCK_DATA_OFFSET	2
+
+#define RMI_F34_COMMAND_MASK		0x0F
+#define RMI_F34_STATUS_MASK		0x07
+#define RMI_F34_STATUS_SHIFT		4
+#define RMI_F34_ENABLED_MASK		0x80
+
+#define RMI_F34_WRITE_FW_BLOCK        0x02
+#define RMI_F34_ERASE_ALL             0x03
+#define RMI_F34_WRITE_CONFIG_BLOCK    0x06
+#define RMI_F34_ENABLE_FLASH_PROG     0x0f
+
+struct rmi_f34_control_status {
+	u8 command;
+	u8 status;
+	bool program_enabled;
+};
+
+/* Timeouts for various F34 operations. */
+#define RMI_F34_ENABLE_WAIT_MS 300
+#define RMI_F34_ERASE_WAIT_MS (5 * 1000)
+#define RMI_F34_IDLE_WAIT_MS 500
+
+#define IS_IDLE(ctl_ptr) ((!ctl_ptr->status) && (!ctl_ptr->command))
+
+
+/* Image file defs. */
+#define RMI_IMG_CHECKSUM_OFFSET			0
+#define RMI_IMG_IO_OFFSET			0x06
+#define RMI_IMG_BOOTLOADER_VERSION_OFFSET	0x07
+#define RMI_IMG_IMAGE_SIZE_OFFSET		0x08
+#define RMI_IMG_CONFIG_SIZE_OFFSET		0x0C
+#define RMI_IMG_PACKAGE_ID_OFFSET		0x1A
+#define RMI_IMG_FW_BUILD_ID_OFFSET		0x50
+
+#define RMI_IMG_PRODUCT_INFO_LENGTH		2
+
+#define RMI_IMG_PRODUCT_ID_OFFSET		0x10
+#define RMI_IMG_PRODUCT_INFO_OFFSET		0x1E
+
+#define RMI_F34_FW_IMAGE_OFFSET 0x100
+
+/* Image file V5, Option 0 */
+struct rmi_image_header {
+	u32 checksum;
+	unsigned int image_size;
+	unsigned int config_size;
+	u8 options;
+	u8 io;
+	u32 fw_build_id;
+	u32 package_id;
+	u8 bootloader_version;
+	u8 product_id[RMI_PRODUCT_ID_LENGTH + 1];
+	u8 product_info[RMI_IMG_PRODUCT_INFO_LENGTH];
+};
+
+static u32 rmi_extract_u32(const u8 *ptr)
+{
+	return (u32)ptr[0] +
+		(u32)ptr[1] * 0x100 +
+		(u32)ptr[2] * 0x10000 +
+		(u32)ptr[3] * 0x1000000;
+}
+
+#define RMI_NAME_BUFFER_SIZE 64
+
+struct rmi_fw_update_data {
+	struct rmi_device *rmi_dev;
+	bool force;
+	ulong busy;
+	char name_buf[RMI_NAME_BUFFER_SIZE];
+	const char *img_name;
+	struct pdt_entry f01_pdt;
+	struct f01_basic_properties f01_props;
+	u8 device_status;
+	struct pdt_entry f34_pdt;
+	u8 bootloader_id[2];
+	struct rmi_f34_queries f34_queries;
+	u16 f34_status_address;
+	struct rmi_f34_control_status f34_controls;
+	const u8 *firmware_data;
+	const u8 *config_data;
+	struct work_struct update_work;
+};
+
+static void rmi_extract_header(const u8 *data, int pos,
+			       struct rmi_image_header *header)
+{
+	header->checksum =
+			rmi_extract_u32(&data[pos + RMI_IMG_CHECKSUM_OFFSET]);
+	header->io = data[pos + RMI_IMG_IO_OFFSET];
+	header->bootloader_version =
+			data[pos + RMI_IMG_BOOTLOADER_VERSION_OFFSET];
+	header->image_size =
+			rmi_extract_u32(&data[pos + RMI_IMG_IMAGE_SIZE_OFFSET]);
+	header->config_size =
+		       rmi_extract_u32(&data[pos + RMI_IMG_CONFIG_SIZE_OFFSET]);
+	if (header->io == 1) {
+		header->fw_build_id =
+		       rmi_extract_u32(&data[pos + RMI_IMG_FW_BUILD_ID_OFFSET]);
+		header->package_id =
+			rmi_extract_u32(&data[pos + RMI_IMG_PACKAGE_ID_OFFSET]);
+	}
+	memcpy(header->product_id, &data[pos + RMI_IMG_PRODUCT_ID_OFFSET],
+	       RMI_PRODUCT_ID_LENGTH);
+	header->product_id[RMI_PRODUCT_ID_LENGTH] = 0;
+	memcpy(header->product_info, &data[pos + RMI_IMG_PRODUCT_INFO_OFFSET],
+	       RMI_IMG_PRODUCT_INFO_LENGTH);
+}
+
+static int rmi_find_functions(struct rmi_device *rmi_dev,
+			      void *ctx, const struct pdt_entry *pdt)
+{
+	struct rmi_fw_update_data *data = ctx;
+
+	if (pdt->page_start > 0)
+		return RMI_SCAN_DONE;
+
+	if (pdt->function_number == 0x01)
+		memcpy(&data->f01_pdt, pdt, sizeof(struct pdt_entry));
+	else if (pdt->function_number == 0x34)
+		memcpy(&data->f34_pdt, pdt, sizeof(struct pdt_entry));
+
+	return RMI_SCAN_CONTINUE;
+}
+
+static int rmi_find_f01_and_f34(struct rmi_fw_update_data *data)
+{
+	struct rmi_device *rmi_dev = data->rmi_dev;
+	int retval;
+
+	data->f01_pdt.function_number = data->f34_pdt.function_number = 0;
+	retval = rmi_scan_pdt(rmi_dev, data, rmi_find_functions);
+	if (retval < 0)
+		return retval;
+
+	if (!data->f01_pdt.function_number) {
+		dev_err(&rmi_dev->dev, "Failed to find F01 for fw update.\n");
+		return -ENODEV;
+	}
+
+	if (!data->f34_pdt.function_number) {
+		dev_err(&rmi_dev->dev, "Failed to find F34 for fw update.\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int rmi_read_f34_controls(struct rmi_fw_update_data *data)
+{
+	int retval;
+	u8 buf;
+
+	retval = rmi_read(data->rmi_dev, data->f34_status_address, &buf);
+	if (retval)
+		return retval;
+
+	data->f34_controls.command = buf & RMI_F34_COMMAND_MASK;
+	data->f34_controls.status = (buf >> RMI_F34_STATUS_SHIFT)
+						& RMI_F34_STATUS_MASK;
+	data->f34_controls.program_enabled = !!(buf & RMI_F34_ENABLED_MASK);
+
+	return 0;
+}
+
+#define RMI_MIN_SLEEP_TIME_US 50
+#define RMI_MAX_SLEEP_TIME_US 100
+
+/*
+ * Wait until the status is idle and we're ready to continue.
+ *
+ * In order to indicate that the previous command has succeeded, the
+ * bootloader is supposed to signal idle state by:
+ *
+ *  + atomically do the following by writing 0x80 to F34_FLASH_Data3
+ *     - set status to 0,
+ *     - set command to 0, and
+ *     - leave program_enabled as 1
+ *  + assert attn
+ *
+ * and then we're supposed to be able to see that we're in IDLE state.
+ * But some (most?) bootloaders do this
+ *
+ *  + clear F34_FLASH_Data3
+ *  + assert attn
+ *  + set the program_enabled bit
+ *
+ * and a significant number of those don't even bother to assert
+ * ATTN, so you've got to poll them (which is what we're doing
+ * here). Regardless of whether you're polling or using ATTN,
+ * when this bug is present there is a race condition between
+ * clearing Data3 and setting program_enabled. So when we lose
+ * that race, we emit this warning (using dev_WARN_ONCE to avoid
+ * filling the log with complaints) and retry a few times. If a
+ * correct idle state is reached during the retries, then we just
+ * continue with the process. If it's not reached (that is, if
+ * Data3 contains anything but 0x80 after the timeout), then
+ * something has gone horribly wrong, and we abort the
+ * firmware update process.
+ *
+ */
+static int rmi_wait_for_idle(struct rmi_fw_update_data *data, int timeout_ms)
+{
+	int timeout_count = ((timeout_ms * 1000) / RMI_MAX_SLEEP_TIME_US) + 1;
+	int count = 0;
+	struct rmi_f34_control_status *controls = &data->f34_controls;
+	int retval;
+
+	do {
+		if (count || timeout_count == 1)
+			usleep_range(RMI_MIN_SLEEP_TIME_US,
+				     RMI_MAX_SLEEP_TIME_US);
+		retval = rmi_read_f34_controls(data);
+		count++;
+		if (retval)
+			continue;
+		else if (IS_IDLE(controls)) {
+			if (dev_WARN_ONCE(&data->rmi_dev->dev,
+					  !data->f34_controls.program_enabled,
+					  "Bootloader is idle but program_enabled bit isn't set.\n"
+					  ))
+				/*
+				 * This works around a bug in certain device
+				 * firmwares, where the idle state is reached,
+				 * but the program_enabled bit is not yet set.
+				 */
+				continue;
+			return 0;
+		}
+	} while (count < timeout_count);
+
+	dev_err(&data->rmi_dev->dev,
+		"ERROR: Timeout waiting for idle status.\n");
+	dev_err(&data->rmi_dev->dev, "Command: %#04x\n", controls->command);
+	dev_err(&data->rmi_dev->dev, "Status:  %#04x\n", controls->status);
+	dev_err(&data->rmi_dev->dev, "Enabled: %d\n",
+			controls->program_enabled);
+	dev_err(&data->rmi_dev->dev, "Idle:    %d\n", IS_IDLE(controls));
+	return -ETIMEDOUT;
+}
+
+static int rmi_read_f34_queries(struct rmi_fw_update_data *data)
+{
+	int retval;
+	u8 id_str[3];
+	u8 buf[RMI_F34_QUERY_SIZE];
+
+	retval = rmi_read_block(data->rmi_dev, data->f34_pdt.query_base_addr,
+				data->bootloader_id, 2);
+	if (retval) {
+		dev_err(&data->rmi_dev->dev,
+			"Failed to read F34 bootloader_id (code %d).\n",
+			retval);
+		return retval;
+	}
+
+	retval = rmi_read_block(data->rmi_dev, data->f34_pdt.query_base_addr+2,
+				buf, RMI_F34_QUERY_SIZE);
+	if (retval) {
+		dev_err(&data->rmi_dev->dev,
+			"Failed to read F34 queries (code %d).\n", retval);
+		return retval;
+	}
+
+	data->f34_queries.new_reg_map = buf[0] & RMI_F34_HAS_NEW_REG_MAP;
+	data->f34_queries.unlocked = buf[0] & RMI_F34_IS_UNLOCKED;
+	data->f34_queries.has_config_id = buf[0] & RMI_F34_HAS_CONFIG_ID;
+	data->f34_queries.block_size =
+		le16_to_cpu(*((u16 *)(buf + RMI_F34_BLOCK_SIZE_OFFSET)));
+	data->f34_queries.fw_block_count =
+		le16_to_cpu(*((u16 *)(buf + RMI_F34_FW_BLOCKS_OFFSET)));
+	data->f34_queries.config_block_count =
+		le16_to_cpu(*((u16 *)(buf + RMI_F34_CONFIG_BLOCKS_OFFSET)));
+
+	id_str[0] = data->bootloader_id[0];
+	id_str[1] = data->bootloader_id[1];
+	id_str[2] = 0;
+
+	dev_dbg(&data->rmi_dev->dev, "F34 bootloader id: %s (%#04x %#04x)\n",
+		id_str, data->bootloader_id[0], data->bootloader_id[1]);
+	dev_dbg(&data->rmi_dev->dev, "F34 has config id: %d\n",
+		data->f34_queries.has_config_id);
+	dev_dbg(&data->rmi_dev->dev, "F34 unlocked:      %d\n",
+		data->f34_queries.unlocked);
+	dev_dbg(&data->rmi_dev->dev, "F34 new reg map:   %d\n",
+		data->f34_queries.new_reg_map);
+	dev_dbg(&data->rmi_dev->dev, "F34 block size:    %d\n",
+		data->f34_queries.block_size);
+	dev_dbg(&data->rmi_dev->dev, "F34 fw blocks:     %d\n",
+		data->f34_queries.fw_block_count);
+	dev_dbg(&data->rmi_dev->dev, "F34 config blocks: %d\n",
+		data->f34_queries.config_block_count);
+
+	data->f34_status_address = data->f34_pdt.data_base_addr +
+		RMI_F34_BLOCK_DATA_OFFSET + data->f34_queries.block_size;
+
+	return 0;
+}
+
+static int rmi_write_bootloader_id(struct rmi_fw_update_data *data)
+{
+	int retval;
+	struct rmi_device *rmi_dev = data->rmi_dev;
+
+	retval = rmi_write_block(rmi_dev,
+		      data->f34_pdt.data_base_addr + RMI_F34_BLOCK_DATA_OFFSET,
+		      data->bootloader_id, ARRAY_SIZE(data->bootloader_id));
+	if (retval < 0) {
+		dev_err(&rmi_dev->dev,
+			"Failed to write bootloader ID. Code: %d.\n", retval);
+		return retval;
+	}
+
+	return 0;
+}
+
+static int rmi_enter_flash_programming(struct rmi_fw_update_data *data)
+{
+	int retval;
+	struct rmi_device *rmi_dev = data->rmi_dev;
+	u8 f01_control_0;
+	const u8 enable_prog = RMI_F34_ENABLE_FLASH_PROG;
+
+	retval = rmi_write_bootloader_id(data);
+	if (retval < 0)
+		return retval;
+
+	dev_dbg(&rmi_dev->dev, "Enabling flash programming.\n");
+	retval = rmi_write(rmi_dev, data->f34_status_address, enable_prog);
+	if (retval < 0) {
+		dev_err(&rmi_dev->dev,
+			"Failed to enable flash programming. Code: %d.\n",
+			retval);
+		return retval;
+	}
+	if (retval < 0)
+		return retval;
+
+	retval = rmi_wait_for_idle(data, RMI_F34_ENABLE_WAIT_MS);
+	if (retval) {
+		dev_err(&rmi_dev->dev, "Did not reach idle state after %d ms. Code: %d.\n",
+			RMI_F34_ENABLE_WAIT_MS, retval);
+		return retval;
+	}
+	if (!data->f34_controls.program_enabled) {
+		dev_err(&rmi_dev->dev, "Reached idle, but programming not enabled.\n");
+		return -EINVAL;
+	}
+	dev_dbg(&rmi_dev->dev, "HOORAY! Programming is enabled!\n");
+
+	retval = rmi_find_f01_and_f34(data);
+	if (retval) {
+		dev_err(&rmi_dev->dev, "Failed to rescan pdt.  Code: %d.\n",
+			retval);
+		return retval;
+	}
+
+	retval = rmi_read(data->rmi_dev, data->f01_pdt.data_base_addr,
+			  &data->device_status);
+	if (retval) {
+		dev_err(&rmi_dev->dev, "Failed to read F01 status after enabling flash programming. Code: %d.\n",
+			retval);
+		return retval;
+	}
+	if (!RMI_F01_STATUS_BOOTLOADER(data->device_status)) {
+		dev_err(&rmi_dev->dev, "Device reports as not in flash programming mode.\n");
+		return -EINVAL;
+	}
+
+	retval = rmi_read_f34_queries(data);
+	if (retval) {
+		dev_err(&rmi_dev->dev, "F34 queries failed, code = %d.\n",
+			retval);
+		return retval;
+	}
+
+	retval = rmi_read(rmi_dev, data->f01_pdt.control_base_addr,
+			  &f01_control_0);
+	if (retval) {
+		dev_err(&rmi_dev->dev, "F01_CTRL_0 read failed, code = %d.\n",
+			retval);
+		return retval;
+	}
+	f01_control_0 |= RMI_F01_CRTL0_NOSLEEP_BIT;
+	f01_control_0 = (f01_control_0 & ~RMI_F01_CTRL0_SLEEP_MODE_MASK)
+			| RMI_SLEEP_MODE_NORMAL;
+
+	retval = rmi_write(rmi_dev, data->f01_pdt.control_base_addr,
+			   f01_control_0);
+	if (retval < 0) {
+		dev_err(&rmi_dev->dev, "F01_CTRL_0 write failed, code = %d.\n",
+			retval);
+		return retval;
+	}
+
+	return 0;
+}
+
+static void rmi_reset_device(struct rmi_fw_update_data *data)
+{
+	int retval;
+	const struct rmi_device_platform_data *pdata =
+				rmi_get_platform_data(data->rmi_dev);
+
+	dev_dbg(&data->rmi_dev->dev, "Resetting...\n");
+	retval = rmi_write(data->rmi_dev, data->f01_pdt.command_base_addr,
+			   RMI_F01_CMD_DEVICE_RESET);
+	if (retval < 0)
+		dev_warn(&data->rmi_dev->dev,
+			 "WARNING - post-update reset failed, code: %d.\n",
+			 retval);
+	msleep(pdata->reset_delay_ms ?: RMI_F01_DEFAULT_RESET_DELAY_MS);
+	dev_dbg(&data->rmi_dev->dev, "Reset completed.\n");
+}
+
+/*
+ * Send data to the device one block at a time.
+ */
+static int rmi_write_blocks(struct rmi_fw_update_data *data, u8 *block_ptr,
+			    u16 block_count, u8 cmd)
+{
+	int block_num;
+	u8 zeros[] = {0, 0};
+	int retval;
+	u16 addr = data->f34_pdt.data_base_addr + RMI_F34_BLOCK_DATA_OFFSET;
+
+	retval = rmi_write_block(data->rmi_dev, data->f34_pdt.data_base_addr,
+				 zeros, ARRAY_SIZE(zeros));
+	if (retval < 0) {
+		dev_err(&data->rmi_dev->dev, "Failed to write initial zeros. Code=%d.\n",
+			retval);
+		return retval;
+	}
+
+	for (block_num = 0; block_num < block_count; ++block_num) {
+		retval = rmi_write_block(data->rmi_dev, addr, block_ptr,
+					 data->f34_queries.block_size);
+		if (retval < 0) {
+			dev_err(&data->rmi_dev->dev, "Failed to write block %d. Code=%d.\n",
+				block_num, retval);
+			return retval;
+		}
+
+		retval = rmi_write(data->rmi_dev, data->f34_status_address,
+				   cmd);
+		if (retval) {
+			dev_err(&data->rmi_dev->dev, "Failed to write command for block %d. Code=%d.\n",
+				block_num, retval);
+			return retval;
+		}
+
+
+		retval = rmi_wait_for_idle(data, RMI_F34_IDLE_WAIT_MS);
+		if (retval) {
+			dev_err(&data->rmi_dev->dev, "Failed to go idle after writing block %d. Code=%d.\n",
+				block_num, retval);
+			return retval;
+		}
+
+		block_ptr += data->f34_queries.block_size;
+	}
+
+	return 0;
+}
+
+static void rmi_update_firmware(struct rmi_fw_update_data *data)
+{
+	struct timespec start;
+	struct timespec end;
+	s64 duration_ns;
+	int retval = 0;
+	const u8 erase_all = RMI_F34_ERASE_ALL;
+
+	retval = rmi_enter_flash_programming(data);
+	if (retval) {
+		dev_err(&data->rmi_dev->dev, "Failed to enter flash programming (code: %d).\n",
+			retval);
+		return;
+	}
+
+	retval = rmi_write_bootloader_id(data);
+	if (retval) {
+		dev_err(&data->rmi_dev->dev, "Failed to enter write bootloader ID (code: %d).\n",
+			retval);
+		return;
+	}
+
+	dev_dbg(&data->rmi_dev->dev, "Erasing FW...\n");
+	getnstimeofday(&start);
+	retval = rmi_write(data->rmi_dev, data->f34_status_address, erase_all);
+	if (retval) {
+		dev_err(&data->rmi_dev->dev, "Erase failed (code: %d).\n",
+			retval);
+		return;
+	}
+
+	retval = rmi_wait_for_idle(data, RMI_F34_ERASE_WAIT_MS);
+	if (retval) {
+		dev_err(&data->rmi_dev->dev,
+			"Failed to reach idle state. Code: %d.\n", retval);
+		return;
+	}
+	getnstimeofday(&end);
+	duration_ns = timespec_to_ns(&end) - timespec_to_ns(&start);
+	dev_dbg(&data->rmi_dev->dev,
+		 "Erase complete, time: %lld ns.\n", duration_ns);
+
+	if (data->firmware_data) {
+		dev_dbg(&data->rmi_dev->dev, "Writing firmware...\n");
+		getnstimeofday(&start);
+		retval = rmi_write_blocks(data, (u8 *) data->firmware_data,
+					  data->f34_queries.fw_block_count,
+					  RMI_F34_WRITE_FW_BLOCK);
+		if (retval) {
+			dev_err(&data->rmi_dev->dev,
+				"Failed to write FW (code: %d).\n", retval);
+			return;
+		}
+		getnstimeofday(&end);
+		duration_ns = timespec_to_ns(&end) - timespec_to_ns(&start);
+		dev_dbg(&data->rmi_dev->dev,
+			 "Done writing FW, time: %lld ns.\n", duration_ns);
+	}
+
+	if (data->config_data) {
+		dev_dbg(&data->rmi_dev->dev, "Writing configuration...\n");
+		getnstimeofday(&start);
+		retval = rmi_write_blocks(data, (u8 *) data->config_data,
+					  data->f34_queries.config_block_count,
+					  RMI_F34_WRITE_CONFIG_BLOCK);
+		if (retval) {
+			dev_err(&data->rmi_dev->dev,
+				"Failed to write config (code: %d).\n", retval);
+			return;
+		}
+		getnstimeofday(&end);
+		duration_ns = timespec_to_ns(&end) - timespec_to_ns(&start);
+		dev_dbg(&data->rmi_dev->dev,
+			 "Done writing config, time: %lld ns.\n", duration_ns);
+	}
+}
+
+static bool rmi_go_nogo(struct rmi_fw_update_data *data,
+			struct rmi_image_header *header)
+{
+	if (data->force) {
+		dev_dbg(&data->rmi_dev->dev, "Fw update force flag in effect.\n");
+		return true;
+	}
+
+	if (header->io == 1) {
+		if (header->fw_build_id > data->f01_props.build_id) {
+			dev_dbg(&data->rmi_dev->dev, "Image file has newer Packrat.\n");
+			return true;
+		} else {
+			dev_dbg(&data->rmi_dev->dev, "Image file has lower Packrat ID than device.\n");
+		}
+	}
+
+	return false;
+}
+
+static const char rmi_fw_name_format[] = "%s.img";
+
+static void rmi_fw_update(struct rmi_device *rmi_dev)
+{
+	struct timespec start;
+	struct timespec end;
+	s64 duration_ns;
+	char *firmware_name;
+	const struct firmware *fw_entry = NULL;
+	int retval;
+	struct rmi_image_header *header = NULL;
+	u8 pdt_props;
+	struct rmi_driver_data *drv_data = dev_get_drvdata(&rmi_dev->dev);
+	struct rmi_fw_update_data *data = drv_data->fw_update_data;
+	const struct rmi_device_platform_data *pdata =
+				rmi_get_platform_data(rmi_dev);
+
+	dev_dbg(&rmi_dev->dev, "%s called.\n", __func__);
+	dev_dbg(&rmi_dev->dev, "force: %d\n", data->force);
+	dev_dbg(&rmi_dev->dev, "img_name: %s\n", data->img_name);
+	dev_dbg(&rmi_dev->dev, "firmware_name: %s\n", pdata->firmware_name);
+
+	getnstimeofday(&start);
+
+	firmware_name = kcalloc(RMI_NAME_BUFFER_SIZE, sizeof(char), GFP_KERNEL);
+	if (!firmware_name) {
+		dev_err(&rmi_dev->dev, "Failed to allocate firmware_name.\n");
+		goto done;
+	}
+	header = kzalloc(sizeof(struct rmi_image_header), GFP_KERNEL);
+	if (!header) {
+		dev_err(&rmi_dev->dev, "Failed to allocate header.\n");
+		goto done;
+	}
+
+	retval = rmi_read(rmi_dev, PDT_PROPERTIES_LOCATION, &pdt_props);
+	if (retval) {
+		dev_warn(&rmi_dev->dev,
+			 "Failed to read PDT props at %#06x (code %d). Assuming 0x00.\n",
+			 PDT_PROPERTIES_LOCATION, retval);
+	}
+	if (pdt_props & RMI_PDT_PROPS_HAS_BSR) {
+		dev_warn(&rmi_dev->dev,
+			 "Firmware update for LTS not currently supported.\n");
+		goto done;
+	}
+
+	retval = rmi_f01_read_properties(rmi_dev, data->f01_pdt.query_base_addr,
+					 &data->f01_props);
+	if (retval) {
+		dev_err(&rmi_dev->dev, "F01 queries failed, code = %d.\n",
+			retval);
+		goto done;
+	}
+	retval = rmi_read_f34_queries(data);
+	if (retval) {
+		dev_err(&rmi_dev->dev, "F34 queries failed, code = %d.\n",
+			retval);
+		goto done;
+	}
+	if (data->img_name && data->img_name[0])
+		snprintf(firmware_name, RMI_NAME_BUFFER_SIZE,
+			 rmi_fw_name_format, data->img_name);
+	else if (pdata->firmware_name && pdata->firmware_name[0])
+		snprintf(firmware_name, RMI_NAME_BUFFER_SIZE,
+			 rmi_fw_name_format, pdata->firmware_name);
+	else {
+		if (!data->f01_props.product_id[0]) {
+			dev_err(&rmi_dev->dev, "Could not determine fw image name - will not update fw.\n");
+			goto done;
+		}
+		snprintf(firmware_name, RMI_NAME_BUFFER_SIZE,
+			 rmi_fw_name_format, data->f01_props.product_id);
+	}
+	dev_info(&rmi_dev->dev, "Requesting %s.\n", firmware_name);
+	retval = request_firmware(&fw_entry, firmware_name, &rmi_dev->dev);
+	if (retval != 0) {
+		dev_err(&rmi_dev->dev, "Firmware %s not available, code = %d\n",
+			firmware_name, retval);
+		goto done;
+	}
+
+	dev_dbg(&rmi_dev->dev, "Got firmware %s, size: %d.\n", firmware_name,
+		fw_entry->size);
+	rmi_extract_header(fw_entry->data, 0, header);
+	dev_dbg(&rmi_dev->dev, "Img checksum:           %#08X\n",
+		header->checksum);
+	dev_dbg(&rmi_dev->dev, "Img io:                 %#04X\n",
+		header->io);
+	dev_dbg(&rmi_dev->dev, "Img image size:         %d\n",
+		header->image_size);
+	dev_dbg(&rmi_dev->dev, "Img config size:        %d\n",
+		header->config_size);
+	dev_dbg(&rmi_dev->dev, "Img bootloader version: %d\n",
+		header->bootloader_version);
+	dev_dbg(&rmi_dev->dev, "Img product id:         %s\n",
+		header->product_id);
+	dev_dbg(&rmi_dev->dev, "Img product info:       %#04x %#04x\n",
+		header->product_info[0], header->product_info[1]);
+	if (header->io == 1) {
+		dev_dbg(&rmi_dev->dev, "Img Packrat:            %d\n",
+			header->fw_build_id);
+		dev_dbg(&rmi_dev->dev, "Img package:            %d\n",
+			header->package_id);
+	}
+
+	if (header->image_size)
+		data->firmware_data = fw_entry->data + RMI_F34_FW_IMAGE_OFFSET;
+	if (header->config_size)
+		data->config_data = fw_entry->data + RMI_F34_FW_IMAGE_OFFSET +
+			header->image_size;
+
+	if (rmi_go_nogo(data, header)) {
+		dev_dbg(&rmi_dev->dev, "Go/NoGo said go.\n");
+		rmi_free_function_list(rmi_dev);
+		rmi_update_firmware(data);
+		rmi_reset_device(data);
+		rmi_driver_detect_functions(rmi_dev);
+	} else {
+		dev_dbg(&rmi_dev->dev, "Go/NoGo said don't update.\n");
+	}
+
+	if (fw_entry)
+		release_firmware(fw_entry);
+
+
+done:
+	getnstimeofday(&end);
+	duration_ns = timespec_to_ns(&end) - timespec_to_ns(&start);
+	dev_dbg(&rmi_dev->dev, "Time to update fw: %lld ns.\n", duration_ns);
+
+	kfree(firmware_name);
+	kfree(header);
+	return;
+}
+
+static int rmi_device_update_firmware(struct rmi_device *rmi_dev)
+{
+	struct device *dev = &rmi_dev->dev;
+	struct rmi_driver_data *drv_data = dev_get_drvdata(dev);
+	struct rmi_fw_update_data *data = drv_data->fw_update_data;
+	int retval;
+
+	retval = rmi_find_f01_and_f34(data);
+	if (retval < 0)
+		return retval;
+
+	rmi_fw_update(rmi_dev);
+
+	clear_bit(0, &data->busy);
+
+	return 0;
+}
+
+static ssize_t rmi_fw_update_img_name_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct rmi_device *rmi_dev = to_rmi_device(dev);
+	struct rmi_driver_data *drv_data = dev_get_drvdata(&rmi_dev->dev);
+	struct rmi_fw_update_data *data = drv_data->fw_update_data;
+
+	return snprintf(buf, PAGE_SIZE, "%s\n", data->img_name);
+}
+
+static ssize_t rmi_fw_update_img_name_store(struct device *dev,
+					    struct device_attribute *attr,
+					    const char *buf, size_t count)
+{
+	struct rmi_device *rmi_dev = to_rmi_device(dev);
+	struct rmi_driver_data *drv_data = dev_get_drvdata(&rmi_dev->dev);
+	struct rmi_fw_update_data *data = drv_data->fw_update_data;
+
+	if (test_and_set_bit(0, &data->busy))
+		return -EBUSY;
+
+	if (!count) {
+		data->img_name = NULL;
+	} else {
+		strlcpy(data->name_buf, buf, count);
+		data->img_name = strstrip(data->name_buf);
+	}
+
+	clear_bit(0, &data->busy);
+	return count;
+}
+
+static ssize_t rmi_fw_update_force_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct rmi_device *rmi_dev = to_rmi_device(dev);
+	struct rmi_driver_data *drv_data = dev_get_drvdata(&rmi_dev->dev);
+	struct rmi_fw_update_data *data = drv_data->fw_update_data;
+
+	return snprintf(buf, PAGE_SIZE, "%u\n", data->force);
+}
+
+static ssize_t rmi_fw_update_force_store(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf, size_t count)
+{
+	struct rmi_device *rmi_dev = to_rmi_device(dev);
+	struct rmi_driver_data *drv_data = dev_get_drvdata(&rmi_dev->dev);
+	struct rmi_fw_update_data *data = drv_data->fw_update_data;
+	int retval;
+	unsigned long val;
+
+	if (test_and_set_bit(0, &data->busy))
+		return -EBUSY;
+
+	retval = kstrtoul(buf, 10, &val);
+	if (retval)
+		count = retval;
+	else if (val > 1)
+		return -EINVAL;
+	else
+		data->force = !!val;
+
+	clear_bit(0, &data->busy);
+
+	return count;
+}
+
+static ssize_t rmi_fw_update_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct rmi_device *rmi_dev = to_rmi_device(dev);
+	struct rmi_driver_data *drv_data = dev_get_drvdata(&rmi_dev->dev);
+	struct rmi_fw_update_data *data = drv_data->fw_update_data;
+
+	return snprintf(buf, PAGE_SIZE, "%u\n", test_bit(0, &data->busy));
+}
+
+static ssize_t rmi_fw_update_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	int retval;
+	unsigned long val;
+	struct rmi_device *rmi_dev = to_rmi_device(dev);
+	struct rmi_driver_data *drv_data = dev_get_drvdata(&rmi_dev->dev);
+	struct rmi_fw_update_data *data = drv_data->fw_update_data;
+
+	retval = kstrtoul(buf, 10, &val);
+	if (retval)
+		return retval;
+
+	if (val > 1)
+		return -EINVAL;
+
+	if (test_and_set_bit(0, &data->busy))
+		return -EBUSY;
+
+	if (val)
+		/*
+		 * TODO: Here we start a work thread to go do the update, but
+		 * maybe we can just use request_firmware_timeout().
+		 */
+		schedule_work(&data->update_work);
+	else
+		clear_bit(0, &data->busy);
+
+	return count;
+}
+
+static void rmi_update_work(struct work_struct *work)
+{
+	struct rmi_fw_update_data *data =
+		container_of(work, struct rmi_fw_update_data, update_work);
+	struct rmi_device *rmi_dev = data->rmi_dev;
+	int error;
+
+	dev_dbg(&rmi_dev->dev, "%s runs.\n", __func__);
+	error = rmi_device_update_firmware(rmi_dev);
+	if (error < 0)
+		dev_err(&rmi_dev->dev, "Firmware update attempt failed with code: %d.",
+			error);
+	clear_bit(0, &data->busy);
+}
+
+static DEVICE_ATTR(fw_force_update,
+			(S_IRUGO | S_IWUGO),
+			rmi_fw_update_force_show, rmi_fw_update_force_store);
+static DEVICE_ATTR(fw_img_name,
+			(S_IRUGO | S_IWUGO),
+			rmi_fw_update_img_name_show,
+			rmi_fw_update_img_name_store);
+static DEVICE_ATTR(fw_update,
+			(S_IRUGO | S_IWUGO),
+			rmi_fw_update_show, rmi_fw_update_store);
+
+static struct attribute *rmi_fw_update_attrs[] = {
+	&dev_attr_fw_force_update.attr,
+	&dev_attr_fw_img_name.attr,
+	&dev_attr_fw_update.attr,
+	NULL
+};
+
+static const struct attribute_group rmi_fw_update_attributes = {
+	.attrs = rmi_fw_update_attrs,
+};
+
+/*
+ * Allocate data needed by firmware update and initialize relevant
+ * structures (like sysfs, work, and so on).  You'll need to call
+ * rmi_fw_update_cleanup() to free the storage and tear down the
+ * structures.
+ */
+void rmi_fw_update_init(struct rmi_device *rmi_dev)
+{
+	int error;
+	struct rmi_driver_data *drv_data = dev_get_drvdata(&rmi_dev->dev);
+	struct rmi_fw_update_data *data;
+
+	dev_dbg(&rmi_dev->dev, "%s called.\n", __func__);
+
+	data = kzalloc(sizeof(struct rmi_fw_update_data), GFP_KERNEL);
+
+	error = sysfs_create_group(&rmi_dev->dev.kobj,
+				   &rmi_fw_update_attributes);
+	if (error) {
+		dev_warn(&rmi_dev->dev, "Failed to create fw update sysfs attributes.\n");
+		return;
+	}
+
+	INIT_WORK(&data->update_work, rmi_update_work);
+	data->rmi_dev = rmi_dev;
+	drv_data->fw_update_data = data;
+}
+
+void rmi_fw_update_cleanup(struct rmi_device *rmi_dev)
+{
+	struct rmi_driver_data *drv_data = dev_get_drvdata(&rmi_dev->dev);
+	struct rmi_fw_update_data *data = drv_data->fw_update_data;
+
+	sysfs_remove_group(&rmi_dev->dev.kobj, &rmi_fw_update_attributes);
+	kfree(data);
+}
diff --git a/include/linux/rmi.h b/include/linux/rmi.h
index 735e978..83d2e52 100644
--- a/include/linux/rmi.h
+++ b/include/linux/rmi.h
@@ -196,8 +196,8 @@ struct rmi_device_platform_data_spi {
  *
  * @sensor_name - this is used for various diagnostic messages.
  *
- * @firmware_name - if specified will override default firmware name,
- * for reflashing.
+ * @firmware_name - if specified will override default firmware image name
+ * used by the firmware update feature.
  *
  * @attn_gpio - the index of a GPIO that will be used to provide the ATTN
  * interrupt from the touch sensor.
@@ -270,7 +270,7 @@ struct rmi_device_platform_data {
 	struct rmi_f30_gpioled_map *gpioled_map;
 	struct rmi_button_map *f41_button_map;
 
-#ifdef CONFIG_RMI4_FWLIB
+#ifdef CONFIG_RMI4_FW_UPDATE
 	char *firmware_name;
 #endif
 

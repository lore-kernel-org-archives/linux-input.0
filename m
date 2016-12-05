From: Nick Dyer <nick@shmanahar.org>
Subject: [PATCH v8] Input: synaptics-rmi4 - add support for F34 V7 bootloader
Date: Mon,  5 Dec 2016 01:02:49 +0000
Message-ID: <1480899769-31330-1-git-send-email-nick@shmanahar.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avasout06.plus.net ([212.159.14.18]:44529 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbcLEBC5 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sun, 4 Dec 2016 20:02:57 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, Chris Healy <cphealy@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Nick Dyer <nick@shmanahar.org>

Port firmware update code from Samsung Galaxy S7 driver into
mainline framework.

This patch has been tested on Synaptics S7813.

Signed-off-by: Nick Dyer <nick@shmanahar.org>
Tested-by: Chris Healy <cphealy@gmail.com>
---

Hi Dmitry-

Thanks for the useful review, here is an updated version.

This patch applies on top of dtor/synaptics-rmi4. The F34 V1 support has
already been merged.

Changes in v8:
- Address Dmitry Torokhov review comments.

Changes in v7:
- Removed bitfields (would cause issues on big endian archs)

Changes in v6:
- Properly free irq_memory in rmi_free_function_list()
- Split out the sysfs changes for now
- Various coding style improvements to the V7 patch (now checkpatch clean)

Changes in v5:
- Improve split between for different versions (req. Bjorn Andersson)
- Address a couple of kbuild test robot issues
- Fix a bug with configuration ID on V7

Changes in v4:
- Add support for v7 bootloaders and fix numerous issues
- Add sysfs attributes for retrieving various hardware IDs
- Add a couple of debug lines to core

Changes in v3:
- Only attempt to flash on F34 V0 (later versions have different
  register map)

Changes in v2:
- Resolved reliability issues with locking and teardown/re-probe
- Add #ifdefs for CONFIG_RMI4_F34 in rmi_driver.c
- Slightly improve debug
- Tested by Chris Healy


 drivers/input/rmi4/Makefile     |    2 +-
 drivers/input/rmi4/rmi_driver.c |   56 +-
 drivers/input/rmi4/rmi_f34.c    |   40 +-
 drivers/input/rmi4/rmi_f34.h    |  252 ++++++-
 drivers/input/rmi4/rmi_f34v7.c  | 1405 +++++++++++++++++++++++++++++++++++++++
 include/linux/rmi.h             |    2 +-
 6 files changed, 1722 insertions(+), 35 deletions(-)
 create mode 100644 drivers/input/rmi4/rmi_f34v7.c

diff --git a/drivers/input/rmi4/Makefile b/drivers/input/rmi4/Makefile
index a199cbe..9aaac3d 100644
--- a/drivers/input/rmi4/Makefile
+++ b/drivers/input/rmi4/Makefile
@@ -8,7 +8,7 @@ rmi_core-$(CONFIG_RMI4_F03) += rmi_f03.o
 rmi_core-$(CONFIG_RMI4_F11) += rmi_f11.o
 rmi_core-$(CONFIG_RMI4_F12) += rmi_f12.o
 rmi_core-$(CONFIG_RMI4_F30) += rmi_f30.o
-rmi_core-$(CONFIG_RMI4_F34) += rmi_f34.o
+rmi_core-$(CONFIG_RMI4_F34) += rmi_f34.o rmi_f34v7.o
 rmi_core-$(CONFIG_RMI4_F54) += rmi_f54.o
 rmi_core-$(CONFIG_RMI4_F55) += rmi_f55.o
 
diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 05a3c4b..cb6efe6 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -544,7 +544,7 @@ static int rmi_scan_pdt_page(struct rmi_device *rmi_dev,
 	else
 		*empty_pages = 0;
 
-	return (data->f01_bootloader_mode || *empty_pages >= 2) ?
+	return (data->bootloader_mode || *empty_pages >= 2) ?
 					RMI_SCAN_DONE : RMI_SCAN_CONTINUE;
 }
 
@@ -749,41 +749,49 @@ bool rmi_register_desc_has_subpacket(const struct rmi_register_desc_item *item,
 				subpacket) == subpacket;
 }
 
-/* Indicates that flash programming is enabled (bootloader mode). */
-#define RMI_F01_STATUS_BOOTLOADER(status)	(!!((status) & 0x40))
-
-/*
- * Given the PDT entry for F01, read the device status register to determine
- * if we're stuck in bootloader mode or not.
- *
- */
 static int rmi_check_bootloader_mode(struct rmi_device *rmi_dev,
 				     const struct pdt_entry *pdt)
 {
-	int error;
-	u8 device_status;
+	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
+	int ret;
+	u8 status;
 
-	error = rmi_read(rmi_dev, pdt->data_base_addr + pdt->page_start,
-			 &device_status);
-	if (error) {
-		dev_err(&rmi_dev->dev,
-			"Failed to read device status: %d.\n", error);
-		return error;
+	if (pdt->function_number == 0x34 && pdt->function_version > 1) {
+		ret = rmi_read(rmi_dev, pdt->data_base_addr, &status);
+		if (ret) {
+			dev_err(&rmi_dev->dev,
+				"Failed to read F34 status: %d.\n", ret);
+			return ret;
+		}
+
+		if (status & BIT(7))
+			data->bootloader_mode = true;
+	} else if (pdt->function_number == 0x01) {
+		ret = rmi_read(rmi_dev, pdt->data_base_addr, &status);
+		if (ret) {
+			dev_err(&rmi_dev->dev,
+				"Failed to read F01 status: %d.\n", ret);
+			return ret;
+		}
+
+		if (status & BIT(6))
+			data->bootloader_mode = true;
 	}
 
-	return RMI_F01_STATUS_BOOTLOADER(device_status);
+	return 0;
 }
 
 static int rmi_count_irqs(struct rmi_device *rmi_dev,
 			 void *ctx, const struct pdt_entry *pdt)
 {
-	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
 	int *irq_count = ctx;
+	int ret;
 
 	*irq_count += pdt->interrupt_source_count;
-	if (pdt->function_number == 0x01)
-		data->f01_bootloader_mode =
-			rmi_check_bootloader_mode(rmi_dev, pdt);
+
+	ret = rmi_check_bootloader_mode(rmi_dev, pdt);
+	if (ret < 0)
+		return ret;
 
 	return RMI_SCAN_CONTINUE;
 }
@@ -1024,13 +1032,15 @@ int rmi_probe_interrupts(struct rmi_driver_data *data)
 	 */
 	rmi_dbg(RMI_DEBUG_CORE, dev, "%s: Counting IRQs.\n", __func__);
 	irq_count = 0;
+	data->bootloader_mode = false;
+
 	retval = rmi_scan_pdt(rmi_dev, &irq_count, rmi_count_irqs);
 	if (retval < 0) {
 		dev_err(dev, "IRQ counting failed with code %d.\n", retval);
 		return retval;
 	}
 
-	if (data->f01_bootloader_mode)
+	if (data->bootloader_mode)
 		dev_warn(&rmi_dev->dev, "Device in bootloader mode.\n");
 
 	data->irq_count = irq_count;
diff --git a/drivers/input/rmi4/rmi_f34.c b/drivers/input/rmi4/rmi_f34.c
index 01936a4..9774dfb 100644
--- a/drivers/input/rmi4/rmi_f34.c
+++ b/drivers/input/rmi4/rmi_f34.c
@@ -12,6 +12,7 @@
 #include <linux/firmware.h>
 #include <asm/unaligned.h>
 #include <asm/unaligned.h>
+#include <linux/bitops.h>
 
 #include "rmi_driver.h"
 #include "rmi_f34.h"
@@ -105,6 +106,9 @@ static int rmi_f34_attention(struct rmi_function *fn, unsigned long *irq_bits)
 	struct f34_data *f34 = dev_get_drvdata(&fn->dev);
 	int ret;
 
+	if (f34->bl_version != 5)
+		return 0;
+
 	ret = rmi_read(f34->fn->rmi_dev, f34->v5.ctrl_address, &f34->v5.status);
 	rmi_dbg(RMI_DEBUG_FN, &fn->dev, "%s: status: %#02x, ret: %d\n",
 		__func__, f34->v5.status, ret);
@@ -292,17 +296,24 @@ static int rmi_firmware_update(struct rmi_driver_data *data,
 		return -EINVAL;
 	}
 
-	/* Only version 0 currently supported */
-	if (data->f34_container->fd.function_version != 0) {
+	f34 = dev_get_drvdata(&data->f34_container->dev);
+
+	if (f34->bl_version == 7) {
+		if (data->pdt_props & HAS_BSR) {
+			dev_err(dev, "%s: LTS not supported\n", __func__);
+			return -ENODEV;
+		}
+	} else if (f34->bl_version != 5) {
 		dev_warn(dev, "F34 V%d not supported!\n",
 			 data->f34_container->fd.function_version);
 		return -ENODEV;
 	}
 
-	f34 = dev_get_drvdata(&data->f34_container->dev);
-
 	/* Enter flash mode */
-	ret = rmi_f34_enable_flash(f34);
+	if (f34->bl_version == 7)
+		ret = rmi_f34v7_start_reflash(f34, fw);
+	else
+		ret = rmi_f34_enable_flash(f34);
 	if (ret)
 		return ret;
 
@@ -319,7 +330,7 @@ static int rmi_firmware_update(struct rmi_driver_data *data,
 	if (ret)
 		return ret;
 
-	if (!data->f01_bootloader_mode || !data->f34_container) {
+	if (!data->bootloader_mode || !data->f34_container) {
 		dev_warn(dev, "%s: No F34 present or not in bootloader!\n",
 				__func__);
 		return -EINVAL;
@@ -330,7 +341,10 @@ static int rmi_firmware_update(struct rmi_driver_data *data,
 	f34 = dev_get_drvdata(&data->f34_container->dev);
 
 	/* Perform firmware update */
-	ret = rmi_f34_update_firmware(f34, fw);
+	if (f34->bl_version == 7)
+		ret = rmi_f34v7_do_reflash(f34, fw);
+	else
+		ret = rmi_f34_update_firmware(f34, fw);
 
 	dev_info(&f34->fn->dev, "Firmware update complete, status:%d\n", ret);
 
@@ -363,6 +377,9 @@ static int rmi_firmware_update(struct rmi_driver_data *data,
 	return ret;
 }
 
+static int rmi_firmware_update(struct rmi_driver_data *data,
+			       const struct firmware *fw);
+
 static ssize_t rmi_driver_update_fw_store(struct device *dev,
 					  struct device_attribute *dattr,
 					  const char *buf, size_t count)
@@ -411,6 +428,7 @@ static int rmi_f34_probe(struct rmi_function *fn)
 	struct f34_data *f34;
 	unsigned char f34_queries[9];
 	bool has_config_id;
+	u8 version = fn->fd.function_version;
 	int ret;
 
 	f34 = devm_kzalloc(&fn->dev, sizeof(struct f34_data), GFP_KERNEL);
@@ -420,6 +438,14 @@ static int rmi_f34_probe(struct rmi_function *fn)
 	f34->fn = fn;
 	dev_set_drvdata(&fn->dev, f34);
 
+	/* v5 code only supported version 0, try V7 probe */
+	if (version > 0)
+		return rmi_f34v7_probe(f34);
+	else if (version != 0)
+		return -ENODEV;
+
+	f34->bl_version = 5;
+
 	ret = rmi_read_block(fn->rmi_dev, fn->fd.query_base_addr,
 			     f34_queries, sizeof(f34_queries));
 	if (ret) {
diff --git a/drivers/input/rmi4/rmi_f34.h b/drivers/input/rmi4/rmi_f34.h
index 6cee528..87776b2 100644
--- a/drivers/input/rmi4/rmi_f34.h
+++ b/drivers/input/rmi4/rmi_f34.h
@@ -33,6 +33,216 @@
 
 #define F34_BOOTLOADER_ID_LEN	2
 
+/* F34 V7 defines */
+#define V7_FLASH_STATUS_OFFSET		0
+#define V7_PARTITION_ID_OFFSET		1
+#define V7_BLOCK_NUMBER_OFFSET		2
+#define V7_TRANSFER_LENGTH_OFFSET	3
+#define V7_COMMAND_OFFSET		4
+#define V7_PAYLOAD_OFFSET		5
+#define V7_BOOTLOADER_ID_OFFSET		1
+
+#define IMAGE_HEADER_VERSION_10		0x10
+
+#define CONFIG_ID_SIZE			32
+#define PRODUCT_ID_SIZE			10
+
+#define ENABLE_WAIT_MS			(1 * 1000)
+#define WRITE_WAIT_MS			(3 * 1000)
+
+#define MIN_SLEEP_TIME_US		50
+#define MAX_SLEEP_TIME_US		100
+
+#define HAS_BSR				BIT(5)
+#define HAS_CONFIG_ID			BIT(3)
+#define HAS_GUEST_CODE			BIT(6)
+#define HAS_DISP_CFG			BIT(5)
+
+/* F34 V7 commands */
+#define CMD_V7_IDLE			0
+#define CMD_V7_ENTER_BL			1
+#define CMD_V7_READ			2
+#define CMD_V7_WRITE			3
+#define CMD_V7_ERASE			4
+#define CMD_V7_ERASE_AP			5
+#define CMD_V7_SENSOR_ID		6
+
+#define v7_CMD_IDLE			0
+#define v7_CMD_WRITE_FW			1
+#define v7_CMD_WRITE_CONFIG		2
+#define v7_CMD_WRITE_LOCKDOWN		3
+#define v7_CMD_WRITE_GUEST_CODE		4
+#define v7_CMD_READ_CONFIG		5
+#define v7_CMD_ERASE_ALL		6
+#define v7_CMD_ERASE_UI_FIRMWARE	7
+#define v7_CMD_ERASE_UI_CONFIG		8
+#define v7_CMD_ERASE_BL_CONFIG		9
+#define v7_CMD_ERASE_DISP_CONFIG	10
+#define v7_CMD_ERASE_FLASH_CONFIG	11
+#define v7_CMD_ERASE_GUEST_CODE		12
+#define v7_CMD_ENABLE_FLASH_PROG	13
+
+#define v7_UI_CONFIG_AREA		0
+#define v7_PM_CONFIG_AREA		1
+#define v7_BL_CONFIG_AREA		2
+#define v7_DP_CONFIG_AREA		3
+#define v7_FLASH_CONFIG_AREA		4
+
+/* F34 V7 partition IDs */
+#define BOOTLOADER_PARTITION		1
+#define DEVICE_CONFIG_PARTITION		2
+#define FLASH_CONFIG_PARTITION		3
+#define MANUFACTURING_BLOCK_PARTITION	4
+#define GUEST_SERIALIZATION_PARTITION	5
+#define GLOBAL_PARAMETERS_PARTITION	6
+#define CORE_CODE_PARTITION		7
+#define CORE_CONFIG_PARTITION		8
+#define GUEST_CODE_PARTITION		9
+#define DISPLAY_CONFIG_PARTITION	10
+
+/* F34 V7 container IDs */
+#define TOP_LEVEL_CONTAINER			0
+#define UI_CONTAINER				1
+#define UI_CONFIG_CONTAINER			2
+#define BL_CONTAINER				3
+#define BL_IMAGE_CONTAINER			4
+#define BL_CONFIG_CONTAINER			5
+#define BL_LOCKDOWN_INFO_CONTAINER		6
+#define PERMANENT_CONFIG_CONTAINER		7
+#define GUEST_CODE_CONTAINER			8
+#define BL_PROTOCOL_DESCRIPTOR_CONTAINER	9
+#define UI_PROTOCOL_DESCRIPTOR_CONTAINER	10
+#define RMI_SELF_DISCOVERY_CONTAINER		11
+#define RMI_PAGE_CONTENT_CONTAINER		12
+#define GENERAL_INFORMATION_CONTAINER		13
+#define DEVICE_CONFIG_CONTAINER			14
+#define FLASH_CONFIG_CONTAINER			15
+#define GUEST_SERIALIZATION_CONTAINER		16
+#define GLOBAL_PARAMETERS_CONTAINER		17
+#define CORE_CODE_CONTAINER			18
+#define CORE_CONFIG_CONTAINER			19
+#define DISPLAY_CONFIG_CONTAINER		20
+
+struct f34v7_query_1_7 {
+	u8 bl_minor_revision;			/* query 1 */
+	u8 bl_major_revision;
+	__le32 bl_fw_id;			/* query 2 */
+	u8 minimum_write_size;			/* query 3 */
+	__le16 block_size;
+	__le16 flash_page_size;
+	__le16 adjustable_partition_area_size;	/* query 4 */
+	__le16 flash_config_length;		/* query 5 */
+	__le16 payload_length;			/* query 6 */
+	u8 partition_support[4];		/* query 7 */
+} __packed;
+
+struct f34v7_data_1_5 {
+	u8 partition_id;
+	__le16 block_offset;
+	__le16 transfer_length;
+	u8 command;
+	u8 payload[2];
+} __packed;
+
+struct block_data {
+	const u8 *data;
+	int size;
+};
+
+struct partition_table {
+	u8 partition_id;
+	u8 byte_1_reserved;
+	__le16 partition_length;
+	__le16 start_physical_address;
+	__le16 partition_properties;
+} __packed;
+
+struct physical_address {
+	u16 ui_firmware;
+	u16 ui_config;
+	u16 dp_config;
+	u16 guest_code;
+};
+
+struct container_descriptor {
+	__le32 content_checksum;
+	__le16 container_id;
+	u8 minor_version;
+	u8 major_version;
+	u8 reserved_08;
+	u8 reserved_09;
+	u8 reserved_0a;
+	u8 reserved_0b;
+	u8 container_option_flags[4];
+	__le32 content_options_length;
+	__le32 content_options_address;
+	__le32 content_length;
+	__le32 content_address;
+} __packed;
+
+struct block_count {
+	u16 ui_firmware;
+	u16 ui_config;
+	u16 dp_config;
+	u16 fl_config;
+	u16 pm_config;
+	u16 bl_config;
+	u16 lockdown;
+	u16 guest_code;
+};
+
+struct image_header_10 {
+	__le32 checksum;
+	u8 reserved_04;
+	u8 reserved_05;
+	u8 minor_header_version;
+	u8 major_header_version;
+	u8 reserved_08;
+	u8 reserved_09;
+	u8 reserved_0a;
+	u8 reserved_0b;
+	__le32 top_level_container_start_addr;
+};
+
+struct image_metadata {
+	bool contains_firmware_id;
+	bool contains_bootloader;
+	bool contains_display_cfg;
+	bool contains_guest_code;
+	bool contains_flash_config;
+	unsigned int firmware_id;
+	unsigned int checksum;
+	unsigned int bootloader_size;
+	unsigned int display_cfg_offset;
+	u8 bl_version;
+	u8 product_id[PRODUCT_ID_SIZE + 1];
+	u8 cstmr_product_id[PRODUCT_ID_SIZE + 1];
+	struct block_data bootloader;
+	struct block_data ui_firmware;
+	struct block_data ui_config;
+	struct block_data dp_config;
+	struct block_data fl_config;
+	struct block_data bl_config;
+	struct block_data guest_code;
+	struct block_data lockdown;
+	struct block_count blkcount;
+	struct physical_address phyaddr;
+};
+
+struct register_offset {
+	u8 properties;
+	u8 properties_2;
+	u8 block_size;
+	u8 block_count;
+	u8 gc_block_count;
+	u8 flash_status;
+	u8 partition_id;
+	u8 block_number;
+	u8 transfer_length;
+	u8 flash_cmd;
+	u8 payload;
+};
+
 struct rmi_f34_firmware {
 	__le32 checksum;
 	u8 pad1[3];
@@ -56,13 +266,49 @@ struct f34v5_data {
 	struct mutex flash_mutex;
 };
 
+struct f34v7_data {
+	bool has_display_cfg;
+	bool has_guest_code;
+	bool force_update;
+	bool in_bl_mode;
+	u8 *read_config_buf;
+	u16 read_config_buf_size;
+	u8 command;
+	u8 flash_status;
+	u16 block_size;
+	u16 config_block_count;
+	u16 config_size;
+	u16 config_area;
+	u16 flash_config_length;
+	u16 payload_length;
+	u8 partitions;
+	u16 partition_table_bytes;
+	bool new_partition_table;
+
+	struct register_offset off;
+	struct block_count blkcount;
+	struct physical_address phyaddr;
+	struct image_metadata img;
+
+	const u8 *config_data;
+	const u8 *image;
+};
+
 struct f34_data {
 	struct rmi_function *fn;
 
-	unsigned char bootloader_id[5];
-	unsigned char configuration_id[9];
+	u8 bl_version;
+	u8 bootloader_id[5];
+	u8 configuration_id[CONFIG_ID_SIZE*2 + 1];
 
-	struct f34v5_data v5;
+	union {
+		struct f34v5_data v5;
+		struct f34v7_data v7;
+	};
 };
 
+int rmi_f34v7_start_reflash(struct f34_data *f34, const struct firmware *fw);
+int rmi_f34v7_do_reflash(struct f34_data *f34, const struct firmware *fw);
+int rmi_f34v7_probe(struct f34_data *f34);
+
 #endif /* _RMI_F34_H */
diff --git a/drivers/input/rmi4/rmi_f34v7.c b/drivers/input/rmi4/rmi_f34v7.c
new file mode 100644
index 0000000..d682ad6
--- /dev/null
+++ b/drivers/input/rmi4/rmi_f34v7.c
@@ -0,0 +1,1405 @@
+/*
+ * Copyright (c) 2016, Zodiac Inflight Innovations
+ * Copyright (c) 2007-2016, Synaptics Incorporated
+ * Copyright (C) 2012 Alexandra Chin <alexandra.chin@tw.synaptics.com>
+ * Copyright (C) 2012 Scott Lin <scott.lin@tw.synaptics.com>
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
+#include <linux/delay.h>
+#include <linux/slab.h>
+
+#include "rmi_driver.h"
+#include "rmi_f34.h"
+
+static int rmi_f34v7_read_flash_status(struct f34_data *f34)
+{
+	u8 status;
+	u8 command;
+	int ret;
+
+	ret = rmi_read_block(f34->fn->rmi_dev,
+			f34->fn->fd.data_base_addr + f34->v7.off.flash_status,
+			&status,
+			sizeof(status));
+	if (ret < 0) {
+		rmi_dbg(RMI_DEBUG_FN, &f34->fn->dev,
+			"%s: Failed to read flash status\n", __func__);
+		return ret;
+	}
+
+	f34->v7.in_bl_mode = status >> 7;
+	f34->v7.flash_status = status & 0x1f;
+
+	if (f34->v7.flash_status != 0x00) {
+		dev_err(&f34->fn->dev, "%s: status=%d, command=0x%02x\n",
+			__func__, f34->v7.flash_status, f34->v7.command);
+	}
+
+	ret = rmi_read_block(f34->fn->rmi_dev,
+			f34->fn->fd.data_base_addr + f34->v7.off.flash_cmd,
+			&command,
+			sizeof(command));
+	if (ret < 0) {
+		dev_err(&f34->fn->dev, "%s: Failed to read flash command\n",
+			__func__);
+		return ret;
+	}
+
+	f34->v7.command = command;
+
+	return 0;
+}
+
+static int rmi_f34v7_wait_for_idle(struct f34_data *f34, int timeout_ms)
+{
+	int count = 0;
+	int timeout_count = ((timeout_ms * 1000) / MAX_SLEEP_TIME_US) + 1;
+
+	do {
+		usleep_range(MIN_SLEEP_TIME_US, MAX_SLEEP_TIME_US);
+
+		count++;
+
+		rmi_f34v7_read_flash_status(f34);
+
+		if ((f34->v7.command == v7_CMD_IDLE)
+		    && (f34->v7.flash_status == 0x00)) {
+			rmi_dbg(RMI_DEBUG_FN, &f34->fn->dev,
+				"Idle status detected\n");
+			return 0;
+		}
+	} while (count < timeout_count);
+
+	dev_err(&f34->fn->dev,
+		"%s: Timed out waiting for idle status\n", __func__);
+
+	return -ETIMEDOUT;
+}
+
+static int rmi_f34v7_write_command_single_transaction(struct f34_data *f34,
+						      u8 cmd)
+{
+	int ret;
+	u8 base;
+	struct f34v7_data_1_5 data_1_5;
+
+	base = f34->fn->fd.data_base_addr;
+
+	memset(&data_1_5, 0, sizeof(data_1_5));
+
+	switch (cmd) {
+	case v7_CMD_ERASE_ALL:
+		data_1_5.partition_id = CORE_CODE_PARTITION;
+		data_1_5.command = CMD_V7_ERASE_AP;
+		break;
+	case v7_CMD_ERASE_UI_FIRMWARE:
+		data_1_5.partition_id = CORE_CODE_PARTITION;
+		data_1_5.command = CMD_V7_ERASE;
+		break;
+	case v7_CMD_ERASE_BL_CONFIG:
+		data_1_5.partition_id = GLOBAL_PARAMETERS_PARTITION;
+		data_1_5.command = CMD_V7_ERASE;
+		break;
+	case v7_CMD_ERASE_UI_CONFIG:
+		data_1_5.partition_id = CORE_CONFIG_PARTITION;
+		data_1_5.command = CMD_V7_ERASE;
+		break;
+	case v7_CMD_ERASE_DISP_CONFIG:
+		data_1_5.partition_id = DISPLAY_CONFIG_PARTITION;
+		data_1_5.command = CMD_V7_ERASE;
+		break;
+	case v7_CMD_ERASE_FLASH_CONFIG:
+		data_1_5.partition_id = FLASH_CONFIG_PARTITION;
+		data_1_5.command = CMD_V7_ERASE;
+		break;
+	case v7_CMD_ERASE_GUEST_CODE:
+		data_1_5.partition_id = GUEST_CODE_PARTITION;
+		data_1_5.command = CMD_V7_ERASE;
+		break;
+	case v7_CMD_ENABLE_FLASH_PROG:
+		data_1_5.partition_id = BOOTLOADER_PARTITION;
+		data_1_5.command = CMD_V7_ENTER_BL;
+		break;
+	}
+
+	data_1_5.payload[0] = f34->bootloader_id[0];
+	data_1_5.payload[1] = f34->bootloader_id[1];
+
+	ret = rmi_write_block(f34->fn->rmi_dev,
+			base + f34->v7.off.partition_id,
+			&data_1_5,
+			sizeof(data_1_5));
+	if (ret < 0) {
+		dev_err(&f34->fn->dev,
+			"%s: Failed to write single transaction command\n",
+			__func__);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int rmi_f34v7_write_command(struct f34_data *f34, u8 cmd)
+{
+	int ret;
+	u8 base;
+	u8 command;
+
+	base = f34->fn->fd.data_base_addr;
+
+	switch (cmd) {
+	case v7_CMD_WRITE_FW:
+	case v7_CMD_WRITE_CONFIG:
+	case v7_CMD_WRITE_GUEST_CODE:
+		command = CMD_V7_WRITE;
+		break;
+	case v7_CMD_READ_CONFIG:
+		command = CMD_V7_READ;
+		break;
+	case v7_CMD_ERASE_ALL:
+		command = CMD_V7_ERASE_AP;
+		break;
+	case v7_CMD_ERASE_UI_FIRMWARE:
+	case v7_CMD_ERASE_BL_CONFIG:
+	case v7_CMD_ERASE_UI_CONFIG:
+	case v7_CMD_ERASE_DISP_CONFIG:
+	case v7_CMD_ERASE_FLASH_CONFIG:
+	case v7_CMD_ERASE_GUEST_CODE:
+		command = CMD_V7_ERASE;
+		break;
+	case v7_CMD_ENABLE_FLASH_PROG:
+		command = CMD_V7_ENTER_BL;
+		break;
+	default:
+		dev_err(&f34->fn->dev, "%s: Invalid command 0x%02x\n",
+			__func__, cmd);
+		return -EINVAL;
+	}
+
+	f34->v7.command = command;
+
+	switch (cmd) {
+	case v7_CMD_ERASE_ALL:
+	case v7_CMD_ERASE_UI_FIRMWARE:
+	case v7_CMD_ERASE_BL_CONFIG:
+	case v7_CMD_ERASE_UI_CONFIG:
+	case v7_CMD_ERASE_DISP_CONFIG:
+	case v7_CMD_ERASE_FLASH_CONFIG:
+	case v7_CMD_ERASE_GUEST_CODE:
+	case v7_CMD_ENABLE_FLASH_PROG:
+		ret = rmi_f34v7_write_command_single_transaction(f34, cmd);
+		if (ret < 0)
+			return ret;
+		else
+			return 0;
+	default:
+		break;
+	}
+
+	rmi_dbg(RMI_DEBUG_FN, &f34->fn->dev, "%s: writing cmd %02X\n",
+		__func__, command);
+
+	ret = rmi_write_block(f34->fn->rmi_dev,
+			base + f34->v7.off.flash_cmd,
+			&command,
+			sizeof(command));
+	if (ret < 0) {
+		dev_err(&f34->fn->dev, "%s: Failed to write flash command\n",
+			__func__);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int rmi_f34v7_write_partition_id(struct f34_data *f34, u8 cmd)
+{
+	int ret;
+	u8 base;
+	u8 partition;
+
+	base = f34->fn->fd.data_base_addr;
+
+	switch (cmd) {
+	case v7_CMD_WRITE_FW:
+		partition = CORE_CODE_PARTITION;
+		break;
+	case v7_CMD_WRITE_CONFIG:
+	case v7_CMD_READ_CONFIG:
+		if (f34->v7.config_area == v7_UI_CONFIG_AREA)
+			partition = CORE_CONFIG_PARTITION;
+		else if (f34->v7.config_area == v7_DP_CONFIG_AREA)
+			partition = DISPLAY_CONFIG_PARTITION;
+		else if (f34->v7.config_area == v7_PM_CONFIG_AREA)
+			partition = GUEST_SERIALIZATION_PARTITION;
+		else if (f34->v7.config_area == v7_BL_CONFIG_AREA)
+			partition = GLOBAL_PARAMETERS_PARTITION;
+		else if (f34->v7.config_area == v7_FLASH_CONFIG_AREA)
+			partition = FLASH_CONFIG_PARTITION;
+		break;
+	case v7_CMD_WRITE_GUEST_CODE:
+		partition = GUEST_CODE_PARTITION;
+		break;
+	case v7_CMD_ERASE_ALL:
+		partition = CORE_CODE_PARTITION;
+		break;
+	case v7_CMD_ERASE_BL_CONFIG:
+		partition = GLOBAL_PARAMETERS_PARTITION;
+		break;
+	case v7_CMD_ERASE_UI_CONFIG:
+		partition = CORE_CONFIG_PARTITION;
+		break;
+	case v7_CMD_ERASE_DISP_CONFIG:
+		partition = DISPLAY_CONFIG_PARTITION;
+		break;
+	case v7_CMD_ERASE_FLASH_CONFIG:
+		partition = FLASH_CONFIG_PARTITION;
+		break;
+	case v7_CMD_ERASE_GUEST_CODE:
+		partition = GUEST_CODE_PARTITION;
+		break;
+	case v7_CMD_ENABLE_FLASH_PROG:
+		partition = BOOTLOADER_PARTITION;
+		break;
+	default:
+		dev_err(&f34->fn->dev, "%s: Invalid command 0x%02x\n",
+			__func__, cmd);
+		return -EINVAL;
+	}
+
+	ret = rmi_write_block(f34->fn->rmi_dev,
+			base + f34->v7.off.partition_id,
+			&partition,
+			sizeof(partition));
+	if (ret < 0) {
+		dev_err(&f34->fn->dev, "%s: Failed to write partition ID\n",
+			__func__);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int rmi_f34v7_read_f34v7_partition_table(struct f34_data *f34)
+{
+	int ret;
+	u8 base;
+	__le16 length;
+	u16 block_number = 0;
+
+	base = f34->fn->fd.data_base_addr;
+
+	f34->v7.config_area = v7_FLASH_CONFIG_AREA;
+
+	ret = rmi_f34v7_write_partition_id(f34, v7_CMD_READ_CONFIG);
+	if (ret < 0)
+		return ret;
+
+	ret = rmi_write_block(f34->fn->rmi_dev,
+			base + f34->v7.off.block_number,
+			(u8 *)&block_number,
+			sizeof(block_number));
+	if (ret < 0) {
+		dev_err(&f34->fn->dev, "%s: Failed to write block number\n",
+			__func__);
+		return ret;
+	}
+
+	put_unaligned_le16(f34->v7.flash_config_length, &length);
+
+	ret = rmi_write_block(f34->fn->rmi_dev,
+			base + f34->v7.off.transfer_length,
+			&length,
+			sizeof(length));
+	if (ret < 0) {
+		dev_err(&f34->fn->dev, "%s: Failed to write transfer length\n",
+			__func__);
+		return ret;
+	}
+
+	ret = rmi_f34v7_write_command(f34, v7_CMD_READ_CONFIG);
+	if (ret < 0) {
+		dev_err(&f34->fn->dev, "%s: Failed to write command\n",
+			__func__);
+		return ret;
+	}
+
+	ret = rmi_f34v7_wait_for_idle(f34, WRITE_WAIT_MS);
+	if (ret < 0) {
+		dev_err(&f34->fn->dev, "%s: Failed to wait for idle status\n",
+			__func__);
+		return ret;
+	}
+
+	ret = rmi_read_block(f34->fn->rmi_dev,
+			base + f34->v7.off.payload,
+			f34->v7.read_config_buf,
+			f34->v7.partition_table_bytes);
+	if (ret < 0) {
+		dev_err(&f34->fn->dev, "%s: Failed to read block data\n",
+			__func__);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void rmi_f34v7_parse_partition_table(struct f34_data *f34,
+					    const u8 *partition_table,
+					    struct block_count *blkcount,
+					    struct physical_address *phyaddr)
+{
+	int i;
+	int index;
+	u16 partition_length;
+	u16 physical_address;
+	struct partition_table *ptable;
+
+	for (i = 0; i < f34->v7.partitions; i++) {
+		index = i * 8 + 2;
+		ptable = (struct partition_table *)&partition_table[index];
+		partition_length = le16_to_cpu(ptable->partition_length);
+		physical_address = le16_to_cpu(ptable->start_physical_address);
+		rmi_dbg(RMI_DEBUG_FN, &f34->fn->dev,
+			"%s: Partition entry %d: %*ph\n",
+			__func__, i, sizeof(struct partition_table), ptable);
+		switch (ptable->partition_id & 0x1f) {
+		case CORE_CODE_PARTITION:
+			blkcount->ui_firmware = partition_length;
+			phyaddr->ui_firmware = physical_address;
+			rmi_dbg(RMI_DEBUG_FN, &f34->fn->dev,
+				"%s: Core code block count: %d\n",
+				__func__, blkcount->ui_firmware);
+			break;
+		case CORE_CONFIG_PARTITION:
+			blkcount->ui_config = partition_length;
+			phyaddr->ui_config = physical_address;
+			rmi_dbg(RMI_DEBUG_FN, &f34->fn->dev,
+				"%s: Core config block count: %d\n",
+				__func__, blkcount->ui_config);
+			break;
+		case DISPLAY_CONFIG_PARTITION:
+			blkcount->dp_config = partition_length;
+			phyaddr->dp_config = physical_address;
+			rmi_dbg(RMI_DEBUG_FN, &f34->fn->dev,
+				"%s: Display config block count: %d\n",
+				__func__, blkcount->dp_config);
+			break;
+		case FLASH_CONFIG_PARTITION:
+			blkcount->fl_config = partition_length;
+			rmi_dbg(RMI_DEBUG_FN, &f34->fn->dev,
+				"%s: Flash config block count: %d\n",
+				__func__, blkcount->fl_config);
+			break;
+		case GUEST_CODE_PARTITION:
+			blkcount->guest_code = partition_length;
+			phyaddr->guest_code = physical_address;
+			rmi_dbg(RMI_DEBUG_FN, &f34->fn->dev,
+				"%s: Guest code block count: %d\n",
+				__func__, blkcount->guest_code);
+			break;
+		case GUEST_SERIALIZATION_PARTITION:
+			blkcount->pm_config = partition_length;
+			rmi_dbg(RMI_DEBUG_FN, &f34->fn->dev,
+				"%s: Guest serialization block count: %d\n",
+				__func__, blkcount->pm_config);
+			break;
+		case GLOBAL_PARAMETERS_PARTITION:
+			blkcount->bl_config = partition_length;
+			rmi_dbg(RMI_DEBUG_FN, &f34->fn->dev,
+				"%s: Global parameters block count: %d\n",
+				__func__, blkcount->bl_config);
+			break;
+		case DEVICE_CONFIG_PARTITION:
+			blkcount->lockdown = partition_length;
+			rmi_dbg(RMI_DEBUG_FN, &f34->fn->dev,
+				"%s: Device config block count: %d\n",
+				__func__, blkcount->lockdown);
+			break;
+		}
+	}
+}
+
+static int rmi_f34v7_read_queries_bl_version(struct f34_data *f34)
+{
+	int ret;
+	u8 base;
+	int offset;
+	u8 query_0;
+	struct f34v7_query_1_7 query_1_7;
+
+	base = f34->fn->fd.query_base_addr;
+
+	ret = rmi_read_block(f34->fn->rmi_dev,
+			base,
+			&query_0,
+			sizeof(query_0));
+	if (ret < 0) {
+		dev_err(&f34->fn->dev,
+			"%s: Failed to read query 0\n", __func__);
+		return ret;
+	}
+
+	offset = (query_0 & 0x7) + 1;
+
+	ret = rmi_read_block(f34->fn->rmi_dev,
+			base + offset,
+			&query_1_7,
+			sizeof(query_1_7));
+	if (ret < 0) {
+		dev_err(&f34->fn->dev, "%s: Failed to read queries 1 to 7\n",
+			__func__);
+		return ret;
+	}
+
+	f34->bootloader_id[0] = query_1_7.bl_minor_revision;
+	f34->bootloader_id[1] = query_1_7.bl_major_revision;
+
+	rmi_dbg(RMI_DEBUG_FN, &f34->fn->dev, "Bootloader V%d.%d\n",
+		f34->bootloader_id[1], f34->bootloader_id[0]);
+
+	return 0;
+}
+
+static int rmi_f34v7_read_queries(struct f34_data *f34)
+{
+	int ret;
+	int i, j;
+	u8 base;
+	int offset;
+	u8 *ptable;
+	u8 query_0;
+	struct f34v7_query_1_7 query_1_7;
+
+	base = f34->fn->fd.query_base_addr;
+
+	ret = rmi_read_block(f34->fn->rmi_dev,
+			base,
+			&query_0,
+			sizeof(query_0));
+	if (ret < 0) {
+		dev_err(&f34->fn->dev,
+			"%s: Failed to read query 0\n", __func__);
+		return ret;
+	}
+
+	offset = (query_0 & 0x07) + 1;
+
+	ret = rmi_read_block(f34->fn->rmi_dev,
+			base + offset,
+			&query_1_7,
+			sizeof(query_1_7));
+	if (ret < 0) {
+		dev_err(&f34->fn->dev, "%s: Failed to read queries 1 to 7\n",
+			__func__);
+		return ret;
+	}
+
+	f34->bootloader_id[0] = query_1_7.bl_minor_revision;
+	f34->bootloader_id[1] = query_1_7.bl_major_revision;
+
+	f34->v7.block_size = le16_to_cpu(query_1_7.block_size);
+	f34->v7.flash_config_length = le16_to_cpu(query_1_7.flash_config_length);
+	f34->v7.payload_length = le16_to_cpu(query_1_7.payload_length);
+
+	rmi_dbg(RMI_DEBUG_FN, &f34->fn->dev, "%s: f34->v7.block_size = %d\n",
+		 __func__, f34->v7.block_size);
+
+	f34->v7.off.flash_status = V7_FLASH_STATUS_OFFSET;
+	f34->v7.off.partition_id = V7_PARTITION_ID_OFFSET;
+	f34->v7.off.block_number = V7_BLOCK_NUMBER_OFFSET;
+	f34->v7.off.transfer_length = V7_TRANSFER_LENGTH_OFFSET;
+	f34->v7.off.flash_cmd = V7_COMMAND_OFFSET;
+	f34->v7.off.payload = V7_PAYLOAD_OFFSET;
+
+	f34->v7.has_display_cfg = query_1_7.partition_support[1] & HAS_DISP_CFG;
+	f34->v7.has_guest_code = query_1_7.partition_support[1] & HAS_GUEST_CODE;
+
+	if (query_0 & HAS_CONFIG_ID) {
+		char f34_ctrl[CONFIG_ID_SIZE];
+		int i = 0;
+		u8 *p = f34->configuration_id;
+		*p = '\0';
+
+		ret = rmi_read_block(f34->fn->rmi_dev,
+				f34->fn->fd.control_base_addr,
+				f34_ctrl,
+				sizeof(f34_ctrl));
+		if (ret)
+			return ret;
+
+		/* Eat leading zeros */
+		while (i < sizeof(f34_ctrl) && !f34_ctrl[i])
+			i++;
+
+		for (; i < sizeof(f34_ctrl); i++)
+			p += snprintf(p, f34->configuration_id
+				      + sizeof(f34->configuration_id) - p,
+				      "%02X", f34_ctrl[i]);
+
+		rmi_dbg(RMI_DEBUG_FN, &f34->fn->dev, "Configuration ID: %s\n",
+			f34->configuration_id);
+	}
+
+	f34->v7.partitions = 0;
+	for (i = 0; i < sizeof(query_1_7.partition_support); i++)
+		for (j = 0; j < 8; j++)
+			if (query_1_7.partition_support[i] & (1 << j))
+				f34->v7.partitions++;
+
+	rmi_dbg(RMI_DEBUG_FN, &f34->fn->dev, "%s: Supported partitions: %*ph\n",
+		__func__, sizeof(query_1_7.partition_support),
+		query_1_7.partition_support);
+
+
+	f34->v7.partition_table_bytes = f34->v7.partitions * 8 + 2;
+
+	f34->v7.read_config_buf = devm_kzalloc(&f34->fn->dev,
+			f34->v7.partition_table_bytes,
+			GFP_KERNEL);
+	if (!f34->v7.read_config_buf) {
+		f34->v7.read_config_buf_size = 0;
+		return -ENOMEM;
+	}
+
+	f34->v7.read_config_buf_size = f34->v7.partition_table_bytes;
+	ptable = f34->v7.read_config_buf;
+
+	ret = rmi_f34v7_read_f34v7_partition_table(f34);
+	if (ret < 0) {
+		dev_err(&f34->fn->dev, "%s: Failed to read partition table\n",
+				__func__);
+		return ret;
+	}
+
+	rmi_f34v7_parse_partition_table(f34, ptable,
+					&f34->v7.blkcount, &f34->v7.phyaddr);
+
+	return 0;
+}
+
+static int rmi_f34v7_check_ui_firmware_size(struct f34_data *f34)
+{
+	u16 block_count;
+
+	block_count = f34->v7.img.ui_firmware.size / f34->v7.block_size;
+
+	if (block_count != f34->v7.blkcount.ui_firmware) {
+		dev_err(&f34->fn->dev,
+			"UI firmware size mismatch: %d != %d\n",
+			block_count, f34->v7.blkcount.ui_firmware);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int rmi_f34v7_check_ui_config_size(struct f34_data *f34)
+{
+	u16 block_count;
+
+	block_count = f34->v7.img.ui_config.size / f34->v7.block_size;
+
+	if (block_count != f34->v7.blkcount.ui_config) {
+		dev_err(&f34->fn->dev, "UI config size mismatch\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int rmi_f34v7_check_dp_config_size(struct f34_data *f34)
+{
+	u16 block_count;
+
+	block_count = f34->v7.img.dp_config.size / f34->v7.block_size;
+
+	if (block_count != f34->v7.blkcount.dp_config) {
+		dev_err(&f34->fn->dev, "Display config size mismatch\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int rmi_f34v7_check_guest_code_size(struct f34_data *f34)
+{
+	u16 block_count;
+
+	block_count = f34->v7.img.guest_code.size / f34->v7.block_size;
+	if (block_count != f34->v7.blkcount.guest_code) {
+		dev_err(&f34->fn->dev, "Guest code size mismatch\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int rmi_f34v7_check_bl_config_size(struct f34_data *f34)
+{
+	u16 block_count;
+
+	block_count = f34->v7.img.bl_config.size / f34->v7.block_size;
+
+	if (block_count != f34->v7.blkcount.bl_config) {
+		dev_err(&f34->fn->dev, "Bootloader config size mismatch\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int rmi_f34v7_erase_config(struct f34_data *f34)
+{
+	int ret;
+
+	dev_info(&f34->fn->dev, "Erasing config...\n");
+
+	switch (f34->v7.config_area) {
+	case v7_UI_CONFIG_AREA:
+		ret = rmi_f34v7_write_command(f34, v7_CMD_ERASE_UI_CONFIG);
+		if (ret < 0)
+			return ret;
+		break;
+	case v7_DP_CONFIG_AREA:
+		ret = rmi_f34v7_write_command(f34, v7_CMD_ERASE_DISP_CONFIG);
+		if (ret < 0)
+			return ret;
+		break;
+	case v7_BL_CONFIG_AREA:
+		ret = rmi_f34v7_write_command(f34, v7_CMD_ERASE_BL_CONFIG);
+		if (ret < 0)
+			return ret;
+		break;
+	}
+
+	ret = rmi_f34v7_wait_for_idle(f34, ENABLE_WAIT_MS);
+	if (ret < 0)
+		return ret;
+
+	return ret;
+}
+
+static int rmi_f34v7_erase_guest_code(struct f34_data *f34)
+{
+	int ret;
+
+	dev_info(&f34->fn->dev, "Erasing guest code...\n");
+
+	ret = rmi_f34v7_write_command(f34, v7_CMD_ERASE_GUEST_CODE);
+	if (ret < 0)
+		return ret;
+
+	ret = rmi_f34v7_wait_for_idle(f34, ENABLE_WAIT_MS);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int rmi_f34v7_erase_all(struct f34_data *f34)
+{
+	int ret;
+
+	dev_info(&f34->fn->dev, "Erasing firmware...\n");
+
+	ret = rmi_f34v7_write_command(f34, v7_CMD_ERASE_UI_FIRMWARE);
+	if (ret < 0)
+		return ret;
+
+	ret = rmi_f34v7_wait_for_idle(f34, ENABLE_WAIT_MS);
+	if (ret < 0)
+		return ret;
+
+	f34->v7.config_area = v7_UI_CONFIG_AREA;
+	ret = rmi_f34v7_erase_config(f34);
+	if (ret < 0)
+		return ret;
+
+	if (f34->v7.has_display_cfg) {
+		f34->v7.config_area = v7_DP_CONFIG_AREA;
+		ret = rmi_f34v7_erase_config(f34);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (f34->v7.new_partition_table && f34->v7.has_guest_code) {
+		ret = rmi_f34v7_erase_guest_code(f34);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int rmi_f34v7_read_f34v7_blocks(struct f34_data *f34, u16 block_cnt,
+				       u8 command)
+{
+	int ret;
+	u8 base;
+	__le16 length;
+	u16 transfer;
+	u16 max_transfer;
+	u16 remaining = block_cnt;
+	u16 block_number = 0;
+	u16 index = 0;
+
+	base = f34->fn->fd.data_base_addr;
+
+	ret = rmi_f34v7_write_partition_id(f34, command);
+	if (ret < 0)
+		return ret;
+
+	ret = rmi_write_block(f34->fn->rmi_dev,
+			base + f34->v7.off.block_number,
+			(u8*)&block_number,
+			sizeof(block_number));
+	if (ret < 0) {
+		dev_err(&f34->fn->dev, "%s: Failed to write block number\n",
+			__func__);
+		return ret;
+	}
+
+	max_transfer = min(f34->v7.payload_length,
+			   (u16)(PAGE_SIZE / f34->v7.block_size));
+
+	do {
+		transfer = min(remaining, max_transfer);
+		put_unaligned_le16(transfer, &length);
+
+		ret = rmi_write_block(f34->fn->rmi_dev,
+				base + f34->v7.off.transfer_length,
+				&length,
+				sizeof(length));
+		if (ret < 0) {
+			dev_err(&f34->fn->dev,
+				"%s: Write transfer length fail (%d remaining)\n",
+				__func__, remaining);
+			return ret;
+		}
+
+		ret = rmi_f34v7_write_command(f34, command);
+		if (ret < 0)
+			return ret;
+
+		ret = rmi_f34v7_wait_for_idle(f34, ENABLE_WAIT_MS);
+		if (ret < 0) {
+			dev_err(&f34->fn->dev,
+				"%s: Wait for idle failed (%d blks remaining)\n",
+				__func__, remaining);
+			return ret;
+		}
+
+		ret = rmi_read_block(f34->fn->rmi_dev,
+				base + f34->v7.off.payload,
+				&f34->v7.read_config_buf[index],
+				transfer * f34->v7.block_size);
+		if (ret < 0) {
+			dev_err(&f34->fn->dev,
+				"%s: Read block failed (%d blks remaining)\n",
+				__func__, remaining);
+			return ret;
+		}
+
+		index += (transfer * f34->v7.block_size);
+		remaining -= transfer;
+	} while (remaining);
+
+	return 0;
+}
+
+static int rmi_f34v7_write_f34v7_blocks(struct f34_data *f34, u8 *block_ptr,
+					u16 block_cnt, u8 command)
+{
+	int ret;
+	u8 base;
+	__le16 length;
+	u16 transfer;
+	u16 max_transfer;
+	u16 remaining = block_cnt;
+	u16 block_number = 0;
+
+	base = f34->fn->fd.data_base_addr;
+
+	ret = rmi_f34v7_write_partition_id(f34, command);
+	if (ret < 0)
+		return ret;
+
+	ret = rmi_write_block(f34->fn->rmi_dev,
+			base + f34->v7.off.block_number,
+			(u8*)&block_number,
+			sizeof(block_number));
+	if (ret < 0) {
+		dev_err(&f34->fn->dev, "%s: Failed to write block number\n",
+			__func__);
+		return ret;
+	}
+
+	if (f34->v7.payload_length > (PAGE_SIZE / f34->v7.block_size))
+		max_transfer = PAGE_SIZE / f34->v7.block_size;
+	else
+		max_transfer = f34->v7.payload_length;
+
+	do {
+		transfer = min(remaining, max_transfer);
+		put_unaligned_le16(transfer, &length);
+
+		ret = rmi_write_block(f34->fn->rmi_dev,
+				base + f34->v7.off.transfer_length,
+				&length,
+				sizeof(length));
+		if (ret < 0) {
+			dev_err(&f34->fn->dev,
+				"%s: Write transfer length fail (%d remaining)\n",
+				__func__, remaining);
+			return ret;
+		}
+
+		ret = rmi_f34v7_write_command(f34, command);
+		if (ret < 0)
+			return ret;
+
+		ret = rmi_write_block(f34->fn->rmi_dev,
+				base + f34->v7.off.payload,
+				block_ptr,
+				transfer * f34->v7.block_size);
+		if (ret < 0) {
+			dev_err(&f34->fn->dev,
+				"%s: Failed writing data (%d blks remaining)\n",
+				__func__, remaining);
+			return ret;
+		}
+
+		ret = rmi_f34v7_wait_for_idle(f34, ENABLE_WAIT_MS);
+		if (ret < 0) {
+			dev_err(&f34->fn->dev,
+				"%s: Failed wait for idle (%d blks remaining)\n",
+				__func__, remaining);
+			return ret;
+		}
+
+		block_ptr += (transfer * f34->v7.block_size);
+		remaining -= transfer;
+	} while (remaining);
+
+	return 0;
+}
+
+static int rmi_f34v7_write_f34_blocks(struct f34_data *f34, u8 *block_ptr,
+				      u16 block_cnt, u8 cmd)
+{
+	int ret;
+
+	ret = rmi_f34v7_write_f34v7_blocks(f34, block_ptr, block_cnt, cmd);
+
+	return ret;
+}
+
+static int rmi_f34v7_write_config(struct f34_data *f34)
+{
+	return rmi_f34v7_write_f34_blocks(f34,
+			(u8 *)f34->v7.config_data,
+			f34->v7.config_block_count, v7_CMD_WRITE_CONFIG);
+}
+
+static int rmi_f34v7_write_ui_config(struct f34_data *f34)
+{
+	f34->v7.config_area = v7_UI_CONFIG_AREA;
+	f34->v7.config_data = f34->v7.img.ui_config.data;
+	f34->v7.config_size = f34->v7.img.ui_config.size;
+	f34->v7.config_block_count = f34->v7.config_size / f34->v7.block_size;
+
+	return rmi_f34v7_write_config(f34);
+}
+
+static int rmi_f34v7_write_dp_config(struct f34_data *f34)
+{
+	f34->v7.config_area = v7_DP_CONFIG_AREA;
+	f34->v7.config_data = f34->v7.img.dp_config.data;
+	f34->v7.config_size = f34->v7.img.dp_config.size;
+	f34->v7.config_block_count = f34->v7.config_size / f34->v7.block_size;
+
+	return rmi_f34v7_write_config(f34);
+}
+
+static int rmi_f34v7_write_guest_code(struct f34_data *f34)
+{
+	u16 blk_count;
+	int ret;
+
+	blk_count = f34->v7.img.guest_code.size / f34->v7.block_size;
+
+	ret = rmi_f34v7_write_f34_blocks(f34,
+				(u8 *)f34->v7.img.guest_code.data,
+				blk_count, v7_CMD_WRITE_GUEST_CODE);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int rmi_f34v7_write_flash_config(struct f34_data *f34)
+{
+	int ret;
+
+	f34->v7.config_area = v7_FLASH_CONFIG_AREA;
+	f34->v7.config_data = f34->v7.img.fl_config.data;
+	f34->v7.config_size = f34->v7.img.fl_config.size;
+	f34->v7.config_block_count = f34->v7.config_size / f34->v7.block_size;
+
+	if (f34->v7.config_block_count != f34->v7.blkcount.fl_config) {
+		dev_err(&f34->fn->dev, "%s: Flash config size mismatch\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	ret = rmi_f34v7_write_command(f34, v7_CMD_ERASE_FLASH_CONFIG);
+	if (ret < 0)
+		return ret;
+
+	rmi_dbg(RMI_DEBUG_FN, &f34->fn->dev,
+		"%s: Erase flash config command written\n", __func__);
+
+	ret = rmi_f34v7_wait_for_idle(f34, ENABLE_WAIT_MS);
+	if (ret < 0)
+		return ret;
+
+	ret = rmi_f34v7_write_config(f34);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int rmi_f34v7_write_partition_table(struct f34_data *f34)
+{
+	u16 block_count;
+	int ret;
+
+	block_count = f34->v7.blkcount.bl_config;
+	f34->v7.config_area = v7_BL_CONFIG_AREA;
+	f34->v7.config_size = f34->v7.block_size * block_count;
+	devm_kfree(&f34->fn->dev, f34->v7.read_config_buf);
+	f34->v7.read_config_buf = devm_kzalloc(&f34->fn->dev,
+					       f34->v7.config_size, GFP_KERNEL);
+	if (!f34->v7.read_config_buf) {
+		f34->v7.read_config_buf_size = 0;
+		return -ENOMEM;
+	}
+
+	f34->v7.read_config_buf_size = f34->v7.config_size;
+
+	ret = rmi_f34v7_read_f34v7_blocks(f34, block_count, v7_CMD_READ_CONFIG);
+	if (ret < 0)
+		return ret;
+
+	ret = rmi_f34v7_erase_config(f34);
+	if (ret < 0)
+		return ret;
+
+	ret = rmi_f34v7_write_flash_config(f34);
+	if (ret < 0)
+		return ret;
+
+	f34->v7.config_area = v7_BL_CONFIG_AREA;
+	f34->v7.config_data = f34->v7.read_config_buf;
+	f34->v7.config_size = f34->v7.img.bl_config.size;
+	f34->v7.config_block_count = f34->v7.config_size / f34->v7.block_size;
+
+	ret = rmi_f34v7_write_config(f34);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int rmi_f34v7_write_firmware(struct f34_data *f34)
+{
+	u16 blk_count;
+
+	blk_count = f34->v7.img.ui_firmware.size / f34->v7.block_size;
+
+	return rmi_f34v7_write_f34_blocks(f34,
+			(u8*)f34->v7.img.ui_firmware.data,
+			blk_count, v7_CMD_WRITE_FW);
+}
+
+static void rmi_f34v7_compare_partition_tables(struct f34_data *f34)
+{
+	if (f34->v7.phyaddr.ui_firmware != f34->v7.img.phyaddr.ui_firmware) {
+		f34->v7.new_partition_table = true;
+		return;
+	}
+
+	if (f34->v7.phyaddr.ui_config != f34->v7.img.phyaddr.ui_config) {
+		f34->v7.new_partition_table = true;
+		return;
+	}
+
+	if (f34->v7.has_display_cfg
+	    && f34->v7.phyaddr.dp_config != f34->v7.img.phyaddr.dp_config) {
+		f34->v7.new_partition_table = true;
+		return;
+	}
+
+	if (f34->v7.has_guest_code
+	    && f34->v7.phyaddr.guest_code != f34->v7.img.phyaddr.guest_code) {
+		f34->v7.new_partition_table = true;
+		return;
+	}
+
+	f34->v7.new_partition_table = false;
+}
+
+static void rmi_f34v7_parse_img_header_10_bl_container(struct f34_data *f34,
+						       const u8 *image)
+{
+	int i;
+	u8 num_of_containers;
+	unsigned int addr;
+	unsigned int container_id;
+	unsigned int length;
+	const u8 *content;
+	struct container_descriptor *descriptor;
+
+	BUG_ON(f34->v7.img.bootloader.size < 4);
+
+	num_of_containers = (f34->v7.img.bootloader.size - 4) / 4;
+
+	for (i = 1; i <= num_of_containers; i++) {
+		addr = le32_to_cpu(f34->v7.img.bootloader.data + (i * 4));
+		descriptor = (struct container_descriptor *)(image + addr);
+		container_id = le16_to_cpu(descriptor->container_id);
+		content = image + le32_to_cpu(descriptor->content_address);
+		length = le32_to_cpu(descriptor->content_length);
+		switch (container_id) {
+		case BL_CONFIG_CONTAINER:
+		case GLOBAL_PARAMETERS_CONTAINER:
+			f34->v7.img.bl_config.data = content;
+			f34->v7.img.bl_config.size = length;
+			break;
+		case BL_LOCKDOWN_INFO_CONTAINER:
+		case DEVICE_CONFIG_CONTAINER:
+			f34->v7.img.lockdown.data = content;
+			f34->v7.img.lockdown.size = length;
+			break;
+		default:
+			break;
+		}
+	}
+}
+
+static void rmi_f34v7_parse_image_header_10(struct f34_data *f34)
+{
+	unsigned int i;
+	unsigned int num_of_containers;
+	unsigned int addr;
+	unsigned int offset;
+	unsigned int container_id;
+	unsigned int length;
+	const u8 *image;
+	const u8 *content;
+	struct container_descriptor *descriptor;
+	struct image_header_10 *header;
+
+	image = f34->v7.image;
+	header = (struct image_header_10 *)image;
+
+	f34->v7.img.checksum = le32_to_cpu(header->checksum);
+
+	rmi_dbg(RMI_DEBUG_FN, &f34->fn->dev, "%s: f34->v7.img.checksum=%X\n",
+		__func__, f34->v7.img.checksum);
+
+	/* address of top level container */
+	offset = le32_to_cpu(header->top_level_container_start_addr);
+	descriptor = (struct container_descriptor *)(image + offset);
+
+	/* address of top level container content */
+	offset = le32_to_cpu(descriptor->content_address);
+	num_of_containers = le32_to_cpu(descriptor->content_length) / 4;
+
+	for (i = 0; i < num_of_containers; i++) {
+		addr = le32_to_cpu(get_unaligned_le32(image + offset));
+		offset += 4;
+		descriptor = (struct container_descriptor *)(image + addr);
+		container_id = le16_to_cpu(descriptor->container_id);
+		content = image + le32_to_cpu(descriptor->content_address);
+		length = le32_to_cpu(descriptor->content_length);
+
+		rmi_dbg(RMI_DEBUG_FN, &f34->fn->dev,
+			"%s: container_id=%d, length=%d\n", __func__,
+			container_id, length);
+
+		switch (container_id) {
+		case UI_CONTAINER:
+		case CORE_CODE_CONTAINER:
+			f34->v7.img.ui_firmware.data = content;
+			f34->v7.img.ui_firmware.size = length;
+			break;
+		case UI_CONFIG_CONTAINER:
+		case CORE_CONFIG_CONTAINER:
+			f34->v7.img.ui_config.data = content;
+			f34->v7.img.ui_config.size = length;
+			break;
+		case BL_CONTAINER:
+			f34->v7.img.bl_version = *content;
+			f34->v7.img.bootloader.data = content;
+			f34->v7.img.bootloader.size = length;
+			rmi_f34v7_parse_img_header_10_bl_container(f34, image);
+			break;
+		case GUEST_CODE_CONTAINER:
+			f34->v7.img.contains_guest_code = true;
+			f34->v7.img.guest_code.data = content;
+			f34->v7.img.guest_code.size = length;
+			break;
+		case DISPLAY_CONFIG_CONTAINER:
+			f34->v7.img.contains_display_cfg = true;
+			f34->v7.img.dp_config.data = content;
+			f34->v7.img.dp_config.size = length;
+			break;
+		case FLASH_CONFIG_CONTAINER:
+			f34->v7.img.contains_flash_config = true;
+			f34->v7.img.fl_config.data = content;
+			f34->v7.img.fl_config.size = length;
+			break;
+		case GENERAL_INFORMATION_CONTAINER:
+			f34->v7.img.contains_firmware_id = true;
+			f34->v7.img.firmware_id =
+				le32_to_cpu(get_unaligned_le32(content + 4));
+			break;
+		default:
+			break;
+		}
+	}
+}
+
+static int rmi_f34v7_parse_image_info(struct f34_data *f34)
+{
+	struct image_header_10 *header;
+
+	header = (struct image_header_10 *)f34->v7.image;
+
+	memset(&f34->v7.img, 0x00, sizeof(f34->v7.img));
+
+	rmi_dbg(RMI_DEBUG_FN, &f34->fn->dev,
+		"%s: header->major_header_version = %d\n",
+		__func__, header->major_header_version);
+
+	switch (header->major_header_version) {
+	case IMAGE_HEADER_VERSION_10:
+		rmi_f34v7_parse_image_header_10(f34);
+		break;
+	default:
+		dev_err(&f34->fn->dev, "Unsupported image file format %02X\n",
+			header->major_header_version);
+		return -EINVAL;
+	}
+
+	if (!f34->v7.img.contains_flash_config) {
+		dev_err(&f34->fn->dev, "%s: No flash config in fw image\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	rmi_f34v7_parse_partition_table(f34, f34->v7.img.fl_config.data,
+			&f34->v7.img.blkcount, &f34->v7.img.phyaddr);
+
+	rmi_f34v7_compare_partition_tables(f34);
+
+	return 0;
+}
+
+int rmi_f34v7_do_reflash(struct f34_data *f34, const struct firmware *fw)
+{
+	int ret;
+
+	rmi_f34v7_read_queries_bl_version(f34);
+
+	f34->v7.image = fw->data;
+
+	ret = rmi_f34v7_parse_image_info(f34);
+	if (ret < 0)
+		goto fail;
+
+	if (!f34->v7.new_partition_table) {
+		ret = rmi_f34v7_check_ui_firmware_size(f34);
+		if (ret < 0)
+			goto fail;
+
+		ret = rmi_f34v7_check_ui_config_size(f34);
+		if (ret < 0)
+			goto fail;
+
+		if (f34->v7.has_display_cfg &&
+		    f34->v7.img.contains_display_cfg) {
+			ret = rmi_f34v7_check_dp_config_size(f34);
+			if (ret < 0)
+				goto fail;
+		}
+
+		if (f34->v7.has_guest_code && f34->v7.img.contains_guest_code) {
+			ret = rmi_f34v7_check_guest_code_size(f34);
+			if (ret < 0)
+				goto fail;
+		}
+	} else {
+		ret = rmi_f34v7_check_bl_config_size(f34);
+		if (ret < 0)
+			goto fail;
+	}
+
+	ret = rmi_f34v7_erase_all(f34);
+	if (ret < 0)
+		goto fail;
+
+	if (f34->v7.new_partition_table) {
+		ret = rmi_f34v7_write_partition_table(f34);
+		if (ret < 0)
+			goto fail;
+		dev_info(&f34->fn->dev, "%s: Partition table programmed\n",
+			 __func__);
+	}
+
+	dev_info(&f34->fn->dev, "Writing firmware (%d bytes)...\n",
+		 f34->v7.img.ui_firmware.size);
+
+	ret = rmi_f34v7_write_firmware(f34);
+	if (ret < 0)
+		goto fail;
+
+	dev_info(&f34->fn->dev, "Writing config (%d bytes)...\n",
+		 f34->v7.img.ui_config.size);
+
+	f34->v7.config_area = v7_UI_CONFIG_AREA;
+	ret = rmi_f34v7_write_ui_config(f34);
+	if (ret < 0)
+		goto fail;
+
+	if (f34->v7.has_display_cfg && f34->v7.img.contains_display_cfg) {
+		dev_info(&f34->fn->dev, "Writing display config...\n");
+
+		ret = rmi_f34v7_write_dp_config(f34);
+		if (ret < 0)
+			goto fail;
+	}
+
+	if (f34->v7.new_partition_table) {
+		if (f34->v7.has_guest_code && f34->v7.img.contains_guest_code) {
+			dev_info(&f34->fn->dev, "Writing guest code...\n");
+
+			ret = rmi_f34v7_write_guest_code(f34);
+			if (ret < 0)
+				goto fail;
+		}
+	}
+
+fail:
+	return ret;
+}
+
+static int rmi_f34v7_enter_flash_prog(struct f34_data *f34)
+{
+	int ret;
+
+	ret = rmi_f34v7_read_flash_status(f34);
+	if (ret < 0)
+		return ret;
+
+	if (f34->v7.in_bl_mode)
+		return 0;
+
+	ret = rmi_f34v7_write_command(f34, v7_CMD_ENABLE_FLASH_PROG);
+	if (ret < 0)
+		return ret;
+
+	ret = rmi_f34v7_wait_for_idle(f34, ENABLE_WAIT_MS);
+	if (ret < 0)
+		return ret;
+
+	if (!f34->v7.in_bl_mode) {
+		dev_err(&f34->fn->dev, "%s: BL mode not entered\n", __func__);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int rmi_f34v7_start_reflash(struct f34_data *f34, const struct firmware *fw)
+{
+	int ret = 0;
+
+	f34->v7.config_area = v7_UI_CONFIG_AREA;
+	f34->v7.image = fw->data;
+
+	ret = rmi_f34v7_parse_image_info(f34);
+	if (ret < 0)
+		goto exit;
+
+	if (!f34->v7.force_update && f34->v7.new_partition_table) {
+		dev_err(&f34->fn->dev, "%s: Partition table mismatch\n",
+				__func__);
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	dev_info(&f34->fn->dev, "Firmware image OK\n");
+
+	ret = rmi_f34v7_read_flash_status(f34);
+	if (ret < 0)
+		goto exit;
+
+	if (f34->v7.in_bl_mode) {
+		dev_info(&f34->fn->dev, "%s: Device in bootloader mode\n",
+				__func__);
+	}
+
+	rmi_f34v7_enter_flash_prog(f34);
+
+	return 0;
+
+exit:
+	return ret;
+}
+
+int rmi_f34v7_probe(struct f34_data *f34)
+{
+	int ret;
+
+	/* Read bootloader version */
+	ret = rmi_read_block(f34->fn->rmi_dev,
+			f34->fn->fd.query_base_addr + V7_BOOTLOADER_ID_OFFSET,
+			f34->bootloader_id,
+			sizeof(f34->bootloader_id));
+	if (ret < 0) {
+		dev_err(&f34->fn->dev, "%s: Failed to read bootloader ID\n",
+			__func__);
+		return ret;
+	}
+
+	if (f34->bootloader_id[1] == '5') {
+		f34->bl_version = 5;
+	} else if (f34->bootloader_id[1] == '6') {
+		f34->bl_version = 6;
+	} else if (f34->bootloader_id[1] == 7) {
+		f34->bl_version = 7;
+	} else {
+		dev_err(&f34->fn->dev, "%s: Unrecognized bootloader version\n",
+				__func__);
+		return -EINVAL;
+	}
+
+	memset(&f34->v7.blkcount, 0x00, sizeof(f34->v7.blkcount));
+	memset(&f34->v7.phyaddr, 0x00, sizeof(f34->v7.phyaddr));
+	rmi_f34v7_read_queries(f34);
+
+	f34->v7.force_update = false;
+	return 0;
+}
diff --git a/include/linux/rmi.h b/include/linux/rmi.h
index ac910f7..64125443 100644
--- a/include/linux/rmi.h
+++ b/include/linux/rmi.h
@@ -342,7 +342,7 @@ struct rmi_driver_data {
 
 	struct rmi_function *f01_container;
 	struct rmi_function *f34_container;
-	bool f01_bootloader_mode;
+	bool bootloader_mode;
 
 	int num_of_irq_regs;
 	int irq_count;
-- 
2.7.4


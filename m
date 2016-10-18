From: Nick Dyer <nick@shmanahar.org>
Subject: [PATCH v4 4/7] Input: synaptics-rmi4 - add support for F34 V7 bootloader
Date: Wed, 19 Oct 2016 00:26:05 +0100
Message-ID: <1476833168-12880-4-git-send-email-nick@shmanahar.org>
References: <1476833168-12880-1-git-send-email-nick@shmanahar.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avasout06.plus.net ([212.159.14.18]:46809 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756201AbcJRX0Q (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 18 Oct 2016 19:26:16 -0400
In-Reply-To: <1476833168-12880-1-git-send-email-nick@shmanahar.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>
Cc: Chris Healy <cphealy@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Nick Dyer <nick@shmanahar.org>

Port firmware update code from Samsung Galaxy S7 driver into
mainline framework.

This patch has been tested on Synaptics S7813.

Signed-off-by: Nick Dyer <nick@shmanahar.org>
---
 drivers/input/rmi4/Makefile     |    2 +-
 drivers/input/rmi4/rmi_driver.c |   56 +-
 drivers/input/rmi4/rmi_f34.c    |  146 ++--
 drivers/input/rmi4/rmi_f34.h    |  379 +++++++++-
 drivers/input/rmi4/rmi_f34v7.c  | 1451 +++++++++++++++++++++++++++++++++++++++
 include/linux/rmi.h             |    2 +-
 6 files changed, 1940 insertions(+), 96 deletions(-)
 create mode 100644 drivers/input/rmi4/rmi_f34v7.c

diff --git a/drivers/input/rmi4/Makefile b/drivers/input/rmi4/Makefile
index 5f165ad..a74b6d5 100644
--- a/drivers/input/rmi4/Makefile
+++ b/drivers/input/rmi4/Makefile
@@ -7,7 +7,7 @@ rmi_core-$(CONFIG_RMI4_2D_SENSOR) += rmi_2d_sensor.o
 rmi_core-$(CONFIG_RMI4_F11) += rmi_f11.o
 rmi_core-$(CONFIG_RMI4_F12) += rmi_f12.o
 rmi_core-$(CONFIG_RMI4_F30) += rmi_f30.o
-rmi_core-$(CONFIG_RMI4_F34) += rmi_f34.o
+rmi_core-$(CONFIG_RMI4_F34) += rmi_f34.o rmi_f34v7.o
 rmi_core-$(CONFIG_RMI4_F54) += rmi_f54.o
 
 # Transports
diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 78fdcef..a9e2827 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -473,7 +473,7 @@ static int rmi_scan_pdt_page(struct rmi_device *rmi_dev,
 			return retval;
 	}
 
-	return (data->f01_bootloader_mode || addr == pdt_start) ?
+	return (data->bootloader_mode || addr == pdt_start) ?
 					RMI_SCAN_DONE : RMI_SCAN_CONTINUE;
 }
 
@@ -681,41 +681,49 @@ bool rmi_register_desc_has_subpacket(const struct rmi_register_desc_item *item,
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
@@ -884,13 +892,15 @@ int rmi_probe_interrupts(struct rmi_driver_data *data)
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
index 9e4cf34..4f97613 100644
--- a/drivers/input/rmi4/rmi_f34.c
+++ b/drivers/input/rmi4/rmi_f34.c
@@ -12,6 +12,7 @@
 #include <linux/firmware.h>
 #include <asm/unaligned.h>
 #include <asm/unaligned.h>
+#include <linux/bitops.h>
 
 #include "rmi_driver.h"
 #include "rmi_f34.h"
@@ -58,9 +59,9 @@ static int rmi_f34_command(struct f34_data *f34, u8 command,
 			return ret;
 	}
 
-	init_completion(&f34->cmd_done);
+	init_completion(&f34->v5.cmd_done);
 
-	ret = rmi_read(rmi_dev, f34->ctrl_address, &f34->status);
+	ret = rmi_read(rmi_dev, f34->v5.ctrl_address, &f34->v5.status);
 	if (ret) {
 		dev_err(&f34->fn->dev,
 			"%s: Failed to read cmd register: %d (command %#02x)\n",
@@ -68,9 +69,9 @@ static int rmi_f34_command(struct f34_data *f34, u8 command,
 		return ret;
 	}
 
-	f34->status |= command & 0x0f;
+	f34->v5.status |= command & 0x0f;
 
-	ret = rmi_write(rmi_dev, f34->ctrl_address, f34->status);
+	ret = rmi_write(rmi_dev, f34->v5.ctrl_address, f34->v5.status);
 	if (ret < 0) {
 		dev_err(&f34->fn->dev,
 			"Failed to write F34 command %#02x: %d\n",
@@ -78,10 +79,10 @@ static int rmi_f34_command(struct f34_data *f34, u8 command,
 		return ret;
 	}
 
-	if (!wait_for_completion_timeout(&f34->cmd_done,
+	if (!wait_for_completion_timeout(&f34->v5.cmd_done,
 				msecs_to_jiffies(timeout))) {
 
-		ret = rmi_read(rmi_dev, f34->ctrl_address, &f34->status);
+		ret = rmi_read(rmi_dev, f34->v5.ctrl_address, &f34->v5.status);
 		if (ret) {
 			dev_err(&f34->fn->dev,
 				"%s: cmd %#02x timed out: %d\n",
@@ -89,10 +90,10 @@ static int rmi_f34_command(struct f34_data *f34, u8 command,
 			return ret;
 		}
 
-		if (f34->status & 0x7f) {
+		if (f34->v5.status & 0x7f) {
 			dev_err(&f34->fn->dev,
 				"%s: cmd %#02x timed out, status: %#02x\n",
-				__func__, command, f34->status);
+				__func__, command, f34->v5.status);
 			return -ETIMEDOUT;
 		}
 	}
@@ -105,12 +106,15 @@ static int rmi_f34_attention(struct rmi_function *fn, unsigned long *irq_bits)
 	struct f34_data *f34 = dev_get_drvdata(&fn->dev);
 	int ret;
 
-	ret = rmi_read(f34->fn->rmi_dev, f34->ctrl_address, &f34->status);
+	if (f34->bl_version != BL_V5)
+		return 0;
+
+	ret = rmi_read(f34->fn->rmi_dev, f34->v5.ctrl_address, &f34->v5.status);
 	rmi_dbg(RMI_DEBUG_FN, &fn->dev, "%s: status: %#02x, ret: %d\n",
-		__func__, f34->status, ret);
+		__func__, f34->v5.status, ret);
 
-	if (!ret && !(f34->status & 0x7f))
-		complete(&f34->cmd_done);
+	if (!ret && !(f34->v5.status & 0x7f))
+		complete(&f34->v5.cmd_done);
 
 	return 0;
 }
@@ -133,7 +137,7 @@ static int rmi_f34_write_blocks(struct f34_data *f34, const void *data,
 	}
 
 	for (i = 0; i < block_count; i++) {
-		ret = rmi_write_block(rmi_dev, address, data, f34->block_size);
+		ret = rmi_write_block(rmi_dev, address, data, f34->v5.block_size);
 		if (ret) {
 			dev_err(&fn->dev,
 				"failed to write block #%d: %d\n", i, ret);
@@ -151,7 +155,7 @@ static int rmi_f34_write_blocks(struct f34_data *f34, const void *data,
 		rmi_dbg(RMI_DEBUG_FN, &fn->dev, "wrote block %d of %d\n",
 			i + 1, block_count);
 
-		data += f34->block_size;
+		data += f34->v5.block_size;
 	}
 
 	return 0;
@@ -159,26 +163,24 @@ static int rmi_f34_write_blocks(struct f34_data *f34, const void *data,
 
 static int rmi_f34_write_firmware(struct f34_data *f34, const void *data)
 {
-	return rmi_f34_write_blocks(f34, data, f34->fw_blocks,
+	return rmi_f34_write_blocks(f34, data, f34->v5.fw_blocks,
 				    F34_WRITE_FW_BLOCK);
 }
 
 static int rmi_f34_write_config(struct f34_data *f34, const void *data)
 {
-	return rmi_f34_write_blocks(f34, data, f34->config_blocks,
+	return rmi_f34_write_blocks(f34, data, f34->v5.config_blocks,
 				    F34_WRITE_CONFIG_BLOCK);
 }
 
-int rmi_f34_enable_flash(struct rmi_function *fn)
+int rmi_f34_enable_flash(struct f34_data *f34)
 {
-	struct f34_data *f34 = dev_get_drvdata(&fn->dev);
-
 	return rmi_f34_command(f34, F34_ENABLE_FLASH_PROG,
 			       F34_ENABLE_WAIT_MS, true);
 }
 
 static int rmi_f34_flash_firmware(struct f34_data *f34,
-					 const struct rmi_f34_firmware *syn_fw)
+				  const struct rmi_f34_firmware *syn_fw)
 {
 	struct rmi_function *fn = f34->fn;
 	int ret;
@@ -221,9 +223,8 @@ static int rmi_f34_flash_firmware(struct f34_data *f34,
 	return 0;
 }
 
-int rmi_f34_update_firmware(struct rmi_function *fn, const struct firmware *fw)
+int rmi_f34_update_firmware(struct f34_data *f34, const struct firmware *fw)
 {
-	struct f34_data *f34 = dev_get_drvdata(&fn->dev);
 	const struct rmi_f34_firmware *syn_fw;
 	int ret;
 
@@ -231,72 +232,61 @@ int rmi_f34_update_firmware(struct rmi_function *fn, const struct firmware *fw)
 	BUILD_BUG_ON(offsetof(struct rmi_f34_firmware, data) !=
 			F34_FW_IMAGE_OFFSET);
 
-	rmi_dbg(RMI_DEBUG_FN, &fn->dev,
+	rmi_dbg(RMI_DEBUG_FN, &f34->fn->dev,
 		"FW size:%d, checksum:%08x, image_size:%d, config_size:%d\n",
 		(int)fw->size,
 		le32_to_cpu(syn_fw->checksum),
 		le32_to_cpu(syn_fw->image_size),
 		le32_to_cpu(syn_fw->config_size));
 
-	rmi_dbg(RMI_DEBUG_FN, &fn->dev,
+	rmi_dbg(RMI_DEBUG_FN, &f34->fn->dev,
 		"FW bootloader_id:%02x, product_id:%.*s, info: %02x%02x\n",
 		syn_fw->bootloader_version,
 		(int)sizeof(syn_fw->product_id), syn_fw->product_id,
 		syn_fw->product_info[0], syn_fw->product_info[1]);
 
 	if (syn_fw->image_size &&
-	    syn_fw->image_size != f34->fw_blocks * f34->block_size) {
-		dev_err(&fn->dev,
+	    syn_fw->image_size != f34->v5.fw_blocks * f34->v5.block_size) {
+		dev_err(&f34->fn->dev,
 			"Bad firmware image: fw size %d, expected %d\n",
 			syn_fw->image_size,
-			f34->fw_blocks * f34->block_size);
+			f34->v5.fw_blocks * f34->v5.block_size);
 		ret = -EILSEQ;
 		goto out;
 	}
 
 	if (syn_fw->config_size &&
-	    syn_fw->config_size != f34->config_blocks * f34->block_size) {
-		dev_err(&fn->dev,
+	    syn_fw->config_size != f34->v5.config_blocks * f34->v5.block_size) {
+		dev_err(&f34->fn->dev,
 			"Bad firmware image: config size %d, expected %d\n",
 			syn_fw->config_size,
-			f34->config_blocks * f34->block_size);
+			f34->v5.config_blocks * f34->v5.block_size);
 		ret = -EILSEQ;
 		goto out;
 	}
 
 	if (syn_fw->image_size && !syn_fw->config_size) {
-		dev_err(&fn->dev, "Bad firmware image: no config data\n");
+		dev_err(&f34->fn->dev, "Bad firmware image: no config data\n");
 		ret = -EILSEQ;
 		goto out;
 	}
 
 	dev_info(&f34->fn->dev, "Firmware image OK\n");
-	mutex_lock(&f34->flash_mutex);
+	mutex_lock(&f34->v5.flash_mutex);
 
 	ret = rmi_f34_flash_firmware(f34, syn_fw);
 
-	mutex_unlock(&f34->flash_mutex);
+	mutex_unlock(&f34->v5.flash_mutex);
 
 out:
 	return ret;
 }
 
-int rmi_f34_check_supported(struct rmi_function *fn)
-{
-	u8 version = fn->fd.function_version;
-
-	/* Only version 0 currently supported */
-	if (version == 0)
-		return 0;
-
-	dev_warn(&fn->dev, "F34 V%d not supported!\n", version);
-	return -ENODEV;
-}
-
 static int rmi_firmware_update(struct rmi_driver_data *data,
 			       const struct firmware *fw)
 {
 	struct device *dev = &data->rmi_dev->dev;
+	struct f34_data *f34;
 	int ret;
 
 	if (!data->f34_container) {
@@ -304,13 +294,23 @@ static int rmi_firmware_update(struct rmi_driver_data *data,
 		return -EINVAL;
 	}
 
-	ret = rmi_f34_check_supported(data->f34_container);
-	if (ret)
-		return ret;
+	f34 = dev_get_drvdata(&data->f34_container->dev);
+
+	if (f34->bl_version == BL_V7) {
+		if (data->pdt_props & HAS_BSR) {
+			dev_err(dev, "%s: LTS not supported\n", __func__);
+			return -ENODEV;
+		}
+	} else if (data->f34_container->fd.function_version != 0) {
+		dev_err(dev, "%s: Version not supported\n", __func__);
+		return -ENODEV;
+	}
 
 	/* Enter flash mode */
-	rmi_dbg(RMI_DEBUG_FN, dev, "Enabling flash\n");
-	ret = rmi_f34_enable_flash(data->f34_container);
+	if (f34->bl_version == BL_V7)
+		ret = rmi_f34v7_start_reflash(f34, fw);
+	else
+		ret = rmi_f34_enable_flash(f34);
 	if (ret)
 		return ret;
 
@@ -325,14 +325,21 @@ static int rmi_firmware_update(struct rmi_driver_data *data,
 	if (ret)
 		return ret;
 
-	if (!data->f01_bootloader_mode || !data->f34_container) {
+	if (!data->bootloader_mode || !data->f34_container) {
 		dev_warn(dev, "%s: No F34 present or not in bootloader!\n",
-			 __func__);
+				__func__);
 		return -EINVAL;
 	}
 
+	f34 = dev_get_drvdata(&data->f34_container->dev);
+
 	/* Perform firmware update */
-	ret = rmi_f34_update_firmware(data->f34_container, fw);
+	if (f34->bl_version == BL_V7)
+		ret = rmi_f34v7_do_reflash(f34, fw);
+	else
+		ret = rmi_f34_update_firmware(f34, fw);
+
+	dev_info(&f34->fn->dev, "Firmware update complete, status:%d\n", ret);
 
 	/* Re-probe */
 	rmi_dbg(RMI_DEBUG_FN, dev, "Re-probing device\n");
@@ -407,12 +414,9 @@ static int rmi_f34_probe(struct rmi_function *fn)
 	struct f34_data *f34;
 	unsigned char f34_queries[9];
 	bool has_config_id;
+	u8 version = fn->fd.function_version;
 	int ret;
 
-	ret = rmi_f34_check_supported(fn);
-	if (ret)
-		return ret;
-
 	f34 = devm_kzalloc(&fn->dev, sizeof(struct f34_data), GFP_KERNEL);
 	if (!f34)
 		return -ENOMEM;
@@ -420,31 +424,37 @@ static int rmi_f34_probe(struct rmi_function *fn)
 	f34->fn = fn;
 	dev_set_drvdata(&fn->dev, f34);
 
-	mutex_init(&f34->flash_mutex);
-	init_completion(&f34->cmd_done);
+	/* v5 code only supported version 0, try V7 probe */
+	if (version > 0)
+		return rmi_f34v7_probe(f34);
+
+	f34->bl_version = BL_V5;
 
 	ret = rmi_read_block(fn->rmi_dev, fn->fd.query_base_addr,
 			     f34_queries, sizeof(f34_queries));
 	if (ret) {
 		dev_err(&fn->dev, "%s: Failed to query properties\n",
-				__func__);
+			__func__);
 		return ret;
 	}
 
 	snprintf(f34->bootloader_id, sizeof(f34->bootloader_id),
 		 "%c%c", f34_queries[0], f34_queries[1]);
 
-	f34->block_size = get_unaligned_le16(&f34_queries[3]);
-	f34->fw_blocks = get_unaligned_le16(&f34_queries[5]);
-	f34->config_blocks = get_unaligned_le16(&f34_queries[7]);
-	f34->ctrl_address = fn->fd.data_base_addr + F34_BLOCK_DATA_OFFSET +
-		f34->block_size;
+	mutex_init(&f34->v5.flash_mutex);
+	init_completion(&f34->v5.cmd_done);
+
+	f34->v5.block_size = get_unaligned_le16(&f34_queries[3]);
+	f34->v5.fw_blocks = get_unaligned_le16(&f34_queries[5]);
+	f34->v5.config_blocks = get_unaligned_le16(&f34_queries[7]);
+	f34->v5.ctrl_address = fn->fd.data_base_addr + F34_BLOCK_DATA_OFFSET +
+		f34->v5.block_size;
 	has_config_id = f34_queries[2] & (1 << 2);
 
 	rmi_dbg(RMI_DEBUG_FN, &fn->dev, "Bootloader ID: %s\n", f34->bootloader_id);
-	rmi_dbg(RMI_DEBUG_FN, &fn->dev, "Block size: %d\n", f34->block_size);
-	rmi_dbg(RMI_DEBUG_FN, &fn->dev, "FW blocks: %d\n", f34->fw_blocks);
-	rmi_dbg(RMI_DEBUG_FN, &fn->dev, "CFG blocks: %d\n", f34->config_blocks);
+	rmi_dbg(RMI_DEBUG_FN, &fn->dev, "Block size: %d\n", f34->v5.block_size);
+	rmi_dbg(RMI_DEBUG_FN, &fn->dev, "FW blocks: %d\n", f34->v5.fw_blocks);
+	rmi_dbg(RMI_DEBUG_FN, &fn->dev, "CFG blocks: %d\n", f34->v5.config_blocks);
 
 	if (has_config_id) {
 		ret = rmi_read_block(fn->rmi_dev, fn->fd.control_base_addr,
diff --git a/drivers/input/rmi4/rmi_f34.h b/drivers/input/rmi4/rmi_f34.h
index 0c19a58..9ab8ece 100644
--- a/drivers/input/rmi4/rmi_f34.h
+++ b/drivers/input/rmi4/rmi_f34.h
@@ -33,6 +33,317 @@
 
 #define F34_BOOTLOADER_ID_LEN	2
 
+#define V7_FLASH_STATUS_OFFSET 0
+#define V7_PARTITION_ID_OFFSET 1
+#define V7_BLOCK_NUMBER_OFFSET 2
+#define V7_TRANSFER_LENGTH_OFFSET 3
+#define V7_COMMAND_OFFSET 4
+#define V7_PAYLOAD_OFFSET 5
+#define BOOTLOADER_ID_OFFSET 1
+
+#define V7_PARTITION_SUPPORT_BYTES 4
+
+#define SLEEP_MODE_NORMAL (0x00)
+
+#define IMAGE_HEADER_VERSION_10 0x10
+
+#define MAX_IMAGE_NAME_LEN 256
+#define SYNAPTICS_RMI4_PRODUCT_ID_SIZE 10
+#define PRODUCT_ID_SIZE 10
+
+#define MASK_8BIT 0xFF
+#define MASK_5BIT 0x1F
+
+#define ENABLE_WAIT_MS (1 * 1000)
+#define WRITE_WAIT_MS (3 * 1000)
+#define ERASE_WAIT_MS (5 * 1000)
+
+#define MIN_SLEEP_TIME_US 50
+#define MAX_SLEEP_TIME_US 100
+
+#define FORCE_UPDATE false
+
+#define HAS_BSR BIT(5)
+
+enum rmi_f34_bl_version {
+	BL_V5 = 5,
+	BL_V6 = 6,
+	BL_V7 = 7,
+};
+
+enum rmi_f34v7_flash_command2 {
+	CMD_V7_IDLE = 0x00,
+	CMD_V7_ENTER_BL,
+	CMD_V7_READ,
+	CMD_V7_WRITE,
+	CMD_V7_ERASE,
+	CMD_V7_ERASE_AP,
+	CMD_V7_SENSOR_ID,
+};
+
+enum rmi_f34v7_flash_command {
+	v7_CMD_IDLE = 0,
+	v7_CMD_WRITE_FW,
+	v7_CMD_WRITE_CONFIG,
+	v7_CMD_WRITE_LOCKDOWN,
+	v7_CMD_WRITE_GUEST_CODE,
+	v7_CMD_READ_CONFIG,
+	v7_CMD_ERASE_ALL,
+	v7_CMD_ERASE_UI_FIRMWARE,
+	v7_CMD_ERASE_UI_CONFIG,
+	v7_CMD_ERASE_BL_CONFIG,
+	v7_CMD_ERASE_DISP_CONFIG,
+	v7_CMD_ERASE_FLASH_CONFIG,
+	v7_CMD_ERASE_GUEST_CODE,
+	v7_CMD_ENABLE_FLASH_PROG,
+};
+
+enum rmi_f34v7_config_area {
+	v7_UI_CONFIG_AREA = 0,
+	v7_PM_CONFIG_AREA,
+	v7_BL_CONFIG_AREA,
+	v7_DP_CONFIG_AREA,
+	v7_FLASH_CONFIG_AREA,
+};
+
+enum rmi_f34v7_partition_id {
+	BOOTLOADER_PARTITION = 0x01,
+	DEVICE_CONFIG_PARTITION,
+	FLASH_CONFIG_PARTITION,
+	MANUFACTURING_BLOCK_PARTITION,
+	GUEST_SERIALIZATION_PARTITION,
+	GLOBAL_PARAMETERS_PARTITION,
+	CORE_CODE_PARTITION,
+	CORE_CONFIG_PARTITION,
+	GUEST_CODE_PARTITION,
+	DISPLAY_CONFIG_PARTITION,
+};
+
+struct f34v7_query_0 {
+	union {
+		struct {
+			unsigned char subpacket_1_size:3;
+			unsigned char has_config_id:1;
+			unsigned char f34_query0_b4:1;
+			unsigned char has_thqa:1;
+			unsigned char f34_query0_b6__7:2;
+		} __packed;
+		unsigned char data[1];
+	};
+};
+
+struct synaptics_rmi4_f34_query_01 {
+	union {
+		struct {
+			unsigned char reg_map:1;
+			unsigned char unlocked:1;
+			unsigned char has_config_id:1;
+			unsigned char has_perm_config:1;
+			unsigned char has_bl_config:1;
+			unsigned char has_disp_config:1;
+			unsigned char has_ctrl1:1;
+			unsigned char has_flash_query4:1;
+		} __packed;
+		unsigned char data[1];
+	};
+};
+
+struct f34v7_query_1_7 {
+	union {
+		struct {
+			/* query 1 */
+			unsigned char bl_minor_revision;
+			unsigned char bl_major_revision;
+
+			/* query 2 */
+			unsigned char bl_fw_id_7_0;
+			unsigned char bl_fw_id_15_8;
+			unsigned char bl_fw_id_23_16;
+			unsigned char bl_fw_id_31_24;
+
+			/* query 3 */
+			unsigned char minimum_write_size;
+			unsigned char block_size_7_0;
+			unsigned char block_size_15_8;
+			unsigned char flash_page_size_7_0;
+			unsigned char flash_page_size_15_8;
+
+			/* query 4 */
+			unsigned char adjustable_partition_area_size_7_0;
+			unsigned char adjustable_partition_area_size_15_8;
+
+			/* query 5 */
+			unsigned char flash_config_length_7_0;
+			unsigned char flash_config_length_15_8;
+
+			/* query 6 */
+			unsigned char payload_length_7_0;
+			unsigned char payload_length_15_8;
+
+			/* query 7 */
+			unsigned char f34_query7_b0:1;
+			unsigned char has_bootloader:1;
+			unsigned char has_device_config:1;
+			unsigned char has_flash_config:1;
+			unsigned char has_manufacturing_block:1;
+			unsigned char has_guest_serialization:1;
+			unsigned char has_global_parameters:1;
+			unsigned char has_core_code:1;
+			unsigned char has_core_config:1;
+			unsigned char has_guest_code:1;
+			unsigned char has_display_config:1;
+			unsigned char f34_query7_b11__15:5;
+			unsigned char f34_query7_b16__23;
+			unsigned char f34_query7_b24__31;
+		} __packed;
+		unsigned char data[21];
+	};
+};
+
+struct f34v7_data_1_5 {
+	union {
+		struct {
+			unsigned char partition_id:5;
+			unsigned char f34_data1_b5__7:3;
+			unsigned char block_offset_7_0;
+			unsigned char block_offset_15_8;
+			unsigned char transfer_length_7_0;
+			unsigned char transfer_length_15_8;
+			unsigned char command;
+			unsigned char payload_0;
+			unsigned char payload_1;
+		} __packed;
+		unsigned char data[8];
+	};
+};
+
+struct block_data {
+	const unsigned char *data;
+	int size;
+};
+
+struct partition_table {
+	unsigned char partition_id:5;
+	unsigned char byte_0_reserved:3;
+	unsigned char byte_1_reserved;
+	unsigned char partition_length_7_0;
+	unsigned char partition_length_15_8;
+	unsigned char start_physical_address_7_0;
+	unsigned char start_physical_address_15_8;
+	unsigned char partition_properties_7_0;
+	unsigned char partition_properties_15_8;
+} __packed;
+
+struct physical_address {
+	unsigned short ui_firmware;
+	unsigned short ui_config;
+	unsigned short dp_config;
+	unsigned short guest_code;
+};
+
+struct container_descriptor {
+	unsigned char content_checksum[4];
+	unsigned char container_id[2];
+	unsigned char minor_version;
+	unsigned char major_version;
+	unsigned char reserved_08;
+	unsigned char reserved_09;
+	unsigned char reserved_0a;
+	unsigned char reserved_0b;
+	unsigned char container_option_flags[4];
+	unsigned char content_options_length[4];
+	unsigned char content_options_address[4];
+	unsigned char content_length[4];
+	unsigned char content_address[4];
+};
+
+enum container_id {
+	TOP_LEVEL_CONTAINER = 0,
+	UI_CONTAINER,
+	UI_CONFIG_CONTAINER,
+	BL_CONTAINER,
+	BL_IMAGE_CONTAINER,
+	BL_CONFIG_CONTAINER,
+	BL_LOCKDOWN_INFO_CONTAINER,
+	PERMANENT_CONFIG_CONTAINER,
+	GUEST_CODE_CONTAINER,
+	BL_PROTOCOL_DESCRIPTOR_CONTAINER,
+	UI_PROTOCOL_DESCRIPTOR_CONTAINER,
+	RMI_SELF_DISCOVERY_CONTAINER,
+	RMI_PAGE_CONTENT_CONTAINER,
+	GENERAL_INFORMATION_CONTAINER,
+	DEVICE_CONFIG_CONTAINER,
+	FLASH_CONFIG_CONTAINER,
+	GUEST_SERIALIZATION_CONTAINER,
+	GLOBAL_PARAMETERS_CONTAINER,
+	CORE_CODE_CONTAINER,
+	CORE_CONFIG_CONTAINER,
+	DISPLAY_CONFIG_CONTAINER,
+};
+
+struct block_count {
+	unsigned short ui_firmware;
+	unsigned short ui_config;
+	unsigned short dp_config;
+	unsigned short fl_config;
+	unsigned short pm_config;
+	unsigned short bl_config;
+	unsigned short lockdown;
+	unsigned short guest_code;
+};
+
+struct image_header_10 {
+	unsigned char checksum[4];
+	unsigned char reserved_04;
+	unsigned char reserved_05;
+	unsigned char minor_header_version;
+	unsigned char major_header_version;
+	unsigned char reserved_08;
+	unsigned char reserved_09;
+	unsigned char reserved_0a;
+	unsigned char reserved_0b;
+	unsigned char top_level_container_start_addr[4];
+};
+
+struct image_metadata {
+	bool contains_firmware_id;
+	bool contains_bootloader;
+	bool contains_disp_config;
+	bool contains_guest_code;
+	bool contains_flash_config;
+	unsigned int firmware_id;
+	unsigned int checksum;
+	unsigned int bootloader_size;
+	unsigned int disp_config_offset;
+	unsigned char bl_version;
+	unsigned char product_id[PRODUCT_ID_SIZE + 1];
+	unsigned char cstmr_product_id[PRODUCT_ID_SIZE + 1];
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
+	unsigned char properties;
+	unsigned char properties_2;
+	unsigned char block_size;
+	unsigned char block_count;
+	unsigned char gc_block_count;
+	unsigned char flash_status;
+	unsigned char partition_id;
+	unsigned char block_number;
+	unsigned char transfer_length;
+	unsigned char flash_cmd;
+	unsigned char payload;
+};
+
 struct rmi_f34_firmware {
 	__le32 checksum;
 	u8 pad1[3];
@@ -45,9 +356,7 @@ struct rmi_f34_firmware {
 	u8 data[];
 };
 
-struct f34_data {
-	struct rmi_function *fn;
-
+struct f34v5_data {
 	u16 block_size;
 	u16 fw_blocks;
 	u16 config_blocks;
@@ -56,9 +365,73 @@ struct f34_data {
 
 	struct completion cmd_done;
 	struct mutex flash_mutex;
+};
+
+struct f34v7_data {
+	bool initialized;
+	bool has_perm_config;
+	bool has_bl_config;
+	bool has_disp_config;
+	bool has_guest_code;
+	bool force_update;
+	unsigned char *read_config_buf;
+	unsigned char command;
+	unsigned char flash_status;
+	unsigned char productinfo1;
+	unsigned char productinfo2;
+	unsigned char properties_off;
+	unsigned char blk_size_off;
+	unsigned char blk_count_off;
+	unsigned char blk_data_off;
+	unsigned char properties2_off;
+	unsigned char guest_blk_count_off;
+	unsigned char flash_cmd_off;
+	unsigned char flash_status_off;
+	unsigned short block_size;
+	unsigned short fw_block_count;
+	unsigned short config_block_count;
+	unsigned short perm_config_block_count;
+	unsigned short bl_config_block_count;
+	unsigned short disp_config_block_count;
+	unsigned short guest_code_block_count;
+	unsigned short config_size;
+	unsigned short config_area;
+	char product_id[SYNAPTICS_RMI4_PRODUCT_ID_SIZE + 1];
 
+	struct synaptics_rmi4_f34_query_01 flash_properties;
+	struct workqueue_struct *fwu_workqueue;
+	struct delayed_work fwu_work;
+
+	unsigned short flash_config_length;
+	unsigned short payload_length;
+	struct register_offset off;
+	unsigned char partitions;
+	unsigned short partition_table_bytes;
+	unsigned short read_config_buf_size;
+	struct block_count blkcount;
+	struct physical_address phyaddr;
+	struct image_metadata img;
+	bool new_partition_table;
+	const unsigned char *config_data;
+	const unsigned char *image;
+	bool in_bl_mode;
+};
+
+struct f34_data {
+	struct rmi_function *fn;
+
+	enum rmi_f34_bl_version bl_version;
 	unsigned char bootloader_id[5];
 	unsigned char configuration_id[9];
+
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
index 0000000..839f308
--- /dev/null
+++ b/drivers/input/rmi4/rmi_f34v7.c
@@ -0,0 +1,1451 @@
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
+	unsigned char status;
+	unsigned char command;
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
+
+	f34->v7.flash_status = status & MASK_5BIT;
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
+		if ((f34->v7.command == v7_CMD_IDLE) && (f34->v7.flash_status == 0x00)) {
+			rmi_dbg(RMI_DEBUG_FN, &f34->fn->dev,
+				"Idle status detected\n");
+			return 0;
+		}
+	} while (count < timeout_count);
+
+	dev_err(&f34->fn->dev, "%s: Timed out waiting for idle status\n", __func__);
+
+	return -ETIMEDOUT;
+}
+
+static int rmi_f34v7_write_command_single_transaction(struct f34_data *f34,
+						      unsigned char cmd)
+{
+	int ret;
+	unsigned char base;
+	struct f34v7_data_1_5 data_1_5;
+
+	base = f34->fn->fd.data_base_addr;
+
+	memset(data_1_5.data, 0x00, sizeof(data_1_5.data));
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
+	};
+
+	data_1_5.payload_0 = f34->bootloader_id[0];
+	data_1_5.payload_1 = f34->bootloader_id[1];
+
+	ret = rmi_write_block(f34->fn->rmi_dev,
+			base + f34->v7.off.partition_id,
+			data_1_5.data,
+			sizeof(data_1_5.data));
+	if (ret < 0) {
+		dev_err(&f34->fn->dev, "%s: Failed to write single transaction command\n",
+			__func__);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int rmi_f34v7_write_command(struct f34_data *f34, unsigned char cmd)
+{
+	int ret;
+	unsigned char base;
+	unsigned char command;
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
+	};
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
+	};
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
+static int rmi_f34v7_write_partition_id(struct f34_data *f34,
+					unsigned char cmd)
+{
+	int ret;
+	unsigned char base;
+	unsigned char partition;
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
+	};
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
+	unsigned char base;
+	unsigned char length[2];
+	unsigned short block_number = 0;
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
+			(unsigned char *)&block_number,
+			sizeof(block_number));
+	if (ret < 0) {
+		dev_err(&f34->fn->dev, "%s: Failed to write block number\n",
+			__func__);
+		return ret;
+	}
+
+	length[0] = (unsigned char)(f34->v7.flash_config_length & MASK_8BIT);
+	length[1] = (unsigned char)(f34->v7.flash_config_length >> 8);
+
+	ret = rmi_write_block(f34->fn->rmi_dev,
+			base + f34->v7.off.transfer_length,
+			length,
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
+		const unsigned char *partition_table,
+		struct block_count *blkcount, struct physical_address *phyaddr)
+{
+	unsigned char ii;
+	unsigned char index;
+	unsigned short partition_length;
+	unsigned short physical_address;
+	struct partition_table *ptable;
+
+	for (ii = 0; ii < f34->v7.partitions; ii++) {
+		index = ii * 8 + 2;
+		ptable = (struct partition_table *)&partition_table[index];
+		partition_length = ptable->partition_length_15_8 << 8 |
+				ptable->partition_length_7_0;
+		physical_address = ptable->start_physical_address_15_8 << 8 |
+				ptable->start_physical_address_7_0;
+		rmi_dbg(RMI_DEBUG_FN, &f34->fn->dev,
+			"%s: Partition entry %d: %*ph\n",
+			__func__, ii, sizeof(struct partition_table), ptable);
+		switch (ptable->partition_id) {
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
+		};
+	}
+}
+
+static int rmi_f34v7_read_queries_bl_version(struct f34_data *f34)
+{
+	int ret;
+	unsigned char base;
+	unsigned char offset;
+	struct f34v7_query_0 query_0;
+	struct f34v7_query_1_7 query_1_7;
+
+	base = f34->fn->fd.query_base_addr;
+
+	ret = rmi_read_block(f34->fn->rmi_dev,
+			base,
+			query_0.data,
+			sizeof(query_0.data));
+	if (ret < 0) {
+		dev_err(&f34->fn->dev, "%s: Failed to read query 0\n", __func__);
+		return ret;
+	}
+
+	offset = query_0.subpacket_1_size + 1;
+
+	ret = rmi_read_block(f34->fn->rmi_dev,
+			base + offset,
+			query_1_7.data,
+			sizeof(query_1_7.data));
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
+	unsigned char ii;
+	unsigned char base;
+	unsigned char index;
+	unsigned char offset;
+	unsigned char *ptable;
+	struct f34v7_query_0 query_0;
+	struct f34v7_query_1_7 query_1_7;
+
+	base = f34->fn->fd.query_base_addr;
+
+	ret = rmi_read_block(f34->fn->rmi_dev,
+			base,
+			query_0.data,
+			sizeof(query_0.data));
+	if (ret < 0) {
+		dev_err(&f34->fn->dev, "%s: Failed to read query 0\n", __func__);
+		return ret;
+	}
+
+	offset = query_0.subpacket_1_size + 1;
+
+	ret = rmi_read_block(f34->fn->rmi_dev,
+			base + offset,
+			query_1_7.data,
+			sizeof(query_1_7.data));
+	if (ret < 0) {
+		dev_err(&f34->fn->dev, "%s: Failed to read queries 1 to 7\n",
+			__func__);
+		return ret;
+	}
+
+	f34->bootloader_id[0] = query_1_7.bl_minor_revision;
+	f34->bootloader_id[1] = query_1_7.bl_major_revision;
+
+	f34->v7.block_size = query_1_7.block_size_15_8 << 8 |
+		query_1_7.block_size_7_0;
+
+	rmi_dbg(RMI_DEBUG_FN, &f34->fn->dev, "%s: f34->v7.block_size = %d\n",
+		 __func__, f34->v7.block_size);
+
+	f34->v7.flash_config_length = query_1_7.flash_config_length_15_8 << 8 |
+		query_1_7.flash_config_length_7_0;
+
+	f34->v7.payload_length = query_1_7.payload_length_15_8 << 8 |
+		query_1_7.payload_length_7_0;
+
+	f34->v7.off.flash_status = V7_FLASH_STATUS_OFFSET;
+	f34->v7.off.partition_id = V7_PARTITION_ID_OFFSET;
+	f34->v7.off.block_number = V7_BLOCK_NUMBER_OFFSET;
+	f34->v7.off.transfer_length = V7_TRANSFER_LENGTH_OFFSET;
+	f34->v7.off.flash_cmd = V7_COMMAND_OFFSET;
+	f34->v7.off.payload = V7_PAYLOAD_OFFSET;
+
+	f34->v7.flash_properties.has_disp_config = query_1_7.has_display_config;
+	f34->v7.flash_properties.has_perm_config = query_1_7.has_guest_serialization;
+	f34->v7.flash_properties.has_bl_config = query_1_7.has_global_parameters;
+
+	f34->v7.has_guest_code = query_1_7.has_guest_code;
+	f34->v7.flash_properties.has_config_id = query_0.has_config_id;
+
+	if (f34->v7.flash_properties.has_config_id) {
+		char f34_ctrl[4];
+
+		ret = rmi_read_block(f34->fn->rmi_dev,
+				f34->fn->fd.control_base_addr,
+				f34_ctrl,
+				sizeof(f34_ctrl));
+		if (ret)
+			return ret;
+
+		snprintf(f34->configuration_id, sizeof(f34->configuration_id),
+			 "%02x%02x%02x%02x",
+			 f34_ctrl[0], f34_ctrl[1], f34_ctrl[2], f34_ctrl[3]);
+
+		rmi_dbg(RMI_DEBUG_FN, &f34->fn->dev, "Configuration ID: %s\n",
+			f34->configuration_id);
+	}
+
+	index = sizeof(query_1_7.data) - V7_PARTITION_SUPPORT_BYTES;
+
+	f34->v7.partitions = 0;
+	for (offset = 0; offset < V7_PARTITION_SUPPORT_BYTES; offset++) {
+		for (ii = 0; ii < 8; ii++) {
+			if (query_1_7.data[index + offset] & (1 << ii))
+				f34->v7.partitions++;
+		}
+
+		rmi_dbg(RMI_DEBUG_FN, &f34->fn->dev,
+				"%s: Supported partitions: 0x%02x\n",
+				__func__, query_1_7.data[index + offset]);
+	}
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
+	rmi_f34v7_parse_partition_table(f34, ptable, &f34->v7.blkcount, &f34->v7.phyaddr);
+
+	return 0;
+}
+
+static int rmi_f34v7_check_ui_firmware_size(struct f34_data *f34)
+{
+	unsigned short block_count;
+
+	block_count = f34->v7.img.ui_firmware.size / f34->v7.block_size;
+
+	if (block_count != f34->v7.blkcount.ui_firmware) {
+		dev_err(&f34->fn->dev, "%s: UI firmware size mismatch:"
+			"block_count=%d,f34->v7.blkcount.ui_firmware=%d\n",
+			__func__, block_count, f34->v7.blkcount.ui_firmware);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int rmi_f34v7_check_ui_configuration_size(struct f34_data *f34)
+{
+	unsigned short block_count;
+
+	block_count = f34->v7.img.ui_config.size / f34->v7.block_size;
+
+	if (block_count != f34->v7.blkcount.ui_config) {
+		dev_err(&f34->fn->dev, "%s: UI configuration size mismatch\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int rmi_f34v7_check_dp_configuration_size(struct f34_data *f34)
+{
+	unsigned short block_count;
+
+	block_count = f34->v7.img.dp_config.size / f34->v7.block_size;
+
+	if (block_count != f34->v7.blkcount.dp_config) {
+		dev_err(&f34->fn->dev, "%s: Display configuration size mismatch\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int rmi_f34v7_check_guest_code_size(struct f34_data *f34)
+{
+	unsigned short block_count;
+
+	block_count = f34->v7.img.guest_code.size / f34->v7.block_size;
+	if (block_count != f34->v7.blkcount.guest_code) {
+		dev_err(&f34->fn->dev, "%s: Guest code size mismatch\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int rmi_f34v7_check_bl_configuration_size(struct f34_data *f34)
+{
+	unsigned short block_count;
+
+	block_count = f34->v7.img.bl_config.size / f34->v7.block_size;
+
+	if (block_count != f34->v7.blkcount.bl_config) {
+		dev_err(&f34->fn->dev, "%s: Bootloader config size mismatch\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int rmi_f34v7_erase_configuration(struct f34_data *f34)
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
+	ret = rmi_f34v7_erase_configuration(f34);
+	if (ret < 0)
+		return ret;
+
+	if (f34->v7.flash_properties.has_disp_config) {
+		f34->v7.config_area = v7_DP_CONFIG_AREA;
+		ret = rmi_f34v7_erase_configuration(f34);
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
+static int rmi_f34v7_read_f34v7_blocks(struct f34_data *f34,
+		unsigned short block_cnt,
+		unsigned char command)
+{
+	int ret;
+	unsigned char base;
+	unsigned char length[2];
+	unsigned short transfer;
+	unsigned short max_transfer;
+	unsigned short remaining = block_cnt;
+	unsigned short block_number = 0;
+	unsigned short index = 0;
+
+	base = f34->fn->fd.data_base_addr;
+
+	ret = rmi_f34v7_write_partition_id(f34, command);
+	if (ret < 0)
+		return ret;
+
+	ret = rmi_write_block(f34->fn->rmi_dev,
+			base + f34->v7.off.block_number,
+			(unsigned char *)&block_number,
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
+		if (remaining / max_transfer)
+			transfer = max_transfer;
+		else
+			transfer = remaining;
+
+		length[0] = (unsigned char)(transfer & MASK_8BIT);
+		length[1] = (unsigned char)(transfer >> 8);
+
+		ret = rmi_write_block(f34->fn->rmi_dev,
+				base + f34->v7.off.transfer_length,
+				length,
+				sizeof(length));
+		if (ret < 0) {
+			dev_err(&f34->fn->dev,
+				"%s: Failed to write transfer length "
+				"(%d blocks remaining)\n",
+				__func__, remaining);
+			return ret;
+		}
+
+		ret = rmi_f34v7_write_command(f34, command);
+		if (ret < 0) {
+			dev_err(&f34->fn->dev, "%s: Failed to write command "
+				"(%d blocks remaining)\n",
+				__func__, remaining);
+			return ret;
+		}
+
+		ret = rmi_f34v7_wait_for_idle(f34, ENABLE_WAIT_MS);
+		if (ret < 0) {
+			dev_err(&f34->fn->dev, "%s: Failed to wait for idle status "
+				"(%d blocks remaining)\n",
+				__func__, remaining);
+			return ret;
+		}
+
+		ret = rmi_read_block(f34->fn->rmi_dev,
+				base + f34->v7.off.payload,
+				&f34->v7.read_config_buf[index],
+				transfer * f34->v7.block_size);
+		if (ret < 0) {
+			dev_err(&f34->fn->dev, "%s: Failed to read block data "
+				"(%d blocks remaining)\n",
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
+static int rmi_f34v7_write_f34v7_blocks(struct f34_data *f34,
+		unsigned char *block_ptr,
+		unsigned short block_cnt, unsigned char command)
+{
+	int ret;
+	unsigned char base;
+	unsigned char length[2];
+	unsigned short transfer;
+	unsigned short max_transfer;
+	unsigned short remaining = block_cnt;
+	unsigned short block_number = 0;
+
+	base = f34->fn->fd.data_base_addr;
+
+	ret = rmi_f34v7_write_partition_id(f34, command);
+	if (ret < 0)
+		return ret;
+
+	ret = rmi_write_block(f34->fn->rmi_dev,
+			base + f34->v7.off.block_number,
+			(unsigned char *)&block_number,
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
+		if (remaining / max_transfer)
+			transfer = max_transfer;
+		else
+			transfer = remaining;
+
+		length[0] = (unsigned char)(transfer & MASK_8BIT);
+		length[1] = (unsigned char)(transfer >> 8);
+
+		ret = rmi_write_block(f34->fn->rmi_dev,
+				base + f34->v7.off.transfer_length,
+				length,
+				sizeof(length));
+		if (ret < 0) {
+			dev_err(&f34->fn->dev,
+				"%s: Failed to write transfer length (%d blocks remaining)\n",
+				__func__, remaining);
+			return ret;
+		}
+
+		ret = rmi_f34v7_write_command(f34, command);
+		if (ret < 0) {
+			dev_err(&f34->fn->dev,
+				"%s: Failed to write command (%d blocks remaining)\n",
+				__func__, remaining);
+			return ret;
+		}
+
+		ret = rmi_write_block(f34->fn->rmi_dev,
+				base + f34->v7.off.payload,
+				block_ptr,
+				transfer * f34->v7.block_size);
+		if (ret < 0) {
+			dev_err(&f34->fn->dev,
+				"%s: Failed to write block data (%d blocks remaining)\n",
+				__func__, remaining);
+			return ret;
+		}
+
+		ret = rmi_f34v7_wait_for_idle(f34, ENABLE_WAIT_MS);
+		if (ret < 0) {
+			dev_err(&f34->fn->dev,
+				"%s: Failed to wait for idle status (%d blocks remaining)\n",
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
+static int rmi_f34v7_write_f34_blocks(struct f34_data *f34,
+		unsigned char *block_ptr,
+		unsigned short block_cnt, unsigned char cmd)
+{
+	int ret;
+
+	ret = rmi_f34v7_write_f34v7_blocks(f34, block_ptr, block_cnt, cmd);
+
+	return ret;
+}
+
+static int rmi_f34v7_write_configuration(struct f34_data *f34)
+{
+	return rmi_f34v7_write_f34_blocks(f34, (unsigned char *)f34->v7.config_data,
+			f34->v7.config_block_count, v7_CMD_WRITE_CONFIG);
+}
+
+static int rmi_f34v7_write_ui_configuration(struct f34_data *f34)
+{
+	f34->v7.config_area = v7_UI_CONFIG_AREA;
+	f34->v7.config_data = f34->v7.img.ui_config.data;
+	f34->v7.config_size = f34->v7.img.ui_config.size;
+	f34->v7.config_block_count = f34->v7.config_size / f34->v7.block_size;
+
+	return rmi_f34v7_write_configuration(f34);
+}
+
+static int rmi_f34v7_write_dp_configuration(struct f34_data *f34)
+{
+	f34->v7.config_area = v7_DP_CONFIG_AREA;
+	f34->v7.config_data = f34->v7.img.dp_config.data;
+	f34->v7.config_size = f34->v7.img.dp_config.size;
+	f34->v7.config_block_count = f34->v7.config_size / f34->v7.block_size;
+
+	return rmi_f34v7_write_configuration(f34);
+}
+
+static int rmi_f34v7_write_guest_code(struct f34_data *f34)
+{
+	unsigned short guest_code_block_count;
+	int ret;
+
+	guest_code_block_count = f34->v7.img.guest_code.size / f34->v7.block_size;
+
+	ret = rmi_f34v7_write_f34_blocks(f34, (unsigned char *)f34->v7.img.guest_code.data,
+			guest_code_block_count, v7_CMD_WRITE_GUEST_CODE);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int rmi_f34v7_write_flash_configuration(struct f34_data *f34)
+{
+	int ret;
+
+	f34->v7.config_area = v7_FLASH_CONFIG_AREA;
+	f34->v7.config_data = f34->v7.img.fl_config.data;
+	f34->v7.config_size = f34->v7.img.fl_config.size;
+	f34->v7.config_block_count = f34->v7.config_size / f34->v7.block_size;
+
+	if (f34->v7.config_block_count != f34->v7.blkcount.fl_config) {
+		dev_err(&f34->fn->dev, "%s: Flash configuration size mismatch\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	ret = rmi_f34v7_write_command(f34, v7_CMD_ERASE_FLASH_CONFIG);
+	if (ret < 0)
+		return ret;
+
+	rmi_dbg(RMI_DEBUG_FN, &f34->fn->dev,
+		"%s: Erase flash configuration command written\n", __func__);
+
+	ret = rmi_f34v7_wait_for_idle(f34, ENABLE_WAIT_MS);
+	if (ret < 0)
+		return ret;
+
+	ret = rmi_f34v7_write_configuration(f34);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int rmi_f34v7_write_partition_table(struct f34_data *f34)
+{
+	unsigned short block_count;
+	int ret;
+
+	block_count = f34->v7.blkcount.bl_config;
+	f34->v7.config_area = v7_BL_CONFIG_AREA;
+	f34->v7.config_size = f34->v7.block_size * block_count;
+	devm_kfree(&f34->fn->dev, f34->v7.read_config_buf);
+	f34->v7.read_config_buf = devm_kzalloc(&f34->fn->dev, f34->v7.config_size,
+					    GFP_KERNEL);
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
+	ret = rmi_f34v7_erase_configuration(f34);
+	if (ret < 0)
+		return ret;
+
+	ret = rmi_f34v7_write_flash_configuration(f34);
+	if (ret < 0)
+		return ret;
+
+	f34->v7.config_area = v7_BL_CONFIG_AREA;
+	f34->v7.config_data = f34->v7.read_config_buf;
+	f34->v7.config_size = f34->v7.img.bl_config.size;
+	f34->v7.config_block_count = f34->v7.config_size / f34->v7.block_size;
+
+	ret = rmi_f34v7_write_configuration(f34);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int rmi_f34v7_write_firmware(struct f34_data *f34)
+{
+	unsigned short firmware_block_count;
+
+	firmware_block_count = f34->v7.img.ui_firmware.size / f34->v7.block_size;
+
+	return rmi_f34v7_write_f34_blocks(f34, (unsigned char *)f34->v7.img.ui_firmware.data,
+			firmware_block_count, v7_CMD_WRITE_FW);
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
+	if (f34->v7.flash_properties.has_disp_config) {
+		if (f34->v7.phyaddr.dp_config != f34->v7.img.phyaddr.dp_config) {
+			f34->v7.new_partition_table = true;
+			return;
+		}
+	}
+
+	if (f34->v7.flash_properties.has_disp_config) {
+		if (f34->v7.phyaddr.dp_config != f34->v7.img.phyaddr.dp_config) {
+			f34->v7.new_partition_table = true;
+			return;
+		}
+	}
+
+	if (f34->v7.has_guest_code) {
+		if (f34->v7.phyaddr.guest_code != f34->v7.img.phyaddr.guest_code) {
+			f34->v7.new_partition_table = true;
+			return;
+		}
+	}
+
+	f34->v7.new_partition_table = false;
+}
+
+static unsigned int le_to_uint(const unsigned char *ptr)
+{
+	return (unsigned int)ptr[0] +
+			(unsigned int)ptr[1] * 0x100 +
+			(unsigned int)ptr[2] * 0x10000 +
+			(unsigned int)ptr[3] * 0x1000000;
+}
+
+static void rmi_f34v7_parse_image_header_10_bl_container(struct f34_data *f34,
+						   const unsigned char *image)
+{
+	unsigned char ii;
+	unsigned char num_of_containers;
+	unsigned int addr;
+	unsigned int container_id;
+	unsigned int length;
+	const unsigned char *content;
+	struct container_descriptor *descriptor;
+
+	num_of_containers = (f34->v7.img.bootloader.size - 4) / 4;
+
+	for (ii = 1; ii <= num_of_containers; ii++) {
+		addr = le_to_uint(f34->v7.img.bootloader.data + (ii * 4));
+		descriptor = (struct container_descriptor *)(image + addr);
+		container_id = descriptor->container_id[0] |
+				descriptor->container_id[1] << 8;
+		content = image + le_to_uint(descriptor->content_address);
+		length = le_to_uint(descriptor->content_length);
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
+		};
+	}
+}
+
+static void rmi_f34v7_parse_image_header_10(struct f34_data *f34)
+{
+	unsigned char ii;
+	unsigned char num_of_containers;
+	unsigned int addr;
+	unsigned int offset;
+	unsigned int container_id;
+	unsigned int length;
+	const unsigned char *image;
+	const unsigned char *content;
+	struct container_descriptor *descriptor;
+	struct image_header_10 *header;
+
+	image = f34->v7.image;
+	header = (struct image_header_10 *)image;
+
+	f34->v7.img.checksum = le_to_uint(header->checksum);
+
+	rmi_dbg(RMI_DEBUG_FN, &f34->fn->dev, "%s: f34->v7.img.checksum=%d\n",
+		__func__, f34->v7.img.checksum);
+
+	/* address of top level container */
+	offset = le_to_uint(header->top_level_container_start_addr);
+	descriptor = (struct container_descriptor *)(image + offset);
+
+	/* address of top level container content */
+	offset = le_to_uint(descriptor->content_address);
+	num_of_containers = le_to_uint(descriptor->content_length) / 4;
+
+	for (ii = 0; ii < num_of_containers; ii++) {
+		addr = le_to_uint(image + offset);
+		offset += 4;
+		descriptor = (struct container_descriptor *)(image + addr);
+		container_id = descriptor->container_id[0] |
+				descriptor->container_id[1] << 8;
+		content = image + le_to_uint(descriptor->content_address);
+		length = le_to_uint(descriptor->content_length);
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
+			rmi_f34v7_parse_image_header_10_bl_container(f34, image);
+			break;
+		case GUEST_CODE_CONTAINER:
+			f34->v7.img.contains_guest_code = true;
+			f34->v7.img.guest_code.data = content;
+			f34->v7.img.guest_code.size = length;
+			break;
+		case DISPLAY_CONFIG_CONTAINER:
+			f34->v7.img.contains_disp_config = true;
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
+			f34->v7.img.firmware_id = le_to_uint(content + 4);
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
+		ret = rmi_f34v7_check_ui_configuration_size(f34);
+		if (ret < 0)
+			goto fail;
+
+		if (f34->v7.flash_properties.has_disp_config &&
+				f34->v7.img.contains_disp_config) {
+			ret = rmi_f34v7_check_dp_configuration_size(f34);
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
+		ret = rmi_f34v7_check_bl_configuration_size(f34);
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
+	ret = rmi_f34v7_write_ui_configuration(f34);
+	if (ret < 0)
+		goto fail;
+
+	if (f34->v7.flash_properties.has_disp_config &&
+			f34->v7.img.contains_disp_config) {
+		dev_info(&f34->fn->dev, "Writing display config...\n");
+
+		ret = rmi_f34v7_write_dp_configuration(f34);
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
+			f34->fn->fd.query_base_addr + BOOTLOADER_ID_OFFSET,
+			f34->bootloader_id,
+			sizeof(f34->bootloader_id));
+	if (ret < 0) {
+		dev_err(&f34->fn->dev, "%s: Failed to read bootloader ID\n",
+			__func__);
+		return ret;
+	}
+
+	if (f34->bootloader_id[1] == '5') {
+		f34->bl_version = BL_V5;
+	} else if (f34->bootloader_id[1] == '6') {
+		f34->bl_version = BL_V6;
+	} else if (f34->bootloader_id[1] == 7) {
+		f34->bl_version = BL_V7;
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
+	f34->v7.force_update = FORCE_UPDATE;
+	f34->v7.initialized = true;
+	return 0;
+}
diff --git a/include/linux/rmi.h b/include/linux/rmi.h
index a283a67..6baee9f 100644
--- a/include/linux/rmi.h
+++ b/include/linux/rmi.h
@@ -331,7 +331,7 @@ struct rmi_driver_data {
 
 	struct rmi_function *f01_container;
 	struct rmi_function *f34_container;
-	bool f01_bootloader_mode;
+	bool bootloader_mode;
 
 	u32 attn_count;
 	int num_of_irq_regs;
-- 
2.7.4


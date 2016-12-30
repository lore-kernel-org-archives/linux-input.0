From: Nick Dyer <nick@shmanahar.org>
Subject: [PATCH 1/2] Input: synaptics-rmi4 - add sysfs attribute update_fw_status
Date: Fri, 30 Dec 2016 18:43:17 +0000
Message-ID: <1483123398-27595-2-git-send-email-nick@shmanahar.org>
References: <1483123398-27595-1-git-send-email-nick@shmanahar.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avasout05.plus.net ([84.93.230.250]:51585 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752536AbcL3SnO (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 30 Dec 2016 13:43:14 -0500
In-Reply-To: <1483123398-27595-1-git-send-email-nick@shmanahar.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, Chris Healy <cphealy@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, Nick Dyer <nick@shmanahar.org>

The status is the percentage complete, or once complete, zero for
success or a negative return code.

Signed-off-by: Nick Dyer <nick@shmanahar.org>
---
 drivers/input/rmi4/rmi_f34.c   | 34 ++++++++++++++++++++++++++++++++++
 drivers/input/rmi4/rmi_f34.h   |  4 ++++
 drivers/input/rmi4/rmi_f34v7.c |  6 ++++++
 3 files changed, 44 insertions(+)

diff --git a/drivers/input/rmi4/rmi_f34.c b/drivers/input/rmi4/rmi_f34.c
index c3285ce..d7709bc 100644
--- a/drivers/input/rmi4/rmi_f34.c
+++ b/drivers/input/rmi4/rmi_f34.c
@@ -157,6 +157,9 @@ static int rmi_f34_write_blocks(struct f34_data *f34, const void *data,
 			i + 1, block_count);
 
 		data += f34->v5.block_size;
+		f34->update_progress += f34->v5.block_size;
+		f34->update_status = (f34->update_progress * 100) /
+			f34->update_size;
 	}
 
 	return 0;
@@ -186,6 +189,8 @@ static int rmi_f34_flash_firmware(struct f34_data *f34,
 	struct rmi_function *fn = f34->fn;
 	int ret;
 
+	f34->update_progress = 0;
+	f34->update_size = syn_fw->image_size + syn_fw->config_size;
 	if (syn_fw->image_size) {
 		dev_info(&fn->dev, "Erasing firmware...\n");
 		ret = rmi_f34_command(f34, F34_ERASE_ALL,
@@ -283,6 +288,17 @@ out:
 	return ret;
 }
 
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
 static int rmi_firmware_update(struct rmi_driver_data *data,
 			       const struct firmware *fw)
 {
@@ -347,6 +363,7 @@ static int rmi_firmware_update(struct rmi_driver_data *data,
 		ret = rmi_f34_update_firmware(f34, fw);
 
 	dev_info(&f34->fn->dev, "Firmware update complete, status:%d\n", ret);
+	f34->update_status = ret;
 
 	rmi_disable_irq(rmi_dev, false);
 
@@ -414,8 +431,25 @@ static ssize_t rmi_driver_update_fw_store(struct device *dev,
 
 static DEVICE_ATTR(update_fw, 0200, NULL, rmi_driver_update_fw_store);
 
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
+static DEVICE_ATTR(update_fw_status, 0444,
+		   rmi_driver_update_fw_status_show, NULL);
+
 static struct attribute *rmi_firmware_attrs[] = {
 	&dev_attr_update_fw.attr,
+	&dev_attr_update_fw_status.attr,
 	NULL
 };
 
diff --git a/drivers/input/rmi4/rmi_f34.h b/drivers/input/rmi4/rmi_f34.h
index 2c21056..43a9134 100644
--- a/drivers/input/rmi4/rmi_f34.h
+++ b/drivers/input/rmi4/rmi_f34.h
@@ -301,6 +301,10 @@ struct f34_data {
 	unsigned char bootloader_id[5];
 	unsigned char configuration_id[CONFIG_ID_SIZE*2 + 1];
 
+	int update_status;
+	int update_progress;
+	int update_size;
+
 	union {
 		struct f34v5_data v5;
 		struct f34v7_data v7;
diff --git a/drivers/input/rmi4/rmi_f34v7.c b/drivers/input/rmi4/rmi_f34v7.c
index ca31f95..35a6cf6 100644
--- a/drivers/input/rmi4/rmi_f34v7.c
+++ b/drivers/input/rmi4/rmi_f34v7.c
@@ -366,6 +366,7 @@ static void rmi_f34v7_parse_partition_table(struct f34_data *f34,
 		rmi_dbg(RMI_DEBUG_FN, &f34->fn->dev,
 			"%s: Partition entry %d: %*ph\n",
 			__func__, i, sizeof(struct partition_table), ptable);
+		f34->update_size += partition_length;
 		switch (ptable->partition_id & 0x1f) {
 		case CORE_CODE_PARTITION:
 			blkcount->ui_firmware = partition_length;
@@ -881,6 +882,9 @@ static int rmi_f34v7_write_f34v7_blocks(struct f34_data *f34,
 
 		block_ptr += (transfer * f34->v7.block_size);
 		remaining -= transfer;
+		f34->update_progress++;
+		f34->update_status = (f34->update_progress * 100) /
+				     f34->update_size;
 	} while (remaining);
 
 	return 0;
@@ -1191,6 +1195,8 @@ int rmi_f34v7_do_reflash(struct f34_data *f34, const struct firmware *fw)
 	rmi_f34v7_read_queries_bl_version(f34);
 
 	f34->v7.image = fw->data;
+	f34->update_progress = 0;
+	f34->update_size = 0;
 
 	ret = rmi_f34v7_parse_image_info(f34);
 	if (ret < 0)
-- 
2.7.4


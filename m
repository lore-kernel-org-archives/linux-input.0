From: Nick Dyer <nick@shmanahar.org>
Subject: [PATCH v4 5/7] Input: synaptics-rmi4 - add sysfs attribute update_fw_status
Date: Wed, 19 Oct 2016 00:26:06 +0100
Message-ID: <1476833168-12880-5-git-send-email-nick@shmanahar.org>
References: <1476833168-12880-1-git-send-email-nick@shmanahar.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avasout06.plus.net ([212.159.14.18]:46729 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756185AbcJRX0P (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 18 Oct 2016 19:26:15 -0400
In-Reply-To: <1476833168-12880-1-git-send-email-nick@shmanahar.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>
Cc: Chris Healy <cphealy@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Nick Dyer <nick@shmanahar.org>

The status is the percentage complete, or once complete, zero for
success or a negative return code.

Signed-off-by: Nick Dyer <nick@shmanahar.org>
---
 drivers/input/rmi4/rmi_f34.c   | 34 ++++++++++++++++++++++++++++++++++
 drivers/input/rmi4/rmi_f34.h   |  4 ++++
 drivers/input/rmi4/rmi_f34v7.c | 14 ++++++++++++++
 3 files changed, 52 insertions(+)

diff --git a/drivers/input/rmi4/rmi_f34.c b/drivers/input/rmi4/rmi_f34.c
index 4f97613..59adfec 100644
--- a/drivers/input/rmi4/rmi_f34.c
+++ b/drivers/input/rmi4/rmi_f34.c
@@ -156,6 +156,9 @@ static int rmi_f34_write_blocks(struct f34_data *f34, const void *data,
 			i + 1, block_count);
 
 		data += f34->v5.block_size;
+		f34->update_progress += f34->v5.block_size;
+		f34->update_status = (f34->update_progress * 100) /
+			f34->update_size;
 	}
 
 	return 0;
@@ -185,6 +188,8 @@ static int rmi_f34_flash_firmware(struct f34_data *f34,
 	struct rmi_function *fn = f34->fn;
 	int ret;
 
+	f34->update_progress = 0;
+	f34->update_size = syn_fw->image_size + syn_fw->config_size;
 	if (syn_fw->image_size) {
 		dev_info(&fn->dev, "Erasing firmware...\n");
 		ret = rmi_f34_command(f34, F34_ERASE_ALL,
@@ -276,12 +281,24 @@ int rmi_f34_update_firmware(struct f34_data *f34, const struct firmware *fw)
 
 	ret = rmi_f34_flash_firmware(f34, syn_fw);
 
+	f34->update_status = ret;
 	mutex_unlock(&f34->v5.flash_mutex);
 
 out:
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
@@ -400,8 +417,25 @@ static ssize_t rmi_driver_update_fw_store(struct device *dev,
 
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
index 9ab8ece..726d5ed 100644
--- a/drivers/input/rmi4/rmi_f34.h
+++ b/drivers/input/rmi4/rmi_f34.h
@@ -424,6 +424,10 @@ struct f34_data {
 	unsigned char bootloader_id[5];
 	unsigned char configuration_id[9];
 
+	int update_status;
+	int update_progress;
+	int update_size;
+
 	union {
 		struct f34v5_data v5;
 		struct f34v7_data v7;
diff --git a/drivers/input/rmi4/rmi_f34v7.c b/drivers/input/rmi4/rmi_f34v7.c
index 839f308..af00a3f 100644
--- a/drivers/input/rmi4/rmi_f34v7.c
+++ b/drivers/input/rmi4/rmi_f34v7.c
@@ -918,6 +918,11 @@ static int rmi_f34v7_write_f34v7_blocks(struct f34_data *f34,
 
 		block_ptr += (transfer * f34->v7.block_size);
 		remaining -= transfer;
+
+		if (command == v7_CMD_WRITE_FW)
+			f34->update_status = 80 - 70*remaining/block_cnt;
+		else if (command == v7_CMD_WRITE_CONFIG)
+			f34->update_status = 90 - 10*remaining/block_cnt;
 	} while (remaining);
 
 	return 0;
@@ -1273,6 +1278,8 @@ int rmi_f34v7_do_reflash(struct f34_data *f34, const struct firmware *fw)
 	if (ret < 0)
 		goto fail;
 
+	f34->update_status = 5;
+
 	if (!f34->v7.new_partition_table) {
 		ret = rmi_f34v7_check_ui_firmware_size(f34);
 		if (ret < 0)
@@ -1312,6 +1319,7 @@ int rmi_f34v7_do_reflash(struct f34_data *f34, const struct firmware *fw)
 			 __func__);
 	}
 
+	f34->update_status = 10;
 	dev_info(&f34->fn->dev, "Writing firmware (%d bytes)...\n",
 		 f34->v7.img.ui_firmware.size);
 
@@ -1336,6 +1344,8 @@ int rmi_f34v7_do_reflash(struct f34_data *f34, const struct firmware *fw)
 			goto fail;
 	}
 
+	f34->update_status = 95;
+
 	if (f34->v7.new_partition_table) {
 		if (f34->v7.has_guest_code && f34->v7.img.contains_guest_code) {
 			dev_info(&f34->fn->dev, "Writing guest code...\n");
@@ -1346,7 +1356,11 @@ int rmi_f34v7_do_reflash(struct f34_data *f34, const struct firmware *fw)
 		}
 	}
 
+	f34->update_status = 0;
+	return 0;
+
 fail:
+	f34->update_status = ret;
 	return ret;
 }
 
-- 
2.7.4


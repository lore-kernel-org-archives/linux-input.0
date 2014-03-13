From: Christopher Heiny <cheiny@synaptics.com>
Subject: [PATCH v2 06/06] input synaptics-rmi4: Use request_firmware_nowait
Date: Wed, 12 Mar 2014 18:53:57 -0700
Message-ID: <1394675637-23853-6-git-send-email-cheiny@synaptics.com>
References: <1394675637-23853-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:45258 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752623AbaCMByO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Mar 2014 21:54:14 -0400
In-Reply-To: <1394675637-23853-1-git-send-email-cheiny@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Christopher Heiny <cheiny@synaptics.com>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>

Replace request_firmware() and our own work_queue entry, and use
request_firmware_nowait() instead.

Suggested-by: Courtney Cavin <courtney.cavin@sonymobile.com>
Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
Signed-off-by: Vincent Huang <vincent.huang@tw.synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Linux Walleij <linus.walleij@linaro.org>
Cc: David Herrmann <dh.herrmann@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>

---

 drivers/input/rmi4/rmi_fw_update.c | 233 +++++++++++++++++--------------------
 1 file changed, 109 insertions(+), 124 deletions(-)

diff --git a/drivers/input/rmi4/rmi_fw_update.c b/drivers/input/rmi4/rmi_fw_update.c
index a990f9a..c84f33f 100644
--- a/drivers/input/rmi4/rmi_fw_update.c
+++ b/drivers/input/rmi4/rmi_fw_update.c
@@ -120,7 +120,6 @@ struct rmi_fw_update_data {
 	struct rmi_f34_control_status f34_controls;
 	const u8 *firmware_data;
 	const u8 *config_data;
-	struct work_struct update_work;
 };
 
 static void rmi_extract_header(const u8 *data, int pos,
@@ -260,11 +259,6 @@ static int rmi_wait_for_idle(struct rmi_fw_update_data *data, int timeout_ms)
 					  !data->f34_controls.program_enabled,
 					  "Bootloader is idle but program_enabled bit isn't set.\n"
 					  ))
-				/*
-				 * This works around a bug in certain device
-				 * firmwares, where the idle state is reached,
-				 * but the program_enabled bit is not yet set.
-				 */
 				continue;
 			return 0;
 		}
@@ -482,7 +476,8 @@ static int rmi_write_blocks(struct rmi_fw_update_data *data, u8 *block_ptr,
 			return retval;
 		}
 
-		retval = rmi_write(data->rmi_dev, data->f34_status_address, cmd);
+		retval = rmi_write(data->rmi_dev, data->f34_status_address,
+				   cmd);
 		if (retval) {
 			dev_err(&data->rmi_dev->dev, "Failed to write command for block %d. Code=%d.\n",
 				block_num, retval);
@@ -600,89 +595,30 @@ static bool rmi_go_nogo(struct rmi_fw_update_data *data,
 	return false;
 }
 
-static const char rmi_fw_name_format[] = "%s.img";
-
-static void rmi_fw_update(struct rmi_device *rmi_dev)
+static void rmi_do_update(const struct firmware *fw_entry, void *context)
 {
+	struct rmi_device *rmi_dev = context;
+	struct rmi_driver_data *drv_data = dev_get_drvdata(&rmi_dev->dev);
+	struct rmi_fw_update_data *data = drv_data->fw_update_data;
+	struct rmi_image_header *header = NULL;
 	struct timespec start;
 	struct timespec end;
 	s64 duration_ns;
-	char *firmware_name;
-	const struct firmware *fw_entry = NULL;
-	int retval;
-	struct rmi_image_header *header = NULL;
-	u8 pdt_props;
-	struct rmi_driver_data *drv_data = dev_get_drvdata(&rmi_dev->dev);
-	struct rmi_fw_update_data *data = drv_data->fw_update_data;
-	const struct rmi_device_platform_data *pdata =
-				rmi_get_platform_data(rmi_dev);
-
-	dev_dbg(&rmi_dev->dev, "%s called.\n", __func__);
-	dev_dbg(&rmi_dev->dev, "force: %d\n", data->force);
-	dev_dbg(&rmi_dev->dev, "img_name: %s\n", data->img_name);
-	dev_dbg(&rmi_dev->dev, "firmware_name: %s\n", pdata->firmware_name);
 
-	getnstimeofday(&start);
-
-	firmware_name = kcalloc(RMI_NAME_BUFFER_SIZE, sizeof(char), GFP_KERNEL);
-	if (!firmware_name) {
-		dev_err(&rmi_dev->dev, "Failed to allocate firmware_name.\n");
-		goto done;
+	if (!fw_entry) {
+		dev_err(&rmi_dev->dev, "Firmware was not available.\n");
+		goto error_exit;
 	}
+
 	header = kzalloc(sizeof(struct rmi_image_header), GFP_KERNEL);
 	if (!header) {
-		dev_err(&rmi_dev->dev, "Failed to allocate header.\n");
-		goto done;
+		dev_err(&rmi_dev->dev, "Failed to allocate image header.\n");
+		goto error_exit;
 	}
 
-	retval = rmi_read(rmi_dev, PDT_PROPERTIES_LOCATION, &pdt_props);
-	if (retval) {
-		dev_warn(&rmi_dev->dev,
-			 "Failed to read PDT props at %#06x (code %d). Assuming 0x00.\n",
-			 PDT_PROPERTIES_LOCATION, retval);
-	}
-	if (pdt_props & RMI_PDT_PROPS_HAS_BSR) {
-		dev_warn(&rmi_dev->dev,
-			 "Firmware update for LTS not currently supported.\n");
-		goto done;
-	}
-
-	retval = rmi_f01_read_properties(rmi_dev, data->f01_pdt.query_base_addr,
-					 &data->f01_props);
-	if (retval) {
-		dev_err(&rmi_dev->dev, "F01 queries failed, code = %d.\n",
-			retval);
-		goto done;
-	}
-	retval = rmi_read_f34_queries(data);
-	if (retval) {
-		dev_err(&rmi_dev->dev, "F34 queries failed, code = %d.\n",
-			retval);
-		goto done;
-	}
-	if (data->img_name && data->img_name[0])
-		snprintf(firmware_name, RMI_NAME_BUFFER_SIZE,
-			 rmi_fw_name_format, data->img_name);
-	else if (pdata->firmware_name && pdata->firmware_name[0])
-		snprintf(firmware_name, RMI_NAME_BUFFER_SIZE,
-			 rmi_fw_name_format, pdata->firmware_name);
-	else {
-		if (!data->f01_props.product_id[0]) {
-			dev_err(&rmi_dev->dev, "Could not determine fw image name - will not update fw.\n");
-			goto done;
-		}
-		snprintf(firmware_name, RMI_NAME_BUFFER_SIZE,
-			 rmi_fw_name_format, data->f01_props.product_id);
-	}
-	dev_info(&rmi_dev->dev, "Requesting %s.\n", firmware_name);
-	retval = request_firmware(&fw_entry, firmware_name, &rmi_dev->dev);
-	if (retval != 0) {
-		dev_err(&rmi_dev->dev, "Firmware %s not available, code = %d\n",
-			firmware_name, retval);
-		goto done;
-	}
+	getnstimeofday(&start);
 
-	dev_dbg(&rmi_dev->dev, "Got firmware %s, size: %d.\n", firmware_name,
+	dev_dbg(&rmi_dev->dev, "Got firmware, size: %d.\n",
 		fw_entry->size);
 	rmi_extract_header(fw_entry->data, 0, header);
 	dev_dbg(&rmi_dev->dev, "Img checksum:           %#08X\n",
@@ -722,36 +658,98 @@ static void rmi_fw_update(struct rmi_device *rmi_dev)
 		dev_dbg(&rmi_dev->dev, "Go/NoGo said don't update.\n");
 	}
 
-	if (fw_entry)
-		release_firmware(fw_entry);
+	release_firmware(fw_entry);
 
-
-done:
 	getnstimeofday(&end);
 	duration_ns = timespec_to_ns(&end) - timespec_to_ns(&start);
 	dev_dbg(&rmi_dev->dev, "Time to update fw: %lld ns.\n", duration_ns);
 
-	kfree(firmware_name);
 	kfree(header);
+error_exit:
+	clear_bit(0, &data->busy);
 	return;
 }
 
-static int rmi_device_update_firmware(struct rmi_device *rmi_dev)
+static const char rmi_fw_name_format[] = "%s.img";
+
+static int rmi_request_fw(struct rmi_device *rmi_dev)
 {
-	struct device *dev = &rmi_dev->dev;
-	struct rmi_driver_data *drv_data = dev_get_drvdata(dev);
+	struct rmi_driver_data *drv_data = dev_get_drvdata(&rmi_dev->dev);
 	struct rmi_fw_update_data *data = drv_data->fw_update_data;
-	int retval;
+	const struct rmi_device_platform_data *pdata =
+				rmi_get_platform_data(rmi_dev);
+	char *firmware_name;
+	int error;
+	u8 pdt_props;
 
-	retval = rmi_find_f01_and_f34(data);
-	if (retval < 0)
-		return retval;
+	error = rmi_find_f01_and_f34(data);
+	if (error < 0)
+		return error;
 
-	rmi_fw_update(rmi_dev);
+	dev_dbg(&rmi_dev->dev, "%s called.\n", __func__);
+	dev_dbg(&rmi_dev->dev, "force: %d\n", data->force);
+	dev_dbg(&rmi_dev->dev, "img_name: %s\n", data->img_name);
+	dev_dbg(&rmi_dev->dev, "firmware_name: %s\n", pdata->firmware_name);
 
-	clear_bit(0, &data->busy);
 
-	return 0;
+	error = rmi_read(rmi_dev, PDT_PROPERTIES_LOCATION, &pdt_props);
+	if (error) {
+		dev_warn(&rmi_dev->dev,
+			 "Failed to read PDT props at %#06x (code %d). Assuming 0x00.\n",
+			 PDT_PROPERTIES_LOCATION, error);
+	}
+	if (pdt_props & RMI_PDT_PROPS_HAS_BSR) {
+		dev_warn(&rmi_dev->dev,
+			 "Firmware update for LTS not currently supported.\n");
+		return -EINVAL;
+	}
+
+	error = rmi_f01_read_properties(rmi_dev, data->f01_pdt.query_base_addr,
+					 &data->f01_props);
+	if (error) {
+		dev_err(&rmi_dev->dev, "F01 queries failed, code = %d.\n",
+			error);
+		return error;
+	}
+	error = rmi_read_f34_queries(data);
+	if (error) {
+		dev_err(&rmi_dev->dev, "F34 queries failed, code = %d.\n",
+			error);
+		return error;
+	}
+
+	firmware_name = kcalloc(RMI_NAME_BUFFER_SIZE, sizeof(char), GFP_KERNEL);
+	if (!firmware_name) {
+		dev_err(&rmi_dev->dev, "Failed to allocate firmware_name.\n");
+		return -ENOMEM;
+	}
+
+	if (data->img_name && data->img_name[0])
+		snprintf(firmware_name, RMI_NAME_BUFFER_SIZE,
+			 rmi_fw_name_format, data->img_name);
+	else if (pdata->firmware_name && pdata->firmware_name[0])
+		snprintf(firmware_name, RMI_NAME_BUFFER_SIZE,
+			 rmi_fw_name_format, pdata->firmware_name);
+	else {
+		if (!data->f01_props.product_id[0]) {
+			dev_err(&rmi_dev->dev, "Could not determine fw image name - will not update fw.\n");
+			error = -EINVAL;
+			goto done;
+		}
+		snprintf(firmware_name, RMI_NAME_BUFFER_SIZE,
+			 rmi_fw_name_format, data->f01_props.product_id);
+	}
+	dev_info(&rmi_dev->dev, "Requesting %s.\n", firmware_name);
+	error = request_firmware_nowait(THIS_MODULE, FW_ACTION_HOTPLUG,
+					 firmware_name, &rmi_dev->dev,
+					 GFP_KERNEL, rmi_dev, rmi_do_update);
+	if (error)
+		dev_err(&rmi_dev->dev, "Request firmware failed for %s, code = %d\n",
+			firmware_name, error);
+
+done:
+	kfree(firmware_name);
+	return error;
 }
 
 static ssize_t rmi_fw_update_img_name_show(struct device *dev,
@@ -788,7 +786,8 @@ static ssize_t rmi_fw_update_img_name_store(struct device *dev,
 }
 
 static ssize_t rmi_fw_update_force_show(struct device *dev,
-					struct device_attribute *attr, char *buf)
+					struct device_attribute *attr,
+					char *buf)
 {
 	struct rmi_device *rmi_dev = to_rmi_device(dev);
 	struct rmi_driver_data *drv_data = dev_get_drvdata(&rmi_dev->dev);
@@ -853,34 +852,21 @@ static ssize_t rmi_fw_update_store(struct device *dev,
 	if (test_and_set_bit(0, &data->busy))
 		return -EBUSY;
 
-	if (val)
-		/*
-		 * TODO: Here we start a work thread to go do the update, but
-		 * maybe we can just use request_firmware_timeout().
-		 */
-		schedule_work(&data->update_work);
-	else
+	if (val) {
+		retval = rmi_request_fw(rmi_dev);
+		if (retval) {
+			dev_err(dev, "Firmware request failed, code: %d",
+				retval);
+			clear_bit(0, &data->busy);
+		}
+	} else {
 		clear_bit(0, &data->busy);
+	}
 
 	return count;
 }
 
-static void rmi_update_work(struct work_struct *work)
-{
-	struct rmi_fw_update_data *data =
-		container_of(work, struct rmi_fw_update_data, update_work);
-	struct rmi_device *rmi_dev = data->rmi_dev;
-	int error;
-
-	dev_dbg(&rmi_dev->dev, "%s runs.\n", __func__);
-	error = rmi_device_update_firmware(rmi_dev);
-	if (error < 0)
-		dev_err(&rmi_dev->dev, "Firmware update attempt failed with code: %d.",
-			error);
-	clear_bit(0, &data->busy);
-}
-
-static DEVICE_ATTR(update_force,
+static DEVICE_ATTR(fw_force_update,
 			(S_IRUGO | S_IWUGO),
 			rmi_fw_update_force_show, rmi_fw_update_force_store);
 static DEVICE_ATTR(fw_img_name,
@@ -892,7 +878,7 @@ static DEVICE_ATTR(fw_update,
 			rmi_fw_update_show, rmi_fw_update_store);
 
 static struct attribute *rmi_fw_update_attrs[] = {
-	&dev_attr_update_force.attr,
+	&dev_attr_fw_force_update.attr,
 	&dev_attr_fw_img_name.attr,
 	&dev_attr_fw_update.attr,
 	NULL
@@ -904,9 +890,8 @@ static const struct attribute_group rmi_fw_update_attributes = {
 
 /*
  * Allocate data needed by firmware update and initialize relevant
- * structures (like sysfs, work, and so on).  You'll need to call
- * rmi_fw_update_cleanup() to free the storage and tear down the
- * structures.
+ * structures (like sysfs).  You'll need to call rmi_fw_update_cleanup()
+ * to free the storage and tear down the structures.
  */
 void rmi_fw_update_init(struct rmi_device *rmi_dev)
 {
@@ -918,13 +903,13 @@ void rmi_fw_update_init(struct rmi_device *rmi_dev)
 
 	data = kzalloc(sizeof(struct rmi_fw_update_data), GFP_KERNEL);
 
-	error = sysfs_create_group(&rmi_dev->dev.kobj, &rmi_fw_update_attributes);
+	error = sysfs_create_group(&rmi_dev->dev.kobj,
+				   &rmi_fw_update_attributes);
 	if (error) {
 		dev_warn(&rmi_dev->dev, "Failed to create fw update sysfs attributes.\n");
 		return;
 	}
 
-	INIT_WORK(&data->update_work, rmi_update_work);
 	data->rmi_dev = rmi_dev;
 	drv_data->fw_update_data = data;
 }

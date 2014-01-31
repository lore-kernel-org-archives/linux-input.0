From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1] HID: hid-sensor-hub: Processing for duplicate physical ids
Date: Fri, 31 Jan 2014 12:04:10 -0800
Message-ID: <1391198650-15468-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:60115 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932238AbaAaUEZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Jan 2014 15:04:25 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: jic23@kernel.org, linux-input@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Archana Patni <archana.patni@intel.com>

In HID sensor hub, HID physical ids are used to represent different
sensors. For example physical id of 0x73 in usage page = 0x20, represents
an accelerometer. The HID sensor hub driver uses this physical ids to
create platform devices using MFD. There is 1:1 correspondence between
an phy id and a client driver.
But in some cases these physical ids are reused. There is a phy id 0xe1,
which specifies a custom sensor, which can exist multiple times to represent
various custom sensors. In this case there can be multiple instances
of client MFD drivers, processing specific custom sensor. In this
case when client driver looks for report id or a field index, it
should still get the report id specific to its own type. This is
also true for reports, they should be directed towards correct instance.
This change introduce a way to parse and tie physical devices to their
correct instance.
Summary of changes:
- To get physical ids, use collections. If a collection of type=physical
exist then use usage id as in the name of platform device name
- As part of the platform data, we assign a hdsev instance, which has
start and end of collection indexes. Using these indexes attributes
can be tied to correct MFD client instances
- When a report is received, call callback with correct hsdev instance.
In this way using its private data stored as part of its registry, it
can distinguish different sensors even when they have same physical and
logical ids.
This patch is co-authored with Archana Patni<archna.patni@intel.com>.

Reported-by: Archana Patni <archana.patni@intel.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Archana Patni <archana.patni@intel.com>
---
 drivers/hid/hid-sensor-hub.c   | 188 ++++++++++++++++++++++-------------------
 include/linux/hid-sensor-hub.h |   6 +-
 2 files changed, 106 insertions(+), 88 deletions(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index ad2b869..5ab93cb 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -56,9 +56,9 @@ struct sensor_hub_pending {
  * @dyn_callback_lock:	spin lock to protect callback list
  * @hid_sensor_hub_client_devs:	Stores all MFD cells for a hub instance.
  * @hid_sensor_client_cnt: Number of MFD cells, (no of sensors attached).
+ * @ref_cnt:		Number of MFD clients have opened this device
  */
 struct sensor_hub_data {
-	struct hid_sensor_hub_device *hsdev;
 	struct mutex mutex;
 	spinlock_t lock;
 	struct sensor_hub_pending pending;
@@ -67,6 +67,7 @@ struct sensor_hub_data {
 	struct mfd_cell *hid_sensor_hub_client_devs;
 	int hid_sensor_client_cnt;
 	unsigned long quirks;
+	int ref_cnt;
 };
 
 /**
@@ -79,6 +80,7 @@ struct sensor_hub_data {
 struct hid_sensor_hub_callbacks_list {
 	struct list_head list;
 	u32 usage_id;
+	struct hid_sensor_hub_device *hsdev;
 	struct hid_sensor_hub_callbacks *usage_callback;
 	void *priv;
 };
@@ -97,20 +99,18 @@ static struct hid_report *sensor_hub_report(int id, struct hid_device *hdev,
 	return NULL;
 }
 
-static int sensor_hub_get_physical_device_count(
-				struct hid_report_enum *report_enum)
+static int sensor_hub_get_physical_device_count(struct hid_device *hdev)
 {
-	struct hid_report *report;
-	struct hid_field *field;
-	int cnt = 0;
+	int i;
+	int count = 0;
 
-	list_for_each_entry(report, &report_enum->report_list, list) {
-		field = report->field[0];
-		if (report->maxfield && field && field->physical)
-			cnt++;
+	for (i = 0; i < hdev->maxcollection; ++i) {
+		struct hid_collection *collection = &hdev->collection[i];
+		if (collection->type == HID_COLLECTION_PHYSICAL)
+			++count;
 	}
 
-	return cnt;
+	return count;
 }
 
 static void sensor_hub_fill_attr_info(
@@ -128,15 +128,23 @@ static void sensor_hub_fill_attr_info(
 
 static struct hid_sensor_hub_callbacks *sensor_hub_get_callback(
 					struct hid_device *hdev,
-					u32 usage_id, void **priv)
+					u32 usage_id,
+					int collection_index,
+					struct hid_sensor_hub_device **hsdev,
+					void **priv)
 {
 	struct hid_sensor_hub_callbacks_list *callback;
 	struct sensor_hub_data *pdata = hid_get_drvdata(hdev);
 
 	spin_lock(&pdata->dyn_callback_lock);
 	list_for_each_entry(callback, &pdata->dyn_callback_list, list)
-		if (callback->usage_id == usage_id) {
+		if (callback->usage_id == usage_id &&
+			(collection_index >=
+				callback->hsdev->start_collection_index) &&
+			(collection_index <
+				callback->hsdev->end_collection_index)) {
 			*priv = callback->priv;
+			*hsdev = callback->hsdev;
 			spin_unlock(&pdata->dyn_callback_lock);
 			return callback->usage_callback;
 		}
@@ -154,7 +162,8 @@ int sensor_hub_register_callback(struct hid_sensor_hub_device *hsdev,
 
 	spin_lock(&pdata->dyn_callback_lock);
 	list_for_each_entry(callback, &pdata->dyn_callback_list, list)
-		if (callback->usage_id == usage_id) {
+		if (callback->usage_id == usage_id &&
+						callback->hsdev == hsdev) {
 			spin_unlock(&pdata->dyn_callback_lock);
 			return -EINVAL;
 		}
@@ -163,6 +172,7 @@ int sensor_hub_register_callback(struct hid_sensor_hub_device *hsdev,
 		spin_unlock(&pdata->dyn_callback_lock);
 		return -ENOMEM;
 	}
+	callback->hsdev = hsdev;
 	callback->usage_callback = usage_callback;
 	callback->usage_id = usage_id;
 	callback->priv = NULL;
@@ -181,7 +191,8 @@ int sensor_hub_remove_callback(struct hid_sensor_hub_device *hsdev,
 
 	spin_lock(&pdata->dyn_callback_lock);
 	list_for_each_entry(callback, &pdata->dyn_callback_list, list)
-		if (callback->usage_id == usage_id) {
+		if (callback->usage_id == usage_id &&
+						callback->hsdev == hsdev) {
 			list_del(&callback->list);
 			kfree(callback);
 			break;
@@ -320,8 +331,7 @@ int sensor_hub_input_get_attribute_info(struct hid_sensor_hub_device *hsdev,
 				struct hid_sensor_hub_attribute_info *info)
 {
 	int ret = -1;
-	int i, j;
-	int collection_index = -1;
+	int i;
 	struct hid_report *report;
 	struct hid_field *field;
 	struct hid_report_enum *report_enum;
@@ -335,44 +345,31 @@ int sensor_hub_input_get_attribute_info(struct hid_sensor_hub_device *hsdev,
 	info->units = -1;
 	info->unit_expo = -1;
 
-	for (i = 0; i < hdev->maxcollection; ++i) {
-		struct hid_collection *collection = &hdev->collection[i];
-		if (usage_id == collection->usage) {
-			collection_index = i;
-			break;
-		}
-	}
-	if (collection_index == -1)
-		goto err_ret;
-
 	report_enum = &hdev->report_enum[type];
 	list_for_each_entry(report, &report_enum->report_list, list) {
 		for (i = 0; i < report->maxfield; ++i) {
 			field = report->field[i];
-			if (field->physical == usage_id &&
-				field->logical == attr_usage_id) {
-				sensor_hub_fill_attr_info(info, i, report->id,
-							  field);
-				ret = 0;
-			} else {
-				for (j = 0; j < field->maxusage; ++j) {
-					if (field->usage[j].hid ==
-					attr_usage_id &&
-					field->usage[j].collection_index ==
-					collection_index) {
-						sensor_hub_fill_attr_info(info,
-							  i, report->id, field);
-						ret = 0;
-						break;
-					}
+			if (field->maxusage) {
+				if (field->physical == usage_id &&
+					(field->logical == attr_usage_id ||
+					field->usage[0].hid ==
+							attr_usage_id) &&
+					(field->usage[0].collection_index >=
+					hsdev->start_collection_index) &&
+					(field->usage[0].collection_index <
+					hsdev->end_collection_index)) {
+
+					sensor_hub_fill_attr_info(info, i,
+								report->id,
+								field);
+					ret = 0;
+					break;
 				}
 			}
-			if (ret == 0)
-				break;
 		}
+
 	}
 
-err_ret:
 	return ret;
 }
 EXPORT_SYMBOL_GPL(sensor_hub_input_get_attribute_info);
@@ -388,7 +385,7 @@ static int sensor_hub_suspend(struct hid_device *hdev, pm_message_t message)
 	list_for_each_entry(callback, &pdata->dyn_callback_list, list) {
 		if (callback->usage_callback->suspend)
 			callback->usage_callback->suspend(
-					pdata->hsdev, callback->priv);
+					callback->hsdev, callback->priv);
 	}
 	spin_unlock(&pdata->dyn_callback_lock);
 
@@ -405,7 +402,7 @@ static int sensor_hub_resume(struct hid_device *hdev)
 	list_for_each_entry(callback, &pdata->dyn_callback_list, list) {
 		if (callback->usage_callback->resume)
 			callback->usage_callback->resume(
-					pdata->hsdev, callback->priv);
+					callback->hsdev, callback->priv);
 	}
 	spin_unlock(&pdata->dyn_callback_lock);
 
@@ -432,6 +429,7 @@ static int sensor_hub_raw_event(struct hid_device *hdev,
 	struct hid_sensor_hub_callbacks *callback = NULL;
 	struct hid_collection *collection = NULL;
 	void *priv = NULL;
+	struct hid_sensor_hub_device *hsdev = NULL;
 
 	hid_dbg(hdev, "sensor_hub_raw_event report id:0x%x size:%d type:%d\n",
 			 report->id, size, report->type);
@@ -466,23 +464,26 @@ static int sensor_hub_raw_event(struct hid_device *hdev,
 				report->field[i]->usage->collection_index];
 		hid_dbg(hdev, "collection->usage %x\n",
 					collection->usage);
-		callback = sensor_hub_get_callback(pdata->hsdev->hdev,
-						report->field[i]->physical,
-							&priv);
+
+		callback = sensor_hub_get_callback(hdev,
+				report->field[i]->physical,
+				report->field[i]->usage[0].collection_index,
+				&hsdev, &priv);
+
 		if (callback && callback->capture_sample) {
 			if (report->field[i]->logical)
-				callback->capture_sample(pdata->hsdev,
+				callback->capture_sample(hsdev,
 					report->field[i]->logical, sz, ptr,
 					callback->pdev);
 			else
-				callback->capture_sample(pdata->hsdev,
+				callback->capture_sample(hsdev,
 					report->field[i]->usage->hid, sz, ptr,
 					callback->pdev);
 		}
 		ptr += sz;
 	}
 	if (callback && collection && callback->send_event)
-		callback->send_event(pdata->hsdev, collection->usage,
+		callback->send_event(hsdev, collection->usage,
 				callback->pdev);
 	spin_unlock_irqrestore(&pdata->lock, flags);
 
@@ -495,7 +496,7 @@ int sensor_hub_device_open(struct hid_sensor_hub_device *hsdev)
 	struct sensor_hub_data *data =  hid_get_drvdata(hsdev->hdev);
 
 	mutex_lock(&data->mutex);
-	if (!hsdev->ref_cnt) {
+	if (!data->ref_cnt) {
 		ret = hid_hw_open(hsdev->hdev);
 		if (ret) {
 			hid_err(hsdev->hdev, "failed to open hid device\n");
@@ -503,7 +504,7 @@ int sensor_hub_device_open(struct hid_sensor_hub_device *hsdev)
 			return ret;
 		}
 	}
-	hsdev->ref_cnt++;
+	data->ref_cnt++;
 	mutex_unlock(&data->mutex);
 
 	return ret;
@@ -515,8 +516,8 @@ void sensor_hub_device_close(struct hid_sensor_hub_device *hsdev)
 	struct sensor_hub_data *data =  hid_get_drvdata(hsdev->hdev);
 
 	mutex_lock(&data->mutex);
-	hsdev->ref_cnt--;
-	if (!hsdev->ref_cnt)
+	data->ref_cnt--;
+	if (!data->ref_cnt)
 		hid_hw_close(hsdev->hdev);
 	mutex_unlock(&data->mutex);
 }
@@ -563,26 +564,19 @@ static int sensor_hub_probe(struct hid_device *hdev,
 	struct sensor_hub_data *sd;
 	int i;
 	char *name;
-	struct hid_report *report;
-	struct hid_report_enum *report_enum;
-	struct hid_field *field;
 	int dev_cnt;
+	struct hid_sensor_hub_device *hsdev;
+	struct hid_sensor_hub_device *last_hsdev = NULL;
 
 	sd = devm_kzalloc(&hdev->dev, sizeof(*sd), GFP_KERNEL);
 	if (!sd) {
 		hid_err(hdev, "cannot allocate Sensor data\n");
 		return -ENOMEM;
 	}
-	sd->hsdev = devm_kzalloc(&hdev->dev, sizeof(*sd->hsdev), GFP_KERNEL);
-	if (!sd->hsdev) {
-		hid_err(hdev, "cannot allocate hid_sensor_hub_device\n");
-		return -ENOMEM;
-	}
+
 	hid_set_drvdata(hdev, sd);
 	sd->quirks = id->driver_data;
-	sd->hsdev->hdev = hdev;
-	sd->hsdev->vendor_id = hdev->vendor;
-	sd->hsdev->product_id = hdev->product;
+
 	spin_lock_init(&sd->lock);
 	spin_lock_init(&sd->dyn_callback_lock);
 	mutex_init(&sd->mutex);
@@ -600,9 +594,8 @@ static int sensor_hub_probe(struct hid_device *hdev,
 	}
 	INIT_LIST_HEAD(&sd->dyn_callback_list);
 	sd->hid_sensor_client_cnt = 0;
-	report_enum = &hdev->report_enum[HID_INPUT_REPORT];
 
-	dev_cnt = sensor_hub_get_physical_device_count(report_enum);
+	dev_cnt = sensor_hub_get_physical_device_count(hdev);
 	if (dev_cnt > HID_MAX_PHY_DEVICES) {
 		hid_err(hdev, "Invalid Physical device count\n");
 		ret = -EINVAL;
@@ -616,42 +609,63 @@ static int sensor_hub_probe(struct hid_device *hdev,
 			ret = -ENOMEM;
 			goto err_stop_hw;
 	}
-	list_for_each_entry(report, &report_enum->report_list, list) {
-		hid_dbg(hdev, "Report id:%x\n", report->id);
-		field = report->field[0];
-		if (report->maxfield && field &&
-					field->physical) {
+
+	for (i = 0; i < hdev->maxcollection; ++i) {
+		struct hid_collection *collection = &hdev->collection[i];
+
+		if (collection->type == HID_COLLECTION_PHYSICAL) {
+
+			hsdev = kzalloc(sizeof(*hsdev), GFP_KERNEL);
+			if (!hsdev) {
+				hid_err(hdev, "cannot allocate hid_sensor_hub_device\n");
+				ret = -ENOMEM;
+				goto err_no_mem;
+			}
+			hsdev->hdev = hdev;
+			hsdev->vendor_id = hdev->vendor;
+			hsdev->product_id = hdev->product;
+			hsdev->start_collection_index = i;
+			if (last_hsdev)
+				last_hsdev->end_collection_index = i;
+			last_hsdev = hsdev;
 			name = kasprintf(GFP_KERNEL, "HID-SENSOR-%x",
-						field->physical);
+					collection->usage);
 			if (name == NULL) {
 				hid_err(hdev, "Failed MFD device name\n");
 					ret = -ENOMEM;
-					goto err_free_names;
+					goto err_no_mem;
 			}
 			sd->hid_sensor_hub_client_devs[
-				sd->hid_sensor_client_cnt].id = PLATFORM_DEVID_AUTO;
+				sd->hid_sensor_client_cnt].id =
+							PLATFORM_DEVID_AUTO;
 			sd->hid_sensor_hub_client_devs[
 				sd->hid_sensor_client_cnt].name = name;
 			sd->hid_sensor_hub_client_devs[
 				sd->hid_sensor_client_cnt].platform_data =
-						sd->hsdev;
+							hsdev;
 			sd->hid_sensor_hub_client_devs[
 				sd->hid_sensor_client_cnt].pdata_size =
-						sizeof(*sd->hsdev);
-			hid_dbg(hdev, "Adding %s:%p\n", name, sd);
+							sizeof(*hsdev);
+			hid_dbg(hdev, "Adding %s:%d\n", name,
+					hsdev->start_collection_index);
 			sd->hid_sensor_client_cnt++;
 		}
 	}
+	if (last_hsdev)
+		last_hsdev->end_collection_index = i;
+
 	ret = mfd_add_devices(&hdev->dev, 0, sd->hid_sensor_hub_client_devs,
 		sd->hid_sensor_client_cnt, NULL, 0, NULL);
 	if (ret < 0)
-		goto err_free_names;
+		goto err_no_mem;
 
 	return ret;
 
-err_free_names:
-	for (i = 0; i < sd->hid_sensor_client_cnt ; ++i)
+err_no_mem:
+	for (i = 0; i < sd->hid_sensor_client_cnt; ++i) {
 		kfree(sd->hid_sensor_hub_client_devs[i].name);
+		kfree(sd->hid_sensor_hub_client_devs[i].platform_data);
+	}
 	kfree(sd->hid_sensor_hub_client_devs);
 err_stop_hw:
 	hid_hw_stop(hdev);
@@ -673,8 +687,10 @@ static void sensor_hub_remove(struct hid_device *hdev)
 		complete(&data->pending.ready);
 	spin_unlock_irqrestore(&data->lock, flags);
 	mfd_remove_devices(&hdev->dev);
-	for (i = 0; i < data->hid_sensor_client_cnt ; ++i)
+	for (i = 0; i < data->hid_sensor_client_cnt; ++i) {
 		kfree(data->hid_sensor_hub_client_devs[i].name);
+		kfree(data->hid_sensor_hub_client_devs[i].platform_data);
+	}
 	kfree(data->hid_sensor_hub_client_devs);
 	hid_set_drvdata(hdev, NULL);
 	mutex_destroy(&data->mutex);
diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
index 205eba0..b70cfd7 100644
--- a/include/linux/hid-sensor-hub.h
+++ b/include/linux/hid-sensor-hub.h
@@ -51,13 +51,15 @@ struct hid_sensor_hub_attribute_info {
  * @hdev:		Stores the hid instance.
  * @vendor_id:		Vendor id of hub device.
  * @product_id:		Product id of hub device.
- * @ref_cnt:		Number of MFD clients have opened this device
+ * @start_collection_index: Starting index for a phy type collection
+ * @end_collection_index: Last index for a phy type collection
  */
 struct hid_sensor_hub_device {
 	struct hid_device *hdev;
 	u32 vendor_id;
 	u32 product_id;
-	int ref_cnt;
+	int start_collection_index;
+	int end_collection_index;
 };
 
 /**
-- 
1.8.3.2


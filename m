From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/2] HID: hid-sensor-hub: Allow parallel synchronous reads
Date: Wed,  7 Jan 2015 10:24:10 -0800
Message-ID: <1420655051-6587-2-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1420655051-6587-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:25063 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754392AbbAGSZS (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 7 Jan 2015 13:25:18 -0500
In-Reply-To: <1420655051-6587-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, jic23@kernel.org
Cc: linux-iio@vger.kernel.org, linux-input@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Current implementation only allows one outstanding synchronous read.
This is a performance hit when user mode is requesting raw reads
of sensor attributes on multiple sensors together.
This change changes the mutex lock to per hid sensor hub device instead
of global lock. Although request to hid sensor hub is serialized, there
can be multiple outstanding read requests pending for responses via
hid reports.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/hid-sensor-hub.c   | 90 +++++++++++++++++++-----------------------
 include/linux/hid-sensor-hub.h | 24 +++++++++++
 2 files changed, 65 insertions(+), 49 deletions(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index e54ce10..865cd56 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -29,29 +29,10 @@
 #define HID_SENSOR_HUB_ENUM_QUIRK	0x01
 
 /**
- * struct sensor_hub_pending - Synchronous read pending information
- * @status:		Pending status true/false.
- * @ready:		Completion synchronization data.
- * @usage_id:		Usage id for physical device, E.g. Gyro usage id.
- * @attr_usage_id:	Usage Id of a field, E.g. X-AXIS for a gyro.
- * @raw_size:		Response size for a read request.
- * @raw_data:		Place holder for received response.
- */
-struct sensor_hub_pending {
-	bool status;
-	struct completion ready;
-	u32 usage_id;
-	u32 attr_usage_id;
-	int raw_size;
-	u8  *raw_data;
-};
-
-/**
  * struct sensor_hub_data - Hold a instance data for a HID hub device
  * @hsdev:		Stored hid instance for current hub device.
  * @mutex:		Mutex to serialize synchronous request.
  * @lock:		Spin lock to protect pending request structure.
- * @pending:		Holds information of pending sync read request.
  * @dyn_callback_list:	Holds callback function
  * @dyn_callback_lock:	spin lock to protect callback list
  * @hid_sensor_hub_client_devs:	Stores all MFD cells for a hub instance.
@@ -61,7 +42,6 @@ struct sensor_hub_pending {
 struct sensor_hub_data {
 	struct mutex mutex;
 	spinlock_t lock;
-	struct sensor_hub_pending pending;
 	struct list_head dyn_callback_list;
 	spinlock_t dyn_callback_lock;
 	struct mfd_cell *hid_sensor_hub_client_devs;
@@ -266,40 +246,42 @@ int sensor_hub_input_attr_get_raw_value(struct hid_sensor_hub_device *hsdev,
 	struct hid_report *report;
 	int ret_val = 0;
 
-	mutex_lock(&data->mutex);
-	memset(&data->pending, 0, sizeof(data->pending));
-	init_completion(&data->pending.ready);
-	data->pending.usage_id = usage_id;
-	data->pending.attr_usage_id = attr_usage_id;
-	data->pending.raw_size = 0;
+	mutex_lock(&hsdev->mutex);
+	memset(&hsdev->pending, 0, sizeof(hsdev->pending));
+	init_completion(&hsdev->pending.ready);
+	hsdev->pending.usage_id = usage_id;
+	hsdev->pending.attr_usage_id = attr_usage_id;
+	hsdev->pending.raw_size = 0;
 
 	spin_lock_irqsave(&data->lock, flags);
-	data->pending.status = true;
+	hsdev->pending.status = true;
 	spin_unlock_irqrestore(&data->lock, flags);
 	report = sensor_hub_report(report_id, hsdev->hdev, HID_INPUT_REPORT);
 	if (!report)
 		goto err_free;
 
+	mutex_lock(&data->mutex);
 	hid_hw_request(hsdev->hdev, report, HID_REQ_GET_REPORT);
-	wait_for_completion_interruptible_timeout(&data->pending.ready, HZ*5);
-	switch (data->pending.raw_size) {
+	mutex_unlock(&data->mutex);
+	wait_for_completion_interruptible_timeout(&hsdev->pending.ready, HZ*5);
+	switch (hsdev->pending.raw_size) {
 	case 1:
-		ret_val = *(u8 *)data->pending.raw_data;
+		ret_val = *(u8 *)hsdev->pending.raw_data;
 		break;
 	case 2:
-		ret_val = *(u16 *)data->pending.raw_data;
+		ret_val = *(u16 *)hsdev->pending.raw_data;
 		break;
 	case 4:
-		ret_val = *(u32 *)data->pending.raw_data;
+		ret_val = *(u32 *)hsdev->pending.raw_data;
 		break;
 	default:
 		ret_val = 0;
 	}
-	kfree(data->pending.raw_data);
+	kfree(hsdev->pending.raw_data);
 
 err_free:
-	data->pending.status = false;
-	mutex_unlock(&data->mutex);
+	hsdev->pending.status = false;
+	mutex_unlock(&hsdev->mutex);
 
 	return ret_val;
 }
@@ -455,16 +437,6 @@ static int sensor_hub_raw_event(struct hid_device *hdev,
 					report->field[i]->report_count)/8);
 		sz = (report->field[i]->report_size *
 					report->field[i]->report_count)/8;
-		if (pdata->pending.status && pdata->pending.attr_usage_id ==
-				report->field[i]->usage->hid) {
-			hid_dbg(hdev, "data was pending ...\n");
-			pdata->pending.raw_data = kmemdup(ptr, sz, GFP_ATOMIC);
-			if (pdata->pending.raw_data)
-				pdata->pending.raw_size = sz;
-			else
-				pdata->pending.raw_size = 0;
-			complete(&pdata->pending.ready);
-		}
 		collection = &hdev->collection[
 				report->field[i]->usage->collection_index];
 		hid_dbg(hdev, "collection->usage %x\n",
@@ -474,8 +446,21 @@ static int sensor_hub_raw_event(struct hid_device *hdev,
 				report->field[i]->physical,
 				report->field[i]->usage[0].collection_index,
 				&hsdev, &priv);
-
-		if (callback && callback->capture_sample) {
+		if (!callback) {
+			ptr += sz;
+			continue;
+		}
+		if (hsdev->pending.status && hsdev->pending.attr_usage_id ==
+				report->field[i]->usage->hid) {
+			hid_dbg(hdev, "data was pending ...\n");
+			hsdev->pending.raw_data = kmemdup(ptr, sz, GFP_ATOMIC);
+			if (hsdev->pending.raw_data)
+				hsdev->pending.raw_size = sz;
+			else
+				hsdev->pending.raw_size = 0;
+			complete(&hsdev->pending.ready);
+		}
+		if (callback->capture_sample) {
 			if (report->field[i]->logical)
 				callback->capture_sample(hsdev,
 					report->field[i]->logical, sz, ptr,
@@ -630,6 +615,8 @@ static int sensor_hub_probe(struct hid_device *hdev,
 			hsdev->hdev = hdev;
 			hsdev->vendor_id = hdev->vendor;
 			hsdev->product_id = hdev->product;
+			hsdev->usage = collection->usage;
+			mutex_init(&hsdev->mutex);
 			hsdev->start_collection_index = i;
 			if (last_hsdev)
 				last_hsdev->end_collection_index = i;
@@ -676,13 +663,18 @@ static void sensor_hub_remove(struct hid_device *hdev)
 {
 	struct sensor_hub_data *data = hid_get_drvdata(hdev);
 	unsigned long flags;
+	int i;
 
 	hid_dbg(hdev, " hardware removed\n");
 	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
 	spin_lock_irqsave(&data->lock, flags);
-	if (data->pending.status)
-		complete(&data->pending.ready);
+	for (i = 0; i < data->hid_sensor_client_cnt; ++i) {
+		struct hid_sensor_hub_device *hsdev =
+			data->hid_sensor_hub_client_devs[i].platform_data;
+		if (hsdev->pending.status)
+			complete(&hsdev->pending.ready);
+	}
 	spin_unlock_irqrestore(&data->lock, flags);
 	mfd_remove_devices(&hdev->dev);
 	hid_set_drvdata(hdev, NULL);
diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
index 4173a8f..0b21c4f 100644
--- a/include/linux/hid-sensor-hub.h
+++ b/include/linux/hid-sensor-hub.h
@@ -49,19 +49,43 @@ struct hid_sensor_hub_attribute_info {
 };
 
 /**
+ * struct sensor_hub_pending - Synchronous read pending information
+ * @status:		Pending status true/false.
+ * @ready:		Completion synchronization data.
+ * @usage_id:		Usage id for physical device, E.g. Gyro usage id.
+ * @attr_usage_id:	Usage Id of a field, E.g. X-AXIS for a gyro.
+ * @raw_size:		Response size for a read request.
+ * @raw_data:		Place holder for received response.
+ */
+struct sensor_hub_pending {
+	bool status;
+	struct completion ready;
+	u32 usage_id;
+	u32 attr_usage_id;
+	int raw_size;
+	u8  *raw_data;
+};
+
+/**
  * struct hid_sensor_hub_device - Stores the hub instance data
  * @hdev:		Stores the hid instance.
  * @vendor_id:		Vendor id of hub device.
  * @product_id:		Product id of hub device.
+ * @usage:		Usage id for this hub device instance.
  * @start_collection_index: Starting index for a phy type collection
  * @end_collection_index: Last index for a phy type collection
+ * @mutex:		synchronizing mutex.
+ * @pending:		Holds information of pending sync read request.
  */
 struct hid_sensor_hub_device {
 	struct hid_device *hdev;
 	u32 vendor_id;
 	u32 product_id;
+	u32 usage;
 	int start_collection_index;
 	int end_collection_index;
+	struct mutex mutex;
+	struct sensor_hub_pending pending;
 };
 
 /**
-- 
1.9.3


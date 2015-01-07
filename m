From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/2] HID: hid-sensor-hub: Add collection device
Date: Wed,  7 Jan 2015 10:24:11 -0800
Message-ID: <1420655051-6587-3-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1420655051-6587-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:25746 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753683AbbAGSZR (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 7 Jan 2015 13:25:17 -0500
In-Reply-To: <1420655051-6587-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, jic23@kernel.org
Cc: linux-iio@vger.kernel.org, linux-input@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

HID sensor hub exports several sensor which are fusion sensors, where
data is interpreted from one or more sensors. Some of them can't be
exported via IIO like sysfs as the user space download some firmware,
which defines what sensor will look like. They can be a part of a
collection.
Creating a MFD cell for a collection to write a standalone driver
to manage collections. Most of the time they will be propritery drivers
may not be even upstreamed. This patch allows framework to have
capability to write such drivers.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/hid-sensor-hub.c   | 50 ++++++++++++++++++++++++++++++++++++++----
 include/linux/hid-sensor-ids.h |  2 ++
 2 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 865cd56..83b6e15 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -119,11 +119,12 @@ static struct hid_sensor_hub_callbacks *sensor_hub_get_callback(
 
 	spin_lock_irqsave(&pdata->dyn_callback_lock, flags);
 	list_for_each_entry(callback, &pdata->dyn_callback_list, list)
-		if (callback->usage_id == usage_id &&
+		if (callback->usage_id == HID_USAGE_SENSOR_TYPE_COLLECTION ||
+			(callback->usage_id == usage_id &&
 			(collection_index >=
 				callback->hsdev->start_collection_index) &&
 			(collection_index <
-				callback->hsdev->end_collection_index)) {
+				callback->hsdev->end_collection_index))) {
 			*priv = callback->priv;
 			*hsdev = callback->hsdev;
 			spin_unlock_irqrestore(&pdata->dyn_callback_lock,
@@ -159,7 +160,12 @@ int sensor_hub_register_callback(struct hid_sensor_hub_device *hsdev,
 	callback->usage_callback = usage_callback;
 	callback->usage_id = usage_id;
 	callback->priv = NULL;
-	list_add_tail(&callback->list, &pdata->dyn_callback_list);
+	/* Give higher priority to collection device, so add to front */
+	if (usage_id == HID_USAGE_SENSOR_TYPE_COLLECTION)
+		list_add(&callback->list, &pdata->dyn_callback_list);
+	else
+		list_add_tail(&callback->list, &pdata->dyn_callback_list);
+
 	spin_unlock_irqrestore(&pdata->dyn_callback_lock, flags);
 
 	return 0;
@@ -547,6 +553,37 @@ static __u8 *sensor_hub_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 	return rdesc;
 }
 
+static int sensor_hub_add_collection_device(struct hid_device *hdev,
+					    struct sensor_hub_data *sd)
+{
+	struct hid_sensor_hub_device *hsdev;
+	char *name;
+
+	hsdev = devm_kzalloc(&hdev->dev, sizeof(*hsdev), GFP_KERNEL);
+	if (!hsdev)
+		return -ENOMEM;
+
+	hsdev->hdev = hdev;
+	hsdev->vendor_id = hdev->vendor;
+	hsdev->product_id = hdev->product;
+	hsdev->usage = HID_USAGE_SENSOR_TYPE_COLLECTION;
+	mutex_init(&hsdev->mutex);
+	name = devm_kasprintf(&hdev->dev, GFP_KERNEL, "HID-SENSOR-%x",
+			      HID_USAGE_SENSOR_TYPE_COLLECTION);
+	if (name == NULL) {
+		hid_err(hdev, "Failed MFD device name\n");
+		return -ENOMEM;
+	}
+	sd->hid_sensor_hub_client_devs[sd->hid_sensor_client_cnt].name = name;
+	sd->hid_sensor_hub_client_devs[
+			sd->hid_sensor_client_cnt].platform_data = hsdev;
+	sd->hid_sensor_hub_client_devs[
+			sd->hid_sensor_client_cnt].pdata_size = sizeof(*hsdev);
+	sd->hid_sensor_client_cnt++;
+
+	return 0;
+}
+
 static int sensor_hub_probe(struct hid_device *hdev,
 				const struct hid_device_id *id)
 {
@@ -591,7 +628,8 @@ static int sensor_hub_probe(struct hid_device *hdev,
 		ret = -EINVAL;
 		goto err_stop_hw;
 	}
-	sd->hid_sensor_hub_client_devs = devm_kzalloc(&hdev->dev, dev_cnt *
+	sd->hid_sensor_hub_client_devs = devm_kzalloc(&hdev->dev,
+						      (dev_cnt + 1) *
 						      sizeof(struct mfd_cell),
 						      GFP_KERNEL);
 	if (sd->hid_sensor_hub_client_devs == NULL) {
@@ -645,6 +683,10 @@ static int sensor_hub_probe(struct hid_device *hdev,
 	if (last_hsdev)
 		last_hsdev->end_collection_index = i;
 
+	ret = sensor_hub_add_collection_device(hdev, sd);
+	if (ret)
+		goto err_stop_hw;
+
 	ret = mfd_add_hotplug_devices(&hdev->dev,
 			sd->hid_sensor_hub_client_devs,
 			sd->hid_sensor_client_cnt);
diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
index 109f0e6..300ffea 100644
--- a/include/linux/hid-sensor-ids.h
+++ b/include/linux/hid-sensor-ids.h
@@ -21,6 +21,8 @@
 
 #define HID_MAX_PHY_DEVICES					0xFF
 
+#define HID_USAGE_SENSOR_TYPE_COLLECTION			0x200001
+
 /* Accel 3D (200073) */
 #define HID_USAGE_SENSOR_ACCEL_3D				0x200073
 #define HID_USAGE_SENSOR_DATA_ACCELERATION			0x200452
-- 
1.9.3


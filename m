From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] HID: hid-sensor-hub: Fix kernel warning and failure
Date: Thu,  5 Dec 2013 11:56:49 -0800
Message-ID: <1386273409-30752-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:13409 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751352Ab3LET6O (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 5 Dec 2013 14:58:14 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Fix kernel warning and failure to register sensor hub devices with MFD.
Now many devices has in-built sensor hubs. So by default this HID hub,
is properly parsed and register individual sensors as platform device
using MFD framework. But if a second sensor hub is attached via USB,
which has same sensors, it will result in kernel warning and failure
to register MFD cell as the platform device sysfs file name will be
same as created by in-built sensor hubs. This patch uses MFD cell id
to genarate unique platform device name. In this way there will never
be duplicate sysfs file names.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/hid-sensor-hub.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index a184e19..4cead68 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -22,6 +22,7 @@
 #include <linux/slab.h>
 #include <linux/mfd/core.h>
 #include <linux/list.h>
+#include <linux/idr.h>
 #include <linux/hid-sensor-ids.h>
 #include <linux/hid-sensor-hub.h>
 #include "hid-ids.h"
@@ -80,6 +81,8 @@ struct hid_sensor_hub_callbacks_list {
 	void *priv;
 };
 
+static DEFINE_IDR(hid_sensor_hub_idr);
+
 static struct hid_report *sensor_hub_report(int id, struct hid_device *hdev,
 						int dir)
 {
@@ -512,6 +515,7 @@ static int sensor_hub_probe(struct hid_device *hdev,
 	struct hid_report_enum *report_enum;
 	struct hid_field *field;
 	int dev_cnt;
+	int cell_id;
 
 	sd = devm_kzalloc(&hdev->dev, sizeof(*sd), GFP_KERNEL);
 	if (!sd) {
@@ -565,6 +569,11 @@ static int sensor_hub_probe(struct hid_device *hdev,
 		field = report->field[0];
 		if (report->maxfield && field &&
 					field->physical) {
+			cell_id = idr_alloc(&hid_sensor_hub_idr,
+							NULL, 0, 0,
+							GFP_KERNEL);
+			if (cell_id < 0)
+					goto err_free_names;
 			name = kasprintf(GFP_KERNEL, "HID-SENSOR-%x",
 						field->physical);
 			if (name == NULL) {
@@ -573,6 +582,8 @@ static int sensor_hub_probe(struct hid_device *hdev,
 					goto err_free_names;
 			}
 			sd->hid_sensor_hub_client_devs[
+				sd->hid_sensor_client_cnt].id = cell_id;
+			sd->hid_sensor_hub_client_devs[
 				sd->hid_sensor_client_cnt].name = name;
 			sd->hid_sensor_hub_client_devs[
 				sd->hid_sensor_client_cnt].platform_data =
@@ -592,8 +603,11 @@ static int sensor_hub_probe(struct hid_device *hdev,
 	return ret;
 
 err_free_names:
-	for (i = 0; i < sd->hid_sensor_client_cnt ; ++i)
+	for (i = 0; i < sd->hid_sensor_client_cnt; ++i) {
 		kfree(sd->hid_sensor_hub_client_devs[i].name);
+		idr_remove(&hid_sensor_hub_idr,
+			sd->hid_sensor_hub_client_devs[i].id);
+	}
 	kfree(sd->hid_sensor_hub_client_devs);
 err_stop_hw:
 	hid_hw_stop(hdev);
@@ -615,8 +629,11 @@ static void sensor_hub_remove(struct hid_device *hdev)
 		complete(&data->pending.ready);
 	spin_unlock_irqrestore(&data->lock, flags);
 	mfd_remove_devices(&hdev->dev);
-	for (i = 0; i < data->hid_sensor_client_cnt ; ++i)
+	for (i = 0; i < data->hid_sensor_client_cnt; ++i) {
 		kfree(data->hid_sensor_hub_client_devs[i].name);
+		idr_remove(&hid_sensor_hub_idr,
+			data->hid_sensor_hub_client_devs[i].id);
+	}
 	kfree(data->hid_sensor_hub_client_devs);
 	hid_set_drvdata(hdev, NULL);
 	mutex_destroy(&data->mutex);
-- 
1.8.1.2


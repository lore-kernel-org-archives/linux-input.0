From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 3/4] hid-sensor-hub: move to devm_kzalloc
Date: Wed, 14 Aug 2013 11:07:10 +0300
Message-ID: <1376467631-20857-3-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1376467631-20857-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:17884 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756769Ab3HNIHa (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Aug 2013 04:07:30 -0400
In-Reply-To: <1376467631-20857-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

devm_kzalloc() will manage resources freeing and allows to make error path
smaller and nicer.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hid/hid-sensor-hub.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index d0687d0..4cb19df 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -477,16 +477,15 @@ static int sensor_hub_probe(struct hid_device *hdev,
 	struct hid_field *field;
 	int dev_cnt;
 
-	sd = kzalloc(sizeof(struct sensor_hub_data), GFP_KERNEL);
+	sd = devm_kzalloc(&hdev->dev, sizeof(*sd), GFP_KERNEL);
 	if (!sd) {
 		hid_err(hdev, "cannot allocate Sensor data\n");
 		return -ENOMEM;
 	}
-	sd->hsdev = kzalloc(sizeof(struct hid_sensor_hub_device), GFP_KERNEL);
+	sd->hsdev = devm_kzalloc(&hdev->dev, sizeof(*sd->hsdev), GFP_KERNEL);
 	if (!sd->hsdev) {
 		hid_err(hdev, "cannot allocate hid_sensor_hub_device\n");
-		ret = -ENOMEM;
-		goto err_free_hub;
+		return -ENOMEM;
 	}
 	hid_set_drvdata(hdev, sd);
 	sd->hsdev->hdev = hdev;
@@ -498,14 +497,14 @@ static int sensor_hub_probe(struct hid_device *hdev,
 	ret = hid_parse(hdev);
 	if (ret) {
 		hid_err(hdev, "parse failed\n");
-		goto err_free;
+		return ret;
 	}
 	INIT_LIST_HEAD(&hdev->inputs);
 
 	ret = hid_hw_start(hdev, 0);
 	if (ret) {
 		hid_err(hdev, "hw start failed\n");
-		goto err_free;
+		return ret;
 	}
 	ret = hid_hw_open(hdev);
 	if (ret) {
@@ -570,10 +569,6 @@ err_close:
 	hid_hw_close(hdev);
 err_stop_hw:
 	hid_hw_stop(hdev);
-err_free:
-	kfree(sd->hsdev);
-err_free_hub:
-	kfree(sd);
 
 	return ret;
 }
@@ -597,8 +592,6 @@ static void sensor_hub_remove(struct hid_device *hdev)
 	kfree(data->hid_sensor_hub_client_devs);
 	hid_set_drvdata(hdev, NULL);
 	mutex_destroy(&data->mutex);
-	kfree(data->hsdev);
-	kfree(data);
 }
 
 static const struct hid_device_id sensor_hub_devices[] = {
-- 
1.8.4.rc2


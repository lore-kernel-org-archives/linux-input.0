From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v4 5/7] iio: hid-sensors: use asynchronous resume
Date: Sun,  7 Aug 2016 02:25:37 -0700
Message-ID: <1470561939-14278-6-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1470561939-14278-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:24529 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751654AbcHGJZv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 7 Aug 2016 05:25:51 -0400
In-Reply-To: <1470561939-14278-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org, jic23@kernel.org
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, srinivas.pandruvada@linux.intel.com

Some platforms power off sensor hubs during S3 suspend, which will require
longer time to resume. This hurts system resume time, so resume
asynchronously.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 21 ++++++++++++++++++++-
 include/linux/hid-sensor-hub.h                      |  1 +
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index 5b41f9d..9784ae3 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -122,6 +122,14 @@ int hid_sensor_power_state(struct hid_sensor_common *st, bool state)
 #endif
 }
 
+static void hid_sensor_set_power_work(struct work_struct *work)
+{
+	struct hid_sensor_common *attrb = container_of(work,
+						       struct hid_sensor_common,
+						       work);
+	_hid_sensor_power_state(attrb, true);
+}
+
 static int hid_sensor_data_rdy_trigger_set_state(struct iio_trigger *trig,
 						bool state)
 {
@@ -170,6 +178,9 @@ int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char *name,
 		goto error_unreg_trigger;
 
 	iio_device_set_drvdata(indio_dev, attrb);
+
+	INIT_WORK(&attrb->work, hid_sensor_set_power_work);
+
 	pm_suspend_ignore_children(&attrb->pdev->dev, true);
 	pm_runtime_enable(&attrb->pdev->dev);
 	/* Default to 3 seconds, but can be changed from sysfs */
@@ -202,7 +213,15 @@ static int hid_sensor_resume(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct hid_sensor_common *attrb = iio_device_get_drvdata(indio_dev);
+	schedule_work(&attrb->work);
+	return 0;
+}
 
+static int hid_sensor_runtime_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct hid_sensor_common *attrb = iio_device_get_drvdata(indio_dev);
 	return _hid_sensor_power_state(attrb, true);
 }
 
@@ -211,7 +230,7 @@ static int hid_sensor_resume(struct device *dev)
 const struct dev_pm_ops hid_sensor_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(hid_sensor_suspend, hid_sensor_resume)
 	SET_RUNTIME_PM_OPS(hid_sensor_suspend,
-			   hid_sensor_resume, NULL)
+			   hid_sensor_runtime_resume, NULL)
 };
 EXPORT_SYMBOL(hid_sensor_pm_ops);
 
diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
index c02b5ce..dd85f35 100644
--- a/include/linux/hid-sensor-hub.h
+++ b/include/linux/hid-sensor-hub.h
@@ -236,6 +236,7 @@ struct hid_sensor_common {
 	struct hid_sensor_hub_attribute_info report_state;
 	struct hid_sensor_hub_attribute_info power_state;
 	struct hid_sensor_hub_attribute_info sensitivity;
+	struct work_struct work;
 };
 
 /* Convert from hid unit expo to regular exponent */
-- 
2.7.4


From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/8] iio: hid_sensor_hub: Common PM functions
Date: Wed,  7 Jan 2015 10:55:53 -0800
Message-ID: <1420656960-7365-2-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1420656960-7365-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:57436 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751745AbbAGS5D (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 7 Jan 2015 13:57:03 -0500
In-Reply-To: <1420656960-7365-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, jic23@kernel.org
Cc: linux-iio@vger.kernel.org, linux-input@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

To improvement power and performance, both regular and run time callbacks
are introduced. Because of auto suspend delay, two consecutive read
don't have to go through full power on/off procedure. The auto suspend
time can be adjusted using regular power attributes of PM sysfs.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../iio/common/hid-sensors/hid-sensor-trigger.c    | 76 +++++++++++++++++++++-
 .../iio/common/hid-sensors/hid-sensor-trigger.h    |  5 ++
 2 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index 910e82a..d128070 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -22,16 +22,18 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/slab.h>
+#include <linux/delay.h>
 #include <linux/hid-sensor-hub.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/trigger.h>
 #include <linux/iio/sysfs.h>
 #include "hid-sensor-trigger.h"
 
-int hid_sensor_power_state(struct hid_sensor_common *st, bool state)
+static int _hid_sensor_power_state(struct hid_sensor_common *st, bool state)
 {
 	int state_val;
 	int report_val;
+	s32 poll_value = 0;
 
 	if (state) {
 		if (sensor_hub_device_open(st->hsdev))
@@ -47,6 +49,8 @@ int hid_sensor_power_state(struct hid_sensor_common *st, bool state)
 			st->report_state.report_id,
 			st->report_state.index,
 			HID_USAGE_SENSOR_PROP_REPORTING_STATE_ALL_EVENTS_ENUM);
+
+		poll_value = hid_sensor_read_poll_value(st);
 	} else {
 		if (!atomic_dec_and_test(&st->data_ready))
 			return 0;
@@ -79,7 +83,34 @@ int hid_sensor_power_state(struct hid_sensor_common *st, bool state)
 	sensor_hub_get_feature(st->hsdev, st->power_state.report_id,
 			       st->power_state.index,
 			       sizeof(state_val), &state_val);
+
+	if (state && poll_value)
+		msleep_interruptible(poll_value * 2);
+
+	return 0;
+}
+
+int hid_sensor_power_state(struct hid_sensor_common *st, bool state)
+{
+#ifdef CONFIG_PM
+	int ret;
+
+	if (state)
+		ret = pm_runtime_get_sync(&st->pdev->dev);
+	else {
+		pm_runtime_mark_last_busy(&st->pdev->dev);
+		ret = pm_runtime_put_autosuspend(&st->pdev->dev);
+	}
+	if (ret < 0) {
+		if (state)
+			pm_runtime_put_noidle(&st->pdev->dev);
+		return ret;
+	}
+
 	return 0;
+#else
+	return _hid_sensor_power_state(st, state);
+#endif
 }
 EXPORT_SYMBOL(hid_sensor_power_state);
 
@@ -126,8 +157,21 @@ int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char *name,
 	attrb->trigger = trig;
 	indio_dev->trig = iio_trigger_get(trig);
 
-	return ret;
+	ret = pm_runtime_set_active(&indio_dev->dev);
+	if (ret)
+		goto error_unreg_trigger;
+
+	iio_device_set_drvdata(indio_dev, attrb);
+	pm_suspend_ignore_children(&attrb->pdev->dev, true);
+	pm_runtime_enable(&attrb->pdev->dev);
+	/* Default to 3 seconds, but can be changed from sysfs */
+	pm_runtime_set_autosuspend_delay(&attrb->pdev->dev,
+					 3000);
+	pm_runtime_use_autosuspend(&attrb->pdev->dev);
 
+	return ret;
+error_unreg_trigger:
+	iio_trigger_unregister(trig);
 error_free_trig:
 	iio_trigger_free(trig);
 error_ret:
@@ -135,6 +179,34 @@ error_ret:
 }
 EXPORT_SYMBOL(hid_sensor_setup_trigger);
 
+#ifdef CONFIG_PM
+static int hid_sensor_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct hid_sensor_common *attrb = iio_device_get_drvdata(indio_dev);
+
+	return _hid_sensor_power_state(attrb, false);
+}
+
+static int hid_sensor_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct hid_sensor_common *attrb = iio_device_get_drvdata(indio_dev);
+
+	return _hid_sensor_power_state(attrb, true);
+}
+
+#endif
+
+const struct dev_pm_ops hid_sensor_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(hid_sensor_suspend, hid_sensor_resume)
+	SET_RUNTIME_PM_OPS(hid_sensor_suspend,
+			   hid_sensor_resume, NULL)
+};
+EXPORT_SYMBOL(hid_sensor_pm_ops);
+
 MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@intel.com>");
 MODULE_DESCRIPTION("HID Sensor trigger processing");
 MODULE_LICENSE("GPL");
diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.h b/drivers/iio/common/hid-sensors/hid-sensor-trigger.h
index 0f8e78c..9f4713f 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.h
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.h
@@ -19,6 +19,11 @@
 #ifndef _HID_SENSOR_TRIGGER_H
 #define _HID_SENSOR_TRIGGER_H
 
+#include <linux/pm.h>
+#include <linux/pm_runtime.h>
+
+extern const struct dev_pm_ops hid_sensor_pm_ops;
+
 int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char *name,
 				struct hid_sensor_common *attrb);
 void hid_sensor_remove_trigger(struct hid_sensor_common *attrb);
-- 
1.9.3


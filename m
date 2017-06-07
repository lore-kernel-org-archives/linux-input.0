From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v2 4/8] HID: serialize hid_hw_open and hid_hw_close
Date: Tue,  6 Jun 2017 23:59:34 -0700
Message-ID: <20170607065938.33332-5-dmitry.torokhov@gmail.com>
References: <20170607065938.33332-1-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170607065938.33332-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-input@vger.kernel.org

The HID transport drivers either re-implement exactly the same logic
(usbhid, i2c-hid) or forget to implement it (usbhid) which causes issues
when the same device is accessed via multiple interfaces (for example input
device through evdev and also hidraw). Let's muve the locking logic into
HID core to make sure the serialized behavior is always enforced.

Also let's uninline and move hid_hw_start() and hid_hw_stop() into hid-core
as hid_hw_start() is somewhat large and do not believe we get any benefit
from these two being inline.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-core.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/hid.h    | 72 +++++-----------------------------------
 2 files changed, 98 insertions(+), 63 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index ca173801d2be..f2a2cd522e46 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1750,6 +1750,94 @@ void hid_disconnect(struct hid_device *hdev)
 }
 EXPORT_SYMBOL_GPL(hid_disconnect);
 
+/**
+ * hid_hw_start - start underlying HW
+ * @hdev: hid device
+ * @connect_mask: which outputs to connect, see HID_CONNECT_*
+ *
+ * Call this in probe function *after* hid_parse. This will setup HW
+ * buffers and start the device (if not defeirred to device open).
+ * hid_hw_stop must be called if this was successful.
+ */
+int hid_hw_start(struct hid_device *hdev, unsigned int connect_mask)
+{
+	int error;
+
+	error = hdev->ll_driver->start(hdev);
+	if (error)
+		return error;
+
+	if (connect_mask) {
+		error = hid_connect(hdev, connect_mask);
+		if (error) {
+			hdev->ll_driver->stop(hdev);
+			return error;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hid_hw_start);
+
+/**
+ * hid_hw_stop - stop underlying HW
+ * @hdev: hid device
+ *
+ * This is usually called from remove function or from probe when something
+ * failed and hid_hw_start was called already.
+ */
+void hid_hw_stop(struct hid_device *hdev)
+{
+	hid_disconnect(hdev);
+	hdev->ll_driver->stop(hdev);
+}
+EXPORT_SYMBOL_GPL(hid_hw_stop);
+
+/**
+ * hid_hw_open - signal underlying HW to start delivering events
+ * @hdev: hid device
+ *
+ * Tell underlying HW to start delivering events from the device.
+ * This function should be called sometime after successful call
+ * to hid_hiw_start().
+ */
+int hid_hw_open(struct hid_device *hdev)
+{
+	int ret;
+
+	ret = mutex_lock_killable(&hdev->ll_open_lock);
+	if (ret)
+		return ret;
+
+	if (!hdev->ll_open_count++) {
+		ret = hdev->ll_driver->open(hdev);
+		if (ret)
+			hdev->ll_open_count--;
+	}
+
+	mutex_unlock(&hdev->ll_open_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(hid_hw_open);
+
+/**
+ * hid_hw_close - signal underlaying HW to stop delivering events
+ *
+ * @hdev: hid device
+ *
+ * This function indicates that we are not interested in the events
+ * from this device anymore. Delivery of events may or may not stop,
+ * depending on the number of users still outstanding.
+ */
+void hid_hw_close(struct hid_device *hdev)
+{
+	mutex_lock(&hdev->ll_open_lock);
+	if (!--hdev->ll_open_count)
+		hdev->ll_driver->close(hdev);
+	mutex_unlock(&hdev->ll_open_lock);
+}
+EXPORT_SYMBOL_GPL(hid_hw_close);
+
 /*
  * A list of devices for which there is a specialized driver on HID bus.
  *
@@ -2748,6 +2836,7 @@ struct hid_device *hid_allocate_device(void)
 	spin_lock_init(&hdev->debug_list_lock);
 	sema_init(&hdev->driver_lock, 1);
 	sema_init(&hdev->driver_input_lock, 1);
+	mutex_init(&hdev->ll_open_lock);
 
 	return hdev;
 }
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 5be325d890d9..5501eb64dbc4 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -34,6 +34,7 @@
 #include <linux/workqueue.h>
 #include <linux/input.h>
 #include <linux/semaphore.h>
+#include <linux/mutex.h>
 #include <linux/power_supply.h>
 #include <uapi/linux/hid.h>
 
@@ -520,7 +521,10 @@ struct hid_device {							/* device report descriptor */
 	struct semaphore driver_input_lock;				/* protects the current driver */
 	struct device dev;						/* device */
 	struct hid_driver *driver;
+
 	struct hid_ll_driver *ll_driver;
+	struct mutex ll_open_lock;
+	unsigned int ll_open_count;
 
 #ifdef CONFIG_HID_BATTERY_STRENGTH
 	/*
@@ -937,69 +941,11 @@ static inline int __must_check hid_parse(struct hid_device *hdev)
 	return hid_open_report(hdev);
 }
 
-/**
- * hid_hw_start - start underlaying HW
- *
- * @hdev: hid device
- * @connect_mask: which outputs to connect, see HID_CONNECT_*
- *
- * Call this in probe function *after* hid_parse. This will setup HW buffers
- * and start the device (if not deffered to device open). hid_hw_stop must be
- * called if this was successful.
- */
-static inline int __must_check hid_hw_start(struct hid_device *hdev,
-		unsigned int connect_mask)
-{
-	int ret = hdev->ll_driver->start(hdev);
-	if (ret || !connect_mask)
-		return ret;
-	ret = hid_connect(hdev, connect_mask);
-	if (ret)
-		hdev->ll_driver->stop(hdev);
-	return ret;
-}
-
-/**
- * hid_hw_stop - stop underlaying HW
- *
- * @hdev: hid device
- *
- * This is usually called from remove function or from probe when something
- * failed and hid_hw_start was called already.
- */
-static inline void hid_hw_stop(struct hid_device *hdev)
-{
-	hid_disconnect(hdev);
-	hdev->ll_driver->stop(hdev);
-}
-
-/**
- * hid_hw_open - signal underlaying HW to start delivering events
- *
- * @hdev: hid device
- *
- * Tell underlying HW to start delivering events from the device.
- * This function should be called sometime after successful call
- * to hid_hiw_start().
- */
-static inline int __must_check hid_hw_open(struct hid_device *hdev)
-{
-	return hdev->ll_driver->open(hdev);
-}
-
-/**
- * hid_hw_close - signal underlaying HW to stop delivering events
- *
- * @hdev: hid device
- *
- * This function indicates that we are not interested in the events
- * from this device anymore. Delivery of events may or may not stop,
- * depending on the number of users still outstanding.
- */
-static inline void hid_hw_close(struct hid_device *hdev)
-{
-	hdev->ll_driver->close(hdev);
-}
+int __must_check hid_hw_start(struct hid_device *hdev,
+			      unsigned int connect_mask);
+void hid_hw_stop(struct hid_device *hdev);
+int __must_check hid_hw_open(struct hid_device *hdev);
+void hid_hw_close(struct hid_device *hdev);
 
 /**
  * hid_hw_power - requests underlying HW to go into given power mode
-- 
2.13.0.506.g27d5fe0cd-goog

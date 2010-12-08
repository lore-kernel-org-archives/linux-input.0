From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] HID: add hid_hw_open/close/power() handlers
Date: Tue, 7 Dec 2010 23:02:48 -0800
Message-ID: <20101208070248.GE4140@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f42.google.com ([74.125.83.42]:42658 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753320Ab0LHHC4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Dec 2010 02:02:56 -0500
Received: by gwb20 with SMTP id 20so700583gwb.1
        for <linux-input@vger.kernel.org>; Tue, 07 Dec 2010 23:02:55 -0800 (PST)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linux Input <linux-input@vger.kernel.org>
Cc: Jiri Kosina <jkosina@suse.cz>

Instead of exposing the guts of hid->ll_driver relationship to HID
sub-drivers provide these helpers to encapsulate the details.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/hid/hid-input.c   |    4 ++--
 drivers/hid/hid-picolcd.c |    6 +++---
 drivers/hid/hid-roccat.c  |   26 ++++++++++----------------
 drivers/hid/hidraw.c      |   21 +++++++++------------
 include/linux/hid.h       |   43 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 67 insertions(+), 33 deletions(-)


diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index d8d372b..861488a 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -817,14 +817,14 @@ static int hidinput_open(struct input_dev *dev)
 {
 	struct hid_device *hid = input_get_drvdata(dev);
 
-	return hid->ll_driver->open(hid);
+	return hid_hw_open(hid);
 }
 
 static void hidinput_close(struct input_dev *dev)
 {
 	struct hid_device *hid = input_get_drvdata(dev);
 
-	hid->ll_driver->close(hid);
+	hid_hw_close(hid);
 }
 
 /*
diff --git a/drivers/hid/hid-picolcd.c b/drivers/hid/hid-picolcd.c
index bc2e077..38565fe 100644
--- a/drivers/hid/hid-picolcd.c
+++ b/drivers/hid/hid-picolcd.c
@@ -2635,7 +2635,7 @@ static int picolcd_probe(struct hid_device *hdev,
 		goto err_cleanup_data;
 	}
 
-	error = hdev->ll_driver->open(hdev);
+	error = hid_hw_open(hdev);
 	if (error) {
 		dev_err(&hdev->dev, "failed to open input interrupt pipe for key and IR events\n");
 		goto err_cleanup_hid_hw;
@@ -2668,7 +2668,7 @@ err_cleanup_sysfs2:
 err_cleanup_sysfs1:
 	device_remove_file(&hdev->dev, &dev_attr_operation_mode_delay);
 err_cleanup_hid_ll:
-	hdev->ll_driver->close(hdev);
+	hid_hw_close(hdev);
 err_cleanup_hid_hw:
 	hid_hw_stop(hdev);
 err_cleanup_data:
@@ -2699,7 +2699,7 @@ static void picolcd_remove(struct hid_device *hdev)
 	picolcd_exit_devfs(data);
 	device_remove_file(&hdev->dev, &dev_attr_operation_mode);
 	device_remove_file(&hdev->dev, &dev_attr_operation_mode_delay);
-	hdev->ll_driver->close(hdev);
+	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
 	hid_set_drvdata(hdev, NULL);
 
diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
index 5a6879e..a9d9b29 100644
--- a/drivers/hid/hid-roccat.c
+++ b/drivers/hid/hid-roccat.c
@@ -173,19 +173,15 @@ static int roccat_open(struct inode *inode, struct file *file)
 
 	if (!device->open++) {
 		/* power on device on adding first reader */
-		if (device->hid->ll_driver->power) {
-			error = device->hid->ll_driver->power(device->hid,
-					PM_HINT_FULLON);
-			if (error < 0) {
-				--device->open;
-				goto exit_err;
-			}
+		error = hid_hw_power(device->hid, PM_HINT_FULLON);
+		if (error < 0) {
+			--device->open;
+			goto exit_err;
 		}
-		error = device->hid->ll_driver->open(device->hid);
+
+		error = hid_hw_open(device->hid);
 		if (error < 0) {
-			if (device->hid->ll_driver->power)
-				device->hid->ll_driver->power(device->hid,
-						PM_HINT_NORMAL);
+			hid_hw_power(device->hid, PM_HINT_NORMAL);
 			--device->open;
 			goto exit_err;
 		}
@@ -231,10 +227,8 @@ static int roccat_release(struct inode *inode, struct file *file)
 	if (!--device->open) {
 		/* removing last reader */
 		if (device->exist) {
-			if (device->hid->ll_driver->power)
-				device->hid->ll_driver->power(device->hid,
-						PM_HINT_NORMAL);
-			device->hid->ll_driver->close(device->hid);
+			hid_hw_power(device->hid, PM_HINT_NORMAL);
+			hid_hw_close(device->hid);
 		} else {
 			kfree(device);
 		}
@@ -370,7 +364,7 @@ void roccat_disconnect(int minor)
 	device_destroy(roccat_class, MKDEV(roccat_major, minor));
 
 	if (device->open) {
-		device->hid->ll_driver->close(device->hid);
+		hid_hw_close(device->hid);
 		wake_up_interruptible(&device->wait);
 	} else {
 		kfree(device);
diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index e1f0748..93b51eb 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -192,15 +192,13 @@ static int hidraw_open(struct inode *inode, struct file *file)
 
 	dev = hidraw_table[minor];
 	if (!dev->open++) {
-		if (dev->hid->ll_driver->power) {
-			err = dev->hid->ll_driver->power(dev->hid, PM_HINT_FULLON);
-			if (err < 0)
-				goto out_unlock;
-		}
-		err = dev->hid->ll_driver->open(dev->hid);
+		err = hid_hw_power(dev->hid, PM_HINT_FULLON);
+		if (err < 0)
+			goto out_unlock;
+
+		err = hid_hw_open(dev->hid);
 		if (err < 0) {
-			if (dev->hid->ll_driver->power)
-				dev->hid->ll_driver->power(dev->hid, PM_HINT_NORMAL);
+			hid_hw_power(dev->hid, PM_HINT_NORMAL);
 			dev->open--;
 		}
 	}
@@ -229,9 +227,8 @@ static int hidraw_release(struct inode * inode, struct file * file)
 	dev = hidraw_table[minor];
 	if (!--dev->open) {
 		if (list->hidraw->exist) {
-			if (dev->hid->ll_driver->power)
-				dev->hid->ll_driver->power(dev->hid, PM_HINT_NORMAL);
-			dev->hid->ll_driver->close(dev->hid);
+			hid_hw_power(dev->hid, PM_HINT_NORMAL);
+			hid_hw_close(dev->hid);
 		} else {
 			kfree(list->hidraw);
 		}
@@ -433,7 +430,7 @@ void hidraw_disconnect(struct hid_device *hid)
 	device_destroy(hidraw_class, MKDEV(hidraw_major, hidraw->minor));
 
 	if (hidraw->open) {
-		hid->ll_driver->close(hid);
+		hid_hw_close(hid);
 		wake_up_interruptible(&hidraw->wait);
 	} else {
 		kfree(hidraw);
diff --git a/include/linux/hid.h b/include/linux/hid.h
index bb0f56f..e2af195 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -820,6 +820,49 @@ static inline void hid_hw_stop(struct hid_device *hdev)
 	hdev->ll_driver->stop(hdev);
 }
 
+/**
+ * hid_hw_open - signal underlaying HW to start delivering events
+ *
+ * @hdev: hid device
+ *
+ * Tell underlying HW to start delivering events from the device.
+ * This function should be called sometime after successful call
+ * to hid_hiw_start().
+ */
+static inline int __must_check hid_hw_open(struct hid_device *hdev)
+{
+	return hdev->ll_driver->open(hdev);
+}
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
+static inline void hid_hw_close(struct hid_device *hdev)
+{
+	hdev->ll_driver->close(hdev);
+}
+
+/**
+ * hid_hw_power - requests underlying HW to go into given power mode
+ *
+ * @hdev: hid device
+ * @level: requested power level (one of %PM_HINT_* defines)
+ *
+ * This function requests underlying hardware to enter requested power
+ * mode.
+ */
+
+static inline int hid_hw_power(struct hid_device *hdev, int level)
+{
+	return hdev->ll_driver->power ? hdev->ll_driver->power(hdev, level) : 0;
+}
+
 void hid_report_raw_event(struct hid_device *hid, int type, u8 *data, int size,
 		int interrupt);
 
-- 
Dmitry

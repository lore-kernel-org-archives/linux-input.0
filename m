From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 20/21] HID: wiimote: add sysfs extension/device-type attrs
Date: Sat, 13 Apr 2013 12:48:01 +0200
Message-ID: <1365850082-3585-21-git-send-email-dh.herrmann@gmail.com>
References: <1365850082-3585-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f48.google.com ([74.125.83.48]:53110 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754078Ab3DMKtD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 13 Apr 2013 06:49:03 -0400
Received: by mail-ee0-f48.google.com with SMTP id b15so1624777eek.21
        for <linux-input@vger.kernel.org>; Sat, 13 Apr 2013 03:49:02 -0700 (PDT)
In-Reply-To: <1365850082-3585-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@gmail.com>

Two new attributes, "extension" and "device" now allow user-space to read
the extension type and device type. As device detection is asynchronous,
we send a CHANGED event after it is done. This also allows user-space to
wait for a device to settle before opening its input event devices.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/hid-wiimote-core.c | 106 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 105 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index 126c9d9..c5b5207 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -1139,11 +1139,18 @@ static void wiimote_init_worker(struct work_struct *work)
 {
 	struct wiimote_data *wdata = container_of(work, struct wiimote_data,
 						  init_worker);
+	bool changed = false;
 
-	if (wdata->state.devtype == WIIMOTE_DEV_PENDING)
+	if (wdata->state.devtype == WIIMOTE_DEV_PENDING) {
 		wiimote_init_detect(wdata);
+		changed = true;
+	}
+
 	if (!wiimote_init_check(wdata))
 		wiimote_init_hotplug(wdata);
+
+	if (changed)
+		kobject_uevent(&wdata->hdev->dev.kobj, KOBJ_CHANGE);
 }
 
 void __wiimote_schedule(struct wiimote_data *wdata)
@@ -1562,6 +1569,84 @@ static int wiimote_hid_event(struct hid_device *hdev, struct hid_report *report,
 	return 0;
 }
 
+static ssize_t wiimote_ext_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct wiimote_data *wdata = dev_to_wii(dev);
+	__u8 type;
+	unsigned long flags;
+
+	spin_lock_irqsave(&wdata->state.lock, flags);
+	type = wdata->state.exttype;
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+
+	switch (type) {
+	case WIIMOTE_EXT_NONE:
+		return sprintf(buf, "none\n");
+	case WIIMOTE_EXT_NUNCHUK:
+		return sprintf(buf, "nunchuk\n");
+	case WIIMOTE_EXT_CLASSIC_CONTROLLER:
+		return sprintf(buf, "classic\n");
+	case WIIMOTE_EXT_BALANCE_BOARD:
+		return sprintf(buf, "balanceboard\n");
+	case WIIMOTE_EXT_UNKNOWN:
+		/* fallthrough */
+	default:
+		return sprintf(buf, "unknown\n");
+	}
+}
+
+static ssize_t wiimote_ext_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
+{
+	struct wiimote_data *wdata = dev_to_wii(dev);
+
+	if (!strcmp(buf, "scan")) {
+		wiimote_schedule(wdata);
+	} else {
+		return -EINVAL;
+	}
+
+	return strnlen(buf, PAGE_SIZE);
+}
+
+static DEVICE_ATTR(extension, S_IRUGO | S_IWUSR | S_IWGRP, wiimote_ext_show,
+		   wiimote_ext_store);
+
+static ssize_t wiimote_dev_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct wiimote_data *wdata = dev_to_wii(dev);
+	__u8 type;
+	unsigned long flags;
+
+	spin_lock_irqsave(&wdata->state.lock, flags);
+	type = wdata->state.devtype;
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+
+	switch (type) {
+	case WIIMOTE_DEV_GENERIC:
+		return sprintf(buf, "none\n");
+	case WIIMOTE_DEV_GEN10:
+		return sprintf(buf, "gen10\n");
+	case WIIMOTE_DEV_GEN20:
+		return sprintf(buf, "gen20\n");
+	case WIIMOTE_DEV_BALANCE_BOARD:
+		return sprintf(buf, "balanceboard\n");
+	case WIIMOTE_DEV_PENDING:
+		return sprintf(buf, "pending\n");
+	case WIIMOTE_DEV_UNKNOWN:
+		/* fallthrough */
+	default:
+		return sprintf(buf, "unknown\n");
+	}
+}
+
+static DEVICE_ATTR(device, S_IRUGO, wiimote_dev_show, NULL);
+
 static struct wiimote_data *wiimote_create(struct hid_device *hdev)
 {
 	struct wiimote_data *wdata;
@@ -1602,6 +1687,9 @@ static void wiimote_destroy(struct wiimote_data *wdata)
 	cancel_work_sync(&wdata->init_worker);
 	del_timer_sync(&wdata->timer);
 
+	device_remove_file(&wdata->hdev->dev, &dev_attr_device);
+	device_remove_file(&wdata->hdev->dev, &dev_attr_extension);
+
 	wiimote_mp_unload(wdata);
 	wiimote_ext_unload(wdata);
 	wiimote_modules_unload(wdata);
@@ -1644,6 +1732,18 @@ static int wiimote_hid_probe(struct hid_device *hdev,
 		goto err_stop;
 	}
 
+	ret = device_create_file(&hdev->dev, &dev_attr_extension);
+	if (ret) {
+		hid_err(hdev, "cannot create sysfs attribute\n");
+		goto err_close;
+	}
+
+	ret = device_create_file(&hdev->dev, &dev_attr_device);
+	if (ret) {
+		hid_err(hdev, "cannot create sysfs attribute\n");
+		goto err_ext;
+	}
+
 	ret = wiidebug_init(wdata);
 	if (ret)
 		goto err_free;
@@ -1659,6 +1759,10 @@ err_free:
 	wiimote_destroy(wdata);
 	return ret;
 
+err_ext:
+	device_remove_file(&wdata->hdev->dev, &dev_attr_extension);
+err_close:
+	hid_hw_close(hdev);
 err_stop:
 	hid_hw_stop(hdev);
 err:
-- 
1.8.2.1


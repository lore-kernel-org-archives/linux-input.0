From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 20/26] HID: wiimote: add sysfs extension/device-type attrs
Date: Sun,  5 May 2013 23:13:04 +0200
Message-ID: <1367788390-29835-21-git-send-email-dh.herrmann@gmail.com>
References: <1367788390-29835-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f44.google.com ([209.85.214.44]:55621 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752266Ab3EEVOQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 5 May 2013 17:14:16 -0400
Received: by mail-bk0-f44.google.com with SMTP id jk13so1357527bkc.31
        for <linux-input@vger.kernel.org>; Sun, 05 May 2013 14:14:15 -0700 (PDT)
In-Reply-To: <1367788390-29835-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@gmail.com>

Two new attributes, "extension" and "devtype" now allow user-space to read
the extension type and device type. As device detection is asynchronous,
we send a CHANGED event after it is done. This also allows user-space to
wait for a device to settle before opening its input event devices.

The "extension" device is compatible with the old "extension" sysfs field
(which was registered by the static extension support code).

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 Documentation/ABI/testing/sysfs-driver-hid-wiimote |  24 ++++-
 drivers/hid/hid-wiimote-core.c                     | 106 ++++++++++++++++++++-
 2 files changed, 128 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-hid-wiimote b/Documentation/ABI/testing/sysfs-driver-hid-wiimote
index 3d98009..e8f6b16 100644
--- a/Documentation/ABI/testing/sysfs-driver-hid-wiimote
+++ b/Documentation/ABI/testing/sysfs-driver-hid-wiimote
@@ -12,7 +12,7 @@ Description:	Make it possible to set/get current led state. Reading from it
 What:		/sys/bus/hid/drivers/wiimote/<dev>/extension
 Date:		August 2011
 KernelVersion:	3.2
-Contact:	David Herrmann <dh.herrmann@googlemail.com>
+Contact:	David Herrmann <dh.herrmann@gmail.com>
 Description:	This file contains the currently connected and initialized
 		extensions. It can be one of: none, motionp, nunchuck, classic,
 		motionp+nunchuck, motionp+classic
@@ -20,3 +20,25 @@ Description:	This file contains the currently connected and initialized
 		the official Nintendo Nunchuck extension and classic is the
 		Nintendo Classic Controller extension. The motionp extension can
 		be combined with the other two.
+		Starting with kernel-version 3.11 Motion Plus hotplugging is
+		supported and if detected, it's no longer reported as static
+		extension. You will get uevent notifications for the motion-plus
+		device then.
+
+What:		/sys/bus/hid/drivers/wiimote/<dev>/devtype
+Date:		May 2013
+KernelVersion:	3.11
+Contact:	David Herrmann <dh.herrmann@gmail.com>
+Description:	While a device is initialized by the wiimote driver, we perform
+		a device detection and signal a "change" uevent after it is
+		done. This file shows the detected device type. "pending" means
+		that the detection is still ongoing, "unknown" means, that the
+		device couldn't be detected or loaded. "generic" means, that the
+		device couldn't be detected but supports basic Wii Remote
+		features and can be used.
+		Other strings for each device-type are available and may be
+		added if new device-specific detections are added.
+		Currently supported are:
+			gen10: First Wii Remote generation
+			gen20: Second Wii Remote Plus generation (builtin MP)
+			balanceboard: Wii Balance Board
diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index 13963b4..fa58045 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -1166,11 +1166,18 @@ static void wiimote_init_worker(struct work_struct *work)
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
@@ -1591,6 +1598,84 @@ static int wiimote_hid_event(struct hid_device *hdev, struct hid_report *report,
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
+		return sprintf(buf, "generic\n");
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
+static DEVICE_ATTR(devtype, S_IRUGO, wiimote_dev_show, NULL);
+
 static struct wiimote_data *wiimote_create(struct hid_device *hdev)
 {
 	struct wiimote_data *wdata;
@@ -1631,6 +1716,9 @@ static void wiimote_destroy(struct wiimote_data *wdata)
 	cancel_work_sync(&wdata->init_worker);
 	del_timer_sync(&wdata->timer);
 
+	device_remove_file(&wdata->hdev->dev, &dev_attr_devtype);
+	device_remove_file(&wdata->hdev->dev, &dev_attr_extension);
+
 	wiimote_mp_unload(wdata);
 	wiimote_ext_unload(wdata);
 	wiimote_modules_unload(wdata);
@@ -1673,6 +1761,18 @@ static int wiimote_hid_probe(struct hid_device *hdev,
 		goto err_stop;
 	}
 
+	ret = device_create_file(&hdev->dev, &dev_attr_extension);
+	if (ret) {
+		hid_err(hdev, "cannot create sysfs attribute\n");
+		goto err_close;
+	}
+
+	ret = device_create_file(&hdev->dev, &dev_attr_devtype);
+	if (ret) {
+		hid_err(hdev, "cannot create sysfs attribute\n");
+		goto err_ext;
+	}
+
 	ret = wiidebug_init(wdata);
 	if (ret)
 		goto err_free;
@@ -1688,6 +1788,10 @@ err_free:
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
1.8.2.2


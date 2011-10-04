From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [RFC 07/12] HID: wiimote: Add extension sysfs attribute
Date: Tue,  4 Oct 2011 15:36:48 +0200
Message-ID: <1317735413-17299-8-git-send-email-dh.herrmann@googlemail.com>
References: <1317735413-17299-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:51678 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757187Ab1JDNhc (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Oct 2011 09:37:32 -0400
Received: by mail-wy0-f174.google.com with SMTP id 34so527686wyg.19
        for <linux-input@vger.kernel.org>; Tue, 04 Oct 2011 06:37:31 -0700 (PDT)
In-Reply-To: <1317735413-17299-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, padovan@profusion.mobi, David Herrmann <dh.herrmann@googlemail.com>

Add new sysfs attribute "extension" which returns the currently connected and
initialized extensions.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 Documentation/ABI/testing/sysfs-driver-hid-wiimote |   12 +++++
 drivers/hid/hid-wiimote-ext.c                      |   46 ++++++++++++++++++++
 2 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-hid-wiimote b/Documentation/ABI/testing/sysfs-driver-hid-wiimote
index 5d5a16e..3d98009 100644
--- a/Documentation/ABI/testing/sysfs-driver-hid-wiimote
+++ b/Documentation/ABI/testing/sysfs-driver-hid-wiimote
@@ -8,3 +8,15 @@ Contact:	David Herrmann <dh.herrmann@googlemail.com>
 Description:	Make it possible to set/get current led state. Reading from it
 		returns 0 if led is off and 1 if it is on. Writing 0 to it
 		disables the led, writing 1 enables it.
+
+What:		/sys/bus/hid/drivers/wiimote/<dev>/extension
+Date:		August 2011
+KernelVersion:	3.2
+Contact:	David Herrmann <dh.herrmann@googlemail.com>
+Description:	This file contains the currently connected and initialized
+		extensions. It can be one of: none, motionp, nunchuck, classic,
+		motionp+nunchuck, motionp+classic
+		motionp is the official Nintendo Motion+ extension, nunchuck is
+		the official Nintendo Nunchuck extension and classic is the
+		Nintendo Classic Controller extension. The motionp extension can
+		be combined with the other two.
diff --git a/drivers/hid/hid-wiimote-ext.c b/drivers/hid/hid-wiimote-ext.c
index 5adfa93..ffd9066 100644
--- a/drivers/hid/hid-wiimote-ext.c
+++ b/drivers/hid/hid-wiimote-ext.c
@@ -208,11 +208,47 @@ bool wiiext_active(struct wiimote_data *wdata)
 	return wdata->ext->motionp || wdata->ext->ext_type;
 }
 
+static ssize_t wiiext_show(struct device *dev, struct device_attribute *attr,
+								char *buf)
+{
+	struct wiimote_data *wdata = dev_to_wii(dev);
+	__u8 type = WIIEXT_NONE;
+	bool motionp = false;
+	unsigned long flags;
+
+	spin_lock_irqsave(&wdata->state.lock, flags);
+	if (wdata->ext) {
+		motionp = wdata->ext->motionp;
+		type = wdata->ext->ext_type;
+	}
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+
+	if (type == WIIEXT_NUNCHUCK) {
+		if (motionp)
+			return sprintf(buf, "motionp+nunchuck\n");
+		else
+			return sprintf(buf, "nunchuck\n");
+	} else if (type == WIIEXT_CLASSIC) {
+		if (motionp)
+			return sprintf(buf, "motionp+classic\n");
+		else
+			return sprintf(buf, "classic\n");
+	} else {
+		if (motionp)
+			return sprintf(buf, "motionp\n");
+		else
+			return sprintf(buf, "none\n");
+	}
+}
+
+static DEVICE_ATTR(extension, S_IRUGO, wiiext_show, NULL);
+
 /* Initializes the extension driver of a wiimote */
 int wiiext_init(struct wiimote_data *wdata)
 {
 	struct wiimote_ext *ext;
 	unsigned long flags;
+	int ret;
 
 	ext = kzalloc(sizeof(*ext), GFP_KERNEL);
 	if (!ext)
@@ -221,11 +257,19 @@ int wiiext_init(struct wiimote_data *wdata)
 	ext->wdata = wdata;
 	INIT_WORK(&ext->worker, wiiext_worker);
 
+	ret = device_create_file(&wdata->hdev->dev, &dev_attr_extension);
+	if (ret)
+		goto err;
+
 	spin_lock_irqsave(&wdata->state.lock, flags);
 	wdata->ext = ext;
 	spin_unlock_irqrestore(&wdata->state.lock, flags);
 
 	return 0;
+
+err:
+	kfree(ext);
+	return ret;
 }
 
 /* Deinitializes the extension driver of a wiimote */
@@ -241,6 +285,8 @@ void wiiext_deinit(struct wiimote_data *wdata)
 	wdata->ext = NULL;
 	spin_unlock_irqrestore(&wdata->state.lock, flags);
 
+	device_remove_file(&wdata->hdev->dev, &dev_attr_extension);
+
 	cancel_work_sync(&ext->worker);
 	kfree(ext);
 }
-- 
1.7.7


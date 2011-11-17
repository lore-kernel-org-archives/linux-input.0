From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH v2 07/17] HID: wiimote: Add extension sysfs attribute
Date: Thu, 17 Nov 2011 14:12:04 +0100
Message-ID: <1321535534-7950-8-git-send-email-dh.herrmann@googlemail.com>
References: <1321535534-7950-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:51247 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757004Ab1KQNNA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Nov 2011 08:13:00 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so1873410eye.19
        for <linux-input@vger.kernel.org>; Thu, 17 Nov 2011 05:12:59 -0800 (PST)
In-Reply-To: <1321535534-7950-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, oneukum@suse.de, David Herrmann <dh.herrmann@googlemail.com>

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
index 233bdfe..477513d 100644
--- a/drivers/hid/hid-wiimote-ext.c
+++ b/drivers/hid/hid-wiimote-ext.c
@@ -199,11 +199,47 @@ bool wiiext_active(struct wiimote_data *wdata)
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
@@ -212,11 +248,19 @@ int wiiext_init(struct wiimote_data *wdata)
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
@@ -240,6 +284,8 @@ void wiiext_deinit(struct wiimote_data *wdata)
 	wdata->ext = NULL;
 	spin_unlock_irqrestore(&wdata->state.lock, flags);
 
+	device_remove_file(&wdata->hdev->dev, &dev_attr_extension);
+
 	cancel_work_sync(&ext->worker);
 	kfree(ext);
 }
-- 
1.7.7.3


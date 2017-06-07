From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v2 2/8] HID: hiddev: use hid_hw_power instead of usbhid_get/put_power
Date: Tue,  6 Jun 2017 23:59:32 -0700
Message-ID: <20170607065938.33332-3-dmitry.torokhov@gmail.com>
References: <20170607065938.33332-1-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35795 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751606AbdFGG7n (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 7 Jun 2017 02:59:43 -0400
In-Reply-To: <20170607065938.33332-1-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Instead of calling into usbhid code directly, let's use the standard
accessors for the transport HID drivers, and stop clobbering their error
codes with -EIO.

This also allows us to remove usbhid_get/put_power(), leaving only
usbhid_power().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/usbhid/hid-core.c | 22 +++++-----------------
 drivers/hid/usbhid/hiddev.c   | 14 ++++++--------
 drivers/hid/usbhid/usbhid.h   |  2 --
 3 files changed, 11 insertions(+), 27 deletions(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index fb0cf5d70504..62b660622265 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -1203,16 +1203,19 @@ static void usbhid_stop(struct hid_device *hid)
 
 static int usbhid_power(struct hid_device *hid, int lvl)
 {
+	struct usbhid_device *usbhid = hid->driver_data;
 	int r = 0;
 
 	switch (lvl) {
 	case PM_HINT_FULLON:
-		r = usbhid_get_power(hid);
+		r = usb_autopm_get_interface(usbhid->intf);
 		break;
+
 	case PM_HINT_NORMAL:
-		usbhid_put_power(hid);
+		usb_autopm_put_interface(usbhid->intf);
 		break;
 	}
+
 	return r;
 }
 
@@ -1492,21 +1495,6 @@ static int hid_post_reset(struct usb_interface *intf)
 	return 0;
 }
 
-int usbhid_get_power(struct hid_device *hid)
-{
-	struct usbhid_device *usbhid = hid->driver_data;
-
-	return usb_autopm_get_interface(usbhid->intf);
-}
-
-void usbhid_put_power(struct hid_device *hid)
-{
-	struct usbhid_device *usbhid = hid->driver_data;
-
-	usb_autopm_put_interface(usbhid->intf);
-}
-
-
 #ifdef CONFIG_PM
 static int hid_resume_common(struct hid_device *hid, bool driver_suspended)
 {
diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
index b4f714752245..7d749b19c27c 100644
--- a/drivers/hid/usbhid/hiddev.c
+++ b/drivers/hid/usbhid/hiddev.c
@@ -238,7 +238,7 @@ static int hiddev_release(struct inode * inode, struct file * file)
 	if (!--list->hiddev->open) {
 		if (list->hiddev->exist) {
 			hid_hw_close(list->hiddev->hid);
-			usbhid_put_power(list->hiddev->hid);
+			hid_hw_power(list->hiddev->hid, PM_HINT_NORMAL);
 		} else {
 			mutex_unlock(&list->hiddev->existancelock);
 			kfree(list->hiddev);
@@ -299,19 +299,17 @@ static int hiddev_open(struct inode *inode, struct file *file)
 	if (!list->hiddev->open++)
 		if (list->hiddev->exist) {
 			struct hid_device *hid = hiddev->hid;
-			res = usbhid_get_power(hid);
-			if (res < 0) {
-				res = -EIO;
+			res = hid_hw_power(hid, PM_HINT_FULLON);
+			if (res < 0)
 				goto bail_unlock;
-			}
 			res = hid_hw_open(hid);
 			if (res < 0)
-				goto bail_put_power;
+				goto bail_normal_power;
 		}
 	mutex_unlock(&hiddev->existancelock);
 	return 0;
-bail_put_power:
-	usbhid_put_power(hid);
+bail_normal_power:
+	hid_hw_power(hid, PM_HINT_NORMAL);
 bail_unlock:
 	mutex_unlock(&hiddev->existancelock);
 bail:
diff --git a/drivers/hid/usbhid/usbhid.h b/drivers/hid/usbhid/usbhid.h
index 83ef5c14aa92..ffcd329b3c3b 100644
--- a/drivers/hid/usbhid/usbhid.h
+++ b/drivers/hid/usbhid/usbhid.h
@@ -35,8 +35,6 @@
 
 /*  API provided by hid-core.c for USB HID drivers */
 void usbhid_init_reports(struct hid_device *hid);
-int usbhid_get_power(struct hid_device *hid);
-void usbhid_put_power(struct hid_device *hid);
 struct usb_interface *usbhid_find_interface(int minor);
 
 /* iofl flags */
-- 
2.13.0.506.g27d5fe0cd-goog


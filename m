From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v2 1/8] HID: hiddev: use hid_hw_open/close instead of usbhid_open/close
Date: Tue,  6 Jun 2017 23:59:31 -0700
Message-ID: <20170607065938.33332-2-dmitry.torokhov@gmail.com>
References: <20170607065938.33332-1-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36446 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751467AbdFGG7m (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 7 Jun 2017 02:59:42 -0400
In-Reply-To: <20170607065938.33332-1-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Instead of calling into usbhid code directly, let's use the standard
accessors for the transport HID drivers, and stop clobbering their errors
with -EIO.

This also allows us make usbhid_open and close static.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/usbhid/hid-core.c |  4 ++--
 drivers/hid/usbhid/hiddev.c   | 16 +++++++++-------
 drivers/hid/usbhid/usbhid.h   |  2 --
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 83772fa7d92a..fb0cf5d70504 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -677,7 +677,7 @@ static int hid_get_class_descriptor(struct usb_device *dev, int ifnum,
 	return result;
 }
 
-int usbhid_open(struct hid_device *hid)
+static int usbhid_open(struct hid_device *hid)
 {
 	struct usbhid_device *usbhid = hid->driver_data;
 	int res = 0;
@@ -722,7 +722,7 @@ int usbhid_open(struct hid_device *hid)
 	return res;
 }
 
-void usbhid_close(struct hid_device *hid)
+static void usbhid_close(struct hid_device *hid)
 {
 	struct usbhid_device *usbhid = hid->driver_data;
 
diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
index 0e06368d1fbb..b4f714752245 100644
--- a/drivers/hid/usbhid/hiddev.c
+++ b/drivers/hid/usbhid/hiddev.c
@@ -237,7 +237,7 @@ static int hiddev_release(struct inode * inode, struct file * file)
 	mutex_lock(&list->hiddev->existancelock);
 	if (!--list->hiddev->open) {
 		if (list->hiddev->exist) {
-			usbhid_close(list->hiddev->hid);
+			hid_hw_close(list->hiddev->hid);
 			usbhid_put_power(list->hiddev->hid);
 		} else {
 			mutex_unlock(&list->hiddev->existancelock);
@@ -282,11 +282,9 @@ static int hiddev_open(struct inode *inode, struct file *file)
 	 */
 	if (list->hiddev->exist) {
 		if (!list->hiddev->open++) {
-			res = usbhid_open(hiddev->hid);
-			if (res < 0) {
-				res = -EIO;
+			res = hid_hw_open(hiddev->hid);
+			if (res < 0)
 				goto bail;
-			}
 		}
 	} else {
 		res = -ENODEV;
@@ -306,10 +304,14 @@ static int hiddev_open(struct inode *inode, struct file *file)
 				res = -EIO;
 				goto bail_unlock;
 			}
-			usbhid_open(hid);
+			res = hid_hw_open(hid);
+			if (res < 0)
+				goto bail_put_power;
 		}
 	mutex_unlock(&hiddev->existancelock);
 	return 0;
+bail_put_power:
+	usbhid_put_power(hid);
 bail_unlock:
 	mutex_unlock(&hiddev->existancelock);
 bail:
@@ -935,7 +937,7 @@ void hiddev_disconnect(struct hid_device *hid)
 
 	if (hiddev->open) {
 		mutex_unlock(&hiddev->existancelock);
-		usbhid_close(hiddev->hid);
+		hid_hw_close(hiddev->hid);
 		wake_up_interruptible(&hiddev->wait);
 	} else {
 		mutex_unlock(&hiddev->existancelock);
diff --git a/drivers/hid/usbhid/usbhid.h b/drivers/hid/usbhid/usbhid.h
index fa47d666cfcf..83ef5c14aa92 100644
--- a/drivers/hid/usbhid/usbhid.h
+++ b/drivers/hid/usbhid/usbhid.h
@@ -34,8 +34,6 @@
 #include <linux/input.h>
 
 /*  API provided by hid-core.c for USB HID drivers */
-void usbhid_close(struct hid_device *hid);
-int usbhid_open(struct hid_device *hid);
 void usbhid_init_reports(struct hid_device *hid);
 int usbhid_get_power(struct hid_device *hid);
 void usbhid_put_power(struct hid_device *hid);
-- 
2.13.0.506.g27d5fe0cd-goog


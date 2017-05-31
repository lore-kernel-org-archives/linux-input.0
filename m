From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 2/7] HID: hiddev: use hid_hw_power instead of usbhid_get/put_power
Date: Wed, 31 May 2017 13:59:46 -0700
Message-ID: <20170531205951.30852-3-dmitry.torokhov@gmail.com>
References: <20170531205951.30852-1-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170531205951.30852-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Instead of calling into usbhid code directly, let's use the standard
accessors for the transport HID drivers.

This also allows us to remove usbhid_get/put_power(), leaving only
usbhid_power().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/usbhid/hid-core.c | 22 +++++-----------------
 drivers/hid/usbhid/hiddev.c   |  4 ++--
 drivers/hid/usbhid/usbhid.h   |  2 --
 3 files changed, 7 insertions(+), 21 deletions(-)

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
index d949ac13af9e..8b62174582b5 100644
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
@@ -301,7 +301,7 @@ static int hiddev_open(struct inode *inode, struct file *file)
 	if (!list->hiddev->open++)
 		if (list->hiddev->exist) {
 			struct hid_device *hid = hiddev->hid;
-			res = usbhid_get_power(hid);
+			res = hid_hw_power(hid, PM_HINT_FULLON);
 			if (res < 0) {
 				res = -EIO;
 				goto bail_unlock;
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

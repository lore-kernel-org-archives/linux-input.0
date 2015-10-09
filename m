From: Luis de Bethencourt <luisbg@osg.samsung.com>
Subject: [PATCH] HID: hiddev: change hiddev_connect() to return bool
Date: Fri,  9 Oct 2015 12:54:56 +0100
Message-ID: <1444391696-1920-1-git-send-email-luisbg@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: jikos@kernel.org, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, Luis de Bethencourt <luisbg@osg.samsung.com>
List-Id: linux-input@vger.kernel.org

Since hid_connect() only cares about hiddev_connect() succeeding or
failing, there is no need for this function to return an int and it can
return a bool instead.

Suggested-by: Jiri Kosina <jikos@kernel.org>
Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
---

Hi,

The suggestion to change the return type of the function was made in:
https://lkml.org/lkml/2015/10/5/330

In relation to hiddev_connect() returning the wrong errno code.

Thanks,
Luis

 drivers/hid/hid-core.c      |  2 +-
 drivers/hid/usbhid/hiddev.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index efed99f..a8f3624 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1631,7 +1631,7 @@ int hid_connect(struct hid_device *hdev, unsigned int connect_mask)
 		hdev->claimed |= HID_CLAIMED_INPUT;
 
 	if ((connect_mask & HID_CONNECT_HIDDEV) && hdev->hiddev_connect &&
-			!hdev->hiddev_connect(hdev,
+			hdev->hiddev_connect(hdev,
 				connect_mask & HID_CONNECT_HIDDEV_FORCE))
 		hdev->claimed |= HID_CLAIMED_HIDDEV;
 	if ((connect_mask & HID_CONNECT_HIDRAW) && !hidraw_connect(hdev))
diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
index 2f1ddca..d715632 100644
--- a/drivers/hid/usbhid/hiddev.c
+++ b/drivers/hid/usbhid/hiddev.c
@@ -875,7 +875,7 @@ static struct usb_class_driver hiddev_class = {
 /*
  * This is where hid.c calls us to connect a hid device to the hiddev driver
  */
-int hiddev_connect(struct hid_device *hid, unsigned int force)
+bool hiddev_connect(struct hid_device *hid, unsigned int force)
 {
 	struct hiddev *hiddev;
 	struct usbhid_device *usbhid = hid->driver_data;
@@ -890,11 +890,11 @@ int hiddev_connect(struct hid_device *hid, unsigned int force)
 				break;
 
 		if (i == hid->maxcollection)
-			return -1;
+			return false;
 	}
 
 	if (!(hiddev = kzalloc(sizeof(struct hiddev), GFP_KERNEL)))
-		return -1;
+		return false;
 
 	init_waitqueue_head(&hiddev->wait);
 	INIT_LIST_HEAD(&hiddev->list);
@@ -908,9 +908,9 @@ int hiddev_connect(struct hid_device *hid, unsigned int force)
 		hid_err(hid, "Not able to get a minor for this device\n");
 		hid->hiddev = NULL;
 		kfree(hiddev);
-		return -1;
+		return false;
 	}
-	return 0;
+	return true;
 }
 
 /*
-- 
2.5.1

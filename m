From: Luis de Bethencourt <luisbg@osg.samsung.com>
Subject: [PATCH v2] HID: hiddev: change hiddev_connect() to return bool
Date: Fri,  9 Oct 2015 14:00:33 +0100
Message-ID: <1444395633-12672-1-git-send-email-luisbg@osg.samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:48024 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932421AbbJINAm (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 9 Oct 2015 09:00:42 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: jikos@kernel.org, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, Luis de Bethencourt <luisbg@osg.samsung.com>

Since hid_connect() only cares about hiddev_connect() succeeding or
failing, there is no need for this function to return an int and it can
return a bool instead.

Suggested-by: Jiri Kosina <jikos@kernel.org>
Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
---

Hi,

No idea why my local build did not complain about the obvious mistake
on the previous version of the patch.

Sorry about that,
Luis

 drivers/hid/hid-core.c      |  2 +-
 drivers/hid/usbhid/hiddev.c | 10 +++++-----
 include/linux/hid.h         |  2 +-
 include/linux/hiddev.h      |  2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

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
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 251a1d3..4b5477e 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -547,7 +547,7 @@ struct hid_device {							/* device report descriptor */
 	int (*ff_init)(struct hid_device *);
 
 	/* hiddev event handler */
-	int (*hiddev_connect)(struct hid_device *, unsigned int);
+	bool (*hiddev_connect)(struct hid_device *, unsigned int);
 	void (*hiddev_disconnect)(struct hid_device *);
 	void (*hiddev_hid_event) (struct hid_device *, struct hid_field *field,
 				  struct hid_usage *, __s32);
diff --git a/include/linux/hiddev.h b/include/linux/hiddev.h
index a5dd814..c0f5c25 100644
--- a/include/linux/hiddev.h
+++ b/include/linux/hiddev.h
@@ -38,7 +38,7 @@ struct hid_field;
 struct hid_report;
 
 #ifdef CONFIG_USB_HIDDEV
-int hiddev_connect(struct hid_device *hid, unsigned int force);
+bool hiddev_connect(struct hid_device *hid, unsigned int force);
 void hiddev_disconnect(struct hid_device *);
 void hiddev_hid_event(struct hid_device *hid, struct hid_field *field,
 		      struct hid_usage *usage, __s32 value);
-- 
2.5.1


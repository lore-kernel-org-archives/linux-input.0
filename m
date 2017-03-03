From: Jaejoong Kim <climbbb.kim@gmail.com>
Subject: [PATCH v2 2/2] HID: hiddev: reallocate hiddev's minor number
Date: Fri,  3 Mar 2017 17:54:01 +0900
Message-ID: <1488531241-18367-3-git-send-email-climbbb.kim@gmail.com>
References: <1488531241-18367-1-git-send-email-climbbb.kim@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34512 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751143AbdCCI5d (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 3 Mar 2017 03:57:33 -0500
In-Reply-To: <1488531241-18367-1-git-send-email-climbbb.kim@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, Jaejoong Kim <climbbb.kim@gmail.com>

We need to store the minor number each drivers. In case of hidraw, the
minor number is stored stores in struct hidraw. But hiddev's minor is
located in struct hid_device.

The hid-core driver announces a kernel message which driver is loaded when
HID device connected, but hiddev's minor number is always zero. To proper
display hiddev's minor number, we need to store the minor number asked from
usb core and do some refactoring work (move from hiddev.c to hiddev.h) to
access hiddev in hid-core.

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Jaejoong Kim <climbbb.kim@gmail.com>
---
Chanes in v2:
- rollback struct hiddev_list exported
- squash this patch in a seperate patch
---

 drivers/hid/hid-core.c      |  2 +-
 drivers/hid/usbhid/hiddev.c | 15 ++++-----------
 include/linux/hid.h         |  1 -
 include/linux/hiddev.h      | 11 +++++++++++
 4 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index e9e87d3..1a0b910 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1695,7 +1695,7 @@ int hid_connect(struct hid_device *hdev, unsigned int connect_mask)
 		len += sprintf(buf + len, "input");
 	if (hdev->claimed & HID_CLAIMED_HIDDEV)
 		len += sprintf(buf + len, "%shiddev%d", len ? "," : "",
-				hdev->minor);
+				((struct hiddev *)hdev->hiddev)->minor);
 	if (hdev->claimed & HID_CLAIMED_HIDRAW)
 		len += sprintf(buf + len, "%shidraw%d", len ? "," : "",
 				((struct hidraw *)hdev->hidraw)->minor);
diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
index 700145b..27721c3 100644
--- a/drivers/hid/usbhid/hiddev.c
+++ b/drivers/hid/usbhid/hiddev.c
@@ -44,17 +44,7 @@
 #define HIDDEV_MINOR_BASE	96
 #define HIDDEV_MINORS		16
 #endif
-#define HIDDEV_BUFFER_SIZE	2048
-
-struct hiddev {
-	int exist;
-	int open;
-	struct mutex existancelock;
-	wait_queue_head_t wait;
-	struct hid_device *hid;
-	struct list_head list;
-	spinlock_t list_lock;
-};
+#define HIDDEV_BUFFER_SIZE      2048
 
 struct hiddev_list {
 	struct hiddev_usage_ref buffer[HIDDEV_BUFFER_SIZE];
@@ -910,6 +900,9 @@ int hiddev_connect(struct hid_device *hid, unsigned int force)
 		kfree(hiddev);
 		return -1;
 	}
+
+	hiddev->minor = usbhid->intf->minor;
+
 	return 0;
 }
 
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 28f38e2b8..643c017 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -541,7 +541,6 @@ struct hid_device {							/* device report descriptor */
 	struct list_head inputs;					/* The list of inputs */
 	void *hiddev;							/* The hiddev structure */
 	void *hidraw;
-	int minor;							/* Hiddev minor number */
 
 	int open;							/* is the device open by anyone? */
 	char name[128];							/* Device name */
diff --git a/include/linux/hiddev.h b/include/linux/hiddev.h
index a5dd814..fb407da 100644
--- a/include/linux/hiddev.h
+++ b/include/linux/hiddev.h
@@ -32,6 +32,17 @@
  * In-kernel definitions.
  */
 
+struct hiddev {
+	int minor;
+	int exist;
+	int open;
+	struct mutex existancelock;
+	wait_queue_head_t wait;
+	struct hid_device *hid;
+	struct list_head list;
+	spinlock_t list_lock;
+};
+
 struct hid_device;
 struct hid_usage;
 struct hid_field;
-- 
2.7.4


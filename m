From: Jaejoong Kim <climbbb.kim@gmail.com>
Subject: [PATCH 2/2] HID: hiddev: store hiddev's minor number when hiddev is connected
Date: Thu,  2 Mar 2017 22:45:30 +0900
Message-ID: <1488462330-12349-3-git-send-email-climbbb.kim@gmail.com>
References: <1488462330-12349-1-git-send-email-climbbb.kim@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1488462330-12349-1-git-send-email-climbbb.kim@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, Jaejoong Kim <climbbb.kim@gmail.com>
List-Id: linux-input@vger.kernel.org

The hid-core announces kernel message which driver is loaded if there is
a hiddev, but hiddev's minor number is always zero even though it's not
zero.

So, we need to store the minor number asked from usb core and do some
refactoring work(move from hiddev.c to hiddev.h) to access hiddev in
hid-core.

Signed-off-by: Jaejoong Kim <climbbb.kim@gmail.com>
---
 drivers/hid/hid-core.c      |  2 +-
 drivers/hid/usbhid/hiddev.c | 26 +++-----------------------
 include/linux/hiddev.h      | 24 ++++++++++++++++++++++++
 3 files changed, 28 insertions(+), 24 deletions(-)

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
index 5c2c489..ef83d68 100644
--- a/drivers/hid/usbhid/hiddev.c
+++ b/drivers/hid/usbhid/hiddev.c
@@ -44,29 +44,6 @@
 #define HIDDEV_MINOR_BASE	96
 #define HIDDEV_MINORS		16
 #endif
-#define HIDDEV_BUFFER_SIZE	2048
-
-struct hiddev {
-	int minor;
-	int exist;
-	int open;
-	struct mutex existancelock;
-	wait_queue_head_t wait;
-	struct hid_device *hid;
-	struct list_head list;
-	spinlock_t list_lock;
-};
-
-struct hiddev_list {
-	struct hiddev_usage_ref buffer[HIDDEV_BUFFER_SIZE];
-	int head;
-	int tail;
-	unsigned flags;
-	struct fasync_struct *fasync;
-	struct hiddev *hiddev;
-	struct list_head node;
-	struct mutex thread_lock;
-};
 
 /*
  * Find a report, given the report's type and ID.  The ID can be specified
@@ -911,6 +888,9 @@ int hiddev_connect(struct hid_device *hid, unsigned int force)
 		kfree(hiddev);
 		return -1;
 	}
+
+	hiddev->minor = usbhid->intf->minor;
+
 	return 0;
 }
 
diff --git a/include/linux/hiddev.h b/include/linux/hiddev.h
index a5dd814..ff3701b 100644
--- a/include/linux/hiddev.h
+++ b/include/linux/hiddev.h
@@ -32,6 +32,30 @@
  * In-kernel definitions.
  */
 
+#define HIDDEV_BUFFER_SIZE      2048
+
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
+struct hiddev_list {
+	struct hiddev_usage_ref buffer[HIDDEV_BUFFER_SIZE];
+	int head;
+	int tail;
+	unsigned flags;
+	struct fasync_struct *fasync;
+	struct hiddev *hiddev;
+	struct list_head node;
+	struct mutex thread_lock;
+};
+
 struct hid_device;
 struct hid_usage;
 struct hid_field;
-- 
2.7.4

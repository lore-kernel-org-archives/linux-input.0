From: Jaejoong Kim <climbbb.kim@gmail.com>
Subject: [PATCH 1/2] HID: hiddev: move hiddev's minor number from struct hid_device to hiddev
Date: Thu,  2 Mar 2017 22:45:29 +0900
Message-ID: <1488462330-12349-2-git-send-email-climbbb.kim@gmail.com>
References: <1488462330-12349-1-git-send-email-climbbb.kim@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1488462330-12349-1-git-send-email-climbbb.kim@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, Jaejoong Kim <climbbb.kim@gmail.com>
List-Id: linux-input@vger.kernel.org

We need to store the minor number each drivers. In case of hidraw, it's
minor number stores in struct hidraw. But hiddev's minor is located in
struct hid_device.

So reallocates for hiddev's minor number.

Signed-off-by: Jaejoong Kim <climbbb.kim@gmail.com>
---
 drivers/hid/usbhid/hiddev.c | 1 +
 include/linux/hid.h         | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
index 700145b..5c2c489 100644
--- a/drivers/hid/usbhid/hiddev.c
+++ b/drivers/hid/usbhid/hiddev.c
@@ -47,6 +47,7 @@
 #define HIDDEV_BUFFER_SIZE	2048
 
 struct hiddev {
+	int minor;
 	int exist;
 	int open;
 	struct mutex existancelock;
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
-- 
2.7.4

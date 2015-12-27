From: Geliang Tang <geliangtang@163.com>
Subject: [PATCH 1/5] HID: move to_hid_device() to hid.h
Date: Sun, 27 Dec 2015 17:25:20 +0800
Message-ID: <3490fef13d9af010ff2da07012eed189c46ee3fa.1451206516.git.geliangtang@163.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from m50-132.163.com ([123.125.50.132]:41969 "EHLO m50-132.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750843AbbL0J0j (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 27 Dec 2015 04:26:39 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Geliang Tang <geliangtang@163.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

to_hid_device() macro is defined in both hid-lg4ff.c and 
hid-logitech-hidpp.c. So I move it to include/linux/hid.h.

Signed-off-by: Geliang Tang <geliangtang@163.com>
---
 drivers/hid/hid-lg4ff.c          | 2 --
 drivers/hid/hid-logitech-hidpp.c | 2 --
 include/linux/hid.h              | 3 +++
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index fbddcb3..3e160ff 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -33,8 +33,6 @@
 #include "hid-lg4ff.h"
 #include "hid-ids.h"
 
-#define to_hid_device(pdev) container_of(pdev, struct hid_device, dev)
-
 #define LG4FF_MMODE_IS_MULTIMODE 0
 #define LG4FF_MMODE_SWITCHED 1
 #define LG4FF_MMODE_NOT_MULTIMODE 2
diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index f2a4811..bd2ab476 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -1310,8 +1310,6 @@ struct g920_private_data {
 	u16 range;
 };
 
-#define to_hid_device(pdev) container_of(pdev, struct hid_device, dev)
-
 static ssize_t g920_range_show(struct device *dev, struct device_attribute *attr,
 				char *buf)
 {
diff --git a/include/linux/hid.h b/include/linux/hid.h
index a6d7a3f..1472026 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -565,6 +565,9 @@ struct hid_device {							/* device report descriptor */
 	wait_queue_head_t debug_wait;
 };
 
+#define to_hid_device(pdev) \
+	container_of(pdev, struct hid_device, dev)
+
 static inline void *hid_get_drvdata(struct hid_device *hdev)
 {
 	return dev_get_drvdata(&hdev->dev);
-- 
2.5.0



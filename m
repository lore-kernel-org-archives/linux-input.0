From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] hid-logitech : Dummy hid-lg functions should return proper error code
Date: Wed, 22 Jun 2016 01:08:59 +0530
Message-ID: <1466537939-32299-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Arvind Yadav <arvind.yadav.cs@gmail.com>
List-Id: linux-input@vger.kernel.org

inline lgff_init stub simply allows compilation on systems with
CONFIG_LOGITECH_FF disabled. The inline lgff_init should return
-ENODEV instead -1 to indicate lack of support when attempting to
register an lg_driver on such a system with CONFIG_LOGITECH_FF
disabled. Same for inline lg2ff_init and lg3ff_init stub when
CONFIG_LOGIRUMBLEPAD2_FF and CONFIG_LOGIG940_FF disabled.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/hid/hid-lg.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-lg.h b/drivers/hid/hid-lg.h
index 10dd8f0..88b8ebd 100644
--- a/drivers/hid/hid-lg.h
+++ b/drivers/hid/hid-lg.h
@@ -1,6 +1,8 @@
 #ifndef __HID_LG_H
 #define __HID_LG_H
 
+#include <linux/errno.h>
+
 struct lg_drv_data {
 	unsigned long quirks;
 	void *device_props;	/* Device specific properties */
@@ -9,19 +11,19 @@ struct lg_drv_data {
 #ifdef CONFIG_LOGITECH_FF
 int lgff_init(struct hid_device *hdev);
 #else
-static inline int lgff_init(struct hid_device *hdev) { return -1; }
+static inline int lgff_init(struct hid_device *hdev) { return -ENODEV; }
 #endif
 
 #ifdef CONFIG_LOGIRUMBLEPAD2_FF
 int lg2ff_init(struct hid_device *hdev);
 #else
-static inline int lg2ff_init(struct hid_device *hdev) { return -1; }
+static inline int lg2ff_init(struct hid_device *hdev) { return -ENODEV; }
 #endif
 
 #ifdef CONFIG_LOGIG940_FF
 int lg3ff_init(struct hid_device *hdev);
 #else
-static inline int lg3ff_init(struct hid_device *hdev) { return -1; }
+static inline int lg3ff_init(struct hid_device *hdev) { return -ENODEV; }
 #endif
 
 #endif
-- 
1.9.1

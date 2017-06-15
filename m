From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 1/3] HID: multitouch: use BIT macro
Date: Thu, 15 Jun 2017 15:32:03 +0200
Message-ID: <20170615133205.15441-2-benjamin.tissoires@redhat.com>
References: <20170615133205.15441-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170615133205.15441-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Arek Burdach <arek.burdach@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

(1 << X) is wrong. We should use BIT(X)

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-multitouch.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 24d5b6d..45be218 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -54,22 +54,22 @@ MODULE_LICENSE("GPL");
 #include "hid-ids.h"
 
 /* quirks to control the device */
-#define MT_QUIRK_NOT_SEEN_MEANS_UP	(1 << 0)
-#define MT_QUIRK_SLOT_IS_CONTACTID	(1 << 1)
-#define MT_QUIRK_CYPRESS		(1 << 2)
-#define MT_QUIRK_SLOT_IS_CONTACTNUMBER	(1 << 3)
-#define MT_QUIRK_ALWAYS_VALID		(1 << 4)
-#define MT_QUIRK_VALID_IS_INRANGE	(1 << 5)
-#define MT_QUIRK_VALID_IS_CONFIDENCE	(1 << 6)
-#define MT_QUIRK_CONFIDENCE		(1 << 7)
-#define MT_QUIRK_SLOT_IS_CONTACTID_MINUS_ONE	(1 << 8)
-#define MT_QUIRK_NO_AREA		(1 << 9)
-#define MT_QUIRK_IGNORE_DUPLICATES	(1 << 10)
-#define MT_QUIRK_HOVERING		(1 << 11)
-#define MT_QUIRK_CONTACT_CNT_ACCURATE	(1 << 12)
-#define MT_QUIRK_FORCE_GET_FEATURE	(1 << 13)
-#define MT_QUIRK_FIX_CONST_CONTACT_ID	(1 << 14)
-#define MT_QUIRK_TOUCH_SIZE_SCALING	(1 << 15)
+#define MT_QUIRK_NOT_SEEN_MEANS_UP	BIT(0)
+#define MT_QUIRK_SLOT_IS_CONTACTID	BIT(1)
+#define MT_QUIRK_CYPRESS		BIT(2)
+#define MT_QUIRK_SLOT_IS_CONTACTNUMBER	BIT(3)
+#define MT_QUIRK_ALWAYS_VALID		BIT(4)
+#define MT_QUIRK_VALID_IS_INRANGE	BIT(5)
+#define MT_QUIRK_VALID_IS_CONFIDENCE	BIT(6)
+#define MT_QUIRK_CONFIDENCE		BIT(7)
+#define MT_QUIRK_SLOT_IS_CONTACTID_MINUS_ONE	BIT(8)
+#define MT_QUIRK_NO_AREA		BIT(9)
+#define MT_QUIRK_IGNORE_DUPLICATES	BIT(10)
+#define MT_QUIRK_HOVERING		BIT(11)
+#define MT_QUIRK_CONTACT_CNT_ACCURATE	BIT(12)
+#define MT_QUIRK_FORCE_GET_FEATURE	BIT(13)
+#define MT_QUIRK_FIX_CONST_CONTACT_ID	BIT(14)
+#define MT_QUIRK_TOUCH_SIZE_SCALING	BIT(15)
 
 #define MT_INPUTMODE_TOUCHSCREEN	0x02
 #define MT_INPUTMODE_TOUCHPAD		0x03
-- 
2.9.4

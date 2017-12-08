From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 1/2] HID: use BIT macro instead of plain integers for flags
Date: Fri,  8 Dec 2017 15:28:17 +0100
Message-ID: <20171208142818.15156-2-benjamin.tissoires@redhat.com>
References: <20171208142818.15156-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171208142818.15156-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

This can lead to some hairy situation with the developer losing
a day or two realizing that 4 should be after 2, not 3.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

new in v2

 include/linux/hid.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/hid.h b/include/linux/hid.h
index a62ee4a609ac..421b62b77c69 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -494,13 +494,13 @@ struct hid_output_fifo {
 	char *raw_report;
 };
 
-#define HID_CLAIMED_INPUT	1
-#define HID_CLAIMED_HIDDEV	2
-#define HID_CLAIMED_HIDRAW	4
-#define HID_CLAIMED_DRIVER	8
+#define HID_CLAIMED_INPUT	BIT(0)
+#define HID_CLAIMED_HIDDEV	BIT(1)
+#define HID_CLAIMED_HIDRAW	BIT(2)
+#define HID_CLAIMED_DRIVER	BIT(3)
 
-#define HID_STAT_ADDED		1
-#define HID_STAT_PARSED		2
+#define HID_STAT_ADDED		BIT(0)
+#define HID_STAT_PARSED		BIT(1)
 
 struct hid_input {
 	struct list_head list;
-- 
2.14.3

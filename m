From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: [PATCH 5/7] hid: egalax: Add event filtering (rev3)
Date: Mon, 29 Nov 2010 08:43:30 +0100
Message-ID: <1291016612-25102-6-git-send-email-rydberg@euromail.se>
References: <1291016612-25102-1-git-send-email-rydberg@euromail.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1291016612-25102-1-git-send-email-rydberg@euromail.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Philipp Merkel <mail@philmerk.de>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>
List-Id: linux-input@vger.kernel.org

Use estimated signal-to-noise ratios to reduce noise and limit the
amount of events emitted.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/hid/hid-egalax.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-egalax.c b/drivers/hid/hid-egalax.c
index a6ab617..5da5ecb 100644
--- a/drivers/hid/hid-egalax.c
+++ b/drivers/hid/hid-egalax.c
@@ -25,6 +25,10 @@ MODULE_LICENSE("GPL");
 
 #include "hid-ids.h"
 
+/* estimated signal-to-noise ratios */
+#define SN_MOVE			4096
+#define SN_PRESSURE		32
+
 struct egalax_data {
 	__u16 x, y, z;
 	__u8 id;
@@ -57,17 +61,17 @@ static int egalax_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 			field->logical_maximum = 32760;
 			hid_map_usage(hi, usage, bit, max,
 					EV_ABS, ABS_MT_POSITION_X);
-			set_abs(input, ABS_MT_POSITION_X, field, 0);
+			set_abs(input, ABS_MT_POSITION_X, field, SN_MOVE);
 			/* touchscreen emulation */
-			set_abs(input, ABS_X, field, 0);
+			set_abs(input, ABS_X, field, SN_MOVE);
 			return 1;
 		case HID_GD_Y:
 			field->logical_maximum = 32760;
 			hid_map_usage(hi, usage, bit, max,
 					EV_ABS, ABS_MT_POSITION_Y);
-			set_abs(input, ABS_MT_POSITION_Y, field, 0);
+			set_abs(input, ABS_MT_POSITION_Y, field, SN_MOVE);
 			/* touchscreen emulation */
-			set_abs(input, ABS_Y, field, 0);
+			set_abs(input, ABS_Y, field, SN_MOVE);
 			return 1;
 		}
 		return 0;
@@ -93,9 +97,9 @@ static int egalax_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 			field->logical_minimum = 0;
 			hid_map_usage(hi, usage, bit, max,
 					EV_ABS, ABS_MT_PRESSURE);
-			set_abs(input, ABS_MT_PRESSURE, field, 0);
+			set_abs(input, ABS_MT_PRESSURE, field, SN_PRESSURE);
 			/* touchscreen emulation */
-			set_abs(input, ABS_PRESSURE, field, 0);
+			set_abs(input, ABS_PRESSURE, field, SN_PRESSURE);
 			return 1;
 		}
 		return 0;
-- 
1.7.1

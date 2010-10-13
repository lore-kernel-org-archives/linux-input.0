From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: [PATCH 5/6] hid: egalax: Add event filtering
Date: Wed, 13 Oct 2010 15:58:21 +0200
Message-ID: <1286978302-30034-6-git-send-email-rydberg@euromail.se>
References: <1286978302-30034-1-git-send-email-rydberg@euromail.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1286978302-30034-1-git-send-email-rydberg@euromail.se>
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
index 2aba897..b21e7dc 100644
--- a/drivers/hid/hid-egalax.c
+++ b/drivers/hid/hid-egalax.c
@@ -27,6 +27,10 @@ MODULE_LICENSE("GPL");
 
 #define MAX_EVENTS		120
 
+/* estimated signal-to-noise ratios */
+#define SN_MOVE			1024
+#define SN_PRESSURE		32
+
 struct egalax_data {
 	__u16 x, y, z;
 	__u8 id;
@@ -59,17 +63,17 @@ static int egalax_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 			field->logical_maximum <<= 3;
 			hid_map_usage(hi, usage, bit, max,
 					EV_ABS, ABS_MT_POSITION_X);
-			set_abs(input, ABS_MT_POSITION_X, field, 0);
+			set_abs(input, ABS_MT_POSITION_X, field, SN_MOVE);
 			/* touchscreen emulation */
-			set_abs(input, ABS_X, field, 0);
+			set_abs(input, ABS_X, field, SN_MOVE);
 			return 1;
 		case HID_GD_Y:
 			field->logical_maximum <<= 3;
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
@@ -96,9 +100,9 @@ static int egalax_input_mapping(struct hid_device *hdev, struct hid_input *hi,
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

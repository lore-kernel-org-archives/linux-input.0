From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: [PATCH] Use TipSwitch for Touch
Date: Wed, 14 Apr 2010 01:04:54 -0400
Message-ID: <1271221494-14846-1-git-send-email-rafi@seas.upenn.edu>
References: <alpine.LNX.2.00.1004131530460.8345@pobox.suse.cz>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from stag.seas.upenn.edu ([158.130.70.79]:33232 "EHLO
	stag.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097Ab0DNFFy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Apr 2010 01:05:54 -0400
In-Reply-To: <alpine.LNX.2.00.1004131530460.8345@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, micki@n-trig.com, dmitry.torokhov@gmail.com, chatty@enac.fr
Cc: Rafi Rubin <rafi@seas.upenn.edu>

TipSwitch is a better match for touch.  Confidence and InRange work
for more current firmwares, but with some older versions only
TipSwitch is appropriate.

Signed-off-by: Rafi Rubin <rafi@seas.upenn.edu>
---
 drivers/hid/hid-ntrig.c |   27 +++++++++++++++++++--------
 1 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
index 58ba0d3..071f86d 100644
--- a/drivers/hid/hid-ntrig.c
+++ b/drivers/hid/hid-ntrig.c
@@ -31,10 +31,12 @@ struct ntrig_data {
 	/* Incoming raw values for a single contact */
 	__u16 x, y, w, h;
 	__u16 id;
-	__u8 confidence;
+
+	bool tipswitch;
+	bool confidence;
+	bool first_contact_touch;
 
 	bool reading_mt;
-	__u8 first_contact_confidence;
 
 	__u8 mt_footer[4];
 	__u8 mt_foot_count;
@@ -141,9 +143,10 @@ static int ntrig_event (struct hid_device *hid, struct hid_field *field,
 		case 0xff000001:
 			/* Tag indicating the start of a multitouch group */
 			nd->reading_mt = 1;
-			nd->first_contact_confidence = 0;
+			nd->first_contact_touch = 0;
 			break;
 		case HID_DG_TIPSWITCH:
+			nd->tipswitch = value;
 			/* Prevent emission of touch until validated */
 			return 1;
 		case HID_DG_CONFIDENCE:
@@ -171,10 +174,17 @@ static int ntrig_event (struct hid_device *hid, struct hid_field *field,
 			 * to emit a normal (X, Y) position
 			 */
 			if (!nd->reading_mt) {
-				input_report_key(input, BTN_TOOL_DOUBLETAP,
-						 (nd->confidence != 0));
+				/*
+				 * TipSwitch indicates the presence of a
+				 * finger.  Touch is the preferred event for
+				 * downstream support.  DoubleTap is also
+				 * emitted to support proper operation with
+				 * the wacom X driver (for now).
+				 */
 				input_report_key(input, BTN_TOUCH,
-						 (nd->confidence != 0));
+						 nd->tipswitch);
+				input_report_key(input, BTN_TOOL_DOUBLETAP,
+						 nd->tipswitch);
 				input_event(input, EV_ABS, ABS_X, nd->x);
 				input_event(input, EV_ABS, ABS_Y, nd->y);
 			}
@@ -213,7 +223,8 @@ static int ntrig_event (struct hid_device *hid, struct hid_field *field,
 
 			/* emit a normal (X, Y) for the first point only */
 			if (nd->id == 0) {
-				nd->first_contact_confidence = nd->confidence;
+				nd->first_contact_touch = nd->confidence &&
+					nd->tipswitch;
 				input_event(input, EV_ABS, ABS_X, nd->x);
 				input_event(input, EV_ABS, ABS_Y, nd->y);
 			}
@@ -243,7 +254,7 @@ static int ntrig_event (struct hid_device *hid, struct hid_field *field,
 
 			nd->reading_mt = 0;
 
-			if (nd->first_contact_confidence) {
+			if (nd->first_contact_touch) {
 				switch (value) {
 				case 0:	/* for single touch devices */
 				case 1:
-- 
1.7.0.4


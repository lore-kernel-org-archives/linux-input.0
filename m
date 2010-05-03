From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: [PATCH 1/2] TipSwitch for single touch mode touch.
Date: Mon,  3 May 2010 05:08:29 -0400
Message-ID: <1272877710-25431-2-git-send-email-rafi@seas.upenn.edu>
References: <1272877710-25431-1-git-send-email-rafi@seas.upenn.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1272877710-25431-1-git-send-email-rafi@seas.upenn.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, jkosina@suse.cz, chatty@enac.fr
Cc: dmitry.torokhov@gmail.com, micki@n-trig.com, linux-kernel@vger.kernel.org, Rafi Rubin <rafi@seas.upenn.edu>
List-Id: linux-input@vger.kernel.org

Include TipSwitch in the touch detection decision for some single touch
firmwares.  Confidence and InRange are high for all finger events
including those used to indicate the finger is no longer in contact with
the sensor.

Signed-off-by: Rafi Rubin <rafi@seas.upenn.edu>
---
 drivers/hid/hid-ntrig.c |   29 +++++++++++++++++++++--------
 1 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
index 58ba0d3..10b08d6 100644
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
@@ -171,10 +174,14 @@ static int ntrig_event (struct hid_device *hid, struct hid_field *field,
 			 * to emit a normal (X, Y) position
 			 */
 			if (!nd->reading_mt) {
-				input_report_key(input, BTN_TOOL_DOUBLETAP,
-						 (nd->confidence != 0));
+				/*
+				 * TipSwitch indicates the presence of a
+				 * finger in single touch mode.
+				 */
 				input_report_key(input, BTN_TOUCH,
-						 (nd->confidence != 0));
+						 nd->tipswitch);
+				input_report_key(input, BTN_TOOL_DOUBLETAP,
+						 nd->tipswitch);
 				input_event(input, EV_ABS, ABS_X, nd->x);
 				input_event(input, EV_ABS, ABS_Y, nd->y);
 			}
@@ -213,7 +220,13 @@ static int ntrig_event (struct hid_device *hid, struct hid_field *field,
 
 			/* emit a normal (X, Y) for the first point only */
 			if (nd->id == 0) {
-				nd->first_contact_confidence = nd->confidence;
+				/*
+				 * TipSwitch is superfluous in multitouch
+				 * mode.  The footer events tell us
+				 * if there is a finger on the screen or
+				 * not.
+				 */
+				nd->first_contact_touch = nd->confidence;
 				input_event(input, EV_ABS, ABS_X, nd->x);
 				input_event(input, EV_ABS, ABS_Y, nd->y);
 			}
@@ -243,7 +256,7 @@ static int ntrig_event (struct hid_device *hid, struct hid_field *field,
 
 			nd->reading_mt = 0;
 
-			if (nd->first_contact_confidence) {
+			if (nd->first_contact_touch) {
 				switch (value) {
 				case 0:	/* for single touch devices */
 				case 1:
-- 
1.7.1

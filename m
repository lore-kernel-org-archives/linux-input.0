From: rafi@seas.upenn.edu
Subject: [PATCH] hid: ntrig touch events
Date: Wed, 10 Mar 2010 03:38:46 -0500
Message-ID: <1268210326-8066-1-git-send-email-rafi@seas.upenn.edu>
References: <4B9722A5.1030607@seas.upenn.edu>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from LION.seas.upenn.edu ([158.130.12.194]:39012 "EHLO
	lion.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755412Ab0CJIjR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Mar 2010 03:39:17 -0500
In-Reply-To: <4B9722A5.1030607@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, chatty@enac.fr
Cc: rafi <rafi@hex.seas.upenn.edu>, Rafi Rubin <rafi@seas.upenn.edu>

From: rafi <rafi@hex.seas.upenn.edu>

This reinstates the lost unpressing of BTN_TOUCH.  To prevent undesireably
touch toggles this also deals with tip switch events.

Added a trap to prevent going out of bounds for hidinputs with empty reports.

Clear bits of unused buttons which result in misidentification.

Signed-off-by: Rafi Rubin <rafi@seas.upenn.edu>
---
 drivers/hid/hid-ntrig.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
index 3234c72..edcc0c4 100644
--- a/drivers/hid/hid-ntrig.c
+++ b/drivers/hid/hid-ntrig.c
@@ -140,6 +140,9 @@ static int ntrig_event (struct hid_device *hid, struct hid_field *field,
 			nd->reading_mt = 1;
 			nd->first_contact_confidence = 0;
 			break;
+		case HID_DG_TIPSWITCH:
+			/* Prevent emission of touch until validated */
+			return 1;
 		case HID_DG_CONFIDENCE:
 			nd->confidence = value;
 			break;
@@ -259,6 +262,7 @@ static int ntrig_event (struct hid_device *hid, struct hid_field *field,
 						BTN_TOOL_TRIPLETAP, 0);
 				input_report_key(input,
 						BTN_TOOL_QUADTAP, 0);
+				input_report_key(input, BTN_TOUCH, 0);
 			}
 			break;
 
@@ -308,13 +312,20 @@ static int ntrig_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 
 	list_for_each_entry(hidinput, &hdev->inputs, list) {
+		if (hidinput->report->maxfield < 1)
+			continue;
+
 		input = hidinput->input;
 		switch (hidinput->report->field[0]->application) {
 		case HID_DG_PEN:
 			input->name = "N-Trig Pen";
 			break;
 		case HID_DG_TOUCHSCREEN:
+			/* These keys are redundant for fingers, clear them
+			 * to prevent incorrect identification */
 			__clear_bit(BTN_TOOL_PEN, input->keybit);
+			__clear_bit(BTN_TOOL_FINGER, input->keybit);
+			__clear_bit(BTN_0, input->keybit);
 			/*
 			 * A little something special to enable
 			 * two and three finger taps.
-- 
1.7.0


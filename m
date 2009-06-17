From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: [PATCH] ntrig tool separation
Date: Wed, 17 Jun 2009 01:50:26 -0400
Message-ID: <4A388422.7020802@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from LION.SEAS.upenn.edu ([158.130.12.194]:38544 "EHLO
	lion.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846AbZFQFub (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Jun 2009 01:50:31 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>

When both touch and pen are active send a tool announcement before
sending any status changes so that event users may differentiate
which tool is changing.

Signed-off-by: Rafi Rubin <rafi@seas.upenn.edu>
---
 drivers/hid/hid-ntrig.c |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
index aeab973..46ece5e 100644
--- a/drivers/hid/hid-ntrig.c
+++ b/drivers/hid/hid-ntrig.c
@@ -27,6 +27,9 @@
 struct ntrig_data {
 	__s32 x, y, id, w, h;
 	char reading_a_point, found_contact_id;
+	char pen_active;
+	char finger_active;
+	char inverted;
 };

 /*
@@ -127,11 +130,37 @@ static int ntrig_event (struct hid_device *hid, struct hid_field *field,
 	struct input_dev *input = field->hidinput->input;
 	struct ntrig_data *nd = hid_get_drvdata(hid);

+	__u16 tool;
+
         if (hid->claimed & HID_CLAIMED_INPUT) {
 		switch (usage->hid) {
+
+		case HID_DG_INRANGE:
+			if(field->application & 0x3)
+				nd->pen_active = value!=0;
+			else
+				nd->finger_active = value!=0;
+			return 0;
+
+		case HID_DG_INVERT:
+			nd->inverted = value;
+			return 0;
+
 		case HID_GD_X:
 			nd->x = value;
 			nd->reading_a_point = 1;
+			if(nd->pen_active && nd->finger_active)
+			{
+				if(field->application & 0x3)
+				{
+					tool = nd->inverted ? BTN_TOOL_RUBBER : BTN_TOOL_PEN;
+				}
+				else
+					tool = BTN_TOOL_DOUBLETAP;
+
+				input_report_key(input, tool, 0);
+				input_report_key(input, tool, 1);
+			}
 			break;
 		case HID_GD_Y:
 			nd->y = value;
-- 
1.6.3.1



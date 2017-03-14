From: Tomasz Kramkowski <tk@the-tk.com>
Subject: [PATCH v2] HID: clamp input to logical range if no null state
Date: Tue, 14 Mar 2017 13:29:13 +0000
Message-ID: <20170314132913.9730-1-tk@the-tk.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Tomasz Kramkowski <tk@the-tk.com>
List-Id: linux-input@vger.kernel.org

This patch fixes an issue in drivers/hid/hid-input.c where values
outside of the logical range are not clamped when "null state" bit of
the input control is not set.

This was discussed on the lists [1] and this change stems from the fact
due to the ambiguity of the HID specification it might be appropriate to
follow Microsoft's own interpretation of the specification. As noted in
Microsoft's documentation [2] in the section titled "Required HID usages
for digitizers" it is noted that values reported outside the logical
range "will be considered as invalid data and the value will be changed
to the nearest boundary value (logical min/max)."

This patch fixes an issue where the (1292:4745) Innomedia INNEX
GENESIS/ATARI reports out of range values for its X and Y axis of the
DPad which, due to the null state bit being unset, are forwarded to
userspace as is. Now these values will get clamped to the logical range
before being forwarded to userspace. This device was also used to test
this patch.

This patch expands on commit 3f3752705dbd ("HID: reject input outside
logical range only if null state is set").

Signed-off-by: Tomasz Kramkowski <tk@the-tk.com>
Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
v1 was: https://lkml.kernel.org/r/20170308215211.24263-1-tk@the-tk.com
v2:
 - Expand comment to mention change and link to MSDN.
 - Use clamp instead of ?: .
 - Don't range check twice.
 - Add Acked-by.
---
 drivers/hid/hid-input.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index cf8256aac2bd..a1ebdd7d4d4d 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1150,19 +1150,26 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
 
 	/*
 	 * Ignore out-of-range values as per HID specification,
-	 * section 5.10 and 6.2.25.
+	 * section 5.10 and 6.2.25, when NULL state bit is present.
+	 * When it's not, clamp the value to match Microsoft's input
+	 * driver as mentioned in "Required HID usages for digitizers":
+	 * https://msdn.microsoft.com/en-us/library/windows/hardware/dn672278(v=vs.85).asp
 	 *
 	 * The logical_minimum < logical_maximum check is done so that we
 	 * don't unintentionally discard values sent by devices which
 	 * don't specify logical min and max.
 	 */
 	if ((field->flags & HID_MAIN_ITEM_VARIABLE) &&
-	    (field->flags & HID_MAIN_ITEM_NULL_STATE) &&
-	    (field->logical_minimum < field->logical_maximum) &&
-	    (value < field->logical_minimum ||
-	     value > field->logical_maximum)) {
-		dbg_hid("Ignoring out-of-range value %x\n", value);
-		return;
+	    (field->logical_minimum < field->logical_maximum)) {
+		if (field->flags & HID_MAIN_ITEM_NULL_STATE &&
+		    (value < field->logical_minimum ||
+		     value > field->logical_maximum)) {
+			dbg_hid("Ignoring out-of-range value %x\n", value);
+			return;
+		}
+		value = clamp(value,
+			      field->logical_minimum,
+			      field->logical_maximum);
 	}
 
 	/*
-- 
2.12.0

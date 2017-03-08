From: Tomasz Kramkowski <tk@the-tk.com>
Subject: [PATCH 1/1] HID: clamp input to logical range if no null state
Date: Wed,  8 Mar 2017 21:52:11 +0000
Message-ID: <20170308215211.24263-1-tk@the-tk.com>
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

[1]: http://lkml.kernel.org/r/20170307131036.GA853@gaia.local
[2]: https://msdn.microsoft.com/en-us/library/windows/hardware/dn672278(v=vs.85).asp

Signed-off-by: Tomasz Kramkowski <tk@the-tk.com>
---
 drivers/hid/hid-input.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index cf8256aac2bd..cf38ff79cfe9 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1157,12 +1157,15 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
 	 * don't specify logical min and max.
 	 */
 	if ((field->flags & HID_MAIN_ITEM_VARIABLE) &&
-	    (field->flags & HID_MAIN_ITEM_NULL_STATE) &&
 	    (field->logical_minimum < field->logical_maximum) &&
 	    (value < field->logical_minimum ||
 	     value > field->logical_maximum)) {
-		dbg_hid("Ignoring out-of-range value %x\n", value);
-		return;
+		if (field->flags & HID_MAIN_ITEM_NULL_STATE) {
+			dbg_hid("Ignoring out-of-range value %x\n", value);
+			return;
+		}
+		value = value < field->logical_minimum ?
+			field->logical_minimum : field->logical_maximum;
 	}
 
 	/*
-- 
2.12.0

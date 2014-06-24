From: Antonio Ospite <ao2@ao2.it>
Subject: [PATCH 2/4] HID: sony: Always override the Sixaxis descriptor
Date: Tue, 24 Jun 2014 13:28:41 +0200
Message-ID: <1403609323-27283-3-git-send-email-ao2@ao2.it>
References: <1403609323-27283-1-git-send-email-ao2@ao2.it>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp206.alice.it ([82.57.200.102]:15672 "EHLO smtp206.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753637AbaFXMML (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Jun 2014 08:12:11 -0400
In-Reply-To: <1403609323-27283-1-git-send-email-ao2@ao2.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Antonio Ospite <ao2@ao2.it>, Jiri Kosina <jkosina@suse.cz>, simon@mungewell.org, Frank Praznik <frank.praznik@oh.rr.com>

Simplify the logic of overriding the Sixaxis HID descriptor, this will
make it easier to amend the descriptor in future commits.

The current code does this:

	if (original sixaxis via USB or BT)
		fixup only a part of the descriptor
	else if (sixaxis compatible controller)
		override the _whole_ descriptor

but the end result is exactly the same, except for the trailing zero in
the case of original BT controllers.

So let's just regularize the process, and always override the HID
descriptor.

Always overriding the descriptor changes the current semantic a little
bit, before this change the BT descriptor still had the trailing zero
byte, while now it is exactly the same as the descriptor of the
controller via USB, but that does not affect proper operation of the
device.

Note that overriding the whole descriptor for original devices is not
strictly necessary for now, but it simplifies the code and in the future
the report descriptor will be patched further and keys will be remapped,
so it's handy to have only one place to patch.

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---
 drivers/hid/hid-sony.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index a77269b..11026b5 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -56,13 +56,7 @@
 
 #define MAX_LEDS 4
 
-static const u8 sixaxis_rdesc_fixup[] = {
-	0x95, 0x13, 0x09, 0x01, 0x81, 0x02, 0x95, 0x0C,
-	0x81, 0x01, 0x75, 0x10, 0x95, 0x04, 0x26, 0xFF,
-	0x03, 0x46, 0xFF, 0x03, 0x09, 0x01, 0x81, 0x02
-};
-
-static const u8 sixaxis_rdesc_fixup2[] = {
+static __u8 sixaxis_rdesc[] = {
 	0x05, 0x01, 0x09, 0x04, 0xa1, 0x01, 0xa1, 0x02,
 	0x85, 0x01, 0x75, 0x08, 0x95, 0x01, 0x15, 0x00,
 	0x26, 0xff, 0x00, 0x81, 0x03, 0x75, 0x01, 0x95,
@@ -778,6 +772,13 @@ struct sony_sc {
 	__u8 led_count;
 };
 
+static __u8 *sixaxis_fixup(struct hid_device *hdev, __u8 *rdesc,
+			     unsigned int *rsize)
+{
+	*rsize = sizeof(sixaxis_rdesc);
+	return sixaxis_rdesc;
+}
+
 static __u8 *ps3remote_fixup(struct hid_device *hdev, __u8 *rdesc,
 			     unsigned int *rsize)
 {
@@ -857,20 +858,8 @@ static __u8 *sony_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		*rsize = sizeof(dualshock4_bt_rdesc);
 	}
 
-	/* The HID descriptor exposed over BT has a trailing zero byte */
-	if ((((sc->quirks & SIXAXIS_CONTROLLER_USB) && *rsize == 148) ||
-			((sc->quirks & SIXAXIS_CONTROLLER_BT) && *rsize == 149)) &&
-			rdesc[83] == 0x75) {
-		hid_info(hdev, "Fixing up Sony Sixaxis report descriptor\n");
-		memcpy((void *)&rdesc[83], (void *)&sixaxis_rdesc_fixup,
-			sizeof(sixaxis_rdesc_fixup));
-	} else if (sc->quirks & SIXAXIS_CONTROLLER_USB &&
-		   *rsize > sizeof(sixaxis_rdesc_fixup2)) {
-		hid_info(hdev, "Sony Sixaxis clone detected. Using original report descriptor (size: %d clone; %d new)\n",
-			 *rsize, (int)sizeof(sixaxis_rdesc_fixup2));
-		*rsize = sizeof(sixaxis_rdesc_fixup2);
-		memcpy(rdesc, &sixaxis_rdesc_fixup2, *rsize);
-	}
+	if (sc->quirks & SIXAXIS_CONTROLLER)
+		return sixaxis_fixup(hdev, rdesc, rsize);
 
 	if (sc->quirks & PS3REMOTE)
 		return ps3remote_fixup(hdev, rdesc, rsize);
-- 
2.0.0


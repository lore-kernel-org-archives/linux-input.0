From: Antonio Ospite <ospite@studenti.unina.it>
Subject: [PATCH v5 1/2] hid-sony: amend Sixaxis descriptor to enable accelerometers
Date: Fri, 10 Jun 2011 12:00:26 +0200
Message-ID: <1307700027-10657-1-git-send-email-ospite@studenti.unina.it>
References: <1b0af21baa09ca623bbe62ee253f5d36.squirrel@host171.canaca.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp208.alice.it ([82.57.200.104]:43193 "EHLO smtp208.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754573Ab1FJKAe (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Jun 2011 06:00:34 -0400
In-Reply-To: <1b0af21baa09ca623bbe62ee253f5d36.squirrel@host171.canaca.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Simon Wood <simon@mungewell.org>, Jiri Kosina <jkosina@suse.cz>, Marcin Tolysz <tolysz@gmail.com>, Michael Bauer <michael@m-bauer.org>, Antonio Ospite <ospite@studenti.unina.it>

From: Simon Wood <simon@mungewell.org>

Modify the HID descriptor of the Sixaxis controller to allow the
reporting of the accelerometers and gyro via a joystick axis.

Rewrite section from offset 83:
--
0x75, 0x08,         /* Report Size (8),         */
/* all the other data lumped together */
0x95, 0x27,         /* Report Count (39),       */
0x09, 0x01,         /* Usage (Pointer),         */
0x81, 0x02,         /* Input (Variable),        */
0x75, 0x08,         /* Report Size (8),         */
0x95, 0x30,         /* Report Count (48),       */
0x09, 0x01,         /* Usage (Pointer),         */
/* Note Output */
0x91, 0x02,         /* Output (Variable),       */
0x75, 0x08,         /* Report Size (8),         */
0x95, 0x30,         /* Report Count (48),       */
0x09, 0x01,         /* Usage (Pointer),         */
/* Note Feature */
0xB1, 0x02,         /* Feature (Variable),      */
--
with
--
/* last 2 not used... */
0x95, 0x13,         /* Report Count (19),       */
0x09, 0x01,         /* Usage (Pointer),         */
0x81, 0x02,         /* Input (Variable),        */
/* Padding */
0x95, 0x0C,         /* Report Count (12),       */
0x81, 0x01,         /* Input (Constant),        */
0x75, 0x10,         /* Report Size (16),        */
0x95, 0x04,         /* Report Count (4),        */
0x26, 0xFF, 0x03,   /* Logical Maximum (1023),  */
0x46, 0xFF, 0x03,   /* Physical Maximum (1023), */
0x09, 0x01,         /* Usage (Pointer),         */
0x81, 0x02,         /* Input (Variable),        */
--

Signed-off-by: Simon Wood <simon@mungewell.org>
Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>
---

Changes since v4:
 - Adjusted the short commit message
 - Wrapped the long commit message to 72 chars
 - Fixed the typo about the offset 
 - Removed a trailing space in sixaxis_rdesc_fixup[]
 - Removed some extra white spaces from the if condition

Simon, please double check the comments above in the commit message, I 
put the inlined ones before the line they were on.

The patch gives only one checkpatch.pl WARNING about a line over 80 chars, 
but I guess this can be accepted.

I tested both patches, my Signed-off-by includes the Tested-by :)

Thanks,
   Antonio

 drivers/hid/hid-sony.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index e0c83ef..60b4257 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -28,6 +28,12 @@
 #define SIXAXIS_CONTROLLER_USB  (1 << 1)
 #define SIXAXIS_CONTROLLER_BT   (1 << 2)
 
+static const u8 sixaxis_rdesc_fixup[] = {
+	0x95, 0x13, 0x09, 0x01, 0x81, 0x02, 0x95, 0x0C,
+	0x81, 0x01, 0x75, 0x10, 0x95, 0x04, 0x26, 0xFF,
+	0x03, 0x46, 0xFF, 0x03, 0x09, 0x01, 0x81, 0x02
+};
+
 struct sony_sc {
 	unsigned long quirks;
 };
@@ -43,6 +49,15 @@ static __u8 *sony_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		hid_info(hdev, "Fixing up Sony Vaio VGX report descriptor\n");
 		rdesc[55] = 0x06;
 	}
+
+	/* The HID descriptor exposed over BT has a trailing zero byte */
+	if ((((sc->quirks & SIXAXIS_CONTROLLER_USB) && *rsize == 148) ||
+			((sc->quirks & SIXAXIS_CONTROLLER_BT) && *rsize == 149)) &&
+			rdesc[83] == 0x75) {
+		hid_info(hdev, "Fixing up Sony Sixaxis report descriptor\n");
+		memcpy((void *)&rdesc[83], (void *)&sixaxis_rdesc_fixup,
+			sizeof(sixaxis_rdesc_fixup));
+	}
 	return rdesc;
 }
 
-- 
1.7.5.3


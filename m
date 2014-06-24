From: Antonio Ospite <ao2@ao2.it>
Subject: [PATCH 3/4] HID: sony: Format and comment sixaxis_rdesc
Date: Tue, 24 Jun 2014 13:28:42 +0200
Message-ID: <1403609323-27283-4-git-send-email-ao2@ao2.it>
References: <1403609323-27283-1-git-send-email-ao2@ao2.it>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp207.alice.it ([82.57.200.103]:11281 "EHLO smtp207.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751530AbaFXMSW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Jun 2014 08:18:22 -0400
In-Reply-To: <1403609323-27283-1-git-send-email-ao2@ao2.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Antonio Ospite <ao2@ao2.it>, Jiri Kosina <jkosina@suse.cz>, simon@mungewell.org, Frank Praznik <frank.praznik@oh.rr.com>

Reformat sixaxis_rdesc to reflect its HID structure, and comment each
field. This will make it easier to validate changes to the descriptor in
the future.

No functional changes are introduced, the descriptor is exactly the same
as before byte by byte.

The heavy lifting has been done with the help of hidrd-convert:
https://github.com/DIGImend/hidrd

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---
 drivers/hid/hid-sony.c | 93 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 74 insertions(+), 19 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 11026b5..22ba5dd 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -57,25 +57,80 @@
 #define MAX_LEDS 4
 
 static __u8 sixaxis_rdesc[] = {
-	0x05, 0x01, 0x09, 0x04, 0xa1, 0x01, 0xa1, 0x02,
-	0x85, 0x01, 0x75, 0x08, 0x95, 0x01, 0x15, 0x00,
-	0x26, 0xff, 0x00, 0x81, 0x03, 0x75, 0x01, 0x95,
-	0x13, 0x15, 0x00, 0x25, 0x01, 0x35, 0x00, 0x45,
-	0x01, 0x05, 0x09, 0x19, 0x01, 0x29, 0x13, 0x81,
-	0x02, 0x75, 0x01, 0x95, 0x0d, 0x06, 0x00, 0xff,
-	0x81, 0x03, 0x15, 0x00, 0x26, 0xff, 0x00, 0x05,
-	0x01, 0x09, 0x01, 0xa1, 0x00, 0x75, 0x08, 0x95,
-	0x04, 0x35, 0x00, 0x46, 0xff, 0x00, 0x09, 0x30,
-	0x09, 0x31, 0x09, 0x32, 0x09, 0x35, 0x81, 0x02,
-	0xc0, 0x05, 0x01, 0x95, 0x13, 0x09, 0x01, 0x81,
-	0x02, 0x95, 0x0c, 0x81, 0x01, 0x75, 0x10, 0x95,
-	0x04, 0x26, 0xff, 0x03, 0x46, 0xff, 0x03, 0x09,
-	0x01, 0x81, 0x02, 0xc0, 0xa1, 0x02, 0x85, 0x02,
-	0x75, 0x08, 0x95, 0x30, 0x09, 0x01, 0xb1, 0x02,
-	0xc0, 0xa1, 0x02, 0x85, 0xee, 0x75, 0x08, 0x95,
-	0x30, 0x09, 0x01, 0xb1, 0x02, 0xc0, 0xa1, 0x02,
-	0x85, 0xef, 0x75, 0x08, 0x95, 0x30, 0x09, 0x01,
-	0xb1, 0x02, 0xc0, 0xc0,
+	0x05, 0x01,         /*  Usage Page (Desktop),               */
+	0x09, 0x04,         /*  Usage (Joystik),                    */
+	0xA1, 0x01,         /*  Collection (Application),           */
+	0xA1, 0x02,         /*      Collection (Logical),           */
+	0x85, 0x01,         /*          Report ID (1),              */
+	0x75, 0x08,         /*          Report Size (8),            */
+	0x95, 0x01,         /*          Report Count (1),           */
+	0x15, 0x00,         /*          Logical Minimum (0),        */
+	0x26, 0xFF, 0x00,   /*          Logical Maximum (255),      */
+	0x81, 0x03,         /*          Input (Constant, Variable), */
+	0x75, 0x01,         /*          Report Size (1),            */
+	0x95, 0x13,         /*          Report Count (19),          */
+	0x15, 0x00,         /*          Logical Minimum (0),        */
+	0x25, 0x01,         /*          Logical Maximum (1),        */
+	0x35, 0x00,         /*          Physical Minimum (0),       */
+	0x45, 0x01,         /*          Physical Maximum (1),       */
+	0x05, 0x09,         /*          Usage Page (Button),        */
+	0x19, 0x01,         /*          Usage Minimum (01h),        */
+	0x29, 0x13,         /*          Usage Maximum (13h),        */
+	0x81, 0x02,         /*          Input (Variable),           */
+	0x75, 0x01,         /*          Report Size (1),            */
+	0x95, 0x0D,         /*          Report Count (13),          */
+	0x06, 0x00, 0xFF,   /*          Usage Page (FF00h),         */
+	0x81, 0x03,         /*          Input (Constant, Variable), */
+	0x15, 0x00,         /*          Logical Minimum (0),        */
+	0x26, 0xFF, 0x00,   /*          Logical Maximum (255),      */
+	0x05, 0x01,         /*          Usage Page (Desktop),       */
+	0x09, 0x01,         /*          Usage (Pointer),            */
+	0xA1, 0x00,         /*          Collection (Physical),      */
+	0x75, 0x08,         /*              Report Size (8),        */
+	0x95, 0x04,         /*              Report Count (4),       */
+	0x35, 0x00,         /*              Physical Minimum (0),   */
+	0x46, 0xFF, 0x00,   /*              Physical Maximum (255), */
+	0x09, 0x30,         /*              Usage (X),              */
+	0x09, 0x31,         /*              Usage (Y),              */
+	0x09, 0x32,         /*              Usage (Z),              */
+	0x09, 0x35,         /*              Usage (Rz),             */
+	0x81, 0x02,         /*              Input (Variable),       */
+	0xC0,               /*          End Collection,             */
+	0x05, 0x01,         /*          Usage Page (Desktop),       */
+	0x95, 0x13,         /*          Report Count (19),          */
+	0x09, 0x01,         /*          Usage (Pointer),            */
+	0x81, 0x02,         /*          Input (Variable),           */
+	0x95, 0x0C,         /*          Report Count (12),          */
+	0x81, 0x01,         /*          Input (Constant),           */
+	0x75, 0x10,         /*          Report Size (16),           */
+	0x95, 0x04,         /*          Report Count (4),           */
+	0x26, 0xFF, 0x03,   /*          Logical Maximum (1023),     */
+	0x46, 0xFF, 0x03,   /*          Physical Maximum (1023),    */
+	0x09, 0x01,         /*          Usage (Pointer),            */
+	0x81, 0x02,         /*          Input (Variable),           */
+	0xC0,               /*      End Collection,                 */
+	0xA1, 0x02,         /*      Collection (Logical),           */
+	0x85, 0x02,         /*          Report ID (2),              */
+	0x75, 0x08,         /*          Report Size (8),            */
+	0x95, 0x30,         /*          Report Count (48),          */
+	0x09, 0x01,         /*          Usage (Pointer),            */
+	0xB1, 0x02,         /*          Feature (Variable),         */
+	0xC0,               /*      End Collection,                 */
+	0xA1, 0x02,         /*      Collection (Logical),           */
+	0x85, 0xEE,         /*          Report ID (238),            */
+	0x75, 0x08,         /*          Report Size (8),            */
+	0x95, 0x30,         /*          Report Count (48),          */
+	0x09, 0x01,         /*          Usage (Pointer),            */
+	0xB1, 0x02,         /*          Feature (Variable),         */
+	0xC0,               /*      End Collection,                 */
+	0xA1, 0x02,         /*      Collection (Logical),           */
+	0x85, 0xEF,         /*          Report ID (239),            */
+	0x75, 0x08,         /*          Report Size (8),            */
+	0x95, 0x30,         /*          Report Count (48),          */
+	0x09, 0x01,         /*          Usage (Pointer),            */
+	0xB1, 0x02,         /*          Feature (Variable),         */
+	0xC0,               /*      End Collection,                 */
+	0xC0                /*  End Collection                      */
 };
 
 /*
-- 
2.0.0


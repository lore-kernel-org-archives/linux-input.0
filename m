From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH v3 2/6] HID: sony: Add modified Dualshock 4 Bluetooth HID descriptor
Date: Wed,  5 Feb 2014 20:03:45 -0500
Message-ID: <1391648629-3077-3-git-send-email-frank.praznik@oh.rr.com>
References: <1391648629-3077-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:56151 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753169AbaBFBEQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Feb 2014 20:04:16 -0500
In-Reply-To: <1391648629-3077-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, dh.herrmann@gmail.com, Frank Praznik <frank.praznik@oh.rr.com>

By default, the Dualshock 4 sends controller data via report 1. Once a valid
output report 0x11 is received or a feature report of type 0x02 is requested the
controller changes from sending data in report 1 to sending data in report 17,
which is unmapped in the default descriptor. The mappings have to be moved to
report 17 to let the HID driver properly process the incoming reports.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
---
 drivers/hid/hid-sony.c | 214 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 214 insertions(+)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 71fd17f..e9775a1 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -336,6 +336,216 @@ static u8 dualshock4_usb_rdesc[] = {
 	0xC0                /*  End Collection                      */
 };
 
+/* The default behavior of the Dualshock 4 is to send reports using report
+ * type 1 when running over Bluetooth. However, as soon as it receives a
+ * report of type 17 to set the LEDs or rumble it starts returning it's state
+ * in report 17 instead of 1.  Since report 17 is undefined in the default HID
+ * descriptor the button and axis definitions must be moved to report 17 or
+ * the HID layer won't process the received input once a report is sent.
+ */
+static u8 dualshock4_bt_rdesc[] = {
+	0x05, 0x01,         /*  Usage Page (Desktop),               */
+	0x09, 0x05,         /*  Usage (Gamepad),                    */
+	0xA1, 0x01,         /*  Collection (Application),           */
+	0x85, 0x01,         /*      Report ID (1),                  */
+	0x75, 0x08,         /*      Report Size (8),                */
+	0x95, 0x0A,         /*      Report Count (9),               */
+	0x81, 0x02,         /*      Input (Variable),               */
+	0x06, 0x04, 0xFF,   /*      Usage Page (FF04h),             */
+	0x85, 0x02,         /*      Report ID (2),                  */
+	0x09, 0x24,         /*      Usage (24h),                    */
+	0x95, 0x24,         /*      Report Count (36),              */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0x85, 0xA3,         /*      Report ID (163),                */
+	0x09, 0x25,         /*      Usage (25h),                    */
+	0x95, 0x30,         /*      Report Count (48),              */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0x85, 0x05,         /*      Report ID (5),                  */
+	0x09, 0x26,         /*      Usage (26h),                    */
+	0x95, 0x28,         /*      Report Count (40),              */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0x85, 0x06,         /*      Report ID (6),                  */
+	0x09, 0x27,         /*      Usage (27h),                    */
+	0x95, 0x34,         /*      Report Count (52),              */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0x85, 0x07,         /*      Report ID (7),                  */
+	0x09, 0x28,         /*      Usage (28h),                    */
+	0x95, 0x30,         /*      Report Count (48),              */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0x85, 0x08,         /*      Report ID (8),                  */
+	0x09, 0x29,         /*      Usage (29h),                    */
+	0x95, 0x2F,         /*      Report Count (47),              */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0x06, 0x03, 0xFF,   /*      Usage Page (FF03h),             */
+	0x85, 0x03,         /*      Report ID (3),                  */
+	0x09, 0x21,         /*      Usage (21h),                    */
+	0x95, 0x26,         /*      Report Count (38),              */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0x85, 0x04,         /*      Report ID (4),                  */
+	0x09, 0x22,         /*      Usage (22h),                    */
+	0x95, 0x2E,         /*      Report Count (46),              */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0x85, 0xF0,         /*      Report ID (240),                */
+	0x09, 0x47,         /*      Usage (47h),                    */
+	0x95, 0x3F,         /*      Report Count (63),              */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0x85, 0xF1,         /*      Report ID (241),                */
+	0x09, 0x48,         /*      Usage (48h),                    */
+	0x95, 0x3F,         /*      Report Count (63),              */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0x85, 0xF2,         /*      Report ID (242),                */
+	0x09, 0x49,         /*      Usage (49h),                    */
+	0x95, 0x0F,         /*      Report Count (15),              */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0x85, 0x11,         /*      Report ID (17),                 */
+	0x06, 0x00, 0xFF,   /*      Usage Page (FF00h),             */
+	0x09, 0x20,         /*      Usage (20h),                    */
+	0x95, 0x02,         /*      Report Count (2),               */
+	0x81, 0x02,         /*      Input (Variable),               */
+	0x05, 0x01,         /*      Usage Page (Desktop),           */
+	0x09, 0x30,         /*      Usage (X),                      */
+	0x09, 0x31,         /*      Usage (Y),                      */
+	0x09, 0x32,         /*      Usage (Z),                      */
+	0x09, 0x35,         /*      Usage (Rz),                     */
+	0x15, 0x00,         /*      Logical Minimum (0),            */
+	0x26, 0xFF, 0x00,   /*      Logical Maximum (255),          */
+	0x75, 0x08,         /*      Report Size (8),                */
+	0x95, 0x04,         /*      Report Count (4),               */
+	0x81, 0x02,         /*      Input (Variable),               */
+	0x09, 0x39,         /*      Usage (Hat Switch),             */
+	0x15, 0x00,         /*      Logical Minimum (0),            */
+	0x25, 0x07,         /*      Logical Maximum (7),            */
+	0x75, 0x04,         /*      Report Size (4),                */
+	0x95, 0x01,         /*      Report Count (1),               */
+	0x81, 0x42,         /*      Input (Variable, Null State),   */
+	0x05, 0x09,         /*      Usage Page (Button),            */
+	0x19, 0x01,         /*      Usage Minimum (01h),            */
+	0x29, 0x0E,         /*      Usage Maximum (0Eh),            */
+	0x15, 0x00,         /*      Logical Minimum (0),            */
+	0x25, 0x01,         /*      Logical Maximum (1),            */
+	0x75, 0x01,         /*      Report Size (1),                */
+	0x95, 0x0E,         /*      Report Count (14),              */
+	0x81, 0x02,         /*      Input (Variable),               */
+	0x75, 0x06,         /*      Report Size (6),                */
+	0x95, 0x01,         /*      Report Count (1),               */
+	0x81, 0x01,         /*      Input (Constant),               */
+	0x05, 0x01,         /*      Usage Page (Desktop),           */
+	0x09, 0x33,         /*      Usage (Rx),                     */
+	0x09, 0x34,         /*      Usage (Ry),                     */
+	0x15, 0x00,         /*      Logical Minimum (0),            */
+	0x26, 0xFF, 0x00,   /*      Logical Maximum (255),          */
+	0x75, 0x08,         /*      Report Size (8),                */
+	0x95, 0x02,         /*      Report Count (2),               */
+	0x81, 0x02,         /*      Input (Variable),               */
+	0x06, 0x00, 0xFF,   /*      Usage Page (FF00h),             */
+	0x09, 0x20,         /*      Usage (20h),                    */
+	0x95, 0x03,         /*      Report Count (3),               */
+	0x81, 0x02,         /*      Input (Variable),               */
+	0x05, 0x01,         /*      Usage Page (Desktop),           */
+	0x19, 0x40,         /*      Usage Minimum (40h),            */
+	0x29, 0x42,         /*      Usage Maximum (42h),            */
+	0x16, 0x00, 0x80,   /*      Logical Minimum (-32768),       */
+	0x26, 0x00, 0x7F,   /*      Logical Maximum (32767),        */
+	0x75, 0x10,         /*      Report Size (16),               */
+	0x95, 0x03,         /*      Report Count (3),               */
+	0x81, 0x02,         /*      Input (Variable),               */
+	0x19, 0x43,         /*      Usage Minimum (43h),            */
+	0x29, 0x45,         /*      Usage Maximum (45h),            */
+	0x16, 0xFF, 0xBF,   /*      Logical Minimum (-16385),       */
+	0x26, 0x00, 0x40,   /*      Logical Maximum (16384),        */
+	0x95, 0x03,         /*      Report Count (3),               */
+	0x81, 0x02,         /*      Input (Variable),               */
+	0x06, 0x00, 0xFF,   /*      Usage Page (FF00h),             */
+	0x09, 0x20,         /*      Usage (20h),                    */
+	0x15, 0x00,         /*      Logical Minimum (0),            */
+	0x26, 0xFF, 0x00,   /*      Logical Maximum (255),          */
+	0x75, 0x08,         /*      Report Size (8),                */
+	0x95, 0x31,         /*      Report Count (51),              */
+	0x81, 0x02,         /*      Input (Variable),               */
+	0x09, 0x21,         /*      Usage (21h),                    */
+	0x75, 0x08,         /*      Report Size (8),                */
+	0x95, 0x4D,         /*      Report Count (77),              */
+	0x91, 0x02,         /*      Output (Variable),              */
+	0x85, 0x12,         /*      Report ID (18),                 */
+	0x09, 0x22,         /*      Usage (22h),                    */
+	0x95, 0x8D,         /*      Report Count (141),             */
+	0x81, 0x02,         /*      Input (Variable),               */
+	0x09, 0x23,         /*      Usage (23h),                    */
+	0x91, 0x02,         /*      Output (Variable),              */
+	0x85, 0x13,         /*      Report ID (19),                 */
+	0x09, 0x24,         /*      Usage (24h),                    */
+	0x95, 0xCD,         /*      Report Count (205),             */
+	0x81, 0x02,         /*      Input (Variable),               */
+	0x09, 0x25,         /*      Usage (25h),                    */
+	0x91, 0x02,         /*      Output (Variable),              */
+	0x85, 0x14,         /*      Report ID (20),                 */
+	0x09, 0x26,         /*      Usage (26h),                    */
+	0x96, 0x0D, 0x01,   /*      Report Count (269),             */
+	0x81, 0x02,         /*      Input (Variable),               */
+	0x09, 0x27,         /*      Usage (27h),                    */
+	0x91, 0x02,         /*      Output (Variable),              */
+	0x85, 0x15,         /*      Report ID (21),                 */
+	0x09, 0x28,         /*      Usage (28h),                    */
+	0x96, 0x4D, 0x01,   /*      Report Count (333),             */
+	0x81, 0x02,         /*      Input (Variable),               */
+	0x09, 0x29,         /*      Usage (29h),                    */
+	0x91, 0x02,         /*      Output (Variable),              */
+	0x85, 0x16,         /*      Report ID (22),                 */
+	0x09, 0x2A,         /*      Usage (2Ah),                    */
+	0x96, 0x8D, 0x01,   /*      Report Count (397),             */
+	0x81, 0x02,         /*      Input (Variable),               */
+	0x09, 0x2B,         /*      Usage (2Bh),                    */
+	0x91, 0x02,         /*      Output (Variable),              */
+	0x85, 0x17,         /*      Report ID (23),                 */
+	0x09, 0x2C,         /*      Usage (2Ch),                    */
+	0x96, 0xCD, 0x01,   /*      Report Count (461),             */
+	0x81, 0x02,         /*      Input (Variable),               */
+	0x09, 0x2D,         /*      Usage (2Dh),                    */
+	0x91, 0x02,         /*      Output (Variable),              */
+	0x85, 0x18,         /*      Report ID (24),                 */
+	0x09, 0x2E,         /*      Usage (2Eh),                    */
+	0x96, 0x0D, 0x02,   /*      Report Count (525),             */
+	0x81, 0x02,         /*      Input (Variable),               */
+	0x09, 0x2F,         /*      Usage (2Fh),                    */
+	0x91, 0x02,         /*      Output (Variable),              */
+	0x85, 0x19,         /*      Report ID (25),                 */
+	0x09, 0x30,         /*      Usage (30h),                    */
+	0x96, 0x22, 0x02,   /*      Report Count (546),             */
+	0x81, 0x02,         /*      Input (Variable),               */
+	0x09, 0x31,         /*      Usage (31h),                    */
+	0x91, 0x02,         /*      Output (Variable),              */
+	0x06, 0x80, 0xFF,   /*      Usage Page (FF80h),             */
+	0x85, 0x82,         /*      Report ID (130),                */
+	0x09, 0x22,         /*      Usage (22h),                    */
+	0x95, 0x3F,         /*      Report Count (63),              */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0x85, 0x83,         /*      Report ID (131),                */
+	0x09, 0x23,         /*      Usage (23h),                    */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0x85, 0x84,         /*      Report ID (132),                */
+	0x09, 0x24,         /*      Usage (24h),                    */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0x85, 0x90,         /*      Report ID (144),                */
+	0x09, 0x30,         /*      Usage (30h),                    */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0x85, 0x91,         /*      Report ID (145),                */
+	0x09, 0x31,         /*      Usage (31h),                    */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0x85, 0x92,         /*      Report ID (146),                */
+	0x09, 0x32,         /*      Usage (32h),                    */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0x85, 0x93,         /*      Report ID (147),                */
+	0x09, 0x33,         /*      Usage (33h),                    */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0x85, 0xA0,         /*      Report ID (160),                */
+	0x09, 0x40,         /*      Usage (40h),                    */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0x85, 0xA4,         /*      Report ID (164),                */
+	0x09, 0x44,         /*      Usage (44h),                    */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0xC0                /*  End Collection                      */
+};
+
 static __u8 ps3remote_rdesc[] = {
 	0x05, 0x01,          /* GUsagePage Generic Desktop */
 	0x09, 0x05,          /* LUsage 0x05 [Game Pad] */
@@ -591,6 +801,10 @@ static __u8 *sony_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		hid_info(hdev, "Using modified Dualshock 4 report descriptor with gyroscope axes\n");
 		rdesc = dualshock4_usb_rdesc;
 		*rsize = sizeof(dualshock4_usb_rdesc);
+	} else if ((sc->quirks & DUALSHOCK4_CONTROLLER_BT) && *rsize == 357) {
+		hid_info(hdev, "Using modified Dualshock 4 Bluetooth report descriptor\n");
+		rdesc = dualshock4_bt_rdesc;
+		*rsize = sizeof(dualshock4_bt_rdesc);
 	}
 
 	/* The HID descriptor exposed over BT has a trailing zero byte */
-- 
1.8.5.3


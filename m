From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH 1/2] Add annotated HID descriptor for the Dualshock 4.
Date: Mon, 20 Jan 2014 12:27:01 -0500
Message-ID: <1390238822-18164-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:55076 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887AbaATR11 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Jan 2014 12:27:27 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, Frank Praznik <frank.praznik@oh.rr.com>

Add annotated HID descriptor for the Dualshock 4.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>

---

 Apply against jikos/hid.git/for-3.14/sony

 drivers/hid/hid-sony.c | 320 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 256 insertions(+), 64 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 9013005..62765c7 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -73,71 +73,263 @@ static const u8 sixaxis_rdesc_fixup2[] = {
 	0xb1, 0x02, 0xc0, 0xc0,
 };
 
+/* The default descriptor doesn't provide mapping for the accelerometers
+ * or orientation sensors.  This fixed descriptor maps the accelerometers
+ * to usage values 0x40, 0x41 and 0x42 and maps the orientation sensors
+ * to usage values 0x43, 0x44 and 0x45.
+ */
 static u8 dualshock4_usb_rdesc[] = {
-	0x05, 0x01, 0x09, 0x05, 0xa1, 0x01, 0x85, 0x01,
-	0x09, 0x30, 0x09, 0x31, 0x09, 0x32, 0x09, 0x35,
-	0x15, 0x00, 0x26, 0xff, 0x00, 0x75, 0x08, 0x95,
-	0x04, 0x81, 0x02, 0x09, 0x39, 0x15, 0x00, 0x25,
-	0x07, 0x35, 0x00, 0x46, 0x3b, 0x01, 0x65, 0x14,
-	0x75, 0x04, 0x95, 0x01, 0x81, 0x42, 0x65, 0x00,
-	0x05, 0x09, 0x19, 0x01, 0x29, 0x0e, 0x15, 0x00,
-	0x25, 0x01, 0x75, 0x01, 0x95, 0x0e, 0x81, 0x02,
-	0x06, 0x00, 0xff, 0x09, 0x20, 0x75, 0x06, 0x95,
-	0x01, 0x15, 0x00, 0x25, 0x7f, 0x81, 0x02, 0x05,
-	0x01, 0x09, 0x33, 0x09, 0x34, 0x15, 0x00, 0x26,
-	0xff, 0x00, 0x75, 0x08, 0x95, 0x02, 0x81, 0x02,
-	0x06, 0x00, 0xff, 0x09, 0x21, 0x95, 0x03, 0x81,
-	0x02, 0x05, 0x01, 0x19, 0x40, 0x29, 0x42, 0x16,
-	0x00, 0x80, 0x26, 0x00, 0x7f, 0x75, 0x10, 0x95,
-	0x03, 0x81, 0x02, 0x05, 0x01, 0x19, 0x43, 0x29,
-	0x45, 0x16, 0xff, 0xbf, 0x26, 0x00, 0x40, 0x95,
-	0x03, 0x81, 0x02, 0x06, 0x00, 0xff, 0x09, 0x21,
-	0x75, 0x08, 0x95, 0x27, 0x81, 0x02, 0x85, 0x05,
-	0x09, 0x22, 0x95, 0x1f, 0x91, 0x02, 0x85, 0x04,
-	0x09, 0x23, 0x95, 0x24, 0xb1, 0x02, 0x85, 0x02,
-	0x09, 0x24, 0x95, 0x24, 0xb1, 0x02, 0x85, 0x08,
-	0x09, 0x25, 0x95, 0x03, 0xb1, 0x02, 0x85, 0x10,
-	0x09, 0x26, 0x95, 0x04, 0xb1, 0x02, 0x85, 0x11,
-	0x09, 0x27, 0x95, 0x02, 0xb1, 0x02, 0x85, 0x12,
-	0x06, 0x02, 0xff, 0x09, 0x21, 0x95, 0x0f, 0xb1,
-	0x02, 0x85, 0x13, 0x09, 0x22, 0x95, 0x16, 0xb1,
-	0x02, 0x85, 0x14, 0x06, 0x05, 0xff, 0x09, 0x20,
-	0x95, 0x10, 0xb1, 0x02, 0x85, 0x15, 0x09, 0x21,
-	0x95, 0x2c, 0xb1, 0x02, 0x06, 0x80, 0xff, 0x85,
-	0x80, 0x09, 0x20, 0x95, 0x06, 0xb1, 0x02, 0x85,
-	0x81, 0x09, 0x21, 0x95, 0x06, 0xb1, 0x02, 0x85,
-	0x82, 0x09, 0x22, 0x95, 0x05, 0xb1, 0x02, 0x85,
-	0x83, 0x09, 0x23, 0x95, 0x01, 0xb1, 0x02, 0x85,
-	0x84, 0x09, 0x24, 0x95, 0x04, 0xb1, 0x02, 0x85,
-	0x85, 0x09, 0x25, 0x95, 0x06, 0xb1, 0x02, 0x85,
-	0x86, 0x09, 0x26, 0x95, 0x06, 0xb1, 0x02, 0x85,
-	0x87, 0x09, 0x27, 0x95, 0x23, 0xb1, 0x02, 0x85,
-	0x88, 0x09, 0x28, 0x95, 0x22, 0xb1, 0x02, 0x85,
-	0x89, 0x09, 0x29, 0x95, 0x02, 0xb1, 0x02, 0x85,
-	0x90, 0x09, 0x30, 0x95, 0x05, 0xb1, 0x02, 0x85,
-	0x91, 0x09, 0x31, 0x95, 0x03, 0xb1, 0x02, 0x85,
-	0x92, 0x09, 0x32, 0x95, 0x03, 0xb1, 0x02, 0x85,
-	0x93, 0x09, 0x33, 0x95, 0x0c, 0xb1, 0x02, 0x85,
-	0xa0, 0x09, 0x40, 0x95, 0x06, 0xb1, 0x02, 0x85,
-	0xa1, 0x09, 0x41, 0x95, 0x01, 0xb1, 0x02, 0x85,
-	0xa2, 0x09, 0x42, 0x95, 0x01, 0xb1, 0x02, 0x85,
-	0xa3, 0x09, 0x43, 0x95, 0x30, 0xb1, 0x02, 0x85,
-	0xa4, 0x09, 0x44, 0x95, 0x0d, 0xb1, 0x02, 0x85,
-	0xa5, 0x09, 0x45, 0x95, 0x15, 0xb1, 0x02, 0x85,
-	0xa6, 0x09, 0x46, 0x95, 0x15, 0xb1, 0x02, 0x85,
-	0xf0, 0x09, 0x47, 0x95, 0x3f, 0xb1, 0x02, 0x85,
-	0xf1, 0x09, 0x48, 0x95, 0x3f, 0xb1, 0x02, 0x85,
-	0xf2, 0x09, 0x49, 0x95, 0x0f, 0xb1, 0x02, 0x85,
-	0xa7, 0x09, 0x4a, 0x95, 0x01, 0xb1, 0x02, 0x85,
-	0xa8, 0x09, 0x4b, 0x95, 0x01, 0xb1, 0x02, 0x85,
-	0xa9, 0x09, 0x4c, 0x95, 0x08, 0xb1, 0x02, 0x85,
-	0xaa, 0x09, 0x4e, 0x95, 0x01, 0xb1, 0x02, 0x85,
-	0xab, 0x09, 0x4f, 0x95, 0x39, 0xb1, 0x02, 0x85,
-	0xac, 0x09, 0x50, 0x95, 0x39, 0xb1, 0x02, 0x85,
-	0xad, 0x09, 0x51, 0x95, 0x0b, 0xb1, 0x02, 0x85,
-	0xae, 0x09, 0x52, 0x95, 0x01, 0xb1, 0x02, 0x85,
-	0xaf, 0x09, 0x53, 0x95, 0x02, 0xb1, 0x02, 0x85,
-	0xb0, 0x09, 0x54, 0x95, 0x3f, 0xb1, 0x02, 0xc0,
+	0x05, 0x01,         /*  Usage Page (Desktop),               */
+	0x09, 0x05,         /*  Usage (Gamepad),                    */
+	0xA1, 0x01,         /*  Collection (Application),           */
+	0x85, 0x01,         /*      Report ID (1),                  */
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
+	0x35, 0x00,         /*      Physical Minimum (0),           */
+	0x46, 0x3B, 0x01,   /*      Physical Maximum (315),         */
+	0x65, 0x14,         /*      Unit (Degrees),                 */
+	0x75, 0x04,         /*      Report Size (4),                */
+	0x95, 0x01,         /*      Report Count (1),               */
+	0x81, 0x42,         /*      Input (Variable, Null State),   */
+	0x65, 0x00,         /*      Unit,                           */
+	0x05, 0x09,         /*      Usage Page (Button),            */
+	0x19, 0x01,         /*      Usage Minimum (01h),            */
+	0x29, 0x0E,         /*      Usage Maximum (0Eh),            */
+	0x15, 0x00,         /*      Logical Minimum (0),            */
+	0x25, 0x01,         /*      Logical Maximum (1),            */
+	0x75, 0x01,         /*      Report Size (1),                */
+	0x95, 0x0E,         /*      Report Count (14),              */
+	0x81, 0x02,         /*      Input (Variable),               */
+	0x06, 0x00, 0xFF,   /*      Usage Page (FF00h),             */
+	0x09, 0x20,         /*      Usage (20h),                    */
+	0x75, 0x06,         /*      Report Size (6),                */
+	0x95, 0x01,         /*      Report Count (1),               */
+	0x15, 0x00,         /*      Logical Minimum (0),            */
+	0x25, 0x7F,         /*      Logical Maximum (127),          */
+	0x81, 0x02,         /*      Input (Variable),               */
+	0x05, 0x01,         /*      Usage Page (Desktop),           */
+	0x09, 0x33,         /*      Usage (Rx),                     */
+	0x09, 0x34,         /*      Usage (Ry),                     */
+	0x15, 0x00,         /*      Logical Minimum (0),            */
+	0x26, 0xFF, 0x00,   /*      Logical Maximum (255),          */
+	0x75, 0x08,         /*      Report Size (8),                */
+	0x95, 0x02,         /*      Report Count (2),               */
+	0x81, 0x02,         /*      Input (Variable),               */
+	0x06, 0x00, 0xFF,   /*      Usage Page (FF00h),             */
+	0x09, 0x21,         /*      Usage (21h),                    */
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
+	0x09, 0x21,         /*      Usage (21h),                    */
+	0x15, 0x00,         /*      Logical Minimum (0),            */
+	0x25, 0xFF,         /*      Logical Maximum (255),          */
+	0x75, 0x08,         /*      Report Size (8),                */
+	0x95, 0x27,         /*      Report Count (39),              */
+	0x81, 0x02,         /*      Input (Variable),               */
+	0x85, 0x05,         /*      Report ID (5),                  */
+	0x09, 0x22,         /*      Usage (22h),                    */
+	0x95, 0x1F,         /*      Report Count (31),              */
+	0x91, 0x02,         /*      Output (Variable),              */
+	0x85, 0x04,         /*      Report ID (4),                  */
+	0x09, 0x23,         /*      Usage (23h),                    */
+	0x95, 0x24,         /*      Report Count (36),              */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0x85, 0x02,         /*      Report ID (2),                  */
+	0x09, 0x24,         /*      Usage (24h),                    */
+	0x95, 0x24,         /*      Report Count (36),              */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0x85, 0x08,         /*      Report ID (8),                  */
+	0x09, 0x25,         /*      Usage (25h),                    */
+	0x95, 0x03,         /*      Report Count (3),               */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0x85, 0x10,         /*      Report ID (16),                 */
+	0x09, 0x26,         /*      Usage (26h),                    */
+	0x95, 0x04,         /*      Report Count (4),               */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0x85, 0x11,         /*      Report ID (17),                 */
+	0x09, 0x27,         /*      Usage (27h),                    */
+	0x95, 0x02,         /*      Report Count (2),               */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0x85, 0x12,         /*      Report ID (18),                 */
+	0x06, 0x02, 0xFF,   /*      Usage Page (FF02h),             */
+	0x09, 0x21,         /*      Usage (21h),                    */
+	0x95, 0x0F,         /*      Report Count (15),              */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0x85, 0x13,         /*      Report ID (19),                 */
+	0x09, 0x22,         /*      Usage (22h),                    */
+	0x95, 0x16,         /*      Report Count (22),              */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0x85, 0x14,         /*      Report ID (20),                 */
+	0x06, 0x05, 0xFF,   /*      Usage Page (FF05h),             */
+	0x09, 0x20,         /*      Usage (20h),                    */
+	0x95, 0x10,         /*      Report Count (16),              */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0x85, 0x15,         /*      Report ID (21),                 */
+	0x09, 0x21,         /*      Usage (21h),                    */
+	0x95, 0x2C,         /*      Report Count (44),              */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0x06, 0x80, 0xFF,   /*      Usage Page (FF80h),             */
+	0x85, 0x80,         /*      Report ID (128),                */
+	0x09, 0x20,         /*      Usage (20h),                    */
+	0x95, 0x06,         /*      Report Count (6),               */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0x85, 0x81,         /*      Report ID (129),                */
+	0x09, 0x21,         /*      Usage (21h),                    */
+	0x95, 0x06,         /*      Report Count (6),               */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0x85, 0x82,         /*      Report ID (130),                */
+	0x09, 0x22,         /*      Usage (22h),                    */
+	0x95, 0x05,         /*      Report Count (5),               */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0x85, 0x83,         /*      Report ID (131),                */
+	0x09, 0x23,         /*      Usage (23h),                    */
+	0x95, 0x01,         /*      Report Count (1),               */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0x85, 0x84,         /*      Report ID (132),                */
+	0x09, 0x24,         /*      Usage (24h),                    */
+	0x95, 0x04,         /*      Report Count (4),               */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0x85, 0x85,         /*      Report ID (133),                */
+	0x09, 0x25,         /*      Usage (25h),                    */
+	0x95, 0x06,         /*      Report Count (6),               */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0x85, 0x86,         /*      Report ID (134),                */
+	0x09, 0x26,         /*      Usage (26h),                    */
+	0x95, 0x06,         /*      Report Count (6),               */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0x85, 0x87,         /*      Report ID (135),                */
+	0x09, 0x27,         /*      Usage (27h),                    */
+	0x95, 0x23,         /*      Report Count (35),              */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0x85, 0x88,         /*      Report ID (136),                */
+	0x09, 0x28,         /*      Usage (28h),                    */
+	0x95, 0x22,         /*      Report Count (34),              */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0x85, 0x89,         /*      Report ID (137),                */
+	0x09, 0x29,         /*      Usage (29h),                    */
+	0x95, 0x02,         /*      Report Count (2),               */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0x85, 0x90,         /*      Report ID (144),                */
+	0x09, 0x30,         /*      Usage (30h),                    */
+	0x95, 0x05,         /*      Report Count (5),               */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0x85, 0x91,         /*      Report ID (145),                */
+	0x09, 0x31,         /*      Usage (31h),                    */
+	0x95, 0x03,         /*      Report Count (3),               */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0x85, 0x92,         /*      Report ID (146),                */
+	0x09, 0x32,         /*      Usage (32h),                    */
+	0x95, 0x03,         /*      Report Count (3),               */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0x85, 0x93,         /*      Report ID (147),                */
+	0x09, 0x33,         /*      Usage (33h),                    */
+	0x95, 0x0C,         /*      Report Count (12),              */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0x85, 0xA0,         /*      Report ID (160),                */
+	0x09, 0x40,         /*      Usage (40h),                    */
+	0x95, 0x06,         /*      Report Count (6),               */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0x85, 0xA1,         /*      Report ID (161),                */
+	0x09, 0x41,         /*      Usage (41h),                    */
+	0x95, 0x01,         /*      Report Count (1),               */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0x85, 0xA2,         /*      Report ID (162),                */
+	0x09, 0x42,         /*      Usage (42h),                    */
+	0x95, 0x01,         /*      Report Count (1),               */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0x85, 0xA3,         /*      Report ID (163),                */
+	0x09, 0x43,         /*      Usage (43h),                    */
+	0x95, 0x30,         /*      Report Count (48),              */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0x85, 0xA4,         /*      Report ID (164),                */
+	0x09, 0x44,         /*      Usage (44h),                    */
+	0x95, 0x0D,         /*      Report Count (13),              */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0x85, 0xA5,         /*      Report ID (165),                */
+	0x09, 0x45,         /*      Usage (45h),                    */
+	0x95, 0x15,         /*      Report Count (21),              */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0x85, 0xA6,         /*      Report ID (166),                */
+	0x09, 0x46,         /*      Usage (46h),                    */
+	0x95, 0x15,         /*      Report Count (21),              */
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
+	0x85, 0xA7,         /*      Report ID (167),                */
+	0x09, 0x4A,         /*      Usage (4Ah),                    */
+	0x95, 0x01,         /*      Report Count (1),               */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0x85, 0xA8,         /*      Report ID (168),                */
+	0x09, 0x4B,         /*      Usage (4Bh),                    */
+	0x95, 0x01,         /*      Report Count (1),               */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0x85, 0xA9,         /*      Report ID (169),                */
+	0x09, 0x4C,         /*      Usage (4Ch),                    */
+	0x95, 0x08,         /*      Report Count (8),               */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0x85, 0xAA,         /*      Report ID (170),                */
+	0x09, 0x4E,         /*      Usage (4Eh),                    */
+	0x95, 0x01,         /*      Report Count (1),               */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0x85, 0xAB,         /*      Report ID (171),                */
+	0x09, 0x4F,         /*      Usage (4Fh),                    */
+	0x95, 0x39,         /*      Report Count (57),              */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0x85, 0xAC,         /*      Report ID (172),                */
+	0x09, 0x50,         /*      Usage (50h),                    */
+	0x95, 0x39,         /*      Report Count (57),              */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0x85, 0xAD,         /*      Report ID (173),                */
+	0x09, 0x51,         /*      Usage (51h),                    */
+	0x95, 0x0B,         /*      Report Count (11),              */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0x85, 0xAE,         /*      Report ID (174),                */
+	0x09, 0x52,         /*      Usage (52h),                    */
+	0x95, 0x01,         /*      Report Count (1),               */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0x85, 0xAF,         /*      Report ID (175),                */
+	0x09, 0x53,         /*      Usage (53h),                    */
+	0x95, 0x02,         /*      Report Count (2),               */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0x85, 0xB0,         /*      Report ID (176),                */
+	0x09, 0x54,         /*      Usage (54h),                    */
+	0x95, 0x3F,         /*      Report Count (63),              */
+	0xB1, 0x02,         /*      Feature (Variable),             */
+	0xC0                /*  End Collection                      */
 };
 
 static __u8 ps3remote_rdesc[] = {
-- 
1.8.3.2


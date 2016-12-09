From: Roderick Colenbrander <roderick@gaikai.com>
Subject: [PATCH 4/7] HID: sony: Report DS4 motion sensors through a separate device
Date: Thu,  8 Dec 2016 19:09:53 -0800
Message-ID: <1481252996-25288-5-git-send-email-roderick@gaikai.com>
References: <1481252996-25288-1-git-send-email-roderick@gaikai.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:35544 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932532AbcLIDKq (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 8 Dec 2016 22:10:46 -0500
Received: by mail-pg0-f51.google.com with SMTP id p66so2562923pga.2
        for <linux-input@vger.kernel.org>; Thu, 08 Dec 2016 19:10:46 -0800 (PST)
In-Reply-To: <1481252996-25288-1-git-send-email-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Simon Wood <simon@mungewell.org>, Frank Praznik <frank.praznik@gmail.com>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

The DS4 motion sensors are currently mapped by the hid-core driver
to non-existing axes in between ABS_MISC and ABS_MT_SLOT, because
the device already exhausted ABS_X-ABS_RZ. For a part the mapping
by hid-core is accomplished by a fixup in hid-sony as the motion
axes actually use vendor specific usage pages.

This patch makes the DS4 use a separate input device for the motion
sensors and reports acceleration data through ABS_X-ABS_Z and
gyroscope data through ABS_RX-ABS_RZ. In addition it extends the
event spec to allow gyroscope data through ABS_RX-ABS_RZ when
INPUT_PROP_ACCELEROMETER is set. This change was suggested by
Peter Hutterer during a discussion on linux-input.

Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
---
 Documentation/input/event-codes.txt |   5 +-
 drivers/hid/hid-sony.c              | 394 ++++++++++--------------------------
 include/uapi/linux/input.h          |  11 +-
 3 files changed, 114 insertions(+), 296 deletions(-)

diff --git a/Documentation/input/event-codes.txt b/Documentation/input/event-codes.txt
index 36ea940..575415f 100644
--- a/Documentation/input/event-codes.txt
+++ b/Documentation/input/event-codes.txt
@@ -301,7 +301,10 @@ them as any other INPUT_PROP_BUTTONPAD device.
 INPUT_PROP_ACCELEROMETER
 -------------------------
 Directional axes on this device (absolute and/or relative x, y, z) represent
-accelerometer data. All other axes retain their meaning. A device must not mix
+accelerometer data. Some devices also report gyroscope data, which devices
+can report through the rotational axes (absolute and/or relative rx, ry, rz).
+
+All other axes retain their meaning. A device must not mix
 regular directional axes and accelerometer axes on the same event node.
 
 Guidelines:
diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index f405b07..1385ac1 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -344,265 +344,6 @@ static u8 navigation_rdesc[] = {
 	0xC0                /*  End Collection                      */
 };
 
-/*
- * The default descriptor doesn't provide mapping for the accelerometers
- * or orientation sensors.  This fixed descriptor maps the accelerometers
- * to usage values 0x40, 0x41 and 0x42 and maps the orientation sensors
- * to usage values 0x43, 0x44 and 0x45.
- */
-static u8 dualshock4_usb_rdesc[] = {
-	0x05, 0x01,         /*  Usage Page (Desktop),               */
-	0x09, 0x05,         /*  Usage (Gamepad),                    */
-	0xA1, 0x01,         /*  Collection (Application),           */
-	0x85, 0x01,         /*      Report ID (1),                  */
-	0x09, 0x30,         /*      Usage (X),                      */
-	0x09, 0x31,         /*      Usage (Y),                      */
-	0x09, 0x32,         /*      Usage (Z),                      */
-	0x09, 0x35,         /*      Usage (Rz),                     */
-	0x15, 0x00,         /*      Logical Minimum (0),            */
-	0x26, 0xFF, 0x00,   /*      Logical Maximum (255),          */
-	0x75, 0x08,         /*      Report Size (8),                */
-	0x95, 0x04,         /*      Report Count (4),               */
-	0x81, 0x02,         /*      Input (Variable),               */
-	0x09, 0x39,         /*      Usage (Hat Switch),             */
-	0x15, 0x00,         /*      Logical Minimum (0),            */
-	0x25, 0x07,         /*      Logical Maximum (7),            */
-	0x35, 0x00,         /*      Physical Minimum (0),           */
-	0x46, 0x3B, 0x01,   /*      Physical Maximum (315),         */
-	0x65, 0x14,         /*      Unit (Degrees),                 */
-	0x75, 0x04,         /*      Report Size (4),                */
-	0x95, 0x01,         /*      Report Count (1),               */
-	0x81, 0x42,         /*      Input (Variable, Null State),   */
-	0x65, 0x00,         /*      Unit,                           */
-	0x05, 0x09,         /*      Usage Page (Button),            */
-	0x19, 0x01,         /*      Usage Minimum (01h),            */
-	0x29, 0x0D,         /*      Usage Maximum (0Dh),            */
-	0x15, 0x00,         /*      Logical Minimum (0),            */
-	0x25, 0x01,         /*      Logical Maximum (1),            */
-	0x75, 0x01,         /*      Report Size (1),                */
-	0x95, 0x0E,         /*      Report Count (14),              */
-	0x81, 0x02,         /*      Input (Variable),               */
-	0x06, 0x00, 0xFF,   /*      Usage Page (FF00h),             */
-	0x09, 0x20,         /*      Usage (20h),                    */
-	0x75, 0x06,         /*      Report Size (6),                */
-	0x95, 0x01,         /*      Report Count (1),               */
-	0x15, 0x00,         /*      Logical Minimum (0),            */
-	0x25, 0x3F,         /*      Logical Maximum (63),           */
-	0x81, 0x02,         /*      Input (Variable),               */
-	0x05, 0x01,         /*      Usage Page (Desktop),           */
-	0x09, 0x33,         /*      Usage (Rx),                     */
-	0x09, 0x34,         /*      Usage (Ry),                     */
-	0x15, 0x00,         /*      Logical Minimum (0),            */
-	0x26, 0xFF, 0x00,   /*      Logical Maximum (255),          */
-	0x75, 0x08,         /*      Report Size (8),                */
-	0x95, 0x02,         /*      Report Count (2),               */
-	0x81, 0x02,         /*      Input (Variable),               */
-	0x06, 0x00, 0xFF,   /*      Usage Page (FF00h),             */
-	0x09, 0x21,         /*      Usage (21h),                    */
-	0x95, 0x03,         /*      Report Count (3),               */
-	0x81, 0x02,         /*      Input (Variable),               */
-	0x05, 0x01,         /*      Usage Page (Desktop),           */
-	0x19, 0x40,         /*      Usage Minimum (40h),            */
-	0x29, 0x42,         /*      Usage Maximum (42h),            */
-	0x16, 0x00, 0x80,   /*      Logical Minimum (-32768),       */
-	0x26, 0xFF, 0x7F,   /*      Logical Maximum (32767),        */
-	0x75, 0x10,         /*      Report Size (16),               */
-	0x95, 0x03,         /*      Report Count (3),               */
-	0x81, 0x02,         /*      Input (Variable),               */
-	0x19, 0x43,         /*      Usage Minimum (43h),            */
-	0x29, 0x45,         /*      Usage Maximum (45h),            */
-	0x16, 0x00, 0x80,   /*      Logical Minimum (-32768),       */
-	0x26, 0xFF, 0x7F,   /*      Logical Maximum (32767),        */
-	0x95, 0x03,         /*      Report Count (3),               */
-	0x81, 0x02,         /*      Input (Variable),               */
-	0x06, 0x00, 0xFF,   /*      Usage Page (FF00h),             */
-	0x09, 0x21,         /*      Usage (21h),                    */
-	0x15, 0x00,         /*      Logical Minimum (0),            */
-	0x26, 0xFF, 0x00,   /*      Logical Maximum (255),          */
-	0x75, 0x08,         /*      Report Size (8),                */
-	0x95, 0x27,         /*      Report Count (39),              */
-	0x81, 0x02,         /*      Input (Variable),               */
-	0x85, 0x05,         /*      Report ID (5),                  */
-	0x09, 0x22,         /*      Usage (22h),                    */
-	0x95, 0x1F,         /*      Report Count (31),              */
-	0x91, 0x02,         /*      Output (Variable),              */
-	0x85, 0x04,         /*      Report ID (4),                  */
-	0x09, 0x23,         /*      Usage (23h),                    */
-	0x95, 0x24,         /*      Report Count (36),              */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0x02,         /*      Report ID (2),                  */
-	0x09, 0x24,         /*      Usage (24h),                    */
-	0x95, 0x24,         /*      Report Count (36),              */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0x08,         /*      Report ID (8),                  */
-	0x09, 0x25,         /*      Usage (25h),                    */
-	0x95, 0x03,         /*      Report Count (3),               */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0x10,         /*      Report ID (16),                 */
-	0x09, 0x26,         /*      Usage (26h),                    */
-	0x95, 0x04,         /*      Report Count (4),               */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0x11,         /*      Report ID (17),                 */
-	0x09, 0x27,         /*      Usage (27h),                    */
-	0x95, 0x02,         /*      Report Count (2),               */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0x12,         /*      Report ID (18),                 */
-	0x06, 0x02, 0xFF,   /*      Usage Page (FF02h),             */
-	0x09, 0x21,         /*      Usage (21h),                    */
-	0x95, 0x0F,         /*      Report Count (15),              */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0x13,         /*      Report ID (19),                 */
-	0x09, 0x22,         /*      Usage (22h),                    */
-	0x95, 0x16,         /*      Report Count (22),              */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0x14,         /*      Report ID (20),                 */
-	0x06, 0x05, 0xFF,   /*      Usage Page (FF05h),             */
-	0x09, 0x20,         /*      Usage (20h),                    */
-	0x95, 0x10,         /*      Report Count (16),              */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0x15,         /*      Report ID (21),                 */
-	0x09, 0x21,         /*      Usage (21h),                    */
-	0x95, 0x2C,         /*      Report Count (44),              */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x06, 0x80, 0xFF,   /*      Usage Page (FF80h),             */
-	0x85, 0x80,         /*      Report ID (128),                */
-	0x09, 0x20,         /*      Usage (20h),                    */
-	0x95, 0x06,         /*      Report Count (6),               */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0x81,         /*      Report ID (129),                */
-	0x09, 0x21,         /*      Usage (21h),                    */
-	0x95, 0x06,         /*      Report Count (6),               */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0x82,         /*      Report ID (130),                */
-	0x09, 0x22,         /*      Usage (22h),                    */
-	0x95, 0x05,         /*      Report Count (5),               */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0x83,         /*      Report ID (131),                */
-	0x09, 0x23,         /*      Usage (23h),                    */
-	0x95, 0x01,         /*      Report Count (1),               */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0x84,         /*      Report ID (132),                */
-	0x09, 0x24,         /*      Usage (24h),                    */
-	0x95, 0x04,         /*      Report Count (4),               */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0x85,         /*      Report ID (133),                */
-	0x09, 0x25,         /*      Usage (25h),                    */
-	0x95, 0x06,         /*      Report Count (6),               */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0x86,         /*      Report ID (134),                */
-	0x09, 0x26,         /*      Usage (26h),                    */
-	0x95, 0x06,         /*      Report Count (6),               */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0x87,         /*      Report ID (135),                */
-	0x09, 0x27,         /*      Usage (27h),                    */
-	0x95, 0x23,         /*      Report Count (35),              */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0x88,         /*      Report ID (136),                */
-	0x09, 0x28,         /*      Usage (28h),                    */
-	0x95, 0x22,         /*      Report Count (34),              */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0x89,         /*      Report ID (137),                */
-	0x09, 0x29,         /*      Usage (29h),                    */
-	0x95, 0x02,         /*      Report Count (2),               */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0x90,         /*      Report ID (144),                */
-	0x09, 0x30,         /*      Usage (30h),                    */
-	0x95, 0x05,         /*      Report Count (5),               */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0x91,         /*      Report ID (145),                */
-	0x09, 0x31,         /*      Usage (31h),                    */
-	0x95, 0x03,         /*      Report Count (3),               */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0x92,         /*      Report ID (146),                */
-	0x09, 0x32,         /*      Usage (32h),                    */
-	0x95, 0x03,         /*      Report Count (3),               */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0x93,         /*      Report ID (147),                */
-	0x09, 0x33,         /*      Usage (33h),                    */
-	0x95, 0x0C,         /*      Report Count (12),              */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0xA0,         /*      Report ID (160),                */
-	0x09, 0x40,         /*      Usage (40h),                    */
-	0x95, 0x06,         /*      Report Count (6),               */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0xA1,         /*      Report ID (161),                */
-	0x09, 0x41,         /*      Usage (41h),                    */
-	0x95, 0x01,         /*      Report Count (1),               */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0xA2,         /*      Report ID (162),                */
-	0x09, 0x42,         /*      Usage (42h),                    */
-	0x95, 0x01,         /*      Report Count (1),               */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0xA3,         /*      Report ID (163),                */
-	0x09, 0x43,         /*      Usage (43h),                    */
-	0x95, 0x30,         /*      Report Count (48),              */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0xA4,         /*      Report ID (164),                */
-	0x09, 0x44,         /*      Usage (44h),                    */
-	0x95, 0x0D,         /*      Report Count (13),              */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0xA5,         /*      Report ID (165),                */
-	0x09, 0x45,         /*      Usage (45h),                    */
-	0x95, 0x15,         /*      Report Count (21),              */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0xA6,         /*      Report ID (166),                */
-	0x09, 0x46,         /*      Usage (46h),                    */
-	0x95, 0x15,         /*      Report Count (21),              */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0xF0,         /*      Report ID (240),                */
-	0x09, 0x47,         /*      Usage (47h),                    */
-	0x95, 0x3F,         /*      Report Count (63),              */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0xF1,         /*      Report ID (241),                */
-	0x09, 0x48,         /*      Usage (48h),                    */
-	0x95, 0x3F,         /*      Report Count (63),              */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0xF2,         /*      Report ID (242),                */
-	0x09, 0x49,         /*      Usage (49h),                    */
-	0x95, 0x0F,         /*      Report Count (15),              */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0xA7,         /*      Report ID (167),                */
-	0x09, 0x4A,         /*      Usage (4Ah),                    */
-	0x95, 0x01,         /*      Report Count (1),               */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0xA8,         /*      Report ID (168),                */
-	0x09, 0x4B,         /*      Usage (4Bh),                    */
-	0x95, 0x01,         /*      Report Count (1),               */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0xA9,         /*      Report ID (169),                */
-	0x09, 0x4C,         /*      Usage (4Ch),                    */
-	0x95, 0x08,         /*      Report Count (8),               */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0xAA,         /*      Report ID (170),                */
-	0x09, 0x4E,         /*      Usage (4Eh),                    */
-	0x95, 0x01,         /*      Report Count (1),               */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0xAB,         /*      Report ID (171),                */
-	0x09, 0x4F,         /*      Usage (4Fh),                    */
-	0x95, 0x39,         /*      Report Count (57),              */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0xAC,         /*      Report ID (172),                */
-	0x09, 0x50,         /*      Usage (50h),                    */
-	0x95, 0x39,         /*      Report Count (57),              */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0xAD,         /*      Report ID (173),                */
-	0x09, 0x51,         /*      Usage (51h),                    */
-	0x95, 0x0B,         /*      Report Count (11),              */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0xAE,         /*      Report ID (174),                */
-	0x09, 0x52,         /*      Usage (52h),                    */
-	0x95, 0x01,         /*      Report Count (1),               */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0xAF,         /*      Report ID (175),                */
-	0x09, 0x53,         /*      Usage (53h),                    */
-	0x95, 0x02,         /*      Report Count (2),               */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0x85, 0xB0,         /*      Report ID (176),                */
-	0x09, 0x54,         /*      Usage (54h),                    */
-	0x95, 0x3F,         /*      Report Count (63),              */
-	0xB1, 0x02,         /*      Feature (Variable),             */
-	0xC0                /*  End Collection                      */
-};
 
 /*
  * The default behavior of the Dualshock 4 is to send reports using report
@@ -706,31 +447,10 @@ static u8 dualshock4_bt_rdesc[] = {
 	0x75, 0x08,         /*      Report Size (8),                */
 	0x95, 0x02,         /*      Report Count (2),               */
 	0x81, 0x02,         /*      Input (Variable),               */
-	0x06, 0x00, 0xFF,   /*      Usage Page (FF00h),             */
-	0x09, 0x20,         /*      Usage (20h),                    */
-	0x95, 0x03,         /*      Report Count (3),               */
-	0x81, 0x02,         /*      Input (Variable),               */
-	0x05, 0x01,         /*      Usage Page (Desktop),           */
-	0x19, 0x40,         /*      Usage Minimum (40h),            */
-	0x29, 0x42,         /*      Usage Maximum (42h),            */
-	0x16, 0x00, 0x80,   /*      Logical Minimum (-32768),       */
-	0x26, 0xFF, 0x7F,   /*      Logical Maximum (32767),        */
-	0x75, 0x10,         /*      Report Size (16),               */
-	0x95, 0x03,         /*      Report Count (3),               */
-	0x81, 0x02,         /*      Input (Variable),               */
-	0x19, 0x43,         /*      Usage Minimum (43h),            */
-	0x29, 0x45,         /*      Usage Maximum (45h),            */
-	0x16, 0x00, 0x80,   /*      Logical Minimum (-32768),       */
-	0x26, 0xFF, 0x7F,   /*      Logical Maximum (32767),        */
-	0x95, 0x03,         /*      Report Count (3),               */
-	0x81, 0x02,         /*      Input (Variable),               */
-	0x06, 0x00, 0xFF,   /*      Usage Page (FF00h),             */
-	0x09, 0x20,         /*      Usage (20h),                    */
-	0x15, 0x00,         /*      Logical Minimum (0),            */
-	0x26, 0xFF, 0x00,   /*      Logical Maximum (255),          */
-	0x75, 0x08,         /*      Report Size (8),                */
-	0x95, 0x31,         /*      Report Count (51),              */
-	0x81, 0x02,         /*      Input (Variable),               */
+	0x06, 0x00, 0xFF,   /*      Usage Page (FF00h)              */
+	0x09, 0x21,         /*      Usage (0x21)                    */
+	0x95, 0x42,         /*      Report Count (66)               */
+	0x81, 0x02,         /*      Input (Variable)                */
 	0x09, 0x21,         /*      Usage (21h),                    */
 	0x75, 0x08,         /*      Report Size (8),                */
 	0x95, 0x4D,         /*      Report Count (77),              */
@@ -1060,9 +780,11 @@ struct motion_output_report_02 {
  * additional +2.
  */
 #define DS4_INPUT_REPORT_BUTTON_OFFSET    5
+#define DS4_INPUT_REPORT_GYRO_X_OFFSET   13
 #define DS4_INPUT_REPORT_BATTERY_OFFSET  30
 #define DS4_INPUT_REPORT_TOUCHPAD_OFFSET 33
 
+#define DS4_SENSOR_SUFFIX " Motion Sensors"
 #define DS4_TOUCHPAD_SUFFIX " Touchpad"
 
 static DEFINE_SPINLOCK(sony_dev_list_lock);
@@ -1074,6 +796,7 @@ struct sony_sc {
 	struct list_head list_node;
 	struct hid_device *hdev;
 	struct input_dev *touchpad;
+	struct input_dev *sensor_dev;
 	struct led_classdev *leds[MAX_LEDS];
 	unsigned long quirks;
 	struct work_struct state_worker;
@@ -1228,15 +951,11 @@ static u8 *sony_report_fixup(struct hid_device *hdev, u8 *rdesc,
 	}
 
 	/*
-	 * The default Dualshock 4 USB descriptor doesn't assign
-	 * the gyroscope values to corresponding axes so we need a
-	 * modified one.
+	 * The default Dualshock 4 BT descriptor doesn't describe report ID 17
+	 * which is most often used for input data. Add this mapping, so we
+	 * use the generic hid code for parsing the buttons and axes.
 	 */
-	if (sc->quirks & DUALSHOCK4_CONTROLLER_USB) {
-		hid_info(hdev, "Using modified Dualshock 4 report descriptor with gyroscope axes\n");
-		rdesc = dualshock4_usb_rdesc;
-		*rsize = sizeof(dualshock4_usb_rdesc);
-	} else if (sc->quirks & DUALSHOCK4_CONTROLLER_BT) {
+	if (sc->quirks & DUALSHOCK4_CONTROLLER_BT) {
 		hid_info(hdev, "Using modified Dualshock 4 Bluetooth report descriptor\n");
 		rdesc = dualshock4_bt_rdesc;
 		*rsize = sizeof(dualshock4_bt_rdesc);
@@ -1296,6 +1015,9 @@ static void dualshock4_parse_report(struct sony_sc *sc, u8 *rd, int size)
 	int n, m, offset, num_touch_data, max_touch_data;
 	u8 cable_state, battery_capacity, battery_charging;
 
+	/* Order of hw axes is gyro first, then accelerometer. */
+	int axes[6] = {ABS_RX, ABS_RY, ABS_RZ, ABS_X, ABS_Y, ABS_Z};
+
 	/* When using Bluetooth the header is 2 bytes longer, so skip these. */
 	int data_offset = (sc->quirks & DUALSHOCK4_CONTROLLER_USB) ? 0 : 2;
 
@@ -1303,6 +1025,14 @@ static void dualshock4_parse_report(struct sony_sc *sc, u8 *rd, int size)
 	offset = data_offset + DS4_INPUT_REPORT_BUTTON_OFFSET;
 	input_report_key(sc->touchpad, BTN_LEFT, rd[offset+2] & 0x2);
 
+	offset = data_offset + DS4_INPUT_REPORT_GYRO_X_OFFSET;
+	for (n = 0; n < 6; n++, offset += 2) {
+		short value = get_unaligned_le16(&rd[offset]);
+
+		input_report_abs(sc->sensor_dev, axes[n], value);
+	}
+	input_sync(sc->sensor_dev);
+
 	/*
 	 * The lower 4 bits of byte 30 (or 32 for BT) contain the battery level
 	 * and the 5th bit contains the USB cable state.
@@ -1581,6 +1311,76 @@ static void sony_unregister_touchpad(struct sony_sc *sc)
 	sc->touchpad = NULL;
 }
 
+static int sony_register_sensors(struct sony_sc *sc)
+{
+	size_t name_sz;
+	char *name;
+	int ret;
+
+	sc->sensor_dev = input_allocate_device();
+	if (!sc->sensor_dev)
+		return -ENOMEM;
+
+	input_set_drvdata(sc->sensor_dev, sc);
+	sc->sensor_dev->dev.parent = &sc->hdev->dev;
+	sc->sensor_dev->phys = sc->hdev->phys;
+	sc->sensor_dev->uniq = sc->hdev->uniq;
+	sc->sensor_dev->id.bustype = sc->hdev->bus;
+	sc->sensor_dev->id.vendor = sc->hdev->vendor;
+	sc->sensor_dev->id.product = sc->hdev->product;
+	sc->sensor_dev->id.version = sc->hdev->version;
+
+	/* Append a suffix to the controller name as there are various
+	 * DS4 compatible non-Sony devices with different names.
+	 */
+	name_sz = strlen(sc->hdev->name) + sizeof(DS4_SENSOR_SUFFIX);
+	name = kzalloc(name_sz, GFP_KERNEL);
+	if (!name) {
+		ret = -ENOMEM;
+		goto err;
+	}
+	snprintf(name, name_sz, "%s" DS4_SENSOR_SUFFIX, sc->hdev->name);
+	sc->sensor_dev->name = name;
+
+	input_set_abs_params(sc->sensor_dev, ABS_X, -32768, 32767, 0, 0);
+	input_set_abs_params(sc->sensor_dev, ABS_Y, -32768, 32767, 0, 0);
+	input_set_abs_params(sc->sensor_dev, ABS_Z, -32768, 32767, 0, 0);
+
+	input_set_abs_params(sc->sensor_dev, ABS_RX, -32768, 32767, 0, 0);
+	input_set_abs_params(sc->sensor_dev, ABS_RY, -32768, 32767, 0, 0);
+	input_set_abs_params(sc->sensor_dev, ABS_RZ, -32768, 32767, 0, 0);
+
+	__set_bit(INPUT_PROP_ACCELEROMETER, sc->sensor_dev->propbit);
+
+	ret = input_register_device(sc->sensor_dev);
+	if (ret < 0)
+		goto err;
+
+	return 0;
+
+err:
+	kfree(sc->sensor_dev->name);
+	sc->sensor_dev->name = NULL;
+
+	input_free_device(sc->sensor_dev);
+	sc->sensor_dev = NULL;
+
+	return ret;
+}
+
+static void sony_unregister_sensors(struct sony_sc *sc)
+{
+	if (!sc->sensor_dev)
+		return;
+
+	kfree(sc->sensor_dev->name);
+	sc->sensor_dev->name = NULL;
+
+	input_unregister_device(sc->sensor_dev);
+	sc->sensor_dev = NULL;
+}
+
+
 /*
  * Sending HID_REQ_GET_REPORT changes the operation mode of the ps3 controller
  * to "operational".  Without this, the ps3 controller will not report any
@@ -2585,6 +2385,13 @@ static int sony_input_configured(struct hid_device *hdev,
 			goto err_stop;
 		}
 
+		ret = sony_register_sensors(sc);
+		if (ret) {
+			hid_err(sc->hdev,
+			"Unable to initialize motion sensors: %d\n", ret);
+			return ret;
+		}
+
 		sony_init_output_report(sc, dualshock4_send_output_report);
 	} else if (sc->quirks & MOTION_CONTROLLER) {
 		sony_init_output_report(sc, motion_send_output_report);
@@ -2719,6 +2526,9 @@ static void sony_remove(struct hid_device *hdev)
 	if (sc->touchpad)
 		sony_unregister_touchpad(sc);
 
+	if (sc->sensor_dev)
+		sony_unregister_sensors(sc);
+
 	sony_cancel_work_sync(sc);
 
 	kfree(sc->output_report_dmabuf);
diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
index e794f7b..f561c0e 100644
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -61,9 +61,14 @@ struct input_id {
  * Note that input core does not clamp reported values to the
  * [minimum, maximum] limits, such task is left to userspace.
  *
- * Resolution for main axes (ABS_X, ABS_Y, ABS_Z) is reported in
- * units per millimeter (units/mm), resolution for rotational axes
- * (ABS_RX, ABS_RY, ABS_RZ) is reported in units per radian.
+ * The default resolution for main axes (ABS_X, ABS_Y, ABS_Z)
+ * is reported in units per millimeter (units/mm), resolution
+ * for rotational axes (ABS_RX, ABS_RY, ABS_RZ) is reported
+ * in units per radian.
+ * When INPUT_PROP_ACCELEROMETER is set the resolution changes.
+ * The main axes (ABS_X, ABS_Y, ABS_Z) are then reported in
+ * in units per g (units/g) and in units per degree per second
+ * (units/deg/s) for rotational axes (ABS_RX, ABS_RY, ABS_RZ).
  */
 struct input_absinfo {
 	__s32 value;
-- 
2.7.4


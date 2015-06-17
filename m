From: Simon Wood <simon@mungewell.org>
Subject: [PATCH 3/3] HID: hid-sony: Fix report descriptor for Navigation Controller
Date: Wed, 17 Jun 2015 00:08:53 -0600
Message-ID: <1434521333-9035-3-git-send-email-simon@mungewell.org>
References: <1434521333-9035-1-git-send-email-simon@mungewell.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1434521333-9035-1-git-send-email-simon@mungewell.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Frank Praznik <frank.praznik@oh.rr.com>, Simon Wood <simon@mungewell.org>
List-Id: linux-input@vger.kernel.org

Patch report descriptor to remove unused and ramdomly changing axis.

Original report descriptor (via BT) was as follows:
00000000  05 01 09 04 a1 01 a1 02  85 01 75 08 95 01 15 00  |..........u.....|
00000010  26 ff 00 81 03 75 01 95  13 15 00 25 01 35 00 45  |&....u.....%.5.E|
00000020  01 05 09 19 01 29 13 81  02 75 01 95 0d 06 00 ff  |.....)...u......|
00000030  81 03 15 00 26 ff 00 05  01 09 01 a1 00 75 08 95  |....&........u..|
00000040  04 35 00 46 ff 00 09 30  09 31 09 32 09 35 81 02  |.5.F...0.1.2.5..|
00000050  c0 05 01 75 08 95 27 09  01 81 02 75 08 95 30 09  |...u..'....u..0.|
00000060  01 91 02 75 08 95 30 09  01 b1 02 c0 a1 02 85 02  |...u..0.........|
00000070  75 08 95 30 09 01 b1 02  c0 a1 02 85 ee 75 08 95  |u..0.........u..|
00000080  30 09 01 b1 02 c0 a1 02  85 ef 75 08 95 30 09 01  |0.........u..0..|
00000090  b1 02 c0 c0 00                                    |.....|
00000095

Signed-off-by: Simon Wood <simon@mungewell.org>
---
 drivers/hid/hid-sony.c | 91 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 90 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index af02139..ed2f008 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -248,6 +248,88 @@ static __u8 motion_rdesc[] = {
 	0xC0                /*  End Collection                      */
 };
 
+/* PS/3 Navigation controller */
+static __u8 navigation_rdesc[] = {
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
+	0x95, 0x02,         /*              Report Count (2),       */
+	0x35, 0x00,         /*              Physical Minimum (0),   */
+	0x46, 0xFF, 0x00,   /*              Physical Maximum (255), */
+	0x09, 0x30,         /*              Usage (X),              */
+	0x09, 0x31,         /*              Usage (Y),              */
+	0x81, 0x02,         /*              Input (Variable),       */
+	0xC0,               /*          End Collection,             */
+	0x06, 0x00, 0xFF,   /*          Usage Page (FF00h),         */
+	0x95, 0x06,         /*          Report Count (6),           */
+	0x81, 0x03,         /*          Input (Constant, Variable), */
+	0x05, 0x01,         /*          Usage Page (Desktop),       */
+	0x75, 0x08,         /*          Report Size (8),            */
+	0x95, 0x05,         /*          Report Count (5),           */
+	0x09, 0x01,         /*          Usage (Pointer),            */
+	0x81, 0x02,         /*          Input (Variable),           */
+	0x06, 0x00, 0xFF,   /*          Usage Page (FF00h),         */
+	0x95, 0x20,         /*          Report Count (26),          */
+	0x81, 0x02,         /*          Input (Variable),           */
+	0x75, 0x08,         /*          Report Size (8),            */
+	0x95, 0x30,         /*          Report Count (48),          */
+	0x09, 0x01,         /*          Usage (Pointer),            */
+	0x91, 0x02,         /*          Output (Variable),          */
+	0x75, 0x08,         /*          Report Size (8),            */
+	0x95, 0x30,         /*          Report Count (48),          */
+	0x09, 0x01,         /*          Usage (Pointer),            */
+	0xB1, 0x02,         /*          Feature (Variable),         */
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
+};
 
 /*
  * The default descriptor doesn't provide mapping for the accelerometers
@@ -974,6 +1056,13 @@ static u8 *motion_fixup(struct hid_device *hdev, u8 *rdesc,
 	return motion_rdesc;
 }
 
+static u8 *navigation_fixup(struct hid_device *hdev, u8 *rdesc,
+			     unsigned int *rsize)
+{
+	*rsize = sizeof(navigation_rdesc);
+	return navigation_rdesc;
+}
+
 static __u8 *ps3remote_fixup(struct hid_device *hdev, __u8 *rdesc,
 			     unsigned int *rsize)
 {
@@ -1058,7 +1147,7 @@ static __u8 *sony_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		return motion_fixup(hdev, rdesc, rsize);
 
 	if (sc->quirks & NAVIGATION_CONTROLLER)
-		return sixaxis_fixup(hdev, rdesc, rsize);
+		return navigation_fixup(hdev, rdesc, rsize);
 
 	if (sc->quirks & PS3REMOTE)
 		return ps3remote_fixup(hdev, rdesc, rsize);
-- 
2.1.4

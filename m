From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH v2 3/6] hid: sony: Add support for the Sony Motion Controller
Date: Tue,  5 May 2015 20:47:30 -0400
Message-ID: <1430873253-11765-4-git-send-email-frank.praznik@oh.rr.com>
References: <1430873253-11765-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.230]:51661 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755780AbbEFAwM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 5 May 2015 20:52:12 -0400
In-Reply-To: <1430873253-11765-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, pavel@ucw.cz, Frank Praznik <frank.praznik@oh.rr.com>

Add a fixed-up HID descriptor for the Sony motion controller and enable
controls for the LED light as well as force-feedback.

The LED is multi-colored (red, green, blue).

The motion controller has a single rumble motor so the higher of the left
and right values is used to set the speed.

Signed-off-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
---

 v2 fixes a nasty pointer assignment omission in the output report allocator
 and removes the 'global' LED.

 drivers/hid/hid-sony.c | 138 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 136 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 4c521b2..d0b18a5 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -46,14 +46,16 @@
 #define PS3REMOTE                 BIT(4)
 #define DUALSHOCK4_CONTROLLER_USB BIT(5)
 #define DUALSHOCK4_CONTROLLER_BT  BIT(6)
+#define MOTION_CONTROLLER         BIT(7)
 
 #define SIXAXIS_CONTROLLER (SIXAXIS_CONTROLLER_USB | SIXAXIS_CONTROLLER_BT)
 #define DUALSHOCK4_CONTROLLER (DUALSHOCK4_CONTROLLER_USB |\
 				DUALSHOCK4_CONTROLLER_BT)
 #define SONY_LED_SUPPORT (SIXAXIS_CONTROLLER | BUZZ_CONTROLLER |\
-				DUALSHOCK4_CONTROLLER)
+				DUALSHOCK4_CONTROLLER | MOTION_CONTROLLER)
 #define SONY_BATTERY_SUPPORT (SIXAXIS_CONTROLLER | DUALSHOCK4_CONTROLLER)
-#define SONY_FF_SUPPORT (SIXAXIS_CONTROLLER | DUALSHOCK4_CONTROLLER)
+#define SONY_FF_SUPPORT (SIXAXIS_CONTROLLER | DUALSHOCK4_CONTROLLER |\
+				MOTION_CONTROLLER)
 
 #define MAX_LEDS 4
 
@@ -134,6 +136,85 @@ static __u8 sixaxis_rdesc[] = {
 	0xC0                /*  End Collection                      */
 };
 
+/* PS/3 Motion controller */
+static __u8 motion_rdesc[] = {
+	0x05, 0x01,         /*  Usage Page (Desktop),               */
+	0x09, 0x04,         /*  Usage (Joystick),                   */
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
+};
+
+
 /*
  * The default descriptor doesn't provide mapping for the accelerometers
  * or orientation sensors.  This fixed descriptor maps the accelerometers
@@ -798,6 +879,13 @@ union sixaxis_output_report_01 {
 	__u8 buf[36];
 };
 
+struct motion_output_report_02 {
+	u8 type, zero;
+	u8 r, g, b;
+	u8 zero2;
+	u8 rumble;
+};
+
 #define DS4_REPORT_0x02_SIZE 37
 #define DS4_REPORT_0x05_SIZE 32
 #define DS4_REPORT_0x11_SIZE 78
@@ -844,6 +932,13 @@ static __u8 *sixaxis_fixup(struct hid_device *hdev, __u8 *rdesc,
 	return sixaxis_rdesc;
 }
 
+static u8 *motion_fixup(struct hid_device *hdev, u8 *rdesc,
+			     unsigned int *rsize)
+{
+	*rsize = sizeof(motion_rdesc);
+	return motion_rdesc;
+}
+
 static __u8 *ps3remote_fixup(struct hid_device *hdev, __u8 *rdesc,
 			     unsigned int *rsize)
 {
@@ -924,6 +1019,9 @@ static __u8 *sony_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 	if (sc->quirks & SIXAXIS_CONTROLLER)
 		return sixaxis_fixup(hdev, rdesc, rsize);
 
+	if (sc->quirks & MOTION_CONTROLLER)
+		return motion_fixup(hdev, rdesc, rsize);
+
 	if (sc->quirks & PS3REMOTE)
 		return ps3remote_fixup(hdev, rdesc, rsize);
 
@@ -1454,6 +1552,12 @@ static int sony_leds_init(struct sony_sc *sc)
 		use_ds4_names = 1;
 		name_len = 0;
 		name_fmt = "%s:%s";
+	} else if (sc->quirks & MOTION_CONTROLLER) {
+		sc->led_count = 3;
+		memset(max_brightness, 255, 3);
+		use_ds4_names = 1;
+		name_len = 0;
+		name_fmt = "%s:%s";
 	} else {
 		sixaxis_set_leds_from_id(sc->device_id, initial_values);
 		sc->led_count = 4;
@@ -1622,6 +1726,28 @@ static void dualshock4_state_worker(struct work_struct *work)
 				HID_OUTPUT_REPORT, HID_REQ_SET_REPORT);
 }
 
+static void motion_state_worker(struct work_struct *work)
+{
+	struct sony_sc *sc = container_of(work, struct sony_sc, state_worker);
+	struct hid_device *hdev = sc->hdev;
+	struct motion_output_report_02 *report =
+		(struct motion_output_report_02 *)sc->output_report_dmabuf;
+
+	memset(report, 0, sizeof(struct motion_output_report_02));
+
+	report->type = 0x02; /* set leds */
+	report->r = sc->led_state[0];
+	report->g = sc->led_state[1];
+	report->b = sc->led_state[2];
+
+#ifdef CONFIG_SONY_FF
+	report->rumble = max(sc->right, sc->left);
+#endif
+
+	hid_hw_output_report(hdev, (__u8 *)report,
+			sizeof(struct motion_output_report_02));
+}
+
 static int sony_allocate_output_report(struct sony_sc *sc)
 {
 	if (sc->quirks & SIXAXIS_CONTROLLER)
@@ -1634,6 +1760,10 @@ static int sony_allocate_output_report(struct sony_sc *sc)
 	else if (sc->quirks & DUALSHOCK4_CONTROLLER_USB)
 		sc->output_report_dmabuf = kmalloc(DS4_REPORT_0x05_SIZE,
 						GFP_KERNEL);
+	else if (sc->quirks & MOTION_CONTROLLER)
+		sc->output_report_dmabuf =
+				kmalloc(sizeof(struct motion_output_report_02),
+				GFP_KERNEL);
 	else
 		return 0;
 
@@ -2043,6 +2173,8 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		}
 
 		sony_init_work(sc, dualshock4_state_worker);
+	} else if (sc->quirks & MOTION_CONTROLLER) {
+		sony_init_work(sc, motion_state_worker);
 	} else {
 		ret = 0;
 	}
@@ -2123,6 +2255,8 @@ static const struct hid_device_id sony_devices[] = {
 		.driver_data = SIXAXIS_CONTROLLER_USB },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_NAVIGATION_CONTROLLER),
 		.driver_data = SIXAXIS_CONTROLLER_USB },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_MOTION_CONTROLLER),
+		.driver_data = MOTION_CONTROLLER },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER),
 		.driver_data = SIXAXIS_CONTROLLER_BT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_VAIO_VGX_MOUSE),
-- 
2.1.0


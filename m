From: Scott Moreau <oreaus@gmail.com>
Subject: [PATCH] HID: sony: Add rumble and LED support for Nyko Core Controller
Date: Wed,  9 Dec 2015 20:26:39 -0700
Message-ID: <1449717999-11079-1-git-send-email-oreaus@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:36169 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752371AbbLJD0q (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Dec 2015 22:26:46 -0500
Received: by obcse5 with SMTP id se5so50862950obc.3
        for <linux-input@vger.kernel.org>; Wed, 09 Dec 2015 19:26:46 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, ao2@ao2.it, frank.praznik@oh.rr.com, Scott Moreau <oreaus@gmail.com>

The Nyko Core Controller, vendor:1345 product:3008, is a usb controller marketed
as a PS3 controller. It works as an HID device for input. It has a single left
rumble motor and no accelerometers, so it isn't a sixaxis. This patch adds rumble
and led support in the hid-sony driver.
---
 drivers/hid/hid-core.c |   1 +
 drivers/hid/hid-ids.h  |   3 ++
 drivers/hid/hid-sony.c | 109 ++++++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 107 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index c6f7a69..bcaf96e 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2008,6 +2008,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_VAIO_VGX_MOUSE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_VAIO_VGP_MOUSE) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SINO_LITE, USB_DEVICE_ID_SINO_LITE_CONTROLLER) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_SRWS1) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SUNPLUS, USB_DEVICE_ID_SUNPLUS_WDESKTOP) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THINGM, USB_DEVICE_ID_BLINK1) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 9024a3d..3ce4817 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -874,6 +874,9 @@
 #define USB_DEVICE_ID_SONY_BUZZ_CONTROLLER		0x0002
 #define USB_DEVICE_ID_SONY_WIRELESS_BUZZ_CONTROLLER	0x1000
 
+#define USB_VENDOR_ID_SINO_LITE			0x1345
+#define USB_DEVICE_ID_SINO_LITE_CONTROLLER	0x3008
+
 #define USB_VENDOR_ID_SOUNDGRAPH	0x15c2
 #define USB_DEVICE_ID_SOUNDGRAPH_IMON_FIRST	0x0034
 #define USB_DEVICE_ID_SOUNDGRAPH_IMON_LAST	0x0046
diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 774cd22..7caac8d 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -50,6 +50,7 @@
 #define MOTION_CONTROLLER_BT      BIT(8)
 #define NAVIGATION_CONTROLLER_USB BIT(9)
 #define NAVIGATION_CONTROLLER_BT  BIT(10)
+#define NYKO_CORE_CONTROLLER      BIT(11)
 
 #define SIXAXIS_CONTROLLER (SIXAXIS_CONTROLLER_USB | SIXAXIS_CONTROLLER_BT)
 #define MOTION_CONTROLLER (MOTION_CONTROLLER_USB | MOTION_CONTROLLER_BT)
@@ -59,11 +60,11 @@
 				DUALSHOCK4_CONTROLLER_BT)
 #define SONY_LED_SUPPORT (SIXAXIS_CONTROLLER | BUZZ_CONTROLLER |\
 				DUALSHOCK4_CONTROLLER | MOTION_CONTROLLER |\
-				NAVIGATION_CONTROLLER)
+				NAVIGATION_CONTROLLER | NYKO_CORE_CONTROLLER)
 #define SONY_BATTERY_SUPPORT (SIXAXIS_CONTROLLER | DUALSHOCK4_CONTROLLER |\
 				MOTION_CONTROLLER_BT | NAVIGATION_CONTROLLER)
 #define SONY_FF_SUPPORT (SIXAXIS_CONTROLLER | DUALSHOCK4_CONTROLLER |\
-				MOTION_CONTROLLER)
+				MOTION_CONTROLLER | NYKO_CORE_CONTROLLER)
 
 #define MAX_LEDS 4
 
@@ -1002,6 +1003,28 @@ union sixaxis_output_report_01 {
 	__u8 buf[36];
 };
 
+struct nyko_rumble {
+	u8 right_duration; /* Right motor duration (0xff means forever) */
+	u8 right_motor_on; /* Right (small) motor on/off, only supports values of 0 or 1 (off/on) */
+	u8 left_duration;    /* Left motor duration (0xff means forever) */
+	u8 left_motor_force; /* left (large) motor, supports force values from 0 to 255 */
+	u8 padding[4];
+} __packed;
+
+struct nyko_output_report {
+	u8 report_id;
+	struct nyko_rumble rumble;
+	u8 leds_bitmap; /* bitmap of enabled LEDs: LED_1 = 0x02, LED_2 = 0x04, ... */
+	struct sixaxis_led led[4];    /* LEDx at (4 - x) */
+	struct sixaxis_led _reserved; /* LED5, not actually soldered */
+	u8 padding;
+} __packed;
+
+union nyko_output_report_01 {
+	struct nyko_output_report data;
+	u8 buf[36];
+};
+
 struct motion_output_report_02 {
 	u8 type, zero;
 	u8 r, g, b;
@@ -1116,6 +1139,9 @@ static __u8 *sony_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 {
 	struct sony_sc *sc = hid_get_drvdata(hdev);
 
+	if (sc->quirks & NYKO_CORE_CONTROLLER)
+		return rdesc;
+
 	/*
 	 * Some Sony RF receivers wrongly declare the mouse pointer as a
 	 * a constant non-data variable.
@@ -1393,6 +1419,7 @@ static int sixaxis_set_operational_usb(struct hid_device *hdev)
 	const int buf_size =
 		max(SIXAXIS_REPORT_0xF2_SIZE, SIXAXIS_REPORT_0xF5_SIZE);
 	__u8 *buf;
+	struct sony_sc *sc = hid_get_drvdata(hdev);
 	int ret;
 
 	buf = kmalloc(buf_size, GFP_KERNEL);
@@ -1406,6 +1433,9 @@ static int sixaxis_set_operational_usb(struct hid_device *hdev)
 		goto out;
 	}
 
+	if (sc->quirks & NYKO_CORE_CONTROLLER)
+		goto out;
+
 	/*
 	 * Some compatible controllers like the Speedlink Strike FX and
 	 * Gasia need another query plus an USB interrupt to get operational.
@@ -1568,7 +1598,8 @@ static void sony_led_set_brightness(struct led_classdev *led,
 	 * controller to avoid having to toggle the state of an LED just to
 	 * stop the flashing later on.
 	 */
-	force_update = !!(drv_data->quirks & SIXAXIS_CONTROLLER_USB);
+	force_update = !!(drv_data->quirks &
+			(SIXAXIS_CONTROLLER_USB | NYKO_CORE_CONTROLLER));
 
 	for (n = 0; n < drv_data->led_count; n++) {
 		if (led == drv_data->leds[n] && (force_update ||
@@ -1803,6 +1834,7 @@ static void sixaxis_state_worker(struct work_struct *work)
 			0x00, 0x00, 0x00, 0x00, 0x00
 		}
 	};
+
 	struct sony_sc *sc = container_of(work, struct sony_sc, state_worker);
 	struct sixaxis_output_report *report =
 		(struct sixaxis_output_report *)sc->output_report_dmabuf;
@@ -1846,6 +1878,62 @@ static void sixaxis_state_worker(struct work_struct *work)
 			HID_OUTPUT_REPORT, HID_REQ_SET_REPORT);
 }
 
+static void nyko_state_worker(struct work_struct *work)
+{
+	static const union nyko_output_report_01 default_report = {
+		.buf = {
+			0x01,
+			0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0xff,
+			0x30, 0x27, 0x30, 0x30, 0xff,
+			0x30, 0x27, 0x30, 0x30, 0xff,
+			0x30, 0x27, 0x30, 0x30, 0xff,
+			0x30, 0x27, 0x30, 0x30, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00
+		}
+	};
+
+	struct sony_sc *sc = container_of(work, struct sony_sc, state_worker);
+	struct nyko_output_report *report =
+		(struct nyko_output_report *)sc->output_report_dmabuf;
+	int n;
+
+	/* Initialize the report with default values */
+	memcpy(report, &default_report, sizeof(struct nyko_output_report));
+
+#ifdef CONFIG_SONY_FF
+	report->rumble.left_motor_force = (sc->right / 2) + (sc->left * 2);
+	report->rumble.right_duration = 0x00;
+	report->rumble.left_duration = 0xff;
+#endif
+
+	report->leds_bitmap |= sc->led_state[0] << 1;
+	report->leds_bitmap |= sc->led_state[1] << 2;
+	report->leds_bitmap |= sc->led_state[2] << 3;
+	report->leds_bitmap |= sc->led_state[3] << 4;
+
+	/*
+	 * The LEDs in the report are indexed in reverse order to their
+	 * corresponding light on the controller.
+	 * Index 0 = LED 4, index 1 = LED 3, etc...
+	 *
+	 * In the case of both delay values being zero (blinking disabled) the
+	 * default report values should be used or the controller LED will be
+	 * always off.
+	 */
+	for (n = 0; n < 4; n++) {
+		if (sc->led_delay_on[n] || sc->led_delay_off[n]) {
+			report->led[3 - n].duty_off = sc->led_delay_off[n];
+			report->led[3 - n].duty_on = sc->led_delay_on[n];
+		}
+	}
+
+	hid_hw_raw_request(sc->hdev, report->report_id, (u8 *)report,
+			sizeof(struct nyko_output_report),
+			HID_OUTPUT_REPORT, HID_REQ_SET_REPORT);
+
+}
+
 static void dualshock4_state_worker(struct work_struct *work)
 {
 	struct sony_sc *sc = container_of(work, struct sony_sc, state_worker);
@@ -1917,7 +2005,8 @@ static void motion_state_worker(struct work_struct *work)
 static int sony_allocate_output_report(struct sony_sc *sc)
 {
 	if ((sc->quirks & SIXAXIS_CONTROLLER) ||
-			(sc->quirks & NAVIGATION_CONTROLLER))
+			(sc->quirks & NAVIGATION_CONTROLLER) ||
+			(sc->quirks & NYKO_CORE_CONTROLLER))
 		sc->output_report_dmabuf =
 			kmalloc(sizeof(union sixaxis_output_report_01),
 				GFP_KERNEL);
@@ -2170,7 +2259,8 @@ static int sony_check_add(struct sony_sc *sc)
 
 		memcpy(sc->mac_address, &buf[1], sizeof(sc->mac_address));
 	} else if ((sc->quirks & SIXAXIS_CONTROLLER_USB) ||
-			(sc->quirks & NAVIGATION_CONTROLLER_USB)) {
+			(sc->quirks & NAVIGATION_CONTROLLER_USB) ||
+			(sc->quirks & NYKO_CORE_CONTROLLER)) {
 		buf = kmalloc(SIXAXIS_REPORT_0xF2_SIZE, GFP_KERNEL);
 		if (!buf)
 			return -ENOMEM;
@@ -2218,7 +2308,8 @@ static int sony_set_device_id(struct sony_sc *sc)
 	 * All others are set to -1.
 	 */
 	if ((sc->quirks & SIXAXIS_CONTROLLER) ||
-	    (sc->quirks & DUALSHOCK4_CONTROLLER)) {
+	    (sc->quirks & DUALSHOCK4_CONTROLLER) ||
+	    (sc->quirks & NYKO_CORE_CONTROLLER)) {
 		ret = ida_simple_get(&sony_device_id_allocator, 0, 0,
 					GFP_KERNEL);
 		if (ret < 0) {
@@ -2320,6 +2411,9 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		hdev->quirks |= HID_QUIRK_SKIP_OUTPUT_REPORT_ID;
 		ret = sixaxis_set_operational_usb(hdev);
 		sony_init_work(sc, sixaxis_state_worker);
+	} else if (sc->quirks & NYKO_CORE_CONTROLLER) {
+		ret = sixaxis_set_operational_usb(hdev);
+		sony_init_work(sc, nyko_state_worker);
 	} else if ((sc->quirks & SIXAXIS_CONTROLLER_BT) ||
 			(sc->quirks & NAVIGATION_CONTROLLER_BT)) {
 		/*
@@ -2458,6 +2552,9 @@ static const struct hid_device_id sony_devices[] = {
 		.driver_data = DUALSHOCK4_CONTROLLER_USB },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER),
 		.driver_data = DUALSHOCK4_CONTROLLER_BT },
+	/* Nyko Core Controller for PS3 */
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SINO_LITE, USB_DEVICE_ID_SINO_LITE_CONTROLLER),
+		.driver_data = NYKO_CORE_CONTROLLER },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, sony_devices);
-- 
2.5.0


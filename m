From: Simon Wood <simon@mungewell.org>
Subject: [PATCH 2/3] HID: hid-sony: Navigation controller only has 1 LED and no rumble
Date: Wed, 17 Jun 2015 00:08:52 -0600
Message-ID: <1434521333-9035-2-git-send-email-simon@mungewell.org>
References: <1434521333-9035-1-git-send-email-simon@mungewell.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1434521333-9035-1-git-send-email-simon@mungewell.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Frank Praznik <frank.praznik@oh.rr.com>, Simon Wood <simon@mungewell.org>
List-Id: linux-input@vger.kernel.org

Signed-off-by: Simon Wood <simon@mungewell.org>
---
 drivers/hid/hid-sony.c | 41 +++++++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 3fba2dca..af02139 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -48,15 +48,20 @@
 #define DUALSHOCK4_CONTROLLER_BT  BIT(6)
 #define MOTION_CONTROLLER_USB     BIT(7)
 #define MOTION_CONTROLLER_BT      BIT(8)
+#define NAVIGATION_CONTROLLER_USB BIT(9)
+#define NAVIGATION_CONTROLLER_BT  BIT(10)
 
 #define SIXAXIS_CONTROLLER (SIXAXIS_CONTROLLER_USB | SIXAXIS_CONTROLLER_BT)
 #define MOTION_CONTROLLER (MOTION_CONTROLLER_USB | MOTION_CONTROLLER_BT)
+#define NAVIGATION_CONTROLLER (NAVIGATION_CONTROLLER_USB |\
+				NAVIGATION_CONTROLLER_BT)
 #define DUALSHOCK4_CONTROLLER (DUALSHOCK4_CONTROLLER_USB |\
 				DUALSHOCK4_CONTROLLER_BT)
 #define SONY_LED_SUPPORT (SIXAXIS_CONTROLLER | BUZZ_CONTROLLER |\
-				DUALSHOCK4_CONTROLLER | MOTION_CONTROLLER)
+				DUALSHOCK4_CONTROLLER | MOTION_CONTROLLER |\
+				NAVIGATION_CONTROLLER)
 #define SONY_BATTERY_SUPPORT (SIXAXIS_CONTROLLER | DUALSHOCK4_CONTROLLER |\
-				MOTION_CONTROLLER_BT)
+				MOTION_CONTROLLER_BT | NAVIGATION_CONTROLLER)
 #define SONY_FF_SUPPORT (SIXAXIS_CONTROLLER | DUALSHOCK4_CONTROLLER |\
 				MOTION_CONTROLLER)
 
@@ -1052,6 +1057,9 @@ static __u8 *sony_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 	if (sc->quirks & MOTION_CONTROLLER)
 		return motion_fixup(hdev, rdesc, rsize);
 
+	if (sc->quirks & NAVIGATION_CONTROLLER)
+		return sixaxis_fixup(hdev, rdesc, rsize);
+
 	if (sc->quirks & PS3REMOTE)
 		return ps3remote_fixup(hdev, rdesc, rsize);
 
@@ -1181,6 +1189,9 @@ static int sony_raw_event(struct hid_device *hdev, struct hid_report *report,
 		sixaxis_parse_report(sc, rd, size);
 	} else if ((sc->quirks & MOTION_CONTROLLER_BT) && rd[0] == 0x01 && size == 49) {
 		sixaxis_parse_report(sc, rd, size);
+	} else if ((sc->quirks & NAVIGATION_CONTROLLER) && rd[0] == 0x01 &&
+			size == 49) {
+		sixaxis_parse_report(sc, rd, size);
 	} else if (((sc->quirks & DUALSHOCK4_CONTROLLER_USB) && rd[0] == 0x01 &&
 			size == 64) || ((sc->quirks & DUALSHOCK4_CONTROLLER_BT)
 			&& rd[0] == 0x11 && size == 78)) {
@@ -1591,6 +1602,15 @@ static int sony_leds_init(struct sony_sc *sc)
 		use_ds4_names = 1;
 		name_len = 0;
 		name_fmt = "%s:%s";
+	} else if (sc->quirks & NAVIGATION_CONTROLLER) {
+		static const __u8 navigation_leds[4] = {0x01, 0x00, 0x00, 0x00};
+
+		memcpy(sc->led_state, navigation_leds, sizeof(navigation_leds));
+		sc->led_count = 1;
+		memset(use_hw_blink, 1, 4);
+		use_ds4_names = 0;
+		name_len = strlen("::sony#");
+		name_fmt = "%s::sony%d";
 	} else {
 		sixaxis_set_leds_from_id(sc);
 		sc->led_count = 4;
@@ -1782,7 +1802,8 @@ static void motion_state_worker(struct work_struct *work)
 
 static int sony_allocate_output_report(struct sony_sc *sc)
 {
-	if (sc->quirks & SIXAXIS_CONTROLLER)
+	if ((sc->quirks & SIXAXIS_CONTROLLER) ||
+			(sc->quirks & NAVIGATION_CONTROLLER))
 		sc->output_report_dmabuf =
 			kmalloc(sizeof(union sixaxis_output_report_01),
 				GFP_KERNEL);
@@ -2001,6 +2022,7 @@ static int sony_check_add(struct sony_sc *sc)
 
 	if ((sc->quirks & DUALSHOCK4_CONTROLLER_BT) ||
 	    (sc->quirks & MOTION_CONTROLLER_BT) ||
+	    (sc->quirks & NAVIGATION_CONTROLLER_BT) ||
 	    (sc->quirks & SIXAXIS_CONTROLLER_BT)) {
 		/*
 		 * sony_get_bt_devaddr() attempts to parse the Bluetooth MAC
@@ -2033,7 +2055,8 @@ static int sony_check_add(struct sony_sc *sc)
 		}
 
 		memcpy(sc->mac_address, &buf[1], sizeof(sc->mac_address));
-	} else if (sc->quirks & SIXAXIS_CONTROLLER_USB) {
+	} else if ((sc->quirks & SIXAXIS_CONTROLLER_USB) ||
+			(sc->quirks & NAVIGATION_CONTROLLER_USB)) {
 		buf = kmalloc(SIXAXIS_REPORT_0xF2_SIZE, GFP_KERNEL);
 		if (!buf)
 			return -ENOMEM;
@@ -2167,7 +2190,8 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		goto err_stop;
 	}
 
-	if (sc->quirks & SIXAXIS_CONTROLLER_USB) {
+	if ((sc->quirks & SIXAXIS_CONTROLLER_USB) ||
+			(sc->quirks & NAVIGATION_CONTROLLER_USB)) {
 		/*
 		 * The Sony Sixaxis does not handle HID Output Reports on the
 		 * Interrupt EP like it could, so we need to force HID Output
@@ -2182,7 +2206,8 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		hdev->quirks |= HID_QUIRK_SKIP_OUTPUT_REPORT_ID;
 		ret = sixaxis_set_operational_usb(hdev);
 		sony_init_work(sc, sixaxis_state_worker);
-	} else if (sc->quirks & SIXAXIS_CONTROLLER_BT) {
+	} else if ((sc->quirks & SIXAXIS_CONTROLLER_BT) ||
+			(sc->quirks & NAVIGATION_CONTROLLER_BT)) {
 		/*
 		 * The Sixaxis wants output reports sent on the ctrl endpoint
 		 * when connected via Bluetooth.
@@ -2286,9 +2311,9 @@ static const struct hid_device_id sony_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER),
 		.driver_data = SIXAXIS_CONTROLLER_USB },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_NAVIGATION_CONTROLLER),
-		.driver_data = SIXAXIS_CONTROLLER_USB },
+		.driver_data = NAVIGATION_CONTROLLER_USB },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_NAVIGATION_CONTROLLER),
-		.driver_data = SIXAXIS_CONTROLLER_BT },
+		.driver_data = NAVIGATION_CONTROLLER_BT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_MOTION_CONTROLLER),
 		.driver_data = MOTION_CONTROLLER_USB },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_MOTION_CONTROLLER),
-- 
2.1.4

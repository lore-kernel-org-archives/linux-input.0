From: Roderick Colenbrander <roderick@gaikai.com>
Subject: [PATCH 5/7] HID: sony: Treat the ds4 dongle as a separate device
Date: Thu,  2 Feb 2017 16:21:04 -0800
Message-ID: <20170203002106.23225-6-roderick@gaikai.com>
References: <20170203002106.23225-1-roderick@gaikai.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:32840 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751565AbdBCAVf (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 2 Feb 2017 19:21:35 -0500
Received: by mail-pf0-f172.google.com with SMTP id y143so1112463pfb.0
        for <linux-input@vger.kernel.org>; Thu, 02 Feb 2017 16:21:35 -0800 (PST)
In-Reply-To: <20170203002106.23225-1-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Simon Wood <simon@mungewell.org>, Frank Praznik <frank.praznik@gmail.com>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

This patch adds a new quirk, which allows us to differentiate
between the DualShock 4 USB and the dongle. So far they have
been treated the same, but handling of calibration data differs
as the dongle behaves like Bluetooth, for other requests it
behaves like USB.

In addition this patches changes usb/dongle/bt handling in
sony_raw_event, which makes the code cleaner to read. In addition
another patch in this series will add more dongle logic, so this
change paves the road for that.

Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
---
 drivers/hid/hid-sony.c | 99 ++++++++++++++++++++++++++------------------------
 1 file changed, 51 insertions(+), 48 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index e367db3..60f801e 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -48,19 +48,21 @@
 #define PS3REMOTE                 BIT(4)
 #define DUALSHOCK4_CONTROLLER_USB BIT(5)
 #define DUALSHOCK4_CONTROLLER_BT  BIT(6)
-#define MOTION_CONTROLLER_USB     BIT(7)
-#define MOTION_CONTROLLER_BT      BIT(8)
-#define NAVIGATION_CONTROLLER_USB BIT(9)
-#define NAVIGATION_CONTROLLER_BT  BIT(10)
-#define SINO_LITE_CONTROLLER      BIT(11)
-#define FUTUREMAX_DANCE_MAT       BIT(12)
+#define DUALSHOCK4_DONGLE         BIT(7)
+#define MOTION_CONTROLLER_USB     BIT(8)
+#define MOTION_CONTROLLER_BT      BIT(9)
+#define NAVIGATION_CONTROLLER_USB BIT(10)
+#define NAVIGATION_CONTROLLER_BT  BIT(11)
+#define SINO_LITE_CONTROLLER      BIT(12)
+#define FUTUREMAX_DANCE_MAT       BIT(13)
 
 #define SIXAXIS_CONTROLLER (SIXAXIS_CONTROLLER_USB | SIXAXIS_CONTROLLER_BT)
 #define MOTION_CONTROLLER (MOTION_CONTROLLER_USB | MOTION_CONTROLLER_BT)
 #define NAVIGATION_CONTROLLER (NAVIGATION_CONTROLLER_USB |\
 				NAVIGATION_CONTROLLER_BT)
 #define DUALSHOCK4_CONTROLLER (DUALSHOCK4_CONTROLLER_USB |\
-				DUALSHOCK4_CONTROLLER_BT)
+				DUALSHOCK4_CONTROLLER_BT | \
+				DUALSHOCK4_DONGLE)
 #define SONY_LED_SUPPORT (SIXAXIS_CONTROLLER | BUZZ_CONTROLLER |\
 				DUALSHOCK4_CONTROLLER | MOTION_CONTROLLER |\
 				NAVIGATION_CONTROLLER)
@@ -847,7 +849,7 @@ static void dualshock4_parse_report(struct sony_sc *sc, u8 *rd, int size)
 	u16 timestamp;
 
 	/* When using Bluetooth the header is 2 bytes longer, so skip these. */
-	int data_offset = (sc->quirks & DUALSHOCK4_CONTROLLER_USB) ? 0 : 2;
+	int data_offset = (sc->quirks & DUALSHOCK4_CONTROLLER_BT) ? 2 : 0;
 
 	/* Second bit of third button byte is for the touchpad button. */
 	offset = data_offset + DS4_INPUT_REPORT_BUTTON_OFFSET;
@@ -980,7 +982,7 @@ static void dualshock4_parse_report(struct sony_sc *sc, u8 *rd, int size)
 	 * Trackpad data starts 2 bytes later (e.g. 35 for USB).
 	 */
 	offset = data_offset + DS4_INPUT_REPORT_TOUCHPAD_OFFSET;
-	max_touch_data = (sc->quirks & DUALSHOCK4_CONTROLLER_USB) ? 3 : 4;
+	max_touch_data = (sc->quirks & DUALSHOCK4_CONTROLLER_BT) ? 4 : 3;
 	if (rd[offset] > 0 && rd[offset] <= max_touch_data)
 		num_touch_data = rd[offset];
 	else
@@ -1054,47 +1056,47 @@ static int sony_raw_event(struct hid_device *hdev, struct hid_report *report,
 	} else if ((sc->quirks & NAVIGATION_CONTROLLER) && rd[0] == 0x01 &&
 			size == 49) {
 		sixaxis_parse_report(sc, rd, size);
-	} else if (((sc->quirks & DUALSHOCK4_CONTROLLER_USB) && rd[0] == 0x01 &&
-			size == 64) || ((sc->quirks & DUALSHOCK4_CONTROLLER_BT)
-			&& rd[0] == 0x11 && size == 78)) {
-		if (sc->quirks & DUALSHOCK4_CONTROLLER_BT) {
-			/* CRC check */
-			u8 bthdr = 0xA1;
-			u32 crc;
-			u32 report_crc;
+	} else if ((sc->quirks & DUALSHOCK4_CONTROLLER_USB) && rd[0] == 0x01 &&
+			size == 64) {
+		dualshock4_parse_report(sc, rd, size);
+	} else if (((sc->quirks & DUALSHOCK4_CONTROLLER_BT) && rd[0] == 0x11 &&
+			size == 78)) {
+		/* CRC check */
+		u8 bthdr = 0xA1;
+		u32 crc;
+		u32 report_crc;
 
-			crc = crc32_le(0xFFFFFFFF, &bthdr, 1);
-			crc = ~crc32_le(crc, rd, DS4_INPUT_REPORT_0x11_SIZE-4);
-			report_crc = get_unaligned_le32(&rd[DS4_INPUT_REPORT_0x11_SIZE-4]);
-			if (crc != report_crc) {
-				hid_dbg(sc->hdev, "DualShock 4 input report's CRC check failed, received crc 0x%0x != 0x%0x\n",
-					report_crc, crc);
-				return -EILSEQ;
-			}
+		crc = crc32_le(0xFFFFFFFF, &bthdr, 1);
+		crc = ~crc32_le(crc, rd, DS4_INPUT_REPORT_0x11_SIZE-4);
+		report_crc = get_unaligned_le32(&rd[DS4_INPUT_REPORT_0x11_SIZE-4]);
+		if (crc != report_crc) {
+			hid_dbg(sc->hdev, "DualShock 4 input report's CRC check failed, received crc 0x%0x != 0x%0x\n",
+				report_crc, crc);
+			return -EILSEQ;
 		}
 
+		dualshock4_parse_report(sc, rd, size);
+	} else if ((sc->quirks & DUALSHOCK4_DONGLE) && rd[0] == 0x01 &&
+			size == 64) {
 		/*
 		 * In the case of a DS4 USB dongle, bit[2] of byte 31 indicates
 		 * if a DS4 is actually connected (indicated by '0').
 		 * For non-dongle, this bit is always 0 (connected).
 		 */
-		if (sc->hdev->vendor == USB_VENDOR_ID_SONY &&
-		    sc->hdev->product == USB_DEVICE_ID_SONY_PS4_CONTROLLER_DONGLE) {
-			bool connected = (rd[31] & 0x04) ? false : true;
-
-			if (!sc->ds4_dongle_connected && connected) {
-				hid_info(sc->hdev, "DualShock 4 USB dongle: controller connected\n");
-				sony_set_leds(sc);
-				sc->ds4_dongle_connected = true;
-			} else if (sc->ds4_dongle_connected && !connected) {
-				hid_info(sc->hdev, "DualShock 4 USB dongle: controller disconnected\n");
-				sc->ds4_dongle_connected = false;
-				/* Return 0, so hidraw can get the report. */
-				return 0;
-			} else if (!sc->ds4_dongle_connected) {
-				/* Return 0, so hidraw can get the report. */
-				return 0;
-			}
+		bool connected = (rd[31] & 0x04) ? false : true;
+
+		if (!sc->ds4_dongle_connected && connected) {
+			hid_info(sc->hdev, "DualShock 4 USB dongle: controller connected\n");
+			sony_set_leds(sc);
+			sc->ds4_dongle_connected = true;
+		} else if (sc->ds4_dongle_connected && !connected) {
+			hid_info(sc->hdev, "DualShock 4 USB dongle: controller disconnected\n");
+			sc->ds4_dongle_connected = false;
+			/* Return 0, so hidraw can get the report. */
+			return 0;
+		} else if (!sc->ds4_dongle_connected) {
+			/* Return 0, so hidraw can get the report. */
+			return 0;
 		}
 
 		dualshock4_parse_report(sc, rd, size);
@@ -1387,7 +1389,7 @@ static int dualshock4_get_calibration_data(struct sony_sc *sc)
 	 * Note: in Bluetooth mode feature report 0x02 also changes the state
 	 * of the controller, so that it sends input reports of type 0x11.
 	 */
-	if (sc->quirks & DUALSHOCK4_CONTROLLER_USB) {
+	if (sc->quirks & (DUALSHOCK4_CONTROLLER_USB | DUALSHOCK4_DONGLE)) {
 		buf = kmalloc(DS4_FEATURE_REPORT_0x02_SIZE, GFP_KERNEL);
 		if (!buf)
 			return -ENOMEM;
@@ -1447,6 +1449,7 @@ static int dualshock4_get_calibration_data(struct sony_sc *sc)
 		gyro_roll_plus   = get_unaligned_le16(&buf[15]);
 		gyro_roll_minus  = get_unaligned_le16(&buf[17]);
 	} else {
+		/* BT + Dongle */
 		gyro_pitch_plus  = get_unaligned_le16(&buf[7]);
 		gyro_yaw_plus    = get_unaligned_le16(&buf[9]);
 		gyro_roll_plus   = get_unaligned_le16(&buf[11]);
@@ -1904,7 +1907,7 @@ static void dualshock4_send_output_report(struct sony_sc *sc)
 	 * 0xB0 - 20hz
 	 * 0xD0 - 66hz
 	 */
-	if (sc->quirks & DUALSHOCK4_CONTROLLER_USB) {
+	if (sc->quirks & (DUALSHOCK4_CONTROLLER_USB | DUALSHOCK4_DONGLE)) {
 		memset(buf, 0, DS4_OUTPUT_REPORT_0x05_SIZE);
 		buf[0] = 0x05;
 		buf[1] = 0xFF;
@@ -1937,7 +1940,7 @@ static void dualshock4_send_output_report(struct sony_sc *sc)
 	buf[offset++] = sc->led_delay_on[3];
 	buf[offset++] = sc->led_delay_off[3];
 
-	if (sc->quirks & DUALSHOCK4_CONTROLLER_USB)
+	if (sc->quirks & (DUALSHOCK4_CONTROLLER_USB | DUALSHOCK4_DONGLE))
 		hid_hw_output_report(hdev, buf, DS4_OUTPUT_REPORT_0x05_SIZE);
 	else {
 		/* CRC generation */
@@ -1994,7 +1997,7 @@ static int sony_allocate_output_report(struct sony_sc *sc)
 	else if (sc->quirks & DUALSHOCK4_CONTROLLER_BT)
 		sc->output_report_dmabuf = kmalloc(DS4_OUTPUT_REPORT_0x11_SIZE,
 						GFP_KERNEL);
-	else if (sc->quirks & DUALSHOCK4_CONTROLLER_USB)
+	else if (sc->quirks & (DUALSHOCK4_CONTROLLER_USB | DUALSHOCK4_DONGLE))
 		sc->output_report_dmabuf = kmalloc(DS4_OUTPUT_REPORT_0x05_SIZE,
 						GFP_KERNEL);
 	else if (sc->quirks & MOTION_CONTROLLER)
@@ -2239,7 +2242,7 @@ static int sony_check_add(struct sony_sc *sc)
 			hid_warn(sc->hdev, "UNIQ does not contain a MAC address; duplicate check skipped\n");
 			return 0;
 		}
-	} else if (sc->quirks & DUALSHOCK4_CONTROLLER_USB) {
+	} else if (sc->quirks & (DUALSHOCK4_CONTROLLER_USB | DUALSHOCK4_DONGLE)) {
 		buf = kmalloc(DS4_FEATURE_REPORT_0x81_SIZE, GFP_KERNEL);
 		if (!buf)
 			return -ENOMEM;
@@ -2676,7 +2679,7 @@ static const struct hid_device_id sony_devices[] = {
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER_2),
 		.driver_data = DUALSHOCK4_CONTROLLER_BT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER_DONGLE),
-		.driver_data = DUALSHOCK4_CONTROLLER_USB },
+		.driver_data = DUALSHOCK4_DONGLE },
 	/* Nyko Core Controller for PS3 */
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SINO_LITE, USB_DEVICE_ID_SINO_LITE_CONTROLLER),
 		.driver_data = SIXAXIS_CONTROLLER_USB | SINO_LITE_CONTROLLER },
-- 
2.9.3


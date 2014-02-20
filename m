From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH v2 1/5] HID: sony: Fix multi-line comment styling
Date: Thu, 20 Feb 2014 11:36:00 -0500
Message-ID: <1392914164-31899-2-git-send-email-frank.praznik@oh.rr.com>
References: <1392914164-31899-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:53948 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755377AbaBTQgM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Feb 2014 11:36:12 -0500
In-Reply-To: <1392914164-31899-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dh.herrmann@gmail.com, jkosina@suse.cz, Frank Praznik <frank.praznik@oh.rr.com>

Convert multi-line comments to comply with the kernel coding style.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
---
 drivers/hid/hid-sony.c | 45 ++++++++++++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 526705f..26992e1 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -17,7 +17,8 @@
  * any later version.
  */
 
-/* NOTE: in order for the Sony PS3 BD Remote Control to be found by
+/*
+ * NOTE: in order for the Sony PS3 BD Remote Control to be found by
  * a Bluetooth host, the key combination Start+Enter has to be kept pressed
  * for about 7 seconds with the Bluetooth Host Controller in discovering mode.
  *
@@ -81,7 +82,8 @@ static const u8 sixaxis_rdesc_fixup2[] = {
 	0xb1, 0x02, 0xc0, 0xc0,
 };
 
-/* The default descriptor doesn't provide mapping for the accelerometers
+/*
+ * The default descriptor doesn't provide mapping for the accelerometers
  * or orientation sensors.  This fixed descriptor maps the accelerometers
  * to usage values 0x40, 0x41 and 0x42 and maps the orientation sensors
  * to usage values 0x43, 0x44 and 0x45.
@@ -340,7 +342,8 @@ static u8 dualshock4_usb_rdesc[] = {
 	0xC0                /*  End Collection                      */
 };
 
-/* The default behavior of the Dualshock 4 is to send reports using report
+/*
+ * The default behavior of the Dualshock 4 is to send reports using report
  * type 1 when running over Bluetooth. However, as soon as it receives a
  * report of type 17 to set the LEDs or rumble it starts returning it's state
  * in report 17 instead of 1.  Since report 17 is undefined in the default HID
@@ -667,7 +670,8 @@ static const unsigned int ps3remote_keymap_remote_buttons[] = {
 };
 
 static const unsigned int buzz_keymap[] = {
-	/* The controller has 4 remote buzzers, each with one LED and 5
+	/*
+	 * The controller has 4 remote buzzers, each with one LED and 5
 	 * buttons.
 	 * 
 	 * We use the mapping chosen by the controller, which is:
@@ -838,7 +842,8 @@ static void sixaxis_parse_report(struct sony_sc *sc, __u8 *rd, int size)
 	unsigned long flags;
 	__u8 cable_state, battery_capacity, battery_charging;
 
-	/* The sixaxis is charging if the battery value is 0xee
+	/*
+	 * The sixaxis is charging if the battery value is 0xee
 	 * and it is fully charged if the value is 0xef.
 	 * It does not report the actual level while charging so it
 	 * is set to 100% while charging is in progress.
@@ -868,18 +873,21 @@ static void dualshock4_parse_report(struct sony_sc *sc, __u8 *rd, int size)
 	int n, offset;
 	__u8 cable_state, battery_capacity, battery_charging;
 
-	/* Battery and touchpad data starts at byte 30 in the USB report and
+	/*
+	 * Battery and touchpad data starts at byte 30 in the USB report and
 	 * 32 in Bluetooth report.
 	 */
 	offset = (sc->quirks & DUALSHOCK4_CONTROLLER_USB) ? 30 : 32;
 
-	/* The lower 4 bits of byte 30 contain the battery level
+	/*
+	 * The lower 4 bits of byte 30 contain the battery level
 	 * and the 5th bit contains the USB cable state.
 	 */
 	cable_state = (rd[offset] >> 4) & 0x01;
 	battery_capacity = rd[offset] & 0x0F;
 
-	/* When a USB power source is connected the battery level ranges from
+	/*
+	 * When a USB power source is connected the battery level ranges from
 	 * 0 to 10, and when running on battery power it ranges from 0 to 9.
 	 * A battery level above 10 when plugged in means charge completed.
 	 */
@@ -903,7 +911,8 @@ static void dualshock4_parse_report(struct sony_sc *sc, __u8 *rd, int size)
 
 	offset += 5;
 
-	/* The Dualshock 4 multi-touch trackpad data starts at offset 35 on USB
+	/*
+	 * The Dualshock 4 multi-touch trackpad data starts at offset 35 on USB
 	 * and 37 on Bluetooth.
 	 * The first 7 bits of the first byte is a counter and bit 8 is a touch
 	 * indicator that is 0 when pressed and 1 when not pressed.
@@ -932,7 +941,8 @@ static int sony_raw_event(struct hid_device *hdev, struct hid_report *report,
 {
 	struct sony_sc *sc = hid_get_drvdata(hdev);
 
-	/* Sixaxis HID report has acclerometers/gyro with MSByte first, this
+	/*
+	 * Sixaxis HID report has acclerometers/gyro with MSByte first, this
 	 * has to be BYTE_SWAPPED before passing up to joystick interface
 	 */
 	if ((sc->quirks & SIXAXIS_CONTROLLER) && rd[0] == 0x01 && size == 49) {
@@ -1057,7 +1067,8 @@ static int sixaxis_set_operational_bt(struct hid_device *hdev)
 				     HID_FEATURE_REPORT);
 }
 
-/* Requesting feature report 0x02 in Bluetooth mode changes the state of the
+/*
+ * Requesting feature report 0x02 in Bluetooth mode changes the state of the
  * controller so that it sends full input reports of type 0x11.
  */
 static int dualshock4_set_operational_bt(struct hid_device *hdev)
@@ -1211,9 +1222,11 @@ static int sony_leds_init(struct hid_device *hdev)
 		name_fmt = "%s::sony%d";
 	}
 
-	/* Clear LEDs as we have no way of reading their initial state. This is
+	/*
+	 * Clear LEDs as we have no way of reading their initial state. This is
 	 * only relevant if the driver is loaded after somebody actively set the
-	 * LEDs to on */
+	 * LEDs to on
+	 */
 	sony_set_leds(hdev, initial_values, drv_data->led_count);
 
 	name_sz = strlen(dev_name(&hdev->dev)) + name_len + 1;
@@ -1420,7 +1433,8 @@ static int sony_battery_probe(struct sony_sc *sc)
 	struct hid_device *hdev = sc->hdev;
 	int ret;
 
-	/* Set the default battery level to 100% to avoid low battery warnings
+	/*
+	 * Set the default battery level to 100% to avoid low battery warnings
 	 * if the battery is polled before the first device report is received.
 	 */
 	sc->battery_capacity = 100;
@@ -1533,7 +1547,8 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 				goto err_stop;
 			}
 		}
-		/* The Dualshock 4 touchpad supports 2 touches and has a
+		/*
+		 * The Dualshock 4 touchpad supports 2 touches and has a
 		 * resolution of 1920x940.
 		 */
 		ret = sony_register_touchpad(sc, 2, 1920, 940);
-- 
1.8.5.3


From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH 1/4] HID: sony: Use separate identifiers for USB and Bluetooth
 connected Dualshock 4 controllers.
Date: Thu, 16 Jan 2014 21:42:31 -0500 (EST)
Message-ID: <alpine.DEB.2.10.1401162131290.15779@franz-virtual-machine>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:35477 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667AbaAQCmd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Jan 2014 21:42:33 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>

Use separate identifiers for Dualshock 4 controllers connected via USB and 
Bluetooth.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>

---

 Apply against jikos/hid.git/for-3.14/sony
 
 drivers/hid/hid-sony.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 1dfed23..2f992e1 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -38,9 +38,10 @@
 #define SIXAXIS_CONTROLLER_BT   BIT(2)
 #define BUZZ_CONTROLLER         BIT(3)
 #define PS3REMOTE		BIT(4)
-#define DUALSHOCK4_CONTROLLER   BIT(5)
+#define DUALSHOCK4_CONTROLLER_USB BIT(5)
+#define DUALSHOCK4_CONTROLLER_BT  BIT(6)
 
-#define SONY_LED_SUPPORT (SIXAXIS_CONTROLLER_USB | BUZZ_CONTROLLER | DUALSHOCK4_CONTROLLER)
+#define SONY_LED_SUPPORT (SIXAXIS_CONTROLLER_USB | BUZZ_CONTROLLER | DUALSHOCK4_CONTROLLER_USB)
 
 #define MAX_LEDS 4
 
@@ -478,7 +479,7 @@ static void sony_set_leds(struct hid_device *hdev, const __u8 *leds, int count)
 	if (drv_data->quirks & BUZZ_CONTROLLER && count == 4) {
 		buzz_set_leds(hdev, leds);
 	} else if ((drv_data->quirks & SIXAXIS_CONTROLLER_USB) ||
-		   (drv_data->quirks & DUALSHOCK4_CONTROLLER)) {
+		   (drv_data->quirks & DUALSHOCK4_CONTROLLER_USB)) {
 		for (n = 0; n < count; n++)
 			drv_data->led_state[n] = leds[n];
 		schedule_work(&drv_data->state_worker);
@@ -583,7 +584,7 @@ static int sony_leds_init(struct hid_device *hdev)
 		name_fmt = "%s::sony%d";
 	}
 
-	if (drv_data->quirks & DUALSHOCK4_CONTROLLER) {
+	if (drv_data->quirks & DUALSHOCK4_CONTROLLER_USB) {
 		drv_data->led_count = 3;
 		max_brightness = 255;
 	} else {
@@ -775,7 +776,7 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	}
 	else if (sc->quirks & SIXAXIS_CONTROLLER_BT)
 		ret = sixaxis_set_operational_bt(hdev);
-	else if (sc->quirks & DUALSHOCK4_CONTROLLER) {
+	else if (sc->quirks & DUALSHOCK4_CONTROLLER_USB) {
 		ret = 0;
 		INIT_WORK(&sc->state_worker, dualshock4_state_worker);
 	} else {
@@ -840,9 +841,9 @@ static const struct hid_device_id sony_devices[] = {
 		.driver_data = PS3REMOTE },
 	/* Sony Dualshock 4 controllers for PS4 */
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER),
-		.driver_data = DUALSHOCK4_CONTROLLER },
+		.driver_data = DUALSHOCK4_CONTROLLER_USB },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER),
-		.driver_data = DUALSHOCK4_CONTROLLER },
+		.driver_data = DUALSHOCK4_CONTROLLER_BT },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, sony_devices);
-- 
1.8.3.2


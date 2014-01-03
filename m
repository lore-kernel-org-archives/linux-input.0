From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH 1/2] HID: sony: Add force feedback for the Dualshock 4
Date: Fri, 3 Jan 2014 16:03:10 -0500 (EST)
Message-ID: <alpine.DEB.2.10.1401031518010.29517@franz-virtual-machine>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:48288 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752756AbaACVDX (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 Jan 2014 16:03:23 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

This patch adds force feedback support for Sony's Dualshock 4 controller.  
It does this by adding a device ID for the new controller and creating a 
new dualshock4_worker function to send data commands formatted for the 
controller.  Unlike the Sixaxis, the Dualshock 4 requires a magnitude 
value for the small motor so the actual value is now sent to the worker 
function and the sixaxis worker was modified to clamp it to 1 or 0 as required.

This patch is built against the for-3.14/sony branch in jikos/hid.git and 
is compatible with the recent fixes.

Signed-off-by Frank Praznik <frank.praznik@oh.rr.com>

---
 drivers/hid/hid-ids.h  |  1 +
 drivers/hid/hid-sony.c | 41 +++++++++++++++++++++++++++++++++++++----
 2 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 60336f06..ebbd292 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -769,6 +769,7 @@
 #define USB_DEVICE_ID_SONY_NAVIGATION_CONTROLLER	0x042f
 #define USB_DEVICE_ID_SONY_BUZZ_CONTROLLER		0x0002
 #define USB_DEVICE_ID_SONY_WIRELESS_BUZZ_CONTROLLER	0x1000
+#define USB_DEVICE_ID_SONY_PS4_CONTROLLER	0x05c4
 
 #define USB_VENDOR_ID_SOUNDGRAPH	0x15c2
 #define USB_DEVICE_ID_SOUNDGRAPH_IMON_FIRST	0x0034
diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index f57ab5e..f42c866 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -38,6 +38,7 @@
 #define SIXAXIS_CONTROLLER_BT   BIT(2)
 #define BUZZ_CONTROLLER         BIT(3)
 #define PS3REMOTE		BIT(4)
+#define DUALSHOCK4_CONTROLLER	BIT(5)
 
 #define SONY_LED_SUPPORT (SIXAXIS_CONTROLLER_USB | BUZZ_CONTROLLER)
 
@@ -615,7 +616,7 @@ error_leds:
 	return ret;
 }
 
-static void sony_state_worker(struct work_struct *work)
+static void sixaxis_state_worker(struct work_struct *work)
 {
 	struct sony_sc *sc = container_of(work, struct sony_sc, state_worker);
 	unsigned char buf[] = {
@@ -630,7 +631,7 @@ static void sony_state_worker(struct work_struct *work)
 	};
 
 #ifdef CONFIG_SONY_FF
-	buf[3] = sc->right;
+	buf[3] = sc->right ? 1 : 0;
 	buf[5] = sc->left;
 #endif
 
@@ -640,6 +641,29 @@ static void sony_state_worker(struct work_struct *work)
 					HID_OUTPUT_REPORT);
 }
 
+static void dualshock4_state_worker(struct work_struct *work)
+{
+	struct sony_sc *sc = container_of(work, struct sony_sc, state_worker);
+	unsigned char buf[] = {
+		0x05,
+		0x03, 0x00, 0x00, 0x00, 0x00,
+		0x00, 0x00, 0x00, 0x00, 0x00,
+		0x00, 0x00, 0x00, 0x00, 0x00,
+		0x00, 0x00, 0x00, 0x00, 0x00,
+		0x00, 0x00, 0x00, 0x00, 0x00,
+		0x00, 0x00, 0x00, 0x00, 0x00,
+		0x00,
+	};
+
+#ifdef CONFIG_SONY_FF
+	buf[4] = sc->right;
+	buf[5] = sc->left;
+#endif
+
+	sc->hdev->hid_output_raw_report(sc->hdev, buf, sizeof(buf),
+					HID_OUTPUT_REPORT);
+}
+
 #ifdef CONFIG_SONY_FF
 static int sony_play_effect(struct input_dev *dev, void *data,
 			    struct ff_effect *effect)
@@ -651,7 +675,7 @@ static int sony_play_effect(struct input_dev *dev, void *data,
 		return 0;
 
 	sc->left = effect->u.rumble.strong_magnitude / 256;
-	sc->right = effect->u.rumble.weak_magnitude ? 1 : 0;
+	sc->right = effect->u.rumble.weak_magnitude / 256;
 
 	schedule_work(&sc->state_worker);
 	return 0;
@@ -724,10 +748,14 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (sc->quirks & SIXAXIS_CONTROLLER_USB) {
 		hdev->hid_output_raw_report = sixaxis_usb_output_raw_report;
 		ret = sixaxis_set_operational_usb(hdev);
-		INIT_WORK(&sc->state_worker, sony_state_worker);
+		INIT_WORK(&sc->state_worker, sixaxis_state_worker);
 	}
 	else if (sc->quirks & SIXAXIS_CONTROLLER_BT)
 		ret = sixaxis_set_operational_bt(hdev);
+	else if (sc->quirks & DUALSHOCK4_CONTROLLER) {
+		ret = 0;
+		INIT_WORK(&sc->state_worker, dualshock4_state_worker);
+	}
 	else
 		ret = 0;
 
@@ -787,6 +815,11 @@ static const struct hid_device_id sony_devices[] = {
 	/* Logitech Harmony Adapter for PS3 */
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_HARMONY_PS3),
 		.driver_data = PS3REMOTE },
+	/* Sony Dualshock 4 controllers for PS4 */
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER),
+		.driver_data = DUALSHOCK4_CONTROLLER },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER),
+		.driver_data = DUALSHOCK4_CONTROLLER },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, sony_devices);
-- 
1.8.3.2


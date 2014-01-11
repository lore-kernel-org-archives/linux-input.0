From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH v2 1/3] HID: sony: Add force-feedback support for the Dualshock
 4
Date: Sat, 11 Jan 2014 15:12:42 -0500 (EST)
Message-ID: <alpine.DEB.2.10.1401111429090.2563@franz-virtual-machine>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:47436 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751986AbaAKUMq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 11 Jan 2014 15:12:46 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>

Adds the Dualshock 4 to the HID device list and enables force-feedback.

Adds a Dualshock 4 specific worker function since the Dualshock 4 needs a 
different report than the Sixaxis.

The right motor in the Dualshock 4 is variable so the full rumble value 
is now passed to the worker function and clamped there if necessary.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>

---

 Apply against jikos/hid.git/for-3.14/sony

 drivers/hid/hid-core.c |  2 ++
 drivers/hid/hid-ids.h  |  1 +
 drivers/hid/hid-sony.c | 39 ++++++++++++++++++++++++++++++++++++---
 3 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 957d35b..70cc468 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1831,6 +1831,8 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_NAVIGATION_CONTROLLER) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_VAIO_VGX_MOUSE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_VAIO_VGP_MOUSE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_SRWS1) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 60336f06..ce24459 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -766,6 +766,7 @@
 #define USB_DEVICE_ID_SONY_VAIO_VGP_MOUSE	0x0374
 #define USB_DEVICE_ID_SONY_PS3_BDREMOTE		0x0306
 #define USB_DEVICE_ID_SONY_PS3_CONTROLLER	0x0268
+#define USB_DEVICE_ID_SONY_PS4_CONTROLLER	0x05c4
 #define USB_DEVICE_ID_SONY_NAVIGATION_CONTROLLER	0x042f
 #define USB_DEVICE_ID_SONY_BUZZ_CONTROLLER		0x0002
 #define USB_DEVICE_ID_SONY_WIRELESS_BUZZ_CONTROLLER	0x1000
diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index f57ab5e..8020d10 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -38,6 +38,7 @@
 #define SIXAXIS_CONTROLLER_BT   BIT(2)
 #define BUZZ_CONTROLLER         BIT(3)
 #define PS3REMOTE		BIT(4)
+#define DUALSHOCK4_CONTROLLER   BIT(5)
 
 #define SONY_LED_SUPPORT (SIXAXIS_CONTROLLER_USB | BUZZ_CONTROLLER)
 
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
@@ -728,8 +752,12 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	}
 	else if (sc->quirks & SIXAXIS_CONTROLLER_BT)
 		ret = sixaxis_set_operational_bt(hdev);
-	else
+	else if (sc->quirks & DUALSHOCK4_CONTROLLER) {
 		ret = 0;
+		INIT_WORK(&sc->state_worker, dualshock4_state_worker);
+	} else {
+		ret = 0;
+	}
 
 	if (ret < 0)
 		goto err_stop;
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


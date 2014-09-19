From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH v2] hid: sony: Set touchpad bits in the input_configured callback
Date: Thu, 18 Sep 2014 21:15:01 -0400
Message-ID: <1411089301-1546-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.229]:51871 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751235AbaISBPV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Sep 2014 21:15:21 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, Frank Praznik <frank.praznik@oh.rr.com>

Set the DualShock4 touchpad bits in the input_configured callback
so that they are registered properly for any input devices created
during hid_hw_start.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>

---

 v2: Remove an unnecessary if (ret < 0) goto err_stop; check.

 This fixes the issue with touch axes being incorrectly mapped to axis 0 in
 the corresponding joydev device.

 drivers/hid/hid-sony.c | 74 +++++++++++++++++++++++++++-----------------------
 1 file changed, 40 insertions(+), 34 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 96a8ec5..5baa311 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1084,6 +1084,38 @@ static int sony_mapping(struct hid_device *hdev, struct hid_input *hi,
 	return 0;
 }
 
+static int sony_register_touchpad(struct hid_input *hi, int touch_count,
+					int w, int h)
+{
+	struct input_dev *input_dev = hi->input;
+	int ret;
+
+	ret = input_mt_init_slots(input_dev, touch_count, 0);
+	if (ret < 0)
+		return ret;
+
+	input_set_abs_params(input_dev, ABS_MT_POSITION_X, 0, w, 0, 0);
+	input_set_abs_params(input_dev, ABS_MT_POSITION_Y, 0, h, 0, 0);
+
+	return 0;
+}
+
+static void sony_input_configured(struct hid_device *hdev,
+					struct hid_input *hidinput)
+{
+	struct sony_sc *sc = hid_get_drvdata(hdev);
+
+	/*
+	 * The Dualshock 4 touchpad supports 2 touches and has a
+	 * resolution of 1920x940.
+	 */
+	if (sc->quirks & DUALSHOCK4_CONTROLLER) {
+		if (sony_register_touchpad(hidinput, 2, 1920, 940) != 0)
+			hid_err(sc->hdev,
+				"Unable to initialize multi-touch slots\n");
+	}
+}
+
 /*
  * Sending HID_REQ_GET_REPORT changes the operation mode of the ps3 controller
  * to "operational".  Without this, the ps3 controller will not report any
@@ -1656,26 +1688,6 @@ static void sony_battery_remove(struct sony_sc *sc)
 	sc->battery.name = NULL;
 }
 
-static int sony_register_touchpad(struct sony_sc *sc, int touch_count,
-					int w, int h)
-{
-	struct hid_input *hidinput = list_entry(sc->hdev->inputs.next,
-						struct hid_input, list);
-	struct input_dev *input_dev = hidinput->input;
-	int ret;
-
-	ret = input_mt_init_slots(input_dev, touch_count, 0);
-	if (ret < 0) {
-		hid_err(sc->hdev, "Unable to initialize multi-touch slots\n");
-		return ret;
-	}
-
-	input_set_abs_params(input_dev, ABS_MT_POSITION_X, 0, w, 0, 0);
-	input_set_abs_params(input_dev, ABS_MT_POSITION_Y, 0, h, 0, 0);
-
-	return 0;
-}
-
 /*
  * If a controller is plugged in via USB while already connected via Bluetooth
  * it will show up as two devices. A global list of connected controllers and
@@ -1925,13 +1937,6 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 				goto err_stop;
 			}
 		}
-		/*
-		 * The Dualshock 4 touchpad supports 2 touches and has a
-		 * resolution of 1920x940.
-		 */
-		ret = sony_register_touchpad(sc, 2, 1920, 940);
-		if (ret < 0)
-			goto err_stop;
 
 		sony_init_work(sc, dualshock4_state_worker);
 	} else {
@@ -2039,13 +2044,14 @@ static const struct hid_device_id sony_devices[] = {
 MODULE_DEVICE_TABLE(hid, sony_devices);
 
 static struct hid_driver sony_driver = {
-	.name          = "sony",
-	.id_table      = sony_devices,
-	.input_mapping = sony_mapping,
-	.probe         = sony_probe,
-	.remove        = sony_remove,
-	.report_fixup  = sony_report_fixup,
-	.raw_event     = sony_raw_event
+	.name             = "sony",
+	.id_table         = sony_devices,
+	.input_mapping    = sony_mapping,
+	.input_configured = sony_input_configured,
+	.probe            = sony_probe,
+	.remove           = sony_remove,
+	.report_fixup     = sony_report_fixup,
+	.raw_event        = sony_raw_event
 };
 
 static int __init sony_init(void)
-- 
2.1.0


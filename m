From: Roderick Colenbrander <roderick@gaikai.com>
Subject: [PATCH 2/3] HID: sony: Set INPUT_PROP_COMPOSITE flag on sub devices.
Date: Thu, 17 Aug 2017 19:01:55 -0700
Message-ID: <20170818020156.23390-3-roderick@gaikai.com>
References: <20170818020156.23390-1-roderick@gaikai.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f182.google.com ([209.85.216.182]:34400 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753857AbdHRCCL (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 17 Aug 2017 22:02:11 -0400
Received: by mail-qt0-f182.google.com with SMTP id s6so47315212qtc.1
        for <linux-input@vger.kernel.org>; Thu, 17 Aug 2017 19:02:11 -0700 (PDT)
In-Reply-To: <20170818020156.23390-1-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Roderick Colenbrander <roderick.colenbrander@sony.com>

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

Configure the touchpad and motion sensor sub devices with the
INPUT_PROP_COMPOSITE flag. This flag will be consumed by joydev
to filter out the motion sensor device.

Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
---
 drivers/hid/hid-sony.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index d03203a..a161093 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1276,6 +1276,7 @@ static int sony_register_touchpad(struct sony_sc *sc, int touch_count,
 	__set_bit(EV_KEY, sc->touchpad->evbit);
 	__set_bit(BTN_LEFT, sc->touchpad->keybit);
 	__set_bit(INPUT_PROP_BUTTONPAD, sc->touchpad->propbit);
+	__set_bit(INPUT_PROP_COMPOSITE, sc->touchpad->propbit);
 
 	input_set_abs_params(sc->touchpad, ABS_MT_POSITION_X, 0, w, 0, 0);
 	input_set_abs_params(sc->touchpad, ABS_MT_POSITION_Y, 0, h, 0, 0);
@@ -1375,6 +1376,7 @@ static int sony_register_sensors(struct sony_sc *sc)
 	}
 
 	__set_bit(INPUT_PROP_ACCELEROMETER, sc->sensor_dev->propbit);
+	__set_bit(INPUT_PROP_COMPOSITE, sc->sensor_dev->propbit);
 
 	ret = input_register_device(sc->sensor_dev);
 	if (ret < 0)
@@ -2561,6 +2563,8 @@ static int sony_input_configured(struct hid_device *hdev,
 
 		sony_init_output_report(sc, sixaxis_send_output_report);
 	} else if (sc->quirks & SIXAXIS_CONTROLLER_USB) {
+		__set_bit(INPUT_PROP_COMPOSITE, hidinput->input->propbit);
+
 		/*
 		 * The Sony Sixaxis does not handle HID Output Reports on the
 		 * Interrupt EP and the device only becomes active when the
@@ -2586,6 +2590,8 @@ static int sony_input_configured(struct hid_device *hdev,
 
 		sony_init_output_report(sc, sixaxis_send_output_report);
 	} else if (sc->quirks & SIXAXIS_CONTROLLER_BT) {
+		__set_bit(INPUT_PROP_COMPOSITE, hidinput->input->propbit);
+
 		/*
 		 * The Sixaxis wants output reports sent on the ctrl endpoint
 		 * when connected via Bluetooth.
@@ -2607,6 +2613,8 @@ static int sony_input_configured(struct hid_device *hdev,
 
 		sony_init_output_report(sc, sixaxis_send_output_report);
 	} else if (sc->quirks & DUALSHOCK4_CONTROLLER) {
+		__set_bit(INPUT_PROP_COMPOSITE, hidinput->input->propbit);
+
 		ret = dualshock4_get_calibration_data(sc);
 		if (ret < 0) {
 			hid_err(hdev, "Failed to get calibration data from Dualshock 4\n");
-- 
2.9.4


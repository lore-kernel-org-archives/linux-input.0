From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH 2/2] HID: sony: Add output events for the multi-touch pad on the Dualshock 4.
Date: Fri, 24 Jan 2014 22:27:01 -0500
Message-ID: <1390620421-11365-2-git-send-email-frank.praznik@oh.rr.com>
References: <1390620421-11365-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:34227 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448AbaAYD1c (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Jan 2014 22:27:32 -0500
In-Reply-To: <1390620421-11365-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, Frank Praznik <frank.praznik@oh.rr.com>

Add output events for the multi-touch pad on the Dualshock 4.

The touchpad has a resolution of 1920x940 and is capable of 2 simultaneous
touches. A 'Type B' stateful slot protocol is implemented as defined in
Documentation/input/multi-touch-protocol.txt

Applications can use the touchpad data by processing the ABS_MT_SLOT,
ABS_MT_TRACKING_ID, ABS_MT_POSITION_X and ABS_MT_POSITION_Y events.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
---
 drivers/hid/hid-sony.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 04fd611..2bd3f13 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -32,6 +32,7 @@
 #include <linux/leds.h>
 #include <linux/power_supply.h>
 #include <linux/spinlock.h>
+#include <linux/input/mt.h>
 
 #include "hid-ids.h"
 
@@ -643,7 +644,11 @@ static void sixaxis_parse_report(struct sony_sc *sc, __u8 *rd, int size)
 
 static void dualshock4_parse_report(struct sony_sc *sc, __u8 *rd, int size)
 {
+	struct hid_input *hidinput = list_entry(sc->hdev->inputs.next,
+						struct hid_input, list);
+	struct input_dev *input_dev = hidinput->input;
 	unsigned long flags;
+	int n, offset = 35;
 	__u8 cable_state, battery_capacity, battery_charging;
 
 	/* The lower 4 bits of byte 30 contain the battery level
@@ -669,6 +674,28 @@ static void dualshock4_parse_report(struct sony_sc *sc, __u8 *rd, int size)
 	sc->battery_capacity = battery_capacity;
 	sc->battery_charging = battery_charging;
 	spin_unlock_irqrestore(&sc->lock, flags);
+
+	/* The Dualshock 4 multi-touch trackpad data starts at offset 35 on USB.
+	 * The first 7 bits of the first byte is a counter and bit 8 is a touch
+	 * indicator that is 0 when pressed and 1 when not pressed.
+	 * The next 3 bytes are two 12 bit touch coordinates, X and Y.
+	 * The data for the second touch is in the same format and immediatly
+	 * follows the data for the first.
+	 */
+	for (n = 0; n < 2; n++) {
+		__u16 x, y;
+
+		x = rd[offset+1] | ((rd[offset+2] & 0xF) << 8);
+		y = ((rd[offset+2] & 0xF0) >> 4) | (rd[offset+3] << 4);
+
+		input_mt_slot(input_dev, n);
+		input_mt_report_slot_state(input_dev, MT_TOOL_FINGER,
+					!(rd[offset] >> 7));
+		input_report_abs(input_dev, ABS_MT_POSITION_X, x);
+		input_report_abs(input_dev, ABS_MT_POSITION_Y, y);
+
+		offset += 4;
+	}
 }
 
 static int sony_raw_event(struct hid_device *hdev, struct hid_report *report,
@@ -1200,6 +1227,26 @@ static int sony_set_output_report(struct sony_sc *sc, int req_id, int req_size)
 	return -EINVAL;
 }
 
+static int sony_register_touchpad(struct sony_sc *sc, int touch_count,
+					int w, int h)
+{
+	struct hid_input *hidinput = list_entry(sc->hdev->inputs.next,
+						struct hid_input, list);
+	struct input_dev *input_dev = hidinput->input;
+	int ret;
+
+	ret = input_mt_init_slots(input_dev, touch_count, 0);
+	if (ret < 0) {
+		hid_err(sc->hdev, "Unable to initialize multi-touch slots\n");
+		return ret;
+	}
+
+	input_set_abs_params(input_dev, ABS_MT_POSITION_X, 0, w, 0, 0);
+	input_set_abs_params(input_dev, ABS_MT_POSITION_Y, 0, h, 0, 0);
+
+	return 0;
+}
+
 static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	int ret;
@@ -1249,6 +1296,13 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		if (ret < 0)
 			goto err_stop;
 
+		/* The Dualshock 4 touchpad supports 2 touches and has a
+		 * resolution of 1920x940.
+		 */
+		ret = sony_register_touchpad(sc, 2, 1920, 940);
+		if (ret < 0)
+			goto err_stop;
+
 		INIT_WORK(&sc->state_worker, dualshock4_state_worker);
 	} else {
 		ret = 0;
-- 
1.8.3.2


From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH 4/7] HID: sony: Add offsets and battery calculations for parsing Dualshock 4 reports sent via Bluetooth.
Date: Wed, 29 Jan 2014 12:33:14 -0500
Message-ID: <1391016797-12842-5-git-send-email-frank.praznik@oh.rr.com>
References: <1391016797-12842-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:63872 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753098AbaA2Rdw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jan 2014 12:33:52 -0500
In-Reply-To: <1391016797-12842-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, Frank Praznik <frank.praznik@oh.rr.com>

The battery and touch data starts at offset 32 instead of 30 in the Bluetooth
reports.

When the controller isn't connected to a power source and the battery is
discharging, the battery level is reported from 0 to 9 instead of 1 to 11.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>

---
 drivers/hid/hid-sony.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index b35535e..e243c3d 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -861,25 +861,34 @@ static void dualshock4_parse_report(struct sony_sc *sc, __u8 *rd, int size)
 						struct hid_input, list);
 	struct input_dev *input_dev = hidinput->input;
 	unsigned long flags;
-	int n, offset = 35;
+	int n, offset;
 	__u8 cable_state, battery_capacity, battery_charging;
 
+	/* Battery and touchpad data starts at byte 30 in the USB report and
+	 * 32 in Bluetooth report.
+	 */
+	offset = (sc->quirks & DUALSHOCK4_CONTROLLER_USB) ? 30 : 32;
+
 	/* The lower 4 bits of byte 30 contain the battery level
 	 * and the 5th bit contains the USB cable state.
 	 */
-	cable_state = (rd[30] >> 4) & 0x01;
-	battery_capacity = rd[30] & 0x0F;
+	cable_state = (rd[offset] >> 4) & 0x01;
+	battery_capacity = rd[offset] & 0x0F;
 
-	/* On USB the Dualshock 4 battery level goes from 0 to 11.
-	 * A battery level of 11 means fully charged.
+	/* When a USB power source is connected the battery level ranges from
+	 * 0 to 11, and when running on battery power it ranges from 0 to 9.
+	 * A battery level of 11 means charge completed.
 	 */
-	if (cable_state && battery_capacity == 11)
+	if (!cable_state || battery_capacity == 11)
 		battery_charging = 0;
 	else
 		battery_charging = 1;
 
+	if (!cable_state)
+		battery_capacity++;
 	if (battery_capacity > 10)
 		battery_capacity--;
+
 	battery_capacity *= 10;
 
 	spin_lock_irqsave(&sc->lock, flags);
@@ -888,7 +897,10 @@ static void dualshock4_parse_report(struct sony_sc *sc, __u8 *rd, int size)
 	sc->battery_charging = battery_charging;
 	spin_unlock_irqrestore(&sc->lock, flags);
 
-	/* The Dualshock 4 multi-touch trackpad data starts at offset 35 on USB.
+	offset += 5;
+
+	/* The Dualshock 4 multi-touch trackpad data starts at offset 35 on USB
+	 * and 37 on Bluetooth.
 	 * The first 7 bits of the first byte is a counter and bit 8 is a touch
 	 * indicator that is 0 when pressed and 1 when not pressed.
 	 * The next 3 bytes are two 12 bit touch coordinates, X and Y.
-- 
1.8.5.3


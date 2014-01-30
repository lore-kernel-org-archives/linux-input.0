From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH v2 4/6] HID: sony: Add Dualshock 4 Bluetooth battery and touchpad parsing
Date: Thu, 30 Jan 2014 12:24:06 -0500
Message-ID: <1391102648-19381-5-git-send-email-frank.praznik@oh.rr.com>
References: <1391102648-19381-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:59584 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753289AbaA3RYP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 30 Jan 2014 12:24:15 -0500
In-Reply-To: <1391102648-19381-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, dh.herrmann@gmail.com, Frank Praznik <frank.praznik@oh.rr.com>

Add offsets for retrieving the battery and touchpad data in Dualshock 4
Bluetooth reports.

Adjust battery capacity calculations when in wireless mode.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
---
 drivers/hid/hid-sony.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 688da52..9aa20ff 100644
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
+	 * 0 to 10, and when running on battery power it ranges from 0 to 9.
+	 * A battery level above 10 when plugged in means charge completed.
 	 */
-	if (cable_state && battery_capacity == 11)
+	if (!cable_state || battery_capacity > 10)
 		battery_charging = 0;
 	else
 		battery_charging = 1;
 
+	if (!cable_state)
+		battery_capacity++;
 	if (battery_capacity > 10)
-		battery_capacity--;
+		battery_capacity = 10;
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


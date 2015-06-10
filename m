From: Simon Wood <simon@mungewell.org>
Subject: [PATCH 2/4] HID_ hid-sony_ Add support PS3 Move Battery via BT
Date: Tue,  9 Jun 2015 21:27:05 -0600
Message-ID: <1433906827-11146-2-git-send-email-simon@mungewell.org>
References: <1433906827-11146-1-git-send-email-simon@mungewell.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:49069 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753110AbbFJD1U (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Jun 2015 23:27:20 -0400
In-Reply-To: <1433906827-11146-1-git-send-email-simon@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Frank Praznik <frank.praznik@oh.rr.com>, Simon Wood <simon@mungewell.org>

Add support for the battery charge level and state to be read via BT.

This is not support via USB as there is no know way to get the device
sending 'input' reports over USB.

Signed-off-by: Simon Wood <simon@mungewell.org>
---
 drivers/hid/hid-sony.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 28dba6c..d9fa804 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -55,7 +55,8 @@
 				DUALSHOCK4_CONTROLLER_BT)
 #define SONY_LED_SUPPORT (SIXAXIS_CONTROLLER | BUZZ_CONTROLLER |\
 				DUALSHOCK4_CONTROLLER | MOTION_CONTROLLER)
-#define SONY_BATTERY_SUPPORT (SIXAXIS_CONTROLLER | DUALSHOCK4_CONTROLLER)
+#define SONY_BATTERY_SUPPORT (SIXAXIS_CONTROLLER | DUALSHOCK4_CONTROLLER |\
+				MOTION_CONTROLLER_BT)
 #define SONY_FF_SUPPORT (SIXAXIS_CONTROLLER | DUALSHOCK4_CONTROLLER |\
 				MOTION_CONTROLLER)
 
@@ -1041,6 +1042,7 @@ static void sixaxis_parse_report(struct sony_sc *sc, __u8 *rd, int size)
 {
 	static const __u8 sixaxis_battery_capacity[] = { 0, 1, 25, 50, 75, 100 };
 	unsigned long flags;
+	int offset;
 	__u8 cable_state, battery_capacity, battery_charging;
 
 	/*
@@ -1049,12 +1051,14 @@ static void sixaxis_parse_report(struct sony_sc *sc, __u8 *rd, int size)
 	 * It does not report the actual level while charging so it
 	 * is set to 100% while charging is in progress.
 	 */
-	if (rd[30] >= 0xee) {
+	offset = (sc->quirks & MOTION_CONTROLLER) ? 12 : 30;
+
+	if (rd[offset] >= 0xee) {
 		battery_capacity = 100;
-		battery_charging = !(rd[30] & 0x01);
+		battery_charging = !(rd[offset] & 0x01);
 		cable_state = 1;
 	} else {
-		__u8 index = rd[30] <= 5 ? rd[30] : 5;
+		__u8 index = rd[offset] <= 5 ? rd[offset] : 5;
 		battery_capacity = sixaxis_battery_capacity[index];
 		battery_charging = 0;
 		cable_state = 0;
@@ -1155,6 +1159,8 @@ static int sony_raw_event(struct hid_device *hdev, struct hid_report *report,
 		swap(rd[47], rd[48]);
 
 		sixaxis_parse_report(sc, rd, size);
+	} else if ((sc->quirks & MOTION_CONTROLLER_BT) && rd[0] == 0x01 && size == 49) {
+		sixaxis_parse_report(sc, rd, size);
 	} else if (((sc->quirks & DUALSHOCK4_CONTROLLER_USB) && rd[0] == 0x01 &&
 			size == 64) || ((sc->quirks & DUALSHOCK4_CONTROLLER_BT)
 			&& rd[0] == 0x11 && size == 78)) {
@@ -1976,6 +1982,7 @@ static int sony_check_add(struct sony_sc *sc)
 	int n, ret;
 
 	if ((sc->quirks & DUALSHOCK4_CONTROLLER_BT) ||
+	    (sc->quirks & MOTION_CONTROLLER_BT) ||
 	    (sc->quirks & SIXAXIS_CONTROLLER_BT)) {
 		/*
 		 * sony_get_bt_devaddr() attempts to parse the Bluetooth MAC
-- 
2.1.4


From: Frederic Jacob <frederic.jacob.78@gmail.com>
Subject: [PATCH] hid: sony: Add power supply support for PS3 remote
Date: Tue,  8 Mar 2016 20:40:59 -0500
Message-ID: <1457487659-3970-1-git-send-email-frederic.jacob.78@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:33408 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbcCIBs7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Mar 2016 20:48:59 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Frederic Jacob <frederic.jacob.78@gmail.com>

Add power supply support for the PS3 remote controller

Signed-off-by: Frederic Jacob <frederic.jacob.78@gmail.com>

---
 drivers/hid/hid-sony.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 9b8db0e..b78e149 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -61,7 +61,8 @@
 				DUALSHOCK4_CONTROLLER | MOTION_CONTROLLER |\
 				NAVIGATION_CONTROLLER)
 #define SONY_BATTERY_SUPPORT (SIXAXIS_CONTROLLER | DUALSHOCK4_CONTROLLER |\
-				MOTION_CONTROLLER_BT | NAVIGATION_CONTROLLER)
+				MOTION_CONTROLLER_BT | NAVIGATION_CONTROLLER |\
+				PS3REMOTE)
 #define SONY_FF_SUPPORT (SIXAXIS_CONTROLLER | DUALSHOCK4_CONTROLLER |\
 				MOTION_CONTROLLER)

@@ -1177,7 +1178,12 @@ static void sixaxis_parse_report(struct sony_sc *sc, __u8 *rd, int size)
 	 * It does not report the actual level while charging so it
 	 * is set to 100% while charging is in progress.
 	 */
-	offset = (sc->quirks & MOTION_CONTROLLER) ? 12 : 30;
+	if (sc->quirks & MOTION_CONTROLLER)
+		offset = 12;
+	else if (sc->quirks & PS3REMOTE)
+		offset = 11;
+	else
+		offset = 30;

 	if (rd[offset] >= 0xee) {
 		battery_capacity = 100;
@@ -1301,6 +1307,9 @@ static int sony_raw_event(struct hid_device *hdev, struct hid_report *report,
 	} else if ((sc->quirks & NAVIGATION_CONTROLLER) && rd[0] == 0x01 &&
 			size == 49) {
 		sixaxis_parse_report(sc, rd, size);
+	} else if ((sc->quirks & PS3REMOTE) && rd[0] == 0x01 &&
+			size == 12) {
+		sixaxis_parse_report(sc, rd, size);
 	} else if (((sc->quirks & DUALSHOCK4_CONTROLLER_USB) && rd[0] == 0x01 &&
 			size == 64) || ((sc->quirks & DUALSHOCK4_CONTROLLER_BT)
 			&& rd[0] == 0x11 && size == 78)) {
--
2.5.0

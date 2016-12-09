From: Roderick Colenbrander <roderick@gaikai.com>
Subject: [PATCH 3/7] HID: sony: Ignore DS4 dongle reports when no device is connected
Date: Thu,  8 Dec 2016 19:09:52 -0800
Message-ID: <1481252996-25288-4-git-send-email-roderick@gaikai.com>
References: <1481252996-25288-1-git-send-email-roderick@gaikai.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f54.google.com ([74.125.83.54]:35538 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932532AbcLIDKo (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 8 Dec 2016 22:10:44 -0500
Received: by mail-pg0-f54.google.com with SMTP id p66so2562618pga.2
        for <linux-input@vger.kernel.org>; Thu, 08 Dec 2016 19:10:44 -0800 (PST)
In-Reply-To: <1481252996-25288-1-git-send-email-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Simon Wood <simon@mungewell.org>, Frank Praznik <frank.praznik@gmail.com>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

When the DS4 dongle is connected, it always generates HID reports
even when no DS4 is paired to it. This patch adds logic to ignore
HID reports from the dongle if there is no DS4 currently attached.

Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
---
 drivers/hid/hid-sony.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index c6982a2..f405b07 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1099,8 +1099,11 @@ struct sony_sc {
 	u8 led_delay_on[MAX_LEDS];
 	u8 led_delay_off[MAX_LEDS];
 	u8 led_count;
+	bool ds4_dongle_connected;
 };
 
+static void sony_set_leds(struct sony_sc *sc);
+
 static inline void sony_schedule_work(struct sony_sc *sc)
 {
 	if (!sc->defer_initialization)
@@ -1430,6 +1433,31 @@ static int sony_raw_event(struct hid_device *hdev, struct hid_report *report,
 				return -EILSEQ;
 			}
 		}
+
+		/*
+		 * In the case of a DS4 USB dongle, bit[2] of byte 31 indicates
+		 * if a DS4 is actually connected (indicated by '0').
+		 * For non-dongle, this bit is always 0 (connected).
+		 */
+		if (sc->hdev->vendor == USB_VENDOR_ID_SONY &&
+		    sc->hdev->product == USB_DEVICE_ID_SONY_PS4_CONTROLLER_DONGLE) {
+			bool connected = (rd[31] & 0x04) ? false : true;
+
+			if (!sc->ds4_dongle_connected && connected) {
+				hid_info(sc->hdev, "DualShock 4 USB dongle: controller connected\n");
+				sony_set_leds(sc);
+				sc->ds4_dongle_connected = true;
+			} else if (sc->ds4_dongle_connected && !connected) {
+				hid_info(sc->hdev, "DualShock 4 USB dongle: controller disconnected\n");
+				sc->ds4_dongle_connected = false;
+				/* Return 0, so hidraw can get the report. */
+				return 0;
+			} else if (!sc->ds4_dongle_connected) {
+				/* Return 0, so hidraw can get the report. */
+				return 0;
+			}
+		}
+
 		dualshock4_parse_report(sc, rd, size);
 	}
 
-- 
2.7.4


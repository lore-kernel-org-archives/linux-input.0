From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 4/7] HID: wacom: Provide battery charge state to system over USB if available
Date: Fri,  6 Mar 2015 11:47:34 -0800
Message-ID: <1425671264-4944-4-git-send-email-killertofu@gmail.com>
References: <1425671264-4944-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:37955 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755190AbbCFTr4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Mar 2015 14:47:56 -0500
Received: by pdbfl12 with SMTP id fl12so46295152pdb.5
        for <linux-input@vger.kernel.org>; Fri, 06 Mar 2015 11:47:56 -0800 (PST)
In-Reply-To: <1425671264-4944-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, linux-input@vger.kernel.org
Cc: pinglinux@gmail.com, benjamin.tissoires@redhat.com, Jason Gerecke <killertofu@gmail.com>

If a wireless adapter (which contains the charging circuitry) is
detected as being attached to the tablet then create a new battery
interface and update its status as data is reported. Also destroy the
battery if the adapter goes away.

Signed-off-by: Jason Gerecke <killertofu@gmail.com>
---
 drivers/hid/wacom_wac.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 5d57fec..f1e53f1 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1952,6 +1952,7 @@ static int wacom_wireless_irq(struct wacom_wac *wacom, size_t len)
 
 static int wacom_status_irq(struct wacom_wac *wacom_wac, size_t len)
 {
+	struct wacom *wacom = container_of(wacom_wac, struct wacom, wacom_wac);
 	struct wacom_features *features = &wacom_wac->features;
 	unsigned char *data = wacom_wac->data;
 
@@ -1965,6 +1966,30 @@ static int wacom_status_irq(struct wacom_wac *wacom_wac, size_t len)
 				    SW_MUTE_DEVICE, data[8] & 0x40);
 		input_sync(wacom_wac->shared->touch_input);
 	}
+
+	if (data[9] & 0x02) { /* wireless module is attached */
+		int battery = (data[8] & 0x3f) * 100 / 31;
+		bool ps_connected = !!(data[8] & 0x80);
+		bool charging = ps_connected &&
+				wacom_wac->battery_capacity < 100;
+
+		wacom_notify_battery(wacom_wac, battery, charging,
+				     ps_connected);
+
+		if (!wacom->battery.dev &&
+		    !(features->quirks & WACOM_QUIRK_BATTERY)) {
+			features->quirks |= WACOM_QUIRK_BATTERY;
+			INIT_WORK(&wacom->work, wacom_battery_work);
+			wacom_schedule_work(wacom_wac);
+		}
+	}
+	else if ((features->quirks & WACOM_QUIRK_BATTERY) &&
+		 wacom->battery.dev) {
+		features->quirks &= ~WACOM_QUIRK_BATTERY;
+		INIT_WORK(&wacom->work, wacom_battery_work);
+		wacom_schedule_work(wacom_wac);
+		wacom_notify_battery(wacom_wac, 0, 0, 0);
+	}
 	return 0;
 }
 
-- 
2.3.0


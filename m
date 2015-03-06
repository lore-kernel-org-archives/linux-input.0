From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 2/7] HID: wacom: Centralize updating of wacom_wac battery status
Date: Fri,  6 Mar 2015 11:47:32 -0800
Message-ID: <1425671264-4944-2-git-send-email-killertofu@gmail.com>
References: <1425671264-4944-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:46102 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754647AbbCFTrw (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Mar 2015 14:47:52 -0500
Received: by pabli10 with SMTP id li10so53964807pab.13
        for <linux-input@vger.kernel.org>; Fri, 06 Mar 2015 11:47:52 -0800 (PST)
In-Reply-To: <1425671264-4944-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, linux-input@vger.kernel.org
Cc: pinglinux@gmail.com, benjamin.tissoires@redhat.com, Jason Gerecke <killertofu@gmail.com>

Has the 'wacom_notify_battery' function take on the job of detecting if
updating the power supply is necessary to remove multiple
nearly-identical 'if' blocks.

Signed-off-by: Jason Gerecke <killertofu@gmail.com>
---
 drivers/hid/wacom.h     |  7 ------
 drivers/hid/wacom_wac.c | 57 +++++++++++++++++++++++++------------------------
 2 files changed, 29 insertions(+), 35 deletions(-)

diff --git a/drivers/hid/wacom.h b/drivers/hid/wacom.h
index 7db4328..b8344b1 100644
--- a/drivers/hid/wacom.h
+++ b/drivers/hid/wacom.h
@@ -129,13 +129,6 @@ static inline void wacom_schedule_work(struct wacom_wac *wacom_wac)
 	schedule_work(&wacom->work);
 }
 
-static inline void wacom_notify_battery(struct wacom_wac *wacom_wac)
-{
-	struct wacom *wacom = container_of(wacom_wac, struct wacom, wacom_wac);
-
-	power_supply_changed(&wacom->battery);
-}
-
 extern const struct hid_device_id wacom_ids[];
 
 void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len);
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index cb308c5..5d57fec 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -45,6 +45,24 @@ static unsigned short batcap_gr[8] = { 1, 15, 25, 35, 50, 70, 100, 100 };
  */
 static unsigned short batcap_i4[8] = { 1, 15, 30, 45, 60, 70, 85, 100 };
 
+static void wacom_notify_battery(struct wacom_wac *wacom_wac,
+	int bat_capacity, bool bat_charging, bool ps_connected)
+{
+	struct wacom *wacom = container_of(wacom_wac, struct wacom, wacom_wac);
+	bool changed = wacom_wac->battery_capacity != bat_capacity  ||
+		       wacom_wac->bat_charging     != bat_charging  ||
+		       wacom_wac->ps_connected     != ps_connected;
+
+	if (changed) {
+		wacom_wac->battery_capacity = bat_capacity;
+		wacom_wac->bat_charging = bat_charging;
+		wacom_wac->ps_connected = ps_connected;
+
+		if (wacom->battery.dev)
+			power_supply_changed(&wacom->battery);
+	}
+}
+
 static int wacom_penpartner_irq(struct wacom_wac *wacom)
 {
 	unsigned char *data = wacom->data;
@@ -419,12 +437,8 @@ static int wacom_graphire_irq(struct wacom_wac *wacom)
 		rw = (data[7] >> 2 & 0x07);
 		battery_capacity = batcap_gr[rw];
 		ps_connected = rw == 7;
-		if ((wacom->battery_capacity != battery_capacity) ||
-		    (wacom->ps_connected != ps_connected)) {
-			wacom->battery_capacity = battery_capacity;
-			wacom->ps_connected = ps_connected;
-			wacom_notify_battery(wacom);
-		}
+		wacom_notify_battery(wacom, battery_capacity, ps_connected,
+				     ps_connected);
 	}
 exit:
 	return retval;
@@ -1014,15 +1028,8 @@ static int wacom_intuos_bt_irq(struct wacom_wac *wacom, size_t len)
 		bat_charging = (power_raw & 0x08) ? 1 : 0;
 		ps_connected = (power_raw & 0x10) ? 1 : 0;
 		battery_capacity = batcap_i4[power_raw & 0x07];
-		if ((wacom->battery_capacity != battery_capacity) ||
-		    (wacom->bat_charging != bat_charging) ||
-		    (wacom->ps_connected != ps_connected)) {
-			wacom->battery_capacity = battery_capacity;
-			wacom->bat_charging = bat_charging;
-			wacom->ps_connected = ps_connected;
-			wacom_notify_battery(wacom);
-		}
-
+		wacom_notify_battery(wacom, battery_capacity, bat_charging,
+				     ps_connected);
 		break;
 	default:
 		dev_dbg(wacom->input->dev.parent,
@@ -1910,7 +1917,7 @@ static int wacom_wireless_irq(struct wacom_wac *wacom, size_t len)
 
 	connected = data[1] & 0x01;
 	if (connected) {
-		int pid, battery, ps_connected;
+		int pid, battery, ps_connected, charging;
 
 		if ((wacom->shared->type == INTUOSHT) &&
 		    wacom->shared->touch_input &&
@@ -1923,27 +1930,21 @@ static int wacom_wireless_irq(struct wacom_wac *wacom, size_t len)
 		pid = get_unaligned_be16(&data[6]);
 		battery = (data[5] & 0x3f) * 100 / 31;
 		ps_connected = !!(data[5] & 0x80);
+		charging = ps_connected && wacom->battery_capacity < 100;
 		if (wacom->pid != pid) {
 			wacom->pid = pid;
 			wacom_schedule_work(wacom);
 		}
 
-		if (wacom->shared->type &&
-		    (battery != wacom->battery_capacity ||
-		     ps_connected != wacom->ps_connected)) {
-			wacom->battery_capacity = battery;
-			wacom->ps_connected = ps_connected;
-			wacom->bat_charging = ps_connected &&
-						wacom->battery_capacity < 100;
-			wacom_notify_battery(wacom);
-		}
+		if (wacom->shared->type)
+			wacom_notify_battery(wacom, battery, charging,
+					     ps_connected);
+
 	} else if (wacom->pid != 0) {
 		/* disconnected while previously connected */
 		wacom->pid = 0;
 		wacom_schedule_work(wacom);
-		wacom->battery_capacity = 0;
-		wacom->bat_charging = 0;
-		wacom->ps_connected = 0;
+		wacom_notify_battery(wacom, 0, 0, 0);
 	}
 
 	return 0;
-- 
2.3.0


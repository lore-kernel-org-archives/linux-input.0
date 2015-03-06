From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 7/7] HID: wacom: Add battery presence indicator to wireless tablets
Date: Fri,  6 Mar 2015 11:47:37 -0800
Message-ID: <1425671264-4944-7-git-send-email-killertofu@gmail.com>
References: <1425671264-4944-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:38245 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755794AbbCFTsC (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Mar 2015 14:48:02 -0500
Received: by pabrd3 with SMTP id rd3so30025634pab.5
        for <linux-input@vger.kernel.org>; Fri, 06 Mar 2015 11:48:02 -0800 (PST)
In-Reply-To: <1425671264-4944-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, linux-input@vger.kernel.org
Cc: pinglinux@gmail.com, benjamin.tissoires@redhat.com, Jason Gerecke <killertofu@gmail.com>

Signed-off-by: Jason Gerecke <killertofu@gmail.com>
---
 drivers/hid/wacom_sys.c |  4 ++++
 drivers/hid/wacom_wac.c | 16 ++++++++++------
 drivers/hid/wacom_wac.h |  1 +
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 955ce7c..ab7bf84 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -945,6 +945,7 @@ static void wacom_destroy_leds(struct wacom *wacom)
 }
 
 static enum power_supply_property wacom_battery_props[] = {
+	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_SCOPE,
 	POWER_SUPPLY_PROP_CAPACITY
@@ -964,6 +965,9 @@ static int wacom_battery_get_property(struct power_supply *psy,
 	int ret = 0;
 
 	switch (psp) {
+		case POWER_SUPPLY_PROP_PRESENT:
+			val->intval = wacom->wacom_wac.bat_connected;
+			break;
 		case POWER_SUPPLY_PROP_SCOPE:
 			val->intval = POWER_SUPPLY_SCOPE_DEVICE;
 			break;
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 57faf5b..9262622 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -46,16 +46,19 @@ static unsigned short batcap_gr[8] = { 1, 15, 25, 35, 50, 70, 100, 100 };
 static unsigned short batcap_i4[8] = { 1, 15, 30, 45, 60, 70, 85, 100 };
 
 static void wacom_notify_battery(struct wacom_wac *wacom_wac,
-	int bat_capacity, bool bat_charging, bool ps_connected)
+	int bat_capacity, bool bat_charging, bool bat_connected,
+	bool ps_connected)
 {
 	struct wacom *wacom = container_of(wacom_wac, struct wacom, wacom_wac);
 	bool changed = wacom_wac->battery_capacity != bat_capacity  ||
 		       wacom_wac->bat_charging     != bat_charging  ||
+		       wacom_wac->bat_connected    != bat_connected ||
 		       wacom_wac->ps_connected     != ps_connected;
 
 	if (changed) {
 		wacom_wac->battery_capacity = bat_capacity;
 		wacom_wac->bat_charging = bat_charging;
+		wacom_wac->bat_connected = bat_connected;
 		wacom_wac->ps_connected = ps_connected;
 
 		if (wacom->battery.dev)
@@ -438,7 +441,7 @@ static int wacom_graphire_irq(struct wacom_wac *wacom)
 		battery_capacity = batcap_gr[rw];
 		ps_connected = rw == 7;
 		wacom_notify_battery(wacom, battery_capacity, ps_connected,
-				     ps_connected);
+				     1, ps_connected);
 	}
 exit:
 	return retval;
@@ -1029,6 +1032,7 @@ static int wacom_intuos_bt_irq(struct wacom_wac *wacom, size_t len)
 		ps_connected = (power_raw & 0x10) ? 1 : 0;
 		battery_capacity = batcap_i4[power_raw & 0x07];
 		wacom_notify_battery(wacom, battery_capacity, bat_charging,
+				     battery_capacity || bat_charging,
 				     ps_connected);
 		break;
 	default:
@@ -1936,13 +1940,13 @@ static int wacom_wireless_irq(struct wacom_wac *wacom, size_t len)
 		}
 
 		if (wacom->shared->type)
-			wacom_notify_battery(wacom, battery, charging, 0);
+			wacom_notify_battery(wacom, battery, charging, 1, 0);
 
 	} else if (wacom->pid != 0) {
 		/* disconnected while previously connected */
 		wacom->pid = 0;
 		wacom_schedule_work(wacom);
-		wacom_notify_battery(wacom, 0, 0, 0);
+		wacom_notify_battery(wacom, 0, 0, 0, 0);
 	}
 
 	return 0;
@@ -1970,7 +1974,7 @@ static int wacom_status_irq(struct wacom_wac *wacom_wac, size_t len)
 		bool charging = !!(data[8] & 0x80);
 
 		wacom_notify_battery(wacom_wac, battery, charging,
-				     1);
+				     battery || charging, 1);
 
 		if (!wacom->battery.dev &&
 		    !(features->quirks & WACOM_QUIRK_BATTERY)) {
@@ -1984,7 +1988,7 @@ static int wacom_status_irq(struct wacom_wac *wacom_wac, size_t len)
 		features->quirks &= ~WACOM_QUIRK_BATTERY;
 		INIT_WORK(&wacom->work, wacom_battery_work);
 		wacom_schedule_work(wacom_wac);
-		wacom_notify_battery(wacom_wac, 0, 0, 0);
+		wacom_notify_battery(wacom_wac, 0, 0, 0, 0);
 	}
 	return 0;
 }
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index ee6a545..f3daf7b 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -213,6 +213,7 @@ struct wacom_wac {
 	int battery_capacity;
 	int num_contacts_left;
 	int bat_charging;
+	int bat_connected;
 	int ps_connected;
 	u8 bt_features;
 	u8 bt_high_speed;
-- 
2.3.0


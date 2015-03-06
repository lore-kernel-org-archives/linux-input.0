From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 6/7] HID: wacom: Status packet provides 'charging', not 'powered' bit
Date: Fri,  6 Mar 2015 11:47:36 -0800
Message-ID: <1425671264-4944-6-git-send-email-killertofu@gmail.com>
References: <1425671264-4944-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:34184 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755190AbbCFTsA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Mar 2015 14:48:00 -0500
Received: by pdno5 with SMTP id o5so3376598pdn.1
        for <linux-input@vger.kernel.org>; Fri, 06 Mar 2015 11:48:00 -0800 (PST)
In-Reply-To: <1425671264-4944-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, linux-input@vger.kernel.org
Cc: pinglinux@gmail.com, benjamin.tissoires@redhat.com, Jason Gerecke <killertofu@gmail.com>

The status packet for tablets which can use a wireless module contains a
bit that is set if the battery is charging. This bit will be 0 if either
a battery is not present or if the battery has reached full charge. Note
that the charging circuit may continue to charge the battery for a short
time after reaching "100%".

Signed-off-by: Jason Gerecke <killertofu@gmail.com>
---
 drivers/hid/wacom_sys.c |  2 ++
 drivers/hid/wacom_wac.c | 14 +++++---------
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index dfa4be7..955ce7c 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -977,6 +977,8 @@ static int wacom_battery_get_property(struct power_supply *psy,
 			else if (wacom->wacom_wac.battery_capacity == 100 &&
 				    wacom->wacom_wac.ps_connected)
 				val->intval = POWER_SUPPLY_STATUS_FULL;
+			else if (wacom->wacom_wac.ps_connected)
+				val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
 			else
 				val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
 			break;
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 726fedb..57faf5b 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1917,7 +1917,7 @@ static int wacom_wireless_irq(struct wacom_wac *wacom, size_t len)
 
 	connected = data[1] & 0x01;
 	if (connected) {
-		int pid, battery, ps_connected, charging;
+		int pid, battery, charging;
 
 		if ((wacom->shared->type == INTUOSHT) &&
 		    wacom->shared->touch_input &&
@@ -1929,16 +1929,14 @@ static int wacom_wireless_irq(struct wacom_wac *wacom, size_t len)
 
 		pid = get_unaligned_be16(&data[6]);
 		battery = (data[5] & 0x3f) * 100 / 31;
-		ps_connected = !!(data[5] & 0x80);
-		charging = ps_connected && wacom->battery_capacity < 100;
+		charging = !!(data[5] & 0x80);
 		if (wacom->pid != pid) {
 			wacom->pid = pid;
 			wacom_schedule_work(wacom);
 		}
 
 		if (wacom->shared->type)
-			wacom_notify_battery(wacom, battery, charging,
-					     ps_connected);
+			wacom_notify_battery(wacom, battery, charging, 0);
 
 	} else if (wacom->pid != 0) {
 		/* disconnected while previously connected */
@@ -1969,12 +1967,10 @@ static int wacom_status_irq(struct wacom_wac *wacom_wac, size_t len)
 
 	if (data[9] & 0x02) { /* wireless module is attached */
 		int battery = (data[8] & 0x3f) * 100 / 31;
-		bool ps_connected = !!(data[8] & 0x80);
-		bool charging = ps_connected &&
-				wacom_wac->battery_capacity < 100;
+		bool charging = !!(data[8] & 0x80);
 
 		wacom_notify_battery(wacom_wac, battery, charging,
-				     ps_connected);
+				     1);
 
 		if (!wacom->battery.dev &&
 		    !(features->quirks & WACOM_QUIRK_BATTERY)) {
-- 
2.3.0


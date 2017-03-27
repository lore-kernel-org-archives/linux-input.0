From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 14/19] HID: logitech-hidpp: battery: provide ONLINE property
Date: Mon, 27 Mar 2017 16:59:34 +0200
Message-ID: <20170327145939.29824-15-benjamin.tissoires@redhat.com>
References: <20170327145939.29824-1-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33358 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753525AbdC0PA2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 27 Mar 2017 11:00:28 -0400
In-Reply-To: <20170327145939.29824-1-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

When ONLINE isn't set, upower should ignore the battery capacity,
so there is no need to overload it with some random values.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

completely reworked in v3:
- store a online field in hidpp->battery to be able to fine control
  the value
- provide POWER_SUPPLY_STATUS_UNKNOWN to the status when the device
  is disconnected
---
 drivers/hid/hid-logitech-hidpp.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 0781d2b..7e4445a 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -120,6 +120,7 @@ struct hidpp_battery {
 	char name[64];
 	int status;
 	int level;
+	bool online;
 };
 
 struct hidpp_device {
@@ -686,7 +687,6 @@ static int hidpp20_batterylevel_map_status_level(u8 data[3], int *level,
 						 int *next_level)
 {
 	int status;
-	int level_override;
 
 	*level = data[0];
 	*next_level = data[1];
@@ -698,36 +698,28 @@ static int hidpp20_batterylevel_map_status_level(u8 data[3], int *level,
 	switch (data[2]) {
 		case 0: /* discharging (in use) */
 			status = POWER_SUPPLY_STATUS_DISCHARGING;
-			level_override = 0;
 			break;
 		case 1: /* recharging */
 			status = POWER_SUPPLY_STATUS_CHARGING;
-			level_override = 80;
 			break;
 		case 2: /* charge in final stage */
 			status = POWER_SUPPLY_STATUS_CHARGING;
-			level_override = 90;
 			break;
 		case 3: /* charge complete */
 			status = POWER_SUPPLY_STATUS_FULL;
-			level_override = 100;
+			*level = 100;
 			break;
 		case 4: /* recharging below optimal speed */
 			status = POWER_SUPPLY_STATUS_CHARGING;
-			level_override = 50;
 			break;
 		/* 5 = invalid battery type
 		   6 = thermal error
 		   7 = other charging error */
 		default:
 			status = POWER_SUPPLY_STATUS_NOT_CHARGING;
-			level_override = 0;
 			break;
 	}
 
-	if (level_override != 0 && *level == 0)
-		*level = level_override;
-
 	return status;
 }
 
@@ -781,6 +773,9 @@ static int hidpp20_query_battery_info(struct hidpp_device *hidpp)
 
 	hidpp->battery.status = status;
 	hidpp->battery.level = level;
+	/* the capacity is only available when discharging or full */
+	hidpp->battery.online = status == POWER_SUPPLY_STATUS_DISCHARGING ||
+				status == POWER_SUPPLY_STATUS_FULL;
 
 	return 0;
 }
@@ -799,6 +794,10 @@ static int hidpp20_battery_event(struct hidpp_device *hidpp,
 	status = hidpp20_batterylevel_map_status_level(report->fap.params,
 						       &level, &next_level);
 
+	/* the capacity is only available when discharging or full */
+	hidpp->battery.online = status == POWER_SUPPLY_STATUS_DISCHARGING ||
+				status == POWER_SUPPLY_STATUS_FULL;
+
 	changed = level != hidpp->battery.level ||
 		  status != hidpp->battery.status;
 
@@ -813,6 +812,7 @@ static int hidpp20_battery_event(struct hidpp_device *hidpp,
 }
 
 static enum power_supply_property hidpp_battery_props[] = {
+	POWER_SUPPLY_PROP_ONLINE,
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_CAPACITY,
 	POWER_SUPPLY_PROP_SCOPE,
@@ -838,6 +838,9 @@ static int hidpp_battery_get_property(struct power_supply *psy,
 		case POWER_SUPPLY_PROP_SCOPE:
 			val->intval = POWER_SUPPLY_SCOPE_DEVICE;
 			break;
+		case POWER_SUPPLY_PROP_ONLINE:
+			val->intval = hidpp->battery.online;
+			break;
 		case POWER_SUPPLY_PROP_MODEL_NAME:
 			if (!strncmp(hidpp->name, "Logitech ", 9))
 				val->strval = hidpp->name + 9;
@@ -2416,8 +2419,14 @@ static void hidpp_connect_event(struct hidpp_device *hidpp)
 	struct input_dev *input;
 	char *name, *devm_name;
 
-	if (!connected)
+	if (!connected) {
+		if (hidpp->battery.ps) {
+			hidpp->battery.online = false;
+			hidpp->battery.status = POWER_SUPPLY_STATUS_UNKNOWN;
+			power_supply_changed(hidpp->battery.ps);
+		}
 		return;
+	}
 
 	if (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP) {
 		ret = wtp_connect(hdev, connected);
-- 
2.9.3


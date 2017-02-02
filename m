From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 04/15] HID: logitech-hidpp: battery: remove overloads and provide ONLINE
Date: Thu,  2 Feb 2017 15:12:18 +0100
Message-ID: <20170202141229.17322-5-benjamin.tissoires@redhat.com>
References: <20170202141229.17322-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170202141229.17322-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>, Peter Hutterer <peter.hutterer@who-t.net>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Olivier Gay <ogay@logitech.com>, Simon Wood <simon@mungewell.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

When ONLINE isn't set, upower should ignore the battery capacity, so there
is no need to overload it with some random values.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

no changes in v2
---
 drivers/hid/hid-logitech-hidpp.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 1cda29e..3c57886 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -632,48 +632,39 @@ static int hidpp20_batterylevel_map_status_level(u8 data[3], int *level,
 						 int *next_level)
 {
 	int status;
-	int level_override;
 
-	*level = data[0];
+	if (data[0])
+		*level = data[0];
 	*next_level = data[1];
 
 	/* When discharging, we can rely on the device reported level.
-	 * For all other states the device reports level 0 (unknown). Make up
-	 * a number instead
+	 * For all other states the device reports level 0 (unknown).
 	 */
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
 
@@ -719,6 +710,8 @@ static int hidpp20_query_battery_info(struct hidpp_device *hidpp)
 			return ret;
 	}
 
+	level = 0;
+	next_level = 0;
 	ret = hidpp20_batterylevel_get_battery_level(hidpp,
 						     hidpp->battery.feature_index,
 						     &status, &level, &next_level);
@@ -742,6 +735,8 @@ static int hidpp20_battery_event(struct hidpp_device *hidpp,
 	    report->fap.funcindex_clientid != EVENT_BATTERY_LEVEL_STATUS_BROADCAST)
 		return 0;
 
+	level = hidpp->battery.level;
+
 	status = hidpp20_batterylevel_map_status_level(report->fap.params,
 						       &level, &next_level);
 
@@ -759,6 +754,7 @@ static int hidpp20_battery_event(struct hidpp_device *hidpp,
 }
 
 static enum power_supply_property hidpp_battery_props[] = {
+	POWER_SUPPLY_PROP_ONLINE,
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_CAPACITY,
 	POWER_SUPPLY_PROP_SCOPE,
@@ -781,6 +777,12 @@ static int hidpp_battery_get_property(struct power_supply *psy,
 		case POWER_SUPPLY_PROP_SCOPE:
 			val->intval = POWER_SUPPLY_SCOPE_DEVICE;
 			break;
+		case POWER_SUPPLY_PROP_ONLINE:
+			val->intval = hidpp->battery.status ==
+					      POWER_SUPPLY_STATUS_DISCHARGING ||
+					hidpp->battery.status ==
+					      POWER_SUPPLY_STATUS_FULL;
+			break;
 		default:
 			ret = -EINVAL;
 			break;
-- 
2.9.3

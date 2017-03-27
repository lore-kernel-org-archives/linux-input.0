From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 15/19] HID: logitech-hidpp: rename battery level into capacity
Date: Mon, 27 Mar 2017 16:59:35 +0200
Message-ID: <20170327145939.29824-16-benjamin.tissoires@redhat.com>
References: <20170327145939.29824-1-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:23426 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753386AbdC0PA3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 27 Mar 2017 11:00:29 -0400
In-Reply-To: <20170327145939.29824-1-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

The power_supply term for the percentage is capacity. Capacity level
can be given when non accurate mileage is provided by the device, so
better stick to the terms used in power_supply.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

new in v3
---
 drivers/hid/hid-logitech-hidpp.c | 55 ++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 27 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 7e4445a..c59f7e5e 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -119,7 +119,7 @@ struct hidpp_battery {
 	struct power_supply *ps;
 	char name[64];
 	int status;
-	int level;
+	int capacity;
 	bool online;
 };
 
@@ -683,17 +683,16 @@ static char *hidpp_get_device_name(struct hidpp_device *hidpp)
 
 #define EVENT_BATTERY_LEVEL_STATUS_BROADCAST			0x00
 
-static int hidpp20_batterylevel_map_status_level(u8 data[3], int *level,
-						 int *next_level)
+static int hidpp20_batterylevel_map_status_capacity(u8 data[3], int *capacity,
+						    int *next_capacity)
 {
 	int status;
 
-	*level = data[0];
-	*next_level = data[1];
+	*capacity = data[0];
+	*next_capacity = data[1];
 
-	/* When discharging, we can rely on the device reported level.
-	 * For all other states the device reports level 0 (unknown). Make up
-	 * a number instead
+	/* When discharging, we can rely on the device reported capacity.
+	 * For all other states the device reports 0 (unknown).
 	 */
 	switch (data[2]) {
 		case 0: /* discharging (in use) */
@@ -707,7 +706,7 @@ static int hidpp20_batterylevel_map_status_level(u8 data[3], int *level,
 			break;
 		case 3: /* charge complete */
 			status = POWER_SUPPLY_STATUS_FULL;
-			*level = 100;
+			*capacity = 100;
 			break;
 		case 4: /* recharging below optimal speed */
 			status = POWER_SUPPLY_STATUS_CHARGING;
@@ -723,11 +722,11 @@ static int hidpp20_batterylevel_map_status_level(u8 data[3], int *level,
 	return status;
 }
 
-static int hidpp20_batterylevel_get_battery_level(struct hidpp_device *hidpp,
-						  u8 feature_index,
-						  int *status,
-						  int *level,
-						  int *next_level)
+static int hidpp20_batterylevel_get_battery_capacity(struct hidpp_device *hidpp,
+						     u8 feature_index,
+						     int *status,
+						     int *capacity,
+						     int *next_capacity)
 {
 	struct hidpp_report response;
 	int ret;
@@ -744,8 +743,8 @@ static int hidpp20_batterylevel_get_battery_level(struct hidpp_device *hidpp,
 	if (ret)
 		return ret;
 
-	*status = hidpp20_batterylevel_map_status_level(params, level,
-							next_level);
+	*status = hidpp20_batterylevel_map_status_capacity(params, capacity,
+							   next_capacity);
 
 	return 0;
 }
@@ -754,7 +753,7 @@ static int hidpp20_query_battery_info(struct hidpp_device *hidpp)
 {
 	u8 feature_type;
 	int ret;
-	int status, level, next_level;
+	int status, capacity, next_capacity;
 
 	if (hidpp->battery.feature_index == 0) {
 		ret = hidpp_root_get_feature(hidpp,
@@ -765,14 +764,15 @@ static int hidpp20_query_battery_info(struct hidpp_device *hidpp)
 			return ret;
 	}
 
-	ret = hidpp20_batterylevel_get_battery_level(hidpp,
-						     hidpp->battery.feature_index,
-						     &status, &level, &next_level);
+	ret = hidpp20_batterylevel_get_battery_capacity(hidpp,
+						hidpp->battery.feature_index,
+						&status, &capacity,
+						&next_capacity);
 	if (ret)
 		return ret;
 
 	hidpp->battery.status = status;
-	hidpp->battery.level = level;
+	hidpp->battery.capacity = capacity;
 	/* the capacity is only available when discharging or full */
 	hidpp->battery.online = status == POWER_SUPPLY_STATUS_DISCHARGING ||
 				status == POWER_SUPPLY_STATUS_FULL;
@@ -784,25 +784,26 @@ static int hidpp20_battery_event(struct hidpp_device *hidpp,
 				 u8 *data, int size)
 {
 	struct hidpp_report *report = (struct hidpp_report *)data;
-	int status, level, next_level;
+	int status, capacity, next_capacity;
 	bool changed;
 
 	if (report->fap.feature_index != hidpp->battery.feature_index ||
 	    report->fap.funcindex_clientid != EVENT_BATTERY_LEVEL_STATUS_BROADCAST)
 		return 0;
 
-	status = hidpp20_batterylevel_map_status_level(report->fap.params,
-						       &level, &next_level);
+	status = hidpp20_batterylevel_map_status_capacity(report->fap.params,
+							  &capacity,
+							  &next_capacity);
 
 	/* the capacity is only available when discharging or full */
 	hidpp->battery.online = status == POWER_SUPPLY_STATUS_DISCHARGING ||
 				status == POWER_SUPPLY_STATUS_FULL;
 
-	changed = level != hidpp->battery.level ||
+	changed = capacity != hidpp->battery.capacity ||
 		  status != hidpp->battery.status;
 
 	if (changed) {
-		hidpp->battery.level = level;
+		hidpp->battery.capacity = capacity;
 		hidpp->battery.status = status;
 		if (hidpp->battery.ps)
 			power_supply_changed(hidpp->battery.ps);
@@ -833,7 +834,7 @@ static int hidpp_battery_get_property(struct power_supply *psy,
 			val->intval = hidpp->battery.status;
 			break;
 		case POWER_SUPPLY_PROP_CAPACITY:
-			val->intval = hidpp->battery.level;
+			val->intval = hidpp->battery.capacity;
 			break;
 		case POWER_SUPPLY_PROP_SCOPE:
 			val->intval = POWER_SUPPLY_SCOPE_DEVICE;
-- 
2.9.3


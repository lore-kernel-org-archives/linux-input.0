From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 18/19] HID: logitech-hidpp: enable HID++ 1.0 battery reporting
Date: Mon, 27 Mar 2017 16:59:38 +0200
Message-ID: <20170327145939.29824-19-benjamin.tissoires@redhat.com>
References: <20170327145939.29824-1-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:24138 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753546AbdC0PAf (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 27 Mar 2017 11:00:35 -0400
In-Reply-To: <20170327145939.29824-1-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Also enable battery reporting for HID++ 1.0 devices through 2 registers:
0x07: battery status -> reports only 4 levels (critical, low, good, full)
0x0D: battery mileage -> reports true pourcentage

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

changes in v3:
- differentiate between level and mileage
- better online reporting

no changes in v2
---
 drivers/hid/hid-logitech-hidpp.c | 234 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 230 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index bb40e5d..eb4339e 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -400,6 +400,211 @@ static void hidpp_prefix_name(char **name, int name_length)
 #define HIDPP_SET_LONG_REGISTER				0x82
 #define HIDPP_GET_LONG_REGISTER				0x83
 
+#define HIDPP_REG_GENERAL				0x00
+
+static int hidpp10_enable_battery_reporting(struct hidpp_device *hidpp_dev)
+{
+	struct hidpp_report response;
+	int ret;
+	u8 params[3] = { 0 };
+
+	ret = hidpp_send_rap_command_sync(hidpp_dev,
+					REPORT_ID_HIDPP_SHORT,
+					HIDPP_GET_REGISTER,
+					HIDPP_REG_GENERAL,
+					NULL, 0, &response);
+	if (ret)
+		return ret;
+
+	memcpy(params, response.rap.params, 3);
+
+	/* Set the battery bit */
+	params[0] |= BIT(4);
+
+	return hidpp_send_rap_command_sync(hidpp_dev,
+					REPORT_ID_HIDPP_SHORT,
+					HIDPP_SET_REGISTER,
+					HIDPP_REG_GENERAL,
+					params, 3, &response);
+}
+
+#define HIDPP_REG_BATTERY_STATUS			0x07
+
+static int hidpp10_battery_status_map_level(u8 param)
+{
+	int level;
+
+	switch (param) {
+	case 1 ... 2:
+		level = POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL;
+		break;
+	case 3 ... 4:
+		level = POWER_SUPPLY_CAPACITY_LEVEL_LOW;
+		break;
+	case 5 ... 6:
+		level = POWER_SUPPLY_CAPACITY_LEVEL_NORMAL;
+		break;
+	case 7:
+		level = POWER_SUPPLY_CAPACITY_LEVEL_HIGH;
+		break;
+	default:
+		level = POWER_SUPPLY_CAPACITY_LEVEL_UNKNOWN;
+	}
+
+	return level;
+}
+
+static int hidpp10_battery_status_map_status(u8 param)
+{
+	int status;
+
+	switch (param) {
+	case 0x00:
+		/* discharging (in use) */
+		status = POWER_SUPPLY_STATUS_DISCHARGING;
+		break;
+	case 0x21: /* (standard) charging */
+	case 0x24: /* fast charging */
+	case 0x25: /* slow charging */
+		status = POWER_SUPPLY_STATUS_CHARGING;
+		break;
+	case 0x26: /* topping charge */
+	case 0x22: /* charge complete */
+		status = POWER_SUPPLY_STATUS_FULL;
+		break;
+	case 0x20: /* unknown */
+		status = POWER_SUPPLY_STATUS_UNKNOWN;
+		break;
+	/*
+	 * 0x01...0x1F = reserved (not charging)
+	 * 0x23 = charging error
+	 * 0x27..0xff = reserved
+	 */
+	default:
+		status = POWER_SUPPLY_STATUS_NOT_CHARGING;
+		break;
+	}
+
+	return status;
+}
+
+static int hidpp10_query_battery_status(struct hidpp_device *hidpp)
+{
+	struct hidpp_report response;
+	int ret, status;
+
+	ret = hidpp_send_rap_command_sync(hidpp,
+					REPORT_ID_HIDPP_SHORT,
+					HIDPP_GET_REGISTER,
+					HIDPP_REG_BATTERY_STATUS,
+					NULL, 0, &response);
+	if (ret)
+		return ret;
+
+	hidpp->battery.level =
+		hidpp10_battery_status_map_level(response.rap.params[0]);
+	status = hidpp10_battery_status_map_status(response.rap.params[1]);
+	hidpp->battery.status = status;
+	/* the capacity is only available when discharging or full */
+	hidpp->battery.online = status == POWER_SUPPLY_STATUS_DISCHARGING ||
+				status == POWER_SUPPLY_STATUS_FULL;
+
+	return 0;
+}
+
+#define HIDPP_REG_BATTERY_MILEAGE			0x0D
+
+static int hidpp10_battery_mileage_map_status(u8 param)
+{
+	int status;
+
+	switch (param >> 6) {
+	case 0x00:
+		/* discharging (in use) */
+		status = POWER_SUPPLY_STATUS_DISCHARGING;
+		break;
+	case 0x01: /* charging */
+		status = POWER_SUPPLY_STATUS_CHARGING;
+		break;
+	case 0x02: /* charge complete */
+		status = POWER_SUPPLY_STATUS_FULL;
+		break;
+	/*
+	 * 0x03 = charging error
+	 */
+	default:
+		status = POWER_SUPPLY_STATUS_NOT_CHARGING;
+		break;
+	}
+
+	return status;
+}
+
+static int hidpp10_query_battery_mileage(struct hidpp_device *hidpp)
+{
+	struct hidpp_report response;
+	int ret, status;
+
+	ret = hidpp_send_rap_command_sync(hidpp,
+					REPORT_ID_HIDPP_SHORT,
+					HIDPP_GET_REGISTER,
+					HIDPP_REG_BATTERY_MILEAGE,
+					NULL, 0, &response);
+	if (ret)
+		return ret;
+
+	hidpp->battery.capacity = response.rap.params[0];
+	status = hidpp10_battery_mileage_map_status(response.rap.params[2]);
+	hidpp->battery.status = status;
+	/* the capacity is only available when discharging or full */
+	hidpp->battery.online = status == POWER_SUPPLY_STATUS_DISCHARGING ||
+				status == POWER_SUPPLY_STATUS_FULL;
+
+	return 0;
+}
+
+static int hidpp10_battery_event(struct hidpp_device *hidpp, u8 *data, int size)
+{
+	struct hidpp_report *report = (struct hidpp_report *)data;
+	int status, capacity, level;
+	bool changed;
+
+	if (report->report_id != REPORT_ID_HIDPP_SHORT)
+		return 0;
+
+	switch (report->rap.sub_id) {
+	case HIDPP_REG_BATTERY_STATUS:
+		capacity = hidpp->battery.capacity;
+		level = hidpp10_battery_status_map_level(report->rawbytes[1]);
+		status = hidpp10_battery_status_map_status(report->rawbytes[2]);
+		break;
+	case HIDPP_REG_BATTERY_MILEAGE:
+		capacity = report->rap.params[0];
+		level = hidpp->battery.level;
+		status = hidpp10_battery_mileage_map_status(report->rawbytes[3]);
+		break;
+	default:
+		return 0;
+	}
+
+	changed = capacity != hidpp->battery.capacity ||
+		  level != hidpp->battery.level ||
+		  status != hidpp->battery.status;
+
+	/* the capacity is only available when discharging or full */
+	hidpp->battery.online = status == POWER_SUPPLY_STATUS_DISCHARGING ||
+				status == POWER_SUPPLY_STATUS_FULL;
+
+	if (changed) {
+		hidpp->battery.level = level;
+		hidpp->battery.status = status;
+		if (hidpp->battery.ps)
+			power_supply_changed(hidpp->battery.ps);
+	}
+
+	return 0;
+}
+
 #define HIDPP_REG_PAIRING_INFORMATION			0xB5
 #define HIDPP_EXTENDED_PAIRING				0x30
 #define HIDPP_DEVICE_NAME				0x40
@@ -2428,6 +2633,12 @@ static int hidpp_raw_hidpp_event(struct hidpp_device *hidpp, u8 *data,
 			return ret;
 	}
 
+	if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP10_BATTERY) {
+		ret = hidpp10_battery_event(hidpp, data, size);
+		if (ret != 0)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -2505,7 +2716,16 @@ static int hidpp_initialize_battery(struct hidpp_device *hidpp)
 			return ret;
 		hidpp->capabilities |= HIDPP_CAPABILITY_HIDPP20_BATTERY;
 	} else {
-		return -ENOENT;
+		ret = hidpp10_query_battery_status(hidpp);
+		if (ret) {
+			ret = hidpp10_query_battery_mileage(hidpp);
+			if (ret)
+				return -ENOENT;
+			hidpp->capabilities |= HIDPP_CAPABILITY_BATTERY_MILEAGE;
+		} else {
+			hidpp->capabilities |= HIDPP_CAPABILITY_BATTERY_LEVEL_STATUS;
+		}
+		hidpp->capabilities |= HIDPP_CAPABILITY_HIDPP10_BATTERY;
 	}
 
 	battery_props = devm_kmemdup(&hidpp->hid_dev->dev,
@@ -2665,11 +2885,17 @@ static void hidpp_connect_event(struct hidpp_device *hidpp)
 	hidpp_initialize_battery(hidpp);
 
 	/* forward current battery state */
-	if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP20_BATTERY) {
+	if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP10_BATTERY) {
+		hidpp10_enable_battery_reporting(hidpp);
+		if (hidpp->capabilities & HIDPP_CAPABILITY_BATTERY_MILEAGE)
+			hidpp10_query_battery_mileage(hidpp);
+		else
+			hidpp10_query_battery_status(hidpp);
+	} else if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP20_BATTERY) {
 		hidpp20_query_battery_info(hidpp);
-		if (hidpp->battery.ps)
-			power_supply_changed(hidpp->battery.ps);
 	}
+	if (hidpp->battery.ps)
+		power_supply_changed(hidpp->battery.ps);
 
 	if (!(hidpp->quirks & HIDPP_QUIRK_NO_HIDINPUT) || hidpp->delayed_input)
 		/* if the input nodes are already created, we can stop now */
-- 
2.9.3


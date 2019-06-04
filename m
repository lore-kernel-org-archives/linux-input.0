From: Pedro Vanzella <pedro@pedrovanzella.com>
Subject: [PATCH 1/2] HID: hid-logitech-hidpp: Report battery voltage
Date: Tue,  4 Jun 2019 19:28:26 -0400
Message-ID: <20190604232827.26008-1-pedro@pedrovanzella.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Pedro Vanzella <pedro@pedrovanzella.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Newer devices have a feature with id 0x1001 that reports the battery
voltage instead of the old feature with id 0x1000 that reports a
percentage.

This patch fetches and decodes this data for all devices that
support it.

Signed-off-by: Pedro Vanzella <pedro@pedrovanzella.com>
---
 drivers/hid/hid-logitech-hidpp.c | 108 ++++++++++++++++++++++++++++++-
 1 file changed, 106 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 72fc9c0566db..e68ea44b0d24 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -91,6 +91,7 @@ MODULE_PARM_DESC(disable_tap_to_click,
 #define HIDPP_CAPABILITY_HIDPP20_BATTERY	BIT(1)
 #define HIDPP_CAPABILITY_BATTERY_MILEAGE	BIT(2)
 #define HIDPP_CAPABILITY_BATTERY_LEVEL_STATUS	BIT(3)
+#define HIDPP_CAPABILITY_BATTERY_VOLTAGE	BIT(4)
 
 /*
  * There are two hidpp protocols in use, the first version hidpp10 is known
@@ -139,12 +140,14 @@ struct hidpp_report {
 struct hidpp_battery {
 	u8 feature_index;
 	u8 solar_feature_index;
+	u8 voltage_feature_index;
 	struct power_supply_desc desc;
 	struct power_supply *ps;
 	char name[64];
 	int status;
 	int capacity;
 	int level;
+	int voltage; /* in millivolts */
 	bool online;
 };
 
@@ -1223,6 +1226,93 @@ static int hidpp20_battery_event(struct hidpp_device *hidpp,
 	return 0;
 }
 
+/* -------------------------------------------------------------------------- */
+/* 0x1001: Battery voltage                                                    */
+/* -------------------------------------------------------------------------- */
+
+#define HIDPP_PAGE_BATTERY_VOLTAGE 0x1001
+
+#define CMD_BATTERY_VOLTAGE_GET_BATTERY_VOLTAGE 0x00
+
+static int hidpp20_battery_map_status_voltage(u8 data[3], int *voltage)
+{
+	int status;
+
+	switch (data[2]) {
+	case 0x00: /* discharging */
+		status = POWER_SUPPLY_STATUS_DISCHARGING;
+		break;
+	case 0x10: /* wireless charging */
+	case 0x80: /* charging */
+		status = POWER_SUPPLY_STATUS_CHARGING;
+		break;
+	case 0x81: /* fully charged */
+		status = POWER_SUPPLY_STATUS_FULL;
+		break;
+	default:
+		status = POWER_SUPPLY_STATUS_NOT_CHARGING;
+	}
+
+	*voltage = (data[0] << 8) + data[1];
+
+	return status;
+}
+
+static int hidpp20_battery_get_battery_voltage(struct hidpp_device *hidpp,
+					       u8 feature_index,
+					       int *status, int *voltage)
+{
+	struct hidpp_report response;
+	int ret;
+	u8 *params = (u8 *)response.fap.params;
+
+	ret = hidpp_send_fap_command_sync(hidpp, feature_index,
+					  CMD_BATTERY_VOLTAGE_GET_BATTERY_VOLTAGE,
+					  NULL, 0, &response);
+
+	if (ret > 0) {
+		hid_err(hidpp->hid_dev, "%s: received protocol error 0x%02x\n",
+			__func__, ret);
+		return -EPROTO;
+	}
+	if (ret)
+		return ret;
+
+	hidpp->capabilities |= HIDPP_CAPABILITY_BATTERY_VOLTAGE;
+
+	*status = hidpp20_battery_map_status_voltage(params, voltage);
+
+	return 0;
+}
+
+static int hidpp20_query_battery_voltage_info(struct hidpp_device *hidpp)
+{
+	u8 feature_type;
+	int ret;
+	int status, voltage;
+
+	if (hidpp->battery.voltage_feature_index == 0xff) {
+		ret = hidpp_root_get_feature(hidpp, HIDPP_PAGE_BATTERY_VOLTAGE,
+					     &hidpp->battery.voltage_feature_index,
+					     &feature_type);
+		if (ret)
+			return ret;
+	}
+
+	ret = hidpp20_battery_get_battery_voltage(hidpp,
+						  hidpp->battery.voltage_feature_index,
+						  &status, &voltage);
+
+	if (ret)
+		return ret;
+
+	hidpp->battery.status = status;
+	hidpp->battery.voltage = voltage;
+	hidpp->battery.online = status != POWER_SUPPLY_STATUS_NOT_CHARGING;
+
+	return 0;
+}
+
 static enum power_supply_property hidpp_battery_props[] = {
 	POWER_SUPPLY_PROP_ONLINE,
 	POWER_SUPPLY_PROP_STATUS,
@@ -1232,6 +1322,7 @@ static enum power_supply_property hidpp_battery_props[] = {
 	POWER_SUPPLY_PROP_SERIAL_NUMBER,
 	0, /* placeholder for POWER_SUPPLY_PROP_CAPACITY, */
 	0, /* placeholder for POWER_SUPPLY_PROP_CAPACITY_LEVEL, */
+	0, /* placeholder for POWER_SUPPLY_PROP_VOLTAGE_NOW, */
 };
 
 static int hidpp_battery_get_property(struct power_supply *psy,
@@ -1269,6 +1360,9 @@ static int hidpp_battery_get_property(struct power_supply *psy,
 		case POWER_SUPPLY_PROP_SERIAL_NUMBER:
 			val->strval = hidpp->hid_dev->uniq;
 			break;
+		case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+			val->intval = hidpp->battery.voltage;
+			break;
 		default:
 			ret = -EINVAL;
 			break;
@@ -3208,12 +3302,16 @@ static int hidpp_initialize_battery(struct hidpp_device *hidpp)
 
 	hidpp->battery.feature_index = 0xff;
 	hidpp->battery.solar_feature_index = 0xff;
+	hidpp->battery.voltage_feature_index = 0xff;
 
 	if (hidpp->protocol_major >= 2) {
 		if (hidpp->quirks & HIDPP_QUIRK_CLASS_K750)
 			ret = hidpp_solar_request_battery_event(hidpp);
-		else
+		else {
 			ret = hidpp20_query_battery_info(hidpp);
+			if (ret)
+				ret = hidpp20_query_battery_voltage_info(hidpp);
+		}
 
 		if (ret)
 			return ret;
@@ -3238,7 +3336,7 @@ static int hidpp_initialize_battery(struct hidpp_device *hidpp)
 	if (!battery_props)
 		return -ENOMEM;
 
-	num_battery_props = ARRAY_SIZE(hidpp_battery_props) - 2;
+	num_battery_props = ARRAY_SIZE(hidpp_battery_props) - 3;
 
 	if (hidpp->capabilities & HIDPP_CAPABILITY_BATTERY_MILEAGE)
 		battery_props[num_battery_props++] =
@@ -3248,6 +3346,10 @@ static int hidpp_initialize_battery(struct hidpp_device *hidpp)
 		battery_props[num_battery_props++] =
 				POWER_SUPPLY_PROP_CAPACITY_LEVEL;
 
+	if (hidpp->capabilities & HIDPP_CAPABILITY_BATTERY_VOLTAGE)
+		battery_props[num_battery_props++] =
+			POWER_SUPPLY_PROP_VOLTAGE_NOW;
+
 	battery = &hidpp->battery;
 
 	n = atomic_inc_return(&battery_no) - 1;
@@ -3412,6 +3514,8 @@ static void hidpp_connect_event(struct hidpp_device *hidpp)
 			hidpp10_query_battery_status(hidpp);
 	} else if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP20_BATTERY) {
 		hidpp20_query_battery_info(hidpp);
+		if (hidpp->capabilities & HIDPP_CAPABILITY_BATTERY_VOLTAGE)
+			hidpp20_query_battery_voltage_info(hidpp);
 	}
 	if (hidpp->battery.ps)
 		power_supply_changed(hidpp->battery.ps);
-- 
2.21.0

From: Pedro Vanzella <pedro@pedrovanzella.com>
Subject: [PATCH v2 2/4] HID: hid-logitech-hidpp: add function to query battery voltage
Date: Wed,  5 Jun 2019 15:45:31 -0400
Message-ID: <20190605194533.18717-3-pedro@pedrovanzella.com>
References: <20190605194533.18717-1-pedro@pedrovanzella.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190605194533.18717-1-pedro@pedrovanzella.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Pedro Vanzella <pedro@pedrovanzella.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

When the device is brought up, if it's one of the devices we know
supports battery voltage checking, figure out the feature index
and get the battery voltage and status.

If everything went correctly, record the fact that we're capable
of querying battery voltage.

Signed-off-by: Pedro Vanzella <pedro@pedrovanzella.com>
---
 drivers/hid/hid-logitech-hidpp.c | 94 ++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 8b38c14725b8..31e99363ab65 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -92,6 +92,7 @@ MODULE_PARM_DESC(disable_tap_to_click,
 #define HIDPP_CAPABILITY_HIDPP20_BATTERY	BIT(1)
 #define HIDPP_CAPABILITY_BATTERY_MILEAGE	BIT(2)
 #define HIDPP_CAPABILITY_BATTERY_LEVEL_STATUS	BIT(3)
+#define HIDPP_CAPABILITY_BATTERY_VOLTAGE	BIT(4)
 
 /*
  * There are two hidpp protocols in use, the first version hidpp10 is known
@@ -140,12 +141,14 @@ struct hidpp_report {
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
 
@@ -1224,6 +1227,92 @@ static int hidpp20_battery_event(struct hidpp_device *hidpp,
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
 static enum power_supply_property hidpp_battery_props[] = {
 	POWER_SUPPLY_PROP_ONLINE,
 	POWER_SUPPLY_PROP_STATUS,
@@ -3209,10 +3298,13 @@ static int hidpp_initialize_battery(struct hidpp_device *hidpp)
 
 	hidpp->battery.feature_index = 0xff;
 	hidpp->battery.solar_feature_index = 0xff;
+	hidpp->battery.voltage_feature_index = 0xff;
 
 	if (hidpp->protocol_major >= 2) {
 		if (hidpp->quirks & HIDPP_QUIRK_CLASS_K750)
 			ret = hidpp_solar_request_battery_event(hidpp);
+		else if (hidpp->quirks & HIDPP_QUIRK_BATTERY_VOLTAGE_X1001)
+			ret = hidpp20_query_battery_voltage_info(hidpp);
 		else
 			ret = hidpp20_query_battery_info(hidpp);
 
@@ -3413,6 +3505,8 @@ static void hidpp_connect_event(struct hidpp_device *hidpp)
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

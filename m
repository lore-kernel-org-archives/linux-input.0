From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 09/15] HID: logitech-hidpp: enable HID++ 1.0 battery reporting
Date: Thu,  2 Feb 2017 15:12:23 +0100
Message-ID: <20170202141229.17322-10-benjamin.tissoires@redhat.com>
References: <20170202141229.17322-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170202141229.17322-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>, Peter Hutterer <peter.hutterer@who-t.net>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Olivier Gay <ogay@logitech.com>, Simon Wood <simon@mungewell.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Also enable battery reporting for HID++ 1.0 devices through 2 registers:
0x07: battery status -> reports only 4 levels (critical, low, good, full)
0x0D: battery mileage -> reports true pourcentage

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

no changes in v2
---
 drivers/hid/hid-logitech-hidpp.c | 209 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 208 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index ec3f47c..1d7dde9 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -393,6 +393,198 @@ static void hidpp_prefix_name(char **name, int name_length)
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
+		level = 5;
+		break;
+	case 3 ... 4:
+		level = 20;
+		break;
+	case 5 ... 6:
+		level = 55;
+		break;
+	case 7:
+		level = 90;
+		break;
+	default:
+		level = 0;
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
+	/*
+	 * 0x01...0x1F = reserved (not charging)
+	 * 0x20 = unknown
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
+	int ret;
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
+
+	hidpp->battery.status =
+		hidpp10_battery_status_map_status(response.rap.params[1]);
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
+	int ret;
+
+	ret = hidpp_send_rap_command_sync(hidpp,
+					REPORT_ID_HIDPP_SHORT,
+					HIDPP_GET_REGISTER,
+					HIDPP_REG_BATTERY_MILEAGE,
+					NULL, 0, &response);
+	if (ret)
+		return ret;
+
+	hidpp->battery.level = response.rap.params[0];
+
+	hidpp->battery.status =
+		hidpp10_battery_mileage_map_status(response.rap.params[2]);
+
+	return 0;
+}
+
+static int hidpp10_battery_event(struct hidpp_device *hidpp, u8 *data, int size)
+{
+	struct hidpp_report *report = (struct hidpp_report *)data;
+	int status, level;
+	bool changed;
+
+	if (report->report_id != REPORT_ID_HIDPP_SHORT)
+		return 0;
+
+	switch (report->rap.reg_address) {
+	case HIDPP_REG_BATTERY_STATUS:
+		level = hidpp10_battery_status_map_level(report->rap.params[0]);
+		status = hidpp10_battery_status_map_status(report->rap.params[1]);
+		break;
+	case HIDPP_REG_BATTERY_MILEAGE:
+		level = report->rap.params[0];
+		status = hidpp10_battery_mileage_map_status(report->rap.params[2]);
+		break;
+	default:
+		return 0;
+	}
+
+	changed = level != hidpp->battery.level ||
+		  status != hidpp->battery.status;
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
 #define DEVICE_NAME					0x40
 
@@ -2340,6 +2532,12 @@ static int hidpp_raw_event(struct hid_device *hdev, struct hid_report *report,
 			return ret;
 	}
 
+	if (hidpp->quirks & HIDPP_QUIRK_HIDPP10_BATTERY) {
+		ret = hidpp10_battery_event(hidpp, data, size);
+		if (ret != 0)
+			return ret;
+	}
+
 	if (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP)
 		return wtp_raw_event(hdev, data, size);
 	else if (hidpp->quirks & HIDPP_QUIRK_CLASS_M560)
@@ -2373,7 +2571,16 @@ static int hidpp_initialize_battery(struct hidpp_device *hidpp)
 			return ret;
 		hidpp->quirks |= HIDPP_QUIRK_HIDPP20_BATTERY;
 	} else {
-		return -ENOENT;
+		ret = hidpp10_enable_battery_reporting(hidpp);
+		if (ret)
+			return -ENOENT;
+		ret = hidpp10_query_battery_status(hidpp);
+		if (ret) {
+			ret = hidpp10_query_battery_mileage(hidpp);
+			if (ret)
+				return -ENOENT;
+		}
+		hidpp->quirks |= HIDPP_QUIRK_HIDPP10_BATTERY;
 	}
 
 	battery = &hidpp->battery;
-- 
2.9.3

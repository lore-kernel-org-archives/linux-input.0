From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: [PATCH 1/2] HID: logitech-hidpp: add battery support for HID++ 2.0 devices
Date: Wed, 29 Jun 2016 19:28:01 +1000
Message-ID: <1467192482-2723-1-git-send-email-peter.hutterer@who-t.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:36676 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846AbcF2JbM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jun 2016 05:31:12 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Nestor Lopez Casado <nlopezcasad@logitech.com>
Cc: Peter Hutterer <peter.hutterer@who-t.net>

If the 0x1000 Unified Battery Level Status feature exists, expose the battery
level.

The main drawback is that while a device is plugged in its battery level is 0.
To avoid exposing that as 0% charge we make up a number based on the charging
status.

Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-logitech-hidpp.c | 238 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 237 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 2e2515a..1ead9f6 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -62,6 +62,8 @@ MODULE_PARM_DESC(disable_tap_to_click,
 #define HIDPP_QUIRK_WTP_PHYSICAL_BUTTONS	BIT(22)
 #define HIDPP_QUIRK_NO_HIDINPUT			BIT(23)
 #define HIDPP_QUIRK_FORCE_OUTPUT_REPORTS	BIT(24)
+#define HIDPP_QUIRK_HIDPP20_BATTERY		BIT(25)
+#define HIDPP_QUIRK_HIDPP10_BATTERY		BIT(26)
 
 #define HIDPP_QUIRK_DELAYED_INIT		(HIDPP_QUIRK_NO_HIDINPUT | \
 						 HIDPP_QUIRK_CONNECT_EVENTS)
@@ -110,6 +112,15 @@ struct hidpp_report {
 	};
 } __packed;
 
+struct hidpp_battery {
+	u8 feature_index;
+	struct power_supply_desc desc;
+	struct power_supply *ps;
+	char name[64];
+	int status;
+	int level;
+};
+
 struct hidpp_device {
 	struct hid_device *hid_dev;
 	struct mutex send_mutex;
@@ -128,8 +139,9 @@ struct hidpp_device {
 	struct input_dev *delayed_input;
 
 	unsigned long quirks;
-};
 
+	struct hidpp_battery battery;
+};
 
 /* HID++ 1.0 error codes */
 #define HIDPP_ERROR				0x8f
@@ -607,6 +619,222 @@ static char *hidpp_get_device_name(struct hidpp_device *hidpp)
 }
 
 /* -------------------------------------------------------------------------- */
+/* 0x1000: Battery level status                                               */
+/* -------------------------------------------------------------------------- */
+
+#define HIDPP_PAGE_BATTERY_LEVEL_STATUS				0x1000
+
+#define CMD_BATTERY_LEVEL_STATUS_GET_BATTERY_LEVEL_STATUS	0x00
+#define CMD_BATTERY_LEVEL_STATUS_GET_BATTERY_CAPABILITY		0x10
+
+#define EVENT_BATTERY_LEVEL_STATUS_BROADCAST			0x00
+
+static int hidpp20_batterylevel_map_status_level(u8 data[3], int *level,
+						 int *next_level)
+{
+	int status;
+	int level_override;
+
+	*level = data[0];
+	*next_level = data[1];
+
+	/* When discharging, we can rely on the device reported level.
+	 * For all other states the device reports level 0 (unknown). Make up
+	 * a number instead
+	 */
+	switch (data[2]) {
+		case 0: /* discharging (in use) */
+			status = POWER_SUPPLY_STATUS_DISCHARGING;
+			level_override = 0;
+			break;
+		case 1: /* recharging */
+			status = POWER_SUPPLY_STATUS_CHARGING;
+			level_override = 80;
+			break;
+		case 2: /* charge in final stage */
+			status = POWER_SUPPLY_STATUS_CHARGING;
+			level_override = 90;
+			break;
+		case 3: /* charge complete */
+			status = POWER_SUPPLY_STATUS_FULL;
+			level_override = 100;
+			break;
+		case 4: /* recharging below optimal speed */
+			status = POWER_SUPPLY_STATUS_CHARGING;
+			level_override = 50;
+			break;
+		/* 5 = invalid battery type
+		   6 = thermal error
+		   7 = other charging error */
+		default:
+			status = POWER_SUPPLY_STATUS_NOT_CHARGING;
+			level_override = 0;
+			break;
+	}
+
+	if (level_override != 0 && *level == 0)
+		*level = level_override;
+
+	return status;
+}
+
+static int hidpp20_batterylevel_get_battery_level(struct hidpp_device *hidpp,
+						  u8 feature_index,
+						  int *status,
+						  int *level,
+						  int *next_level)
+{
+	struct hidpp_report response;
+	int ret;
+	u8 *params = (u8 *)response.fap.params;
+
+	ret = hidpp_send_fap_command_sync(hidpp, feature_index,
+					  CMD_BATTERY_LEVEL_STATUS_GET_BATTERY_LEVEL_STATUS,
+					  NULL, 0, &response);
+	if (ret > 0) {
+		hid_err(hidpp->hid_dev, "%s: received protocol error 0x%02x\n",
+			__func__, ret);
+		return -EPROTO;
+	}
+	if (ret)
+		return ret;
+
+	*status = hidpp20_batterylevel_map_status_level(params, level,
+							next_level);
+
+	return 0;
+}
+
+static int hidpp20_query_battery_info(struct hidpp_device *hidpp)
+{
+	u8 feature_type;
+	int ret;
+	int status, level, next_level;
+
+	if (hidpp->battery.feature_index == 0) {
+		ret = hidpp_root_get_feature(hidpp,
+					     HIDPP_PAGE_BATTERY_LEVEL_STATUS,
+					     &hidpp->battery.feature_index,
+					     &feature_type);
+		if (ret)
+			return ret;
+	}
+
+	ret = hidpp20_batterylevel_get_battery_level(hidpp,
+						     hidpp->battery.feature_index,
+						     &status, &level, &next_level);
+	if (ret)
+		return ret;
+
+	hidpp->battery.status = status;
+	hidpp->battery.level = level;
+
+	return 0;
+}
+
+static int hidpp20_battery_event(struct hidpp_device *hidpp,
+				 u8 *data, int size)
+{
+	struct hidpp_report *report = (struct hidpp_report *)data;
+	int status, level, next_level;
+	bool changed;
+
+	if (report->fap.feature_index != hidpp->battery.feature_index ||
+	    report->fap.funcindex_clientid != EVENT_BATTERY_LEVEL_STATUS_BROADCAST)
+		return 0;
+
+	status = hidpp20_batterylevel_map_status_level(report->fap.params,
+						       &level, &next_level);
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
+static enum power_supply_property hidpp_battery_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_CAPACITY,
+};
+
+static int hidpp_battery_get_property(struct power_supply *psy,
+				      enum power_supply_property psp,
+				      union power_supply_propval *val)
+{
+	struct hidpp_device *hidpp = power_supply_get_drvdata(psy);
+	int ret = 0;
+
+	switch(psp) {
+		case POWER_SUPPLY_PROP_STATUS:
+			val->intval = hidpp->battery.status;
+			break;
+		case POWER_SUPPLY_PROP_CAPACITY:
+			val->intval = hidpp->battery.level;
+			break;
+		default:
+			ret = -EINVAL;
+			break;
+	}
+
+	return ret;
+}
+
+static int hidpp20_initialize_battery(struct hidpp_device *hidpp)
+{
+	static atomic_t battery_no = ATOMIC_INIT(0);
+	struct power_supply_config cfg = { .drv_data = hidpp };
+	struct power_supply_desc *desc = &hidpp->battery.desc;
+	struct hidpp_battery *battery;
+	unsigned long n;
+	int ret;
+
+	ret = hidpp20_query_battery_info(hidpp);
+	if (ret)
+		return ret;
+
+	battery = &hidpp->battery;
+
+	n = atomic_inc_return(&battery_no) - 1;
+	desc->properties = hidpp_battery_props;
+	desc->num_properties = ARRAY_SIZE(hidpp_battery_props);
+	desc->get_property = hidpp_battery_get_property;
+	sprintf(battery->name, "hidpp_battery_%ld", n);
+	desc->name = battery->name;
+	desc->type = POWER_SUPPLY_TYPE_BATTERY;
+	desc->use_for_apm = 0;
+
+	battery->ps = devm_power_supply_register(&hidpp->hid_dev->dev,
+						 &battery->desc,
+						 &cfg);
+	if (IS_ERR(battery->ps))
+		return PTR_ERR(battery->ps);
+
+	power_supply_powers(battery->ps, &hidpp->hid_dev->dev);
+
+	return 0;
+}
+
+static int hidpp_initialize_battery(struct hidpp_device *hidpp)
+{
+	int ret;
+
+	if (hidpp->protocol_major >= 2) {
+		ret = hidpp20_initialize_battery(hidpp);
+		if (ret == 0)
+			hidpp->quirks |= HIDPP_QUIRK_HIDPP20_BATTERY;
+	}
+
+	return ret;
+}
+
+/* -------------------------------------------------------------------------- */
 /* 0x6010: Touchpad FW items                                                  */
 /* -------------------------------------------------------------------------- */
 
@@ -2050,6 +2278,12 @@ static int hidpp_raw_event(struct hid_device *hdev, struct hid_report *report,
 	if (ret != 0)
 		return ret;
 
+	if (hidpp->quirks & HIDPP_QUIRK_HIDPP20_BATTERY) {
+		ret = hidpp20_battery_event(hidpp, data, size);
+		if (ret != 0)
+			return ret;
+	}
+
 	if (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP)
 		return wtp_raw_event(hdev, data, size);
 	else if (hidpp->quirks & HIDPP_QUIRK_CLASS_M560)
@@ -2158,6 +2392,8 @@ static void hidpp_connect_event(struct hidpp_device *hidpp)
 			 hidpp->protocol_major, hidpp->protocol_minor);
 	}
 
+	hidpp_initialize_battery(hidpp);
+
 	if (!(hidpp->quirks & HIDPP_QUIRK_NO_HIDINPUT))
 		/* if HID created the input nodes for us, we can stop now */
 		return;
-- 
2.7.4


From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 08/17] HID: logitech-hidpp: add support for battery status for the K750
Date: Tue, 17 Jan 2017 15:35:38 +0100
Message-ID: <20170117143547.30488-9-benjamin.tissoires@redhat.com>
References: <20170117143547.30488-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170117143547.30488-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>, Peter Hutterer <peter.hutterer@who-t.net>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Olivier Gay <ogay@logitech.com>, Simon Wood <simon@mungewell.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The Solar Keyboard uses a different feature to report the battery level.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-logitech-hidpp.c | 86 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 84 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 404b3b8..91ea553 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -56,6 +56,7 @@ MODULE_PARM_DESC(disable_tap_to_click,
 #define HIDPP_QUIRK_CLASS_M560			BIT(1)
 #define HIDPP_QUIRK_CLASS_K400			BIT(2)
 #define HIDPP_QUIRK_CLASS_G920			BIT(3)
+#define HIDPP_QUIRK_CLASS_K750			BIT(4)
 
 /* bits 2..20 are reserved for classes */
 /* #define HIDPP_QUIRK_CONNECT_EVENTS		BIT(21) disabled */
@@ -113,6 +114,7 @@ struct hidpp_report {
 
 struct hidpp_battery {
 	u8 feature_index;
+	u8 solar_feature_index;
 	struct power_supply_desc desc;
 	struct power_supply *ps;
 	char name[64];
@@ -704,7 +706,7 @@ static int hidpp20_query_battery_info(struct hidpp_device *hidpp)
 	int ret;
 	int status, level, next_level;
 
-	if (hidpp->battery.feature_index == 0) {
+	if (hidpp->battery.feature_index == 0xff) {
 		ret = hidpp_root_get_feature(hidpp,
 					     HIDPP_PAGE_BATTERY_LEVEL_STATUS,
 					     &hidpp->battery.feature_index,
@@ -807,6 +809,72 @@ static int hidpp_battery_get_property(struct power_supply *psy,
 }
 
 /* -------------------------------------------------------------------------- */
+/* 0x4301: Solar Keyboard                                                     */
+/* -------------------------------------------------------------------------- */
+
+#define HIDPP_PAGE_SOLAR_KEYBOARD			0x4301
+
+#define CMD_SOLAR_SET_LIGHT_MEASURE			0x00
+
+#define EVENT_SOLAR_BATTERY_BROADCAST			0x00
+#define EVENT_SOLAR_BATTERY_LIGHT_MEASURE		0x10
+#define EVENT_SOLAR_CHECK_LIGHT_BUTTON			0x20
+
+static int hidpp_solar_request_battery_event(struct hidpp_device *hidpp)
+{
+	struct hidpp_report response;
+	u8 params[2] = { 3, 4 };
+	u8 feature_type;
+	int ret;
+
+	if (hidpp->battery.feature_index == 0xff) {
+		ret = hidpp_root_get_feature(hidpp,
+					     HIDPP_PAGE_SOLAR_KEYBOARD,
+					     &hidpp->battery.solar_feature_index,
+					     &feature_type);
+		if (ret)
+			return ret;
+	}
+
+	ret = hidpp_send_fap_command_sync(hidpp,
+					  hidpp->battery.solar_feature_index,
+					  CMD_SOLAR_SET_LIGHT_MEASURE,
+					  params, 2, &response);
+	if (ret > 0) {
+		hid_err(hidpp->hid_dev, "%s: received protocol error 0x%02x\n",
+			__func__, ret);
+		return -EPROTO;
+	}
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int hidpp_solar_battery_event(struct hidpp_device *hidpp,
+				     u8 *data, int size)
+{
+	struct hidpp_report *report = (struct hidpp_report *)data;
+	int level;
+
+	if (report->fap.feature_index != hidpp->battery.solar_feature_index ||
+	    !(report->fap.funcindex_clientid == EVENT_SOLAR_BATTERY_BROADCAST ||
+	      report->fap.funcindex_clientid == EVENT_SOLAR_BATTERY_LIGHT_MEASURE ||
+	      report->fap.funcindex_clientid == EVENT_SOLAR_CHECK_LIGHT_BUTTON))
+		return 0;
+
+	level = report->fap.params[0];
+
+	if (level != hidpp->battery.level) {
+		hidpp->battery.level = level;
+		if (hidpp->battery.ps)
+			power_supply_changed(hidpp->battery.ps);
+	}
+
+	return 0;
+}
+
+/* -------------------------------------------------------------------------- */
 /* 0x6010: Touchpad FW items                                                  */
 /* -------------------------------------------------------------------------- */
 
@@ -2253,6 +2321,9 @@ static int hidpp_raw_event(struct hid_device *hdev, struct hid_report *report,
 		ret = hidpp20_battery_event(hidpp, data, size);
 		if (ret != 0)
 			return ret;
+		ret = hidpp_solar_battery_event(hidpp, data, size);
+		if (ret != 0)
+			return ret;
 	}
 
 	if (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP)
@@ -2275,8 +2346,15 @@ static int hidpp_initialize_battery(struct hidpp_device *hidpp)
 	if (hidpp->battery.ps)
 		return 0;
 
+	hidpp->battery.feature_index = 0xff;
+	hidpp->battery.solar_feature_index = 0xff;
+
 	if (hidpp->protocol_major >= 2) {
-		ret = hidpp20_query_battery_info(hidpp);
+		if (hidpp->quirks & HIDPP_QUIRK_CLASS_K750)
+			ret = hidpp_solar_request_battery_event(hidpp);
+		else
+			ret = hidpp20_query_battery_info(hidpp);
+
 		if (ret)
 			return ret;
 		hidpp->quirks |= HIDPP_QUIRK_HIDPP20_BATTERY;
@@ -2605,6 +2683,10 @@ static const struct hid_device_id hidpp_devices[] = {
 	  HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
 		USB_VENDOR_ID_LOGITECH, 0x4024),
 	  .driver_data = HIDPP_QUIRK_CLASS_K400 },
+	{ /* Solar Keyboard Logitech K750 */
+	  HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
+		USB_VENDOR_ID_LOGITECH, 0x4002),
+	  .driver_data = HIDPP_QUIRK_CLASS_K750 },
 
 	{ HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
 		USB_VENDOR_ID_LOGITECH, HID_ANY_ID)},
-- 
2.9.3

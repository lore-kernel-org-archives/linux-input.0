From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 17/19] HID: logitech-hidpp: add support for battery status for the K750
Date: Mon, 27 Mar 2017 16:59:37 +0200
Message-ID: <20170327145939.29824-18-benjamin.tissoires@redhat.com>
References: <20170327145939.29824-1-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:22248 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753578AbdC0PAm (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 27 Mar 2017 11:00:42 -0400
In-Reply-To: <20170327145939.29824-1-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

The Solar Keyboard uses a different feature to report the battery level.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

changes in v3:
- fixed online status

changes in v2:
* update state according to lux information
* do not update Lux if the event does not contain lux information
---
 drivers/hid/hid-logitech-hidpp.c | 115 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 113 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index d7dc458..bb40e5d 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -56,6 +56,7 @@ MODULE_PARM_DESC(disable_tap_to_click,
 #define HIDPP_QUIRK_CLASS_M560			BIT(1)
 #define HIDPP_QUIRK_CLASS_K400			BIT(2)
 #define HIDPP_QUIRK_CLASS_G920			BIT(3)
+#define HIDPP_QUIRK_CLASS_K750			BIT(4)
 
 /* bits 2..20 are reserved for classes */
 /* #define HIDPP_QUIRK_CONNECT_EVENTS		BIT(21) disabled */
@@ -117,6 +118,7 @@ struct hidpp_report {
 
 struct hidpp_battery {
 	u8 feature_index;
+	u8 solar_feature_index;
 	struct power_supply_desc desc;
 	struct power_supply *ps;
 	char name[64];
@@ -809,7 +811,7 @@ static int hidpp20_query_battery_info(struct hidpp_device *hidpp)
 	int ret;
 	int status, capacity, next_capacity, level;
 
-	if (hidpp->battery.feature_index == 0) {
+	if (hidpp->battery.feature_index == 0xff) {
 		ret = hidpp_root_get_feature(hidpp,
 					     HIDPP_PAGE_BATTERY_LEVEL_STATUS,
 					     &hidpp->battery.feature_index,
@@ -930,6 +932,101 @@ static int hidpp_battery_get_property(struct power_supply *psy,
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
+	u8 params[2] = { 1, 1 };
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
+	hidpp->capabilities |= HIDPP_CAPABILITY_BATTERY_MILEAGE;
+
+	return 0;
+}
+
+static int hidpp_solar_battery_event(struct hidpp_device *hidpp,
+				     u8 *data, int size)
+{
+	struct hidpp_report *report = (struct hidpp_report *)data;
+	int capacity, lux, status;
+	u8 function;
+
+	function = report->fap.funcindex_clientid;
+
+
+	if (report->fap.feature_index != hidpp->battery.solar_feature_index ||
+	    !(function == EVENT_SOLAR_BATTERY_BROADCAST ||
+	      function == EVENT_SOLAR_BATTERY_LIGHT_MEASURE ||
+	      function == EVENT_SOLAR_CHECK_LIGHT_BUTTON))
+		return 0;
+
+	capacity = report->fap.params[0];
+
+	switch (function) {
+	case EVENT_SOLAR_BATTERY_LIGHT_MEASURE:
+		lux = (report->fap.params[1] << 8) | report->fap.params[2];
+		if (lux > 200)
+			status = POWER_SUPPLY_STATUS_CHARGING;
+		else
+			status = POWER_SUPPLY_STATUS_DISCHARGING;
+		break;
+	case EVENT_SOLAR_CHECK_LIGHT_BUTTON:
+	default:
+		if (capacity < hidpp->battery.capacity)
+			status = POWER_SUPPLY_STATUS_DISCHARGING;
+		else
+			status = POWER_SUPPLY_STATUS_CHARGING;
+
+	}
+
+	if (capacity == 100)
+		status = POWER_SUPPLY_STATUS_FULL;
+
+	hidpp->battery.online = true;
+	if (capacity != hidpp->battery.capacity ||
+	    status != hidpp->battery.status) {
+		hidpp->battery.capacity = capacity;
+		hidpp->battery.status = status;
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
 
@@ -2326,6 +2423,9 @@ static int hidpp_raw_hidpp_event(struct hidpp_device *hidpp, u8 *data,
 		ret = hidpp20_battery_event(hidpp, data, size);
 		if (ret != 0)
 			return ret;
+		ret = hidpp_solar_battery_event(hidpp, data, size);
+		if (ret != 0)
+			return ret;
 	}
 
 	return 0;
@@ -2392,8 +2492,15 @@ static int hidpp_initialize_battery(struct hidpp_device *hidpp)
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
 		hidpp->capabilities |= HIDPP_CAPABILITY_HIDPP20_BATTERY;
@@ -2751,6 +2858,10 @@ static const struct hid_device_id hidpp_devices[] = {
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


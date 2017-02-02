From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 06/15] HID: logitech-hidpp: create the battery for all types of HID++ devices
Date: Thu,  2 Feb 2017 15:12:20 +0100
Message-ID: <20170202141229.17322-7-benjamin.tissoires@redhat.com>
References: <20170202141229.17322-1-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34614 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751143AbdBBOMy (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 2 Feb 2017 09:12:54 -0500
In-Reply-To: <20170202141229.17322-1-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>, Peter Hutterer <peter.hutterer@who-t.net>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Olivier Gay <ogay@logitech.com>, Simon Wood <simon@mungewell.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

The creation of the power_supply should not be in a HID++ 2.0 specific
function.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

no changes in v2
---
 drivers/hid/hid-logitech-hidpp.c | 94 ++++++++++++++++++----------------------
 1 file changed, 43 insertions(+), 51 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 6124481..ef7ef9e 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -806,57 +806,6 @@ static int hidpp_battery_get_property(struct power_supply *psy,
 	return ret;
 }
 
-static int hidpp20_initialize_battery(struct hidpp_device *hidpp)
-{
-	static atomic_t battery_no = ATOMIC_INIT(0);
-	struct power_supply_config cfg = { .drv_data = hidpp };
-	struct power_supply_desc *desc = &hidpp->battery.desc;
-	struct hidpp_battery *battery;
-	unsigned long n;
-	int ret;
-
-	ret = hidpp20_query_battery_info(hidpp);
-	if (ret)
-		return ret;
-
-	battery = &hidpp->battery;
-
-	n = atomic_inc_return(&battery_no) - 1;
-	desc->properties = hidpp_battery_props;
-	desc->num_properties = ARRAY_SIZE(hidpp_battery_props);
-	desc->get_property = hidpp_battery_get_property;
-	sprintf(battery->name, "hidpp_battery_%ld", n);
-	desc->name = battery->name;
-	desc->type = POWER_SUPPLY_TYPE_BATTERY;
-	desc->use_for_apm = 0;
-
-	battery->ps = devm_power_supply_register(&hidpp->hid_dev->dev,
-						 &battery->desc,
-						 &cfg);
-	if (IS_ERR(battery->ps))
-		return PTR_ERR(battery->ps);
-
-	power_supply_powers(battery->ps, &hidpp->hid_dev->dev);
-
-	return 0;
-}
-
-static int hidpp_initialize_battery(struct hidpp_device *hidpp)
-{
-	int ret;
-
-	if (hidpp->battery.ps)
-		return 0;
-
-	if (hidpp->protocol_major >= 2) {
-		ret = hidpp20_initialize_battery(hidpp);
-		if (ret == 0)
-			hidpp->quirks |= HIDPP_QUIRK_HIDPP20_BATTERY;
-	}
-
-	return ret;
-}
-
 /* -------------------------------------------------------------------------- */
 /* 0x6010: Touchpad FW items                                                  */
 /* -------------------------------------------------------------------------- */
@@ -2314,6 +2263,49 @@ static int hidpp_raw_event(struct hid_device *hdev, struct hid_report *report,
 	return 0;
 }
 
+static int hidpp_initialize_battery(struct hidpp_device *hidpp)
+{
+	static atomic_t battery_no = ATOMIC_INIT(0);
+	struct power_supply_config cfg = { .drv_data = hidpp };
+	struct power_supply_desc *desc = &hidpp->battery.desc;
+	struct hidpp_battery *battery;
+	unsigned long n;
+	int ret;
+
+	if (hidpp->battery.ps)
+		return 0;
+
+	if (hidpp->protocol_major >= 2) {
+		ret = hidpp20_query_battery_info(hidpp);
+		if (ret)
+			return ret;
+		hidpp->quirks |= HIDPP_QUIRK_HIDPP20_BATTERY;
+	} else {
+		return -ENOENT;
+	}
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
+	return ret;
+}
+
 static void hidpp_overwrite_name(struct hid_device *hdev, bool use_unifying)
 {
 	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
-- 
2.9.3


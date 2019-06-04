From: Pedro Vanzella <pedro@pedrovanzella.com>
Subject: [PATCH 2/2] HID: hid-logitech-hidpp: subscribe to battery voltage change events
Date: Tue,  4 Jun 2019 19:28:27 -0400
Message-ID: <20190604232827.26008-2-pedro@pedrovanzella.com>
References: <20190604232827.26008-1-pedro@pedrovanzella.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190604232827.26008-1-pedro@pedrovanzella.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Pedro Vanzella <pedro@pedrovanzella.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Same as with the other ways of reporting battery status,
fetch the battery voltage on raw hidpp events.

Signed-off-by: Pedro Vanzella <pedro@pedrovanzella.com>
---
 drivers/hid/hid-logitech-hidpp.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index e68ea44b0d24..1eee206a0aed 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -1313,6 +1313,35 @@ static int hidpp20_query_battery_voltage_info(struct hidpp_device *hidpp)
 	return 0;
 }
 
+static int hidpp20_battery_voltage_event(struct hidpp_device *hidpp,
+					 u8 *data, int size)
+{
+	struct hidpp_report *report = (struct hidpp_report *)data;
+	int status, voltage;
+	bool changed;
+
+	if (report->fap.feature_index != hidpp->battery.voltage_feature_index ||
+	    report->fap.funcindex_clientid !=
+		    EVENT_BATTERY_LEVEL_STATUS_BROADCAST)
+		return 0;
+
+	status = hidpp20_battery_map_status_voltage(report->fap.params,
+						    &voltage);
+
+	hidpp->battery.online = status != POWER_SUPPLY_STATUS_NOT_CHARGING;
+
+	changed = voltage != hidpp->battery.voltage ||
+		  status != hidpp->battery.status;
+
+	if (changed) {
+		hidpp->battery.voltage = voltage;
+		hidpp->battery.status = status;
+		if (hidpp->battery.ps)
+			power_supply_changed(hidpp->battery.ps);
+	}
+	return 0;
+}
+
 static enum power_supply_property hidpp_battery_props[] = {
 	POWER_SUPPLY_PROP_ONLINE,
 	POWER_SUPPLY_PROP_STATUS,
@@ -3181,6 +3210,9 @@ static int hidpp_raw_hidpp_event(struct hidpp_device *hidpp, u8 *data,
 		ret = hidpp_solar_battery_event(hidpp, data, size);
 		if (ret != 0)
 			return ret;
+		ret = hidpp20_battery_voltage_event(hidpp, data, size);
+		if (ret != 0)
+			return ret;
 	}
 
 	if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP10_BATTERY) {
-- 
2.21.0

From: Pedro Vanzella <pedro@pedrovanzella.com>
Subject: [PATCH v2 3/4] HID: hid-logitech-hidpp: report battery voltage to the power supply
Date: Wed,  5 Jun 2019 15:45:32 -0400
Message-ID: <20190605194533.18717-4-pedro@pedrovanzella.com>
References: <20190605194533.18717-1-pedro@pedrovanzella.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190605194533.18717-1-pedro@pedrovanzella.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Pedro Vanzella <pedro@pedrovanzella.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

If we know the device supports reading its voltage, report that.

Note that the protocol only gives us the current voltage in millivolts.

Signed-off-by: Pedro Vanzella <pedro@pedrovanzella.com>
---
 drivers/hid/hid-logitech-hidpp.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 31e99363ab65..d6c59b11b9d2 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -1322,6 +1322,7 @@ static enum power_supply_property hidpp_battery_props[] = {
 	POWER_SUPPLY_PROP_SERIAL_NUMBER,
 	0, /* placeholder for POWER_SUPPLY_PROP_CAPACITY, */
 	0, /* placeholder for POWER_SUPPLY_PROP_CAPACITY_LEVEL, */
+	0, /* placeholder for POWER_SUPPLY_PROP_VOLTAGE_NOW, */
 };
 
 static int hidpp_battery_get_property(struct power_supply *psy,
@@ -1359,6 +1360,9 @@ static int hidpp_battery_get_property(struct power_supply *psy,
 		case POWER_SUPPLY_PROP_SERIAL_NUMBER:
 			val->strval = hidpp->hid_dev->uniq;
 			break;
+		case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+			val->intval = hidpp->battery.voltage;
+			break;
 		default:
 			ret = -EINVAL;
 			break;
@@ -3331,7 +3335,7 @@ static int hidpp_initialize_battery(struct hidpp_device *hidpp)
 	if (!battery_props)
 		return -ENOMEM;
 
-	num_battery_props = ARRAY_SIZE(hidpp_battery_props) - 2;
+	num_battery_props = ARRAY_SIZE(hidpp_battery_props) - 3;
 
 	if (hidpp->capabilities & HIDPP_CAPABILITY_BATTERY_MILEAGE)
 		battery_props[num_battery_props++] =
@@ -3341,6 +3345,10 @@ static int hidpp_initialize_battery(struct hidpp_device *hidpp)
 		battery_props[num_battery_props++] =
 				POWER_SUPPLY_PROP_CAPACITY_LEVEL;
 
+	if (hidpp->capabilities & HIDPP_CAPABILITY_BATTERY_VOLTAGE)
+		battery_props[num_battery_props++] =
+			POWER_SUPPLY_PROP_VOLTAGE_NOW;
+
 	battery = &hidpp->battery;
 
 	n = atomic_inc_return(&battery_no) - 1;
-- 
2.21.0

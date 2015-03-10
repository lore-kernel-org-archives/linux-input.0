From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH v6 12/22] power_supply: charger-manager: Use power_supply_*()
 API for accessing function attrs
Date: Tue, 10 Mar 2015 09:27:16 +0100
Message-ID: <1425976046-20973-13-git-send-email-k.kozlowski@samsung.com>
References: <1425976046-20973-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-reply-to: <1425976046-20973-1-git-send-email-k.kozlowski@samsung.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@googlemail.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Darren Hart <dvhart@infradead.org>, Support Opensource <support.opensource@diasemi.com>, Milo Kim <milo.kim@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.orglinux-
Cc: Thomas Gleixner <tglx@linutronix.de>, Pavel Machek <pavel@ucw.cz>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-input@vger.kernel.org

Replace direct calls to power supply function attributes with wrappers.
Wrappers provide safe access in case of unregistering the power
supply (e.g. by removing the driver). Replace:
 - get_property -> power_supply_get_property

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Acked-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Reviewed-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/power/charger-manager.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/power/charger-manager.c b/drivers/power/charger-manager.c
index df27600880b9..a5b86b60d244 100644
--- a/drivers/power/charger-manager.c
+++ b/drivers/power/charger-manager.c
@@ -103,8 +103,8 @@ static bool is_batt_present(struct charger_manager *cm)
 		if (!psy)
 			break;
 
-		ret = psy->get_property(psy,
-				POWER_SUPPLY_PROP_PRESENT, &val);
+		ret = power_supply_get_property(psy, POWER_SUPPLY_PROP_PRESENT,
+				&val);
 		if (ret == 0 && val.intval)
 			present = true;
 		break;
@@ -118,8 +118,8 @@ static bool is_batt_present(struct charger_manager *cm)
 				continue;
 			}
 
-			ret = psy->get_property(psy, POWER_SUPPLY_PROP_PRESENT,
-					&val);
+			ret = power_supply_get_property(psy,
+				POWER_SUPPLY_PROP_PRESENT, &val);
 			if (ret == 0 && val.intval) {
 				present = true;
 				break;
@@ -155,7 +155,8 @@ static bool is_ext_pwr_online(struct charger_manager *cm)
 			continue;
 		}
 
-		ret = psy->get_property(psy, POWER_SUPPLY_PROP_ONLINE, &val);
+		ret = power_supply_get_property(psy, POWER_SUPPLY_PROP_ONLINE,
+				&val);
 		if (ret == 0 && val.intval) {
 			online = true;
 			break;
@@ -183,7 +184,7 @@ static int get_batt_uV(struct charger_manager *cm, int *uV)
 	if (!fuel_gauge)
 		return -ENODEV;
 
-	ret = fuel_gauge->get_property(fuel_gauge,
+	ret = power_supply_get_property(fuel_gauge,
 				POWER_SUPPLY_PROP_VOLTAGE_NOW, &val);
 	if (ret)
 		return ret;
@@ -223,7 +224,8 @@ static bool is_charging(struct charger_manager *cm)
 		}
 
 		/* 2. The charger should be online (ext-power) */
-		ret = psy->get_property(psy, POWER_SUPPLY_PROP_ONLINE, &val);
+		ret = power_supply_get_property(psy, POWER_SUPPLY_PROP_ONLINE,
+				&val);
 		if (ret) {
 			dev_warn(cm->dev, "Cannot read ONLINE value from %s\n",
 				 cm->desc->psy_charger_stat[i]);
@@ -236,7 +238,8 @@ static bool is_charging(struct charger_manager *cm)
 		 * 3. The charger should not be FULL, DISCHARGING,
 		 * or NOT_CHARGING.
 		 */
-		ret = psy->get_property(psy, POWER_SUPPLY_PROP_STATUS, &val);
+		ret = power_supply_get_property(psy, POWER_SUPPLY_PROP_STATUS,
+				&val);
 		if (ret) {
 			dev_warn(cm->dev, "Cannot read STATUS value from %s\n",
 				 cm->desc->psy_charger_stat[i]);
@@ -279,7 +282,7 @@ static bool is_full_charged(struct charger_manager *cm)
 		val.intval = 0;
 
 		/* Not full if capacity of fuel gauge isn't full */
-		ret = fuel_gauge->get_property(fuel_gauge,
+		ret = power_supply_get_property(fuel_gauge,
 				POWER_SUPPLY_PROP_CHARGE_FULL, &val);
 		if (!ret && val.intval > desc->fullbatt_full_capacity)
 			return true;
@@ -296,7 +299,7 @@ static bool is_full_charged(struct charger_manager *cm)
 	if (desc->fullbatt_soc > 0) {
 		val.intval = 0;
 
-		ret = fuel_gauge->get_property(fuel_gauge,
+		ret = power_supply_get_property(fuel_gauge,
 				POWER_SUPPLY_PROP_CAPACITY, &val);
 		if (!ret && val.intval >= desc->fullbatt_soc)
 			return true;
@@ -580,7 +583,7 @@ static int cm_get_battery_temperature_by_psy(struct charger_manager *cm,
 	if (!fuel_gauge)
 		return -ENODEV;
 
-	return fuel_gauge->get_property(fuel_gauge,
+	return power_supply_get_property(fuel_gauge,
 				POWER_SUPPLY_PROP_TEMP,
 				(union power_supply_propval *)temp);
 }
@@ -900,7 +903,7 @@ static int charger_get_property(struct power_supply *psy,
 			ret = -ENODEV;
 			break;
 		}
-		ret = fuel_gauge->get_property(fuel_gauge,
+		ret = power_supply_get_property(fuel_gauge,
 				POWER_SUPPLY_PROP_CURRENT_NOW, val);
 		break;
 	case POWER_SUPPLY_PROP_TEMP:
@@ -919,7 +922,7 @@ static int charger_get_property(struct power_supply *psy,
 			break;
 		}
 
-		ret = fuel_gauge->get_property(fuel_gauge,
+		ret = power_supply_get_property(fuel_gauge,
 					POWER_SUPPLY_PROP_CAPACITY, val);
 		if (ret)
 			break;
@@ -975,7 +978,7 @@ static int charger_get_property(struct power_supply *psy,
 				break;
 			}
 
-			ret = fuel_gauge->get_property(fuel_gauge,
+			ret = power_supply_get_property(fuel_gauge,
 						POWER_SUPPLY_PROP_CHARGE_NOW,
 						val);
 			if (ret) {
@@ -1424,7 +1427,7 @@ static int cm_init_thermal_data(struct charger_manager *cm,
 	int ret;
 
 	/* Verify whether fuel gauge provides battery temperature */
-	ret = fuel_gauge->get_property(fuel_gauge,
+	ret = power_supply_get_property(fuel_gauge,
 					POWER_SUPPLY_PROP_TEMP, &val);
 
 	if (!ret) {
@@ -1718,13 +1721,13 @@ static int charger_manager_probe(struct platform_device *pdev)
 	cm->charger_psy.num_properties = psy_default.num_properties;
 
 	/* Find which optional psy-properties are available */
-	if (!fuel_gauge->get_property(fuel_gauge,
+	if (!power_supply_get_property(fuel_gauge,
 					  POWER_SUPPLY_PROP_CHARGE_NOW, &val)) {
 		cm->charger_psy.properties[cm->charger_psy.num_properties] =
 				POWER_SUPPLY_PROP_CHARGE_NOW;
 		cm->charger_psy.num_properties++;
 	}
-	if (!fuel_gauge->get_property(fuel_gauge,
+	if (!power_supply_get_property(fuel_gauge,
 					  POWER_SUPPLY_PROP_CURRENT_NOW,
 					  &val)) {
 		cm->charger_psy.properties[cm->charger_psy.num_properties] =
-- 
1.9.1

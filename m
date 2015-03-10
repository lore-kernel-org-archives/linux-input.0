From: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v6 16/22] power_supply: charger-manager: Decrement the power
 supply's device reference counter
Date: Tue, 10 Mar 2015 09:27:20 +0100
Message-ID: <1425976046-20973-17-git-send-email-k.kozlowski@samsung.com>
References: <1425976046-20973-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1425976046-20973-1-git-send-email-k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, David Herrmann <dh.herrmann-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, Cezary Jackiewicz <cezary.jackiewicz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Darren Hart <dvhart-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Milo Kim <milo.kim-l0cyMroinI0@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.orglinux-
Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Use power_supply_put() to decrement the power supply's device reference
counter.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Acked-by: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Reviewed-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/power/charger-manager.c | 70 +++++++++++++++++++++++++++--------------
 1 file changed, 47 insertions(+), 23 deletions(-)

diff --git a/drivers/power/charger-manager.c b/drivers/power/charger-manager.c
index 5c47409c6889..e23b7ba2cbd2 100644
--- a/drivers/power/charger-manager.c
+++ b/drivers/power/charger-manager.c
@@ -107,6 +107,7 @@ static bool is_batt_present(struct charger_manager *cm)
 				&val);
 		if (ret == 0 && val.intval)
 			present = true;
+		power_supply_put(psy);
 		break;
 	case CM_CHARGER_STAT:
 		for (i = 0; cm->desc->psy_charger_stat[i]; i++) {
@@ -120,6 +121,7 @@ static bool is_batt_present(struct charger_manager *cm)
 
 			ret = power_supply_get_property(psy,
 				POWER_SUPPLY_PROP_PRESENT, &val);
+			power_supply_put(psy);
 			if (ret == 0 && val.intval) {
 				present = true;
 				break;
@@ -157,6 +159,7 @@ static bool is_ext_pwr_online(struct charger_manager *cm)
 
 		ret = power_supply_get_property(psy, POWER_SUPPLY_PROP_ONLINE,
 				&val);
+		power_supply_put(psy);
 		if (ret == 0 && val.intval) {
 			online = true;
 			break;
@@ -186,6 +189,7 @@ static int get_batt_uV(struct charger_manager *cm, int *uV)
 
 	ret = power_supply_get_property(fuel_gauge,
 				POWER_SUPPLY_PROP_VOLTAGE_NOW, &val);
+	power_supply_put(fuel_gauge);
 	if (ret)
 		return ret;
 
@@ -229,10 +233,13 @@ static bool is_charging(struct charger_manager *cm)
 		if (ret) {
 			dev_warn(cm->dev, "Cannot read ONLINE value from %s\n",
 				 cm->desc->psy_charger_stat[i]);
+			power_supply_put(psy);
 			continue;
 		}
-		if (val.intval == 0)
+		if (val.intval == 0) {
+			power_supply_put(psy);
 			continue;
+		}
 
 		/*
 		 * 3. The charger should not be FULL, DISCHARGING,
@@ -240,6 +247,7 @@ static bool is_charging(struct charger_manager *cm)
 		 */
 		ret = power_supply_get_property(psy, POWER_SUPPLY_PROP_STATUS,
 				&val);
+		power_supply_put(psy);
 		if (ret) {
 			dev_warn(cm->dev, "Cannot read STATUS value from %s\n",
 				 cm->desc->psy_charger_stat[i]);
@@ -267,6 +275,7 @@ static bool is_full_charged(struct charger_manager *cm)
 	struct charger_desc *desc = cm->desc;
 	union power_supply_propval val;
 	struct power_supply *fuel_gauge;
+	bool is_full = false;
 	int ret = 0;
 	int uV;
 
@@ -284,15 +293,19 @@ static bool is_full_charged(struct charger_manager *cm)
 		/* Not full if capacity of fuel gauge isn't full */
 		ret = power_supply_get_property(fuel_gauge,
 				POWER_SUPPLY_PROP_CHARGE_FULL, &val);
-		if (!ret && val.intval > desc->fullbatt_full_capacity)
-			return true;
+		if (!ret && val.intval > desc->fullbatt_full_capacity) {
+			is_full = true;
+			goto out;
+		}
 	}
 
 	/* Full, if it's over the fullbatt voltage */
 	if (desc->fullbatt_uV > 0) {
 		ret = get_batt_uV(cm, &uV);
-		if (!ret && uV >= desc->fullbatt_uV)
-			return true;
+		if (!ret && uV >= desc->fullbatt_uV) {
+			is_full = true;
+			goto out;
+		}
 	}
 
 	/* Full, if the capacity is more than fullbatt_soc */
@@ -301,11 +314,15 @@ static bool is_full_charged(struct charger_manager *cm)
 
 		ret = power_supply_get_property(fuel_gauge,
 				POWER_SUPPLY_PROP_CAPACITY, &val);
-		if (!ret && val.intval >= desc->fullbatt_soc)
-			return true;
+		if (!ret && val.intval >= desc->fullbatt_soc) {
+			is_full = true;
+			goto out;
+		}
 	}
 
-	return false;
+out:
+	power_supply_put(fuel_gauge);
+	return is_full;
 }
 
 /**
@@ -578,14 +595,18 @@ static int cm_get_battery_temperature_by_psy(struct charger_manager *cm,
 					int *temp)
 {
 	struct power_supply *fuel_gauge;
+	int ret;
 
 	fuel_gauge = power_supply_get_by_name(cm->desc->psy_fuel_gauge);
 	if (!fuel_gauge)
 		return -ENODEV;
 
-	return power_supply_get_property(fuel_gauge,
+	ret = power_supply_get_property(fuel_gauge,
 				POWER_SUPPLY_PROP_TEMP,
 				(union power_supply_propval *)temp);
+	power_supply_put(fuel_gauge);
+
+	return ret;
 }
 
 static int cm_get_battery_temperature(struct charger_manager *cm,
@@ -866,7 +887,7 @@ static int charger_get_property(struct power_supply *psy,
 {
 	struct charger_manager *cm = power_supply_get_drvdata(psy);
 	struct charger_desc *desc = cm->desc;
-	struct power_supply *fuel_gauge;
+	struct power_supply *fuel_gauge = NULL;
 	int ret = 0;
 	int uV;
 
@@ -909,18 +930,18 @@ static int charger_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_TEMP_AMBIENT:
 		return cm_get_battery_temperature(cm, &val->intval);
 	case POWER_SUPPLY_PROP_CAPACITY:
-		fuel_gauge = power_supply_get_by_name(cm->desc->psy_fuel_gauge);
-		if (!fuel_gauge) {
-			ret = -ENODEV;
-			break;
-		}
-
 		if (!is_batt_present(cm)) {
 			/* There is no battery. Assume 100% */
 			val->intval = 100;
 			break;
 		}
 
+		fuel_gauge = power_supply_get_by_name(cm->desc->psy_fuel_gauge);
+		if (!fuel_gauge) {
+			ret = -ENODEV;
+			break;
+		}
+
 		ret = power_supply_get_property(fuel_gauge,
 					POWER_SUPPLY_PROP_CAPACITY, val);
 		if (ret)
@@ -995,6 +1016,8 @@ static int charger_get_property(struct power_supply *psy,
 	default:
 		return -EINVAL;
 	}
+	if (fuel_gauge)
+		power_supply_put(fuel_gauge);
 	return ret;
 }
 
@@ -1676,13 +1699,7 @@ static int charger_manager_probe(struct platform_device *pdev)
 				desc->psy_charger_stat[i]);
 			return -ENODEV;
 		}
-	}
-
-	fuel_gauge = power_supply_get_by_name(desc->psy_fuel_gauge);
-	if (!fuel_gauge) {
-		dev_err(&pdev->dev, "Cannot find power supply \"%s\"\n",
-			desc->psy_fuel_gauge);
-		return -ENODEV;
+		power_supply_put(psy);
 	}
 
 	if (desc->polling_interval_ms == 0 ||
@@ -1722,6 +1739,12 @@ static int charger_manager_probe(struct platform_device *pdev)
 	cm->charger_psy_desc.num_properties = psy_default.num_properties;
 
 	/* Find which optional psy-properties are available */
+	fuel_gauge = power_supply_get_by_name(desc->psy_fuel_gauge);
+	if (!fuel_gauge) {
+		dev_err(&pdev->dev, "Cannot find power supply \"%s\"\n",
+			desc->psy_fuel_gauge);
+		return -ENODEV;
+	}
 	if (!power_supply_get_property(fuel_gauge,
 					  POWER_SUPPLY_PROP_CHARGE_NOW, &val)) {
 		cm->charger_psy_desc.properties[cm->charger_psy_desc.num_properties] =
@@ -1741,6 +1764,7 @@ static int charger_manager_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Failed to initialize thermal data\n");
 		cm->desc->measure_battery_temp = false;
 	}
+	power_supply_put(fuel_gauge);
 
 	INIT_DELAYED_WORK(&cm->fullbatt_vchk_work, fullbatt_vchk);
 
-- 
1.9.1

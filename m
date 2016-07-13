From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 29/30] HID: wacom: power_supply: remove ac information
Date: Wed, 13 Jul 2016 18:06:16 +0200
Message-ID: <1468425977-4819-30-git-send-email-benjamin.tissoires@redhat.com>
References: <1468425977-4819-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38729 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752556AbcGMQHh (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Jul 2016 12:07:37 -0400
In-Reply-To: <1468425977-4819-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Aaron Skomra <skomra@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Looks like upowerd is ignoring this since October 2013, so there is
no need to keep this around in the kernel.
And as mentioned in 8aaa592 (linux: Ignore ACs coming from devices) in
the upower tree, "We already have enough information on the device
battery".

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

New in v2
---
 drivers/hid/wacom.h     |  3 ---
 drivers/hid/wacom_sys.c | 49 +------------------------------------------------
 2 files changed, 1 insertion(+), 51 deletions(-)

diff --git a/drivers/hid/wacom.h b/drivers/hid/wacom.h
index 8f8a162..26a8a05 100644
--- a/drivers/hid/wacom.h
+++ b/drivers/hid/wacom.h
@@ -135,11 +135,8 @@ struct wacom_group_leds {
 
 struct wacom_battery {
 	struct power_supply_desc bat_desc;
-	struct power_supply_desc ac_desc;
 	struct power_supply *battery;
-	struct power_supply *ac;
 	char bat_name[WACOM_NAME_MAX];
-	char ac_name[WACOM_NAME_MAX];
 	int battery_capacity;
 	int bat_charging;
 	int bat_connected;
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 792708b..d8f3d3d 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1342,12 +1342,6 @@ static enum power_supply_property wacom_battery_props[] = {
 	POWER_SUPPLY_PROP_CAPACITY
 };
 
-static enum power_supply_property wacom_ac_props[] = {
-	POWER_SUPPLY_PROP_PRESENT,
-	POWER_SUPPLY_PROP_ONLINE,
-	POWER_SUPPLY_PROP_SCOPE,
-};
-
 static int wacom_battery_get_property(struct power_supply *psy,
 				      enum power_supply_property psp,
 				      union power_supply_propval *val)
@@ -1384,38 +1378,14 @@ static int wacom_battery_get_property(struct power_supply *psy,
 	return ret;
 }
 
-static int wacom_ac_get_property(struct power_supply *psy,
-				enum power_supply_property psp,
-				union power_supply_propval *val)
-{
-	struct wacom_battery *battery = power_supply_get_drvdata(psy);
-	int ret = 0;
-
-	switch (psp) {
-	case POWER_SUPPLY_PROP_PRESENT:
-		/* fall through */
-	case POWER_SUPPLY_PROP_ONLINE:
-		val->intval = battery->ps_connected;
-		break;
-	case POWER_SUPPLY_PROP_SCOPE:
-		val->intval = POWER_SUPPLY_SCOPE_DEVICE;
-		break;
-	default:
-		ret = -EINVAL;
-		break;
-	}
-	return ret;
-}
-
 static int __wacom_initialize_battery(struct wacom *wacom,
 				      struct wacom_battery *battery)
 {
 	static atomic_t battery_no = ATOMIC_INIT(0);
 	struct device *dev = &wacom->hdev->dev;
 	struct power_supply_config psy_cfg = { .drv_data = battery, };
-	struct power_supply *ps_bat, *ps_ac;
+	struct power_supply *ps_bat;
 	struct power_supply_desc *bat_desc = &battery->bat_desc;
-	struct power_supply_desc *ac_desc = &battery->ac_desc;
 	unsigned long n;
 	int error;
 
@@ -1432,31 +1402,15 @@ static int __wacom_initialize_battery(struct wacom *wacom,
 	bat_desc->type = POWER_SUPPLY_TYPE_USB;
 	bat_desc->use_for_apm = 0;
 
-	ac_desc->properties = wacom_ac_props;
-	ac_desc->num_properties = ARRAY_SIZE(wacom_ac_props);
-	ac_desc->get_property = wacom_ac_get_property;
-	sprintf(battery->ac_name, "wacom_ac_%ld", n);
-	ac_desc->name = battery->ac_name;
-	ac_desc->type = POWER_SUPPLY_TYPE_MAINS;
-	ac_desc->use_for_apm = 0;
-
 	ps_bat = devm_power_supply_register(dev, bat_desc, &psy_cfg);
 	if (IS_ERR(ps_bat)) {
 		error = PTR_ERR(ps_bat);
 		goto err;
 	}
 
-	ps_ac = devm_power_supply_register(dev, ac_desc, &psy_cfg);
-	if (IS_ERR(ps_ac)) {
-		error = PTR_ERR(ps_ac);
-		goto err;
-	}
-
 	power_supply_powers(ps_bat, &wacom->hdev->dev);
-	power_supply_powers(ps_ac, &wacom->hdev->dev);
 
 	battery->battery = ps_bat;
-	battery->ac = ps_ac;
 
 	devres_close_group(dev, bat_desc);
 	return 0;
@@ -1480,7 +1434,6 @@ static void wacom_destroy_battery(struct wacom *wacom)
 		devres_release_group(&wacom->hdev->dev,
 				     &wacom->battery.bat_desc);
 		wacom->battery.battery = NULL;
-		wacom->battery.ac = NULL;
 	}
 }
 
-- 
2.5.5


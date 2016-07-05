From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 06/27] HID: wacom: switch battery to devres
Date: Tue,  5 Jul 2016 16:39:02 +0200
Message-ID: <1467729563-23318-7-git-send-email-benjamin.tissoires@redhat.com>
References: <1467729563-23318-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467729563-23318-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Aaron Skomra <skomra@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Simplifying the error code paths.
We need to keep wacom_destroy_battery() around for now as the wireless
module and the remotes are using it to dynamically remove the battery
supply on disconnect.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

# Conflicts:
#	drivers/hid/wacom_sys.c
---
 drivers/hid/wacom_sys.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 54f0260..61dcb87e 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1082,11 +1082,16 @@ static int wacom_ac_get_property(struct power_supply *psy,
 static int wacom_initialize_battery(struct wacom *wacom)
 {
 	static atomic_t battery_no = ATOMIC_INIT(0);
+	struct device *dev = &wacom->hdev->dev;
 	struct power_supply_config psy_cfg = { .drv_data = wacom, };
+	struct power_supply_desc *bat_desc = &wacom->battery_desc;
 	unsigned long n;
+	int error;
+
+	if (!devres_open_group(dev, bat_desc, GFP_KERNEL))
+		return -ENOMEM;
 
 	if (wacom->wacom_wac.features.quirks & WACOM_QUIRK_BATTERY) {
-		struct power_supply_desc *bat_desc = &wacom->battery_desc;
 		struct power_supply_desc *ac_desc = &wacom->ac_desc;
 		n = atomic_inc_return(&battery_no) - 1;
 
@@ -1106,33 +1111,40 @@ static int wacom_initialize_battery(struct wacom *wacom)
 		ac_desc->type = POWER_SUPPLY_TYPE_MAINS;
 		ac_desc->use_for_apm = 0;
 
-		wacom->battery = power_supply_register(&wacom->hdev->dev,
-					      &wacom->battery_desc, &psy_cfg);
-		if (IS_ERR(wacom->battery))
-			return PTR_ERR(wacom->battery);
+		wacom->battery = devm_power_supply_register(dev,
+							   &wacom->battery_desc,
+							   &psy_cfg);
+		if (IS_ERR(wacom->battery)) {
+			error = PTR_ERR(wacom->battery);
+			goto err;
+		}
 
 		power_supply_powers(wacom->battery, &wacom->hdev->dev);
 
-		wacom->ac = power_supply_register(&wacom->hdev->dev,
-						  &wacom->ac_desc,
-						  &psy_cfg);
+		wacom->ac = devm_power_supply_register(dev,
+						       &wacom->ac_desc,
+						       &psy_cfg);
 		if (IS_ERR(wacom->ac)) {
-			power_supply_unregister(wacom->battery);
-			return PTR_ERR(wacom->ac);
+			error = PTR_ERR(wacom->ac);
+			goto err;
 		}
 
 		power_supply_powers(wacom->ac, &wacom->hdev->dev);
 	}
 
+	devres_close_group(dev, bat_desc);
 	return 0;
+
+err:
+	devres_release_group(dev, bat_desc);
+	return error;
 }
 
 static void wacom_destroy_battery(struct wacom *wacom)
 {
 	if (wacom->battery) {
-		power_supply_unregister(wacom->battery);
+		devres_release_group(&wacom->hdev->dev, &wacom->battery_desc);
 		wacom->battery = NULL;
-		power_supply_unregister(wacom->ac);
 		wacom->ac = NULL;
 	}
 }
@@ -1731,7 +1743,6 @@ fail_remote:
 fail_leds:
 	wacom_clean_inputs(wacom);
 fail_register_inputs:
-	wacom_destroy_battery(wacom);
 fail_battery:
 	wacom_remove_shared_data(wacom);
 fail_shared_data:
@@ -1920,7 +1931,6 @@ static void wacom_remove(struct hid_device *hdev)
 	wacom_clean_inputs(wacom);
 	if (hdev->bus == BUS_BLUETOOTH)
 		device_remove_file(&hdev->dev, &dev_attr_speed);
-	wacom_destroy_battery(wacom);
 	wacom_remove_shared_data(wacom);
 
 	hid_set_drvdata(hdev, NULL);
-- 
2.5.5

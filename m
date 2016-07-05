From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 21/27] HID: wacom: EKR: have one power_supply per remote
Date: Tue,  5 Jul 2016 16:39:17 +0200
Message-ID: <1467729563-23318-22-git-send-email-benjamin.tissoires@redhat.com>
References: <1467729563-23318-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467729563-23318-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Aaron Skomra <skomra@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Previously, all the remotes attached to the same receiver would share the
same power_supply. That's not good as the remotes will constantly change
the battery information according to their own state.

To have something generic enough, we introduce struct wacom_battery
which regroups all the information we need for a battery.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/wacom.h     |  19 ++++++--
 drivers/hid/wacom_sys.c | 123 ++++++++++++++++++++++++++----------------------
 drivers/hid/wacom_wac.c |  55 ++++++++++++----------
 drivers/hid/wacom_wac.h |   6 ---
 4 files changed, 111 insertions(+), 92 deletions(-)

diff --git a/drivers/hid/wacom.h b/drivers/hid/wacom.h
index 393b5af..768d696 100644
--- a/drivers/hid/wacom.h
+++ b/drivers/hid/wacom.h
@@ -116,6 +116,19 @@ struct wacom_group_leds {
 	u8 select; /* status led selector (0..3) */
 };
 
+struct wacom_battery {
+	struct power_supply_desc bat_desc;
+	struct power_supply_desc ac_desc;
+	struct power_supply *battery;
+	struct power_supply *ac;
+	char bat_name[WACOM_NAME_MAX];
+	char ac_name[WACOM_NAME_MAX];
+	int battery_capacity;
+	int bat_charging;
+	int bat_connected;
+	int ps_connected;
+};
+
 struct wacom_remote {
 	spinlock_t remote_lock;
 	struct kfifo remote_fifo;
@@ -125,6 +138,7 @@ struct wacom_remote {
 		u32 serial;
 		struct input_dev *input;
 		bool registered;
+		struct wacom_battery battery;
 	} remotes[WACOM_MAX_REMOTES];
 };
 
@@ -144,10 +158,7 @@ struct wacom {
 		u8 hlv;       /* status led brightness button pressed (1..127) */
 		u8 img_lum;   /* OLED matrix display brightness */
 	} led;
-	struct power_supply *battery;
-	struct power_supply *ac;
-	struct power_supply_desc battery_desc;
-	struct power_supply_desc ac_desc;
+	struct wacom_battery battery;
 	bool resources;
 };
 
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index f2f5b4b..04f5c75 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1101,27 +1101,26 @@ static int wacom_battery_get_property(struct power_supply *psy,
 				      enum power_supply_property psp,
 				      union power_supply_propval *val)
 {
-	struct wacom *wacom = power_supply_get_drvdata(psy);
+	struct wacom_battery *battery = power_supply_get_drvdata(psy);
 	int ret = 0;
 
 	switch (psp) {
 		case POWER_SUPPLY_PROP_PRESENT:
-			val->intval = wacom->wacom_wac.bat_connected;
+			val->intval = battery->bat_connected;
 			break;
 		case POWER_SUPPLY_PROP_SCOPE:
 			val->intval = POWER_SUPPLY_SCOPE_DEVICE;
 			break;
 		case POWER_SUPPLY_PROP_CAPACITY:
-			val->intval =
-				wacom->wacom_wac.battery_capacity;
+			val->intval = battery->battery_capacity;
 			break;
 		case POWER_SUPPLY_PROP_STATUS:
-			if (wacom->wacom_wac.bat_charging)
+			if (battery->bat_charging)
 				val->intval = POWER_SUPPLY_STATUS_CHARGING;
-			else if (wacom->wacom_wac.battery_capacity == 100 &&
-				    wacom->wacom_wac.ps_connected)
+			else if (battery->battery_capacity == 100 &&
+				    battery->ps_connected)
 				val->intval = POWER_SUPPLY_STATUS_FULL;
-			else if (wacom->wacom_wac.ps_connected)
+			else if (battery->ps_connected)
 				val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
 			else
 				val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
@@ -1138,14 +1137,14 @@ static int wacom_ac_get_property(struct power_supply *psy,
 				enum power_supply_property psp,
 				union power_supply_propval *val)
 {
-	struct wacom *wacom = power_supply_get_drvdata(psy);
+	struct wacom_battery *battery = power_supply_get_drvdata(psy);
 	int ret = 0;
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_PRESENT:
 		/* fall through */
 	case POWER_SUPPLY_PROP_ONLINE:
-		val->intval = wacom->wacom_wac.ps_connected;
+		val->intval = battery->ps_connected;
 		break;
 	case POWER_SUPPLY_PROP_SCOPE:
 		val->intval = POWER_SUPPLY_SCOPE_DEVICE;
@@ -1157,58 +1156,56 @@ static int wacom_ac_get_property(struct power_supply *psy,
 	return ret;
 }
 
-static int wacom_initialize_battery(struct wacom *wacom)
+static int __wacom_initialize_battery(struct wacom *wacom,
+				      struct wacom_battery *battery)
 {
 	static atomic_t battery_no = ATOMIC_INIT(0);
 	struct device *dev = &wacom->hdev->dev;
-	struct power_supply_config psy_cfg = { .drv_data = wacom, };
-	struct power_supply_desc *bat_desc = &wacom->battery_desc;
+	struct power_supply_config psy_cfg = { .drv_data = battery, };
+	struct power_supply *ps_bat, *ps_ac;
+	struct power_supply_desc *bat_desc = &battery->bat_desc;
+	struct power_supply_desc *ac_desc = &battery->ac_desc;
 	unsigned long n;
 	int error;
 
 	if (!devres_open_group(dev, bat_desc, GFP_KERNEL))
 		return -ENOMEM;
 
-	if (wacom->wacom_wac.features.quirks & WACOM_QUIRK_BATTERY) {
-		struct power_supply_desc *ac_desc = &wacom->ac_desc;
-		n = atomic_inc_return(&battery_no) - 1;
-
-		bat_desc->properties = wacom_battery_props;
-		bat_desc->num_properties = ARRAY_SIZE(wacom_battery_props);
-		bat_desc->get_property = wacom_battery_get_property;
-		sprintf(wacom->wacom_wac.bat_name, "wacom_battery_%ld", n);
-		bat_desc->name = wacom->wacom_wac.bat_name;
-		bat_desc->type = POWER_SUPPLY_TYPE_BATTERY;
-		bat_desc->use_for_apm = 0;
-
-		ac_desc->properties = wacom_ac_props;
-		ac_desc->num_properties = ARRAY_SIZE(wacom_ac_props);
-		ac_desc->get_property = wacom_ac_get_property;
-		sprintf(wacom->wacom_wac.ac_name, "wacom_ac_%ld", n);
-		ac_desc->name = wacom->wacom_wac.ac_name;
-		ac_desc->type = POWER_SUPPLY_TYPE_MAINS;
-		ac_desc->use_for_apm = 0;
-
-		wacom->battery = devm_power_supply_register(dev,
-							   &wacom->battery_desc,
-							   &psy_cfg);
-		if (IS_ERR(wacom->battery)) {
-			error = PTR_ERR(wacom->battery);
-			goto err;
-		}
+	n = atomic_inc_return(&battery_no) - 1;
+
+	bat_desc->properties = wacom_battery_props;
+	bat_desc->num_properties = ARRAY_SIZE(wacom_battery_props);
+	bat_desc->get_property = wacom_battery_get_property;
+	sprintf(battery->bat_name, "wacom_battery_%ld", n);
+	bat_desc->name = battery->bat_name;
+	bat_desc->type = POWER_SUPPLY_TYPE_BATTERY;
+	bat_desc->use_for_apm = 0;
+
+	ac_desc->properties = wacom_ac_props;
+	ac_desc->num_properties = ARRAY_SIZE(wacom_ac_props);
+	ac_desc->get_property = wacom_ac_get_property;
+	sprintf(battery->ac_name, "wacom_ac_%ld", n);
+	ac_desc->name = battery->ac_name;
+	ac_desc->type = POWER_SUPPLY_TYPE_MAINS;
+	ac_desc->use_for_apm = 0;
+
+	ps_bat = devm_power_supply_register(dev, bat_desc, &psy_cfg);
+	if (IS_ERR(ps_bat)) {
+		error = PTR_ERR(ps_bat);
+		goto err;
+	}
 
-		power_supply_powers(wacom->battery, &wacom->hdev->dev);
+	ps_ac = devm_power_supply_register(dev, ac_desc, &psy_cfg);
+	if (IS_ERR(ps_ac)) {
+		error = PTR_ERR(ps_ac);
+		goto err;
+	}
 
-		wacom->ac = devm_power_supply_register(dev,
-						       &wacom->ac_desc,
-						       &psy_cfg);
-		if (IS_ERR(wacom->ac)) {
-			error = PTR_ERR(wacom->ac);
-			goto err;
-		}
+	power_supply_powers(ps_bat, &wacom->hdev->dev);
+	power_supply_powers(ps_ac, &wacom->hdev->dev);
 
-		power_supply_powers(wacom->ac, &wacom->hdev->dev);
-	}
+	battery->battery = ps_bat;
+	battery->ac = ps_ac;
 
 	devres_close_group(dev, bat_desc);
 	return 0;
@@ -1218,12 +1215,21 @@ err:
 	return error;
 }
 
+static int wacom_initialize_battery(struct wacom *wacom)
+{
+	if (wacom->wacom_wac.features.quirks & WACOM_QUIRK_BATTERY)
+		return __wacom_initialize_battery(wacom, &wacom->battery);
+
+	return 0;
+}
+
 static void wacom_destroy_battery(struct wacom *wacom)
 {
-	if (wacom->battery) {
-		devres_release_group(&wacom->hdev->dev, &wacom->battery_desc);
-		wacom->battery = NULL;
-		wacom->ac = NULL;
+	if (wacom->battery.battery) {
+		devres_release_group(&wacom->hdev->dev,
+				     &wacom->battery.bat_desc);
+		wacom->battery.battery = NULL;
+		wacom->battery.ac = NULL;
 	}
 }
 
@@ -1593,11 +1599,11 @@ void wacom_battery_work(struct work_struct *work)
 	struct wacom *wacom = container_of(work, struct wacom, battery_work);
 
 	if ((wacom->wacom_wac.features.quirks & WACOM_QUIRK_BATTERY) &&
-	     !wacom->battery) {
+	     !wacom->battery.battery) {
 		wacom_initialize_battery(wacom);
 	}
 	else if (!(wacom->wacom_wac.features.quirks & WACOM_QUIRK_BATTERY) &&
-		 wacom->battery) {
+		 wacom->battery.battery) {
 		wacom_destroy_battery(wacom);
 	}
 }
@@ -1976,6 +1982,11 @@ static int wacom_remote_create_one(struct wacom *wacom, u32 serial,
 	if (error)
 		goto fail;
 
+	error = __wacom_initialize_battery(wacom,
+					   &remote->remotes[index].battery);
+	if (error)
+		goto fail;
+
 	remote->remotes[index].registered = true;
 
 	devres_close_group(dev, &remote->remotes[index]);
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index d1210d0..6904e9b 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -48,25 +48,37 @@ static unsigned short batcap_gr[8] = { 1, 15, 25, 35, 50, 70, 100, 100 };
  */
 static unsigned short batcap_i4[8] = { 1, 15, 30, 45, 60, 70, 85, 100 };
 
+static void __wacom_notify_battery(struct wacom_battery *battery,
+				   int bat_capacity, bool bat_charging,
+				   bool bat_connected, bool ps_connected)
+{
+	bool changed = battery->battery_capacity != bat_capacity  ||
+		       battery->bat_charging     != bat_charging  ||
+		       battery->bat_connected    != bat_connected ||
+		       battery->ps_connected     != ps_connected;
+
+	if (changed) {
+		battery->battery_capacity = bat_capacity;
+		battery->bat_charging = bat_charging;
+		battery->bat_connected = bat_connected;
+		battery->ps_connected = ps_connected;
+
+		if (battery->battery)
+			power_supply_changed(battery->battery);
+	}
+}
+
 static void wacom_notify_battery(struct wacom_wac *wacom_wac,
 	int bat_capacity, bool bat_charging, bool bat_connected,
 	bool ps_connected)
 {
 	struct wacom *wacom = container_of(wacom_wac, struct wacom, wacom_wac);
-	bool changed = wacom_wac->battery_capacity != bat_capacity  ||
-		       wacom_wac->bat_charging     != bat_charging  ||
-		       wacom_wac->bat_connected    != bat_connected ||
-		       wacom_wac->ps_connected     != ps_connected;
 
-	if (changed) {
-		wacom_wac->battery_capacity = bat_capacity;
-		wacom_wac->bat_charging = bat_charging;
-		wacom_wac->bat_connected = bat_connected;
-		wacom_wac->ps_connected = ps_connected;
+	if (!wacom->battery.battery)
+		return;
 
-		if (wacom->battery)
-			power_supply_changed(wacom->battery);
-	}
+	__wacom_notify_battery(&wacom->battery, bat_capacity, bat_charging,
+			       bat_connected, ps_connected);
 }
 
 static int wacom_penpartner_irq(struct wacom_wac *wacom)
@@ -754,7 +766,6 @@ static int wacom_remote_irq(struct wacom_wac *wacom_wac, size_t len)
 	struct input_dev *input;
 	struct wacom *wacom = container_of(wacom_wac, struct wacom, wacom_wac);
 	struct wacom_remote *remote = wacom->remote;
-	struct wacom_features *features = &wacom_wac->features;
 	int bat_charging, bat_percent, touch_ring_mode;
 	__u32 serial;
 	int i, index = -1;
@@ -829,14 +840,8 @@ static int wacom_remote_irq(struct wacom_wac *wacom_wac, size_t len)
 			wacom->led.groups[i].select = touch_ring_mode;
 	}
 
-	if (!wacom->battery &&
-	    !(features->quirks & WACOM_QUIRK_BATTERY)) {
-		features->quirks |= WACOM_QUIRK_BATTERY;
-		wacom_schedule_work(wacom_wac, WACOM_WORKER_BATTERY);
-	}
-
-	wacom_notify_battery(wacom_wac, bat_percent, bat_charging, 1,
-			     bat_charging);
+	__wacom_notify_battery(&remote->remotes[index].battery, bat_percent,
+				bat_charging, 1, bat_charging);
 
 out:
 	spin_unlock_irqrestore(&remote->remote_lock, flags);
@@ -2132,7 +2137,6 @@ static int wacom_bamboo_pad_irq(struct wacom_wac *wacom, size_t len)
 
 static int wacom_wireless_irq(struct wacom_wac *wacom, size_t len)
 {
-	struct wacom *w = container_of(wacom, struct wacom, wacom_wac);
 	unsigned char *data = wacom->data;
 	int connected;
 
@@ -2160,8 +2164,7 @@ static int wacom_wireless_irq(struct wacom_wac *wacom, size_t len)
 			wacom_schedule_work(wacom, WACOM_WORKER_WIRELESS);
 		}
 
-		if (w->battery)
-			wacom_notify_battery(wacom, battery, charging, 1, 0);
+		wacom_notify_battery(wacom, battery, charging, 1, 0);
 
 	} else if (wacom->pid != 0) {
 		/* disconnected while previously connected */
@@ -2198,14 +2201,14 @@ static int wacom_status_irq(struct wacom_wac *wacom_wac, size_t len)
 		wacom_notify_battery(wacom_wac, battery, charging,
 				     battery || charging, 1);
 
-		if (!wacom->battery &&
+		if (!wacom->battery.battery &&
 		    !(features->quirks & WACOM_QUIRK_BATTERY)) {
 			features->quirks |= WACOM_QUIRK_BATTERY;
 			wacom_schedule_work(wacom_wac, WACOM_WORKER_BATTERY);
 		}
 	}
 	else if ((features->quirks & WACOM_QUIRK_BATTERY) &&
-		 wacom->battery) {
+		 wacom->battery.battery) {
 		features->quirks &= ~WACOM_QUIRK_BATTERY;
 		wacom_schedule_work(wacom_wac, WACOM_WORKER_BATTERY);
 		wacom_notify_battery(wacom_wac, 0, 0, 0, 0);
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 6be6cae..8a8974c 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -229,8 +229,6 @@ struct wacom_wac {
 	char pen_name[WACOM_NAME_MAX];
 	char touch_name[WACOM_NAME_MAX];
 	char pad_name[WACOM_NAME_MAX];
-	char bat_name[WACOM_NAME_MAX];
-	char ac_name[WACOM_NAME_MAX];
 	unsigned char data[WACOM_PKGLEN_MAX];
 	int tool[2];
 	int id[2];
@@ -242,11 +240,7 @@ struct wacom_wac {
 	struct input_dev *touch_input;
 	struct input_dev *pad_input;
 	int pid;
-	int battery_capacity;
 	int num_contacts_left;
-	int bat_charging;
-	int bat_connected;
-	int ps_connected;
 	u8 bt_features;
 	u8 bt_high_speed;
 	int mode_report;
-- 
2.5.5

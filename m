From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 16/19] HID: logitech-hidpp: battery: provide CAPACITY_LEVEL
Date: Mon, 27 Mar 2017 16:59:36 +0200
Message-ID: <20170327145939.29824-17-benjamin.tissoires@redhat.com>
References: <20170327145939.29824-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170327145939.29824-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

CAPACITY LEVEL allows to forward rough information on the battery mileage.
HID++ 2.0 devices will either report percentage or levels, so better
forwarding this information to the user space.

The M325 supports only 2 levels: 'Full' and 'Critical'. With mileage,
it will report either 90% or 5%, which might confuse users. With this
change the battery will either report "Full" or "Critical".

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

new in v3
---
 drivers/hid/hid-logitech-hidpp.c | 104 +++++++++++++++++++++++++++++++++++----
 1 file changed, 94 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index c59f7e5e..d7dc458 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -68,6 +68,8 @@ MODULE_PARM_DESC(disable_tap_to_click,
 
 #define HIDPP_CAPABILITY_HIDPP10_BATTERY	BIT(0)
 #define HIDPP_CAPABILITY_HIDPP20_BATTERY	BIT(1)
+#define HIDPP_CAPABILITY_BATTERY_MILEAGE	BIT(2)
+#define HIDPP_CAPABILITY_BATTERY_LEVEL_STATUS	BIT(3)
 
 /*
  * There are two hidpp protocols in use, the first version hidpp10 is known
@@ -120,6 +122,7 @@ struct hidpp_battery {
 	char name[64];
 	int status;
 	int capacity;
+	int level;
 	bool online;
 };
 
@@ -683,13 +686,30 @@ static char *hidpp_get_device_name(struct hidpp_device *hidpp)
 
 #define EVENT_BATTERY_LEVEL_STATUS_BROADCAST			0x00
 
+#define FLAG_BATTERY_LEVEL_DISABLE_OSD				BIT(0)
+#define FLAG_BATTERY_LEVEL_MILEAGE				BIT(1)
+#define FLAG_BATTERY_LEVEL_RECHARGEABLE				BIT(2)
+
+static int hidpp_map_battery_level(int capacity)
+{
+	if (capacity < 11)
+		return POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL;
+	else if (capacity < 31)
+		return POWER_SUPPLY_CAPACITY_LEVEL_LOW;
+	else if (capacity < 81)
+		return POWER_SUPPLY_CAPACITY_LEVEL_NORMAL;
+	return POWER_SUPPLY_CAPACITY_LEVEL_FULL;
+}
+
 static int hidpp20_batterylevel_map_status_capacity(u8 data[3], int *capacity,
-						    int *next_capacity)
+						    int *next_capacity,
+						    int *level)
 {
 	int status;
 
 	*capacity = data[0];
 	*next_capacity = data[1];
+	*level = POWER_SUPPLY_CAPACITY_LEVEL_UNKNOWN;
 
 	/* When discharging, we can rely on the device reported capacity.
 	 * For all other states the device reports 0 (unknown).
@@ -697,6 +717,7 @@ static int hidpp20_batterylevel_map_status_capacity(u8 data[3], int *capacity,
 	switch (data[2]) {
 		case 0: /* discharging (in use) */
 			status = POWER_SUPPLY_STATUS_DISCHARGING;
+			*level = hidpp_map_battery_level(*capacity);
 			break;
 		case 1: /* recharging */
 			status = POWER_SUPPLY_STATUS_CHARGING;
@@ -706,6 +727,7 @@ static int hidpp20_batterylevel_map_status_capacity(u8 data[3], int *capacity,
 			break;
 		case 3: /* charge complete */
 			status = POWER_SUPPLY_STATUS_FULL;
+			*level = POWER_SUPPLY_CAPACITY_LEVEL_FULL;
 			*capacity = 100;
 			break;
 		case 4: /* recharging below optimal speed */
@@ -726,7 +748,8 @@ static int hidpp20_batterylevel_get_battery_capacity(struct hidpp_device *hidpp,
 						     u8 feature_index,
 						     int *status,
 						     int *capacity,
-						     int *next_capacity)
+						     int *next_capacity,
+						     int *level)
 {
 	struct hidpp_report response;
 	int ret;
@@ -744,7 +767,38 @@ static int hidpp20_batterylevel_get_battery_capacity(struct hidpp_device *hidpp,
 		return ret;
 
 	*status = hidpp20_batterylevel_map_status_capacity(params, capacity,
-							   next_capacity);
+							   next_capacity,
+							   level);
+
+	return 0;
+}
+
+static int hidpp20_batterylevel_get_battery_info(struct hidpp_device *hidpp,
+						  u8 feature_index)
+{
+	struct hidpp_report response;
+	int ret;
+	u8 *params = (u8 *)response.fap.params;
+	unsigned int level_count, flags;
+
+	ret = hidpp_send_fap_command_sync(hidpp, feature_index,
+					  CMD_BATTERY_LEVEL_STATUS_GET_BATTERY_CAPABILITY,
+					  NULL, 0, &response);
+	if (ret > 0) {
+		hid_err(hidpp->hid_dev, "%s: received protocol error 0x%02x\n",
+			__func__, ret);
+		return -EPROTO;
+	}
+	if (ret)
+		return ret;
+
+	level_count = params[0];
+	flags = params[1];
+
+	if (level_count < 10 || !(flags & FLAG_BATTERY_LEVEL_MILEAGE))
+		hidpp->capabilities |= HIDPP_CAPABILITY_BATTERY_LEVEL_STATUS;
+	else
+		hidpp->capabilities |= HIDPP_CAPABILITY_BATTERY_MILEAGE;
 
 	return 0;
 }
@@ -753,7 +807,7 @@ static int hidpp20_query_battery_info(struct hidpp_device *hidpp)
 {
 	u8 feature_type;
 	int ret;
-	int status, capacity, next_capacity;
+	int status, capacity, next_capacity, level;
 
 	if (hidpp->battery.feature_index == 0) {
 		ret = hidpp_root_get_feature(hidpp,
@@ -767,12 +821,18 @@ static int hidpp20_query_battery_info(struct hidpp_device *hidpp)
 	ret = hidpp20_batterylevel_get_battery_capacity(hidpp,
 						hidpp->battery.feature_index,
 						&status, &capacity,
-						&next_capacity);
+						&next_capacity, &level);
+	if (ret)
+		return ret;
+
+	ret = hidpp20_batterylevel_get_battery_info(hidpp,
+						hidpp->battery.feature_index);
 	if (ret)
 		return ret;
 
 	hidpp->battery.status = status;
 	hidpp->battery.capacity = capacity;
+	hidpp->battery.level = level;
 	/* the capacity is only available when discharging or full */
 	hidpp->battery.online = status == POWER_SUPPLY_STATUS_DISCHARGING ||
 				status == POWER_SUPPLY_STATUS_FULL;
@@ -784,7 +844,7 @@ static int hidpp20_battery_event(struct hidpp_device *hidpp,
 				 u8 *data, int size)
 {
 	struct hidpp_report *report = (struct hidpp_report *)data;
-	int status, capacity, next_capacity;
+	int status, capacity, next_capacity, level;
 	bool changed;
 
 	if (report->fap.feature_index != hidpp->battery.feature_index ||
@@ -793,16 +853,19 @@ static int hidpp20_battery_event(struct hidpp_device *hidpp,
 
 	status = hidpp20_batterylevel_map_status_capacity(report->fap.params,
 							  &capacity,
-							  &next_capacity);
+							  &next_capacity,
+							  &level);
 
 	/* the capacity is only available when discharging or full */
 	hidpp->battery.online = status == POWER_SUPPLY_STATUS_DISCHARGING ||
 				status == POWER_SUPPLY_STATUS_FULL;
 
 	changed = capacity != hidpp->battery.capacity ||
+		  level != hidpp->battery.level ||
 		  status != hidpp->battery.status;
 
 	if (changed) {
+		hidpp->battery.level = level;
 		hidpp->battery.capacity = capacity;
 		hidpp->battery.status = status;
 		if (hidpp->battery.ps)
@@ -815,11 +878,12 @@ static int hidpp20_battery_event(struct hidpp_device *hidpp,
 static enum power_supply_property hidpp_battery_props[] = {
 	POWER_SUPPLY_PROP_ONLINE,
 	POWER_SUPPLY_PROP_STATUS,
-	POWER_SUPPLY_PROP_CAPACITY,
 	POWER_SUPPLY_PROP_SCOPE,
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,
 	POWER_SUPPLY_PROP_SERIAL_NUMBER,
+	0, /* placeholder for POWER_SUPPLY_PROP_CAPACITY, */
+	0, /* placeholder for POWER_SUPPLY_PROP_CAPACITY_LEVEL, */
 };
 
 static int hidpp_battery_get_property(struct power_supply *psy,
@@ -836,6 +900,9 @@ static int hidpp_battery_get_property(struct power_supply *psy,
 		case POWER_SUPPLY_PROP_CAPACITY:
 			val->intval = hidpp->battery.capacity;
 			break;
+		case POWER_SUPPLY_PROP_CAPACITY_LEVEL:
+			val->intval = hidpp->battery.level;
+			break;
 		case POWER_SUPPLY_PROP_SCOPE:
 			val->intval = POWER_SUPPLY_SCOPE_DEVICE;
 			break;
@@ -2316,7 +2383,9 @@ static int hidpp_initialize_battery(struct hidpp_device *hidpp)
 	static atomic_t battery_no = ATOMIC_INIT(0);
 	struct power_supply_config cfg = { .drv_data = hidpp };
 	struct power_supply_desc *desc = &hidpp->battery.desc;
+	enum power_supply_property *battery_props;
 	struct hidpp_battery *battery;
+	unsigned int num_battery_props;
 	unsigned long n;
 	int ret;
 
@@ -2332,11 +2401,25 @@ static int hidpp_initialize_battery(struct hidpp_device *hidpp)
 		return -ENOENT;
 	}
 
+	battery_props = devm_kmemdup(&hidpp->hid_dev->dev,
+				     hidpp_battery_props,
+				     sizeof(hidpp_battery_props),
+				     GFP_KERNEL);
+	num_battery_props = ARRAY_SIZE(hidpp_battery_props) - 2;
+
+	if (hidpp->capabilities & HIDPP_CAPABILITY_BATTERY_MILEAGE)
+		battery_props[num_battery_props++] =
+				POWER_SUPPLY_PROP_CAPACITY;
+
+	if (hidpp->capabilities & HIDPP_CAPABILITY_BATTERY_LEVEL_STATUS)
+		battery_props[num_battery_props++] =
+				POWER_SUPPLY_PROP_CAPACITY_LEVEL;
+
 	battery = &hidpp->battery;
 
 	n = atomic_inc_return(&battery_no) - 1;
-	desc->properties = hidpp_battery_props;
-	desc->num_properties = ARRAY_SIZE(hidpp_battery_props);
+	desc->properties = battery_props;
+	desc->num_properties = num_battery_props;
 	desc->get_property = hidpp_battery_get_property;
 	sprintf(battery->name, "hidpp_battery_%ld", n);
 	desc->name = battery->name;
@@ -2424,6 +2507,7 @@ static void hidpp_connect_event(struct hidpp_device *hidpp)
 		if (hidpp->battery.ps) {
 			hidpp->battery.online = false;
 			hidpp->battery.status = POWER_SUPPLY_STATUS_UNKNOWN;
+			hidpp->battery.level = POWER_SUPPLY_CAPACITY_LEVEL_UNKNOWN;
 			power_supply_changed(hidpp->battery.ps);
 		}
 		return;
-- 
2.9.3

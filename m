From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 1/2] HID: input: map digitizer battery usage
Date: Mon, 31 Jul 2017 16:21:03 -0700
Message-ID: <20170731232104.14708-1-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36965 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751052AbdGaXVH (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 31 Jul 2017 19:21:07 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jason Gerecke <killertofu@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

We already mapped battery strength reports from the generic device
control page, but we did not update capacity from input reports, nor we
mapped the battery strength report from the digitizer page, so let's
implement this now.

Batteries driven by the input reports will now start in "unknown" state,
and will get updated once we receive first report containing battery
strength from the device.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-input.c | 181 ++++++++++++++++++++++++++++++++----------------
 include/linux/hid.h     |   2 +
 2 files changed, 124 insertions(+), 59 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index ccdff1ee1f0c..5bcd4e4afb54 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -340,13 +340,42 @@ static unsigned find_battery_quirk(struct hid_device *hdev)
 	return quirks;
 }
 
+static int hidinput_scale_battery_capacity(struct hid_device *dev,
+					   int value)
+{
+	if (dev->battery_min < dev->battery_max &&
+	    value >= dev->battery_min && value <= dev->battery_max)
+		value = ((value - dev->battery_min) * 100) /
+			(dev->battery_max - dev->battery_min);
+
+	return value;
+}
+
+static int hidinput_query_battery_capacity(struct hid_device *dev)
+{
+	u8 *buf;
+	int ret;
+
+	buf = kmalloc(2, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	ret = hid_hw_raw_request(dev, dev->battery_report_id, buf, 2,
+				 dev->battery_report_type, HID_REQ_GET_REPORT);
+	ret = (ret != 2) ? -ENODATA : buf[1];
+
+	kfree(buf);
+
+	return hidinput_scale_battery_capacity(dev, ret);
+}
+
 static int hidinput_get_battery_property(struct power_supply *psy,
 					 enum power_supply_property prop,
 					 union power_supply_propval *val)
 {
 	struct hid_device *dev = power_supply_get_drvdata(psy);
+	int value;
 	int ret = 0;
-	__u8 *buf;
 
 	switch (prop) {
 	case POWER_SUPPLY_PROP_PRESENT:
@@ -355,29 +384,15 @@ static int hidinput_get_battery_property(struct power_supply *psy,
 		break;
 
 	case POWER_SUPPLY_PROP_CAPACITY:
-
-		buf = kmalloc(2 * sizeof(__u8), GFP_KERNEL);
-		if (!buf) {
-			ret = -ENOMEM;
-			break;
+		if (dev->battery_report_type == HID_FEATURE_REPORT) {
+			value = hidinput_query_battery_capacity(dev);
+			if (value < 0)
+				return value;
+		} else  {
+			value = dev->battery_capacity;
 		}
-		ret = hid_hw_raw_request(dev, dev->battery_report_id, buf, 2,
-					 dev->battery_report_type,
-					 HID_REQ_GET_REPORT);
 
-		if (ret != 2) {
-			ret = -ENODATA;
-			kfree(buf);
-			break;
-		}
-		ret = 0;
-
-		if (dev->battery_min < dev->battery_max &&
-		    buf[1] >= dev->battery_min &&
-		    buf[1] <= dev->battery_max)
-			val->intval = (100 * (buf[1] - dev->battery_min)) /
-				(dev->battery_max - dev->battery_min);
-		kfree(buf);
+		val->intval = value;
 		break;
 
 	case POWER_SUPPLY_PROP_MODEL_NAME:
@@ -385,7 +400,22 @@ static int hidinput_get_battery_property(struct power_supply *psy,
 		break;
 
 	case POWER_SUPPLY_PROP_STATUS:
-		val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+		if (!dev->battery_reported &&
+		    dev->battery_report_type == HID_FEATURE_REPORT) {
+			value = hidinput_query_battery_capacity(dev);
+			if (value < 0)
+				return value;
+
+			dev->battery_capacity = value;
+			dev->battery_reported = true;
+		}
+
+		if (!dev->battery_reported)
+			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
+		else if (dev->battery_capacity == 100)
+			val->intval = POWER_SUPPLY_STATUS_FULL;
+		else
+			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
 		break;
 
 	case POWER_SUPPLY_PROP_SCOPE:
@@ -400,18 +430,16 @@ static int hidinput_get_battery_property(struct power_supply *psy,
 	return ret;
 }
 
-static bool hidinput_setup_battery(struct hid_device *dev, unsigned report_type, struct hid_field *field)
+static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type, struct hid_field *field)
 {
-	struct power_supply_desc *psy_desc = NULL;
+	struct power_supply_desc *psy_desc;
 	struct power_supply_config psy_cfg = { .drv_data = dev, };
 	unsigned quirks;
 	s32 min, max;
+	int error;
 
-	if (field->usage->hid != HID_DC_BATTERYSTRENGTH)
-		return false;	/* no match */
-
-	if (dev->battery != NULL)
-		goto out;	/* already initialized? */
+	if (dev->battery)
+		return 0;	/* already initialized? */
 
 	quirks = find_battery_quirk(dev);
 
@@ -419,16 +447,16 @@ static bool hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 		dev->bus, dev->vendor, dev->product, dev->version, quirks);
 
 	if (quirks & HID_BATTERY_QUIRK_IGNORE)
-		goto out;
+		return 0;
 
 	psy_desc = kzalloc(sizeof(*psy_desc), GFP_KERNEL);
-	if (psy_desc == NULL)
-		goto out;
+	if (!psy_desc)
+		return -ENOMEM;
 
 	psy_desc->name = kasprintf(GFP_KERNEL, "hid-%s-battery", dev->uniq);
-	if (psy_desc->name == NULL) {
-		kfree(psy_desc);
-		goto out;
+	if (!psy_desc->name) {
+		error = -ENOMEM;
+		goto err_free_mem;
 	}
 
 	psy_desc->type = POWER_SUPPLY_TYPE_BATTERY;
@@ -455,17 +483,20 @@ static bool hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 
 	dev->battery = power_supply_register(&dev->dev, psy_desc, &psy_cfg);
 	if (IS_ERR(dev->battery)) {
-		hid_warn(dev, "can't register power supply: %ld\n",
-				PTR_ERR(dev->battery));
-		kfree(psy_desc->name);
-		kfree(psy_desc);
-		dev->battery = NULL;
-	} else {
-		power_supply_powers(dev->battery, &dev->dev);
+		error = PTR_ERR(dev->battery);
+		hid_warn(dev, "can't register power supply: %d\n", error);
+		goto err_free_name;
 	}
 
-out:
-	return true;
+	power_supply_powers(dev->battery, &dev->dev);
+	return 0;
+
+err_free_name:
+	kfree(psy_desc->name);
+err_free_mem:
+	kfree(psy_desc);
+	dev->battery = NULL;
+	return error;
 }
 
 static void hidinput_cleanup_battery(struct hid_device *dev)
@@ -481,16 +512,33 @@ static void hidinput_cleanup_battery(struct hid_device *dev)
 	kfree(psy_desc);
 	dev->battery = NULL;
 }
+
+static void hidinput_update_battery(struct hid_device *dev, int value)
+{
+	if (!dev->battery)
+		return;
+
+	if (value == 0 || value < dev->battery_min || value > dev->battery_max)
+		return;
+
+	dev->battery_capacity = hidinput_scale_battery_capacity(dev, value);
+	dev->battery_reported = true;
+	power_supply_changed(dev->battery);
+}
 #else  /* !CONFIG_HID_BATTERY_STRENGTH */
-static bool hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
-				   struct hid_field *field)
+static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
+				  struct hid_field *field)
 {
-	return false;
+	return 0;
 }
 
 static void hidinput_cleanup_battery(struct hid_device *dev)
 {
 }
+
+static void hidinput_update_battery(struct hid_device *dev, int value)
+{
+}
 #endif	/* CONFIG_HID_BATTERY_STRENGTH */
 
 static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_field *field,
@@ -710,6 +758,11 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 			}
 			break;
 
+		case 0x3b: /* Battery Strength */
+			hidinput_setup_battery(device, HID_INPUT_REPORT, field);
+			usage->type = EV_PWR;
+			goto ignore;
+
 		case 0x3c: /* Invert */
 			map_key_clear(BTN_TOOL_RUBBER);
 			break;
@@ -944,11 +997,13 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		break;
 
 	case HID_UP_GENDEVCTRLS:
-		if (hidinput_setup_battery(device, HID_INPUT_REPORT, field))
+		switch (usage->hid) {
+		case HID_DC_BATTERYSTRENGTH:
+			hidinput_setup_battery(device, HID_INPUT_REPORT, field);
+			usage->type = EV_PWR;
 			goto ignore;
-		else
-			goto unknown;
-		break;
+		}
+		goto unknown;
 
 	case HID_UP_HPVENDOR:	/* Reported on a Dutch layout HP5308 */
 		set_bit(EV_REP, input->evbit);
@@ -1031,7 +1086,6 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 	if (usage->code > max)
 		goto ignore;
 
-
 	if (usage->type == EV_ABS) {
 
 		int a = field->logical_minimum;
@@ -1090,14 +1144,19 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
 	struct input_dev *input;
 	unsigned *quirks = &hid->quirks;
 
-	if (!field->hidinput)
+	if (!usage->type)
 		return;
 
-	input = field->hidinput->input;
+	if (usage->type == EV_PWR) {
+		hidinput_update_battery(hid, value);
+		return;
+	}
 
-	if (!usage->type)
+	if (!field->hidinput)
 		return;
 
+	input = field->hidinput->input;
+
 	if (usage->hat_min < usage->hat_max || usage->hat_dir) {
 		int hat_dir = usage->hat_dir;
 		if (!hat_dir)
@@ -1373,6 +1432,7 @@ static void report_features(struct hid_device *hid)
 	struct hid_driver *drv = hid->driver;
 	struct hid_report_enum *rep_enum;
 	struct hid_report *rep;
+	struct hid_usage *usage;
 	int i, j;
 
 	rep_enum = &hid->report_enum[HID_FEATURE_REPORT];
@@ -1383,12 +1443,15 @@ static void report_features(struct hid_device *hid)
 				continue;
 
 			for (j = 0; j < rep->field[i]->maxusage; j++) {
+				usage = &rep->field[i]->usage[j];
+
 				/* Verify if Battery Strength feature is available */
-				hidinput_setup_battery(hid, HID_FEATURE_REPORT, rep->field[i]);
+				if (usage->hid == HID_DC_BATTERYSTRENGTH)
+					hidinput_setup_battery(hid, HID_FEATURE_REPORT,
+							       rep->field[i]);
 
 				if (drv->feature_mapping)
-					drv->feature_mapping(hid, rep->field[i],
-							     rep->field[i]->usage + j);
+					drv->feature_mapping(hid, rep->field[i], usage);
 			}
 		}
 }
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 3853408daf7f..bbee87b514d2 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -542,10 +542,12 @@ struct hid_device {							/* device report descriptor */
 	 * battery is non-NULL.
 	 */
 	struct power_supply *battery;
+	__s32 battery_capacity;
 	__s32 battery_min;
 	__s32 battery_max;
 	__s32 battery_report_type;
 	__s32 battery_report_id;
+	bool battery_reported;
 #endif
 
 	unsigned int status;						/* see STAT flags above */
-- 
2.14.0.rc0.400.g1c36432dff-goog


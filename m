From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [GIT PULL RFC] directly poll battery strength when reading power_supply
Date: Fri, 02 Dec 2011 22:13:12 -0800
Message-ID: <4ED9BDF8.3010600@goop.org>
References: <4EC75224.7070207@goop.org> <alpine.LNX.2.00.1111191212140.15187@pobox.suse.cz> <4EC820F8.4070900@goop.org> <alpine.LNX.2.00.1111201110480.15187@pobox.suse.cz> <4ECA7E7D.80207@goop.org> <alpine.LNX.2.00.1111220028130.28728@pobox.suse.cz> <4ECAE019.4000409@goop.org> <alpine.LNX.2.00.1111220049470.28728@pobox.suse.cz> <4ECCB38A.8000503@goop.org> <alpine.LNX.2.00.1111281111510.15446@pobox.suse.cz> <CACo8zOd45i3EnCVMyJoDPP4bx2AnD9mEjDiC=bJKvmX=TWfXGg@mail.gmail.com> <4ED90E6D.8090402@goop.org> <CACo8zOcvKwr0wDkytvJfqyx4kV0ceYyCt+qnDqiSgxNywpzeHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from claw.goop.org ([74.207.240.146]:47304 "EHLO claw.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750858Ab1LCGNW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 3 Dec 2011 01:13:22 -0500
In-Reply-To: <CACo8zOcvKwr0wDkytvJfqyx4kV0ceYyCt+qnDqiSgxNywpzeHg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Nicoletti <dantti12@gmail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, vojtech@ucw.cz, Przemo Firszt <przemo@firszt.eu>, Richard Hughes <richard@hughsie.com>

Hi,

This series of patches includes Daniel's patch to directly poll for the battery strength rather than
hoping the device will happen to send it, along with some cleanup patches from me.

The only functional change I made from Daniel's patch is keeping the power_supply type as BATTERY rather
than USB.

	J

The following changes since commit 1b2bdc70c10f9bf1455ea76a558261d7431b533c:

  hid-input: add support for HID devices reporting Battery Strength (2011-11-23 00:38:25 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/jeremy/xen.git hid-battery

Daniel Nicoletti (1):
      hid-input: add support for HID devices reporting Battery Strength

Jeremy Fitzhardinge (7):
      hid-input: fix compile for !HID_BATTERY_STRENGTH
      hid-input/battery: remove apparently redundant kmalloc
      hid-input/battery: add quirks for battery
      hid-input/battery: deal with both FEATURE and INPUT report batteries
      hid-input/battery: make the battery setup common for INPUTs and FEATUREs
      hid-input/battery: power-supply type really *is* a battery
      hid-input/battery: remove battery_val

 drivers/hid/hid-core.c  |    2 +-
 drivers/hid/hid-input.c |  105 +++++++++++++++++++++++++++++++++++------------
 include/linux/hid.h     |    5 ++-
 3 files changed, 83 insertions(+), 29 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 848a56c..70f5192 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1157,7 +1157,7 @@ static bool hid_match_one_id(struct hid_device *hdev,
 		(id->product == HID_ANY_ID || id->product == hdev->product);
 }
 
-static const struct hid_device_id *hid_match_id(struct hid_device *hdev,
+const struct hid_device_id *hid_match_id(struct hid_device *hdev,
 		const struct hid_device_id *id)
 {
 	for (; id->bus; id++)
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 83afb86..7360351 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -32,6 +32,8 @@
 #include <linux/hid.h>
 #include <linux/hid-debug.h>
 
+#include "hid-ids.h"
+
 #define unk	KEY_UNKNOWN
 
 static const unsigned char hid_keyboard[256] = {
@@ -277,14 +279,39 @@ static enum power_supply_property hidinput_battery_props[] = {
 	POWER_SUPPLY_PROP_ONLINE,
 	POWER_SUPPLY_PROP_CAPACITY,
 	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_STATUS
 };
 
+#define HID_BATTERY_QUIRK_PERCENT	(1 << 0) /* always reports percent */
+
+static const struct hid_device_id hid_battery_quirks[] = {
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGICMOUSE),
+	  HID_BATTERY_QUIRK_PERCENT },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGICTRACKPAD),
+	  HID_BATTERY_QUIRK_PERCENT },
+	{}
+};
+
+static unsigned find_battery_quirk(struct hid_device *hdev)
+{
+	unsigned quirks = 0;
+	const struct hid_device_id *match;
+
+	match = hid_match_id(hdev, hid_battery_quirks);
+	if (match != NULL)
+		quirks = match->driver_data;
+
+	return quirks;
+}
+
 static int hidinput_get_battery_property(struct power_supply *psy,
 					 enum power_supply_property prop,
 					 union power_supply_propval *val)
 {
 	struct hid_device *dev = container_of(psy, struct hid_device, battery);
 	int ret = 0;
+	int ret_rep;
+	__u8 buf[2] = {};
 
 	switch (prop) {
 	case POWER_SUPPLY_PROP_PRESENT:
@@ -293,19 +320,29 @@ static int hidinput_get_battery_property(struct power_supply *psy,
 		break;
 
 	case POWER_SUPPLY_PROP_CAPACITY:
+		ret_rep = dev->hid_get_raw_report(dev, dev->battery_report_id,
+						  buf, sizeof(buf),
+						  dev->battery_report_type);
+		if (ret_rep != 2) {
+			ret = -EINVAL;
+			break;
+		}
+
 		if (dev->battery_min < dev->battery_max &&
-		    dev->battery_val >= dev->battery_min &&
-		    dev->battery_val <= dev->battery_max)
-			val->intval = (100 * (dev->battery_val - dev->battery_min)) /
+		    buf[1] >= dev->battery_min &&
+		    buf[1] <= dev->battery_max)
+			val->intval = (100 * (buf[1] - dev->battery_min)) /
 				(dev->battery_max - dev->battery_min);
-		else
-			ret = -EINVAL;
 		break;
 
 	case POWER_SUPPLY_PROP_MODEL_NAME:
 		val->strval = dev->name;
 		break;
 
+	case POWER_SUPPLY_PROP_STATUS:
+		val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+		break;
+
 	default:
 		ret = -EINVAL;
 		break;
@@ -314,17 +351,22 @@ static int hidinput_get_battery_property(struct power_supply *psy,
 	return ret;
 }
 
-static void hidinput_setup_battery(struct hid_device *dev, s32 min, s32 max)
+static bool hidinput_setup_battery(struct hid_device *dev, unsigned report_type, struct hid_field *field)
 {
 	struct power_supply *battery = &dev->battery;
 	int ret;
+	unsigned quirks;
+	s32 min, max;
+
+	if (field->usage->hid != HID_DC_BATTERYSTRENGTH)
+		return false;	/* no match */
 
 	if (battery->name != NULL)
-		return;		/* already initialized? */
+		goto out;	/* already initialized? */
 
 	battery->name = kasprintf(GFP_KERNEL, "hid-%s-battery", dev->uniq);
 	if (battery->name == NULL)
-		return;
+		goto out;
 
 	battery->type = POWER_SUPPLY_TYPE_BATTERY;
 	battery->properties = hidinput_battery_props;
@@ -332,8 +374,20 @@ static void hidinput_setup_battery(struct hid_device *dev, s32 min, s32 max)
 	battery->use_for_apm = 0;
 	battery->get_property = hidinput_get_battery_property;
 
+	quirks = find_battery_quirk(dev);
+
+	min = field->logical_minimum;
+	max = field->logical_maximum;
+
+	if (quirks & HID_BATTERY_QUIRK_PERCENT) {
+		min = 0;
+		max = 100;
+	}
+
 	dev->battery_min = min;
 	dev->battery_max = max;
+	dev->battery_report_type = report_type;
+	dev->battery_report_id = field->report->id;
 
 	ret = power_supply_register(&dev->dev, battery);
 	if (ret != 0) {
@@ -341,6 +395,9 @@ static void hidinput_setup_battery(struct hid_device *dev, s32 min, s32 max)
 		kfree(battery->name);
 		battery->name = NULL;
 	}
+
+out:
+	return true;
 }
 
 static void hidinput_cleanup_battery(struct hid_device *dev)
@@ -353,8 +410,10 @@ static void hidinput_cleanup_battery(struct hid_device *dev)
 	dev->battery.name = NULL;
 }
 #else  /* !CONFIG_HID_BATTERY_STRENGTH */
-static void hidinput_setup_battery(struct hid_device *dev, s32 min, s32 max)
+static bool hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
+				   struct hid_field *field)
 {
+	return false;
 }
 
 static void hidinput_cleanup_battery(struct hid_device *dev)
@@ -721,12 +780,9 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		break;
 
 	case HID_UP_GENDEVCTRLS:
-		if ((usage->hid & HID_USAGE) == 0x20) {	/* Battery Strength */
-			hidinput_setup_battery(device,
-					       field->logical_minimum,
-					       field->logical_maximum);
+		if (hidinput_setup_battery(device, HID_INPUT_REPORT, field))
 			goto ignore;
-		} else
+		else
 			goto unknown;
 		break;
 
@@ -861,13 +917,6 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
 
 	input = field->hidinput->input;
 
-	if (usage->hid == HID_DC_BATTERYSTRENGTH) {
-		hid->battery_val = value;
-		hid_dbg(hid, "battery value is %d (range %d-%d)\n",
-			value, hid->battery_min, hid->battery_max);
-		return;
-	}
-
 	if (!usage->type)
 		return;
 
@@ -990,15 +1039,17 @@ static void report_features(struct hid_device *hid)
 	struct hid_report *rep;
 	int i, j;
 
-	if (!drv->feature_mapping)
-		return;
-
 	rep_enum = &hid->report_enum[HID_FEATURE_REPORT];
 	list_for_each_entry(rep, &rep_enum->report_list, list)
 		for (i = 0; i < rep->maxfield; i++)
-			for (j = 0; j < rep->field[i]->maxusage; j++)
-				drv->feature_mapping(hid, rep->field[i],
-						     rep->field[i]->usage + j);
+			for (j = 0; j < rep->field[i]->maxusage; j++) {
+				/* Verify if Battery Strength feature is available */
+				hidinput_setup_battery(hid, HID_FEATURE_REPORT, rep->field[i]);
+
+				if (drv->feature_mapping)
+					drv->feature_mapping(hid, rep->field[i],
+							     rep->field[i]->usage + j);
+			}
 }
 
 /*
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 214801d..49d116e 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -495,7 +495,8 @@ struct hid_device {							/* device report descriptor */
 	struct power_supply battery;
 	__s32 battery_min;
 	__s32 battery_max;
-	__s32 battery_val;
+	__s32 battery_report_type;
+	__s32 battery_report_id;
 #endif
 
 	unsigned int status;						/* see STAT flags above */
@@ -735,6 +736,8 @@ int hid_parse_report(struct hid_device *hid, __u8 *start, unsigned size);
 int hid_check_keys_pressed(struct hid_device *hid);
 int hid_connect(struct hid_device *hid, unsigned int connect_mask);
 void hid_disconnect(struct hid_device *hid);
+const struct hid_device_id *hid_match_id(struct hid_device *hdev,
+					 const struct hid_device_id *id);
 
 /**
  * hid_map_usage - map usage input bits



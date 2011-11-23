From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [PATCH RFC] hid-input: add support for HID devices reporting Battery
 Strength
Date: Wed, 23 Nov 2011 00:49:14 -0800
Message-ID: <4ECCB38A.8000503@goop.org>
References: <4EC75224.7070207@goop.org> <alpine.LNX.2.00.1111191212140.15187@pobox.suse.cz> <4EC820F8.4070900@goop.org> <alpine.LNX.2.00.1111201110480.15187@pobox.suse.cz> <4ECA7E7D.80207@goop.org> <alpine.LNX.2.00.1111220028130.28728@pobox.suse.cz> <4ECAE019.4000409@goop.org> <alpine.LNX.2.00.1111220049470.28728@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from claw.goop.org ([74.207.240.146]:52257 "EHLO claw.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750959Ab1KWItQ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Nov 2011 03:49:16 -0500
In-Reply-To: <alpine.LNX.2.00.1111220049470.28728@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, vojtech@ucw.cz, Przemo Firszt <przemo@firszt.eu>

Some HID devices, such as my Bluetooth mouse, report their battery
strength as an event.  Rather than passing it through as a strange
absolute input event, this patch registers it with the power_supply
subsystem as a battery, so that the device's Battery Strength can be
reported to usermode.

The battery appears in sysfs names
/sys/class/power_supply/hid-<UNIQ>-battery, and it is a child of the
battery-containing device, so it should be clear what it's the battery of.

Unfortunately on my current Fedora 16 system, while the battery does
appear in the UI, it is listed as a Laptop Battery with 0% charge (since
it ignores the "capacity" property of the battery and instead computes
it from the "energy*" fields, which we can't supply given the limited
information contained within the HID Report).

Still, this patch is the first step.

Signed-off-by: Jeremy Fitzhardinge <jeremy@goop.org>

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 22a4a05..3a97f1f 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -31,6 +31,11 @@ config HID
 
 	  If unsure, say Y.
 
+config HID_BATTERY_STRENGTH
+	bool
+	depends on POWER_SUPPLY
+	default y
+
 config HIDRAW
 	bool "/dev/hidraw raw HID device support"
 	depends on HID
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index f333139..83afb86 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -271,6 +271,97 @@ static __s32 hidinput_calc_abs_res(const struct hid_field *field, __u16 code)
 	return logical_extents / physical_extents;
 }
 
+#ifdef CONFIG_HID_BATTERY_STRENGTH
+static enum power_supply_property hidinput_battery_props[] = {
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+};
+
+static int hidinput_get_battery_property(struct power_supply *psy,
+					 enum power_supply_property prop,
+					 union power_supply_propval *val)
+{
+	struct hid_device *dev = container_of(psy, struct hid_device, battery);
+	int ret = 0;
+
+	switch (prop) {
+	case POWER_SUPPLY_PROP_PRESENT:
+	case POWER_SUPPLY_PROP_ONLINE:
+		val->intval = 1;
+		break;
+
+	case POWER_SUPPLY_PROP_CAPACITY:
+		if (dev->battery_min < dev->battery_max &&
+		    dev->battery_val >= dev->battery_min &&
+		    dev->battery_val <= dev->battery_max)
+			val->intval = (100 * (dev->battery_val - dev->battery_min)) /
+				(dev->battery_max - dev->battery_min);
+		else
+			ret = -EINVAL;
+		break;
+
+	case POWER_SUPPLY_PROP_MODEL_NAME:
+		val->strval = dev->name;
+		break;
+
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static void hidinput_setup_battery(struct hid_device *dev, s32 min, s32 max)
+{
+	struct power_supply *battery = &dev->battery;
+	int ret;
+
+	if (battery->name != NULL)
+		return;		/* already initialized? */
+
+	battery->name = kasprintf(GFP_KERNEL, "hid-%s-battery", dev->uniq);
+	if (battery->name == NULL)
+		return;
+
+	battery->type = POWER_SUPPLY_TYPE_BATTERY;
+	battery->properties = hidinput_battery_props;
+	battery->num_properties = ARRAY_SIZE(hidinput_battery_props);
+	battery->use_for_apm = 0;
+	battery->get_property = hidinput_get_battery_property;
+
+	dev->battery_min = min;
+	dev->battery_max = max;
+
+	ret = power_supply_register(&dev->dev, battery);
+	if (ret != 0) {
+		hid_warn(dev, "can't register power supply: %d\n", ret);
+		kfree(battery->name);
+		battery->name = NULL;
+	}
+}
+
+static void hidinput_cleanup_battery(struct hid_device *dev)
+{
+	if (!dev->battery.name)
+		return;
+
+	power_supply_unregister(&dev->battery);
+	kfree(dev->battery.name);
+	dev->battery.name = NULL;
+}
+#else  /* !CONFIG_HID_BATTERY_STRENGTH */
+static void hidinput_setup_battery(struct hid_device *dev, s32 min, s32 max)
+{
+}
+
+static void hidinput_cleanup_battery(struct hid_device *dev)
+{
+}
+#endif	/* CONFIG_HID_BATTERY_STRENGTH */
+
 static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_field *field,
 				     struct hid_usage *usage)
 {
@@ -629,6 +720,16 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		}
 		break;
 
+	case HID_UP_GENDEVCTRLS:
+		if ((usage->hid & HID_USAGE) == 0x20) {	/* Battery Strength */
+			hidinput_setup_battery(device,
+					       field->logical_minimum,
+					       field->logical_maximum);
+			goto ignore;
+		} else
+			goto unknown;
+		break;
+
 	case HID_UP_HPVENDOR:	/* Reported on a Dutch layout HP5308 */
 		set_bit(EV_REP, input->evbit);
 		switch (usage->hid & HID_USAGE) {
@@ -760,6 +861,13 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
 
 	input = field->hidinput->input;
 
+	if (usage->hid == HID_DC_BATTERYSTRENGTH) {
+		hid->battery_val = value;
+		hid_dbg(hid, "battery value is %d (range %d-%d)\n",
+			value, hid->battery_min, hid->battery_max);
+		return;
+	}
+
 	if (!usage->type)
 		return;
 
@@ -1010,6 +1118,8 @@ void hidinput_disconnect(struct hid_device *hid)
 {
 	struct hid_input *hidinput, *next;
 
+	hidinput_cleanup_battery(hid);
+
 	list_for_each_entry_safe(hidinput, next, &hid->inputs, list) {
 		list_del(&hidinput->list);
 		input_unregister_device(hidinput->input);
diff --git a/include/linux/hid.h b/include/linux/hid.h
index c235e4e..214801d 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -72,6 +72,7 @@
 #include <linux/workqueue.h>
 #include <linux/input.h>
 #include <linux/semaphore.h>
+#include <linux/power_supply.h>
 
 /*
  * We parse each description item into this structure. Short items data
@@ -190,6 +191,7 @@ struct hid_item {
 #define HID_UP_UNDEFINED	0x00000000
 #define HID_UP_GENDESK		0x00010000
 #define HID_UP_SIMULATION	0x00020000
+#define HID_UP_GENDEVCTRLS	0x00060000
 #define HID_UP_KEYBOARD		0x00070000
 #define HID_UP_LED		0x00080000
 #define HID_UP_BUTTON		0x00090000
@@ -239,6 +241,8 @@ struct hid_item {
 #define HID_GD_RIGHT		0x00010092
 #define HID_GD_LEFT		0x00010093
 
+#define HID_DC_BATTERYSTRENGTH	0x00060020
+
 #define HID_DG_DIGITIZER	0x000d0001
 #define HID_DG_PEN		0x000d0002
 #define HID_DG_LIGHTPEN		0x000d0003
@@ -482,6 +486,18 @@ struct hid_device {							/* device report descriptor */
 	struct hid_driver *driver;
 	struct hid_ll_driver *ll_driver;
 
+#ifdef CONFIG_HID_BATTERY_STRENGTH
+	/*
+	 * Power supply information for HID devices which report
+	 * battery strength. power_supply is registered iff
+	 * battery.name is non-NULL.
+	 */
+	struct power_supply battery;
+	__s32 battery_min;
+	__s32 battery_max;
+	__s32 battery_val;
+#endif
+
 	unsigned int status;						/* see STAT flags above */
 	unsigned claimed;						/* Claimed by hidinput, hiddev? */
 	unsigned quirks;						/* Various quirks the device can pull on us */



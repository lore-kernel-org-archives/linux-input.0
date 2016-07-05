From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 09/27] HID: wacom: convert LEDs to devres
Date: Tue,  5 Jul 2016 16:39:05 +0200
Message-ID: <1467729563-23318-10-git-send-email-benjamin.tissoires@redhat.com>
References: <1467729563-23318-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467729563-23318-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Aaron Skomra <skomra@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Use our own wacom_devm_sysfs_create_group() as there is currently no
generic one. It has been requested at least twice [1][2] but has been
always rejected.
However, in the Wacom case, for the wirelessly connected devices, we need
to be able to release the created sysfs files without removing the parent
kobject.

[1] https://patchwork.kernel.org/patch/7526551/
[2] https://lkml.org/lkml/2013/3/14/728

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/wacom.h     |  1 -
 drivers/hid/wacom_sys.c | 95 +++++++++++++++++++++++--------------------------
 2 files changed, 45 insertions(+), 51 deletions(-)

diff --git a/drivers/hid/wacom.h b/drivers/hid/wacom.h
index 6f5555f..bcfeb51 100644
--- a/drivers/hid/wacom.h
+++ b/drivers/hid/wacom.h
@@ -124,7 +124,6 @@ struct wacom {
 		u8 hlv;       /* status led brightness button pressed (1..127) */
 		u8 img_lum;   /* OLED matrix display brightness */
 	} led;
-	bool led_initialized;
 	struct power_supply *battery;
 	struct power_supply *ac;
 	struct power_supply_desc battery_desc;
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 08f6d1f..c08a752 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -909,6 +909,45 @@ static struct attribute_group intuos5_led_attr_group = {
 	.attrs = intuos5_led_attrs,
 };
 
+struct wacom_sysfs_group_devres {
+	struct attribute_group *group;
+	struct kobject *root;
+};
+
+static void wacom_devm_sysfs_group_release(struct device *dev, void *res)
+{
+	struct wacom_sysfs_group_devres *devres = res;
+	struct kobject *kobj = devres->root;
+
+	dev_dbg(dev, "%s: dropping reference to %s\n",
+		__func__, devres->group->name);
+	sysfs_remove_group(kobj, devres->group);
+}
+
+static int wacom_devm_sysfs_create_group(struct wacom *wacom,
+					 struct attribute_group *group)
+{
+	struct wacom_sysfs_group_devres *devres;
+	int error;
+
+	devres = devres_alloc(wacom_devm_sysfs_group_release,
+			      sizeof(struct wacom_sysfs_group_devres),
+			      GFP_KERNEL);
+	if (!devres)
+		return -ENOMEM;
+
+	devres->group = group;
+	devres->root = &wacom->hdev->dev.kobj;
+
+	error = sysfs_create_group(devres->root, group);
+	if (error)
+		return error;
+
+	devres_add(&wacom->hdev->dev, devres);
+
+	return 0;
+}
+
 static int wacom_initialize_leds(struct wacom *wacom)
 {
 	int error;
@@ -927,8 +966,8 @@ static int wacom_initialize_leds(struct wacom *wacom)
 		wacom->led.llv = 10;
 		wacom->led.hlv = 20;
 		wacom->led.img_lum = 10;
-		error = sysfs_create_group(&wacom->hdev->dev.kobj,
-					   &intuos4_led_attr_group);
+		error = wacom_devm_sysfs_create_group(wacom,
+						      &intuos4_led_attr_group);
 		break;
 
 	case WACOM_24HD:
@@ -939,8 +978,8 @@ static int wacom_initialize_leds(struct wacom *wacom)
 		wacom->led.hlv = 0;
 		wacom->led.img_lum = 0;
 
-		error = sysfs_create_group(&wacom->hdev->dev.kobj,
-					   &cintiq_led_attr_group);
+		error = wacom_devm_sysfs_create_group(wacom,
+						      &cintiq_led_attr_group);
 		break;
 
 	case INTUOS5S:
@@ -955,8 +994,8 @@ static int wacom_initialize_leds(struct wacom *wacom)
 		wacom->led.hlv = 0;
 		wacom->led.img_lum = 0;
 
-		error = sysfs_create_group(&wacom->hdev->dev.kobj,
-					  &intuos5_led_attr_group);
+		error = wacom_devm_sysfs_create_group(wacom,
+						      &intuos5_led_attr_group);
 		break;
 
 	default:
@@ -969,48 +1008,10 @@ static int wacom_initialize_leds(struct wacom *wacom)
 		return error;
 	}
 	wacom_led_control(wacom);
-	wacom->led_initialized = true;
 
 	return 0;
 }
 
-static void wacom_destroy_leds(struct wacom *wacom)
-{
-	if (!wacom->led_initialized)
-		return;
-
-	if (!(wacom->wacom_wac.features.device_type & WACOM_DEVICETYPE_PAD))
-		return;
-
-	wacom->led_initialized = false;
-
-	switch (wacom->wacom_wac.features.type) {
-	case INTUOS4S:
-	case INTUOS4:
-	case INTUOS4WL:
-	case INTUOS4L:
-		sysfs_remove_group(&wacom->hdev->dev.kobj,
-				   &intuos4_led_attr_group);
-		break;
-
-	case WACOM_24HD:
-	case WACOM_21UX2:
-		sysfs_remove_group(&wacom->hdev->dev.kobj,
-				   &cintiq_led_attr_group);
-		break;
-
-	case INTUOS5S:
-	case INTUOS5:
-	case INTUOS5L:
-	case INTUOSPS:
-	case INTUOSPM:
-	case INTUOSPL:
-		sysfs_remove_group(&wacom->hdev->dev.kobj,
-				   &intuos5_led_attr_group);
-		break;
-	}
-}
-
 static enum power_supply_property wacom_battery_props[] = {
 	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_STATUS,
@@ -1729,7 +1730,6 @@ fail_quirks:
 fail_hw_start:
 	kobject_put(wacom->remote_dir);
 fail_remote:
-	wacom_destroy_leds(wacom);
 fail_leds:
 fail_register_inputs:
 fail_battery:
@@ -1763,14 +1763,12 @@ static void wacom_wireless_work(struct work_struct *work)
 	hdev1 = usb_get_intfdata(usbdev->config->interface[1]);
 	wacom1 = hid_get_drvdata(hdev1);
 	wacom_wac1 = &(wacom1->wacom_wac);
-	wacom_destroy_leds(wacom1);
 	wacom_release_resources(wacom1);
 
 	/* Touch interface */
 	hdev2 = usb_get_intfdata(usbdev->config->interface[2]);
 	wacom2 = hid_get_drvdata(hdev2);
 	wacom_wac2 = &(wacom2->wacom_wac);
-	wacom_destroy_leds(wacom2);
 	wacom_release_resources(wacom2);
 
 	if (wacom_wac->pid == 0) {
@@ -1825,9 +1823,7 @@ static void wacom_wireless_work(struct work_struct *work)
 	return;
 
 fail:
-	wacom_destroy_leds(wacom1);
 	wacom_release_resources(wacom1);
-	wacom_destroy_leds(wacom2);
 	wacom_release_resources(wacom2);
 	return;
 }
@@ -1917,7 +1913,6 @@ static void wacom_remove(struct hid_device *hdev)
 	cancel_work_sync(&wacom->wireless_work);
 	cancel_work_sync(&wacom->battery_work);
 	kobject_put(wacom->remote_dir);
-	wacom_destroy_leds(wacom);
 	if (hdev->bus == BUS_BLUETOOTH)
 		device_remove_file(&hdev->dev, &dev_attr_speed);
 	wacom_remove_shared_data(wacom);
-- 
2.5.5

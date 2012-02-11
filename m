From: chris@cnpbagwell.com
Subject: [PATCH v3 4/7] Input: wacom - wireless Bamboo battery status
Date: Sat, 11 Feb 2012 15:55:31 -0600
Message-ID: <1328997334-24140-5-git-send-email-chris@cnpbagwell.com>
References: <1328997334-24140-1-git-send-email-chris@cnpbagwell.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:61504 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752837Ab2BKVzp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 11 Feb 2012 16:55:45 -0500
Received: by mail-tul01m020-f174.google.com with SMTP id va7so5156955obc.19
        for <linux-input@vger.kernel.org>; Sat, 11 Feb 2012 13:55:45 -0800 (PST)
In-Reply-To: <1328997334-24140-1-git-send-email-chris@cnpbagwell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, Ping Cheng <pinglinux@gmail.com>
Cc: Chris Bagwell <chris@cnpbagwell.com>

From: Chris Bagwell <chris@cnpbagwell.com>

Signed-off-by: Chris Bagwell <chris@cnpbagwell.com>
---
 drivers/input/tablet/Kconfig     |    1 +
 drivers/input/tablet/wacom.h     |    2 +
 drivers/input/tablet/wacom_sys.c |   57 +++++++++++++++++++++++++++++++++++++-
 drivers/input/tablet/wacom_wac.c |    5 ++-
 drivers/input/tablet/wacom_wac.h |    1 +
 5 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/drivers/input/tablet/Kconfig b/drivers/input/tablet/Kconfig
index 58a8775..0edeb94 100644
--- a/drivers/input/tablet/Kconfig
+++ b/drivers/input/tablet/Kconfig
@@ -76,6 +76,7 @@ config TABLET_USB_KBTAB
 config TABLET_USB_WACOM
 	tristate "Wacom Intuos/Graphire tablet support (USB)"
 	depends on USB_ARCH_HAS_HCD
+	select POWER_SUPPLY
 	select USB
 	help
 	  Say Y here if you want to use the USB version of the Wacom Intuos
diff --git a/drivers/input/tablet/wacom.h b/drivers/input/tablet/wacom.h
index febbfd9..b4842d0 100644
--- a/drivers/input/tablet/wacom.h
+++ b/drivers/input/tablet/wacom.h
@@ -88,6 +88,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/init.h>
 #include <linux/usb/input.h>
+#include <linux/power_supply.h>
 #include <asm/unaligned.h>
 
 /*
@@ -121,6 +122,7 @@ struct wacom {
 		u8 hlv;       /* status led brightness button pressed (1..127) */
 		u8 img_lum;   /* OLED matrix display brightness */
 	} led;
+	struct power_supply battery;
 };
 
 static inline void wacom_schedule_work(struct wacom_wac *wacom_wac)
diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index 40e0358..b09d939 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -843,6 +843,55 @@ static void wacom_destroy_leds(struct wacom *wacom)
 	}
 }
 
+static enum power_supply_property wacom_battery_props[] = {
+	POWER_SUPPLY_PROP_CAPACITY
+};
+
+static int wacom_battery_get_property(struct power_supply *psy,
+				      enum power_supply_property psp,
+				      union power_supply_propval *val)
+{
+	struct wacom *wacom = container_of(psy, struct wacom, battery);
+	int ret = 0;
+
+	switch (psp) {
+		case POWER_SUPPLY_PROP_CAPACITY:
+			val->intval =
+				wacom->wacom_wac.battery_capacity * 100 / 31;
+			break;
+		default:
+			ret = -EINVAL;
+			break;
+	}
+
+	return ret;
+}
+static int wacom_initialize_battery(struct wacom *wacom)
+{
+	int error = 0;
+
+	if (wacom->wacom_wac.features.quirks & WACOM_QUIRK_MONITOR) {
+		wacom->battery.properties = wacom_battery_props;
+		wacom->battery.num_properties = ARRAY_SIZE(wacom_battery_props);
+		wacom->battery.get_property = wacom_battery_get_property;
+		wacom->battery.name = "wacom_battery";
+		wacom->battery.type = POWER_SUPPLY_TYPE_BATTERY;
+		wacom->battery.use_for_apm = 0;
+
+		error = power_supply_register(&wacom->usbdev->dev,
+					      &wacom->battery);
+	}
+
+	return error;
+}
+
+static void wacom_destroy_battery(struct wacom *wacom)
+{
+	if (wacom->wacom_wac.features.quirks & WACOM_QUIRK_MONITOR) {
+		power_supply_unregister(&wacom->battery);
+	}
+}
+
 static int wacom_register_input(struct wacom *wacom)
 {
 	struct input_dev *input_dev;
@@ -1021,10 +1070,14 @@ static int wacom_probe(struct usb_interface *intf, const struct usb_device_id *i
 			goto fail5;
 	}
 
+	error = wacom_initialize_battery(wacom);
+	if (error)
+		goto fail5;
+
 	if (!(features->quirks & WACOM_QUIRK_NO_INPUT)) {
 		error = wacom_register_input(wacom);
 		if (error)
-			goto fail5;
+			goto fail6;
 	}
 
 	/* Note that if query fails it is not a hard failure */
@@ -1033,6 +1086,7 @@ static int wacom_probe(struct usb_interface *intf, const struct usb_device_id *i
 	usb_set_intfdata(intf, wacom);
 	return 0;
 
+ fail6: wacom_destroy_battery(wacom);
  fail5: wacom_destroy_leds(wacom);
  fail4:	wacom_remove_shared_data(wacom_wac);
  fail3:	usb_free_urb(wacom->irq);
@@ -1051,6 +1105,7 @@ static void wacom_disconnect(struct usb_interface *intf)
 	cancel_work_sync(&wacom->work);
 	if (wacom->wacom_wac.input)
 		input_unregister_device(wacom->wacom_wac.input);
+	wacom_destroy_battery(wacom);
 	wacom_destroy_leds(wacom);
 	usb_free_urb(wacom->irq);
 	usb_free_coherent(interface_to_usbdev(intf), WACOM_PKGLEN_MAX,
diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index b649eba..a30f229 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -1054,17 +1054,20 @@ static int wacom_bpt_wireless_irq(struct wacom_wac *wacom, size_t len)
 
 	connected = data[1] & 0x01;
 	if (connected) {
-		int pid;
+		int pid, battery;
 
 		pid = get_unaligned_be16(&data[6]);
+		battery = data[5] & 0x3f;
 		if (wacom->pid != pid) {
 			wacom->pid = pid;
 			wacom_schedule_work(wacom);
 		}
+		wacom->battery_capacity = battery;
 	} else if (wacom->pid != 0) {
 		/* disconnected while previously connected */
 		wacom->pid = 0;
 		wacom_schedule_work(wacom);
+		wacom->battery_capacity = 0;
 	}
 
 	return 0;
diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/wacom_wac.h
index 873b9bf..2d5e9ee 100644
--- a/drivers/input/tablet/wacom_wac.h
+++ b/drivers/input/tablet/wacom_wac.h
@@ -112,6 +112,7 @@ struct wacom_wac {
 	struct wacom_shared *shared;
 	struct input_dev *input;
 	int pid;
+	int battery_capacity;
 };
 
 #endif
-- 
1.7.7.6


From: chris@cnpbagwell.com
Subject: [PATCH 1/2] input: wacom - battery reporting improvements
Date: Sun, 20 May 2012 20:43:31 -0500
Message-ID: <1337564612-15301-1-git-send-email-chris@cnpbagwell.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:56028 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755209Ab2EUBnk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 20 May 2012 21:43:40 -0400
Received: by obbtb18 with SMTP id tb18so7412505obb.19
        for <linux-input@vger.kernel.org>; Sun, 20 May 2012 18:43:39 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, pinglinux@gmail.com
Cc: Chris Bagwell <chris@cnpbagwell.com>

From: Chris Bagwell <chris@cnpbagwell.com>

Do not register battery device until connected to a tablet.
This prevents an empty battery icon from being shown when tablet is
connected using USB cable.

Also, call power_supply_powers() for apps that can make use of that
info.

And stop ignoring input registration failures.

Signed-off-by: Chris Bagwell <chris@cnpbagwell.com>
---
 drivers/input/tablet/wacom_sys.c |   82 ++++++++++++++++++++++++--------------
 1 file changed, 53 insertions(+), 29 deletions(-)

diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index b3a8bd3..74b7725 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -967,6 +967,10 @@ static int wacom_initialize_battery(struct wacom *wacom)
 
 		error = power_supply_register(&wacom->usbdev->dev,
 					      &wacom->battery);
+
+		if (!error)
+			power_supply_powers(&wacom->battery,
+					    &wacom->usbdev->dev);
 	}
 
 	return error;
@@ -974,8 +978,11 @@ static int wacom_initialize_battery(struct wacom *wacom)
 
 static void wacom_destroy_battery(struct wacom *wacom)
 {
-	if (wacom->wacom_wac.features.quirks & WACOM_QUIRK_MONITOR)
+	if (wacom->wacom_wac.features.quirks & WACOM_QUIRK_MONITOR &&
+	    wacom->battery.dev) {
 		power_supply_unregister(&wacom->battery);
+		wacom->battery.dev = NULL;
+	}
 }
 
 static int wacom_register_input(struct wacom *wacom)
@@ -1022,23 +1029,30 @@ static void wacom_wireless_work(struct work_struct *work)
 	struct wacom *wacom = container_of(work, struct wacom, work);
 	struct usb_device *usbdev = wacom->usbdev;
 	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
+	struct wacom *wacom1, *wacom2;
+	struct wacom_wac *wacom_wac1, *wacom_wac2;
+	int error;
 
 	/*
 	 * Regardless if this is a disconnect or a new tablet,
-	 * remove any existing input devices.
+	 * remove any existing input and battery devices.
 	 */
 
+	wacom_destroy_battery(wacom);
+
 	/* Stylus interface */
-	wacom = usb_get_intfdata(usbdev->config->interface[1]);
-	if (wacom->wacom_wac.input)
-		input_unregister_device(wacom->wacom_wac.input);
-	wacom->wacom_wac.input = NULL;
+	wacom1 = usb_get_intfdata(usbdev->config->interface[1]);
+	wacom_wac1 = &(wacom1->wacom_wac);
+	if (wacom_wac1->input)
+		input_unregister_device(wacom_wac1->input);
+	wacom_wac1->input = NULL;
 
 	/* Touch interface */
-	wacom = usb_get_intfdata(usbdev->config->interface[2]);
-	if (wacom->wacom_wac.input)
-		input_unregister_device(wacom->wacom_wac.input);
-	wacom->wacom_wac.input = NULL;
+	wacom2 = usb_get_intfdata(usbdev->config->interface[2]);
+	wacom_wac2 = &(wacom2->wacom_wac);
+	if (wacom_wac2->input)
+		input_unregister_device(wacom_wac2->input);
+	wacom_wac2->input = NULL;
 
 	if (wacom_wac->pid == 0) {
 		dev_info(&wacom->intf->dev, "wireless tablet disconnected\n");
@@ -1063,24 +1077,39 @@ static void wacom_wireless_work(struct work_struct *work)
 		}
 
 		/* Stylus interface */
-		wacom = usb_get_intfdata(usbdev->config->interface[1]);
-		wacom_wac = &wacom->wacom_wac;
-		wacom_wac->features =
+		wacom_wac1->features =
 			*((struct wacom_features *)id->driver_info);
-		wacom_wac->features.device_type = BTN_TOOL_PEN;
-		wacom_register_input(wacom);
+		wacom_wac1->features.device_type = BTN_TOOL_PEN;
+		error = wacom_register_input(wacom1);
+		if (error)
+			goto fail1;
 
 		/* Touch interface */
-		wacom = usb_get_intfdata(usbdev->config->interface[2]);
-		wacom_wac = &wacom->wacom_wac;
-		wacom_wac->features =
+		wacom_wac2->features =
 			*((struct wacom_features *)id->driver_info);
-		wacom_wac->features.pktlen = WACOM_PKGLEN_BBTOUCH3;
-		wacom_wac->features.device_type = BTN_TOOL_FINGER;
-		wacom_set_phy_from_res(&wacom_wac->features);
-		wacom_wac->features.x_max = wacom_wac->features.y_max = 4096;
-		wacom_register_input(wacom);
+		wacom_wac2->features.pktlen = WACOM_PKGLEN_BBTOUCH3;
+		wacom_wac2->features.device_type = BTN_TOOL_FINGER;
+		wacom_set_phy_from_res(&wacom_wac2->features);
+		wacom_wac2->features.x_max = wacom_wac2->features.y_max = 4096;
+		error = wacom_register_input(wacom2);
+		if (error)
+			goto fail2;
+
+		error = wacom_initialize_battery(wacom);
+		if (error)
+			goto fail3;
 	}
+
+	return;
+
+fail3:
+	input_unregister_device(wacom_wac2->input);
+	wacom_wac2->input = NULL;
+fail2:
+	input_unregister_device(wacom_wac1->input);
+	wacom_wac1->input = NULL;
+fail1:
+	return;
 }
 
 static int wacom_probe(struct usb_interface *intf, const struct usb_device_id *id)
@@ -1183,14 +1212,10 @@ static int wacom_probe(struct usb_interface *intf, const struct usb_device_id *i
 	if (error)
 		goto fail4;
 
-	error = wacom_initialize_battery(wacom);
-	if (error)
-		goto fail5;
-
 	if (!(features->quirks & WACOM_QUIRK_NO_INPUT)) {
 		error = wacom_register_input(wacom);
 		if (error)
-			goto fail6;
+			goto fail5;
 	}
 
 	/* Note that if query fails it is not a hard failure */
@@ -1205,7 +1230,6 @@ static int wacom_probe(struct usb_interface *intf, const struct usb_device_id *i
 
 	return 0;
 
- fail6: wacom_destroy_battery(wacom);
  fail5: wacom_destroy_leds(wacom);
  fail4:	wacom_remove_shared_data(wacom_wac);
  fail3:	usb_free_urb(wacom->irq);
-- 
1.7.10.1


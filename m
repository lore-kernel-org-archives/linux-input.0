From: chris@cnpbagwell.com
Subject: [PATCH v4 1/4] Input: wacom - isolate input registration
Date: Tue, 13 Mar 2012 19:51:59 -0500
Message-ID: <1331686322-4914-2-git-send-email-chris@cnpbagwell.com>
References: <1331686322-4914-1-git-send-email-chris@cnpbagwell.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:51988 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964938Ab2CNAwP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Mar 2012 20:52:15 -0400
Received: by mail-yx0-f174.google.com with SMTP id l12so1239758yen.19
        for <linux-input@vger.kernel.org>; Tue, 13 Mar 2012 17:52:15 -0700 (PDT)
In-Reply-To: <1331686322-4914-1-git-send-email-chris@cnpbagwell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, killertofu@gmail.com
Cc: Chris Bagwell <chris@cnpbagwell.com>

From: Chris Bagwell <chris@cnpbagwell.com>

Although this better co-locates input registration logic,
the main goal is to make it easier to optionally create
input devices or delay creation to later time periods.

Signed-off-by: Chris Bagwell <chris@cnpbagwell.com>
---
 drivers/input/tablet/wacom_sys.c |   53 +++++++++++++++++++++++--------------
 1 files changed, 33 insertions(+), 20 deletions(-)

diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index 39205ed..f6da2f8 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -822,6 +822,37 @@ static void wacom_destroy_leds(struct wacom *wacom)
 	}
 }
 
+static int wacom_register_input(struct wacom *wacom)
+{
+	struct input_dev *input_dev;
+	struct usb_interface *intf = wacom->intf;
+	struct usb_device *dev = interface_to_usbdev(intf);
+	struct wacom_wac *wacom_wac = &(wacom->wacom_wac);
+	int error;
+
+	input_dev = input_allocate_device();
+	if (!input_dev)
+		return -ENOMEM;
+
+	input_dev->name = wacom_wac->name;
+	input_dev->dev.parent = &intf->dev;
+	input_dev->open = wacom_open;
+	input_dev->close = wacom_close;
+	usb_to_input_id(dev, &input_dev->id);
+	input_set_drvdata(input_dev, wacom);
+
+	wacom_wac->input = input_dev;
+	wacom_setup_input_capabilities(input_dev, wacom_wac);
+
+	error = input_register_device(input_dev);
+	if (error) {
+		input_free_device(input_dev);
+		wacom_wac->input = NULL;
+	}
+
+	return error;
+}
+
 static int wacom_probe(struct usb_interface *intf, const struct usb_device_id *id)
 {
 	struct usb_device *dev = interface_to_usbdev(intf);
@@ -829,18 +860,12 @@ static int wacom_probe(struct usb_interface *intf, const struct usb_device_id *i
 	struct wacom *wacom;
 	struct wacom_wac *wacom_wac;
 	struct wacom_features *features;
-	struct input_dev *input_dev;
 	int error;
 
 	if (!id->driver_info)
 		return -EINVAL;
 
 	wacom = kzalloc(sizeof(struct wacom), GFP_KERNEL);
-	input_dev = input_allocate_device();
-	if (!wacom || !input_dev) {
-		error = -ENOMEM;
-		goto fail1;
-	}
 
 	wacom_wac = &wacom->wacom_wac;
 	wacom_wac->features = *((struct wacom_features *)id->driver_info);
@@ -869,8 +894,6 @@ static int wacom_probe(struct usb_interface *intf, const struct usb_device_id *i
 	usb_make_path(dev, wacom->phys, sizeof(wacom->phys));
 	strlcat(wacom->phys, "/input0", sizeof(wacom->phys));
 
-	wacom_wac->input = input_dev;
-
 	endpoint = &intf->cur_altsetting->endpoint[0].desc;
 
 	/* Retrieve the physical and logical size for OEM devices */
@@ -894,15 +917,6 @@ static int wacom_probe(struct usb_interface *intf, const struct usb_device_id *i
 			goto fail3;
 	}
 
-	input_dev->name = wacom_wac->name;
-	input_dev->dev.parent = &intf->dev;
-	input_dev->open = wacom_open;
-	input_dev->close = wacom_close;
-	usb_to_input_id(dev, &input_dev->id);
-	input_set_drvdata(input_dev, wacom);
-
-	wacom_setup_input_capabilities(input_dev, wacom_wac);
-
 	usb_fill_int_urb(wacom->irq, dev,
 			 usb_rcvintpipe(dev, endpoint->bEndpointAddress),
 			 wacom_wac->data, features->pktlen,
@@ -914,7 +928,7 @@ static int wacom_probe(struct usb_interface *intf, const struct usb_device_id *i
 	if (error)
 		goto fail4;
 
-	error = input_register_device(input_dev);
+	error = wacom_register_input(wacom);
 	if (error)
 		goto fail5;
 
@@ -928,8 +942,7 @@ static int wacom_probe(struct usb_interface *intf, const struct usb_device_id *i
  fail4:	wacom_remove_shared_data(wacom_wac);
  fail3:	usb_free_urb(wacom->irq);
  fail2:	usb_free_coherent(dev, WACOM_PKGLEN_MAX, wacom_wac->data, wacom->data_dma);
- fail1:	input_free_device(input_dev);
-	kfree(wacom);
+ fail1:	kfree(wacom);
 	return error;
 }
 
-- 
1.7.7.6


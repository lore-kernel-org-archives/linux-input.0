From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 3/3] USB: cdc-acm - blacklist IMS PCU device
Date: Mon, 18 Feb 2013 11:05:57 -0800
Message-ID: <1361214357-21205-4-git-send-email-dmitry.torokhov@gmail.com>
References: <1361214357-21205-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:37744 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754628Ab3BRTGO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Feb 2013 14:06:14 -0500
In-Reply-To: <1361214357-21205-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-usb@vger.kernel.org, Oliver Neukum <oliver@neukum.org>, Chris Healy <chealy@imsco-us.com>

The IMS PCU (Passenger Control Unit) device used custom protocol over serial
line, so it is presenting itself as CDC ACM device.

Now that we have proper in-kernel driver for it we need to black-list the
device in cdc-acm driver.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/usb/class/cdc-acm.c | 13 +++++++++++++
 drivers/usb/class/cdc-acm.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 2d92cce..3c8473d 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -987,6 +987,10 @@ static int acm_probe(struct usb_interface *intf,
 
 	/* normal quirks */
 	quirks = (unsigned long)id->driver_info;
+
+	if (quirks == IGNORE_DEVICE)
+		return -ENODEV;
+
 	num_rx_buf = (quirks == SINGLE_RX_URB) ? 1 : ACM_NR;
 
 	/* handle quirks deadly to normal probing*/
@@ -1691,6 +1695,15 @@ static const struct usb_device_id acm_ids[] = {
 	.driver_info = NO_DATA_INTERFACE,
 	},
 
+#if IS_ENABLED(CONFIG_INPUT_IMS_PCU)
+	{ USB_DEVICE(0x04d8, 0x0082),	/* Application mode */
+	.driver_info = IGNORE_DEVICE,
+	},
+	{ USB_DEVICE(0x04d8, 0x0083),	/* Bootloader mode */
+	.driver_info = IGNORE_DEVICE,
+	},
+#endif
+
 	/* control interfaces without any protocol set */
 	{ USB_INTERFACE_INFO(USB_CLASS_COMM, USB_CDC_SUBCLASS_ACM,
 		USB_CDC_PROTO_NONE) },
diff --git a/drivers/usb/class/cdc-acm.h b/drivers/usb/class/cdc-acm.h
index 35ef887..0f76e4a 100644
--- a/drivers/usb/class/cdc-acm.h
+++ b/drivers/usb/class/cdc-acm.h
@@ -128,3 +128,4 @@ struct acm {
 #define NO_CAP_LINE			4
 #define NOT_A_MODEM			8
 #define NO_DATA_INTERFACE		16
+#define IGNORE_DEVICE			32
-- 
1.7.11.7


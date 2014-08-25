From: Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: [PATCH] HID: add support for PenMount HID TouchScreen Driver
Date: Mon, 25 Aug 2014 16:48:03 +0200
Message-ID: <1408978083-569-1-git-send-email-christian.gmeiner@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:58958 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932613AbaHYOrb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Aug 2014 10:47:31 -0400
Received: by mail-we0-f180.google.com with SMTP id w61so13344720wes.25
        for <linux-input@vger.kernel.org>; Mon, 25 Aug 2014 07:47:29 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Christian Gmeiner <christian.gmeiner@gmail.com>

This driver is a cleaned up version of
http://git.android-x86.org/?p=kernel/cdv.git;a=blob_plain;f=drivers/hid/hid-penmount.c;hb=HEAD

As I only have a PenMount 6000 to test I removed the multi touch support from the dirver.

Bus 002 Device 006: ID 14e1:6000 Dialogue Technology Corp.
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0        64
  idVendor           0x14e1 Dialogue Technology Corp.
  idProduct          0x6000
  bcdDevice           a4.b4
  iManufacturer           1 DIALOGUE INC
  iProduct                2 PenMount USB
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           41
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          4 full speed
    bmAttributes         0xa0
      (Bus Powered)
      Remote Wakeup
    MaxPower              500mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      0 No Subclass
      bInterfaceProtocol      0 None
      iInterface              3 EndPoint1 Interrupt Pipe
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.01
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      76
         Report Descriptors:
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0005  1x 5 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0005  1x 5 bytes
        bInterval               1
Device Status:     0x0000
  (Bus Powered)

Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
 drivers/hid/Kconfig        |   6 ++
 drivers/hid/Makefile       |   1 +
 drivers/hid/hid-core.c     |   1 +
 drivers/hid/hid-ids.h      |   1 +
 drivers/hid/hid-penmount.c | 200 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 209 insertions(+)
 create mode 100644 drivers/hid/hid-penmount.c

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index c18d5d7..0351b66 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -530,6 +530,12 @@ config PANTHERLORD_FF
 	  Say Y here if you have a PantherLord/GreenAsia based game controller
 	  or adapter and want to enable force feedback support for it.
 
+config HID_PENMOUNT
+	tristate "Penmount touch device"
+	depends on USB_HID
+	---help---
+	  Say Y here if you have a Penmount based touch controller.
+
 config HID_PETALYNX
 	tristate "Petalynx Maxter remote control"
 	depends on HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 4dbac7f..e2850d8 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -71,6 +71,7 @@ obj-$(CONFIG_HID_NTRIG)		+= hid-ntrig.o
 obj-$(CONFIG_HID_ORTEK)		+= hid-ortek.o
 obj-$(CONFIG_HID_PRODIKEYS)	+= hid-prodikeys.o
 obj-$(CONFIG_HID_PANTHERLORD)	+= hid-pl.o
+obj-$(CONFIG_HID_PENMOUNT)	+= hid-penmount.o
 obj-$(CONFIG_HID_PETALYNX)	+= hid-petalynx.o
 obj-$(CONFIG_HID_PICOLCD)	+= hid-picolcd.o
 hid-picolcd-y			+= hid-picolcd_core.o
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 12b6e67..6827196 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1880,6 +1880,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_NTRIG, USB_DEVICE_ID_NTRIG_TOUCH_SCREEN_18) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ORTEK, USB_DEVICE_ID_ORTEK_PKB1700) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ORTEK, USB_DEVICE_ID_ORTEK_WKB2000) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_PENMOUNT, USB_DEVICE_ID_PENMOUNT_6000) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_PETALYNX, USB_DEVICE_ID_PETALYNX_MAXTER_REMOTE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_PRIMAX, USB_DEVICE_ID_PRIMAX_KEYBOARD) },
 #if IS_ENABLED(CONFIG_HID_ROCCAT)
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 25cd674..3943ffe 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -722,6 +722,7 @@
 #define USB_DEVICE_ID_PENMOUNT_PCI	0x3500
 #define USB_DEVICE_ID_PENMOUNT_1610	0x1610
 #define USB_DEVICE_ID_PENMOUNT_1640	0x1640
+#define USB_DEVICE_ID_PENMOUNT_6000	0x6000
 
 #define USB_VENDOR_ID_PETALYNX		0x18b1
 #define USB_DEVICE_ID_PETALYNX_MAXTER_REMOTE	0x0037
diff --git a/drivers/hid/hid-penmount.c b/drivers/hid/hid-penmount.c
new file mode 100644
index 0000000..3a630d1
--- /dev/null
+++ b/drivers/hid/hid-penmount.c
@@ -0,0 +1,200 @@
+/*
+ *  HID driver for PenMount touchscreens
+ *
+ *  Copyright (c) 2011 PenMount Touch Solutions <penmount@seed.net.tw>
+ *
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/hid.h>
+#include <linux/version.h>
+#include <linux/input/mt.h>
+#include "hid-ids.h"
+
+struct penmount_priv {
+	u8 touch;
+	bool touching;
+	u16 x;
+	u16 y;
+};
+
+static int penmount_input_mapping(struct hid_device *hdev,
+		struct hid_input *hi, struct hid_field *field,
+		struct hid_usage *usage, unsigned long **bit, int *max)
+{
+	struct input_dev *dev = hi->input;
+	int mapped = 0;
+	
+	switch (usage->hid & HID_USAGE_PAGE) {
+	case HID_UP_GENDESK:
+		switch (usage->hid) {
+		case HID_GD_X:
+			hid_map_usage(hi, usage, bit, max, EV_ABS, ABS_X);
+			mapped = 1;
+			break;
+		case HID_GD_Y:
+			hid_map_usage(hi, usage, bit, max, EV_ABS, ABS_Y);
+			mapped = 1;
+			break;
+		}
+		break;
+	case HID_UP_BUTTON:
+		hid_map_usage(hi, usage, bit, max, EV_KEY, BTN_TOUCH);
+		mapped = 1;
+		break;
+	case HID_UP_DIGITIZER:
+		switch (usage->hid) {
+		case HID_DG_TIPSWITCH:
+			hid_map_usage(hi, usage, bit, max, EV_KEY, BTN_TOUCH);
+			mapped = 1;
+			break;
+		case HID_DG_CONTACTID:
+			input_mt_init_slots(dev, 1, 0);
+			mapped = -1;
+			break;
+		case HID_DG_INRANGE:
+		case HID_DG_CONFIDENCE:
+			mapped = -1;
+			break;
+		}
+		break;
+	}
+
+	return mapped;
+}
+
+static void penmount_process(struct input_dev *dev, struct penmount_priv *priv)
+{
+	if (!priv->touching) {
+		if (priv->touch) {
+			input_report_key(dev, BTN_TOUCH, 1);
+			priv->touching = true;
+		}
+	} else {
+		if (!priv->touch) {
+			input_report_key(dev, BTN_TOUCH, 0);
+			priv->touching = false;
+		}
+	}
+
+	input_report_abs(dev, ABS_X, priv->x);
+	input_report_abs(dev, ABS_Y, priv->y);
+	input_sync(dev);
+	
+	priv->touch = 0;
+}
+
+static int penmount_event(struct hid_device *hdev, struct hid_field *field,
+		struct hid_usage *usage, __s32 value)
+{
+	if (hdev->claimed & HID_CLAIMED_INPUT) {
+		struct penmount_priv *priv = hid_get_drvdata(hdev);
+		struct input_dev *dev = field->hidinput->input;
+
+		switch (usage->hid) {
+		case HID_DG_TIPSWITCH:
+			priv->touch = value;
+			break;
+		case HID_GD_X:
+			priv->x = value;
+			break;
+		case HID_GD_Y:
+			priv->y = value;
+			break;
+		default:
+			/* fallback to the generic hidinput handling */
+			return 0;
+		}
+
+		penmount_process(dev, priv);
+	}
+
+	if ((hdev->claimed & HID_CLAIMED_HIDDEV) && (hdev->hiddev_hid_event))
+		hdev->hiddev_hid_event(hdev, field, usage, value);
+
+	return 1;
+}
+
+static int penmount_probe(struct hid_device *hdev,
+		const struct hid_device_id *id)
+{
+	struct penmount_priv *priv;
+	int ret = 0;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	hid_set_drvdata(hdev, priv);
+
+	ret = hid_parse(hdev);
+	if (ret) {
+		hid_err(hdev, "parse failed\n");
+		goto err_free;
+	}
+
+	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+	if (ret) {
+		hid_err(hdev, "hw start failed\n");
+		goto err_free;
+	}
+
+	return 0;
+
+err_free:
+	kfree(priv);
+	return ret;
+}
+
+static void penmount_remove(struct hid_device *hdev)
+{
+	struct penmount_priv *priv = hid_get_drvdata(hdev);
+
+	hid_hw_stop(hdev);
+	kfree(priv);
+}
+
+static const struct hid_device_id penmount_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_PENMOUNT, USB_DEVICE_ID_PENMOUNT_6000) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, penmount_devices);
+
+static const struct hid_usage_id penmount_usages[] = {
+	{ HID_ANY_ID, HID_ANY_ID, HID_ANY_ID },
+	{ HID_ANY_ID - 1, HID_ANY_ID - 1, HID_ANY_ID - 1 }
+};
+
+static struct hid_driver penmount_driver = {
+	.name = "hid-penmount",
+	.id_table = penmount_devices,
+	.probe = penmount_probe,
+	.remove = penmount_remove,
+	.input_mapping = penmount_input_mapping,
+	.usage_table = penmount_usages,
+	.event = penmount_event,
+};
+
+static int __init penmount_init(void)
+{
+	return hid_register_driver(&penmount_driver);
+}
+
+static void __exit penmount_exit(void)
+{
+	hid_unregister_driver(&penmount_driver);
+}
+
+module_init(penmount_init);
+module_exit(penmount_exit);
+
+MODULE_AUTHOR("PenMount Touch Solutions <penmount@seed.net.tw>");
+MODULE_DESCRIPTION("PenMount HID TouchScreen Driver");
+MODULE_LICENSE("GPL");
-- 
1.9.3


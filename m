From: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH] Add HID_QUIRK_HIDDEV_FORCE and HID_QUIRK_NO_IGNORE
Date: Fri, 16 Apr 2010 17:19:50 +0100
Message-ID: <1271434790.2045.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from slow3-v.mail.gandi.net ([217.70.178.89]:41224 "EHLO
	slow3-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757123Ab0DPQ1Q (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Apr 2010 12:27:16 -0400
Received: from relay4-v.mail.gandi.net (relay4-v.mail.gandi.net [217.70.178.78])
	by slow3-v.mail.gandi.net (Postfix) with ESMTP id 1D5C8380AC
	for <linux-input@vger.kernel.org>; Fri, 16 Apr 2010 18:27:15 +0200 (CEST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>

Add two quirks to make it possible for usbhid module options to
override whether a device is ignored (HID_QUIRK_NO_IGNORE) and
whether to connect a hiddev device (HID_QUIRK_HIDDEV_FORCE).

Passing HID_QUIRK_NO_IGNORE for your device means that it will
not be ignored by the HID layer, even if present in a blacklist.

HID_QUIRK_HIDDEV_FORCE will force the creation of a hiddev for that
device, making it accessible from user-space.

Tested with an Apple IR Receiver, switching it from using appleir
to using lirc's macmini driver.

Signed-off-by: Bastien Nocera <hadess@hadess.net>
---
 drivers/hid/hid-core.c        |    4 +++-
 drivers/hid/usbhid/hid-core.c |    1 +
 include/linux/hid.h           |    2 ++
 3 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index b57e5f7..6ae1ea2 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1172,6 +1172,8 @@ int hid_connect(struct hid_device *hdev, unsigned int connect_mask)
 	unsigned int i;
 	int len;
 
+	if (hdev->quirks & HID_QUIRK_HIDDEV_FORCE)
+		connect_mask |= (HID_CONNECT_HIDDEV_FORCE | HID_CONNECT_HIDDEV);
 	if (hdev->bus != BUS_USB)
 		connect_mask &= ~HID_CONNECT_HIDDEV;
 	if (hid_hiddev(hdev))
@@ -1761,7 +1763,7 @@ int hid_add_device(struct hid_device *hdev)
 
 	/* we need to kill them here, otherwise they will stay allocated to
 	 * wait for coming driver */
-	if (hid_ignore(hdev))
+	if (!(hdev->quirks & HID_QUIRK_NO_IGNORE) && hid_ignore(hdev))
 		return -ENODEV;
 
 	/* XXX hack, any other cleaner solution after the driver core
diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 56d06cd..cf73e39 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -1140,6 +1140,7 @@ static int usbhid_probe(struct usb_interface *intf, const struct usb_device_id *
 	hid->vendor = le16_to_cpu(dev->descriptor.idVendor);
 	hid->product = le16_to_cpu(dev->descriptor.idProduct);
 	hid->name[0] = 0;
+	hid->quirks = usbhid_lookup_quirk(hid->vendor, hid->product);
 	if (intf->cur_altsetting->desc.bInterfaceProtocol ==
 			USB_INTERFACE_PROTOCOL_MOUSE)
 		hid->type = HID_TYPE_USBMOUSE;
diff --git a/include/linux/hid.h b/include/linux/hid.h
index b1344ec..f1f2b6f 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -308,11 +308,13 @@ struct hid_item {
 #define HID_QUIRK_NOTOUCH			0x00000002
 #define HID_QUIRK_IGNORE			0x00000004
 #define HID_QUIRK_NOGET				0x00000008
+#define HID_QUIRK_HIDDEV_FORCE			0x00000010
 #define HID_QUIRK_BADPAD			0x00000020
 #define HID_QUIRK_MULTI_INPUT			0x00000040
 #define HID_QUIRK_SKIP_OUTPUT_REPORTS		0x00010000
 #define HID_QUIRK_FULLSPEED_INTERVAL		0x10000000
 #define HID_QUIRK_NO_INIT_REPORTS		0x20000000
+#define HID_QUIRK_NO_IGNORE			0x40000000
 
 /*
  * This is the global environment of the parser. This information is
-- 
1.6.6.1



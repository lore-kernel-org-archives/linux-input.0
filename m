From: Pascal Terjan <pterjan@mandriva.com>
Subject: [PATCH] Use hid blacklist in usbmouse/usbkbd
Date: Mon, 26 Nov 2007 11:58:08 +0100
Message-ID: <1196074688.12642.10.camel@plop>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ryu.zarb.org ([212.85.153.228]:44476 "EHLO ryu.zarb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752267AbXKZLUY (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Nov 2007 06:20:24 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linuxwacom-devel@lists.sourceforge.net

Hi,
Some devices are blacklisted in hid-quirks, but still get handled by
usbmouse/usbkbd.

That means that if usbmouse is already loaded when a wacom tablet gets
plugged it, it will take it.

This patch fixes this behaviour by using hid's blacklist in usbmouse
and usbkbd, but I don't know much about interactions between hid and
usbmouse/usbkbd so I'm not sure this is the correct way to do it.

So, please voice you opinion :)

(It has been tested to fix wacom support)

---
 drivers/hid/usbhid/hid-quirks.c |    2 ++
 drivers/hid/usbhid/usbkbd.c     |    6 ++++++
 drivers/hid/usbhid/usbmouse.c   |    6 ++++++
 3 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index a255285..50e4165 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -884,6 +884,8 @@ u32 usbhid_lookup_quirk(const u16 idVendor, const u16 idProduct)
 	return quirks;
 }
 
+EXPORT_SYMBOL_GPL(usbhid_lookup_quirk);
+
 /*
  * Cherry Cymotion keyboard have an invalid HID report descriptor,
  * that needs fixing before we can parse it.
diff --git a/drivers/hid/usbhid/usbkbd.c b/drivers/hid/usbhid/usbkbd.c
index 775a1ef..a9cca6e 100644
--- a/drivers/hid/usbhid/usbkbd.c
+++ b/drivers/hid/usbhid/usbkbd.c
@@ -235,6 +235,12 @@ static int usb_kbd_probe(struct usb_interface *iface,
 	if (!usb_endpoint_is_int_in(endpoint))
 		return -ENODEV;
 
+	if (usbhid_lookup_quirk(le16_to_cpu(dev->descriptor.idVendor),
+				le16_to_cpu(dev->descriptor.idProduct))
+     			& HID_QUIRK_IGNORE) {
+		return -ENODEV;
+	}
+
 	pipe = usb_rcvintpipe(dev, endpoint->bEndpointAddress);
 	maxp = usb_maxpacket(dev, pipe, usb_pipeout(pipe));
 
diff --git a/drivers/hid/usbhid/usbmouse.c b/drivers/hid/usbhid/usbmouse.c
index f8ad691..c403ce9 100644
--- a/drivers/hid/usbhid/usbmouse.c
+++ b/drivers/hid/usbhid/usbmouse.c
@@ -131,6 +131,12 @@ static int usb_mouse_probe(struct usb_interface *intf, const struct usb_device_i
 	if (!usb_endpoint_is_int_in(endpoint))
 		return -ENODEV;
 
+	if (usbhid_lookup_quirk(le16_to_cpu(dev->descriptor.idVendor),
+				le16_to_cpu(dev->descriptor.idProduct))
+     			& (HID_QUIRK_IGNORE|HID_QUIRK_IGNORE_MOUSE)) {
+		return -ENODEV;
+	}
+
 	pipe = usb_rcvintpipe(dev, endpoint->bEndpointAddress);
 	maxp = usb_maxpacket(dev, pipe, usb_pipeout(pipe));
 
-- 
1.5.3.5



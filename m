From: Jindrich Makovicka <makovick@gmail.com>
Subject: [PATCH] HID: check for HID_QUIRK_IGNORE during probing
Date: Sun, 23 May 2010 20:47:25 +0200
Message-ID: <20100523204725.6e9e8dad@holly>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/hzyW5upsQVNVeHIU_Q.oxKF"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:47606 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755119Ab0EWSuE (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 23 May 2010 14:50:04 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glki-linux-input-2@m.gmane.org>)
	id 1OGGFP-0002P9-4j
	for linux-input@vger.kernel.org; Sun, 23 May 2010 20:50:03 +0200
Received: from r11jd148.net.upc.cz ([94.113.7.148])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Sun, 23 May 2010 20:50:03 +0200
Received: from makovick by r11jd148.net.upc.cz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Sun, 23 May 2010 20:50:03 +0200
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

--MP_/hzyW5upsQVNVeHIU_Q.oxKF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

While the hardcoded ignore list is checked in usbhid_probe(), the
user supplied ignore flags are not. Thus, the IGNORE quirk (0x0004)
cannot be used to stop usbhid from binding devices like iBuddy, which
has been recently removed from the ignore list due to product ID
conflict.

This patch adds the user quirk check to usb_probe(), and makes
usb_probe() return -ENODEV when HID_QUIRK_IGNORE bit is set.

With the patch, iBuddy works properly using libusb when the following
option is added to modprobe.d:

options usbhid quirks=0x1130:0x0002:0x0004

Signed-off-by: Jindrich Makovicka <makovick@gmail.com>

-- 
Jindrich Makovicka

--MP_/hzyW5upsQVNVeHIU_Q.oxKF
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=hid-core.c.diff

--- hid-core.c.orig	2010-05-16 23:17:36.000000000 +0200
+++ hid-core.c	2010-05-23 20:23:28.471259245 +0200
@@ -864,8 +864,7 @@ static int usbhid_parse(struct hid_devic
 	quirks = usbhid_lookup_quirk(le16_to_cpu(dev->descriptor.idVendor),
 			le16_to_cpu(dev->descriptor.idProduct));
 
-	if (quirks & HID_QUIRK_IGNORE)
-		return -ENODEV;
+	WARN_ON(quirks & HID_QUIRK_IGNORE);
 
 	/* Many keyboards and mice don't like to be polled for reports,
 	 * so we will always set the HID_QUIRK_NOGET flag for them. */
@@ -1098,6 +1097,7 @@ static int usbhid_probe(struct usb_inter
 	struct usb_device *dev = interface_to_usbdev(intf);
 	struct usbhid_device *usbhid;
 	struct hid_device *hid;
+	u32 quirks = 0;
 	unsigned int n, has_in = 0;
 	size_t len;
 	int ret;
@@ -1114,6 +1114,12 @@ static int usbhid_probe(struct usb_inter
 		return -ENODEV;
 	}
 
+	quirks = usbhid_lookup_quirk(le16_to_cpu(dev->descriptor.idVendor),
+			le16_to_cpu(dev->descriptor.idProduct));
+
+	if (quirks & HID_QUIRK_IGNORE)
+		return -ENODEV;
+
 	hid = hid_allocate_device();
 	if (IS_ERR(hid))
 		return PTR_ERR(hid);

--MP_/hzyW5upsQVNVeHIU_Q.oxKF--



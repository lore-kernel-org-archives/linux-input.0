From: Oliver Neukum <oliver@neukum.org>
Subject: [patch]fix USB HID devices after STD with autosuspend
Date: Wed, 18 Feb 2009 09:46:14 +0100
Message-ID: <200902180946.15593.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out002.kontent.com ([81.88.40.216]:38240 "EHLO
	smtp-out002.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751659AbZBRIob (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Feb 2009 03:44:31 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@jikos.cz, linux-input@vger.kernel.org, USB list <linux-usb@vger.kernel.org>

This patch fixes a bug caused by reset_resume not changing the internal
status flags for a device that is resumed via reset_resume. To do so the
reset handlers, which correctly assume that a device is awake, can no longer
do all the work of reset_resume handling.

Signed-off-by: Oliver Neukum <oneukum@suse.de>
Tested-by: Laurent Riffard <laurent.riffard@free.fr>

Hi,

this is a patch for the linux-next tree and fixes a regression reported
for that tree.

	Regards
		Oliver

--

--- nexttree/drivers/hid/usbhid/hid-core.c.alt	2009-02-17 21:39:45.000000000 +0100
+++ nexttree/drivers/hid/usbhid/hid-core.c	2009-02-17 21:39:57.000000000 +0100
@@ -1333,6 +1333,15 @@ static int hid_post_reset(struct usb_int
 	return 0;
 }
 
+static int hid_reset_resume(struct usb_interface *intf)
+{
+	struct hid_device *hid = usb_get_intfdata(intf);
+	struct usbhid_device *usbhid = hid->driver_data;
+
+	clear_bit(HID_REPORTED_IDLE, &usbhid->iofl);
+	return hid_post_reset(intf);
+}
+
 int usbhid_get_power(struct hid_device *hid)
 {
 	struct usbhid_device *usbhid = hid->driver_data;
@@ -1362,7 +1371,7 @@ static struct usb_driver hid_driver = {
 #ifdef CONFIG_PM
 	.suspend =	hid_suspend,
 	.resume =	hid_resume,
-	.reset_resume =	hid_post_reset,
+	.reset_resume =	hid_reset_resume,
 #endif
 	.pre_reset =	hid_pre_reset,
 	.post_reset =	hid_post_reset,

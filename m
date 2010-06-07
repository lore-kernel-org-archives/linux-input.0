From: Oliver Neukum <oneukum@suse.de>
Subject: [PATCH 1/3] usbtouchscreen: Implement basic suspend/resume
Date: Mon, 7 Jun 2010 15:13:36 +0200
Message-ID: <201006071513.36531.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:36971 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751189Ab0FGNNR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Jun 2010 09:13:17 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-usb@vger.kernel.org, Daniel Ritz <daniel.ritz@gmx.ch>

>From f7c1e2f15bab537c487f935f0701f01705afc90d Mon Sep 17 00:00:00 2001
From: Oliver Neukum <oliver@neukum.org>
Date: Mon, 7 Jun 2010 11:41:15 +0200
Subject: [PATCH 1/3] usbtouchscreen: Implement basic suspend/resume

This implements basic support for suspend & resume

Signed-off-by: Oliver Neukum <oneukum@suse.de>
---
 drivers/input/touchscreen/usbtouchscreen.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
index 567d572..6d23c0e 100644
--- a/drivers/input/touchscreen/usbtouchscreen.c
+++ b/drivers/input/touchscreen/usbtouchscreen.c
@@ -1291,6 +1291,27 @@ static void usbtouch_close(struct input_dev *input)
 		usb_kill_urb(usbtouch->irq);
 }
 
+static int usbtouch_suspend
+(struct usb_interface *intf, pm_message_t message)
+{
+	struct usbtouch_usb *usbtouch = usb_get_intfdata(intf);
+	
+	usb_kill_urb(usbtouch->irq);
+	return 0;
+}
+
+static int usbtouch_resume(struct usb_interface *intf)
+{
+	struct usbtouch_usb *usbtouch = usb_get_intfdata(intf);
+	struct input_dev *input = usbtouch->input;
+	int result = 0;
+	
+	mutex_lock(&input->mutex);
+	if (input->users)
+		result = usb_submit_urb(usbtouch->irq, GFP_NOIO);
+	mutex_unlock(&input->mutex);
+	return result;
+}
 
 static void usbtouch_free_buffers(struct usb_device *udev,
 				  struct usbtouch_usb *usbtouch)
@@ -1481,6 +1502,8 @@ static struct usb_driver usbtouch_driver = {
 	.name		= "usbtouchscreen",
 	.probe		= usbtouch_probe,
 	.disconnect	= usbtouch_disconnect,
+	.suspend	= usbtouch_suspend,
+	.resume		= usbtouch_resume,
 	.id_table	= usbtouch_devices,
 };
 
-- 
1.6.4.2


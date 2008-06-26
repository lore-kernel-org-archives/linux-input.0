From: Oliver Neukum <oliver@neukum.org>
Subject: [patch]fix race between disconnect and open in usbtouch
Date: Thu, 26 Jun 2008 15:32:05 +0200
Message-ID: <200806261532.06544.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:39996 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763018AbYFZNbi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Jun 2008 09:31:38 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: daniel.ritz@gmx.ch, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

Hi,

if you kill the URB before you unregister, open can come in between
and resubmit the urb. This patch reverses the order.

	Regards
		Oliver

Signed-off-by: Oliver Neukum <oneukum@suse.de>

---

--- linux-2.6.26-sierra/drivers/input/touchscreen/usbtouchscreen.c.alt	2008-06-26 15:23:34.000000000 +0200
+++ linux-2.6.26-sierra/drivers/input/touchscreen/usbtouchscreen.c	2008-06-26 15:23:38.000000000 +0200
@@ -973,8 +973,8 @@ static void usbtouch_disconnect(struct u
 
 	dbg("%s - usbtouch is initialized, cleaning up", __FUNCTION__);
 	usb_set_intfdata(intf, NULL);
-	usb_kill_urb(usbtouch->irq);
 	input_unregister_device(usbtouch->input);
+	usb_kill_urb(usbtouch->irq);
 	usb_free_urb(usbtouch->irq);
 	usbtouch_free_buffers(interface_to_usbdev(intf), usbtouch);
 	kfree(usbtouch);

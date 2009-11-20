From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: [patch]race between disconnect and open in usbtouchscreen
Date: Fri, 20 Nov 2009 22:13:47 +0100
Message-ID: <200911202213.47916.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ondrej Zary <linux-ZCIryABCsrmttCpgsWEBFmD2FQJk+8+b@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, Daniel Ritz <daniel.ritz-OI3hZJvNYWs@public.gmane.org>, Dmitry Torokhov <dt>
List-Id: linux-input@vger.kernel.org

Hi,

an open() between killing the urb and unregistering the device
can lead to IO to a disconnected device.

	Regards
		Oliver

Signed-off-by: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>

--

commit e15f9b41115356ca5399f77bbc6b364c41b7f780
Author: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Date:   Fri Nov 20 21:50:38 2009 +0100

    usbtouchscreen: fix race between open and disconnect
    
    the input device must be unregistered before IO is stopped
    so that open cannot restart IO

diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
index 68ece58..6850b0d 100644
--- a/drivers/input/touchscreen/usbtouchscreen.c
+++ b/drivers/input/touchscreen/usbtouchscreen.c
@@ -1087,8 +1087,8 @@ static void usbtouch_disconnect(struct usb_interface *intf)
 
 	dbg("%s - usbtouch is initialized, cleaning up", __func__);
 	usb_set_intfdata(intf, NULL);
-	usb_kill_urb(usbtouch->irq);
 	input_unregister_device(usbtouch->input);
+	usb_kill_urb(usbtouch->irq);
 	usb_free_urb(usbtouch->irq);
 	usbtouch_free_buffers(interface_to_usbdev(intf), usbtouch);
 	kfree(usbtouch);

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

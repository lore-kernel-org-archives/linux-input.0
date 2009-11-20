From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [patch]race between disconnect and open in usbtouchscreen
Date: Fri, 20 Nov 2009 22:49:56 +0100
Message-ID: <200911202249.56591.oliver@neukum.org>
References: <200911202213.47916.oliver@neukum.org> <20091120212259.GC16447@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out002.kontent.com ([81.88.40.216]:56214 "EHLO
	smtp-out002.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753928AbZKTVts (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Nov 2009 16:49:48 -0500
In-Reply-To: <20091120212259.GC16447@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, Ondrej Zary <linux@rainbow-software.org>, Jiri Kosina <jkosina@suse.cz>, Daniel Ritz <daniel.ritz@gmx.ch>

Am Freitag, 20. November 2009 22:22:59 schrieb Dmitry Torokhov:
> Hi Oliver,
> 
> On Fri, Nov 20, 2009 at 10:13:47PM +0100, Oliver Neukum wrote:
> > Hi,
> >
> > an open() between killing the urb and unregistering the device
> > can lead to IO to a disconnected device.
> 
> usbtouch_close() calls usb_kill_urb() so there is no race.
> usb_kill_urb() simply not needed in usbtouch_disconnect().

Then it needs to go.

Signed-off-by: Oliver Neukum <oliver@neukum.org>

	Regards
		Oliver

--

commit 2705666144b8c898283974efc59fd5182e13e652
Author: Oliver Neukum <oliver@neukum.org>
Date:   Fri Nov 20 22:41:04 2009 +0100

    usbtouchscreen:remove unneeded usb_kill_urb
    
    usb_kill_urb() in disconnect is not needed as unregistering
    cause close to be called

diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
index 68ece58..eddb628 100644
--- a/drivers/input/touchscreen/usbtouchscreen.c
+++ b/drivers/input/touchscreen/usbtouchscreen.c
@@ -1087,7 +1087,7 @@ static void usbtouch_disconnect(struct usb_interface *intf)
 
 	dbg("%s - usbtouch is initialized, cleaning up", __func__);
 	usb_set_intfdata(intf, NULL);
-	usb_kill_urb(usbtouch->irq);
+	/* this will stop IO via close */
 	input_unregister_device(usbtouch->input);
 	usb_free_urb(usbtouch->irq);
 	usbtouch_free_buffers(interface_to_usbdev(intf), usbtouch);

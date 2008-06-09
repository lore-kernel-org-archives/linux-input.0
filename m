From: Oliver Neukum <oliver@neukum.org>
Subject: Re: fix appletouch regression bugzilla.kernel.org#10825
Date: Mon, 9 Jun 2008 11:04:16 +0200
Message-ID: <200806091104.17640.oliver@neukum.org>
References: <200806061213.18066.oliver@neukum.org> <20080606094514.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:37459 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758145AbYFIJEA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Jun 2008 05:04:00 -0400
In-Reply-To: <20080606094514.ZZRA012@mailhub.coreip.homeip.net>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg KH <greg@kroah.com>, Justin Mattock <justinmattock@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, USB list <linux-usb@vger.kernel.org>

Am Freitag 06 Juni 2008 16:07:08 schrieb Dmitry Torokhov:
> Hi Oliver,
> 
> On Fri, Jun 06, 2008 at 12:13:17PM +0200, Oliver Neukum wrote:
> > Hi,
> > 
> > this touchpad needs, probably due to a change in timing of suspension,
> > a quirk in 2.6.25 and later. To use this quirk the driver needs to implement
> > reset_resume(). I had written a patch that does that and implements USB
> > autosuspend. The reporter tested it and found it to work.
> > If you want me to I can't isolate the implementation of reset_resume() from
> > the rest but I can't test it.
> > 
> 
> Yes, that'd be great since I'd like the regression fix to show up in
> .26 while the autosuspend can wait till .27.

Very well, this is the minimal patch. It needs to be retested and if
it works it should go into 2.6.26 and the stable series.

	Regards
		Oliver

Signed-off-by: Oliver Neukum <oneukum@suse.de>

---

--- linux-2.6.26-rc5/drivers/usb/core/quirks.c	2008-06-05 13:45:57.000000000 +0200
+++ linux-2.6.26-rc5-btusb/drivers/usb/core/quirks.c	2008-06-06 08:12:10.000000000 +0200
@@ -47,6 +47,9 @@ static const struct usb_device_id usb_qu
 	/* Edirol SD-20 */
 	{ USB_DEVICE(0x0582, 0x0027), .driver_info = USB_QUIRK_RESET_RESUME },
 
+	/* appletouch */
+	{ USB_DEVICE(0x05ac, 0x021a), .driver_info = USB_QUIRK_RESET_RESUME },
+
 	/* Avision AV600U */
 	{ USB_DEVICE(0x0638, 0x0a13), .driver_info =
 	  USB_QUIRK_STRING_FETCH_255 },
--- linux-2.6.26-rc5-btusb/drivers/input/mouse/appletouch.c.alt	2008-06-09 10:40:00.000000000 +0200
+++ linux-2.6.26-rc5-btusb/drivers/input/mouse/appletouch.c	2008-06-09 10:40:03.000000000 +0200
@@ -589,6 +589,20 @@ static void atp_close(struct input_dev *
 	dev->open = 0;
 }
 
+static int handle_geyser(struct atp *dev)
+{
+	struct usb_device *udev = dev->udev;
+
+	if (!atp_is_fountain(dev)) {
+		/* switch to raw sensor mode */
+		if (atp_geyser_init(udev))
+			return -EIO;
+
+		printk(KERN_INFO "appletouch: Geyser mode initialized.\n");
+	}
+	return 0;
+}
+
 static int atp_probe(struct usb_interface *iface, const struct usb_device_id *id)
 {
 	struct atp *dev;
@@ -744,6 +758,20 @@ static void atp_disconnect(struct usb_in
 	printk(KERN_INFO "input: appletouch disconnected\n");
 }
 
+static int recover_dev(struct atp *dev)
+{
+	int rv;
+
+	rv = handle_geyser(dev);
+	if (rv < 0)
+		return rv;
+
+	if (dev->open && usb_submit_urb(dev->urb, GFP_NOIO))
+		return -EIO;
+
+	return 0;	
+}
+
 static int atp_suspend(struct usb_interface *iface, pm_message_t message)
 {
 	struct atp *dev = usb_get_intfdata(iface);
@@ -764,12 +792,20 @@ static int atp_resume(struct usb_interfa
 	return 0;
 }
 
+static int atp_reset_resume(struct usb_interface *iface)
+{
+	struct atp *dev = usb_get_intfdata(iface);
+
+	return recover_dev(dev);
+}
+
 static struct usb_driver atp_driver = {
 	.name		= "appletouch",
 	.probe		= atp_probe,
 	.disconnect	= atp_disconnect,
 	.suspend	= atp_suspend,
 	.resume		= atp_resume,
+	.reset_resume	= atp_reset_resume,
 	.id_table	= atp_table,
 };
 

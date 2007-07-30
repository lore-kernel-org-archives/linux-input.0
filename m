From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH][hid] Fix a NULL pointer dereference when we fail to
 allocate memory
Date: Mon, 30 Jul 2007 15:56:57 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0707301553240.26532@jikos.suse.cz>
References: <200707220006.20359.jesper.juhl@gmail.com> <46A2EF75.70700@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <46A2EF75.70700@gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Michael Haboustak <mike-@cinci.rr.com>, Andreas Gal <gal@uci.edu>, Greg Kroah-Hartman <greg@kroah.com>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Sun, 22 Jul 2007, Jiri Slaby wrote:

> > --- a/drivers/hid/usbhid/hid-core.c
> > +++ b/drivers/hid/usbhid/hid-core.c
> > @@ -743,7 +743,7 @@ static struct hid_device *usb_hid_configure(struct usb_interface *intf)
> >  	hid->quirks = quirks;
> >  
> >  	if (!(usbhid = kzalloc(sizeof(struct usbhid_device), GFP_KERNEL)))
> Out of curiosity, where is this freed?

I have queued the fix below on top of Jesper's patch, thanks.


diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 3ff7468..6e73934 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -877,6 +877,7 @@ fail:
 	usb_free_urb(usbhid->urbin);
 	usb_free_urb(usbhid->urbout);
 	usb_free_urb(usbhid->urbctrl);
+	kfree(usbhid);
 fail_no_usbhid:
 	hid_free_buffers(dev, hid);
 	hid_free_device(hid);
@@ -912,6 +913,7 @@ static void hid_disconnect(struct usb_interface *intf)
 	usb_free_urb(usbhid->urbin);
 	usb_free_urb(usbhid->urbctrl);
 	usb_free_urb(usbhid->urbout);
+	kfree(usbhid);
 
 	hid_free_buffers(hid_to_usb_dev(hid), hid);
 	hid_free_device(hid);

From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH][RFC] usbhid: enable autosuspend for internal devices
Date: Fri, 26 Jun 2015 16:28:20 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1506261622500.1566-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1506261549310.1566-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:37919 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752104AbbFZU2V (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 26 Jun 2015 16:28:21 -0400
In-Reply-To: <Pine.LNX.4.44L0.1506261549310.1566-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tom Gundersen <teg@jklm.no>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Fri, 26 Jun 2015, Alan Stern wrote:

> On Fri, 26 Jun 2015, Tom Gundersen wrote:
> 
> > This policy used to be unconditionally applied by udev, but there
> > is no reason to make userspace be involved in this and in the future
> > udev will not be doing it by default.
> > 
> > See: <https://github.com/systemd/systemd/pull/353>.
> > 
> > Signed-off-by: Tom Gundersen <teg@jklm.no>
> > Cc: Jiri Kosina <jkosina@suse.cz>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> > 
> > Hi,
> > 
> > I don't have the right hardware for this, so it has only been compile-tested.
> > I'm therefore sending it as an RFC only. Mainly I want to bring it to people's
> > attention that it would be great to get this feature into the kernel as we want
> > to drop it from udev.
> > 
> > Cheers,
> > 
> > Tom
> > 
> >  drivers/hid/usbhid/hid-core.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> > index bfbe1be..af80700 100644
> > --- a/drivers/hid/usbhid/hid-core.c
> > +++ b/drivers/hid/usbhid/hid-core.c
> > @@ -1358,6 +1358,9 @@ static int usbhid_probe(struct usb_interface *intf, const struct usb_device_id *
> >  	setup_timer(&usbhid->io_retry, hid_retry_timeout, (unsigned long) hid);
> >  	spin_lock_init(&usbhid->lock);
> >  
> > +	if (dev->removable == USB_DEVICE_FIXED)
> > +		usb_enable_autosuspend(dev);
> 
> This doesn't do what the patch title says.  USB_DEVICE_FIXED means that
> the device can't be unplugged from its upstream port.  It doesn't mean
> the device is internal to the computer.
> 
> As an example, consider a composite Apple keyboard, which has an

Oops -- I meant "compound", not "composite".  A compound USB device
actually has multiple devices (one of which is a hub) in a single 
package.

> internal 3-port USB hub where two of the hub's ports are exposed on the
> edge of the keyboard case and the keyboard controller is permanently
> attached to the third hub port.  Then the controller device would be
> marked USB_DEVICE_FIXED, even though the whole thing is external to
> the computer and can be unplugged.

Another problem is that the set_usb_port_removable() routine in
drivers/usb/core/hub.c (the routine that sets dev->removable in the
first place) contains this code:

	hub = usb_hub_to_struct_hub(udev->parent);

	wHubCharacteristics = le16_to_cpu(hub->descriptor->wHubCharacteristics);

	if (!(wHubCharacteristics & HUB_CHAR_COMPOUND))
		return;

I guess the assumption was that all of a hub's ports would be
unpluggable if the hub wasn't part of a compound device.  But that's
not correct for root hubs.  This test should be deleted.

Alan Stern


From: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH][RFC] usbhid: enable autosuspend for internal devices
Date: Fri, 26 Jun 2015 15:15:17 -0700
Message-ID: <20150626221517.GB2761@kroah.com>
References: <1435346647-29473-1-git-send-email-teg@jklm.no>
 <Pine.LNX.4.44L0.1506261549310.1566-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1506261549310.1566-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Tom Gundersen <teg-B22kvLQNl6c@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Fri, Jun 26, 2015 at 04:08:20PM -0400, Alan Stern wrote:
> On Fri, 26 Jun 2015, Tom Gundersen wrote:
> 
> > This policy used to be unconditionally applied by udev, but there
> > is no reason to make userspace be involved in this and in the future
> > udev will not be doing it by default.
> > 
> > See: <https://github.com/systemd/systemd/pull/353>.
> > 
> > Signed-off-by: Tom Gundersen <teg-B22kvLQNl6c@public.gmane.org>
> > Cc: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
> > Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
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
> internal 3-port USB hub where two of the hub's ports are exposed on the
> edge of the keyboard case and the keyboard controller is permanently
> attached to the third hub port.  Then the controller device would be
> marked USB_DEVICE_FIXED, even though the whole thing is external to
> the computer and can be unplugged.
> 

Is that really how those devices are marked?  I can't find any of my
keyboard with hubs that mark things that way.

> A reasonable compromise might be
> 
> 	/*
> 	 * Enable autosuspend for devices permanently attached
> 	 * to the root hub.
> 	 */
> 	if (!dev->parent->parent && dev->removable == USB_DEVICE_FIXED)
> 		usb_enable_autosuspend(dev);
> 
> But this doesn't work if there's a permanently attached hub and a
> device permanently attached to that hub.  To do this thoroughly, you
> have to iterate up the dev->parent chain, making sure at each step that 
> the ->removable value is USB_DEVICE_FIXED.
> 
> Also, are you really certain this is safe?  Aren't there a number of 
> built-in keyboards that will work badly if you allow them to 
> autosuspend?

udev has been doing this for a while now by default, with no reports of
problems, so I think we should be safe.

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

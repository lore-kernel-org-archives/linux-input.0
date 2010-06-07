From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] usbtouchscreen: Implement runtime power management
Date: Mon, 7 Jun 2010 22:47:33 +0200
Message-ID: <201006072247.33068.oliver@neukum.org>
References: <Pine.LNX.4.44L0.1006071622260.1332-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1006071622260.1332-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Ritz <daniel.ritz-OI3hZJvNYWs@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Am Montag, 7. Juni 2010 22:22:54 schrieb Alan Stern:
> On Mon, 7 Jun 2010, Oliver Neukum wrote:
> 
> > Am Montag, 7. Juni 2010 18:23:16 schrieb Dmitry Torokhov:
> > > On Mon, Jun 07, 2010 at 03:13:42PM +0200, Oliver Neukum wrote:
> > > >  static int usbtouch_open(struct input_dev *input)
> > > >  {
> > > >  	struct usbtouch_usb *usbtouch = input_get_drvdata(input);
> > > > +	int r;
> > > >  
> > > >  	usbtouch->irq->dev = interface_to_usbdev(usbtouch->interface);
> > > >  
> > > > +	r = usb_autopm_get_interface(usbtouch->interface) ? -EIO : 0;
> > > 
> > > Why are we clobbering error code with -EIO? We should propagate te code
> > > returned to us (here and below).
> > 
> > usb_autopm_get_interface() uses internal USB error codes which with
> > a few exceptions, do not have the meaning error codes in user space
> > have.
> 
> But other drivers don't do this.  What's special about usbtouch?

Then I'd say the other drivers are wrong. We cannot leak USB specific
codes. Maybe we should pass -ENOMEM and -ENODEV, but the others
really don't mean anything as generic codes.

	Regards
		Oliver
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

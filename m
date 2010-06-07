From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] usbtouchscreen: Implement runtime power management
Date: Mon, 7 Jun 2010 21:31:18 +0200
Message-ID: <201006072131.18949.oliver@neukum.org>
References: <201006071513.42714.oneukum@suse.de> <20100607162316.GB7706@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100607162316.GB7706-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Ritz <daniel.ritz-OI3hZJvNYWs@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Am Montag, 7. Juni 2010 18:23:16 schrieb Dmitry Torokhov:
> On Mon, Jun 07, 2010 at 03:13:42PM +0200, Oliver Neukum wrote:
> >  static int usbtouch_open(struct input_dev *input)
> >  {
> >  	struct usbtouch_usb *usbtouch = input_get_drvdata(input);
> > +	int r;
> >  
> >  	usbtouch->irq->dev = interface_to_usbdev(usbtouch->interface);
> >  
> > +	r = usb_autopm_get_interface(usbtouch->interface) ? -EIO : 0;
> 
> Why are we clobbering error code with -EIO? We should propagate te code
> returned to us (here and below).

usb_autopm_get_interface() uses internal USB error codes which with
a few exceptions, do not have the meaning error codes in user space
have.

	Regards
		Oliver
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

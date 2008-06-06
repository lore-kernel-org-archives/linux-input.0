From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: fix appletouch regression bugzilla.kernel.org#10825
Date: Fri, 6 Jun 2008 11:53:54 -0700
Message-ID: <20080606185354.GA8576@kroah.com>
References: <200806061213.18066.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200806061213.18066.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Fri, Jun 06, 2008 at 12:13:17PM +0200, Oliver Neukum wrote:
> Hi,
> 
> this touchpad needs, probably due to a change in timing of suspension,
> a quirk in 2.6.25 and later. To use this quirk the driver needs to implement
> reset_resume(). I had written a patch that does that and implements USB
> autosuspend. The reporter tested it and found it to work.
> If you want me to I can't isolate the implementation of reset_resume() from
> the rest but I can't test it.
> 
> 	Regards
> 		Oliver
> 
> Signed-off-by: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
> 
> ---
> 
> --- linux-2.6.26-rc5/drivers/usb/core/quirks.c	2008-06-05 13:45:57.000000000 +0200
> +++ linux-2.6.26-rc5-btusb/drivers/usb/core/quirks.c	2008-06-06 08:12:10.000000000 +0200
> @@ -47,6 +47,9 @@ static const struct usb_device_id usb_qu
>  	/* Edirol SD-20 */
>  	{ USB_DEVICE(0x0582, 0x0027), .driver_info = USB_QUIRK_RESET_RESUME },
>  
> +	/* appletouch */
> +	{ USB_DEVICE(0x05ac, 0x021a), .driver_info = USB_QUIRK_RESET_RESUME },
> +
>  	/* Avision AV600U */
>  	{ USB_DEVICE(0x0638, 0x0a13), .driver_info =
>  	  USB_QUIRK_STRING_FETCH_255 },

So should this portion go into 2.6.26 now, and in .25-stable as well?

Or are the changes to the driver also needed?

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

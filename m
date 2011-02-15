From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] usbmouse: random freeze/hangup; synchronize irq
 completion
Date: Mon, 14 Feb 2011 17:05:30 -0800
Message-ID: <20110215010530.GB16060@kroah.com>
References: <201102140951.00866.jordipujolp@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201102140951.00866.jordipujolp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jordi Pujol <jordipujolp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, Feb 14, 2011 at 09:51:00AM +0100, Jordi Pujol wrote:
> Hello,
> 
> usbmouse: synchonize the irq completion for each urb.
> 
> Without this patch the mouse was a bit erratic and when
> using the mouse the system gets freezed/hangup randomly (one or two times a 
> day).
> 
> Jordi Pujol
> 
> Live never ending Tale
> GNU/Linux Live forever!
> http://livenet.selfip.com

>  usbmouse: synchonize the irq completion
> 
> Signed-off-by: Jordi Pujol <jordipujolp AT gmail DOT com>
> 
> --- linux-2.6.37-old/include/linux/usb.h	2011-01-05 01:50:19.000000000 +0100
> +++ linux-2.6.37/include/linux/usb.h	2011-02-10 09:31:30.098752709 +0100
> @@ -1214,6 +1214,7 @@ struct urb {
>  	int error_count;		/* (return) number of ISO errors */
>  	void *context;			/* (in) context for completion */
>  	usb_complete_t complete;	/* (in) completion routine */
> +	struct mutex		complete_mutex;		/* synchronize completion */

Ick, no, this should never be needed.

Please explain why the existing procedure for this isn't working for
you?

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

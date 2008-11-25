From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [patch] add module parameter to provide hardware-calibrated
 coordinate data for MicroTouch/3M touchscreens
Date: Tue, 25 Nov 2008 16:27:20 +0100 (CET)
Message-ID: <alpine.LRH.1.10.0811251624440.26670@twin.jikos.cz>
References: <alpine.LNX.1.10.0811240944520.4090@floyd.root.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LNX.1.10.0811240944520.4090-ah6mVDs4vN4u9rY2yWxFjw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dan Streetman <ddstreet-EkmVulN54Sk@public.gmane.org>
Cc: Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, daniel.ritz-OI3hZJvNYWs@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, 24 Nov 2008, Dan Streetman wrote:

> This patch adds a module parameter to report either the raw coordinate data or 
> the hardware-calibrated coordinate data.  The default is set to the raw 
> coordinates for backwards compatibilty.

Please don't forget to include input subsystem maitainer (Dmitry Torokhov) 
when sending patches to code residing in drivers/input. Added.

> @@ -294,6 +303,12 @@ static int mtouch_init(struct usbtouch_u
>  			return ret;
>  	}
>  
> +	// Default min/max xy are the raw values, override if using hw-calib

Please use style of comments that is in compliance with kernel coding 
style.

Otherwise I think that the patch is fine.

-- 
Jiri Kosina
SUSE Labs

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

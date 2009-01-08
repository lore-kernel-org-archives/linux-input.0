From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [patch] add module parameter to provide hardware-calibrated
 coordinate data for MicroTouch/3M touchscreens
Date: Thu, 8 Jan 2009 01:52:41 +0100 (CET)
Message-ID: <alpine.LRH.1.10.0901080149280.24105@twin.jikos.cz>
References: <alpine.LNX.1.10.0811251035260.30650@floyd.root.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LNX.1.10.0811251035260.30650-ah6mVDs4vN4u9rY2yWxFjw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dan Streetman <ddstreet-EkmVulN54Sk@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, daniel.ritz-OI3hZJvNYWs@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, 25 Nov 2008, Dan Streetman wrote:

> On Tue, Nov 25, 2008 at 10:27 AM, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org> wrote:
> > On Mon, 24 Nov 2008, Dan Streetman wrote:
> >
> >> +     // Default min/max xy are the raw values, override if using hw-calib
> >
> > Please use style of comments that is in compliance with kernel coding
> > style.
> 
> Oops, ok.  Updated patch below.
> 
> 
> 
> 
> This patch adds a module parameter to report either the raw coordinate data or
> the hardware-calibrated coordinate data.  The default is set to the raw
> coordinates for backwards compatibilty.
> 
> Signed-off-by: Dan Streetman <ddstreet-EkmVulN54Sk@public.gmane.org>
> 
> 
> --- a/drivers/input/touchscreen/usbtouchscreen.c	2008-11-17 10:51:30.000000000 -0500
> +++ b/drivers/input/touchscreen/usbtouchscreen.c	2008-11-17 10:51:45.000000000 -0500
> @@ -60,6 +60,10 @@ static int swap_xy;
>  module_param(swap_xy, bool, 0644);
>  MODULE_PARM_DESC(swap_xy, "If set X and Y axes are swapped.");
>  
> +static int hwcalib_xy = 0;
> +module_param(hwcalib_xy, bool, 0644);
> +MODULE_PARM_DESC(hwcalib_xy, "If set hw-calibrated X/Y are used if available");
> +
>  /* device specifc data/functions */
>  struct usbtouch_usb;
>  struct usbtouch_device_info {
> @@ -260,8 +264,13 @@ static int panjit_read_data(struct usbto
>  
>  static int mtouch_read_data(struct usbtouch_usb *dev, unsigned char *pkt)
>  {
> -	dev->x = (pkt[8] << 8) | pkt[7];
> -	dev->y = (pkt[10] << 8) | pkt[9];
> +	if (hwcalib_xy) {
> +		dev->x = (pkt[4] << 8) | pkt[3];
> +		dev->y = 0xffff - ((pkt[6] << 8) | pkt[5]);
> +	} else {
> +		dev->x = (pkt[8] << 8) | pkt[7];
> +		dev->y = (pkt[10] << 8) | pkt[9];
> +	}
>  	dev->touch = (pkt[2] & 0x40) ? 1 : 0;
>  
>  	return 1;
> @@ -294,6 +303,12 @@ static int mtouch_init(struct usbtouch_u
>  			return ret;
>  	}
>  
> +	/* Default min/max xy are the raw values, override if using hw-calib */
> +	if (hwcalib_xy) {
> +		input_set_abs_params(usbtouch->input, ABS_X, 0, 0xffff, 0, 0);
> +		input_set_abs_params(usbtouch->input, ABS_Y, 0, 0xffff, 0, 0);
> +	}
> +
>  	return 0;
>  }
>  #endif

[ just making sure that this one didn't get lost in the noise ]

Dmitry, the patch above looks sane to me. Would you consider merging it 
(ideally still for 2.6.29) please?

Thanks,

-- 
Jiri Kosina
SUSE Labs

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

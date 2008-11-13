From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: [patch] add module parameter to provide hardware-calibrated
	coordinate data for MicroTouch/3M touchscreens
Date: Thu, 13 Nov 2008 12:31:48 -0800
Message-ID: <20081113203148.GA13559@kroah.com>
References: <3fad22b40811131222k3a168a06tfe01b09ca106e0a2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3fad22b40811131222k3a168a06tfe01b09ca106e0a2-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dan Streetman <ddstreet-EkmVulN54Sk@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, daniel.ritz-OI3hZJvNYWs@public.gmane.org, Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Thu, Nov 13, 2008 at 03:22:52PM -0500, Dan Streetman wrote:
> Back in mtouchusb, I added the "raw_coordinates" module parameter to
> make it possible to get the hw-calib data:
> http://marc.info/?l=linux-usb-devel&m=110968309531306&w=2
> 
> When mtouchusb was integrated into the usbtouchscreen driver, that
> ability wasn't carried over - it reports only the raw coordinates
> again.
> 
> This patch restores the ability to get hardware-calibrated coordinate
> data, and defaults to the raw data so existing systems with a
> microtouch touchscreen won't see any changes.
> 
> Note that the Y axis is inverted as reported by the touchscreen, so
> this reverses the Y min and max (0xffff for the min, 0 for the max).
> This works fine on my system using the X evdev driver.
> 
> (I'm sending this from gmail which hopefully won't mangle the
> patch...I tested it and it seems ok)
> 
> Signed-off-by: Dan Streetman <ddstreet-EkmVulN54Sk@public.gmane.org>
> 
> 
> --- a/drivers/input/touchscreen/usbtouchscreen.c	2008-11-12
> 13:06:23.000000000 -0500
> +++ b/drivers/input/touchscreen/usbtouchscreen.c	2008-11-12
> 13:07:44.000000000 -0500

Your patch is line-wrapped :(

> @@ -60,6 +60,10 @@ static int swap_xy;
>  module_param(swap_xy, bool, 0644);
>  MODULE_PARM_DESC(swap_xy, "If set X and Y axes are swapped.");
> 
> +static int hwcalib_xy = 0;
> +module_param(hwcalib_xy, bool, 0444);
> +MODULE_PARM_DESC(hwcalib_xy, "If set hw-calibrated X/Y are used if available");

Should this variable be allowed to be changed at run time?  That might
be useful if the code is built into the system.  If so, please change
the permissions on the module_param() call.

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

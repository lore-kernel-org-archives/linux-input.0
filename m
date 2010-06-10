From: Ondrej Zary <linux-ZCIryABCsrmttCpgsWEBFmD2FQJk+8+b@public.gmane.org>
Subject: Re: [0000/0003]full power management for usb touchscreens
Date: Thu, 10 Jun 2010 13:33:57 +0200
Message-ID: <201006101333.58693.linux@rainbow-software.org>
References: <201006071513.29478.oneukum@suse.de> <201006091540.06003.linux@rainbow-software.org> <201006091836.14136.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201006091836.14136.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Ritz <daniel.ritz-OI3hZJvNYWs@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wednesday 09 June 2010, Oliver Neukum wrote:
> Am Mittwoch, 9. Juni 2010 15:40:04 schrieb Ondrej Zary:
> > Looking at the patches from archive:
> >
> > If I understand it correctly, usbtouch_resume submits the irq URB only if
> > the input device is open. That will fail with Nexio as it has an internal
> > watchdog which needs URBs or the device will reconnect - see irq_always
> > (Zytronic seems to need it too).
>
> Thank you for the review. Does this patch fix the issues?

I haven't tested the patches before. Now I tested them and the Nexio 
touchscreen does not play well with suspend. It always reconnects after 
resume from STR or hibernation. Autosuspend is probably never activated at 
the URBs are submitted continuously.

> 	Regards
> 		Oliver
>
> From 3fe66013333931b4b0cb7361fbe60d502d306eb4 Mon Sep 17 00:00:00 2001
> From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
> Date: Wed, 9 Jun 2010 18:32:58 +0200
> Subject: [PATCH] usbtouchscreen: fix typo and touchpads which require
> constant polling
>
> 1. fix typo
> 2. start polling on closed devices if they require it
>
> Signed-off-by: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
> ---
>  drivers/input/touchscreen/usbtouchscreen.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/input/touchscreen/usbtouchscreen.c
> b/drivers/input/touchscreen/usbtouchscreen.c index 421f168..d13517a 100644
> --- a/drivers/input/touchscreen/usbtouchscreen.c
> +++ b/drivers/input/touchscreen/usbtouchscreen.c
> @@ -1333,7 +1333,7 @@ static int usbtouch_resume(struct usb_interface
> *intf) int result = 0;
>
>  	mutex_lock(&input->mutex);
> -	if (input->users)
> +	if (input->users || usbtouch->type->irq_always)
>  		result = usb_submit_urb(usbtouch->irq, GFP_NOIO);
>  	mutex_unlock(&input->mutex);
>  	return result;
> @@ -1484,7 +1484,7 @@ static int usbtouch_probe(struct usb_interface *intf,
>  	usbtouch->irq->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
>
>  	/* device specific allocations */
> -	if (type->init) {
> +	if (type->alloc) {
>  		err = type->alloc(usbtouch);
>  		if (err) {
>  			dbg("%s - type->alloc() failed, err: %d", __func__, err);



-- 
Ondrej Zary
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

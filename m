From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: xpad - fix oops when attaching an unknown Xbox
 One gamepad
Date: Thu, 23 Jun 2016 10:27:26 -0700
Message-ID: <20160623172726.GG32561@dtor-ws>
References: <5753B431.2040908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:36561 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286AbcFWR1a (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jun 2016 13:27:30 -0400
Received: by mail-pa0-f67.google.com with SMTP id av7so908127pac.3
        for <linux-input@vger.kernel.org>; Thu, 23 Jun 2016 10:27:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5753B431.2040908@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Cameron Gutman <aicommander@gmail.com>
Cc: linux-input@vger.kernel.org

On Sun, Jun 05, 2016 at 12:10:09AM -0500, Cameron Gutman wrote:
> Xbox One controllers have multiple interfaces which all have the
> same class, subclass, and protocol. One of the these interfaces
> has only a single endpoint. When Xpad attempts to bind to this
> interface, it causes an oops when trying initialize the output URB
> by trying to access the second endpoint's descriptor.
> 
> This situation was avoided for known Xbox One devices by checking
> the XTYPE constant associated with the VID and PID tuple. However,
> this breaks when new or previously unknown Xbox One controllers
> are attached to the system.
> 
> This change addresses the problem by deriving the XTYPE for Xbox
> One controllers based on the interface protocol before checking
> the interface number.
> 
> Fixes: 1a48ff81b391 ("Input: xpad - add support for Xbox One controllers")
> Signed-off-by: Cameron Gutman <aicommander@gmail.com>
> Cc: stable@vger.kernel.org
> ---
> This bug affects kernels since 3.18. Controllers upgraded to the 2015
> firmware will trigger the oops on affected kernels (up to 4.4 when the
> new device ID was added). The Xbox One Elite controller will likely
> also trigger the oops up to 4.6 (though I've not tested myself) along
> with any new third-party Xbox One controllers that are released.
> 
> There are a few ways we could address it, but this one seems nice
> because it allows the controller to work correctly (as opposed to simply
> kicking out interfaces without enough endpoints).

Applied, thank you.

But I think it would be even better if we still validated the number of
endpoints afterwards so that a device with malicious descriptors would
not crash the kernel. Any chance you could make such a patch?

Thanks!

> ---
>  drivers/input/joystick/xpad.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index 923c572..3438e98 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -1437,16 +1437,6 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
>  			break;
>  	}
>  
> -	if (xpad_device[i].xtype == XTYPE_XBOXONE &&
> -	    intf->cur_altsetting->desc.bInterfaceNumber != 0) {
> -		/*
> -		 * The Xbox One controller lists three interfaces all with the
> -		 * same interface class, subclass and protocol. Differentiate by
> -		 * interface number.
> -		 */
> -		return -ENODEV;
> -	}
> -
>  	xpad = kzalloc(sizeof(struct usb_xpad), GFP_KERNEL);
>  	if (!xpad)
>  		return -ENOMEM;
> @@ -1478,6 +1468,8 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
>  		if (intf->cur_altsetting->desc.bInterfaceClass == USB_CLASS_VENDOR_SPEC) {
>  			if (intf->cur_altsetting->desc.bInterfaceProtocol == 129)
>  				xpad->xtype = XTYPE_XBOX360W;
> +			else if (intf->cur_altsetting->desc.bInterfaceProtocol == 208)
> +				xpad->xtype = XTYPE_XBOXONE;
>  			else
>  				xpad->xtype = XTYPE_XBOX360;
>  		} else {
> @@ -1492,6 +1484,17 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
>  			xpad->mapping |= MAP_STICKS_TO_NULL;
>  	}
>  
> +	if (xpad->xtype == XTYPE_XBOXONE &&
> +	    intf->cur_altsetting->desc.bInterfaceNumber != 0) {
> +		/*
> +		 * The Xbox One controller lists three interfaces all with the
> +		 * same interface class, subclass and protocol. Differentiate by
> +		 * interface number.
> +		 */
> +		error = -ENODEV;
> +		goto err_free_in_urb;
> +	}
> +
>  	error = xpad_init_output(intf, xpad);
>  	if (error)
>  		goto err_free_in_urb;
> -- 
> 2.7.4

-- 
Dmitry

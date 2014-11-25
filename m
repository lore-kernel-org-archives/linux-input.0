From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: xpad: use proper endpoint type
Date: Tue, 25 Nov 2014 00:38:48 -0800
Message-ID: <20141125083848.GA14519@dtor-ws>
References: <20141124020323.GA5651@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:35694 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124AbaKYIix (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 25 Nov 2014 03:38:53 -0500
Received: by mail-ig0-f176.google.com with SMTP id l13so4944321iga.15
        for <linux-input@vger.kernel.org>; Tue, 25 Nov 2014 00:38:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141124020323.GA5651@kroah.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.or, "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>

On Sun, Nov 23, 2014 at 06:03:23PM -0800, Greg Kroah-Hartman wrote:
> The xpad wireless endpoint is not a bulk endpoint on my devices, but
> rather an interrupt one, so the USB core complains when it is submitted.
> I'm guessing that the author really did mean that this should be an
> interrupt urb, but as there are a zillion different xpad devices out
> there, let's cover out bases and handle both bulk and interrupt
> endpoints just as easily.
> 
> Signed-off-by: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: stable <stable@vger.kernel.org>


Applied, thank you.

> ---
> 
> This has been in my local tree since January, don't know why it never
> got pushed out, sorry for the delay.  Valve has been using a version of
> this patch for a year now.
> 
>  drivers/input/joystick/xpad.c |   16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -1179,9 +1179,19 @@ static int xpad_probe(struct usb_interfa
>  		}
>  
>  		ep_irq_in = &intf->cur_altsetting->endpoint[1].desc;
> -		usb_fill_bulk_urb(xpad->bulk_out, udev,
> -				usb_sndbulkpipe(udev, ep_irq_in->bEndpointAddress),
> -				xpad->bdata, XPAD_PKT_LEN, xpad_bulk_out, xpad);
> +		if (usb_endpoint_is_bulk_out(ep_irq_in)) {
> +			usb_fill_bulk_urb(xpad->bulk_out, udev,
> +					  usb_sndbulkpipe(udev,
> +							  ep_irq_in->bEndpointAddress),
> +					  xpad->bdata, XPAD_PKT_LEN,
> +					  xpad_bulk_out, xpad);
> +		} else {
> +			usb_fill_int_urb(xpad->bulk_out, udev,
> +					 usb_sndintpipe(udev,
> +							ep_irq_in->bEndpointAddress),
> +					 xpad->bdata, XPAD_PKT_LEN,
> +					 xpad_bulk_out, xpad, 0);
> +		}
>  
>  		/*
>  		 * Submit the int URB immediately rather than waiting for open

-- 
Dmitry

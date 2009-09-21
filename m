From: Henk Martijn <h.h.martijn@gmail.com>
Subject: Re: [patch]fix usbhid using GFP_KERNEL in interrupt
Date: Mon, 21 Sep 2009 22:33:53 +0200
Message-ID: <4AB7E331.8050209@gmail.com>
References: <200909212225.48513.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f206.google.com ([209.85.219.206]:55313 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750909AbZIUUdx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Sep 2009 16:33:53 -0400
In-Reply-To: <200909212225.48513.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, Greg KH <gregkh@suse.de>, Jiri Kosina <jkosina@suse.cz>

Oliver Neukum wrote:
> hid:usbhid: fix wrong use of GFP_KERNEL
>     
> hid_input_report() must be told it is called in interrupt context
> 
> Signed-off-by: Oliver Neukum <oliver@neukum.org>
> 
> Hi Jiri, Greg,
> 
> this should go into the current tree and the stable tree.
Stable? Interestingly I did not have any problems with 2.6.31......

/Henk
> 
> 	Regards
> 		Oliver
> 
> --
> commit ca5c4a1397d1a1c0d1074f4d8922630fdd732780
> Author: Oliver Neukum <oliver@neukum.org>
> Date:   Mon Sep 21 22:02:01 2009 +0200
> 
>     hid:usbhid: fix wrong use of GFP_KERNEL
>     
>     hid_input_report() must be told it is called in interrupt context
> 
> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> index 1b0e07a..ab2869d 100644
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -455,7 +455,7 @@ static void hid_ctrl(struct urb *urb)
>  		if (usbhid->ctrl[usbhid->ctrltail].dir == USB_DIR_IN)
>  			hid_input_report(urb->context,
>  				usbhid->ctrl[usbhid->ctrltail].report->type,
> -				urb->transfer_buffer, urb->actual_length, 0);
> +				urb->transfer_buffer, urb->actual_length, 1);
>  		break;
>  	case -ESHUTDOWN:	/* unplug */
>  		unplug = 1;
> 
> 


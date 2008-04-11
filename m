From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] xpad - Set buffer length for outgoing requests
Date: Fri, 11 Apr 2008 11:34:17 -0400
Message-ID: <20080411113140.ZZRA012@mailhub.coreip.homeip.net>
References: <74d457500804080405x50098dcfi6dfe965da2a962ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.188]:18256 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758556AbYDKPe0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Apr 2008 11:34:26 -0400
Received: by rn-out-0910.google.com with SMTP id e11so446931rng.17
        for <linux-input@vger.kernel.org>; Fri, 11 Apr 2008 08:34:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <74d457500804080405x50098dcfi6dfe965da2a962ef@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Gruber <lists.mg@googlemail.com>, anssi.hannula@gmail.com
Cc: linux-input@vger.kernel.org

Hi Michael,

On Tue, Apr 08, 2008 at 01:05:27PM +0200, Michael Gruber wrote:
> From: Michael Gruber <lists.mg@googlemail.com>
> 
> The messages for led/rumble are exactly 3 and 8 bytes respectively.
> Hence set up the transfer_buffer_length accordingly.
> 
> Signed-off-by: Michael Gruber <lists.mg@googlemail.com>
> 

Thank you for the patch, it seems reasonable. Anssi, any objections?

> ---
> 
> Hi, my Xbox360 Controller will not work at all unless this is set up correctly.
> I am new to linux kernel programming and would appreciate any kinds of comments.
> 
>  drivers/input/joystick/xpad.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- a/drivers/input/joystick/xpad.c	2008-04-05 15:18:37.000000000 +0200
> +++ b/drivers/input/joystick/xpad.c	2008-04-05 15:18:25.000000000 +0200
> @@ -558,6 +558,7 @@ static int xpad_play_effect(struct input
>  		xpad->odata[5] = 0x00;
>  		xpad->odata[6] = 0x00;
>  		xpad->odata[7] = 0x00;
> +		xpad->irq_out->transfer_buffer_length = 8;
>  		usb_submit_urb(xpad->irq_out, GFP_KERNEL);
>  	}
> 
> @@ -594,6 +595,7 @@ static void xpad_send_led_command(struct
>  		xpad->odata[0] = 0x01;
>  		xpad->odata[1] = 0x03;
>  		xpad->odata[2] = command;
> +		xpad->irq_out->transfer_buffer_length = 3;
>  		usb_submit_urb(xpad->irq_out, GFP_KERNEL);
>  		mutex_unlock(&xpad->odata_mutex);
>  	}

-- 
Dmitry

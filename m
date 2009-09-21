From: Henk Martijn <h.h.martijn@gmail.com>
Subject: Re: 2.6.31-0.1-default-07068-g43c1266 lockdep warning and scheduling
 while atomic BUG
Date: Mon, 21 Sep 2009 22:17:18 +0200
Message-ID: <4AB7DF4E.9040703@gmail.com>
References: <1253560490.2934.42.camel@localhost> <4AB7D9B8.6000501@gmail.com> <200909212204.50047.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753861AbZIUUR3@vger.kernel.org>
In-Reply-To: <200909212204.50047.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Yes that worked, Thanks!

/Henk

Oliver Neukum wrote:
> Am Montag, 21. September 2009 21:53:28 schrieb Henk Martijn:
>> This is a i7 based DELL and current git throws the following warning and
>> bug at me during boot:
> 
> Please try this patch
> 
> 	Regards
> 		Oliver
> 
> --
> 
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

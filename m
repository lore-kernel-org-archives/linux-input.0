From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 2/2] Input: usbtouchscreen: ignore eGalax/D-Wav/EETI
 HIDs
Date: Tue, 5 Nov 2013 10:53:10 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1311051052530.2779@pobox.suse.cz>
References: <20131021163818.GB30240@alittletooquiet.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:33105 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752072Ab3KEJxN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 5 Nov 2013 04:53:13 -0500
In-Reply-To: <20131021163818.GB30240@alittletooquiet.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Forest Bond <forest@forestbond.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, =?ISO-8859-15?Q?Sebastian_Dalfu=DF?= <sd@sedf.de>, Daniel Ritz <daniel.ritz@gmx.ch>, Max Weninger <max.weninger@gmail.com>, Christian Engelmayer <christian.engelmayer@frequentis.com>

On Mon, 21 Oct 2013, Forest Bond wrote:

> From: Forest Bond <forest.bond@rapidrollout.com>
> 
> The HID driver now handles these devices, regardless of what protocol
> the device claims it supports.
> 
> Signed-off-by: Forest Bond <forest.bond@rapidrollout.com>

Dmitry,

could you please Ack this, so that it can be applied together with 1/2? 
Thanks!

> ---
>  drivers/input/touchscreen/usbtouchscreen.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
> index 721fdb3..ae4b6b9 100644
> --- a/drivers/input/touchscreen/usbtouchscreen.c
> +++ b/drivers/input/touchscreen/usbtouchscreen.c
> @@ -146,12 +146,10 @@ enum {
>  
>  #define USB_DEVICE_HID_CLASS(vend, prod) \
>  	.match_flags = USB_DEVICE_ID_MATCH_INT_CLASS \
> -		| USB_DEVICE_ID_MATCH_INT_PROTOCOL \
>  		| USB_DEVICE_ID_MATCH_DEVICE, \
>  	.idVendor = (vend), \
>  	.idProduct = (prod), \
> -	.bInterfaceClass = USB_INTERFACE_CLASS_HID, \
> -	.bInterfaceProtocol = USB_INTERFACE_PROTOCOL_MOUSE
> +	.bInterfaceClass = USB_INTERFACE_CLASS_HID
>  
>  static const struct usb_device_id usbtouch_devices[] = {
>  #ifdef CONFIG_TOUCHSCREEN_USB_EGALAX
> -- 
> 1.7.9.5
> 

-- 
Jiri Kosina
SUSE Labs

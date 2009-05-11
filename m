From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hid: add force feedback support for SmartJoy PLUS PS2/USB
 adapter
Date: Mon, 11 May 2009 17:17:05 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0905111712410.22712@wotan.suse.de>
References: <20090508074636.16912.55839.stgit@fate.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:43102 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751823AbZEKPRF (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 11 May 2009 11:17:05 -0400
In-Reply-To: <20090508074636.16912.55839.stgit@fate.lan>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jussi Kivilinna <jussi.kivilinna@mbnet.fi>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>

On Fri, 8 May 2009, Jussi Kivilinna wrote:

> This driver adds force feedback support for SmartJoy PLUS PS2/USB 
> adapter. I made this driver one device spesific instead of making 
> generic 'wisegroup-ff' because I have another Wisegroup PS2/USB adapter 
> that doesn't work same way as SmartJoy PLUS. If another device that is 
> compatible pops up, this driver could be then renamed to something more 
> generic.

Thanks for writing the driver!

> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1312,6 +1312,9 @@ static const struct hid_device_id hid_blacklist[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb651) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb654) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_TOPSEED, USB_DEVICE_ID_TOPSEED_CYBERLINK) },
> +#if defined(CONFIG_SMARTJOYPLUS_FF) || defined(CONFIG_SMARTJOYPLUS_FF_MODULE)
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_SMARTJOY_PLUS) },
> +#endif
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ZEROPLUS, 0x0005) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ZEROPLUS, 0x0030) },

Hmm, this isn't really compatible with what we have for other drivers, we 
require the config option to be turned on in order to have support (i.e. 
we include them into hid_blacklist unconditionally).

Otherwise the driver looks OK.

Jiri, what do you think?

Thanks,

-- 
Jiri Kosina
SUSE Labs

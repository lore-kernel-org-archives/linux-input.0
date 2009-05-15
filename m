From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH v3] hid: add force feedback support for SmartJoy PLUS
 PS2/USB adapter
Date: Fri, 15 May 2009 12:25:15 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0905151224050.22712@wotan.suse.de>
References: <20090513085438.2458.6988.stgit@fate.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090513085438.2458.6988.stgit-q/85JClnwdg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jussi Kivilinna <jussi.kivilinna-E01nCVcF24I@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, 13 May 2009, Jussi Kivilinna wrote:

> This driver adds force feedback support for SmartJoy PLUS PS2/USB adapter. I made this driver
> one device spesific instead of making generic 'wisegroup-ff' because I have another Wisegroup
> PS2/USB adapter that doesn't work same way as SmartJoy PLUS. If another device that is
> compatible pops up, this driver could be then renamed to something more generic.
> 
> v2 changes:
>  - use pr_fmt
>  - remove #ifdef from hid-core.c and made driver unable-to-disable if !EMBEDDED
> 
> v3 changes:
>  - use dev_dbg, not pr_fmt

I will apply this one and fix the other hid-ff drivers to work in a 
similar fashion (i.e. make the device working without FF effects if only 
the FF driver for this particular device has been disabled).

Thanks,

-- 
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

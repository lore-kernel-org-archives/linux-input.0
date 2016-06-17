From: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] usb: misc: remove outdated USB LED driver
Date: Fri, 17 Jun 2016 22:33:52 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1606172233110.6874@cbobk.fhfr.pm>
References: <2d50e14a-9ca4-b1ac-8e5e-62a466d97784@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2d50e14a-9ca4-b1ac-8e5e-62a466d97784-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Fri, 17 Jun 2016, Heiner Kallweit wrote:

> The USB LED driver exposes a undocumented sysfs interface and doesn't
> use the standard kernel LED subsystem. It supports three devices:
> 
> Delcom Visual Signal Indicator
> The driver supports generation 1 of the device only which was
> manufactured until 2008. Remove support for this device completely.
> 
> Riso Kagaku RGB LED + Dream Cheeky Webmail Notifier
> These devices are HID compliant and are supported by a new USB LED
> driver under drivers/hid utilizing the kernel LED subsystem.
> 
> So let's remove the old USB LED driver.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Acked-by: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>

I am applying this to hid.git#for-4.8/hid-led so that it goes together 
with the addition of hid-led driver.

Greg, if you have any objections, please speak up.

Thanks,

-- 
Jiri Kosina
SUSE Labs

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

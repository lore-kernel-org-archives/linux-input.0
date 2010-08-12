From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH RESEND] USB HID: Add ID for eGalax Multitouch used in
 JooJoo tablet
Date: Fri, 13 Aug 2010 01:15:24 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1008130113530.2702@pobox.suse.cz>
References: <m339wl2ug6.fsf@pullcord.laptop.org> <m3hbiz8m11.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <m3hbiz8m11.fsf-0VGQAjvlmrQzNDMTQreKSUB+6BGkLq7r@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephane Chatty <chatty-rXV5z7KbLFk@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Thu, 12 Aug 2010, Chris Ball wrote:

> The JooJoo tablet (http://thejoojoo.com/) contains an "eGalax Inc. USB
> TouchController", and this patch hooks it up to the egalax-touch driver.
> Without the patch we don't get any cursor motion, since it comes through
> Z/RX rather than X/Y.
> 
> Signed-off-by: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
> ---
>  drivers/hid/hid-egalax.c |    2 ++
>  drivers/hid/hid-ids.h    |    1 +
>  2 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/hid/hid-egalax.c b/drivers/hid/hid-egalax.c
> index f44bdc0..22e3b35 100644
> --- a/drivers/hid/hid-egalax.c
> +++ b/drivers/hid/hid-egalax.c
> @@ -246,6 +246,8 @@ static void egalax_remove(struct hid_device *hdev)
>  static const struct hid_device_id egalax_devices[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
>  			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
> +			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH1) },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(hid, egalax_devices);
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 6af77ed..01c3009 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -185,6 +185,7 @@
>  #define USB_VENDOR_ID_DWAV		0x0eef
>  #define USB_DEVICE_ID_EGALAX_TOUCHCONTROLLER	0x0001
>  #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH	0x480d
> +#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH1	0x720c
>  
>  #define USB_VENDOR_ID_ELO		0x04E7
>  #define USB_DEVICE_ID_ELO_TS2700	0x0020

Hi Chris,

has this patch been really tested?

I am almost certain that we need to have the device ID to be added to 
hid_blacklist[] in drivers/hid/hid-core.c as well. Otherwise the 
hid-egalax driver wouldn't bind to the device automatically in a proper 
way.

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH 3/3] HID: Force registration of an input device for "VEC
 footpedal" devices
Date: Mon, 19 Jul 2010 11:59:48 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1007191158330.4741@pobox.suse.cz>
References: <1278955708-9428-1-git-send-email-daniel@caiaq.de> <1278955708-9428-3-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1278955708-9428-3-git-send-email-daniel-rDUAYElUppE@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Mon, 12 Jul 2010, Daniel Mack wrote:

> These devices report a usage page of type "consumer" and a usage of
> "Programmable buttons". They are hence ignored by the hid-input layer.
> 
> Force the registration of an input device by using the new quirk type
> HID_QUIRK_HIDINPUT_FORCE.
> 
> Signed-off-by: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
> Cc: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
> Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/hid/hid-ids.h           |    2 ++
>  drivers/hid/usbhid/hid-quirks.c |    2 ++
>  2 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 6af77ed..0510cc1 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -505,5 +505,7 @@
>  #define USB_DEVICE_ID_KYE_ERGO_525V	0x0087
>  #define USB_DEVICE_ID_KYE_GPEN_560	0x5003
>  
> +#define USB_VENDOR_ID_PI_ENGINEERING	0x05f3
> +#define USB_DEVICE_ID_PI_ENGINEERING_VEC_USB_FOOTPEDAL	0xff
>  
>  #endif
> diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
> index 5ff8d32..12b38d1 100644
> --- a/drivers/hid/usbhid/hid-quirks.c
> +++ b/drivers/hid/usbhid/hid-quirks.c
> @@ -73,6 +73,8 @@ static const struct hid_blacklist {
>  	{ USB_VENDOR_ID_WISEGROUP_LTD, USB_DEVICE_ID_SMARTJOY_DUAL_PLUS, HID_QUIRK_NOGET | HID_QUIRK_MULTI_INPUT },
>  	{ USB_VENDOR_ID_WISEGROUP_LTD2, USB_DEVICE_ID_SMARTJOY_DUAL_PLUS, HID_QUIRK_NOGET | HID_QUIRK_MULTI_INPUT },
>  
> +	{ USB_VENDOR_ID_PI_ENGINEERING, USB_DEVICE_ID_PI_ENGINEERING_VEC_USB_FOOTPEDAL, HID_QUIRK_HIDINPUT_FORCE },
> +
>  	{ 0, 0 }
>  };

I have applied the whole series, thanks Daniel.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] hid: Fix boot delay for Creative SB Omni Surround 5.1
 with quirk
Date: Mon, 25 Apr 2016 14:24:34 +0200
Message-ID: <20160425122434.GE23234@mail.corp.redhat.com>
References: <0f11d1a2-a565-0ac2-2e27-b87c1705370a@mokrynskyi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <0f11d1a2-a565-0ac2-2e27-b87c1705370a-yn5EusZxFslygrA4Gshslw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nazar Mokrynskyi <nazar-yn5EusZxFslygrA4Gshslw@public.gmane.org>
Cc: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Apr 25 2016 or thereabouts, Nazar Mokrynskyi wrote:
> Needed for v2 of the device firmware, otherwise kernel will stuck for few
> seconds and throw "usb_submit_urb(ctrl) failed: -1" early on system boot.
> 
> Signed-off-by: Nazar Mokrynskyi <nazar-yn5EusZxFslygrA4Gshslw@public.gmane.org>
> ---

Looks good to me but your mailer might have mangled the lines.

Jiri might be able to apply the patch, but next time, please make sure
the mailer client does not break lines.

Reviewed-by: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Cheers,
Benjamin

>  drivers/hid/hid-ids.h           | 1 +
>  drivers/hid/usbhid/hid-quirks.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index c6eaff5..0238f01 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -259,6 +259,7 @@
>  #define USB_DEVICE_ID_CORSAIR_K90    0x1b02
> 
>  #define USB_VENDOR_ID_CREATIVELABS    0x041e
> +#define USB_DEVICE_ID_CREATIVE_SB_OMNI_SURROUND_51    0x322c
>  #define USB_DEVICE_ID_PRODIKEYS_PCMIDI    0x2801
> 
>  #define USB_VENDOR_ID_CVTOUCH        0x1ff7
> diff --git a/drivers/hid/usbhid/hid-quirks.c
> b/drivers/hid/usbhid/hid-quirks.c
> index ed2f68e..53fc856 100644
> --- a/drivers/hid/usbhid/hid-quirks.c
> +++ b/drivers/hid/usbhid/hid-quirks.c
> @@ -71,6 +71,7 @@ static const struct hid_blacklist {
>      { USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_3AXIS_5BUTTON_STICK,
> HID_QUIRK_NOGET },
>      { USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_AXIS_295, HID_QUIRK_NOGET },
>      { USB_VENDOR_ID_CHICONY,
> USB_DEVICE_ID_CHICONY_PIXART_USB_OPTICAL_MOUSE, HID_QUIRK_ALWAYS_POLL },
> +    { USB_VENDOR_ID_CREATIVELABS,
> USB_DEVICE_ID_CREATIVE_SB_OMNI_SURROUND_51, HID_QUIRK_NOGET },
>      { USB_VENDOR_ID_DMI, USB_DEVICE_ID_DMI_ENC, HID_QUIRK_NOGET },
>      { USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_WIIU,
> HID_QUIRK_MULTI_INPUT },
>      { USB_VENDOR_ID_ELAN, HID_ANY_ID, HID_QUIRK_ALWAYS_POLL },
> -- 
> 2.7.4
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

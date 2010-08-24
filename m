From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH 2.6.35.3] usbhid: USB 5543:6001 needs
 HID_QUIRK_MULTI_INPUT
Date: Tue, 24 Aug 2010 17:46:01 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1008241745530.1019@pobox.suse.cz>
References: <alpine.LFD.2.00.1008241235200.29566@Tk.techk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LFD.2.00.1008241235200.29566-zrNi74cEMLNg9hUCZPvPmw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Decio Fonini <fonini-F9PaRGVAbxDYtjvyW6yDsg@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, 24 Aug 2010, Decio Fonini wrote:

> From: Decio Fonini <fonini-F9PaRGVAbxDYtjvyW6yDsg@public.gmane.org>
> 
> The Kanvus Note A5 tablet (with USB ID 5543:6001, USB vendor UC_Logic) needs
> the HID_QUIRK_MULTI_INPUT in order to work out of the box; otherwise, we get
> the usual "cursor stuck at the upper left corner of the screen".
> 
> Signed-off-by: Decio Fonini <fonini-F9PaRGVAbxDYtjvyW6yDsg@public.gmane.org>
> 
> ---
> 
> diff -uprN -X a/Documentation/dontdiff a/drivers/hid/hid-ids.h
> b/drivers/hid/hid-ids.h
> --- a/drivers/hid/hid-ids.h	2010-08-20 15:55:55.000000000 -0300
> +++ b/drivers/hid/hid-ids.h	2010-08-24 10:17:12.244384470 -0300
> @@ -490,6 +490,7 @@
>  #define USB_VENDOR_ID_UCLOGIC		0x5543
>  #define USB_DEVICE_ID_UCLOGIC_TABLET_PF1209	0x0042
>  #define USB_DEVICE_ID_UCLOGIC_TABLET_WP4030U	0x0003
> +#define USB_DEVICE_ID_UCLOGIC_TABLET_KNA5	0x6001
> 
>  #define USB_VENDOR_ID_VERNIER		0x08f7
>  #define USB_DEVICE_ID_VERNIER_LABPRO	0x0001
> diff -uprN -X a/Documentation/dontdiff a/drivers/hid/usbhid/hid-quirks.c
> b/drivers/hid/usbhid/hid-quirks.c
> --- a/drivers/hid/usbhid/hid-quirks.c	2010-08-20 15:55:55.000000000 -0300
> +++ b/drivers/hid/usbhid/hid-quirks.c	2010-08-24 11:07:51.388410656 -0300
> @@ -69,6 +69,7 @@ static const struct hid_blacklist {
>  	{ USB_VENDOR_ID_TURBOX, USB_DEVICE_ID_TURBOX_KEYBOARD, HID_QUIRK_NOGET
> },
>  	{ USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_PF1209,
> HID_QUIRK_MULTI_INPUT },
>  	{ USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_WP4030U,
> HID_QUIRK_MULTI_INPUT },
> +	{ USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_KNA5,
> HID_QUIRK_MULTI_INPUT },
>  	{ USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_DUAL_USB_JOYPAD,
> HID_QUIRK_NOGET | HID_QUIRK_MULTI_INPUT | HID_QUIRK_SKIP_OUTPUT_REPORTS },
>  	{ USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_QUAD_USB_JOYPAD,
> HID_QUIRK_NOGET | HID_QUIRK_MULTI_INPUT },

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH] HID: add no-get quirk for eGalax touch controller
Date: Fri, 3 Sep 2010 12:17:48 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1009031217400.26813@pobox.suse.cz>
References: <1283461509-4488-1-git-send-email-jhovold@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1283461509-4488-1-git-send-email-jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Thu, 2 Sep 2010, Johan Hovold wrote:

> Add no-get quirk for eGalax touch controller to avoid timeout at probe.
> 
> Signed-off-by: Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
> 
> Hi Jiri, 
> 
> Without the no-get quirk the eGalax touch controller times out (after 10s) at
> probe:
> 
> [ 2239.402354] /usr/src/linux-2.6/drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_Report wValue=0x0101 wIndex=0x0000 wLength=6
> [ 2249.402218] /usr/src/linux-2.6/drivers/hid/usbhid/hid-core.c: timeout waiting for ctrl or out queue to clear
> [ 2249.404118] /usr/src/linux-2.6/drivers/hid/usbhid/hid-core.c: submitting ctrl urb: Get_Report wValue=0x0102 wIndex=0x0000 wLength=6
> [ 2249.404209] /usr/src/linux-2.6/drivers/hid/usbhid/hid-core.c: usb_submit_urb(ctrl) failed
> [ 2249.404341] generic-usb 0003:0EEF:0001.0001: timeout initializing reports
> 
> Note that this patch applies on top of Thierry's eGalaxy multi-input quirk
> patch that you recently applied.
> 
> Thanks,
> Johan
> 
> 
>  drivers/hid/usbhid/hid-quirks.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
> index 95ca317..2371cf1 100644
> --- a/drivers/hid/usbhid/hid-quirks.c
> +++ b/drivers/hid/usbhid/hid-quirks.c
> @@ -33,7 +33,7 @@ static const struct hid_blacklist {
>  	{ USB_VENDOR_ID_AASHIMA, USB_DEVICE_ID_AASHIMA_PREDATOR, HID_QUIRK_BADPAD },
>  	{ USB_VENDOR_ID_ALPS, USB_DEVICE_ID_IBM_GAMEPAD, HID_QUIRK_BADPAD },
>  	{ USB_VENDOR_ID_CHIC, USB_DEVICE_ID_CHIC_GAMEPAD, HID_QUIRK_BADPAD },
> -	{ USB_VENDOR_ID_DWAV, USB_DEVICE_ID_EGALAX_TOUCHCONTROLLER, HID_QUIRK_MULTI_INPUT },
> +	{ USB_VENDOR_ID_DWAV, USB_DEVICE_ID_EGALAX_TOUCHCONTROLLER, HID_QUIRK_MULTI_INPUT | HID_QUIRK_NOGET },
>  	{ USB_VENDOR_ID_DWAV, USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH, HID_QUIRK_MULTI_INPUT },
>  	{ USB_VENDOR_ID_MOJO, USB_DEVICE_ID_RETRO_ADAPTER, HID_QUIRK_MULTI_INPUT },
>  	{ USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_DRIVING, HID_QUIRK_BADPAD | HID_QUIRK_MULTI_INPUT },

Applied, thank you.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

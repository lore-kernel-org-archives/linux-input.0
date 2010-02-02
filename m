From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [RFC][PATCH] HID: add NOGET quirk for Prodige Cordless Combo
Date: Tue, 2 Feb 2010 20:34:04 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1002022033340.15395@pobox.suse.cz>
References: <1265129012-6023-1-git-send-email-virtuoso@slind.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1265129012-6023-1-git-send-email-virtuoso-0lOfPCoBze7YtjvyW6yDsg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Shishkin <virtuoso-0lOfPCoBze7YtjvyW6yDsg@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, 2 Feb 2010, Alexander Shishkin wrote:

> I happen to own a keyboard identified as 05af:3062 which is labeled as
> "FlatX Coldless Combo" by "Prodige", which exhibits input problems without
> NOGET quirk. For some reason, lsusb reports this device as "Jing-Mold
> Enterprise Co., Ltd", which is not mentioned anywhere on the package.
> A quick search on the intenet shows that there a other people who have
> this in their lsusb output, but apparently they don't have the problem
> I am seeing (or they are not such furious typists as myself).

Out of curiosity, what behavior does the device in question exhibit 
without the quirk?

> Signed-off-by: Alexander Shishkin <virtuoso-0lOfPCoBze7YtjvyW6yDsg@public.gmane.org>
> CC: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> CC: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> ---
>  drivers/hid/hid-ids.h           |    3 +++
>  drivers/hid/usbhid/hid-quirks.c |    1 +
>  2 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 010368e..034f694 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -382,6 +382,9 @@
>  #define USB_VENDOR_ID_POWERCOM		0x0d9f
>  #define USB_DEVICE_ID_POWERCOM_UPS	0x0002
>  
> +#define USB_VENDOR_ID_PRODIGE		0x05af
> +#define USB_DEVICE_ID_PRODIGE_CORDLESS	0x3062
> +
>  #define USB_VENDOR_ID_SAITEK		0x06a3
>  #define USB_DEVICE_ID_SAITEK_RUMBLEPAD	0xff17
>  
> diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
> index 38773dc..fc074c1 100644
> --- a/drivers/hid/usbhid/hid-quirks.c
> +++ b/drivers/hid/usbhid/hid-quirks.c
> @@ -45,6 +45,7 @@ static const struct hid_blacklist {
>  
>  	{ USB_VENDOR_ID_PANTHERLORD, USB_DEVICE_ID_PANTHERLORD_TWIN_USB_JOYSTICK, HID_QUIRK_MULTI_INPUT | HID_QUIRK_SKIP_OUTPUT_REPORTS },
>  	{ USB_VENDOR_ID_PLAYDOTCOM, USB_DEVICE_ID_PLAYDOTCOM_EMS_USBII, HID_QUIRK_MULTI_INPUT },
> +	{ USB_VENDOR_ID_PRODIGE, USB_DEVICE_ID_PRODIGE_CORDLESS, HID_QUIRK_NOGET },
>  
>  	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_UC100KM, HID_QUIRK_NOGET },
>  	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_CS124U, HID_QUIRK_NOGET },
> -- 
> 1.6.5
> 

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

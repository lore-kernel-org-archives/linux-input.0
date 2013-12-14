From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] Add new USB_DEVICE_ID to holtek workaround module
 (hid-holtek-mouse.c)
Date: Sun, 15 Dec 2013 00:40:29 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1312150028340.28760@pobox.suse.cz>
References: <120781387058135@web10j.yandex.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <120781387058135@web10j.yandex.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Kharlamov Alexey <derlafff@yandex.ru>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org


[ usual CCs added ]

On Sun, 15 Dec 2013, Kharlamov Alexey wrote:

> New USB_DEVICE_ID_HOLTEK_ALT_MOUSE_A070 constant was added to existing 
> workaround module, so RITMIX ROM-316 mouse can now work.
> 
> Signed-off-by: Alexey Kharlamov <derlafff@ya.ru>
> 
> ---
> 
> Tested and patched on linux-3.13-rc3

Hi Alexey,

I am wondering how this patch was tested, please? See comments below.

> diff -uprN a/drivers/hid/hid-holtek-mouse.c b/drivers/hid/hid-holtek-mouse.c
> --- a/drivers/hid/hid-holtek-mouse.c	2013-12-06 21:34:04.000000000 +0400
> +++ b/drivers/hid/hid-holtek-mouse.c	2013-12-15 01:24:30.277447386 +0400
> @@ -28,6 +28,7 @@
>   * - USB ID 04d9:a04a, sold as Tracer Sniper TRM-503, NOVA Gaming Slider X200
>   *   and Zalman ZM-GM1
>   * - USB ID 04d9:a081, sold as SHARKOON DarkGlider Gaming mouse
> + * - USB ID 04d9:a070, sold as RITMIX ROM-316 Gaming Mouse
>   * - USB ID 04d9:a072, sold as LEETGION Hellion Gaming Mouse
>   */

You are not adding a new switch case to holtek_mouse_report_fixup(), hence 
your patch seems to be a no-op (as the function does absolutely nothing 
and returns the original descriptor back)?

>  
> @@ -68,6 +69,8 @@ static const struct hid_device_id holtek
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_HOLTEK_ALT,
>  			USB_DEVICE_ID_HOLTEK_ALT_MOUSE_A04A) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_HOLTEK_ALT,
> +			USB_DEVICE_ID_HOLTEK_ALT_MOUSE_A070) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_HOLTEK_ALT,
>  			USB_DEVICE_ID_HOLTEK_ALT_MOUSE_A072) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_HOLTEK_ALT,
>  			USB_DEVICE_ID_HOLTEK_ALT_MOUSE_A081) },
> diff -uprN a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> --- a/drivers/hid/hid-ids.h	2013-12-06 21:34:04.000000000 +0400
> +++ b/drivers/hid/hid-ids.h	2013-12-15 01:22:37.661390627 +0400
> @@ -455,6 +455,7 @@
>  #define USB_DEVICE_ID_HOLTEK_ALT_KEYBOARD	0xa055
>  #define USB_DEVICE_ID_HOLTEK_ALT_MOUSE_A04A	0xa04a
>  #define USB_DEVICE_ID_HOLTEK_ALT_MOUSE_A067	0xa067
> +#define USB_DEVICE_ID_HOLTEK_ALT_MOUSE_A070	0xa070
>  #define USB_DEVICE_ID_HOLTEK_ALT_MOUSE_A072	0xa072
>  #define USB_DEVICE_ID_HOLTEK_ALT_MOUSE_A081	0xa081

You also need to add the device to hid_have_special_driver[] so that the 
binding is guaranteed to be correct.

Could you please work in fixing up and resending the patch?

Thanks,

-- 
Jiri Kosina
SUSE Labs

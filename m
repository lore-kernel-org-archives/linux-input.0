From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 2/2] HID: asus: Add support for Zen AiO MD-5110 keyboard
Date: Tue, 6 Jun 2017 09:51:19 +0200
Message-ID: <20170606075119.GV1293@mail.corp.redhat.com>
References: <20170605205857.17789-1-drake@endlessm.com>
 <20170605205857.17789-2-drake@endlessm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57310 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751272AbdFFHv3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 6 Jun 2017 03:51:29 -0400
Content-Disposition: inline
In-Reply-To: <20170605205857.17789-2-drake@endlessm.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Drake <drake@endlessm.com>
Cc: jikos@kernel.org, linux-input@vger.kernel.org, linux@endlessm.com

On Jun 05 2017 or thereabouts, Daniel Drake wrote:
> Add support for media keys on the MD-5110 wireless keyboard that comes
> with the Asus V221ID and ZN241IC All In One computers.
> 
> The keys to support here are WLAN, BRIGHTNESSDOWN and BRIGHTNESSUP.
> 
> The USB Vendor ID suggests that it is a TURBOX device, but
> the physical branding only mentions ASUS MD-5110.
> 
> Signed-off-by: Daniel Drake <drake@endlessm.com>
> ---

Series looks good to me (did not went deep in details):
Acked-by: Benjamin Tissoires <benajmin.tissoires@redhat.com>

Cheers,
Benjamin

>  drivers/hid/hid-asus.c | 1 +
>  drivers/hid/hid-core.c | 1 +
>  drivers/hid/hid-ids.h  | 1 +
>  3 files changed, 3 insertions(+)
> 
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 16a88da545b1..a4a3c38bc145 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -600,6 +600,7 @@ static const struct hid_device_id asus_devices[] = {
>  		USB_DEVICE_ID_ASUSTEK_T100_KEYBOARD),
>  	  QUIRK_T100_KEYBOARD | QUIRK_NO_CONSUMER_USAGES },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_ASUS_AK1D) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_TURBOX, USB_DEVICE_ID_ASUS_MD_5110) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_JESS, USB_DEVICE_ID_ASUS_MD_5112) },
>  	{ }
>  };
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 391dcc94d2c2..006cece0f6aa 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -2090,6 +2090,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_TOPSEED, USB_DEVICE_ID_TOPSEED_CYBERLINK) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_TOPSEED2, USB_DEVICE_ID_TOPSEED2_RF_COMBO) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_TWINHAN, USB_DEVICE_ID_TWINHAN_IR_REMOTE) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_TURBOX, USB_DEVICE_ID_ASUS_MD_5110) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_PF1209) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_WP4030U) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_WP5540U) },
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 10ad3899c079..20371ab0cac8 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -1022,6 +1022,7 @@
>  
>  #define USB_VENDOR_ID_TURBOX		0x062a
>  #define USB_DEVICE_ID_TURBOX_KEYBOARD	0x0201
> +#define USB_DEVICE_ID_ASUS_MD_5110	0x5110
>  #define USB_DEVICE_ID_TURBOX_TOUCHSCREEN_MOSART	0x7100
>  
>  #define USB_VENDOR_ID_TWINHAN		0x6253
> -- 
> 2.11.0
> 

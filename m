From: "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: multitouch: enable the Surface 4 Type Cover Pro
 (JP) to report multitouch data
Date: Thu, 15 Dec 2016 09:10:54 +0100
Message-ID: <20161215081054.GA31881@mail.corp.redhat.com>
References: <OSXPR01MB07917D3BE92900CAB5CC44E9F29D0@OSXPR01MB0791.jpnprd01.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47400 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753237AbcLOILA (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 15 Dec 2016 03:11:00 -0500
Content-Disposition: inline
In-Reply-To: <OSXPR01MB07917D3BE92900CAB5CC44E9F29D0@OSXPR01MB0791.jpnprd01.prod.outlook.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yuta Kobayashi <alu.ula@outlook.com>
Cc: alu <alu@ninja.co.jp>, Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org

Hi,

Please resend this patch to Jiri Kosina (Cc-ed),
linux-input@vger.kernel.org and myself so we can include it upstream.

On Dec 15 2016 or thereabouts, Yuta Kobayashi wrote:
> From: Yuta Kobayashi <alu.ula@outlook.com>
> 
> Signed-off-by: Yuta Kobayashi <alu.ula@outlook.com>
> Signed-off-by: alu <alu@ninja.co.jp>
> ---
>  drivers/hid/hid-core.c          | 2 --
>  drivers/hid/hid-ids.h           | 1 -
>  drivers/hid/hid-microsoft.c     | 2 --
>  drivers/hid/usbhid/hid-quirks.c | 1 -
>  4 files changed, 6 deletions(-)

Otherwise, that's the kind of patches I love :)

Cheers,
Benjamin

> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index cff060b..db87d91 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -729,7 +729,6 @@ static void hid_scan_collection(struct hid_parser *parser, unsigned type)
>  	     hid->product == USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP ||
>  	     hid->product == USB_DEVICE_ID_MS_TYPE_COVER_PRO_4 ||
>  	     hid->product == USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_2 ||
> -	     hid->product == USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_JP ||
>  	     hid->product == USB_DEVICE_ID_MS_POWER_COVER) &&
>  	    hid->group == HID_GROUP_MULTITOUCH)
>  		hid->group = HID_GROUP_GENERIC;
> @@ -1990,7 +1989,6 @@ static const struct hid_device_id hid_have_special_driver[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_4) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_2) },
> -	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_JP) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_DIGITAL_MEDIA_7K) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_DIGITAL_MEDIA_600) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_DIGITAL_MEDIA_3KV1) },
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index ec277b9..55758f7 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -723,7 +723,6 @@
>  #define USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP 0x07dd
>  #define USB_DEVICE_ID_MS_TYPE_COVER_PRO_4 0x07e4
>  #define USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_2 0x07e8
> -#define USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_JP 0x07e9
>  #define USB_DEVICE_ID_MS_POWER_COVER     0x07da
>  
>  #define USB_VENDOR_ID_MOJO		0x8282
> diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
> index 74b7b84..2b706b5 100644
> --- a/drivers/hid/hid-microsoft.c
> +++ b/drivers/hid/hid-microsoft.c
> @@ -284,8 +284,6 @@ static const struct hid_device_id ms_devices[] = {
>  		.driver_data = MS_HIDINPUT },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_2),
>  		.driver_data = MS_HIDINPUT },
> -	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_JP),
> -		.driver_data = MS_HIDINPUT },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_POWER_COVER),
>  		.driver_data = MS_HIDINPUT },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_COMFORT_KEYBOARD),
> diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
> index b3e01c8..ebb8e95 100644
> --- a/drivers/hid/usbhid/hid-quirks.c
> +++ b/drivers/hid/usbhid/hid-quirks.c
> @@ -105,7 +105,6 @@ static const struct hid_blacklist {
>  	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP, HID_QUIRK_NO_INIT_REPORTS },
>  	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_4, HID_QUIRK_NO_INIT_REPORTS },
>  	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_2, HID_QUIRK_NO_INIT_REPORTS },
> -	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_JP, HID_QUIRK_NO_INIT_REPORTS },
>  	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_POWER_COVER, HID_QUIRK_NO_INIT_REPORTS },
>  	{ USB_VENDOR_ID_MSI, USB_DEVICE_ID_MSI_GT683R_LED_PANEL, HID_QUIRK_NO_INIT_REPORTS },
>  	{ USB_VENDOR_ID_NEXIO, USB_DEVICE_ID_NEXIO_MULTITOUCH_PTI0750, HID_QUIRK_NO_INIT_REPORTS },
> -- 
> 2.5.5
> 

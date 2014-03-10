From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 1/2] Revert "HID: microsoft: Add ID's for Surface
 Type/Touch, Cover 2"
Date: Mon, 10 Mar 2014 16:22:19 -0400
Message-ID: <20140310202219.GA4125@mail.corp.redhat.com>
References: <531CAA1F.4080809@yahoo.de>
 <531CAA97.4020802@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59619 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752925AbaCJUWX (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Mar 2014 16:22:23 -0400
Content-Disposition: inline
In-Reply-To: <531CAA97.4020802@yahoo.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Derya <derya.kiran@yahoo.de>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

On Mar 09 2014 or thereabouts, Derya wrote:
> This reverts commit 117309c51dca42121f70cacec801511b76acf75c.
> 
> The MS Surface Pro 2 has an USB composite device with 3 interfaces
> - interface 0 - sensor hub
> - interface 1 - wacom digitizer
> - interface 2 - the keyboard cover, if one is attached
> This USB composite device changes it product id dependent on if and which
> keyboard cover is attached. Adding the covers to hid_have_special_driver
> prevents loading the right hid drivers for the other two interfaces, all 3
> get loaded with hid-microsoft. We don't even need hid-microsoft for the
> keyboards. We have to revert this to load the right hid modules for each
> interface.
> 
> Signed-off-by: Derya <derya.kiran@yahoo.de>

Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Hoewever, Derya, you should reconsider re-sending the whole series
through "git send-email" or configuring your e-mail client according to
Documentation/email-clients.txt . This series has the lines wrapped and
tabs are converted to spaces, which means that Jiri ca not take the
patch without reformatting them to his tree.

Thanks,
Benjamin

> ---
>  drivers/hid/hid-core.c      | 2 --
>  drivers/hid/hid-ids.h       | 2 --
>  drivers/hid/hid-microsoft.c | 4 ----
>  3 files changed, 8 deletions(-)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index cc32a6f..bb5c494 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1780,8 +1780,6 @@ static const struct hid_device_id
> hid_have_special_driver[] = {
>      { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
> USB_DEVICE_ID_MS_PRESENTER_8K_USB) },
>      { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
> USB_DEVICE_ID_MS_DIGITAL_MEDIA_3K) },
>      { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
> USB_DEVICE_ID_WIRELESS_OPTICAL_DESKTOP_3_0) },
> -    { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
> USB_DEVICE_ID_MS_TYPE_COVER_2) },
> -    { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
> USB_DEVICE_ID_MS_TOUCH_COVER_2) },
>      { HID_USB_DEVICE(USB_VENDOR_ID_MONTEREY, USB_DEVICE_ID_GENIUS_KB29E) },
>      { HID_USB_DEVICE(USB_VENDOR_ID_NTRIG, USB_DEVICE_ID_NTRIG_TOUCH_SCREEN)
> },
>      { HID_USB_DEVICE(USB_VENDOR_ID_NTRIG,
> USB_DEVICE_ID_NTRIG_TOUCH_SCREEN_1) },
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 22f28d6..07cd28c 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -624,8 +624,6 @@
>  #define USB_DEVICE_ID_MS_PRESENTER_8K_USB    0x0713
>  #define USB_DEVICE_ID_MS_DIGITAL_MEDIA_3K    0x0730
>  #define USB_DEVICE_ID_MS_COMFORT_MOUSE_4500    0x076c
> -#define USB_DEVICE_ID_MS_TOUCH_COVER_2    0x07a7
> -#define USB_DEVICE_ID_MS_TYPE_COVER_2    0x07a9
> 
>  #define USB_VENDOR_ID_MOJO        0x8282
>  #define USB_DEVICE_ID_RETRO_ADAPTER    0x3201
> diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
> index 404a3a8..c6ef6ee 100644
> --- a/drivers/hid/hid-microsoft.c
> +++ b/drivers/hid/hid-microsoft.c
> @@ -208,10 +208,6 @@ static const struct hid_device_id ms_devices[] = {
>          .driver_data = MS_NOGET },
>      { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
> USB_DEVICE_ID_MS_COMFORT_MOUSE_4500),
>          .driver_data = MS_DUPLICATE_USAGES },
> -    { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
> USB_DEVICE_ID_MS_TYPE_COVER_2),
> -        .driver_data = 0 },
> -    { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
> USB_DEVICE_ID_MS_TOUCH_COVER_2),
> -        .driver_data = 0 },
> 
>      { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT,
> USB_DEVICE_ID_MS_PRESENTER_8K_BT),
>          .driver_data = MS_PRESENTER },
> -- 
> 1.8.3.2
> 

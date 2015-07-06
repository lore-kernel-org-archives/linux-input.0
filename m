From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] HID:multitouch:add driver for CJTouch MultiTouch
Date: Mon, 6 Jul 2015 09:55:29 +0200
Message-ID: <CAN+gG=FWp61uBBEUq3-Zk-4yLv4QBWc10k08Yj5oe6K-r8Af5A@mail.gmail.com>
References: <1436104612-3357-1-git-send-email-linuxsea@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:34953 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917AbbGFHza (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Jul 2015 03:55:30 -0400
In-Reply-To: <1436104612-3357-1-git-send-email-linuxsea@163.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linuxsea@163.com
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Sun, Jul 5, 2015 at 3:56 PM,  <linuxsea@163.com> wrote:
> From: Yang Bo <linuxsea@163.com>
>
> Signed-off-by: Yang Bo <linuxsea@163.com>
> ---
>  drivers/hid/Kconfig          |    1 +
>  drivers/hid/hid-ids.h        |    4 ++++
>  drivers/hid/hid-multitouch.c |    8 ++++++++
>  3 files changed, 13 insertions(+)
>
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index cc4c664..57c94d7 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -480,6 +480,7 @@ config HID_MULTITOUCH
>           - Atmel panels
>           - Cando dual touch panels
>           - Chunghwa panels
> +         - CJTouch panels
>           - CVTouch panels
>           - Cypress TrueTouch panels
>           - Elan Microelectronics touch panels
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index b04b082..591b7d0 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -236,6 +236,10 @@
>
>  #define USB_VENDOR_ID_CIDC             0x1677
>
> +#define USB_VENDOR_ID_CJTOUCH          0x24b8
> +#define USB_DEVICE_ID_CJTOUCH_MULTI_TOUCH_0020 0x0020
> +#define USB_DEVICE_ID_CJTOUCH_MULTI_TOUCH_0040 0x0040
> +
>  #define USB_VENDOR_ID_CMEDIA           0x0d8c
>  #define USB_DEVICE_ID_CM109            0x000e
>
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 6a9b05b..5055008 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -1138,6 +1138,14 @@ static const struct hid_device_id mt_devices[] = {
>                 MT_USB_DEVICE(USB_VENDOR_ID_CHUNGHWAT,
>                         USB_DEVICE_ID_CHUNGHWAT_MULTITOUCH) },
>
> +       /* CJTouch panels */
> +       { .driver_data = MT_CLS_DEFAULT,
> +               HID_USB_DEVICE(USB_VENDOR_ID_CJTOUCH,
> +                       USB_DEVICE_ID_CJTOUCH_MULTI_TOUCH_0020) },
> +       { .driver_data = MT_CLS_DEFAULT,
> +               HID_USB_DEVICE(USB_VENDOR_ID_CJTOUCH,
> +                       USB_DEVICE_ID_CJTOUCH_MULTI_TOUCH_0040) },
> +

Just taking a few minutes while I am still on vacations...

NACK. If the devices work with the MT_CLS_DEFAULT class, there is no
point in adding them in the list of special devices.
This list should only contain the devices that requires special quirks
which is not the case here.

Thanks for the submission though!

Cheers,
Benjamin

>         /* CVTouch panels */
>         { .driver_data = MT_CLS_NSMU,
>                 MT_USB_DEVICE(USB_VENDOR_ID_CVTOUCH,
> --
> 1.7.9.5
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

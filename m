From: JJ Ding <jj_ding@emc.com.tw>
Subject: Re: [PATCH] Input: hid-multitouch- support PixArt optical touch screen
Date: Tue, 06 Dec 2011 19:27:45 +0800
Message-ID: <87borm549a.fsf@emc.com.tw>
References: <OF2AC9FD94.4CE4D9FB-ON4825795E.0037FF42-4825795E.00380F71@pixart.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:43391 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753731Ab1LFL3W (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Dec 2011 06:29:22 -0500
In-Reply-To: <OF2AC9FD94.4CE4D9FB-ON4825795E.0037FF42-4825795E.00380F71@pixart.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: aaron_tian@pixart.com.tw, linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com

Hi Aaron,

I can't apply your patch. Your MUA seems to wrap the mail. Maybe you
want to use "git send-email" instead.

Btw, the fisrt part of the mail should be your commit message. You can
put your explanation below the "---" line. And hid drivers are
maintained by Jiri Kosina <jkosina@suse.cz>, you might also CC Jiri next
time.

Thanks.

br,
jj

On Tue, 6 Dec 2011 18:12:19 +0800, aaron_tian@pixart.com.tw wrote:
> From: Aaron Tian <aaron_tian@pixart.com.tw>
> 
> Hello,
> 
> This ia Aaron Tian in Pixart. We have modified the hid-multitouch driver 
> for 
> supporting PixArt optical touch screen and it works well. Because of the 
> device 
> does not have to set initial report, we apply "HID_QUIRK_NO_INIT_REPORTS" 
> quirk and add the device into hid_blacklist in 
> drivers/hid/usbhid/hid-quirks.c 
> 
> The patch is according to commit 45e713efe2fa574b6662e7fb63fae9497c5e03d4 
> of 
> Linux mainline git (3.2.0-rc4+)
> 
> 
> Signed-off-by: Aaron Tian <aaron_tian@pixart.com.tw>
> ---


>  drivers/hid/Kconfig             |    1 +
>  drivers/hid/hid-core.c          |    1 +
>  drivers/hid/hid-ids.h           |    3 +++
>  drivers/hid/hid-multitouch.c    |    5 +++++
>  drivers/hid/usbhid/hid-quirks.c |    1 +
>  5 files changed, 11 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 22a4a05..eda54b6 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -349,6 +349,7 @@ config HID_MULTITOUCH
>           - Lumio CrystalTouch panels
>           - MosArt dual-touch panels
>           - PenMount dual touch panels
> +         - PixArt optical touch screen
>           - Pixcir dual touch panels
>           - eGalax dual-touch panels, including the Joojoo and Wetab 
> tablets
>           - Stantum multitouch panels
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index af35384..e9280ef 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1498,6 +1498,7 @@ static const struct hid_device_id 
> hid_have_special_driver[] = {
>         { HID_USB_DEVICE(USB_VENDOR_ID_ORTEK, USB_DEVICE_ID_ORTEK_WKB2000) 
> },
>         { HID_USB_DEVICE(USB_VENDOR_ID_PENMOUNT, 
> USB_DEVICE_ID_PENMOUNT_PCI) },
>         { HID_USB_DEVICE(USB_VENDOR_ID_PETALYNX, 
> USB_DEVICE_ID_PETALYNX_MAXTER_REMOTE) },
> +       { HID_USB_DEVICE(USB_VENDOR_TYPE_PIXART, 
> USB_DEVICE_TYPE_PIXART_OPTICAL_TOUCH_SCREEN) },
>         { HID_USB_DEVICE(USB_VENDOR_ID_PRIMAX, 
> USB_DEVICE_ID_PRIMAX_KEYBOARD) },
>         { HID_USB_DEVICE(USB_VENDOR_ID_QUANTA, 
> USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH) },
>         { HID_USB_DEVICE(USB_VENDOR_ID_QUANTA, 
> USB_DEVICE_ID_PIXART_IMAGING_INC_OPTICAL_TOUCH_SCREEN) },
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 4a441a6..869911b 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -571,6 +571,9 @@
>  #define USB_VENDOR_ID_PI_ENGINEERING   0x05f3
>  #define USB_DEVICE_ID_PI_ENGINEERING_VEC_USB_FOOTPEDAL 0xff
>  
> +#define USB_VENDOR_TYPE_PIXART                         0x093a
> +#define USB_DEVICE_TYPE_PIXART_OPTICAL_TOUCH_SCREEN    0x8001
> +
>  #define USB_VENDOR_ID_PLAYDOTCOM       0x0b43
>  #define USB_DEVICE_ID_PLAYDOTCOM_EMS_USBII     0x0003
>  
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index f1c909f..2f338b1 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -722,6 +722,11 @@ static const struct hid_device_id mt_devices[] = {
>                 HID_USB_DEVICE(USB_VENDOR_ID_PENMOUNT,
>                         USB_DEVICE_ID_PENMOUNT_PCI) },
>  
> +       /* PixArt optical touch screen */
> +       { .driver_data = MT_CLS_DUAL_INRANGE_CONTACTNUMBER,
> +               HID_USB_DEVICE(USB_VENDOR_ID_PIXART,
> +                       USB_DEVICE_ID_PIXART_OPTICAL_TOUCH_SCREEN) },
> +
>         /* PixCir-based panels */
>         { .driver_data = MT_CLS_DUAL_INRANGE_CONTACTID,
>                 HID_USB_DEVICE(USB_VENDOR_ID_HANVON,
> diff --git a/drivers/hid/usbhid/hid-quirks.c 
> b/drivers/hid/usbhid/hid-quirks.c
> index 5028d60..99324eb 100644
> --- a/drivers/hid/usbhid/hid-quirks.c
> +++ b/drivers/hid/usbhid/hid-quirks.c
> @@ -67,6 +67,7 @@ static const struct hid_blacklist {
>         { USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_AXIS_295, HID_QUIRK_NOGET },
>         { USB_VENDOR_ID_DMI, USB_DEVICE_ID_DMI_ENC, HID_QUIRK_NOGET },
>         { USB_VENDOR_ID_ELO, USB_DEVICE_ID_ELO_TS2700, HID_QUIRK_NOGET },
> +       { USB_VENDOR_ID_PIXART, USB_DEVICE_ID_PIXART_OPTICAL_TOUCH_SCREEN, 
> HID_QUIRK_NO_INIT_REPORTS },
>         { USB_VENDOR_ID_PRODIGE, USB_DEVICE_ID_PRODIGE_CORDLESS, 
> HID_QUIRK_NOGET },
>         { USB_VENDOR_ID_QUANTA, 
> USB_DEVICE_ID_PIXART_IMAGING_INC_OPTICAL_TOUCH_SCREEN, HID_QUIRK_NOGET },
>         { USB_VENDOR_ID_SUN, USB_DEVICE_ID_RARITAN_KVM_DONGLE, 
> HID_QUIRK_NOGET },
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

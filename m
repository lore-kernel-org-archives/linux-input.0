From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 1/2] usbhid: Add quirks for Mayflash/Dragonrise GameCube
 and PS3 adapters.
Date: Mon, 31 Oct 2016 12:10:21 +0100
Message-ID: <20161031111021.GA12010@mail.corp.redhat.com>
References: <cover.1477863542.git.mahasler@gmail.com>
 <20161030221256.GA15434@arch-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33164 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754898AbcJaLKk (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 31 Oct 2016 07:10:40 -0400
Content-Disposition: inline
In-Reply-To: <20161030221256.GA15434@arch-desktop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marcel Hasler <mahasler@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org

On Oct 30 2016 or thereabouts, Marcel Hasler wrote:
> All known gamepad adapters by Mayflash (identified as Dragonrise) need HID_QUIRK_MULTI_INPUT to
> split them up into four input devices. Without this quirk those adapters are falsely recognized
> as tablets. Fixes bug 115841 (https://bugzilla.kernel.org/show_bug.cgi?id=115841).
> 
> Signed-off-by: Marcel Hasler <mahasler@gmail.com>
> ---
>  drivers/hid/hid-ids.h           | 6 ++++--
>  drivers/hid/usbhid/hid-quirks.c | 2 ++
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 6cfb5ca..642e648 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -314,8 +314,10 @@
>  #define USB_VENDOR_ID_DMI		0x0c0b
>  #define USB_DEVICE_ID_DMI_ENC		0x5fab
>  
> -#define USB_VENDOR_ID_DRAGONRISE	0x0079
> -#define USB_DEVICE_ID_DRAGONRISE_WIIU	0x1800
> +#define USB_VENDOR_ID_DRAGONRISE		0x0079
> +#define USB_DEVICE_ID_DRAGONRISE_WIIU		0x1800
> +#define USB_DEVICE_ID_DRAGONRISE_PS3		0x1801

I already gave my rev-by of this patch earlier today, but if you are to
switch the device to be using a specific driver, I'd rather see the HID
quirk set into the driver itself. The rational is that if you have to
use a Bluetooth connection or a replay of the device through uhid,
you'll get the quirk applied, while this patch only applies to
USB physically connected devices.

Cheers,
Benjamin

> +#define USB_DEVICE_ID_DRAGONRISE_GAMECUBE	0x1843
>  
>  #define USB_VENDOR_ID_DWAV		0x0eef
>  #define USB_DEVICE_ID_EGALAX_TOUCHCONTROLLER	0x0001
> diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
> index 354d49e..05f6f61 100644
> --- a/drivers/hid/usbhid/hid-quirks.c
> +++ b/drivers/hid/usbhid/hid-quirks.c
> @@ -81,6 +81,8 @@ static const struct hid_blacklist {
>  	{ USB_VENDOR_ID_CREATIVELABS, USB_DEVICE_ID_CREATIVE_SB_OMNI_SURROUND_51, HID_QUIRK_NOGET },
>  	{ USB_VENDOR_ID_DMI, USB_DEVICE_ID_DMI_ENC, HID_QUIRK_NOGET },
>  	{ USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_WIIU, HID_QUIRK_MULTI_INPUT },
> +	{ USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_PS3, HID_QUIRK_MULTI_INPUT },
> +	{ USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_GAMECUBE, HID_QUIRK_MULTI_INPUT },
>  	{ USB_VENDOR_ID_ELAN, HID_ANY_ID, HID_QUIRK_ALWAYS_POLL },
>  	{ USB_VENDOR_ID_ELO, USB_DEVICE_ID_ELO_TS2700, HID_QUIRK_NOGET },
>  	{ USB_VENDOR_ID_FORMOSA, USB_DEVICE_ID_FORMOSA_IR_RECEIVER, HID_QUIRK_NO_INIT_REPORTS },
> -- 
> 2.10.1
> 

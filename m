From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Mayflash / Dragonrise GameCube controller adapter recognized as
 tablet, not joystick
Date: Wed, 11 Feb 2015 10:17:24 -0800
Message-ID: <20150211181724.GD29440@dtor-ws>
References: <CABFQKmN7Lzr2GzZ4d+HgbzMRDe_NBxJDL81qMpaOGOV07LYwag@mail.gmail.com>
 <CAKdAkRTU5a8MTstcJXgqAcfAKgjKUz=64aKP11TPaJKcCytK3w@mail.gmail.com>
 <CABFQKmMMJBj==983B-hgxT5MqpYV7uesSLvQqKgsTMXHgL+rMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:47130 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753831AbbBKSRb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Feb 2015 13:17:31 -0500
Received: by mail-wg0-f53.google.com with SMTP id x13so5153151wgg.12
        for <linux-input@vger.kernel.org>; Wed, 11 Feb 2015 10:17:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CABFQKmMMJBj==983B-hgxT5MqpYV7uesSLvQqKgsTMXHgL+rMg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Rodland <andrew@cleverdomain.org>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

Hi Andrew,

On Thu, Feb 05, 2015 at 12:02:21AM -0500, Andrew Rodland wrote:
> On Wed, Feb 4, 2015 at 7:48 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > Hi Andrew,
> >
> >
> > From the list of events you posted below it seems the device needs
> > HID_QUIRK_MULTI_INPUT to split it into 4 individual input devices.
> >
> That did the trick neatly. Everything works, although no force
> feedback (and sadly hacking it into hid-dr isn't as trivial as I
> hoped).
> 
> Patch in case it's useful (attached because of gmail, sorry).
> 
> (which also doesn't reply to list by default, so here's a dupe. Some
> day I'll switch back to a real mail client.)

Thank you for the patch. For it to be applied you need to add your
"Signed-off-by" to the commit message - see
Documentation/SubmittingPatches - and explain in the commit message why
the change was needed.

Please also CC Jiri Kosina <jkosina@suse.cz> on your next submission
since he's the maintainer of HID subsystem and the patch will need to go
through his tree.

Thanks!

> From 61ca320a43f652edeb00d37fecfef1f2226afbab Mon Sep 17 00:00:00 2001
> From: Andrew Rodland <andrew@cleverdomain.org>
> Date: Wed, 4 Feb 2015 23:09:36 -0500
> Subject: [PATCH] Add HID_QUIRK_MULTI_INPUT for Dragonrise GameCube adapter
> 
> ---
>  drivers/hid/hid-ids.h           | 3 ++-
>  drivers/hid/usbhid/hid-quirks.c | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 9243359..041753e 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -272,7 +272,8 @@
>  #define USB_VENDOR_ID_DMI		0x0c0b
>  #define USB_DEVICE_ID_DMI_ENC		0x5fab
>  
> -#define USB_VENDOR_ID_DRAGONRISE	0x0079
> +#define USB_VENDOR_ID_DRAGONRISE                0x0079
> +#define USB_DEVICE_ID_DRAGONRISE_GAMECUBE       0x1843
>  
>  #define USB_VENDOR_ID_DWAV		0x0eef
>  #define USB_DEVICE_ID_EGALAX_TOUCHCONTROLLER	0x0001
> diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
> index b27b3d3..e47a445 100644
> --- a/drivers/hid/usbhid/hid-quirks.c
> +++ b/drivers/hid/usbhid/hid-quirks.c
> @@ -70,6 +70,7 @@ static const struct hid_blacklist {
>  	{ USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_3AXIS_5BUTTON_STICK, HID_QUIRK_NOGET },
>  	{ USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_AXIS_295, HID_QUIRK_NOGET },
>  	{ USB_VENDOR_ID_DMI, USB_DEVICE_ID_DMI_ENC, HID_QUIRK_NOGET },
> +	{ USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_GAMECUBE, HID_QUIRK_MULTI_INPUT },
>  	{ USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ELAN_TOUCHSCREEN, HID_QUIRK_ALWAYS_POLL },
>  	{ USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ELAN_TOUCHSCREEN_009B, HID_QUIRK_ALWAYS_POLL },
>  	{ USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ELAN_TOUCHSCREEN_0103, HID_QUIRK_ALWAYS_POLL },
> -- 
> 1.9.1
> 

-- 
Dmitry

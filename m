From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: add support for 0079:1846 Mayflash/Dragonrise USB
 Gamecube Adapter
Date: Tue, 1 Oct 2019 16:17:49 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1910011617080.13160@cbobk.fhfr.pm>
References: <CAAPc1Th4mgE=ntLY=NXn2Jbfgi0OBpZ5R2sYGhWJ_4+syuPA9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAPc1Th4mgE=ntLY=NXn2Jbfgi0OBpZ5R2sYGhWJ_4+syuPA9w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ethan Warth <redyoshi49q@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com
List-Id: linux-input@vger.kernel.org

On Fri, 6 Sep 2019, Ethan Warth wrote:

> >From 32bdfb1d652cc38ab13f8616df58dee726201785 Mon Sep 17 00:00:00 2001
> From: Ethan Warth <redyoshi49q@gmail.com>
> Date: Wed, 4 Sep 2019 16:07:45 -0500
> Subject: [PATCH] HID: add support for 0079:1846 Mayflash/Dragonrise USB Gamecube
>  Adapter
> 
> Mayflash/Dragonrise seems to have yet another device ID for one of their
> Gamecube controller adapters.  Previous to this commit, the adapter
> registered only one /dev/input/js* device, and all controller inputs (from
> any controller) were mapped to this device.  This patch defines the 1846
> USB device ID and enables the HID_QUIRK_MULTI_INPUT quirk for it, which
> fixes that (with the patch, four /dev/input/js* devices are created, one
> for each of the four controller ports).
> ---
>  drivers/hid/hid-ids.h    | 1 +
>  drivers/hid/hid-mf.c     | 2 ++
>  drivers/hid/hid-quirks.c | 2 ++
>  3 files changed, 5 insertions(+)
> 
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 0a00be19f7a0..9cd909985a4c 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -362,6 +362,7 @@
>  #define USB_DEVICE_ID_DRAGONRISE_DOLPHINBAR    0x1803
>  #define USB_DEVICE_ID_DRAGONRISE_GAMECUBE1    0x1843
>  #define USB_DEVICE_ID_DRAGONRISE_GAMECUBE2    0x1844
> +#define USB_DEVICE_ID_DRAGONRISE_GAMECUBE3    0x1846
> 
>  #define USB_VENDOR_ID_DWAV        0x0eef
>  #define USB_DEVICE_ID_EGALAX_TOUCHCONTROLLER    0x0001
> diff --git a/drivers/hid/hid-mf.c b/drivers/hid/hid-mf.c
> index fc75f30f537c..92d7ecd41a78 100644
> --- a/drivers/hid/hid-mf.c
> +++ b/drivers/hid/hid-mf.c
> @@ -153,6 +153,8 @@ static const struct hid_device_id mf_devices[] = {
>          .driver_data = HID_QUIRK_MULTI_INPUT },
>      { HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE,
> USB_DEVICE_ID_DRAGONRISE_GAMECUBE2),
>          .driver_data = 0 }, /* No quirk required */
> +    { HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE,
> USB_DEVICE_ID_DRAGONRISE_GAMECUBE3),

Thanks a lot for the fix; however your mail client seems to have damaged 
it badly with respect to whitespace and line-wrapping. Could you please 
fix that up and resend?

Thanks,

-- 
Jiri Kosina
SUSE Labs

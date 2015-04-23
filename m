From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: hid-plantronics: Update to map volume up/down
 controls
Date: Thu, 23 Apr 2015 10:22:05 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1504231017320.3695@pobox.suse.cz>
References: <1428779862-31930-1-git-send-email-terry.junge@plantronics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:39740 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755870AbbDWIWH (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Apr 2015 04:22:07 -0400
In-Reply-To: <1428779862-31930-1-git-send-email-terry.junge@plantronics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Terry Junge <terry.junge@plantronics.com>
Cc: linux-input@vger.kernel.org

On Sat, 11 Apr 2015, Terry Junge wrote:

> Update hid-plantronics.c to identify device type and correctly map
> either the vendor unique or consumer control volume up/down usages
> to KEY_VOLUMEUP and KEY_VOLUMEDOWN events.
> 
> Update Kconfig with enhanced help text for hid-plantronics driver
> and changed default value from !EXPERT to m. This driver prevents
> hid-input from mapping unknown vendor unique usages to mouse events
> so it is preferred that it be available, expert or not.
> 
> Signed-off-by: Terry Junge <terry.junge@plantronics.com>
> ---
>  drivers/hid/Kconfig           |   7 +-
>  drivers/hid/hid-plantronics.c | 152 +++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 149 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 152b006..69aac6b 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -638,10 +638,13 @@ config HID_PICOLCD_CIR
> 
>  config HID_PLANTRONICS
>         tristate "Plantronics USB HID Driver"
> -       default !EXPERT

The '!EXPERT' stuff is gone in current Linus' tree (see commit 
7af05e73cd).

> +       default m
>         depends on HID
>         ---help---
> -       Provides HID support for Plantronics telephony devices.
> +       Provides HID support for Plantronics USB audio devices.
> +       Correctly maps vendor unique volume up/down HID usages to
> +       KEY_VOLUMEUP and KEY_VOLUMEDOWN events and prevents core mapping
> +       of other vendor unique HID usages to random mouse events.
> 
>  config HID_PRIMAX
>         tristate "Primax non-fully HID-compliant devices"
> diff --git a/drivers/hid/hid-plantronics.c b/drivers/hid/hid-plantronics.c
> index 2180e07..c4756a1 100644
> --- a/drivers/hid/hid-plantronics.c
> +++ b/drivers/hid/hid-plantronics.c
> @@ -2,7 +2,7 @@
>   *  Plantronics USB HID Driver
>   *
>   *  Copyright (c) 2014 JD Cole <jd.cole@plantronics.com>
> - *  Copyright (c) 2014 Terry Junge <terry.junge@plantronics.com>
> + *  Copyright (c) 2015 Terry Junge <terry.junge@plantronics.com>
>   */
> 
>  /*
> @@ -14,26 +14,161 @@
> 
>  #include "hid-ids.h"
> 
> +#include <linux/usb.h>
>  #include <linux/hid.h>
>  #include <linux/module.h>
> 
> +#define PLT_HID_1_0_PAGE       0xffa00000
> +#define PLT_HID_2_0_PAGE       0xffa20000
> +
> +#define PLT_BASIC_TELEPHONY    0x0003
> +#define PLT_BASIC_EXCEPTION    0x0005
> +
> +#define PLT_VOL_UP             0x00b1
> +#define PLT_VOL_DOWN           0x00b2
> +
> +#define PLT1_VOL_UP            (PLT_HID_1_0_PAGE | PLT_VOL_UP)
> +#define PLT1_VOL_DOWN          (PLT_HID_1_0_PAGE | PLT_VOL_DOWN)
> +#define PLT2_VOL_UP            (PLT_HID_2_0_PAGE | PLT_VOL_UP)
> +#define PLT2_VOL_DOWN          (PLT_HID_2_0_PAGE | PLT_VOL_DOWN)
> +
> +#define PLT_DA60               0xda60
> +
> +#define PLT_ALLOW_CONSUMER (field->application == HID_CP_CONSUMERCONTROL && \
> +                           (usage->hid & HID_USAGE_PAGE) == HID_UP_CONSUMER)
> +
>  static int plantronics_input_mapping(struct hid_device *hdev,
>                                      struct hid_input *hi,
>                                      struct hid_field *field,
>                                      struct hid_usage *usage,
>                                      unsigned long **bit, int *max)
>  {
> -       if (field->application == HID_CP_CONSUMERCONTROL
> -           && (usage->hid & HID_USAGE_PAGE) == HID_UP_CONSUMER) {
> -               hid_dbg(hdev, "usage: %08x (appl: %08x) - defaulted\n",
> -                        usage->hid, field->application);
> -               return 0;
> +       unsigned short mapped_key;
> +       unsigned long plt_type = (unsigned long)hid_get_drvdata(hdev);
> +
> +       /* handle volume up/down mapping */
> +       /* non-standard types or multi-HID interfaces - plt_type is PID */
> +       if (!(plt_type & HID_USAGE_PAGE)) {
> +               switch (plt_type) {
> +               case PLT_DA60:
> +                       if (PLT_ALLOW_CONSUMER)
> +                               goto defaulted;
> +                       goto ignored;
> +               default:
> +                       if (PLT_ALLOW_CONSUMER)
> +                               goto defaulted;
> +               }
> +       }
> +       /* handle standard types - plt_type is 0xffa0uuuu or 0xffa2uuuu */
> +       /* 'basic telephony compliant' - allow default consumer page map */
> +       else if ((plt_type & HID_USAGE) >= PLT_BASIC_TELEPHONY &&
> +                (plt_type & HID_USAGE) != PLT_BASIC_EXCEPTION) {
> +               if (PLT_ALLOW_CONSUMER)
> +                       goto defaulted;
> +       }
> +       /* not 'basic telephony' - apply legacy mapping */
> +       /* only map if the field is in the device's primary vendor page */
> +       else if (!((field->application ^ plt_type) & HID_USAGE_PAGE)) {
> +               switch (usage->hid) {
> +               case PLT1_VOL_UP:
> +               case PLT2_VOL_UP:
> +                       mapped_key = KEY_VOLUMEUP;
> +                       goto mapped;
> +               case PLT1_VOL_DOWN:
> +               case PLT2_VOL_DOWN:
> +                       mapped_key = KEY_VOLUMEDOWN;
> +                       goto mapped;
> +               }
>         }
> 
> -       hid_dbg(hdev, "usage: %08x (appl: %08x) - ignored\n",
> -               usage->hid, field->application);
> +/*
> + * Future mapping of call control or other usages,
> + * if and when keys are defined would go here
> + * otherwise, ignore everything else that was not mapped
> + */
> 
> +ignored:
>         return -1;
> +
> +defaulted:
> +       hid_dbg(hdev, "usage: %08x (appl: %08x) - defaulted\n",
> +               usage->hid, field->application);
> +       return 0;
> +
> +mapped:
> +       hid_map_usage_clear(hi, usage, bit, max, EV_KEY, mapped_key);
> +       hid_dbg(hdev, "usage: %08x (appl: %08x) - mapped to key %d\n",
> +               usage->hid, field->application, mapped_key);
> +       return 1;
> +}
> +
> +static int plantronics_hid_interface_count(struct hid_device *hdev)
> +{
> +       int i, count;
> +       struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
> +       struct usb_device *udev = interface_to_usbdev(intf);
> +       struct usb_host_config *config = udev->actconfig;

You are now introducing USB-isms into a HID driver.

Is it really necessary? The changelog is rather sparse about the reason 
why you are counting the USB interfaces and make decisions based on it. 
Could you please be more verbose there?

Also, as you as now using USB-isms in the driver, you have to make it 
dependent on USB availability.

Thanks,

-- 
Jiri Kosina
SUSE Labs

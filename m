From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Plantronics Telephony Device HID Driver
Date: Thu, 23 Oct 2014 16:49:06 -0700
Message-ID: <20141023234906.GC9463@dtor-ws>
References: <05963dc6f4db439e88525351d4e9a0b8@usscmb04.plt.plantronics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:50323 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753179AbaJWXtM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Oct 2014 19:49:12 -0400
Received: by mail-pd0-f182.google.com with SMTP id y10so373078pdj.13
        for <linux-input@vger.kernel.org>; Thu, 23 Oct 2014 16:49:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <05963dc6f4db439e88525351d4e9a0b8@usscmb04.plt.plantronics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Cole, JD" <JD.Cole@plantronics.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "Wesselman, Tom" <Tom.Wesselman@plantronics.com>, "Dsouza, Sunil" <Sunil.Dsouza@plantronics.com>, "Junge, Terry" <Terry.Junge@plantronics.com>, "dtor@chromium.org" <dtor@chromium.org>, "bleung@chromium.org" <bleung@chromium.org>, "vpalatin@chromium.org" <vpalatin@chromium.org>, "adlr@chromium.org" <adlr@chromium.org>, Jiri Kosina <jkosina@suse.cz>

Hi JD,

On Tue, Oct 21, 2014 at 06:40:26PM +0000, Cole, JD wrote:
> Plantronics telephony devices equipped with HID-enabled controls have been reported to cause odd mouse behaviors when buttons are clicked. This is due to how the hid-input driver handles "unmapped" usages and the fact that Plantronics devices send Vendor Unique usages in addition to standards, e.g. Consumer Page Mute. It is the vendor unique usages that are mis-interpreted by the hid-input driver and mapped as mouse events.
> 
> This driver serves to prevent unhandled usages from reaching the hid-input driver. Two patches are included:
> 
> (1) The minimal driver
> (2) The more complete additions to hid.h Consumer Page MACROS
> 
> Cheers,
> 
> jd
> 
> From ee603e2aa62906a65b08b440c4b440e324269295 Mon Sep 17 00:00:00 2001
> From: JD Cole <jd.cole@plantronics.com>
> Date: Fri, 17 Oct 2014 12:21:49 -0700
> Subject: [PATCH 1/2] Created base Plantronics HID driver.
> 
> A fix for Plantronics telephony device controls interfering with
> the mouse.
> 
> This version of the driver prevents Telephony pages which are not
> mapped as Consumer Control applications AND are not on the Consumer Page
> from being registered by the hid-input driver.
> 
> BUG=chromium:417434
> TEST=Tested with multiple Plantronics devices on 'peppy' Acer C720p.
> 
> Change-Id: I7a55880d6082467274b693c48415e9331d9bbd81
> Signed-off-by: JD Cole <jd.cole@plantronics.com>
> ---
>  drivers/hid/Kconfig           |  7 ++++
>  drivers/hid/Makefile          |  1 +
>  drivers/hid/hid-ids.h         |  2 +
>  drivers/hid/hid-plantronics.c | 92 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/hid.h           |  3 ++
>  5 files changed, 105 insertions(+)
>  create mode 100644 drivers/hid/hid-plantronics.c
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 2f38a7b..b245c28 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -594,6 +594,13 @@ config HID_PICOLCD_CIR
>         ---help---
>           Provide access to PicoLCD's CIR interface via remote control (LIRC).
> 
> +config HID_PLANTRONICS
> +       tristate "Plantronics USB HID Driver"
> +       default !EXPERT
> +       depends on HID
> +       ---help---
> +       Provides HID support for Plantronics telephony devices.
> +
>  config HID_PRIMAX
>         tristate "Primax non-fully HID-compliant devices"
>         depends on HID
> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> index 6684b30..7080637 100644
> --- a/drivers/hid/Makefile
> +++ b/drivers/hid/Makefile
> @@ -93,6 +93,7 @@ ifdef CONFIG_DEBUG_FS
>  hid-picolcd-y                  += hid-picolcd_debugfs.o
>  endif
> 
> +obj-$(CONFIG_HID_PLANTRONICS)  += hid-plantronics.o
>  obj-$(CONFIG_HID_PRIMAX)       += hid-primax.o
>  obj-$(CONFIG_HID_QUICKSTEP)    += hid-quickstep.o
>  obj-$(CONFIG_HID_ROCCAT)       += hid-roccat.o hid-roccat-common.o \
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 7fd93c3..1c8ede1 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -703,6 +703,8 @@
>  #define USB_DEVICE_ID_ORTEK_PKB1700    0x1700
>  #define USB_DEVICE_ID_ORTEK_WKB2000    0x2000
> 
> +#define USB_VENDOR_ID_PLANTRONICS      0x047f
> +
>  #define USB_VENDOR_ID_PANASONIC                0x04da
>  #define USB_DEVICE_ID_PANABOARD_UBT780 0x1044
>  #define USB_DEVICE_ID_PANABOARD_UBT880 0x104d
> diff --git a/drivers/hid/hid-plantronics.c b/drivers/hid/hid-plantronics.c
> new file mode 100644
> index 0000000..c43440a
> --- /dev/null
> +++ b/drivers/hid/hid-plantronics.c
> @@ -0,0 +1,92 @@
> +/*
> + *  Plantronics USB HID Driver
> + *
> + *  Copyright (c) 2014 JD Cole <jd.cole@plantronics.com>
> + *  Copyright (c) 2014 Terry Junge <terry.junge@plantronics.com>
> + */
> +
> +/*
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the Free
> + * Software Foundation; either version 2 of the License, or (at your option)
> + * any later version.
> + */
> +
> +#include "hid-ids.h"
> +
> +#include <linux/hid.h>
> +#include <linux/module.h>
> +
> +static bool plt_debug;
> +module_param_named(debug, plt_debug, bool, 0644);
> +MODULE_PARM_DESC(debug, "enables extra debugging info");

Instead of introducing module-specific option can we simply use
dbg_hid() and rely on hid's 'debug' option to activate debug output?

> +
> +static bool plt_passall;
> +module_param_named(passall, plt_passall, bool, 0644);
> +MODULE_PARM_DESC(passall, "force all usages to be accepted (requires debug=1)");

Can't we simply unload the driver if we want to pass all usages?

Thanks.

> +
> +static int plantronics_input_mapping(struct hid_device *hdev,
> +                                    struct hid_input *hi,
> +                                    struct hid_field *field,
> +                                    struct hid_usage *usage,
> +                                    unsigned long **bit, int *max)
> +{
> +       if ((field->application == HID_CP_CONSUMERCONTROL
> +           && ((usage->hid & HID_USAGE_PAGE) == HID_UP_CONSUMER))
> +           || (plt_debug && plt_passall)) {
> +               if (plt_debug)
> +                       hid_info(hdev, "usage: %08x (appl: %08x) - defaulted\n",
> +                                usage->hid, field->application);
> +               return 0;
> +       }
> +
> +       if (plt_debug)
> +               hid_info(hdev, "usage: %08x (appl: %08x) - ignored\n",
> +                        usage->hid, field->application);
> +
> +       return -1;
> +}
> +
> +static int plantronics_probe(struct hid_device *hdev,
> +                            const struct hid_device_id *id)
> +{
> +       int ret;
> +
> +       if (plt_debug)
> +               hid_info(hdev, "found plantronics device\n");
> +
> +       ret = hid_parse(hdev);
> +       if (ret) {
> +               hid_err(hdev, "parse failed\n");
> +               goto err;
> +       }
> +
> +       ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> +       if (ret) {
> +               hid_err(hdev, "hw start failed\n");
> +               goto err;
> +       }
> +
> +       return 0;
> + err:
> +       return ret;
> +}
> +
> +static const struct hid_device_id plantronics_devices[] = {
> +       { HID_USB_DEVICE(USB_VENDOR_ID_PLANTRONICS, HID_ANY_ID) },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(hid, plantronics_devices);
> +
> +static struct hid_driver plantronics_driver = {
> +       .name = "plantronics",
> +       .id_table = plantronics_devices,
> +       .input_mapping = plantronics_input_mapping,
> +       .probe = plantronics_probe,
> +};
> +module_hid_driver(plantronics_driver);
> +
> +MODULE_AUTHOR("JD Cole <jd.cole@plantronics.com>");
> +MODULE_AUTHOR("Terry Junge <terry.junge@plantronics.com>");
> +MODULE_DESCRIPTION("Plantronics USB HID Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index 10c9be6..2806146 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -230,6 +230,9 @@ struct hid_item {
>  #define HID_DG_BARRELSWITCH    0x000d0044
>  #define HID_DG_ERASER          0x000d0045
>  #define HID_DG_TABLETPICK      0x000d0046
> +
> +#define HID_CP_CONSUMERCONTROL 0x000c0001
> +
>  /*
>   * as of May 20, 2009 the usages below are not yet in the official USB spec
>   * but are being pushed by Microsft as described in their paper "Digitizer
> --
> 1.8.3.2
> 
> From 6564f0972c5d4e9acba9ebbd8d83cd5a1e95f254 Mon Sep 17 00:00:00 2001
> From: JD Cole <jd.cole@plantronics.com>
> Date: Fri, 17 Oct 2014 15:52:40 -0700
> Subject: [PATCH 2/2] Added missing HID Consumer Page identifiers, for
>  completeness.
> 
> Adds CA and NAry usage type identifiers.
> 
> BUG=chromium:417434
> TEST=Tested with multiple Plantronics devices on 'peppy' Acer C720p.
> 
> Change-Id: I7a55880d6082467274b693c48415e9331d9bbd81
> Signed-off-by: JD Cole <jd.cole@plantronics.com>
> ---
>  include/linux/hid.h | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index 2806146..e923f3d 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -232,6 +232,30 @@ struct hid_item {
>  #define HID_DG_TABLETPICK      0x000d0046
> 
>  #define HID_CP_CONSUMERCONTROL 0x000c0001
> +#define HID_CP_NUMERICKEYPAD   0x000c0002
> +#define HID_CP_PROGRAMMABLEBUTTONS     0x000c0003
> +#define HID_CP_MICROPHONE      0x000c0004
> +#define HID_CP_HEADPHONE       0x000c0005
> +#define HID_CP_GRAPHICEQUALIZER        0x000c0006
> +#define HID_CP_FUNCTIONBUTTONS 0x000c0036
> +#define HID_CP_SELECTION       0x000c0080
> +#define HID_CP_MEDIASELECTION  0x000c0087
> +#define HID_CP_SELECTDISC      0x000c00ba
> +#define HID_CP_PLAYBACKSPEED   0x000c00f1
> +#define HID_CP_PROXIMITY       0x000c0109
> +#define HID_CP_SPEAKERSYSTEM   0x000c0160
> +#define HID_CP_CHANNELLEFT     0x000c0161
> +#define HID_CP_CHANNELRIGHT    0x000c0162
> +#define HID_CP_CHANNELCENTER   0x000c0163
> +#define HID_CP_CHANNELFRONT    0x000c0164
> +#define HID_CP_CHANNELCENTERFRONT      0x000c0165
> +#define HID_CP_CHANNELSIDE     0x000c0166
> +#define HID_CP_CHANNELSURROUND 0x000c0167
> +#define HID_CP_CHANNELLOWFREQUENCYENHANCEMENT  0x000c0168
> +#define HID_CP_CHANNELTOP      0x000c0169
> +#define HID_CP_CHANNELUNKNOWN  0x000c016a
> +#define HID_CP_APPLICATIONLAUNCHBUTTONS        0x000c0180
> +#define HID_CP_GENERICGUIAPPLICATIONCONTROLS   0x000c0200
> 
>  /*
>   * as of May 20, 2009 the usages below are not yet in the official USB spec
> --
> 1.8.3.2
> 
> 
> 
> ________________________________
> 
> CONFIDENTIALITY NOTICE: This e-mail transmission, and any documents, files or previous e-mail messages attached to it, may contain information that is confidential and/or legally privileged. If you are not the intended recipient, or a person responsible for delivering it to the intended recipient, please DO NOT disclose the contents to another person, store or copy the information in any medium, or use any of the information contained in or attached to this transmission for any purpose. If you have received this transmission in error, please immediately notify the sender by reply email or at privacy@plantronics.com, and destroy the original transmission and its attachments without reading or saving in any manner.
> 
> For further information about Plantronics - the Company, its products, brands, partners, please visit our website www.plantronics.com.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Dmitry

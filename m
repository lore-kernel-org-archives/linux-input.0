From: "Junge, Terry" <Terry.Junge@plantronics.com>
Subject: RE: [PATCH] HID: hid-plantronics: Update to map volume up/down
 controls
Date: Fri, 8 May 2015 00:16:47 +0000
Message-ID: <539921aa7dd24d3c801f8d0bfb9ef438@usscmb04.plt.plantronics.com>
References: <1428779862-31930-1-git-send-email-terry.junge@plantronics.com>
 <alpine.LNX.2.00.1504231017320.3695@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail3.plantronics.com ([198.231.10.49]:34600 "EHLO
	mail3.plantronics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995AbbEHARD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 May 2015 20:17:03 -0400
In-Reply-To: <alpine.LNX.2.00.1504231017320.3695@pobox.suse.cz>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Jiri,
Thanks for the review. Sorry for the late response. Please see below:

> -----Original Message-----
> From: Jiri Kosina [mailto:jkosina@suse.cz]
> Sent: Thursday, April 23, 2015 1:22 AM
> To: Junge, Terry
> Cc: linux-input@vger.kernel.org
> Subject: Re: [PATCH] HID: hid-plantronics: Update to map volume up/down
> controls
>
> On Sat, 11 Apr 2015, Terry Junge wrote:
>
> > Update hid-plantronics.c to identify device type and correctly map
> > either the vendor unique or consumer control volume up/down usages
> > to KEY_VOLUMEUP and KEY_VOLUMEDOWN events.
> >
> > Update Kconfig with enhanced help text for hid-plantronics driver
> > and changed default value from !EXPERT to m. This driver prevents
> > hid-input from mapping unknown vendor unique usages to mouse events
> > so it is preferred that it be available, expert or not.
> >
> > Signed-off-by: Terry Junge <terry.junge@plantronics.com>
> > ---
> >  drivers/hid/Kconfig           |   7 +-
> >  drivers/hid/hid-plantronics.c | 152
> +++++++++++++++++++++++++++++++++++++++---
> >  2 files changed, 149 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> > index 152b006..69aac6b 100644
> > --- a/drivers/hid/Kconfig
> > +++ b/drivers/hid/Kconfig
> > @@ -638,10 +638,13 @@ config HID_PICOLCD_CIR
> >
> >  config HID_PLANTRONICS
> >         tristate "Plantronics USB HID Driver"
> > -       default !EXPERT
>
> The '!EXPERT' stuff is gone in current Linus' tree (see commit
> 7af05e73cd).

I see that, good; is there any issue with setting default to 'm'?

>
> > +       default m
> >         depends on HID
> >         ---help---
> > -       Provides HID support for Plantronics telephony devices.
> > +       Provides HID support for Plantronics USB audio devices.
> > +       Correctly maps vendor unique volume up/down HID usages to
> > +       KEY_VOLUMEUP and KEY_VOLUMEDOWN events and prevents core
> mapping
> > +       of other vendor unique HID usages to random mouse events.
> >
> >  config HID_PRIMAX
> >         tristate "Primax non-fully HID-compliant devices"
> > diff --git a/drivers/hid/hid-plantronics.c b/drivers/hid/hid-plantronics.c
> > index 2180e07..c4756a1 100644
> > --- a/drivers/hid/hid-plantronics.c
> > +++ b/drivers/hid/hid-plantronics.c
> > @@ -2,7 +2,7 @@
> >   *  Plantronics USB HID Driver
> >   *
> >   *  Copyright (c) 2014 JD Cole <jd.cole@plantronics.com>
> > - *  Copyright (c) 2014 Terry Junge <terry.junge@plantronics.com>
> > + *  Copyright (c) 2015 Terry Junge <terry.junge@plantronics.com>
> >   */
> >
> >  /*
> > @@ -14,26 +14,161 @@
> >
> >  #include "hid-ids.h"
> >
> > +#include <linux/usb.h>
> >  #include <linux/hid.h>
> >  #include <linux/module.h>
> >
> > +#define PLT_HID_1_0_PAGE       0xffa00000
> > +#define PLT_HID_2_0_PAGE       0xffa20000
> > +
> > +#define PLT_BASIC_TELEPHONY    0x0003
> > +#define PLT_BASIC_EXCEPTION    0x0005
> > +
> > +#define PLT_VOL_UP             0x00b1
> > +#define PLT_VOL_DOWN           0x00b2
> > +
> > +#define PLT1_VOL_UP            (PLT_HID_1_0_PAGE | PLT_VOL_UP)
> > +#define PLT1_VOL_DOWN          (PLT_HID_1_0_PAGE | PLT_VOL_DOWN)
> > +#define PLT2_VOL_UP            (PLT_HID_2_0_PAGE | PLT_VOL_UP)
> > +#define PLT2_VOL_DOWN          (PLT_HID_2_0_PAGE | PLT_VOL_DOWN)
> > +
> > +#define PLT_DA60               0xda60
> > +
> > +#define PLT_ALLOW_CONSUMER (field->application ==
> HID_CP_CONSUMERCONTROL && \
> > +                           (usage->hid & HID_USAGE_PAGE) == HID_UP_CONSUMER)
> > +
> >  static int plantronics_input_mapping(struct hid_device *hdev,
> >                                      struct hid_input *hi,
> >                                      struct hid_field *field,
> >                                      struct hid_usage *usage,
> >                                      unsigned long **bit, int *max)
> >  {
> > -       if (field->application == HID_CP_CONSUMERCONTROL
> > -           && (usage->hid & HID_USAGE_PAGE) == HID_UP_CONSUMER) {
> > -               hid_dbg(hdev, "usage: %08x (appl: %08x) - defaulted\n",
> > -                        usage->hid, field->application);
> > -               return 0;
> > +       unsigned short mapped_key;
> > +       unsigned long plt_type = (unsigned long)hid_get_drvdata(hdev);
> > +
> > +       /* handle volume up/down mapping */
> > +       /* non-standard types or multi-HID interfaces - plt_type is PID */
> > +       if (!(plt_type & HID_USAGE_PAGE)) {
> > +               switch (plt_type) {
> > +               case PLT_DA60:
> > +                       if (PLT_ALLOW_CONSUMER)
> > +                               goto defaulted;
> > +                       goto ignored;
> > +               default:
> > +                       if (PLT_ALLOW_CONSUMER)
> > +                               goto defaulted;
> > +               }
> > +       }
> > +       /* handle standard types - plt_type is 0xffa0uuuu or 0xffa2uuuu */
> > +       /* 'basic telephony compliant' - allow default consumer page map */
> > +       else if ((plt_type & HID_USAGE) >= PLT_BASIC_TELEPHONY &&
> > +                (plt_type & HID_USAGE) != PLT_BASIC_EXCEPTION) {
> > +               if (PLT_ALLOW_CONSUMER)
> > +                       goto defaulted;
> > +       }
> > +       /* not 'basic telephony' - apply legacy mapping */
> > +       /* only map if the field is in the device's primary vendor page */
> > +       else if (!((field->application ^ plt_type) & HID_USAGE_PAGE)) {
> > +               switch (usage->hid) {
> > +               case PLT1_VOL_UP:
> > +               case PLT2_VOL_UP:
> > +                       mapped_key = KEY_VOLUMEUP;
> > +                       goto mapped;
> > +               case PLT1_VOL_DOWN:
> > +               case PLT2_VOL_DOWN:
> > +                       mapped_key = KEY_VOLUMEDOWN;
> > +                       goto mapped;
> > +               }
> >         }
> >
> > -       hid_dbg(hdev, "usage: %08x (appl: %08x) - ignored\n",
> > -               usage->hid, field->application);
> > +/*
> > + * Future mapping of call control or other usages,
> > + * if and when keys are defined would go here
> > + * otherwise, ignore everything else that was not mapped
> > + */
> >
> > +ignored:
> >         return -1;
> > +
> > +defaulted:
> > +       hid_dbg(hdev, "usage: %08x (appl: %08x) - defaulted\n",
> > +               usage->hid, field->application);
> > +       return 0;
> > +
> > +mapped:
> > +       hid_map_usage_clear(hi, usage, bit, max, EV_KEY, mapped_key);
> > +       hid_dbg(hdev, "usage: %08x (appl: %08x) - mapped to key %d\n",
> > +               usage->hid, field->application, mapped_key);
> > +       return 1;
> > +}
> > +
> > +static int plantronics_hid_interface_count(struct hid_device *hdev)
> > +{
> > +       int i, count;
> > +       struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
> > +       struct usb_device *udev = interface_to_usbdev(intf);
> > +       struct usb_host_config *config = udev->actconfig;
>
> You are now introducing USB-isms into a HID driver.
>
> Is it really necessary? The changelog is rather sparse about the reason
> why you are counting the USB interfaces and make decisions based on it.
> Could you please be more verbose there?
>

The intent of this driver was to be able to identify Plantronics devices
by their HID collection characteristics as opposed to an ever growing
PID list. There is one group of devices that have multiple HID interfaces
so counting sibling HID interfaces is a method to identify them and
force all the interfaces to be processed and mapped.

However, I can see that pulling USB-isms into a HID driver may be
setting a bad precedent. I have created and tested an alternate patch
that uses PIDs to identify the current devices with multiple HID interfaces.
This eliminates the interface counting but would require an update if we
ever shipped another device with multiple HID interfaces (I hope not).

I'm good either way. We can kill this patch and I can submit a v2 patch
that eliminates the USB-isms. Or just add in the USB dependency and
go with this one. What's your preference?

> Also, as you as now using USB-isms in the driver, you have to make it
> dependent on USB availability.
>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs

Thanks again for your time and review,
Terry Junge
Plantronics


________________________________

CONFIDENTIALITY NOTICE: This e-mail transmission, and any documents, files or previous e-mail messages attached to it, may contain information that is confidential and/or legally privileged. If you are not the intended recipient, or a person responsible for delivering it to the intended recipient, please DO NOT disclose the contents to another person, store or copy the information in any medium, or use any of the information contained in or attached to this transmission for any purpose. If you have received this transmission in error, please immediately notify the sender by reply email or at privacy@plantronics.com, and destroy the original transmission and its attachments without reading or saving in any manner.

For further information about Plantronics - the Company, its products, brands, partners, please visit our website www.plantronics.com.

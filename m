From: Niels Skou Olsen <nolsen@jabra.com>
Subject: RE: [PATCH] HID: Add special driver for Jabra devices
Date: Fri, 8 Sep 2017 12:58:57 +0000
Message-ID: <VI1PR0701MB2991CB81F8DC7A0143A6E232DA950@VI1PR0701MB2991.eurprd07.prod.outlook.com>
References: <1504269832-23142-1-git-send-email-nolsen@jabra.com>
 <nycvar.YFH.7.76.1709081408220.3285@jbgna.fhfr.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-eopbgr40063.outbound.protection.outlook.com ([40.107.4.63]:51712
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755787AbdIHM7B (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 8 Sep 2017 08:59:01 -0400
In-Reply-To: <nycvar.YFH.7.76.1709081408220.3285@jbgna.fhfr.qr>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>

On Fri, 8 Sep 2017, jikos@kernel.org write:

> On Fri, 1 Sep 2017, nolsen@jabra.com wrote:
>
> > From: Niels Skou Olsen <nolsen@jabra.com>
> >
> > Add a hid-jabra driver to the list of special drivers in hid-core. The
> > driver prevents vendor defined HID usages (FF00-FFFF) in Jabra devices
> > from being mapped to input events that become unintended mouse events
> > in the X11 server.
> >
> > Signed-off-by: Niels Skou Olsen <nolsen@jabra.com>
> > ---
> >  drivers/hid/Kconfig     | 11 ++++++++++
> >  drivers/hid/Makefile    |  1 +
> >  drivers/hid/hid-core.c  |  3 +++
> >  drivers/hid/hid-jabra.c | 58
> > +++++++++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 73 insertions(+)
> >  create mode 100644 drivers/hid/hid-jabra.c
> >
> > diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig index
> > 0a3117c..d9d2843 100644
> > --- a/drivers/hid/Kconfig
> > +++ b/drivers/hid/Kconfig
> > @@ -395,6 +395,17 @@ config HID_ITE
> >  ---help---
> >  Support for ITE devices not fully compliant with HID standard.
> >
> > +config HID_JABRA
> > +tristate "Jabra USB HID Driver"
> > +depends on HID
> > +---help---
> > +Support for Jabra USB HID devices.
> > +
> > +Prevents mapping of vendor defined HID usages to input events.
> Without
> > +this driver HIDreports from Jabra devices may incorrectly be seen as
> > +mouse button events.
> > +Say M here if you may ever plug in a Jabra USB device.
> > +
> >  config HID_TWINHAN
> >  tristate "Twinhan IR remote control"
> >  depends on HID
> > diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile index
> > 8659d7e..d2563e5 100644
> > --- a/drivers/hid/Makefile
> > +++ b/drivers/hid/Makefile
> > @@ -51,6 +51,7 @@ obj-$(CONFIG_HID_HOLTEK)+=3D hid-holtekff.o
> >  obj-$(CONFIG_HID_HYPERV_MOUSE)+=3D hid-hyperv.o
> >  obj-$(CONFIG_HID_ICADE)+=3D hid-icade.o
> >  obj-$(CONFIG_HID_ITE)+=3D hid-ite.o
> > +obj-$(CONFIG_HID_JABRA)+=3D hid-jabra.o
> >  obj-$(CONFIG_HID_KENSINGTON)+=3D hid-kensington.o
> >  obj-$(CONFIG_HID_KEYTOUCH)+=3D hid-keytouch.o
> >  obj-$(CONFIG_HID_KYE)+=3D hid-kye.o
> > diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c index
> > 9bc9116..0603012 100644
> > --- a/drivers/hid/hid-core.c
> > +++ b/drivers/hid/hid-core.c
> > @@ -2077,6 +2077,9 @@ static const struct hid_device_id
> > hid_have_special_driver[] =3D {  #if IS_ENABLED(CONFIG_HID_ITE)
> >  { HID_USB_DEVICE(USB_VENDOR_ID_ITE,
> USB_DEVICE_ID_ITE8595) },
> > #endif
> > +#if IS_ENABLED(CONFIG_HID_JABRA)
> > +{ HID_USB_DEVICE(USB_VENDOR_ID_JABRA, HID_ANY_ID) },
> #endif
> >  #if IS_ENABLED(CONFIG_HID_KENSINGTON)
> >  { HID_USB_DEVICE(USB_VENDOR_ID_KENSINGTON,
> > USB_DEVICE_ID_KS_SLIMBLADE) },  #endif diff --git
> > a/drivers/hid/hid-jabra.c b/drivers/hid/hid-jabra.c new file mode
> > 100644 index 0000000..1f52daf
> > --- /dev/null
> > +++ b/drivers/hid/hid-jabra.c
> > @@ -0,0 +1,58 @@
> > +/*
> > + *  Jabra USB HID Driver
> > + *
> > + *  Copyright (c) 2017 Niels Skou Olsen <nolsen@jabra.com>  */
> > +
> > +/*
> > + * This program is free software; you can redistribute it and/or
> > +modify it
> > + * under the terms of the GNU General Public License as published by
> > +the Free
> > + * Software Foundation; either version 2 of the License, or (at your
> > +option)
> > + * any later version.
> > + */
> > +
> > +#include <linux/hid.h>
> > +#include <linux/module.h>
> > +
> > +#include "hid-ids.h"
> > +
> > +#define HID_UP_VENDOR_DEFINED_MIN0xff000000
> > +#define HID_UP_VENDOR_DEFINED_MAX0xffff0000
> > +
> > +static int jabra_input_mapping(struct hid_device *hdev,
> > +       struct hid_input *hi,
> > +       struct hid_field *field,
> > +       struct hid_usage *usage,
> > +       unsigned long **bit, int *max) {
> > +int is_vendor_defined =3D
> > +((usage->hid & HID_USAGE_PAGE) >=3D
> HID_UP_VENDOR_DEFINED_MIN &&
> > + (usage->hid & HID_USAGE_PAGE) <=3D
> HID_UP_VENDOR_DEFINED_MAX);
> > +
> > +dbg_hid("hid=3D0x%08x appl=3D0x%08x coll_idx=3D0x%02x
> usage_idx=3D0x%02x: %s\n",
> > +usage->hid,
> > +field->application,
> > +usage->collection_index,
> > +usage->usage_index,
> > +is_vendor_defined ? "ignored" : "defaulted");
> > +
> > +/* Ignore vendor defined usages, default map standard usages */
> > +return is_vendor_defined ? -1 : 0;
> > +}
> > +
> > +static const struct hid_device_id jabra_devices[] =3D {
> > +{ HID_USB_DEVICE(USB_VENDOR_ID_JABRA, HID_ANY_ID) },
>
> You also need to update hid-core so that generic driver doesn't bind to t=
hose device.
> See hid_have_special_driver[] in drivers/hid/hid-core.c

The original patch already has a hunk that patches hid_have_special_driver[=
] -- did you miss it, or do I need to do something else also?

Thanks,
Niels
**** GN GROUP NOTICE - AUTOMATICALLY INSERTED**** The information in this e=
-mail (including attachments, if any) is considered confidential and is int=
ended only for the recipient(s) listed above. Any review, use, disclosure, =
distribution or copying of this e-mail is prohibited except by or on behalf=
 of the intended recipient. If you have received this email in error, pleas=
e notify me immediately by reply e-mail, delete this e-mail, and do not dis=
close its contents to anyone. Any opinions expressed in this e-mail are tho=
se of the individual and not necessarily the GN group. Thank you. *********=
*********** DISCLAIMER END ************************

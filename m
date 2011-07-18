From: Nestor Lopez Casado <nlopezcasad@logitech.com>
Subject: Re: [PATCH 1/1] HID: Add full support for logitech Unifying receivers
Date: Mon, 18 Jul 2011 12:59:02 +0200
Message-ID: <CAE7qMroWt2p2_i0c7uvug5Z2X9VnsN5=1RaNOgLRbCq_J=J6mA@mail.gmail.com>
References: <1305297084-10224-1-git-send-email-nlopezcasad@logitech.com> <alpine.LNX.2.00.1106241417480.11049@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:34575 "HELO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756420Ab1GRK7d convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Jul 2011 06:59:33 -0400
Received: by mail-pz0-f50.google.com with SMTP id 2so4786889pzk.23
        for <linux-input@vger.kernel.org>; Mon, 18 Jul 2011 03:59:32 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1106241417480.11049@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, xnlopez@gmail.com, rtitmuss@logitech.com, ogay@logitech.com

Hi everyone, please find my comments Jiri's remarks below:

Thanks,
Nestor

On Fri, Jun 24, 2011 at 2:27 PM, Jiri Kosina <jkosina@suse.cz> wrote:
>
> On Fri, 13 May 2011, Nestor Lopez Casado wrote:
>
> > Up to now, when Logitech Unifying receivers are connected to a Linu=
x
> > based system, a single keyboard and a single mouse are presented to=
 the
> > HID Layer, even if the Unifying receiver can pair up to six compati=
ble
> > devices. The Unifying receiver by default multiplexes all incoming
> > events (from multiple keyboards/mice) into these two.
>
> Sorry that it took me too long to review the driver.
>
> Generally, I like it. The question I have -- apparently the receiver =
works
> in a crippled mode even without the driver. Therefore, I'd suggest to=
 put
> the hid_have_special_driver[] uncodinitionally, the same way we do fo=
r
> other devices.
>

The receiver does work in a simpler "crippled" mode where all input
from all paired devices are multiplexed through a single keyboard
interface and a single mouse interface. All Linux based systems
already support Unifying devices via the standard hid driver. This
will suffice for most users. The added functionality that this driver
provides goes to users that would like to differentiate input coming
from different input devices paired to the same Unifying receiver.
(Some use cases: Gaming on the same PC with two input devices, more
than one keyboard w/ different layouts, applying different ballistics
to different cursor control devices, etc)

I understand the inappropriateness of the conditionals on the specific
hid driver table, but removing them would mean that users that have
not selected the Unifying driver on their kernel configuration would
lose an otherwise perfectly functioning set of devices which are meant
to work out of the box without any special driver. For this reason I
suggest that we leave the conditionals.

> Apart from the, the driver looks good to me. Please find a few rather
> minor comments below.
>
> > +config HID_LOGITECH_DJ
> > + =A0 =A0 tristate "Logitech Unifying receivers full support"
> > + =A0 =A0 depends on USB_HID
>
> We already have sub-menu for Logitech devices. I think this driver sh=
ould
> be in that sub-menu, even if it doesn't directly depend on hid-logite=
ch.
>

That's OK. It is already corrected for the next patch.

> > --- a/drivers/hid/Makefile
> > +++ b/drivers/hid/Makefile
> > @@ -44,6 +44,7 @@ obj-$(CONFIG_HID_KEYTOUCH) =A0+=3D hid-keytouch.o
> > =A0obj-$(CONFIG_HID_KYE) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D hid-ky=
e.o
> > =A0obj-$(CONFIG_HID_LCPOWER) =A0 =A0 =A0 +=3D hid-lcpower.o
> > =A0obj-$(CONFIG_HID_LOGITECH) =A0 +=3D hid-logitech.o
> > +obj-$(CONFIG_HID_LOGITECH_DJ) =A0 =A0 =A0 =A0+=3D hid-logitech-dj.=
o
> > =A0obj-$(CONFIG_HID_MAGICMOUSE) =A0 =A0+=3D hid-magicmouse.o
> > =A0obj-$(CONFIG_HID_MICROSOFT) =A0+=3D hid-microsoft.o
> > =A0obj-$(CONFIG_HID_MONTEREY) =A0 +=3D hid-monterey.o
> > @@ -78,6 +79,7 @@ obj-$(CONFIG_HID_ZYDACRON) =A0+=3D hid-zydacron.o
> > =A0obj-$(CONFIG_HID_WACOM) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D hid-waco=
m.o
> > =A0obj-$(CONFIG_HID_WALTOP) =A0 =A0 +=3D hid-waltop.o
> >
> > +
> > =A0obj-$(CONFIG_USB_HID) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D usbhid=
/
> > =A0obj-$(CONFIG_USB_MOUSE) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D usbhid/
> > =A0obj-$(CONFIG_USB_KBD) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D usbhid=
/
>
> Why the added new line?
>

Did not see it. It is already corrected for the next patch.

> > diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> > index 408c4be..2855403 100644
> > --- a/drivers/hid/hid-core.c
> > +++ b/drivers/hid/hid-core.c
> > @@ -1253,6 +1253,9 @@ int hid_connect(struct hid_device *hdev, unsi=
gned int connect_mask)
> > =A0 =A0 =A0 case BUS_BLUETOOTH:
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus =3D "BLUETOOTH";
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> > + =A0 =A0 case BUS_DJ:
> > + =A0 =A0 =A0 =A0 =A0 =A0 bus =3D "UNIFYING";
> > + =A0 =A0 =A0 =A0 =A0 =A0 break;
>
> Why do we need separate bus? It's always USB, right?

The reason we need a new bus type is because we are creating a set of
new hid devices which are not physically connected to the USB. And
they don't have a USB VID/PID. They only have a Unifying (a.k.a. DJ)
product ID known as Unifying device ID.

I am afraid that mixing things up now (even if it may work for the
moment) can create some undesired couplings in the future. See that
hid-logitech-dj registers a generic hid driver for Unifying devices.
What if at one point we need to have specific DJ drivers por specific
DJ devices that do not fit in the current HID implementation/standard?

On top of that I don't see harm in leaving the extra bus type.

>
> > =A0 =A0 =A0 default:
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus =3D "<UNKNOWN>";
> > =A0 =A0 =A0 }
> > @@ -1485,8 +1488,11 @@ static const struct hid_device_id hid_have_s=
pecial_driver[] =3D {
> > =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_ZEROPLUS, 0x0005) },
> > =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_ZEROPLUS, 0x0030) },
> > =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_ZYDACRON, USB_DEVICE_ID_=
ZYDACRON_REMOTE_CONTROL) },
> > -
> > =A0 =A0 =A0 { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEV=
ICE_ID_MS_PRESENTER_8K_BT) },
> > +#if defined(CONFIG_HID_LOGITECH_DJ) || defined(CONFIG_HID_LOGITECH=
_DJ_MODULE)
> > + =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xc52b) },
> > + =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xc532) },
> > +#endif
>
> See above.
>
> > +static void logi_dj_recv_destroy_djhid_device(struct dj_receiver_d=
ev *djrcv_dev,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 struct dj_report *dj_report)
> > +{
> > + =A0 =A0 /* Called in delayed work context */
> > + =A0 =A0 struct dj_device *dj_dev;
> > + =A0 =A0 unsigned long flags;
> > +
> > + =A0 =A0 spin_lock_irqsave(&djrcv_dev->lock, flags);
> > + =A0 =A0 dj_dev =3D djrcv_dev->paired_dj_devices[dj_report->device=
_index];
> > + =A0 =A0 djrcv_dev->paired_dj_devices[dj_report->device_index] =3D=
 NULL;
> > + =A0 =A0 spin_unlock_irqrestore(&djrcv_dev->lock, flags);
> > +
> > + =A0 =A0 if (dj_dev !=3D NULL) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 hid_destroy_device(dj_dev->hdev);
> > + =A0 =A0 =A0 =A0 =A0 =A0 kfree(dj_dev);
> > + =A0 =A0 } else {
> > + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&djrcv_dev->hdev->dev, "logi_dj_r=
ecv_destroy_djhid_device"
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 ":cant destroy a NULL device\n");
>
> The error message looks odd (cant is spelled wrong way, and directly
> attached to ':').

Did not see it. It is already corrected for the next patch.

>
> > --- /dev/null
> > +++ b/drivers/hid/hid-logitech-dj.h
> > @@ -0,0 +1,117 @@
> > +#ifndef __HID_LOGITECH_DJ_H
> > +#define __HID_LOGITECH_DJ_H
> > +
> > +/*
> > + * =A0HID driver for Logitech Unifying receivers
> > + *
> > + * =A0Copyright (c) 2011 Logitech (c)
> > + */
> > +
> > +/*
> > + * This program is free software; you can redistribute it and/or m=
odify
> > + * it under the terms of the GNU General Public License as publish=
ed by
> > + * the Free Software Foundation; either version 2 of the License, =
or
> > + * (at your option) any later version.
>
> BTW, are you sure about the "any later version" part?
>
> Thanks,
>

Very good point. It is already corrected for the next patch.

> --
> Jiri Kosina
> SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

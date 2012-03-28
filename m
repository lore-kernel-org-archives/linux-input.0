From: Nicolas Pouillon <npouillon@freebox.fr>
Subject: Re: [RFC v2 1/1] HID: User-space I/O driver support for HID
 subsystem
Date: Wed, 28 Mar 2012 13:15:29 +0200 (CEST)
Message-ID: <2052749237.3448849.1332933329806.JavaMail.root@zmc>
References: <CANq1E4TnjzNG4sT_qt5qmrYMHp39HAJUcG1D4w=kcWoBkrThqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from zmc.proxad.net ([212.27.53.206]:54336 "EHLO zmc.proxad.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758225Ab2C1LPb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Mar 2012 07:15:31 -0400
In-Reply-To: <CANq1E4TnjzNG4sT_qt5qmrYMHp39HAJUcG1D4w=kcWoBkrThqA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, chen ganir <chen.ganir@ti.com>, claudio takahasi <claudio.takahasi@openbossa.org>, jprvita@openbossa.org, linux-bluetooth@vger.kernel.org, anderson lizardo <anderson.lizardo@openbossa.org>, Marcel Holtmann <marcel@holtmann.org>

David,

----- Original Message -----

> >> + =C2=A0 =C2=A0 strncpy(hid->name, ev->u.create.name, 128);
> >> + =C2=A0 =C2=A0 hid->name[127] =3D 0;
> >> + =C2=A0 =C2=A0 hid->ll_driver =3D &uhid_hid_driver;
> >> + =C2=A0 =C2=A0 hid->hid_get_raw_report =3D uhid_hid_get_raw;
> >> + =C2=A0 =C2=A0 hid->hid_output_raw_report =3D uhid_hid_output_raw=
;
> >> + =C2=A0 =C2=A0 hid->bus =3D ev->u.create.bus;
> >> + =C2=A0 =C2=A0 hid->vendor =3D ev->u.create.vendor;
> >> + =C2=A0 =C2=A0 hid->product =3D ev->u.create.product;
> >> + =C2=A0 =C2=A0 hid->version =3D ev->u.create.version;
> >> + =C2=A0 =C2=A0 hid->country =3D ev->u.create.country;
> >> + =C2=A0 =C2=A0 hid->phys[0] =3D 0;
> >> + =C2=A0 =C2=A0 hid->uniq[0] =3D 0;
> >> + =C2=A0 =C2=A0 hid->driver_data =3D uhid;
> >> + =C2=A0 =C2=A0 hid->dev.parent =3D uhid->parent;
> >
> > Here we have to make sure that we have all required information pro=
vided
> > by userspace. Anything else that HID might require to work better. =
Or
> > that BR/EDR or LE provides additionally over USB.
>=20
> Beside phys and uniq I have copied all information that HIDP and
> USBHID use. I haven't found any other field that could be of interest
> here. We can also always add UHID_CREATE2 with additional fields to
> allow further additions (or use a "size" field as you suggested
> below).

HID report descriptor may reference Physical Descriptor (HID 6.2.3) and
String Descriptor entries (USB 9.6.8, HID E.11).  Physical Descriptor
blob could be another __user buffer + size in uhid_create_req.  String
descriptor should probably be an event for querying strings.

hidraw interface also offers access to Feature Reports, adding events
to send/receive and query (kernel querying uhid client) feature reports
could be of some interest.

Cheers,
--=20
Nicolas Pouillon
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

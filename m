From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: [RFC v2 1/1] HID: User-space I/O driver support for HID subsystem
Date: Thu, 29 Mar 2012 14:28:01 +0200
Message-ID: <CANq1E4Qy4aF1PJdyF2wWVH7bDGypy1roHvVmyhRUV8CNd4_NrA@mail.gmail.com>
References: <CANq1E4TnjzNG4sT_qt5qmrYMHp39HAJUcG1D4w=kcWoBkrThqA@mail.gmail.com>
	<2052749237.3448849.1332933329806.JavaMail.root@zmc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:32979 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759206Ab2C2M2D convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Mar 2012 08:28:03 -0400
In-Reply-To: <2052749237.3448849.1332933329806.JavaMail.root@zmc>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nicolas Pouillon <npouillon@freebox.fr>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, chen ganir <chen.ganir@ti.com>, claudio takahasi <claudio.takahasi@openbossa.org>, jprvita@openbossa.org, linux-bluetooth@vger.kernel.org, anderson lizardo <anderson.lizardo@openbossa.org>, Marcel Holtmann <marcel@holtmann.org>

Hi Nicolas

On Wed, Mar 28, 2012 at 1:15 PM, Nicolas Pouillon <npouillon@freebox.fr=
> wrote:
> David,
>
> ----- Original Message -----
>
>> >> + =A0 =A0 strncpy(hid->name, ev->u.create.name, 128);
>> >> + =A0 =A0 hid->name[127] =3D 0;
>> >> + =A0 =A0 hid->ll_driver =3D &uhid_hid_driver;
>> >> + =A0 =A0 hid->hid_get_raw_report =3D uhid_hid_get_raw;
>> >> + =A0 =A0 hid->hid_output_raw_report =3D uhid_hid_output_raw;
>> >> + =A0 =A0 hid->bus =3D ev->u.create.bus;
>> >> + =A0 =A0 hid->vendor =3D ev->u.create.vendor;
>> >> + =A0 =A0 hid->product =3D ev->u.create.product;
>> >> + =A0 =A0 hid->version =3D ev->u.create.version;
>> >> + =A0 =A0 hid->country =3D ev->u.create.country;
>> >> + =A0 =A0 hid->phys[0] =3D 0;
>> >> + =A0 =A0 hid->uniq[0] =3D 0;
>> >> + =A0 =A0 hid->driver_data =3D uhid;
>> >> + =A0 =A0 hid->dev.parent =3D uhid->parent;
>> >
>> > Here we have to make sure that we have all required information pr=
ovided
>> > by userspace. Anything else that HID might require to work better.=
 Or
>> > that BR/EDR or LE provides additionally over USB.
>>
>> Beside phys and uniq I have copied all information that HIDP and
>> USBHID use. I haven't found any other field that could be of interes=
t
>> here. We can also always add UHID_CREATE2 with additional fields to
>> allow further additions (or use a "size" field as you suggested
>> below).
>
> HID report descriptor may reference Physical Descriptor (HID 6.2.3) a=
nd
> String Descriptor entries (USB 9.6.8, HID E.11). =A0Physical Descript=
or
> blob could be another __user buffer + size in uhid_create_req. =A0Str=
ing
> descriptor should probably be an event for querying strings.

I haven't seen that hid-core uses them? I pass the report-descriptor
to hid_parse_report() and I don't see a way to pass in the phys-desc
or string-descriptors. Neither USBHID nor HIDP uses them or am I
missing something here?
Anyway, we can always add them with a UHID_CREATE_EXT or similar
command later if hid-core adds support for them.

> hidraw interface also offers access to Feature Reports, adding events
> to send/receive and query (kernel querying uhid client) feature repor=
ts
> could be of some interest.

Yeah, I haven't implemented this (yet) and I return -EOPNOTSUPP.
However, it's on my TODO list. Thanks!

> Cheers,
> --
> Nicolas Pouillon

Thanks
David
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

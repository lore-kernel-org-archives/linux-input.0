From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: ALPS v7 trackpad passthrough to Thinkpad trackpoint
Date: Thu, 13 Aug 2015 17:18:33 -0700
Message-ID: <20150814001833.GD15693@dtor-ws>
References: <CANULwrQyVOhorRXb-+m=V-SZofn9dM3QJBU-xi=yFFOhq4t_2w@mail.gmail.com>
 <20150807132639.GB21627@pali>
 <CANULwrSnV=JvbUzkq2PCnpyWw3H9gFE1Z+HB-ntBZteF=AUE9g@mail.gmail.com>
 <20150807141214.GD21627@pali>
 <CANULwrTm0XEdKfC7Shx5VLpvHmkzRt5mOUjbFSm8ck86Ci=iKQ@mail.gmail.com>
 <20150813110317.GC20040@pali>
 <20150813224839.GC15693@dtor-ws>
 <17D6F4B6F11B44BBB1A2C8EB95A9CF84@cirque.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35336 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932067AbbHNASh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Aug 2015 20:18:37 -0400
Received: by pacgr6 with SMTP id gr6so47563665pac.2
        for <linux-input@vger.kernel.org>; Thu, 13 Aug 2015 17:18:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <17D6F4B6F11B44BBB1A2C8EB95A9CF84@cirque.local>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vadim Klishko <vadim@cirque.com>
Cc: Pali =?utf-8?B?Um9o77+9cg==?= <pali.rohar@gmail.com>, Ari Entlich <atrigent@gmail.com>, linux-input@vger.kernel.org, Masaki Ota <012nexus@gmail.com>, Tommy Will <tommywill2011@gmail.com>, Yunkang Tang <yunkang.tang@cn.alps.com>, Qiting Chen <qiting.chen@cn.alps.com>, Qiting Chen <elaineee66@gmail.com>

Hi Vadim,

On Thu, Aug 13, 2015 at 06:11:22PM -0600, Vadim Klishko wrote:
> I am not sure I understand what details you are looking for, but as
> far as I know, the only way a command sent to an Alps device from the
> host could reach the trackstick is when the touchpad chip is in
> pass-thru mode.

We are looking for information on how to detect whether a device
supports pass-through mode and how to activate it. IOW we are looking
for the protocol specs for the PS/2 flavor used by ALPS devices. So far
we had to deduce many of the details itself and it would be great if
manufacturer would share the information with us sol that we could
improve support for the devices in Linux kernel.

Thanks.

>=20
>=20
> ----- Original Message -----=20
> From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
> To: "Pali Roh=E1r" <pali.rohar@gmail.com>
> Cc: "Ari Entlich" <atrigent@gmail.com>; <linux-input@vger.kernel.org>=
; "Masaki Ota" <012nexus@gmail.com>; "Tommy Will" <tommywill2011@gmail.=
com>; "Yunkang Tang" <yunkang.tang@cn.alps.com>; "Qiting Chen" <qiting.=
chen@cn.alps.com>; "Qiting Chen" <elaineee66@gmail.com>; <vadim@cirque.=
com>
> Sent: Thursday, August 13, 2015 4:48 PM
> Subject: Re: ALPS v7 trackpad passthrough to Thinkpad trackpoint
>=20
>=20
> > On Thu, Aug 13, 2015 at 01:03:17PM +0200, Pali Roh=E1r wrote:
> >> On Friday 07 August 2015 12:35:33 Ari Entlich wrote:
> >> > On Fri, Aug 7, 2015 at 10:12 AM, Pali Roh=E1r <pali.rohar@gmail.=
com> wrote:
> >> > > For some old ALPS devices which use V1 and V2 protocols (with =
flag
> >> > > ALPS_PASS) there is something like that. On that devices touch=
pad is
> >> > > behind trackpoint HW. But you cannot wait for data or poll for=
 both
> >> > > devices at same time -- you need to choose if tou want to talk=
 directly
> >> > > to touchpad (via passthrough mode) or just to trackpoint. I th=
ink
> >> > > because of this limitation ALPS driver implement all logic in =
one
> >> > > driver...
> >> > >
> >> > > Above was for old ALPS devices. New ALPS devices with V3 or V5=
 protocols
> >> > > have trackpoint behind touchpad, so normally OS communicate wi=
th
> >> > > touchpad (and not with trackstick like before). But here touch=
pad sends
> >> > > data for both touchpad and trackstick events and so OS does no=
t have
> >> > > normal access to "hidden" trackstick.
> >> > >
> >> > > There is a way "jump" into passthrough mode and talk directly =
to
> >> > > trackpoint. But it is used only for configuring trackstick and=
 currently
> >> > > it is used to configure trackstick so it send data (via touchp=
ad) in
> >> > > format which is supported by our ALPS driver.
> >> > >
> >> > > On the other hand, synaptics driver and devices support full
> >> > > "encapsulation" or how can I call it of serio PS/2 device and =
in this
> >> > > case you can use full set of PS/2 commands directly with track=
stick
> >> > > (behind synaptics touchpad). ALPS devices do not support somet=
hing like
> >> > > that.
> >> >=20
> >> > It looks to me like the Synaptics passthrough is implemented pri=
marily
> >> > via the ability to write directly to the trackpoint. Events comi=
ng
> >> > from the trackpoint are implemented similarly to the ALPS driver=
 - by
> >> > redirecting trackpoint events to the second device which the dri=
ver
> >> > creates for the trackpoint.
> >> >=20
> >>=20
> >> No, passthrough for ALPS and Synaptics differ. Synaptics driver ex=
ports
> >> full serio PS/2 bus on which can be attached psmouse.ko driver wit=
h full
> >> mouse detection (or any other serio driver) and so there can be fu=
ll
> >> TPPS/2 trackpoint.c protocol driver.
> >>=20
> >> ALPS allows us for *some* protocol version passthrough data direct=
ly to
> >> touchpad (or trackpoint) device. There is no support to exporting =
full
> >> serio bus with PS/2 access to it (like for Synaptics hardware).
> >=20
> > At least we do not know how to detect and activate it even if it ex=
ists.
> >=20
> > Let's add some ALPS people to the thread: maybe they could share so=
me
> > details on accessing trackpoints behind the touchpads with us.
> >=20
> > Thanks.
> >=20
> > --=20
> > Dmitry
>=20
> --=20
> This message and any attachment are confidential. It may also be priv=
ileged=20
> or otherwise protected by work product immunity or other legal rules.=
 If=20
> you have received it by mistake, please let us know by e-mail reply a=
nd=20
> delete it from your system, you may not copy this message or disclose=
 its=20
> contents to anyone.
> Cirque Corporation

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

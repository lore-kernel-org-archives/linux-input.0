From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: ALPS v7 trackpad passthrough to Thinkpad trackpoint
Date: Thu, 21 Jan 2016 13:12:03 +0100
Message-ID: <20160121121203.GC7192@pali>
References: <CANULwrQyVOhorRXb-+m=V-SZofn9dM3QJBU-xi=yFFOhq4t_2w@mail.gmail.com>
 <20150807132639.GB21627@pali>
 <CANULwrSnV=JvbUzkq2PCnpyWw3H9gFE1Z+HB-ntBZteF=AUE9g@mail.gmail.com>
 <20150807141214.GD21627@pali>
 <CANULwrTm0XEdKfC7Shx5VLpvHmkzRt5mOUjbFSm8ck86Ci=iKQ@mail.gmail.com>
 <20150813110317.GC20040@pali>
 <20150813224839.GC15693@dtor-ws>
 <17D6F4B6F11B44BBB1A2C8EB95A9CF84@cirque.local>
 <20150814001833.GD15693@dtor-ws>
 <7A4B7432A86148988B9878D8EB50F969@cirque.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:34932 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759214AbcAUMMG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Jan 2016 07:12:06 -0500
Received: by mail-wm0-f54.google.com with SMTP id r129so169491394wmr.0
        for <linux-input@vger.kernel.org>; Thu, 21 Jan 2016 04:12:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7A4B7432A86148988B9878D8EB50F969@cirque.local>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vadim Klishko <vadim@cirque.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ari Entlich <atrigent@gmail.com>, linux-input@vger.kernel.org, Masaki Ota <012nexus@gmail.com>, Tommy Will <tommywill2011@gmail.com>, Yunkang Tang <yunkang.tang@cn.alps.com>, Qiting Chen <qiting.chen@cn.alps.com>, Qiting Chen <elaineee66@gmail.com>

On Thursday 13 August 2015 18:25:16 Vadim Klishko wrote:
> > On Thu, Aug 13, 2015 at 06:11:22PM -0600, Vadim Klishko wrote:
> >> I am not sure I understand what details you are looking for, but a=
s
> >> far as I know, the only way a command sent to an Alps device from =
the
> >> host could reach the trackstick is when the touchpad chip is in
> >> pass-thru mode.
> >=20
> > We are looking for information on how to detect whether a device
> > supports pass-through mode and how to activate it. IOW we are looki=
ng
> > for the protocol specs for the PS/2 flavor used by ALPS devices. So=
 far
> > we had to deduce many of the details itself and it would be great i=
f
> > manufacturer would share the information with us sol that we could
> > improve support for the devices in Linux kernel.
> >=20
> OK, got it. It may take some time.
>=20

Hi Vadim! Now after more months, do you have some news about this?

>=20
> >>=20
> >>=20
> >> ----- Original Message -----=20
> >> From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
> >> To: "Pali Roh=C3=A1r" <pali.rohar@gmail.com>
> >> Cc: "Ari Entlich" <atrigent@gmail.com>; <linux-input@vger.kernel.o=
rg>; "Masaki Ota" <012nexus@gmail.com>; "Tommy Will" <tommywill2011@gma=
il.com>; "Yunkang Tang" <yunkang.tang@cn.alps.com>; "Qiting Chen" <qiti=
ng.chen@cn.alps.com>; "Qiting Chen" <elaineee66@gmail.com>; <vadim@cirq=
ue.com>
> >> Sent: Thursday, August 13, 2015 4:48 PM
> >> Subject: Re: ALPS v7 trackpad passthrough to Thinkpad trackpoint
> >>=20
> >>=20
> >> > On Thu, Aug 13, 2015 at 01:03:17PM +0200, Pali Roh=C3=A1r wrote:
> >> >> On Friday 07 August 2015 12:35:33 Ari Entlich wrote:
> >> >> > On Fri, Aug 7, 2015 at 10:12 AM, Pali Roh=C3=A1r <pali.rohar@=
gmail.com> wrote:
> >> >> > > For some old ALPS devices which use V1 and V2 protocols (wi=
th flag
> >> >> > > ALPS_PASS) there is something like that. On that devices to=
uchpad is
> >> >> > > behind trackpoint HW. But you cannot wait for data or poll =
for both
> >> >> > > devices at same time -- you need to choose if tou want to t=
alk directly
> >> >> > > to touchpad (via passthrough mode) or just to trackpoint. I=
 think
> >> >> > > because of this limitation ALPS driver implement all logic =
in one
> >> >> > > driver...
> >> >> > >
> >> >> > > Above was for old ALPS devices. New ALPS devices with V3 or=
 V5 protocols
> >> >> > > have trackpoint behind touchpad, so normally OS communicate=
 with
> >> >> > > touchpad (and not with trackstick like before). But here to=
uchpad sends
> >> >> > > data for both touchpad and trackstick events and so OS does=
 not have
> >> >> > > normal access to "hidden" trackstick.
> >> >> > >
> >> >> > > There is a way "jump" into passthrough mode and talk direct=
ly to
> >> >> > > trackpoint. But it is used only for configuring trackstick =
and currently
> >> >> > > it is used to configure trackstick so it send data (via tou=
chpad) in
> >> >> > > format which is supported by our ALPS driver.
> >> >> > >
> >> >> > > On the other hand, synaptics driver and devices support ful=
l
> >> >> > > "encapsulation" or how can I call it of serio PS/2 device a=
nd in this
> >> >> > > case you can use full set of PS/2 commands directly with tr=
ackstick
> >> >> > > (behind synaptics touchpad). ALPS devices do not support so=
mething like
> >> >> > > that.
> >> >> >=20
> >> >> > It looks to me like the Synaptics passthrough is implemented =
primarily
> >> >> > via the ability to write directly to the trackpoint. Events c=
oming
> >> >> > from the trackpoint are implemented similarly to the ALPS dri=
ver - by
> >> >> > redirecting trackpoint events to the second device which the =
driver
> >> >> > creates for the trackpoint.
> >> >> >=20
> >> >>=20
> >> >> No, passthrough for ALPS and Synaptics differ. Synaptics driver=
 exports
> >> >> full serio PS/2 bus on which can be attached psmouse.ko driver =
with full
> >> >> mouse detection (or any other serio driver) and so there can be=
 full
> >> >> TPPS/2 trackpoint.c protocol driver.
> >> >>=20
> >> >> ALPS allows us for *some* protocol version passthrough data dir=
ectly to
> >> >> touchpad (or trackpoint) device. There is no support to exporti=
ng full
> >> >> serio bus with PS/2 access to it (like for Synaptics hardware).
> >> >=20
> >> > At least we do not know how to detect and activate it even if it=
 exists.
> >> >=20
> >> > Let's add some ALPS people to the thread: maybe they could share=
 some
> >> > details on accessing trackpoints behind the touchpads with us.
> >> >=20
> >> > Thanks.
> >> >=20
> >> > --=20
> >> > Dmitry
> >>=20
> >> --=20
> >> This message and any attachment are confidential. It may also be p=
rivileged=20
> >> or otherwise protected by work product immunity or other legal rul=
es. If=20
> >> you have received it by mistake, please let us know by e-mail repl=
y and=20
> >> delete it from your system, you may not copy this message or discl=
ose its=20
> >> contents to anyone.
> >> Cirque Corporation
> >=20
> > --=20
> > Dmitry
>=20

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

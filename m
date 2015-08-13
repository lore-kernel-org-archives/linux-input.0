From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: ALPS v7 trackpad passthrough to Thinkpad trackpoint
Date: Thu, 13 Aug 2015 15:48:39 -0700
Message-ID: <20150813224839.GC15693@dtor-ws>
References: <CANULwrQyVOhorRXb-+m=V-SZofn9dM3QJBU-xi=yFFOhq4t_2w@mail.gmail.com>
 <20150807132639.GB21627@pali>
 <CANULwrSnV=JvbUzkq2PCnpyWw3H9gFE1Z+HB-ntBZteF=AUE9g@mail.gmail.com>
 <20150807141214.GD21627@pali>
 <CANULwrTm0XEdKfC7Shx5VLpvHmkzRt5mOUjbFSm8ck86Ci=iKQ@mail.gmail.com>
 <20150813110317.GC20040@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:35891 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752135AbbHMWsp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Aug 2015 18:48:45 -0400
Received: by pdco4 with SMTP id o4so24494985pdc.3
        for <linux-input@vger.kernel.org>; Thu, 13 Aug 2015 15:48:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150813110317.GC20040@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Ari Entlich <atrigent@gmail.com>, linux-input@vger.kernel.org, Masaki Ota <012nexus@gmail.com>, Tommy Will <tommywill2011@gmail.com>, Yunkang Tang <yunkang.tang@cn.alps.com>, Qiting Chen <qiting.chen@cn.alps.com>, Qiting Chen <elaineee66@gmail.com>, vadim@cirque.com

On Thu, Aug 13, 2015 at 01:03:17PM +0200, Pali Roh=E1r wrote:
> On Friday 07 August 2015 12:35:33 Ari Entlich wrote:
> > On Fri, Aug 7, 2015 at 10:12 AM, Pali Roh=E1r <pali.rohar@gmail.com=
> wrote:
> > > For some old ALPS devices which use V1 and V2 protocols (with fla=
g
> > > ALPS_PASS) there is something like that. On that devices touchpad=
 is
> > > behind trackpoint HW. But you cannot wait for data or poll for bo=
th
> > > devices at same time -- you need to choose if tou want to talk di=
rectly
> > > to touchpad (via passthrough mode) or just to trackpoint. I think
> > > because of this limitation ALPS driver implement all logic in one
> > > driver...
> > >
> > > Above was for old ALPS devices. New ALPS devices with V3 or V5 pr=
otocols
> > > have trackpoint behind touchpad, so normally OS communicate with
> > > touchpad (and not with trackstick like before). But here touchpad=
 sends
> > > data for both touchpad and trackstick events and so OS does not h=
ave
> > > normal access to "hidden" trackstick.
> > >
> > > There is a way "jump" into passthrough mode and talk directly to
> > > trackpoint. But it is used only for configuring trackstick and cu=
rrently
> > > it is used to configure trackstick so it send data (via touchpad)=
 in
> > > format which is supported by our ALPS driver.
> > >
> > > On the other hand, synaptics driver and devices support full
> > > "encapsulation" or how can I call it of serio PS/2 device and in =
this
> > > case you can use full set of PS/2 commands directly with tracksti=
ck
> > > (behind synaptics touchpad). ALPS devices do not support somethin=
g like
> > > that.
> >=20
> > It looks to me like the Synaptics passthrough is implemented primar=
ily
> > via the ability to write directly to the trackpoint. Events coming
> > from the trackpoint are implemented similarly to the ALPS driver - =
by
> > redirecting trackpoint events to the second device which the driver
> > creates for the trackpoint.
> >=20
>=20
> No, passthrough for ALPS and Synaptics differ. Synaptics driver expor=
ts
> full serio PS/2 bus on which can be attached psmouse.ko driver with f=
ull
> mouse detection (or any other serio driver) and so there can be full
> TPPS/2 trackpoint.c protocol driver.
>=20
> ALPS allows us for *some* protocol version passthrough data directly =
to
> touchpad (or trackpoint) device. There is no support to exporting ful=
l
> serio bus with PS/2 access to it (like for Synaptics hardware).

At least we do not know how to detect and activate it even if it exists=
=2E

Let's add some ALPS people to the thread: maybe they could share some
details on accessing trackpoints behind the touchpads with us.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

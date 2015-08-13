From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: ALPS v7 trackpad passthrough to Thinkpad trackpoint
Date: Thu, 13 Aug 2015 13:03:17 +0200
Message-ID: <20150813110317.GC20040@pali>
References: <CANULwrQyVOhorRXb-+m=V-SZofn9dM3QJBU-xi=yFFOhq4t_2w@mail.gmail.com>
 <20150807132639.GB21627@pali>
 <CANULwrSnV=JvbUzkq2PCnpyWw3H9gFE1Z+HB-ntBZteF=AUE9g@mail.gmail.com>
 <20150807141214.GD21627@pali>
 <CANULwrTm0XEdKfC7Shx5VLpvHmkzRt5mOUjbFSm8ck86Ci=iKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:36826 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740AbbHMLDV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Aug 2015 07:03:21 -0400
Received: by wicja10 with SMTP id ja10so146718543wic.1
        for <linux-input@vger.kernel.org>; Thu, 13 Aug 2015 04:03:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANULwrTm0XEdKfC7Shx5VLpvHmkzRt5mOUjbFSm8ck86Ci=iKQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ari Entlich <atrigent@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

On Friday 07 August 2015 12:35:33 Ari Entlich wrote:
> On Fri, Aug 7, 2015 at 10:12 AM, Pali Roh=C3=A1r <pali.rohar@gmail.co=
m> wrote:
> > For some old ALPS devices which use V1 and V2 protocols (with flag
> > ALPS_PASS) there is something like that. On that devices touchpad i=
s
> > behind trackpoint HW. But you cannot wait for data or poll for both
> > devices at same time -- you need to choose if tou want to talk dire=
ctly
> > to touchpad (via passthrough mode) or just to trackpoint. I think
> > because of this limitation ALPS driver implement all logic in one
> > driver...
> >
> > Above was for old ALPS devices. New ALPS devices with V3 or V5 prot=
ocols
> > have trackpoint behind touchpad, so normally OS communicate with
> > touchpad (and not with trackstick like before). But here touchpad s=
ends
> > data for both touchpad and trackstick events and so OS does not hav=
e
> > normal access to "hidden" trackstick.
> >
> > There is a way "jump" into passthrough mode and talk directly to
> > trackpoint. But it is used only for configuring trackstick and curr=
ently
> > it is used to configure trackstick so it send data (via touchpad) i=
n
> > format which is supported by our ALPS driver.
> >
> > On the other hand, synaptics driver and devices support full
> > "encapsulation" or how can I call it of serio PS/2 device and in th=
is
> > case you can use full set of PS/2 commands directly with trackstick
> > (behind synaptics touchpad). ALPS devices do not support something =
like
> > that.
>=20
> It looks to me like the Synaptics passthrough is implemented primaril=
y
> via the ability to write directly to the trackpoint. Events coming
> from the trackpoint are implemented similarly to the ALPS driver - by
> redirecting trackpoint events to the second device which the driver
> creates for the trackpoint.
>=20

No, passthrough for ALPS and Synaptics differ. Synaptics driver exports
full serio PS/2 bus on which can be attached psmouse.ko driver with ful=
l
mouse detection (or any other serio driver) and so there can be full
TPPS/2 trackpoint.c protocol driver.

ALPS allows us for *some* protocol version passthrough data directly to
touchpad (or trackpoint) device. There is no support to exporting full
serio bus with PS/2 access to it (like for Synaptics hardware).

> > Note I just wrote information which I understand from driver source=
 code
> > and with "playing" with touchpads. There can be some mistakes (so
> > somebody can correct me), but this is how I understand this situati=
on.
> >
> > I do not have access and I have never seen any "official" documenta=
tion.
> > I can say, that current ALPS driver in kernel does not support it f=
or
> > 100% sure. But maybe we just missing some information which allows =
us to
> > do it.
> >
> > But in my opinion ALPS firmware which is running in ALPS touchpad d=
oes
> > not support something like full passthrough to trackpoint device li=
ke
> > synaptics. For me it does not make sense to add such function into
> > firmware, because it already send all needed data for OS to allow
> > processing both touchpad and trackpoint data.
>=20
> The issue isn't so much getting information from the trackpoint but
> sending information TO it. The trackpoint driver is able to send

But because we do not have direct access to serio PS/2 bus to trackpoin=
t
hardware, we cannot use trackpoint.c driver and so trackpoint.c code is
for ALPS devices useless.

> special commands to the trackpoint to modify its behavior. As far as =
I
> can tell, this is pretty much the only thing it does. See
> drivers/input/mouse/trackpoint.c for details.
>=20
> > Questions are: Do we need full access to trackpoint hardware? Do we=
 know
> > if trackpoint (used by ALPS input solutions) supports configuring s=
peed
> > or acceleration in hardware? It is really not easier to do it in
> > software?
>=20
> As I mentioned in my first email, I'm aware that mouse behavior can b=
e
> modified in userspace. However, that's not what I'm asking about. I
> want to have the same capabilities with this device as I had with the
> old one, if at all possible.

Ok, which are those capabilities?

> And anyways, there are some things that
> the trackpoint driver can do that cannot be done in software.
>=20

What cannot be done in software? I still think that trackpoint is
"stupid" HW with firmware which doing all that magic. And I do not see
reason why something implement in firmware software cannot be done in
userspace application (or in kernel driver if it makes sense).

> Ari
>=20
> > --
> > Pali Roh=C3=A1r
> > pali.rohar@gmail.com

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

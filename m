From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: ALPS v7 trackpad passthrough to Thinkpad trackpoint
Date: Fri, 7 Aug 2015 16:12:14 +0200
Message-ID: <20150807141214.GD21627@pali>
References: <CANULwrQyVOhorRXb-+m=V-SZofn9dM3QJBU-xi=yFFOhq4t_2w@mail.gmail.com>
 <20150807132639.GB21627@pali>
 <CANULwrSnV=JvbUzkq2PCnpyWw3H9gFE1Z+HB-ntBZteF=AUE9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:36236 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753337AbbHGOMQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Aug 2015 10:12:16 -0400
Received: by wicgj17 with SMTP id gj17so63205610wic.1
        for <linux-input@vger.kernel.org>; Fri, 07 Aug 2015 07:12:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANULwrSnV=JvbUzkq2PCnpyWw3H9gFE1Z+HB-ntBZteF=AUE9g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ari Entlich <atrigent@gmail.com>
Cc: linux-input@vger.kernel.org

On Friday 07 August 2015 09:41:07 Ari Entlich wrote:
> On Fri, Aug 7, 2015 at 9:26 AM, Pali Roh=C3=A1r <pali.rohar@gmail.com=
> wrote:
> > Hello,
> >
> > ALPS devices does not support pass-throw mode like Synaptics device=
s.
>=20
> Hmm... Then what are all of these references to passthrough in alps.c=
?
> Does the alps driver use the term "passthrough" in a different way
> than the synaptics driver does?
>=20

=46or some old ALPS devices which use V1 and V2 protocols (with flag
ALPS_PASS) there is something like that. On that devices touchpad is
behind trackpoint HW. But you cannot wait for data or poll for both
devices at same time -- you need to choose if tou want to talk directly
to touchpad (via passthrough mode) or just to trackpoint. I think
because of this limitation ALPS driver implement all logic in one
driver...

Above was for old ALPS devices. New ALPS devices with V3 or V5 protocol=
s
have trackpoint behind touchpad, so normally OS communicate with
touchpad (and not with trackstick like before). But here touchpad sends
data for both touchpad and trackstick events and so OS does not have
normal access to "hidden" trackstick.

There is a way "jump" into passthrough mode and talk directly to
trackpoint. But it is used only for configuring trackstick and currentl=
y
it is used to configure trackstick so it send data (via touchpad) in
format which is supported by our ALPS driver.

On the other hand, synaptics driver and devices support full
"encapsulation" or how can I call it of serio PS/2 device and in this
case you can use full set of PS/2 commands directly with trackstick
(behind synaptics touchpad). ALPS devices do not support something like
that.

> Are we 100% sure that alps devices can't do this? Is there any
> possibility that we just don't know how to do it?
>=20

Note I just wrote information which I understand from driver source cod=
e
and with "playing" with touchpads. There can be some mistakes (so
somebody can correct me), but this is how I understand this situation.

I do not have access and I have never seen any "official" documentation=
=2E
I can say, that current ALPS driver in kernel does not support it for
100% sure. But maybe we just missing some information which allows us t=
o
do it.

But in my opinion ALPS firmware which is running in ALPS touchpad does
not support something like full passthrough to trackpoint device like
synaptics. For me it does not make sense to add such function into
firmware, because it already send all needed data for OS to allow
processing both touchpad and trackpoint data.

Questions are: Do we need full access to trackpoint hardware? Do we kno=
w
if trackpoint (used by ALPS input solutions) supports configuring speed
or acceleration in hardware? It is really not easier to do it in
software?

> Thanks.
>=20
> Ari
>=20
> > But our ALPS driver is good and can detect packet from device conta=
ins
> > data for touchpad or trackpoint. So ALPS driver create two input de=
vices
> > and send events to userspace via correct input device and userspace=
 see
> > that there are two different devices (touchpad and trackstick) and =
not
> > one "combined".
> >
> > Looks like that ALPS devices does not support any speed or accelera=
tion
> > configuration, so everything needs to be implemented in software --=
 in
> > userspace. X drivers already have such configuration ether via xorg=
=2Econf
> > or runtime via xinput. Speed or acceleration can be configured per =
input
> > device, so this is something which you probably want.
> >
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

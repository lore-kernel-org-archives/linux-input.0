From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [patch 0/2] Winbond IR Driver - v2
Date: Mon, 17 Aug 2009 06:56:57 +0300
Message-ID: <1250481417.3549.23.camel@maxim-laptop>
References: <20090809095645.198777507@hardeman.nu>
	 <1250305347.18122.4.camel@maxim-laptop>
	 <20090815201019.GB27484@hardeman.nu>
	 <1250374211.1928.27.camel@maxim-laptop>
	 <20090816184350.GA28497@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f175.google.com ([209.85.210.175]:63794 "EHLO
	mail-yx0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714AbZHQD5C (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 16 Aug 2009 23:57:02 -0400
In-Reply-To: <20090816184350.GA28497@hardeman.nu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David =?ISO-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, jbarnes@virtuousgeek.org, akpm@linux-foundation.org, dmitry.torokhov@gmail.com

On Sun, 2009-08-16 at 20:43 +0200, David H=C3=A4rdeman wrote:
> On Sun, Aug 16, 2009 at 01:10:11AM +0300, Maxim Levitsky wrote:
> >On Sat, 2009-08-15 at 22:10 +0200, David H=C3=A4rdeman wrote:
> >> On Sat, Aug 15, 2009 at 06:02:27AM +0300, Maxim Levitsky wrote:
> >>>
> >>> Then why not to implement lirc driver?
> >>
> >> That's a fair question, but I'm afraid you're putting the cart bef=
ore
> >> the horse.
> >
> >No, I just want to write the driver that fully exposes the hardware.=
 I
> >don't care if it has to be outside or not.
>=20
> That's not a very user-friendly sentiment. The entire idea is to exte=
nd=20
> the input subsystem so that it fully exposes the hardware *and* gives=
=20
> users the benefit of in-kernel drivers.
>=20
> >> The question is not why anyone would want to write an in-kernel dr=
iver
> >> but rather why anyone would want to write an out-of-kernel driver.
It doesn't matter that much. I have written a driver. It works.
Eventually some IR subsystem will make into kernel, I then port my
driver to that system.

Currently, there is no such system. attempting to write a driver that
decode just one remote, in my opinion aren't that great.
IR_RAW of course, it nice, and will solve all problems, so go ahead wit=
h
that.

As long as there is a normal (not debug or so) access to raw data, its
fine with me.

I do think however that in kernel ir decoders are redundant, except
maybe some embedded systems.


> >>
> >> There have been repeated attempts to get LIRC merged with the kern=
el,
> >> and the feedback has been pretty consistent - make it part of the =
input
> >> subsystem.
> >>
> >> I have written the driver for theo input system and it limits the =
driver
> >> somewhat. I am working on extending the input system to accomodate=
 IR
> >> drivers (see the discussion of EV_IR on the linux-input list).
> >
> >The EV_IR thing is that he attempts to put all IR decoding in kernel=
,
> >and on top of that create a configfs config system.
>=20
> I never proposed a configfs system. I only proposed a part of Jon=20
> Smirl's EV_IR functionality. I think the configfs system as well as t=
he=20
> in-kernel protocol _en_coders are overengineering.
and decoders?


>=20
> >I first thought it would be nice, but then realized that this is rea=
lly
> >bad idea.
> >Currently LIRC has very oiled system for decoding pretty much every
> >remote that exist. It can cope with all kind of troubles, including =
not
> >very accurate receivers.
>=20
> I think you've misunderstood my EV_IR suggestion on the linux-input=20
> list. Part of that proposal is to allow drivers to generate IR_RAW=20
> timing events (if asked to do so via an ioctl), then you could contin=
ue=20
> to use lirc with some minimal changes to the lirc daemon while still=20
> getting the benefits of in-kernel drivers. I have a hard time seeing=20
> what would be wrong with that? Whether the input subsystem *also*=20
> includes (optional) IR decoding or not should not matter to lirc fans=
 as=20
> long as it includes some kind of IR_RAW support (which it does both i=
n=20
> Jon's proposal and in mine).
Thats of course is different.
I am not yet a lirc fan :-), but I can assure you that there are many
protocols. much more that we think.

The way lirc works, ensures that it can adapt to any remote.

>=20
> >On top of that there are pure userspace devices, like a IR diode
> >connected to soundcard. It would be nice to do all the raw signal
> >decoding in one place. Once signal is decoded, lirc forwards the inp=
ut
> >signal to the kernel via uinput, so it is a part of input system.
>=20
> That's a red herring, there is always going to be esoteric DIY hardwa=
re,=20
> and no matter which API is used in the kernel, that hardware can alwa=
ys=20
> use user-space drivers.
The point is that doing it all in userspace helps ensure that settings
are kept in one place.
I have a lirc.conf. It will work with any receiver, homebrew or not.

>=20
> >The way kernel hands in the raw IR data to lirc doesn't matter much.=
 It
> >is really just a queue of numbers. It can be forced into input syste=
m,
> >but there is really no need for that.
I personally don't care. If you want to send IR raw data via input
layer, it is very fine with me. I am sure that lirc devs won't mind tha=
t
ether.



>=20
> There really is a need if you want in-kernel drivers.
>=20
> >> Feel free to help me out in implementing that API, and porting LIR=
C
> >> drivers, and all the benefits of in-kernel drivers will flow from =
that
> >> work.
> >
> >This isn't a bad idea.
>=20
> Good, we agree on this point, which is the most important one. IR_RAW=
=20
> should be enough for the lirc daemon, right? So let's make sure=20
> something like that gets added to the input subsystem and we can take=
 it=20
> from there...
This indeed will be great.


>=20
> >>>This driver as I understand is a driver for single remote shipped =
with
> >>>the notebook.
> >>
> >> It's a driver for a winbond chipset shipped with many Intel deskto=
p
> >> "media" motherboards (DP35DP, DG33TL, DX388T, DX488T2, DP455G, DG4=
5ID
> >> and DG45FC are the ones I'm aware of).
> >
> >But it won't work with my JVC remote?....
>=20
> Not sure what you JVC remote has to do with the Intel mainboards that=
=20
> include the WPCD376I chipset.
Lets see. I have a remote from a VCR I no longer use, I now use it with
my computer....
It isn't a NEC protocol, it actually has its own protocol (JVC)
But all these protocols are very similar.


>=20
> Anyway, based on past experience of JVC remotes I'm guessing that you=
r=20
> remote uses some version of the NEC protocol, in that case it will be=
=20
> supported...and IR_RAW (or something similar) will be supported if it=
 is=20
> accepted by the input subsystem maintainers so you will additionally =
be=20
> able to use that air conditioning remote which implements a completel=
y=20
> wonky IR protocol together with lirc - if you want to...
Indeed. Not with lirc, as it doesn't implement support for decoding suc=
h
remotes... but it is trivial to add such support, or write my own app
for that.


So I do agree with you mostly. I don't care how the raw timings will be
given to lirc.


Best regards,
	Maxim Levitsky



>=20
> Regards,
> David H=C3=A4rdeman
>=20
> (trimmed some people of the CC list which are unlikely to be interest=
ed=20
> in this discussion, I hope Dmitry will speak up soon).
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [patch 0/2] Winbond IR Driver - v2
Date: Sun, 16 Aug 2009 01:10:11 +0300
Message-ID: <1250374211.1928.27.camel@maxim-laptop>
References: <20090809095645.198777507@hardeman.nu>
	 <1250305347.18122.4.camel@maxim-laptop>
	 <20090815201019.GB27484@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f215.google.com ([209.85.220.215]:41274 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbZHOWK1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 15 Aug 2009 18:10:27 -0400
In-Reply-To: <20090815201019.GB27484@hardeman.nu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David =?ISO-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, jbarnes@virtuousgeek.org, akpm@linux-foundation.org, bjorn.helgaas@hp.com, randy.dunlap@oracle.com, dmitry.torokhov@gmail.com

On Sat, 2009-08-15 at 22:10 +0200, David H=C3=A4rdeman wrote:
> On Sat, Aug 15, 2009 at 06:02:27AM +0300, Maxim Levitsky wrote:
> >On Sun, 2009-08-09 at 11:56 +0200, david@hardeman.nu wrote:
> >> Here's a new patch set which should replace all the patches curren=
tly in the
> >> -mm tree for the winbond cir driver. The new series incorporate fe=
edback from
> >> Bjorn Helgaas (convert the driver from ACPI to PNP) and Randy Dunl=
ap (Kconfig
> >> fixes).
> >>=20
> >> The IR decoding can still be improved but the driver works for in =
daily use
> >> decoding RC6 commands, so I believe it is ready to go upstream.
> >>=20
> >
> >Hi.
>=20
> Hi,
>=20
> >As I understand, this hardware returns sampled IR signal, so it can =
be
> >used with any remote, right?
>=20
> Yes.
>=20
> >Then why not to implement lirc driver?
>=20
> That's a fair question, but I'm afraid you're putting the cart before=
=20
> the horse.
No, I just want to write the driver that fully exposes the hardware. I
don't care if it has to be outside or not.

>=20
> The question is not why anyone would want to write an in-kernel drive=
r=20
> but rather why anyone would want to write an out-of-kernel driver.
>=20
> There have been repeated attempts to get LIRC merged with the kernel,=
=20
> and the feedback has been pretty consistent - make it part of the inp=
ut=20
> subsystem.
>=20
> I have written the driver for theo input system and it limits the dri=
ver=20
> somewhat. I am working on extending the input system to accomodate IR=
=20
> drivers (see the discussion of EV_IR on the linux-input list).
The EV_IR thing is that he attempts to put all IR decoding in kernel,
and on top of that create a configfs config system.
I first thought it would be nice, but then realized that this is really
bad idea.
Currently LIRC has very oiled system for decoding pretty much every
remote that exist. It can cope with all kind of troubles, including not
very accurate receivers.
On top of that there are pure userspace devices, like a IR diode
connected to soundcard. It would be nice to do all the raw signal
decoding in one place. Once signal is decoded, lirc forwards the input
signal to the kernel via uinput, so it is a part of input system.

The way kernel hands in the raw IR data to lirc doesn't matter much. It
is really just a queue of numbers. It can be forced into input system,
but there is really no need for that.





>=20
> As an example, the input system already has a quite extensive set of=20
> additional functions to deal with force-feedback hardware (mostly=20
> additional ioctl's, see include/linux/input.h). I want the input syst=
em=20
> to grow similar extensions for IR hardware which would then allow IR=20
> drivers to be written as input drivers with their full functionality=20
> exposed to user-space.
This is straight forward to implement as an ioctl for that lirc device.

>=20
> Feel free to help me out in implementing that API, and porting LIRC=20
> drivers, and all the benefits of in-kernel drivers will flow from tha=
t=20
> work.
This isn't a bad idea.


>=20
> To be more specific, the things that are on my radar right now are:
>=20
> o IR TX - I believe an IOCTL which will take an array of signed integ=
ers=20
>            symbolizing IR on/off timings together with parameters for=
 IR=20
>            carrier modulation is the way to go and to let userspace d=
eal=20
>            with the generation of those integers (for a number of=20
>            reasons).
This is done in lirc already via ioctls.

>=20
> o IR RX - We need to expose the full functionality of hardware with=20
>            multiple receivers to userspace. Microsoft's current CIR s=
pecs=20
>            mandate that IR hardware that includes transmitters must=20
>            include both a long-distance, narrow-band receiver for com=
mon=20
>            use and a short-distance, wide-band receiver for learning=20
>            purposes. Expect future hardware to meet those demands...
>=20
> o Hardware differences -
>            The lircd daemon currently has a "-H" parameter to specify=
 the=20
>            driver to use. To me, that is a dead giveaway for an=20
>            inconsistent kernel <-> userspace API. We can do better, g=
iven=20
>            the proper HW flags from the input layer, userspace should=
=20
>            adapt automatically. Some hardware, say=20
>            drivers/media/dvb/ttpci/budget-ci.c (where you'll find my =
name=20
>            in the git logs) only support passing decoded RC5 events. =
Some=20
>            hardware (like the lirc mceusb(2) driver) passes the timin=
g=20
>            for the IR signals and supports any remotely sane IR proto=
col.=20
>            The WPCD376I has even a bit more capabilities like=20
>            wake-from-poweroff, two receivers and up to four transmitt=
ers
>            with the capability to detect which transmitters are conne=
cted=20
>            and which ones are not.
This isn't a problem. LIRC has a 'generic' driver "default" its name I
think, that deals with kernel drivers. It has the -H for all kinds of
wierd and old devices that work via userspace.

>=20
>            The challenge at this point is not in writing drivers for =
the=20
>            hardware, it is designing an extension to the input layer =
that=20
>            can sanely deal with the diversity.
>=20
> Anyhow, do check the linux-input list for my EV_IR patches, they are =
the=20
> first step in that direction (and they're based on the API proposal b=
y=20
> Jon Smirl posted at the end of last year). Raw signalling information=
=20
> for wonky remotes is part of that proposal (though the patches are no=
t=20
> fully fleshed out yet).
>=20
> >This driver as I understand is a driver for single remote shipped wi=
th
> >the notebook.
>=20
> It's a driver for a winbond chipset shipped with many Intel desktop=20
> "media" motherboards (DP35DP, DG33TL, DX388T, DX488T2, DP455G, DG45ID=
=20
> and DG45FC are the ones I'm aware of).
But it won't work with my JVC remote?....

>=20
> >I have recently wrote a lirc driver for  my receiver, a lirc driver.=
 Now
> >I can use all my remotes.
>=20
> So can I. But for a easy-to-use and consistent user interface, some=20
> changes are needed to the input layer.


Best regards,
	Maxim Levitsky

>=20
> >And no, I don't need any software support for that. LIRC happily
> >forwards all events via uinput to kernel, so I use it a an ordinary
> >keyboard.
>=20
> I know LIRC and what it can do, look in the CVS logs and the LIRC=20
> mailing list archives and I think you'll find my name there.
>=20
> Regards,
> David H=C3=A4rdeman

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

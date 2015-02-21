From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: Logitech G-series drivers
Date: Sat, 21 Feb 2015 22:57:28 +0100
Message-ID: <20150221225728.2944c76a@neptune.home>
References: <2384594.RyRtmbhCrj@pink>
	<20150219104827.7f5d4e38@pluto.restena.lu>
	<2205053.ll7fhHWnZQ@pink>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hygieia.santi-shop.eu ([78.46.175.2]:45693 "EHLO
	hygieia.santi-shop.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751733AbbBUV5h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 21 Feb 2015 16:57:37 -0500
In-Reply-To: <2205053.ll7fhHWnZQ@pink>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ciprian Ciubotariu <cheepeero@gmx.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

On Sat, 21 February 2015 Ciprian Ciubotariu <cheepeero@gmx.net> wrote:
> Hi. Only now I realized you wrote some instructions. Below are my (qu=
ite=20
> lengthy) responses.
>=20
> On Thursday 19 February 2015 10:48:27 Bruno Pr=C3=A9mont wrote:
> > Hi Ciprian,
> >=20
> > Adding linux-input and Jiri (HID maintainer) to CC.
>=20
> Should I register myself on the linux-input mailing list as well?

That's up to you, though it would help catching possibly relevant threa=
ds
affecting input devices or (later) Logitech devices you care about.

> > On Sun, 15 Feb 2015 23:17:27 +0200 Ciprian Ciubotariu wrote:
> > Did you check for older work on Logitech keyboards that has been
> > proposed on linux-input list some time ago and what is currently
> > present in Linus' tree?
>=20
> Yes, I have checked the tree. The mailing list archives recorded some=
 related=20
> activity in 2010, but no patches were applied to the kernel tree.

Reviewing the work that happened back then and at least considering the
comments made at that time will help you get the code into a better sha=
pe.

That's about the time when I wrote picolcd driver, using the proposed
Logitech driver as a starting point.

> > An overview of the features covered by the drivers would help
> > understand what the new drivers add (and the differences between al=
l
> > the covered keyboard variants).
>=20
> I. From the user perspective, all G-series keyboards have
>=20
>     (1) A set of "macro" keys and a set of support keys (macro set se=
lection,=20
> menu navigation and such).=20
>=20
>     (2) Some devices present an LCD, which is either monochrome or co=
lor.=20
>=20
>     (3) All have LEDs that allow changing the (3a) keyboard illuminat=
ion=20
> intensity and color, (3b) the backlight of the macro set selection ke=
ys, as=20
> well (3c) as the backlight of the LCD.=20
>=20
> II. Hardware
>=20
> The hardware presents these extra keys on a separate USB device. G110=
 and G19=20
> use a separate endpoint for some of the keys, while other models use =
just HID=20
> reports. All seem to use a custom bit-flag format to report the key s=
tatus, but=20
> I am not a HID expert - maybe it is standard. However, all these keys=
 are dead=20
> without these drivers.
>
> The LEDs are controlled via hid reports, but the calculus of the fiel=
ds differs=20
> on some models (G110 needs some weird maths).
>=20
> The LCD framebuffer can be written to via USB interrupt/bulk endpoint=
s=20
> depending on the model. hid-gfb.c implements the LCD matrix via the k=
ernel's=20
> FB API. The LCD backlight can only be controlled independently on G19=
, and is=20
> mapped to LED devices by hid-g19.

This is rather important information for explaining your choice of spli=
tting
up the code.
You may want to extend this, eventually putting it into a file under
Documentation/

Giving a clear overview of how the various features are presented on US=
B/HID
side for each driver definitely helps.

This should also help you decide if unification is reasonable or just r=
equires
too much glue-code to translate different HW implementations.

> III. Driver code
>=20
> <snip>
>=20
> > If you would like to get the drivers merged please create patches
> > against upstream tree, eventually starting with support for the
> > keyboard you own, adding support for the other keyboards in separat=
e
> > patches.
> > You could also split your patch based on feature support.
>=20
> While I am typing on the G19 right now, I have only tested G110, G13,=
 G15v2=20
> and they seem stable. I lack the G15 model, and G510 is not yet worki=
ng.
>=20
> To summarize, this submission is about devices g110, g13, g15v2 and g=
19, all=20
> tested by me and working.
>=20
> I have prepared a patch for the kernel tree, rebased into a single co=
mmit. I=20
> can split it per-device, but I don't know how to split the changes to=
 Kconfig,=20
> hid-ids.h and hid-core.c so that each patch can be applied independen=
tly=20
> (because the changes would overlap).

Splitting per-device is one way. More interesting for review would be s=
plitting
by feature:
- base input driver handling the "dead" keys
- adding LEDs
- adding LCD fb/backlight
- adding other goodies

Proposing the patches in a series where later patches depend on previou=
s ones
is the normal way of operating.

> The Kconfig made me wonder if I should (a) activate the dependent cod=
e in the=20
> kernel (for instance the FB or LEDS_CLASS etc), or (b) deactivate the=
 feature=20
> from the driver and advise users in the help text.

=46or those wanting to trip down their kernels in size having the optio=
n to
reduce feature set via Kconfig options is welcome.
If you select dependencies (you can only properly do so when selecting
config options that have no dependencies) or have your options show up/=
default
on them is up to you.

> > It might be worth exploring the option to organize the driver(s) as=
 a
> > MFD (multi-function-device) device.
>=20
> I have looked at the list of MFD devices with make menuconfig, but I =
have not=20
> seen any input devices there. Perhaps a radio, and mostly PMICs of va=
rious=20
> sorts.
>=20
> These are rather HID input devices with some extra custom goodies (ex=
tra keys,=20
> LEDs and LCDs). The implementation is also based on the HID bus.

If I had to redo picolcd driver now I would give MFD a try.
When I have enough time to do so I may very well convert it driver.

The big advantage I see in MFD drivers is that the separate functions c=
an
live in their respective areas in kernel code tree so they don't get sk=
ipped
when core/class code get API changes.


Bruno
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

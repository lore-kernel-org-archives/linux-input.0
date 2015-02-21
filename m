From: Ciprian Ciubotariu <cheepeero@gmx.net>
Subject: Re: Logitech G-series drivers
Date: Sat, 21 Feb 2015 17:46:47 +0200
Message-ID: <2205053.ll7fhHWnZQ@pink>
References: <2384594.RyRtmbhCrj@pink> <20150219104827.7f5d4e38@pluto.restena.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:61532 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751113AbbBUPrH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 21 Feb 2015 10:47:07 -0500
In-Reply-To: <20150219104827.7f5d4e38@pluto.restena.lu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Bruno =?ISO-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>

Hi. Only now I realized you wrote some instructions. Below are my (quit=
e=20
lengthy) responses.

On Thursday 19 February 2015 10:48:27 Bruno Pr=E9mont wrote:
> Hi Ciprian,
>=20
> Adding linux-input and Jiri (HID maintainer) to CC.

Should I register myself on the linux-input mailing list as well?

>=20
> On Sun, 15 Feb 2015 23:17:27 +0200 Ciprian Ciubotariu wrote:
> > I would like to submit to your attention for inclusion in the mainl=
ine
> > kernel a series of drivers for a set of Logitech keybord devices. I
> > forked the sources under a GPL/GPLv2 license and performed maintena=
nce
> > and stabilization work on them.
> >=20
> > The repository I am working on is at
> >=20
> >     https://github.com/CMoH/lg4l
> >=20
> > Short description of the modules and files:
> >     - hid-g110 - Logitech G110 (tested)
> >     - hid-g13 - Logitech G13 (tested)
> >     - hid-g15v2 - Logitech G15, version 2 (tested)
> >     - hid-g19 - Logitech G19 (tested)
> >    =20
> >     - hid-g15 - Logitech G15 (not tested)
> >     - hid-g510 - Logitech G510 - not ready
> >    =20
> >     - hid-gcore - common functions for other modules
> >     - hid-gfb - framebuffer implementation for on-device displays
> >     - hid-ids.h - product IDs
> >=20
> > I would like the opinion of a kernel developer on the possibility o=
f
> > including these drivers in the kernel. If the answer is favorable, =
I will
> > prepare a series of patches against the kernel's master branch and =
work
> > towards them being accepted.
>=20
> From a quick look at your github tree the drivers are prepared for
> building out-of-tree.
>=20
> Did you check for older work on Logitech keyboards that has been
> proposed on linux-input list some time ago and what is currently
> present in Linus' tree?

Yes, I have checked the tree. The mailing list archives recorded some r=
elated=20
activity in 2010, but no patches were applied to the kernel tree.

>=20
> An overview of the features covered by the drivers would help
> understand what the new drivers add (and the differences between all
> the covered keyboard variants).

I. From the user perspective, all G-series keyboards have

    (1) A set of "macro" keys and a set of support keys (macro set sele=
ction,=20
menu navigation and such).=20

    (2) Some devices present an LCD, which is either monochrome or colo=
r.=20

    (3) All have LEDs that allow changing the (3a) keyboard illuminatio=
n=20
intensity and color, (3b) the backlight of the macro set selection keys=
, as=20
well (3c) as the backlight of the LCD.=20

II. Hardware

The hardware presents these extra keys on a separate USB device. G110 a=
nd G19=20
use a separate endpoint for some of the keys, while other models use ju=
st HID=20
reports. All seem to use a custom bit-flag format to report the key sta=
tus, but=20
I am not a HID expert - maybe it is standard. However, all these keys a=
re dead=20
without these drivers.

The LEDs are controlled via hid reports, but the calculus of the fields=
 differs=20
on some models (G110 needs some weird maths).

The LCD framebuffer can be written to via USB interrupt/bulk endpoints=20
depending on the model. hid-gfb.c implements the LCD matrix via the ker=
nel's=20
=46B API. The LCD backlight can only be controlled independently on G19=
, and is=20
mapped to LED devices by hid-g19.

III. Driver code

The driver code can be understood starting from the probe functions for=
 each=20
model. The probe functions allocate a common structure via hid-gcore.c,=
 and=20
use the gdata member for model-custom information. Each probe function =
adds=20
the appropriate LED-class devices, using functions in hid-gcore.c. Same=
 goes=20
for input devices, sysfs attributes and possibly framebuffer devices (v=
ia hid-
gfb.c).

Device initialization goes through a series of stages, which can be rea=
d via a=20
bitfield in some reports. After this is completed, the gXX_raw_event fu=
nction=20
defers to gXX_raw_event_process_input, which reports input events. For =
G110=20
and G19 we also have gXX_ep1_read and gXX_ep1_urb_completion, which han=
dle the=20
extra keys. gXX_led_.... keys handle LED brightness via sysfs.

The gfb_probe function in hid-gfb.c  is started by the main driver in=20
monochrome or color mode, depending on model. It allocates a backbuffer=
 for=20
user interaction, and writes it via an bulk/interrupt USB endpoint to t=
he=20
device. The USB writes are performed using a certain frequency using=20
=46B_DEFERRED_IO (see gfb_fb_deferred_io, gfb_update and gfb_fb_send). =
The rest=20
manages framebuffer operations and userspace access.


> There seem to be individual drivers for each keyboard type.
> Are the features so different that distinct drivers are needed or can
> the drivers be unified?

Some of my work was to start refactoring the set of copy-pasted drivers=
 into a=20
common functions module (hid-gcore). The LCDs use a common protocol, wh=
ich was=20
already isolated in hid-gfb.=20

Perhaps the LEDs API could be unified, but the hardware protocol would =
still=20
differ between models. The probe functions also seem similar, but I'll =
have to=20
check for subtle differences before attempting to unify them. More work=
 could=20
be done in this direction.

However, I think that at this stage attempting to completely unify the =
drivers=20
would make the code more unreadable. Maybe after some more refactoring.

Also, I am unsure if such an unification is compatible with Logitech's =
newer G-
series models (G710 etc), since they seem to change things in hardware =
at will=20
between models.

>=20
>=20
> If you would like to get the drivers merged please create patches
> against upstream tree, eventually starting with support for the
> keyboard you own, adding support for the other keyboards in separate
> patches.
> You could also split your patch based on feature support.

While I am typing on the G19 right now, I have only tested G110, G13, G=
15v2=20
and they seem stable. I lack the G15 model, and G510 is not yet working=
=2E

To summarize, this submission is about devices g110, g13, g15v2 and g19=
, all=20
tested by me and working.

I have prepared a patch for the kernel tree, rebased into a single comm=
it. I=20
can split it per-device, but I don't know how to split the changes to K=
config,=20
hid-ids.h and hid-core.c so that each patch can be applied independentl=
y=20
(because the changes would overlap).

The Kconfig made me wonder if I should (a) activate the dependent code =
in the=20
kernel (for instance the FB or LEDS_CLASS etc), or (b) deactivate the f=
eature=20
from the driver and advise users in the help text.

I have followed the Documentation/SubmitChecklist guide to check the co=
de for=20
style problems, checked it with sparse and cross-compiled it for ARM an=
d=20
PPC64. The incremental changes can be reviewed at https://github.com/CM=
oH/lg4l

>=20
> It might be worth exploring the option to organize the driver(s) as a
> MFD (multi-function-device) device.

I have looked at the list of MFD devices with make menuconfig, but I ha=
ve not=20
seen any input devices there. Perhaps a radio, and mostly PMICs of vari=
ous=20
sorts.

These are rather HID input devices with some extra custom goodies (extr=
a keys,=20
LEDs and LCDs). The implementation is also based on the HID bus.

I don't have any preference though.

>=20
> Bruno

Thank you for your interest!
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

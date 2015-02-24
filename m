From: Ciprian Ciubotariu <cheepeero@gmx.net>
Subject: Re: Logitech G-series drivers
Date: Tue, 24 Feb 2015 02:32:49 +0200
Message-ID: <2337211.N3hLRRcU3d@pink>
References: <2384594.RyRtmbhCrj@pink> <2205053.ll7fhHWnZQ@pink> <20150221225728.2944c76a@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150221225728.2944c76a@neptune.home>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Bruno Premont <bonbons@linux-vserver.org>
List-Id: linux-input@vger.kernel.org

On Saturday 21 February 2015 22:57:28 Bruno Pr=E9mont wrote:
> On Sat, 21 February 2015 Ciprian Ciubotariu <cheepeero@gmx.net> wrote=
:
> > > On Sun, 15 Feb 2015 23:17:27 +0200 Ciprian Ciubotariu wrote:
> > > Did you check for older work on Logitech keyboards that has been
> > > proposed on linux-input list some time ago and what is currently
> > > present in Linus' tree?
> >=20
> > Yes, I have checked the tree. The mailing list archives recorded so=
me
> > related activity in 2010, but no patches were applied to the kernel=
 tree.
>=20
> Reviewing the work that happened back then and at least considering t=
he
> comments made at that time will help you get the code into a better s=
hape.
>=20
> That's about the time when I wrote picolcd driver, using the proposed
> Logitech driver as a starting point.
>=20
> > > An overview of the features covered by the drivers would help
> > > understand what the new drivers add (and the differences between =
all
> > > the covered keyboard variants).
> >=20
> > I. From the user perspective, all G-series keyboards have
> >=20
> >     (1) A set of "macro" keys and a set of support keys (macro set
> >     selection,
> >=20
> > menu navigation and such).
> >=20
> >     (2) Some devices present an LCD, which is either monochrome or =
color.
> >    =20
> >     (3) All have LEDs that allow changing the (3a) keyboard illumin=
ation
> >=20
> > intensity and color, (3b) the backlight of the macro set selection =
keys,
> > as
> > well (3c) as the backlight of the LCD.
> >=20
> > II. Hardware
> >=20
> > The hardware presents these extra keys on a separate USB device. G1=
10 and
> > G19 use a separate endpoint for some of the keys, while other model=
s use
> > just HID reports. All seem to use a custom bit-flag format to repor=
t the
> > key status, but I am not a HID expert - maybe it is standard. Howev=
er,
> > all these keys are dead without these drivers.
> >=20
> > The LEDs are controlled via hid reports, but the calculus of the fi=
elds
> > differs on some models (G110 needs some weird maths).
> >=20
> > The LCD framebuffer can be written to via USB interrupt/bulk endpoi=
nts
> > depending on the model. hid-gfb.c implements the LCD matrix via the
> > kernel's FB API. The LCD backlight can only be controlled independe=
ntly
> > on G19, and is mapped to LED devices by hid-g19.
>=20
> This is rather important information for explaining your choice of sp=
litting
> up the code.
> You may want to extend this, eventually putting it into a file under
> Documentation/
>=20
> Giving a clear overview of how the various features are presented on =
USB/HID
> side for each driver definitely helps.
>=20
> This should also help you decide if unification is reasonable or just
> requires too much glue-code to translate different HW implementations=
=2E

I'll transcribe this to a file.

>=20
> > III. Driver code
> >=20
> > <snip>
> >=20
> > > If you would like to get the drivers merged please create patches
> > > against upstream tree, eventually starting with support for the
> > > keyboard you own, adding support for the other keyboards in separ=
ate
> > > patches.
> > > You could also split your patch based on feature support.
> >=20
> > While I am typing on the G19 right now, I have only tested G110, G1=
3,
> > G15v2
> > and they seem stable. I lack the G15 model, and G510 is not yet wor=
king.
> >=20
> > To summarize, this submission is about devices g110, g13, g15v2 and=
 g19,
> > all tested by me and working.
> >=20
> > I have prepared a patch for the kernel tree, rebased into a single =
commit.
> > I can split it per-device, but I don't know how to split the change=
s to
> > Kconfig, hid-ids.h and hid-core.c so that each patch can be applied
> > independently (because the changes would overlap).
>=20
> Splitting per-device is one way. More interesting for review would be
> splitting by feature:
> - base input driver handling the "dead" keys
> - adding LEDs
> - adding LCD fb/backlight
> - adding other goodies
>=20
> Proposing the patches in a series where later patches depend on previ=
ous
> ones is the normal way of operating.

This would require simulating such a path to the current state of the c=
ode. In=20
reality I inherited the code with all the features, fixed the bugs and=20
refactored it for submission here.

However, see discussion below on the MFD issue. Performing this separat=
ion=20
might make the code quite readable, even as a single patch.

>=20
> > The Kconfig made me wonder if I should (a) activate the dependent c=
ode in
> > the kernel (for instance the FB or LEDS_CLASS etc), or (b) deactiva=
te the
> > feature from the driver and advise users in the help text.
>=20
> For those wanting to trip down their kernels in size having the optio=
n to
> reduce feature set via Kconfig options is welcome.
> If you select dependencies (you can only properly do so when selectin=
g
> config options that have no dependencies) or have your options show
> up/default on them is up to you.
>=20
> > > It might be worth exploring the option to organize the driver(s) =
as a
> > > MFD (multi-function-device) device.
> >=20
> > I have looked at the list of MFD devices with make menuconfig, but =
I have
> > not seen any input devices there. Perhaps a radio, and mostly PMICs=
 of
> > various sorts.
> >=20
> > These are rather HID input devices with some extra custom goodies (=
extra
> > keys, LEDs and LCDs). The implementation is also based on the HID b=
us.
>=20
> If I had to redo picolcd driver now I would give MFD a try.
> When I have enough time to do so I may very well convert it driver.
>=20
> The big advantage I see in MFD drivers is that the separate functions=
 can
> live in their respective areas in kernel code tree so they don't get =
skipped
> when core/class code get API changes.

I see. I can change the driver so that hid-gfb is in drivers/video/fbde=
v. The=20
LEDs vs. input parts are harder to separate, but I can see a hid-gleds.=
c in=20
drivers/leds. Both of them would be hidden though, and used as support =
code=20
from the main driver(s).

However, I cannot follow the reasons to put the main HID driver into=20
drivers/mfd. Wouldn't picolcd break kernel builds if it wouldn't be upd=
ated on=20
core/class API changes? Also, the keyboard device presents itself fully=
=20
functional, as opposed to a PMIC where hardware connectivity determines=
 which=20
features are actually usable.

I also got clarified on how to implement the LCD_BACKLIGHT part for the=
 G19.=20
Thanks for pointing me towards picolcd.

The only question is... do I do all this on my github repository as an =
out-of-
tree module? And next after a while I come back to LKML with a new vers=
ion?

Or do I try to clean the patch for the drivers in this shape and contin=
ue on=20
directly on the kernel tree?

How should I proceed?

Thanks,

Ciprian


>=20
>=20
> Bruno
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

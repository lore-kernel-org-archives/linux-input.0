From: "Joey Lee" <jlee@novell.com>
Subject: Re: [PATCH 2/3] Support enable Acer Launch Manager mode
Date: Sun, 17 Oct 2010 22:53:05 -0600
Message-ID: <4CBC6D61020000230002205F@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
Sender: platform-driver-x86-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: corentin.chary@gmail.com, Takashi Iwai <tiwai@novell.com>, Thomas Renninger <trenn@novell.com>, mjg59@srcf.ucam.org, carlos@strangeworlds.co.uk, jbenc@suse.cz, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry,=20

=E6=96=BC =E6=97=A5=EF=BC=8C2010-10-17 =E6=96=BC 21:07 -0700=EF=BC=8CDm=
itry Torokhov =E6=8F=90=E5=88=B0=EF=BC=9A
> On Sun, Oct 17, 2010 at 08:32:22PM -0600, Joey Lee wrote:
> > Hi Carios,=20
> >=20
> > =E6=96=BC =E4=BA=94=EF=BC=8C2010-10-15 =E6=96=BC 18:11 +0100=EF=BC=8C=
Carlos Corbacho =E6=8F=90=E5=88=B0=EF=BC=9A
> > > On Friday 15 October 2010 09:02:01 Joey Lee wrote:
> > > > > Why would user chose one setup over another? I.e do we really=
 need a
> > > > > module option or maybe we should pick up behavior and stick t=
o it?
> > > >=20
> > > > When Acer notebook ship with Windows, they will preload a userl=
and
> > > > application, the name is Launch Manager, it provide a GUI for e=
nd user
> > > > to change WLAN/BT/3G on/off state.
> > >=20
> > > [...]
> > >=20
> > > > Because the Launch Manager is userland application, so wmi driv=
er only
> > > > can provide the function for it to call and don't have any way =
can
> > > > detect it from kernel module.
> > >=20
> > > Dmitry's point is still valid - why do we want to provide the use=
rspace=20
> > > behaviour? Why not just handle it all in kernel using rfkill?
> > >=20
>=20
> Apparently networkign people is not quite happy with rfkill-input
> behavior and would like to move policy from the kernel into userspace=
=2E
> To tell the truth rfkill-input was never supposed to be the main
> mechanism but rather something that is usable at bootup and then the
> control would be handed off to userspace (if more complex policy is
> needed).
>=20

Yes, currently, we use ioctl to disable the rfkill-input when our
userland rfkill daemon enabled.

http://www.mail-archive.com/devkit-devel@lists.freedesktop.org/msg00858=
=2Ehtml

> >=20
> > Did you mean put the wifi hotkey behavior to acer-wmi driver or any=
 x86
> > laptop driver and implement by using rfkill?
> >=20
> > The wifi hotkey behavior is highly customization and different OEM =
have
> > different behavior. I am not sure put the wifi hotkey rule in kerne=
l is
> > a good idea.
>=20
> OEMs have nothing to do with this, user is the entity that should be =
in
> control.
>=20
> >=20
> > In the future, there need have a userland rfkill policy daemon to
> > replace the rfkill-input module in kernel:
> >=20
> > Documentation/rfkill.txt
> > The rfkill-input will be:
> >  * the deprecated rfkill-input module (an input layer handler, bein=
g
> >    replaced by userspace policy code) and
> >=20
> > And here have a statement in feature-removal-schedule.txt
> > http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;=
a=3Dcommitdiff;h=3Dc64fb01627e24725d1f9d535e4426475a4415753#patch1
> >=20
> > +What:  CONFIG_RFKILL_INPUT
> > +When:  2.6.33
> > +Why:   Should be implemented in userspace, policy daemon.
> > +Who:   Johannes Berg <johannes@sipsolutions.net>
> >=20
> > So, we choice remove rfkill-input then put the logic in x86/platfor=
m
> > driver?
> > A simple question:
> > Userland policy daemon or kernel module, which one we want to put t=
he
> > wifi hotkey behavior implementation?
> >=20
> > > We don't have Launch Manager for Linux, and quite frankly, I hope=
 we never see=20
> > > it - relying on random, vendor specific applications to drive thi=
s kind of=20
> > > functionality is just asking for trouble.
> > >=20
> >=20
> > Acer BIOS team provide the function to OS for disable the EC hehavi=
or,
> > it's available on window, why we hide it on Linux?
> > Either userland daemon or kernel module who want to implement the w=
ifi
> > hotkey behavior, it need enable the launch-manager mode to disable =
the
> > default EC behavior on wifi hotkey.
> >=20
> > If don't want provide the launch-manager mode parameter to userland=
, can
> > we just direct enable it?
> >=20
>=20
> I believe that we simply need to tell EC to keep its hands off RF
> switch. As long as key is properly reported through input layer rfkil=
l
> should be able to control the RF equipment, either via rfkill-input
> in-kernel shortcut or userspace daemon (when it is ready).
>=20

I agree EC don't need touch the RF switch by default, I will contact
with them to discuss.

But,=20
Currently, the Acer BIOS already shipped to world wide, and BIOS guys
give me tThat's why I contribute launch-manager mode patch to here.


Thank's a lot!
Joey Lee

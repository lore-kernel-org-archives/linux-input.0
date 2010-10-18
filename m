From: "Joey Lee" <jlee@novell.com>
Subject: Re: [PATCH 2/3] Support enable Acer Launch Manager mode
Date: Sun, 17 Oct 2010 20:32:22 -0600
Message-ID: <4CBC4C660200002300022008@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
Sender: platform-driver-x86-owner@vger.kernel.org
To: carlos@strangeworlds.co.uk
Cc: corentin.chary@gmail.com, dmitry.torokhov@gmail.com, Takashi Iwai <tiwai@novell.com>, Thomas Renninger <trenn@novell.com>, mjg59@srcf.ucam.org, jbenc@suse.cz, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Carios,=20

=E6=96=BC =E4=BA=94=EF=BC=8C2010-10-15 =E6=96=BC 18:11 +0100=EF=BC=8CCa=
rlos Corbacho =E6=8F=90=E5=88=B0=EF=BC=9A
> On Friday 15 October 2010 09:02:01 Joey Lee wrote:
> > > Why would user chose one setup over another? I.e do we really nee=
d a
> > > module option or maybe we should pick up behavior and stick to it=
?
> >=20
> > When Acer notebook ship with Windows, they will preload a userland
> > application, the name is Launch Manager, it provide a GUI for end u=
ser
> > to change WLAN/BT/3G on/off state.
>=20
> [...]
>=20
> > Because the Launch Manager is userland application, so wmi driver o=
nly
> > can provide the function for it to call and don't have any way can
> > detect it from kernel module.
>=20
> Dmitry's point is still valid - why do we want to provide the userspa=
ce=20
> behaviour? Why not just handle it all in kernel using rfkill?
>=20

Did you mean put the wifi hotkey behavior to acer-wmi driver or any x86
laptop driver and implement by using rfkill?

The wifi hotkey behavior is highly customization and different OEM have
different behavior. I am not sure put the wifi hotkey rule in kernel is
a good idea.

In the future, there need have a userland rfkill policy daemon to
replace the rfkill-input module in kernel:

Documentation/rfkill.txt
The rfkill-input will be:
 * the deprecated rfkill-input module (an input layer handler, being
   replaced by userspace policy code) and

And here have a statement in feature-removal-schedule.txt
http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
commitdiff;h=3Dc64fb01627e24725d1f9d535e4426475a4415753#patch1

+What:  CONFIG_RFKILL_INPUT
+When:  2.6.33
+Why:   Should be implemented in userspace, policy daemon.
+Who:   Johannes Berg <johannes@sipsolutions.net>

So, we choice remove rfkill-input then put the logic in x86/platform
driver?
A simple question:
Userland policy daemon or kernel module, which one we want to put the
wifi hotkey behavior implementation?

> We don't have Launch Manager for Linux, and quite frankly, I hope we =
never see=20
> it - relying on random, vendor specific applications to drive this ki=
nd of=20
> functionality is just asking for trouble.
>=20

Acer BIOS team provide the function to OS for disable the EC hehavior,
it's available on window, why we hide it on Linux?
Either userland daemon or kernel module who want to implement the wifi
hotkey behavior, it need enable the launch-manager mode to disable the
default EC behavior on wifi hotkey.

If don't want provide the launch-manager mode parameter to userland, ca=
n
we just direct enable it?


Thank's a lot!
Joey Lee

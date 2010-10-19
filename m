From: "Joey Lee" <jlee@novell.com>
Subject: Re: [PATCH 2/3] Support enable Acer Launch Manager mode
Date: Tue, 19 Oct 2010 02:09:57 -0600
Message-ID: <4CBDED050200002300022450@novprvlin0050.provo.novell.com>
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

=E6=96=BC =E4=B8=80=EF=BC=8C2010-10-18 =E6=96=BC 08:19 +0100=EF=BC=8CCa=
rlos Corbacho =E6=8F=90=E5=88=B0=EF=BC=9A
> On Monday 18 October 2010 03:32:22 Joey Lee wrote:
> > So, we choice remove rfkill-input then put the logic in x86/platfor=
m
> > driver?
> > A simple question:
> > Userland policy daemon or kernel module, which one we want to put t=
he
> > wifi hotkey behavior implementation?
>=20
> Pass. I really have no opinion on the above, as long as we pick somet=
hing and=20
> stick with it (i.e. not-another-rfkill-rewrite).
>=20
> > > We don't have Launch Manager for Linux, and quite frankly, I hope=
 we
> > > never see it - relying on random, vendor specific applications to=
 drive
> > > this kind of functionality is just asking for trouble.
> >=20
> > Acer BIOS team provide the function to OS for disable the EC hehavi=
or,
> > it's available on window, why we hide it on Linux?
>=20
> As an aside, just because Windows does something is not a good reason=
 to do it=20
> or expose on on Linux if it doesn't make any sense.
>=20

M... We all know the wmi spec is from Microsoft and OEM/ODM base on it
to write their wmi function spec for develop their windows solution.
So, I thought we still need to reference the behavior on windows then d=
o
our desicion on Linux.

Especially Linux kernel response BIOS by _OSI said we are Windows OS.

> > Either userland daemon or kernel module who want to implement the w=
ifi
> > hotkey behavior, it need enable the launch-manager mode to disable =
the
> > default EC behavior on wifi hotkey.
>=20
> When did Acer laptops start doing this then? The behaviour they alway=
s did in=20
> the past was that pressing the wireless/ bluetooth/ 3G button sent ou=
t a=20
> scancode, and is was then the job of something else to catch that (be=
 it=20
> rfkill-input or friends) and for that something else to then toggle t=
he state.
>=20
> Do the current batch of laptops then just 'magically' toggle the stat=
e without=20
> needing rfkill-input?
>=20

I will check when they start to use wmi event to replace the scancode o=
r
maybe Acer ship wmi with different notebook family.
My 0001 patch transfer the wmi event to keycode, so, rfkill-input can
catch the keycode to work.

I agreed Dmitry's suggestion, we just direct enable the launch manager
mode to stop EC touch RF switch. Either use rfkill-input or userland
daemon to control the RF switch, we all need disable the default EC
behavior, it causes sometimes will enable/disalbe wifi/bluetooth switch
twice.

> (And do you actually have contact with someone on the Acer BIOS team?=
 Because=20
> I've never managed to get through to anyone at Acer, so would be inte=
rested to=20
> know).
>=20

Thank's for your suggestion, I will try to check your question.

> > If don't want provide the launch-manager mode parameter to userland=
, can
> > we just direct enable it?
>=20
> Well, my point is more that we should figure out what we want, and th=
en stick=20
> with that. I don't want to add a pointless module paramater that all =
of three=20
> people are ever going to use, and then have to support it working bot=
h ways.
>=20

Like the above, I thought we just direct enable the lanuch manager mode
when acer-wmi driver detected the WMID3 available.


Thank's
Joey Lee

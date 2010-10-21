From: "Joey Lee" <jlee@novell.com>
Subject: Re: [PATCH 2/3] Support enable Acer Launch Manager mode
Date: Wed, 20 Oct 2010 21:35:01 -0600
Message-ID: <4CC04F95020000230002269F@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
Sender: platform-driver-x86-owner@vger.kernel.org
To: carlos@strangeworlds.co.uk
Cc: corentin.chary@gmail.com, dmitry.torokhov@gmail.com, Takashi Iwai <tiwai@novell.com>, Thomas Renninger <trenn@novell.com>, mjg59@srcf.ucam.org, jbenc@suse.cz, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Carlos,=20

=E6=96=BC =E4=BA=8C=EF=BC=8C2010-10-19 =E6=96=BC 02:09 -0600=EF=BC=8CJo=
ey Lee =E6=8F=90=E5=88=B0=EF=BC=9A=20
> > As an aside, just because Windows does something is not a good reas=
on to do it=20
> > or expose on on Linux if it doesn't make any sense.
> >=20
>=20
> M... We all know the wmi spec is from Microsoft and OEM/ODM base on i=
t
> to write their wmi function spec for develop their windows solution.
> So, I thought we still need to reference the behavior on windows then=
 do
> our desicion on Linux.
>=20
> Especially Linux kernel response BIOS by _OSI said we are Windows OS.
>=20
> > > Either userland daemon or kernel module who want to implement the=
 wifi
> > > hotkey behavior, it need enable the launch-manager mode to disabl=
e the
> > > default EC behavior on wifi hotkey.
> >=20
> > When did Acer laptops start doing this then? The behaviour they alw=
ays did in=20
> > the past was that pressing the wireless/ bluetooth/ 3G button sent =
out a=20
> > scancode, and is was then the job of something else to catch that (=
be it=20
> > rfkill-input or friends) and for that something else to then toggle=
 the state.
> >=20
> > Do the current batch of laptops then just 'magically' toggle the st=
ate without=20
> > needing rfkill-input?
> >=20
>=20
> I will check when they start to use wmi event to replace the scancode=
 or
> maybe Acer ship wmi with different notebook family.
> My 0001 patch transfer the wmi event to keycode, so, rfkill-input can
> catch the keycode to work.
>=20
> I agreed Dmitry's suggestion, we just direct enable the launch manage=
r
> mode to stop EC touch RF switch. Either use rfkill-input or userland
> daemon to control the RF switch, we all need disable the default EC
> behavior, it causes sometimes will enable/disalbe wifi/bluetooth swit=
ch
> twice.
>=20
> > (And do you actually have contact with someone on the Acer BIOS tea=
m? Because=20
> > I've never managed to get through to anyone at Acer, so would be in=
terested to=20
> > know).
> >=20
>=20
> Thank's for your suggestion, I will try to check your question.
>=20

After check.
Acer moved to WMI for hotkey function on notebook/netbook from 2010.=20

But if the hotkey have standard scan code (Ex. Volume up/down,
Play/Pause, =C2=A1K), it will keep scan code.


> > > If don't want provide the launch-manager mode parameter to userla=
nd, can
> > > we just direct enable it?
> >=20
> > Well, my point is more that we should figure out what we want, and =
then stick=20
> > with that. I don't want to add a pointless module paramater that al=
l of three=20
> > people are ever going to use, and then have to support it working b=
oth ways.
> >=20
>=20
> Like the above, I thought we just direct enable the lanuch manager mo=
de
> when acer-wmi driver detected the WMID3 available.
>=20

Also check why have default EC "raw" behavior in wifi hotkey before
enable launch manager mode, That's because they want to cover end user
install Windows 98 or other old Windows not support wmi.


Thank's
Joey Lee

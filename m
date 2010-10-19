From: "Joey Lee" <jlee@novell.com>
Subject: Re: [PATCH 2/3] Support enable Acer Launch Manager mode
Date: Mon, 18 Oct 2010 20:48:19 -0600
Message-ID: <4CBDA1A302000023000221AA@novprvlin0050.provo.novell.com>
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

=E6=96=BC =E4=B8=80=EF=BC=8C2010-10-18 =E6=96=BC 01:20 -0700=EF=BC=8CDm=
itry Torokhov =E6=8F=90=E5=88=B0=EF=BC=9A
> On Sun, Oct 17, 2010 at 10:53:05PM -0600, Joey Lee wrote:
> > Hi Dmitry,=20
> >=20
> > =E6=96=BC =E6=97=A5=EF=BC=8C2010-10-17 =E6=96=BC 21:07 -0700=EF=BC=8C=
Dmitry Torokhov =E6=8F=90=E5=88=B0=EF=BC=9A
> > >=20
> > > I believe that we simply need to tell EC to keep its hands off RF
> > > switch. As long as key is properly reported through input layer r=
fkill
> > > should be able to control the RF equipment, either via rfkill-inp=
ut
> > > in-kernel shortcut or userspace daemon (when it is ready).
> > >=20
> >=20
> > I agree EC don't need touch the RF switch by default, I will contac=
t
> > with them to discuss.
> >=20
> > But,=20
> > Currently, the Acer BIOS already shipped to world wide, and BIOS gu=
ys
> > give me tThat's why I contribute launch-manager mode patch to here.
> >=20
>=20
> I understand that certain BIOSes do, by default, toggle the switch. I
> also believe that we want to disable this. The question that still is
> not answered why we need the module option? Why don't we _always_
> tell EC to keep its hands off RF switch?
>=20

=46ully understood, now.

I also agreed direct enable the launch manager mode to tell EC don't
touch RF. It pother any other RF switch implementation, like
rfkill-input or any other userland daemon.


Thank's
Joey Lee

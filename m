From: "Joey Lee" <jlee@novell.com>
Subject: Re: [PATCH 2/3] Support enable Acer Launch Manager mode
Date: Tue, 19 Oct 2010 07:25:53 -0600
Message-ID: <4CBE371102000023000224F1@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
Sender: platform-driver-x86-owner@vger.kernel.org
To: corentin.chary@gmail.com
Cc: dmitry.torokhov@gmail.com, Takashi Iwai <tiwai@novell.com>, Thomas Renninger <trenn@novell.com>, mjg59@srcf.ucam.org, carlos@strangeworlds.co.uk, jbenc@suse.cz, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Corentin,=20

=E6=96=BC =E4=BA=8C=EF=BC=8C2010-10-19 =E6=96=BC 05:15 -0600=EF=BC=8CJo=
ey Lee =E6=8F=90=E5=88=B0=EF=BC=9A
> Hi Corentin,=20
>=20
> =E6=96=BC =E4=BA=8C=EF=BC=8C2010-10-19 =E6=96=BC 12:51 +0200=EF=BC=8C=
Corentin Chary =E6=8F=90=E5=88=B0=EF=BC=9A
> > >> Most of users will want the key to just toggle wlan/bluetooth. B=
ut some of them
> > >> will be happy if they can configure the behavior of the key (cyc=
le, only toggle
> > >> WLAN, etc...)
> > >>
> > >
> > > I thought just direct disable the default EC behavior then leave =
a
> > > userland daemon to control the behavior, it will grab the wifi ke=
y event
> > > then control rfkill state by follow user's customization rules.
> >=20
> > What I'm saying is: I don't really care what's the default behavior=
 is,
> > but if the EC provide a somewhat reliable way to make the key work
> > without any userspace daemon involved, I think we should allow
> > the user to use this mode (even if it's with an obscure module
> > parameter or sysfs file).
> >=20
> > But .. maybe if someone want this default "raw" behavior,
> > he should just not load this module.
> >=20
>=20
> Fully understood, now.
>=20
> Like you siad, we need define a policy for:
>=20
>  - If user want the default "raw" behavior, what do they need to do?
> 	I thought if the wmi driver doesn't load by default, then user=20
>        will get a "raw" behavior.
>=20
But...=20
The wmi driver doesn't just provide the RF switch function, it's also
have other functions like transfer wmi event to key code.

User doesn't load wmi driver will have "raw" RF switch behavior, but
lost other more functions.

>  - If any distro want provide userland solution, how can they disable=
=20
>    the default "raw" behavior?
> 	If anybody want to disable the "raw" behavior, just load the wmi=20
>        driver.
Maybe we still add kernel module parameter?


Thank's
Joey Lee

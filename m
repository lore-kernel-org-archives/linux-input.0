From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/3] Support enable Acer Launch Manager mode
Date: Tue, 19 Oct 2010 08:49:51 -0700
Message-ID: <20101019154951.GA22303@core.coreip.homeip.net>
References: <4CBE371102000023000224F1@novprvlin0050.provo.novell.com>
 <AANLkTi=iVb_sR4tYJ0acjkUzN_jq2tja43kjeHQwTtb8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTi=iVb_sR4tYJ0acjkUzN_jq2tja43kjeHQwTtb8@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: Joey Lee <jlee@novell.com>, Takashi Iwai <tiwai@novell.com>, Thomas Renninger <trenn@novell.com>, mjg59@srcf.ucam.org, carlos@strangeworlds.co.uk, jbenc@suse.cz, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Oct 19, 2010 at 03:28:43PM +0200, Corentin Chary wrote:
> On Tue, Oct 19, 2010 at 3:25 PM, Joey Lee <jlee@novell.com> wrote:
> > Hi Corentin,
> >
> > =E6=96=BC =E4=BA=8C=EF=BC=8C2010-10-19 =E6=96=BC 05:15 -0600=EF=BC=8C=
Joey Lee =E6=8F=90=E5=88=B0=EF=BC=9A
> >> Hi Corentin,
> >>
> >> =E6=96=BC =E4=BA=8C=EF=BC=8C2010-10-19 =E6=96=BC 12:51 +0200=EF=BC=
=8CCorentin Chary =E6=8F=90=E5=88=B0=EF=BC=9A
> >> > >> Most of users will want the key to just toggle wlan/bluetooth=
=2E But some of them
> >> > >> will be happy if they can configure the behavior of the key (=
cycle, only toggle
> >> > >> WLAN, etc...)
> >> > >>
> >> > >
> >> > > I thought just direct disable the default EC behavior then lea=
ve a
> >> > > userland daemon to control the behavior, it will grab the wifi=
 key event
> >> > > then control rfkill state by follow user's customization rules=
=2E
> >> >
> >> > What I'm saying is: I don't really care what's the default behav=
ior is,
> >> > but if the EC provide a somewhat reliable way to make the key wo=
rk
> >> > without any userspace daemon involved, I think we should allow
> >> > the user to use this mode (even if it's with an obscure module
> >> > parameter or sysfs file).

But we already have the in-kernel solution that provides this behavior.
It is called rfkill-input and it is the in-kernel bridge between input
devices that emit KEY_WLAN etc. and rfkill switches. There is no need t=
o
have yet another mechanism (most likely fighting with default in-kernel
one) doing the same thing. So for boxes tat do support this launcher
mode we should simply enable it. _Always_.

And once the userspace manager[s] become standard we can just rely on
their presence. Like right now you can't really live without udev, dbus=
,
etc. if you want to have reasonably behaving box (embedded setups out o=
f
scope here).

> >> >
> >> > But .. maybe if someone want this default "raw" behavior,
> >> > he should just not load this module.
> >> >
> >>
> >> Fully understood, now.
> >>
> >> Like you siad, we need define a policy for:
> >>
> >> =C2=A0- If user want the default "raw" behavior, what do they need=
 to do?
> >> =C2=A0 =C2=A0 =C2=A0 I thought if the wmi driver doesn't load by d=
efault, then user
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0will get a "raw" behavior.
> >>
> > But...
> > The wmi driver doesn't just provide the RF switch function, it's al=
so
> > have other functions like transfer wmi event to key code.
> >
> > User doesn't load wmi driver will have "raw" RF switch behavior, bu=
t
> > lost other more functions.
> >
> >> =C2=A0- If any distro want provide userland solution, how can they=
 disable
> >> =C2=A0 =C2=A0the default "raw" behavior?
> >> =C2=A0 =C2=A0 =C2=A0 If anybody want to disable the "raw" behavior=
, just load the wmi
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0driver.
> > Maybe we still add kernel module parameter?
> >
>=20
> Indeed, I think it would be a good idea to let the user do that.
>=20

And I do not think so for the reasons outlined. We have chosen the
direction already (dictated by the existence of keys not directly
connected withg RF switches) and we should follow through with it, so
all boxes and drivers behave as uniformly as possible.

Thanks.

--=20
Dmitry

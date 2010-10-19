From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/3] Support enable Acer Launch Manager mode
Date: Tue, 19 Oct 2010 09:49:48 -0700
Message-ID: <20101019164947.GB23186@core.coreip.homeip.net>
References: <4CBE371102000023000224F1@novprvlin0050.provo.novell.com>
 <AANLkTi=iVb_sR4tYJ0acjkUzN_jq2tja43kjeHQwTtb8@mail.gmail.com>
 <20101019154951.GA22303@core.coreip.homeip.net>
 <AANLkTi=QT0uktH9F=m+A0n=KhH_uxf-iW8xZCCLHxBXm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTi=QT0uktH9F=m+A0n=KhH_uxf-iW8xZCCLHxBXm@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: Joey Lee <jlee@novell.com>, Takashi Iwai <tiwai@novell.com>, Thomas Renninger <trenn@novell.com>, mjg59@srcf.ucam.org, carlos@strangeworlds.co.uk, jbenc@suse.cz, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Oct 19, 2010 at 06:03:09PM +0200, Corentin Chary wrote:
> On Tue, Oct 19, 2010 at 5:49 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Tue, Oct 19, 2010 at 03:28:43PM +0200, Corentin Chary wrote:
> >> On Tue, Oct 19, 2010 at 3:25 PM, Joey Lee <jlee@novell.com> wrote:
> >> > Hi Corentin,
> >> >
> >> > =E6=96=BC =E4=BA=8C=EF=BC=8C2010-10-19 =E6=96=BC 05:15 -0600=EF=BC=
=8CJoey Lee =E6=8F=90=E5=88=B0=EF=BC=9A
> >> >> Hi Corentin,
> >> >>
> >> >> =E6=96=BC =E4=BA=8C=EF=BC=8C2010-10-19 =E6=96=BC 12:51 +0200=EF=
=BC=8CCorentin Chary =E6=8F=90=E5=88=B0=EF=BC=9A
> >> >> > >> Most of users will want the key to just toggle wlan/blueto=
oth. But some of them
> >> >> > >> will be happy if they can configure the behavior of the ke=
y (cycle, only toggle
> >> >> > >> WLAN, etc...)
> >> >> > >>
> >> >> > >
> >> >> > > I thought just direct disable the default EC behavior then =
leave a
> >> >> > > userland daemon to control the behavior, it will grab the w=
ifi key event
> >> >> > > then control rfkill state by follow user's customization ru=
les.
> >> >> >
> >> >> > What I'm saying is: I don't really care what's the default be=
havior is,
> >> >> > but if the EC provide a somewhat reliable way to make the key=
 work
> >> >> > without any userspace daemon involved, I think we should allo=
w
> >> >> > the user to use this mode (even if it's with an obscure modul=
e
> >> >> > parameter or sysfs file).
> >
> > But we already have the in-kernel solution that provides this behav=
ior.
> > It is called rfkill-input and it is the in-kernel bridge between in=
put
> > devices that emit KEY_WLAN etc. and rfkill switches. There is no ne=
ed to
> > have yet another mechanism (most likely fighting with default in-ke=
rnel
> > one) doing the same thing. So for boxes tat do support this launche=
r
> > mode we should simply enable it. _Always_.
> >
> > And once the userspace manager[s] become standard we can just rely =
on
> > their presence. Like right now you can't really live without udev, =
dbus,
> > etc. if you want to have reasonably behaving box (embedded setups o=
ut of
> > scope here).
> >
> >> >> >
> >> >> > But .. maybe if someone want this default "raw" behavior,
> >> >> > he should just not load this module.
> >> >> >
> >> >>
> >> >> Fully understood, now.
> >> >>
> >> >> Like you siad, we need define a policy for:
> >> >>
> >> >> =C2=A0- If user want the default "raw" behavior, what do they n=
eed to do?
> >> >> =C2=A0 =C2=A0 =C2=A0 I thought if the wmi driver doesn't load b=
y default, then user
> >> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0will get a "raw" behavior.
> >> >>
> >> > But...
> >> > The wmi driver doesn't just provide the RF switch function, it's=
 also
> >> > have other functions like transfer wmi event to key code.
> >> >
> >> > User doesn't load wmi driver will have "raw" RF switch behavior,=
 but
> >> > lost other more functions.
> >> >
> >> >> =C2=A0- If any distro want provide userland solution, how can t=
hey disable
> >> >> =C2=A0 =C2=A0the default "raw" behavior?
> >> >> =C2=A0 =C2=A0 =C2=A0 If anybody want to disable the "raw" behav=
ior, just load the wmi
> >> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0driver.
> >> > Maybe we still add kernel module parameter?
> >> >
> >>
> >> Indeed, I think it would be a good idea to let the user do that.
> >>
> >
> > And I do not think so for the reasons outlined. We have chosen the
> > direction already (dictated by the existence of keys not directly
> > connected withg RF switches) and we should follow through with it, =
so
> > all boxes and drivers behave as uniformly as possible.
> >
>=20
> Then, let's not add this parameter. Anyway the potential user base wh=
o
> may acer-wmi without this mode is probably very low.
>=20
> But I still think that having a parameter to enable this "raw" mode
> would be helpful in some case, for example, "the keycode changed and
> is not yet mapped to KEY_WLAN", or "wimax is not yet supported by
> acer-wmi and there is not (yet) a rfkill interface for it". This woul=
d
> be a quirk mode, only enabled for some very special cases, like
> acpi_osi=3D"Linux" or acpi_backlight=3D"vendor".

I see. I guess I'd rather people reported the issue and we provided the
fix that have them work around the issue (maybe) and we never hearing
about it. This way fix hapepns quicker and work for everyone instead of
only the person discovered the magic option.

I think we discussed it enough, I'll defer to Matthew whether to take
the patch with the switch or the one enabling the mode unconditionally.

Thanks.

--=20
Dmitry

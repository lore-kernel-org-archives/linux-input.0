From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [PATCH 2/3] Support enable Acer Launch Manager mode
Date: Tue, 19 Oct 2010 18:03:09 +0200
Message-ID: <AANLkTi=QT0uktH9F=m+A0n=KhH_uxf-iW8xZCCLHxBXm@mail.gmail.com>
References: <4CBE371102000023000224F1@novprvlin0050.provo.novell.com>
	<AANLkTi=iVb_sR4tYJ0acjkUzN_jq2tja43kjeHQwTtb8@mail.gmail.com>
	<20101019154951.GA22303@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20101019154951.GA22303@core.coreip.homeip.net>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Joey Lee <jlee@novell.com>, Takashi Iwai <tiwai@novell.com>, Thomas Renninger <trenn@novell.com>, mjg59@srcf.ucam.org, carlos@strangeworlds.co.uk, jbenc@suse.cz, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Oct 19, 2010 at 5:49 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Tue, Oct 19, 2010 at 03:28:43PM +0200, Corentin Chary wrote:
>> On Tue, Oct 19, 2010 at 3:25 PM, Joey Lee <jlee@novell.com> wrote:
>> > Hi Corentin,
>> >
>> > =E6=96=BC =E4=BA=8C=EF=BC=8C2010-10-19 =E6=96=BC 05:15 -0600=EF=BC=
=8CJoey Lee =E6=8F=90=E5=88=B0=EF=BC=9A
>> >> Hi Corentin,
>> >>
>> >> =E6=96=BC =E4=BA=8C=EF=BC=8C2010-10-19 =E6=96=BC 12:51 +0200=EF=BC=
=8CCorentin Chary =E6=8F=90=E5=88=B0=EF=BC=9A
>> >> > >> Most of users will want the key to just toggle wlan/bluetoot=
h. But some of them
>> >> > >> will be happy if they can configure the behavior of the key =
(cycle, only toggle
>> >> > >> WLAN, etc...)
>> >> > >>
>> >> > >
>> >> > > I thought just direct disable the default EC behavior then le=
ave a
>> >> > > userland daemon to control the behavior, it will grab the wif=
i key event
>> >> > > then control rfkill state by follow user's customization rule=
s.
>> >> >
>> >> > What I'm saying is: I don't really care what's the default beha=
vior is,
>> >> > but if the EC provide a somewhat reliable way to make the key w=
ork
>> >> > without any userspace daemon involved, I think we should allow
>> >> > the user to use this mode (even if it's with an obscure module
>> >> > parameter or sysfs file).
>
> But we already have the in-kernel solution that provides this behavio=
r.
> It is called rfkill-input and it is the in-kernel bridge between inpu=
t
> devices that emit KEY_WLAN etc. and rfkill switches. There is no need=
 to
> have yet another mechanism (most likely fighting with default in-kern=
el
> one) doing the same thing. So for boxes tat do support this launcher
> mode we should simply enable it. _Always_.
>
> And once the userspace manager[s] become standard we can just rely on
> their presence. Like right now you can't really live without udev, db=
us,
> etc. if you want to have reasonably behaving box (embedded setups out=
 of
> scope here).
>
>> >> >
>> >> > But .. maybe if someone want this default "raw" behavior,
>> >> > he should just not load this module.
>> >> >
>> >>
>> >> Fully understood, now.
>> >>
>> >> Like you siad, we need define a policy for:
>> >>
>> >> =C2=A0- If user want the default "raw" behavior, what do they nee=
d to do?
>> >> =C2=A0 =C2=A0 =C2=A0 I thought if the wmi driver doesn't load by =
default, then user
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0will get a "raw" behavior.
>> >>
>> > But...
>> > The wmi driver doesn't just provide the RF switch function, it's a=
lso
>> > have other functions like transfer wmi event to key code.
>> >
>> > User doesn't load wmi driver will have "raw" RF switch behavior, b=
ut
>> > lost other more functions.
>> >
>> >> =C2=A0- If any distro want provide userland solution, how can the=
y disable
>> >> =C2=A0 =C2=A0the default "raw" behavior?
>> >> =C2=A0 =C2=A0 =C2=A0 If anybody want to disable the "raw" behavio=
r, just load the wmi
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0driver.
>> > Maybe we still add kernel module parameter?
>> >
>>
>> Indeed, I think it would be a good idea to let the user do that.
>>
>
> And I do not think so for the reasons outlined. We have chosen the
> direction already (dictated by the existence of keys not directly
> connected withg RF switches) and we should follow through with it, so
> all boxes and drivers behave as uniformly as possible.
>

Then, let's not add this parameter. Anyway the potential user base who
may acer-wmi without this mode is probably very low.

But I still think that having a parameter to enable this "raw" mode
would be helpful in some case, for example, "the keycode changed and
is not yet mapped to KEY_WLAN", or "wimax is not yet supported by
acer-wmi and there is not (yet) a rfkill interface for it". This would
be a quirk mode, only enabled for some very special cases, like
acpi_osi=3D"Linux" or acpi_backlight=3D"vendor".

--=20
Corentin Chary
http://xf.iksaif.net

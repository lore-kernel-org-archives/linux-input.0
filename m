From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [PATCH 2/3] Support enable Acer Launch Manager mode
Date: Tue, 19 Oct 2010 15:28:43 +0200
Message-ID: <AANLkTi=iVb_sR4tYJ0acjkUzN_jq2tja43kjeHQwTtb8@mail.gmail.com>
References: <4CBE371102000023000224F1@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <4CBE371102000023000224F1@novprvlin0050.provo.novell.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Joey Lee <jlee@novell.com>
Cc: dmitry.torokhov@gmail.com, Takashi Iwai <tiwai@novell.com>, Thomas Renninger <trenn@novell.com>, mjg59@srcf.ucam.org, carlos@strangeworlds.co.uk, jbenc@suse.cz, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Oct 19, 2010 at 3:25 PM, Joey Lee <jlee@novell.com> wrote:
> Hi Corentin,
>
> =E6=96=BC =E4=BA=8C=EF=BC=8C2010-10-19 =E6=96=BC 05:15 -0600=EF=BC=8C=
Joey Lee =E6=8F=90=E5=88=B0=EF=BC=9A
>> Hi Corentin,
>>
>> =E6=96=BC =E4=BA=8C=EF=BC=8C2010-10-19 =E6=96=BC 12:51 +0200=EF=BC=8C=
Corentin Chary =E6=8F=90=E5=88=B0=EF=BC=9A
>> > >> Most of users will want the key to just toggle wlan/bluetooth. =
But some of them
>> > >> will be happy if they can configure the behavior of the key (cy=
cle, only toggle
>> > >> WLAN, etc...)
>> > >>
>> > >
>> > > I thought just direct disable the default EC behavior then leave=
 a
>> > > userland daemon to control the behavior, it will grab the wifi k=
ey event
>> > > then control rfkill state by follow user's customization rules.
>> >
>> > What I'm saying is: I don't really care what's the default behavio=
r is,
>> > but if the EC provide a somewhat reliable way to make the key work
>> > without any userspace daemon involved, I think we should allow
>> > the user to use this mode (even if it's with an obscure module
>> > parameter or sysfs file).
>> >
>> > But .. maybe if someone want this default "raw" behavior,
>> > he should just not load this module.
>> >
>>
>> Fully understood, now.
>>
>> Like you siad, we need define a policy for:
>>
>> =C2=A0- If user want the default "raw" behavior, what do they need t=
o do?
>> =C2=A0 =C2=A0 =C2=A0 I thought if the wmi driver doesn't load by def=
ault, then user
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0will get a "raw" behavior.
>>
> But...
> The wmi driver doesn't just provide the RF switch function, it's also
> have other functions like transfer wmi event to key code.
>
> User doesn't load wmi driver will have "raw" RF switch behavior, but
> lost other more functions.
>
>> =C2=A0- If any distro want provide userland solution, how can they d=
isable
>> =C2=A0 =C2=A0the default "raw" behavior?
>> =C2=A0 =C2=A0 =C2=A0 If anybody want to disable the "raw" behavior, =
just load the wmi
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0driver.
> Maybe we still add kernel module parameter?
>

Indeed, I think it would be a good idea to let the user do that.

--=20
Corentin Chary
http://xf.iksaif.net

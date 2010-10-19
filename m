From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [PATCH 2/3] Support enable Acer Launch Manager mode
Date: Tue, 19 Oct 2010 12:51:36 +0200
Message-ID: <AANLkTi=-FLs6TnTA+e-UWwJ3Zy41ejXXSa5PLXEqzt4x@mail.gmail.com>
References: <4CBE05A602000023000224A1@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <4CBE05A602000023000224A1@novprvlin0050.provo.novell.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Joey Lee <jlee@novell.com>
Cc: dmitry.torokhov@gmail.com, Takashi Iwai <tiwai@novell.com>, Thomas Renninger <trenn@novell.com>, mjg59@srcf.ucam.org, carlos@strangeworlds.co.uk, jbenc@suse.cz, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Oct 19, 2010 at 11:55 AM, Joey Lee <jlee@novell.com> wrote:
> Hi Corentin,
>
> =E6=96=BC =E4=B8=80=EF=BC=8C2010-10-18 =E6=96=BC 09:55 +0200=EF=BC=8C=
Corentin Chary =E6=8F=90=E5=88=B0=EF=BC=9A
>> On Mon, Oct 18, 2010 at 9:19 AM, Carlos Corbacho
>> <carlos@strangeworlds.co.uk> wrote:
>> > On Monday 18 October 2010 03:32:22 Joey Lee wrote:
>> >> So, we choice remove rfkill-input then put the logic in x86/platf=
orm
>> >> driver?
>> >> A simple question:
>> >> Userland policy daemon or kernel module, which one we want to put=
 the
>> >> wifi hotkey behavior implementation?
>> >
>> > Pass. I really have no opinion on the above, as long as we pick so=
mething and
>> > stick with it (i.e. not-another-rfkill-rewrite).
>> >
>> >> > We don't have Launch Manager for Linux, and quite frankly, I ho=
pe we
>> >> > never see it - relying on random, vendor specific applications =
to drive
>> >> > this kind of functionality is just asking for trouble.
>> >>
>> >> Acer BIOS team provide the function to OS for disable the EC heha=
vior,
>> >> it's available on window, why we hide it on Linux?
>> >
>> > As an aside, just because Windows does something is not a good rea=
son to do it
>> > or expose on on Linux if it doesn't make any sense.
>> >
>> >> Either userland daemon or kernel module who want to implement the=
 wifi
>> >> hotkey behavior, it need enable the launch-manager mode to disabl=
e the
>> >> default EC behavior on wifi hotkey.
>> >
>> > When did Acer laptops start doing this then? The behaviour they al=
ways did in
>> > the past was that pressing the wireless/ bluetooth/ 3G button sent=
 out a
>> > scancode, and is was then the job of something else to catch that =
(be it
>> > rfkill-input or friends) and for that something else to then toggl=
e the state.
>> >
>> > Do the current batch of laptops then just 'magically' toggle the s=
tate without
>> > needing rfkill-input?
>> >
>> > (And do you actually have contact with someone on the Acer BIOS te=
am? Because
>> > I've never managed to get through to anyone at Acer, so would be i=
nterested to
>> > know).
>> >
>> >> If don't want provide the launch-manager mode parameter to userla=
nd, can
>> >> we just direct enable it?
>> >
>> > Well, my point is more that we should figure out what we want, and=
 then stick
>> > with that. I don't want to add a pointless module paramater that a=
ll of three
>> > people are ever going to use, and then have to support it working =
both ways.
>> >
>> > -Carlos
>>
>> asus-laptop laptop also has that kind of parameter, but mainly becau=
se
>> the behavior of the toggle key is quite random across models. So we
>> need to set it sometimes.
>>
>> Anyway, I think it's a good thing to have the choice between "handle=
d by
>> hardware/BIOS" and "handled by kernel/userspace", as long as the def=
ault choice
>> is coherent and always works correctly.
>>
>
> I didn't see a good mechanism that was provided by Acer or MSI BIOS t=
o
> set the wifi key behavior like you said in Asus BIOS.
> Their EC just control the RF switch follow a default priority, like:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0wlan on, bt on, 3G on
> =C2=A0 =C2=A0 =C2=A0 =C2=A0wlan on, bt off, 3G off
> =C2=A0 =C2=A0 =C2=A0 =C2=A0...
> =C2=A0 =C2=A0 =C2=A0 =C2=A0wlan off, bt off, 3G off
>
> The logic is not fully the same with different hardware model.
> And,
> As I know, on Windows, they sometimes also disable the default behavi=
or
> because they have something like hotkey manager or launch manager to
> handle it.
>
>> Most of users will want the key to just toggle wlan/bluetooth. But s=
ome of them
>> will be happy if they can configure the behavior of the key (cycle, =
only toggle
>> WLAN, etc...)
>>
>
> I thought just direct disable the default EC behavior then leave a
> userland daemon to control the behavior, it will grab the wifi key ev=
ent
> then control rfkill state by follow user's customization rules.

What I'm saying is: I don't really care what's the default behavior is,
but if the EC provide a somewhat reliable way to make the key work
without any userspace daemon involved, I think we should allow
the user to use this mode (even if it's with an obscure module
parameter or sysfs file).

But .. maybe if someone want this default "raw" behavior,
he should just not load this module.

--=20
Corentin Chary
http://xf.iksaif.net

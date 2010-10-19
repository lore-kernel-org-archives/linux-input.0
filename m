From: "Joey Lee" <jlee@novell.com>
Subject: Re: [PATCH 2/3] Support enable Acer Launch Manager mode
Date: Tue, 19 Oct 2010 03:55:02 -0600
Message-ID: <4CBE05A602000023000224A1@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: corentin.chary@gmail.com
Cc: dmitry.torokhov@gmail.com, Takashi Iwai <tiwai@novell.com>, Thomas Renninger <trenn@novell.com>, mjg59@srcf.ucam.org, carlos@strangeworlds.co.uk, jbenc@suse.cz, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org

Hi Corentin,=20

=E6=96=BC =E4=B8=80=EF=BC=8C2010-10-18 =E6=96=BC 09:55 +0200=EF=BC=8CCo=
rentin Chary =E6=8F=90=E5=88=B0=EF=BC=9A
> On Mon, Oct 18, 2010 at 9:19 AM, Carlos Corbacho
> <carlos@strangeworlds.co.uk> wrote:
> > On Monday 18 October 2010 03:32:22 Joey Lee wrote:
> >> So, we choice remove rfkill-input then put the logic in x86/platfo=
rm
> >> driver?
> >> A simple question:
> >> Userland policy daemon or kernel module, which one we want to put =
the
> >> wifi hotkey behavior implementation?
> >
> > Pass. I really have no opinion on the above, as long as we pick som=
ething and
> > stick with it (i.e. not-another-rfkill-rewrite).
> >
> >> > We don't have Launch Manager for Linux, and quite frankly, I hop=
e we
> >> > never see it - relying on random, vendor specific applications t=
o drive
> >> > this kind of functionality is just asking for trouble.
> >>
> >> Acer BIOS team provide the function to OS for disable the EC hehav=
ior,
> >> it's available on window, why we hide it on Linux?
> >
> > As an aside, just because Windows does something is not a good reas=
on to do it
> > or expose on on Linux if it doesn't make any sense.
> >
> >> Either userland daemon or kernel module who want to implement the =
wifi
> >> hotkey behavior, it need enable the launch-manager mode to disable=
 the
> >> default EC behavior on wifi hotkey.
> >
> > When did Acer laptops start doing this then? The behaviour they alw=
ays did in
> > the past was that pressing the wireless/ bluetooth/ 3G button sent =
out a
> > scancode, and is was then the job of something else to catch that (=
be it
> > rfkill-input or friends) and for that something else to then toggle=
 the state.
> >
> > Do the current batch of laptops then just 'magically' toggle the st=
ate without
> > needing rfkill-input?
> >
> > (And do you actually have contact with someone on the Acer BIOS tea=
m? Because
> > I've never managed to get through to anyone at Acer, so would be in=
terested to
> > know).
> >
> >> If don't want provide the launch-manager mode parameter to userlan=
d, can
> >> we just direct enable it?
> >
> > Well, my point is more that we should figure out what we want, and =
then stick
> > with that. I don't want to add a pointless module paramater that al=
l of three
> > people are ever going to use, and then have to support it working b=
oth ways.
> >
> > -Carlos
>=20
> asus-laptop laptop also has that kind of parameter, but mainly becaus=
e
> the behavior of the toggle key is quite random across models. So we
> need to set it sometimes.
>=20
> Anyway, I think it's a good thing to have the choice between "handled=
 by
> hardware/BIOS" and "handled by kernel/userspace", as long as the defa=
ult choice
> is coherent and always works correctly.
>=20

I didn't see a good mechanism that was provided by Acer or MSI BIOS to
set the wifi key behavior like you said in Asus BIOS.
Their EC just control the RF switch follow a default priority, like:
	wlan on, bt on, 3G on
	wlan on, bt off, 3G off
	...
	wlan off, bt off, 3G off

The logic is not fully the same with different hardware model.
And,=20
As I know, on Windows, they sometimes also disable the default behavior
because they have something like hotkey manager or launch manager to
handle it.

> Most of users will want the key to just toggle wlan/bluetooth. But so=
me of them
> will be happy if they can configure the behavior of the key (cycle, o=
nly toggle
> WLAN, etc...)
>=20

I thought just direct disable the default EC behavior then leave a
userland daemon to control the behavior, it will grab the wifi key even=
t
then control rfkill state by follow user's customization rules.


Thank's
Joey Lee


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: "Joey Lee" <jlee@novell.com>
Subject: Re: acer-wmi: rfkill and bluetooth enabling doesn't work as in
 2.6.37
Date: Thu, 31 Mar 2011 02:09:42 -0600
Message-ID: <4D94D176020000230002AA8A@novprvlin0050.provo.novell.com>
References: <4D79E5230200002300029ADA@novprvlin0050.provo.novell.com>
 <4D8DB372020000230002A653@novprvlin0050.provo.novell.com>
 <20110327170928.GB30244@core.coreip.homeip.net>
 <201103310723.33728.oldium.pro@seznam.cz>
 <AANLkTi=QREK2r6zbvo6RyTNMG4=NCf+kCUWi52ZwjOhS@mail.gmail.com>
 <4D94CD40020000230002AA76@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <4D94CD40020000230002AA76@novprvlin0050.provo.novell.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: oldium.pro@seznam.cz
Cc: davem@davemloft.net, dmitry.torokhov@gmail.com, marcel@holtmann.org, Al Cho <ACho@novell.com>, Gary Lin <GLin@novell.com>, johannes@sipsolutions.net, mjg59@srcf.ucam.org, linux-acpi@vger.kernel.org, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-input@vger.kernel.org

=E6=96=BC =E5=9B=9B=EF=BC=8C2011-03-31 =E6=96=BC 01:51 -0600=EF=BC=8CJo=
ey Lee =E6=8F=90=E5=88=B0=EF=BC=9A
> Hi Old=C5=99ich,=20
>=20
> =E6=96=BC =E5=9B=9B=EF=BC=8C2011-03-31 =E6=96=BC 08:43 +0200=EF=BC=8C=
Old=C5=99ich Jedli=C4=8Dka =E6=8F=90=E5=88=B0=EF=BC=9A
> > Hi Joey Lee,
> >=20
> > 2011/3/31 Old=C5=99ich Jedli=C4=8Dka <oldium.pro@seznam.cz>
> >         Hi Dmitry,
> >        =20
> >         On Sunday 27 March 2011 19:09:29 Dmitry Torokhov wrote:
> >         > On Fri, Mar 25, 2011 at 04:35:46PM -0600, Joey Lee wrote:
> >         > > Thank's for your information, I will look at it.
> >         > >
> >         > > Finally,
> >         > > I borrow a Acer Aspire one ZG8 from Gary, it can reprod=
uce
> >         your
> >         > > situation.
> >         > >
> >         > > The BAD thing is you are right,
> >         > > I CAN REPRODUCE rfkill-input didn't receive any input, =
it
> >         not make sense
> >         > > because rfkill-input registered input handler.
> >         > >
> >         > > The BT HW key still works because acer-wmi have polling=
 to
> >         sync the
> >         > > state with EC and killswitch, and EC also take care the=
 BT
> >         device power
> >         > > off job.
> >         > >
> >         > > But, I also found SOMETIMES after system reboot,
> >         rfkill-input can
> >         > > capture the key event.
> >         > > We need find out why input handle didn't receive KEY_*
> >         event.
> >         > >
> >         > >
> >         > > Hi, Dmitry
> >         > >
> >         > > Appreciate if you can give us any good suggestions!
> >         > > Why keyboard emit KEY_BLUETOOTH, but rfkill-input,
> >         registered input
> >         > > handler, can't capture it?
> >         > >
> >        =20
> >         > > *** 06:32:42.972: lshal: device_condition,
> >         > >
> >         udi=3D/org/freedesktop/Hal/devices/platform_i8042_i8042_KBD=
_port_logicaldev
> >         > > _input
> >         > >
> >         > >            condition_name=3DButtonPressed
> >         > >            condition_details=3Dbluetooth
> >         > >
> >        =20
> >         > > But, SOMETIMES after reboot system, rfkill-input can
> >         capture the key.
> >         > > We are working on 2.6.38 kernel, and Acer notebook.
> >         >
> >         > Hi Joey,
> >         >
> >         > If you look in /proc/bus/input/devices do you see
> >         rfkill-input as
> >         > actually bound to the device that has KEY_BLUETOOTH?
> >         >
> >        =20
> >         > Since it is atkbd that is emitting KEY_BLUETOOTH and this
> >         key is not in
> >         > the default keymap I think you must be loading Acer-speci=
fic
> >         keymap via
> >         > udev or some other mechanism, and I guess stumbling upon =
a
> >         deficiency in
> >         > input layer: we do not re-match devices after changing
> >         keymap. So if
> >         > rfkill-input was loaded before keymap was altered, then i=
t
> >         will not bind
> >         > to the keyboard even if you add KE_BLUETOOTH at a later
> >         time. Fixing
> >         > this is something that was on my TODO list for a while
> >         now...
> >        =20
> >        =20
> >         Verified - I tried to compile rfkill as module as you
> >         recommended (on personal
> >         e-mail). I had to reload rfkill after startup to have rfkil=
l
> >         listening. So
> >         this part looks clear on what happens.
> >        =20
> >         @Joey Lee: There are other strange situations when I have
> >         rfkill as a module
> >         and don't have acer-wmi loaded (every second try hci0 rfkil=
l
> >         is blocked, the
> >         other try it is unblocked) and more strange situation is wh=
en
> >         acer-wmi gets
> >         loaded (accidentally I've tried it when the BT hci0 was up =
and
> >         running) - the
> >         BT switch brings hci0 to light after the second press (no
> >         action on the first
> >         one), next press switched it off. I was able to reproduce b=
oth
> >         "problems"
> >         several times with no randomness> > Sorry, that was probabl=
y caused by the fact that the bluetooth
> > on-to-off scancode isn't mapped correctly (0xD9 emits brightness-up
> > instead of bluetooth). I have the updated keymap already, but it
> > doesn't get loaded automatically cu> this was also the case during =
my tests. I will try it with the correct
> > keymap later too.
> >=20
> > Cheers,
> > Old=C5=99ich.
> > =20
>=20
> Yes, I just also simply try, the EC emit key priority is:
> 	KEY_BLUETOOTH
> 	KEY_BRIGHTNESSUP
> 	KEY_BLUETOOTH
> 	KEY_BLUETOOTH
>=20
> You are right, maybe the keymaping have problem on speciall acer
> notebook, I will also try.
>=20
>=20
> Thank's
> Joey Lee
>=20

Set 0xD9=3Dbluetooth in udev keymap works fine to me both on acer-wmi
probe or not.
But, on my Acer AspireOne ZG8, there have no product name in
dmidecode...


Thank's
Joey Lee

> >         Cheers,
> >         Old=C5=99ich.
> >        =20
> >         >
> >         > Thaks.
> >=20
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe platform-dr=
iver-x86" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: =?utf-8?q?Old=C5=99ich_Jedli=C4=8Dka?= <oldium.pro@seznam.cz>
Subject: Re: acer-wmi: rfkill and bluetooth enabling doesn't work as in 2.6.37
Date: Thu, 31 Mar 2011 22:27:35 +0200
Message-ID: <201103312227.36054.oldium.pro@seznam.cz>
References: <4D79E5230200002300029ADA@novprvlin0050.provo.novell.com> <4D94D176020000230002AA8A@novprvlin0050.provo.novell.com> <4D94DFC9020000230002AAAA@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <4D94DFC9020000230002AAAA@novprvlin0050.provo.novell.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Joey Lee <jlee@novell.com>
Cc: davem@davemloft.net, dmitry.torokhov@gmail.com, marcel@holtmann.org, Al Cho <ACho@novell.com>, Gary Lin <GLin@novell.com>, johannes@sipsolutions.net, mjg59@srcf.ucam.org, linux-acpi@vger.kernel.org, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Joey Lee,

On Thursday 31 March 2011 11:10:49 Joey Lee wrote:
> Hi Old=C5=99ich,
>=20
> =E6=96=BC =E5=9B=9B=EF=BC=8C2011-03-31 =E6=96=BC 02:09 -0600=EF=BC=8C=
Joey Lee =E6=8F=90=E5=88=B0=EF=BC=9A
>=20
> > =E6=96=BC =E5=9B=9B=EF=BC=8C2011-03-31 =E6=96=BC 01:51 -0600=EF=BC=8C=
Joey Lee =E6=8F=90=E5=88=B0=EF=BC=9A
> >=20
> > > Hi Old=C5=99ich,
> > >=20
> > > =E6=96=BC =E5=9B=9B=EF=BC=8C2011-03-31 =E6=96=BC 08:43 +0200=EF=BC=
=8COld=C5=99ich Jedli=C4=8Dka =E6=8F=90=E5=88=B0=EF=BC=9A
> > >=20
> > > > Hi Joey Lee,
> > > >=20
> > > > 2011/3/31 Old=C5=99ich Jedli=C4=8Dka <oldium.pro@seznam.cz>
> > > >=20
> > > >         Hi Dmitry,
> > > >        =20
> > > >         On Sunday 27 March 2011 19:09:29 Dmitry Torokhov wrote:
> > > >         > On Fri, Mar 25, 2011 at 04:35:46PM -0600, Joey Lee wr=
ote:
> > > >         > > Thank's for your information, I will look at it.
> > > >         > >=20
> > > >         > > Finally,
> > > >         > > I borrow a Acer Aspire one ZG8 from Gary, it can
> > > >         > > reproduce
> > > >        =20
> > > >         your
> > > >        =20
> > > >         > > situation.
> > > >         > >=20
> > > >         > > The BAD thing is you are right,
> > > >         > > I CAN REPRODUCE rfkill-input didn't receive any inp=
ut, it
> > > >        =20
> > > >         not make sense
> > > >        =20
> > > >         > > because rfkill-input registered input handler.
> > > >         > >=20
> > > >         > > The BT HW key still works because acer-wmi have pol=
ling
> > > >         > > to
> > > >        =20
> > > >         sync the
> > > >        =20
> > > >         > > state with EC and killswitch, and EC also take care=
 the
> > > >         > > BT
> > > >        =20
> > > >         device power
> > > >        =20
> > > >         > > off job.
> > > >         > >=20
> > > >         > > But, I also found SOMETIMES after system reboot,
> > > >        =20
> > > >         rfkill-input can
> > > >        =20
> > > >         > > capture the key event.
> > > >         > > We need find out why input handle didn't receive KE=
Y_*
> > > >        =20
> > > >         event.
> > > >        =20
> > > >         > > Hi, Dmitry
> > > >         > >=20
> > > >         > > Appreciate if you can give us any good suggestions!
> > > >         > > Why keyboard emit KEY_BLUETOOTH, but rfkill-input,
> > > >        =20
> > > >         registered input
> > > >        =20
> > > >         > > handler, can't capture it?
> > > >         > >=20
> > > >         > >=20
> > > >         > > *** 06:32:42.972: lshal: device_condition,
> > > >        =20
> > > >         udi=3D/org/freedesktop/Hal/devices/platform_i8042_i8042=
_KBD_por
> > > >         t_logicaldev
> > > >        =20
> > > >         > > _input
> > > >         > >=20
> > > >         > >            condition_name=3DButtonPressed
> > > >         > >            condition_details=3Dbluetooth
> > > >         > >=20
> > > >         > > But, SOMETIMES after reboot system, rfkill-input ca=
n
> > > >        =20
> > > >         capture the key.
> > > >        =20
> > > >         > > We are working on 2.6.38 kernel, and Acer notebook.
> > > >         >=20
> > > >         > Hi Joey,
> > > >         >=20
> > > >         > If you look in /proc/bus/input/devices do you see
> > > >        =20
> > > >         rfkill-input as
> > > >        =20
> > > >         > actually bound to the device that has KEY_BLUETOOTH?
> > > >         >=20
> > > >         >=20
> > > >         > Since it is atkbd that is emitting KEY_BLUETOOTH and =
this
> > > >        =20
> > > >         key is not in
> > > >        =20
> > > >         > the default keymap I think you must be loading
> > > >         > Acer-specific
> > > >        =20
> > > >         keymap via
> > > >        =20
> > > >         > udev or some other mechanism, and I guess stumbling u=
pon a
> > > >        =20
> > > >         deficiency in
> > > >        =20
> > > >         > input layer: we do not re-match devices after changin=
g
> > > >        =20
> > > >         keymap. So if
> > > >        =20
> > > >         > rfkill-input was loaded before keymap was altered, th=
en it
> > > >        =20
> > > >         will not bind
> > > >        =20
> > > >         > to the keyboard even if you add KE_BLUETOOTH at a lat=
er
> > > >        =20
> > > >         time. Fixing
> > > >        =20
> > > >         > this is something that was on my TODO list for a whil=
e
> > > >        =20
> > > >         now...
> > > >        =20
> > > >        =20
> > > >         Verified - I tried to compile rfkill as module as you
> > > >         recommended (on personal
> > > >         e-mail). I had to reload rfkill after startup to have r=
fkill
> > > >         listening. So
> > > >         this part looks clear on what happens.
> > > >        =20
> > > >         @Joey Lee: There are other strange situations when I ha=
ve
> > > >         rfkill as a module
> > > >         and don't have acer-wmi loaded (every second try hci0 r=
fkill
> > > >         is blocked, the
> > > >         other try it is unblocked) and more strange situation i=
s when
> > > >         acer-wmi gets
> > > >         loaded (accidentally I've tried it when the BT hci0 was=
 up
> > > >         and r> > >         BT switch brings hci0 to light after=
 the
> > > >         second press (no action on the first
> > > >         one), next press switched it off. I was able to reprodu=
ce
> > > >         both "problems"
> > > >         several times with no randomness> > Sorry, that was pro=
bably
> > > >         caused by the fact that the bluetooth
> > > >=20
> > > > on-to-off scancode isn't mapped correctly (0xD9 emits brightnes=
s-up
> > > > instead of bluetooth). I have the updated keymap already, but i=
t
> > > > doesn't get loaded automatically cu> this was also the case dur=
ing my
> > > > tests. I will try it with the correct keymap later too.
> > > >=20
> > > > Cheers,
> > > > Old=C5=99ich.
> > >=20
> > > Yes, I just also simply try, the EC emit key priority is:
> > > 	KEY_BLUETOOTH
> > > 	KEY_BRIGHTNESSUP
> > > 	KEY_BLUETOOTH
> > > 	KEY_BLUETOOTH
> > >=20
> > > You are right, maybe the keymaping have problem on speciall acer
> > > notebook, I will also try.
> > >=20
> > >=20
> > > Thank's
> > > Joey Lee
> >=20
> > Set 0xD9=3Dbluetooth in udev keymap works fine to me both on acer-w=
mi
> > probe or not.
> > But, on my Acer AspireOne ZG8, there have no product name in
> > dmidecode...
>=20
> OK, confirm acer-aspire_5720 keymap works fine on my ZG8. I added the
> following rule to /lib/udev/rules.d/95-keymap.rules:
>=20
> ENV{DMI_VENDOR}=3D=3D"Acer*", ATTR{[dmi/id]product_serial}=3D=3D"ZG8*=
",
> RUN+=3D"keymap $name acer-aspire_5720"
>=20
> I will send patch to udev group. But I am not sure acer-aspire_5720 k=
eymap
> also works to you:
>
> 0x84 bluetooth  # sent when bluetooth module missing, and key pressed
> 0x92 media      # acer arcade
> 0xD4 bluetooth  # bluetooth on
> 0xD9 bluetooth  # bluetooth off

Yes, that would work. I've sent already keymap to linux-hotplug mailing=
 list=20
(with a note to update the meanings to be in-line with other keymaps):

0xD9 bluetooth # (toggle) off-to-on                                    =
                                             =20
0xF1 touchpad_on # (toggle) off-to-on                                  =
                                             =20
0xF2 touchpad_off # (toggle) on-to-off                                 =
                                             =20
0xF9 connect # Sync                                                    =
                                             =20
0xEE screenlock # Lock                                                 =
                                             =20

My keymap problem was caused by started `hald`, which reset the keymap =
to some=20
bad one. I've removed hald from startup and the keys are mapped well no=
w. Also=20
the starting of bluetooth with BT HW button works as expected now.

> Do you need me help to send out patch to udev group for your machine?

Thanks, not necessary.

Cheers,
Old=C5=99ich.

>=20
> Thank's
> Joey Lee
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

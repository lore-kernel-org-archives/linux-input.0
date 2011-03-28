From: "Joey Lee" <jlee@novell.com>
Subject: Re: acer-wmi: rfkill and bluetooth enabling doesn't work as in
 2.6.37
Date: Mon, 28 Mar 2011 02:51:52 -0600
Message-ID: <4D90E6D8020000230002A7E1@novprvlin0050.provo.novell.com>
References: <4D79E5230200002300029ADA@novprvlin0050.provo.novell.com>
 <201103242234.03598.oldium.pro@seznam.cz>
 <4D8CE950020000230002A5DA@novprvlin0050.provo.novell.com>
 <201103252022.26766.oldium.pro@seznam.cz>
 <4D8DB372020000230002A653@novprvlin0050.provo.novell.com>
 <20110327170928.GB30244@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20110327170928.GB30244@core.coreip.homeip.net>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: davem@davemloft.net, marcel@holtmann.org, Al Cho <ACho@novell.com>, Gary Lin <GLin@novell.com>, oldium.pro@seznam.cz, johannes@sipsolutions.net, mjg59@srcf.ucam.org, linux-acpi@vger.kernel.org, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org

Hi Dmitry,

=E6=96=BC =E6=97=A5=EF=BC=8C2011-03-27 =E6=96=BC 10:09 -0700=EF=BC=8CDm=
itry Torokhov =E6=8F=90=E5=88=B0=EF=BC=9A
> On Fri, Mar 25, 2011 at 04:35:46PM -0600, Joey Lee wrote:
> >=20
> > Thank's for your information, I will look at it.
> >=20
> > Finally,
> > I borrow a Acer Aspire one ZG8 from Gary, it can reproduce your
> > situation.
> >=20
> > The BAD thing is you are right,=20
> > I CAN REPRODUCE rfkill-input didn't receive any input, it not make =
sense
> > because rfkill-input registered input handler.
> >=20
> > The BT HW key still works because acer-wmi have polling to sync the
> > state with EC and killswitch, and EC also take care the BT device p=
ower
> > off job.
> >=20
> > But, I also found SOMETIMES after system reboot, rfkill-input can
> > capture the key event.
> > We need find out why input handle didn't receive KEY_* event.
> >=20
> >=20
> > Hi, Dmitry=20
> >=20
> > Appreciate if you can give us any good suggestions!
> > Why keyboard emit KEY_BLUETOOTH, but rfkill-input, registered input
> > handler, can't capture it?
> >=20
> > *** 06:32:42.972: lshal: device_condition,
> > udi=3D/org/freedesktop/Hal/devices/platform_i8042_i8042_KBD_port_lo=
gicaldev_input
> >            condition_name=3DButtonPressed
> >            condition_details=3Dbluetooth
> >=20
> > But, SOMETIMES after reboot system, rfkill-input can capture the ke=
y.
> > We are working on 2.6.38 kernel, and Acer notebook.
>=20
> Hi Joey,
>=20
> If you look in /proc/bus/input/devices do you see rfkill-input as
> actually bound to the device that has KEY_BLUETOOTH?
>=20

Like you said, we fell into the trap:

=46ail case:

linux-uy92:/proc/bus/input # vi devices

I: Bus=3D0011 Vendor=3D0001 Product=3D0001 Version=3Dab41
N: Name=3D"AT Translated Set 2 keyboard"
P: Phys=3Disa0060/serio0/input0
S: Sysfs=3D/devices/platform/i8042/serio0/input/input0
U: Uniq=3D
H: Handlers=3Dsysrq kbd event0
B: PROP=3D0
B: EV=3D120013
B: KEY=3D10000 c0200 0 0 0 0 0 700f 2000003 3803078 f830f401 febfffdf f=
fefffff ffffffff fffffffe
B: MSC=3D10
B: LED=3D7


Success case:

linux-uy92:/proc/bus/input # vi devices=20

I: Bus=3D0011 Vendor=3D0001 Product=3D0001 Version=3Dab41
N: Name=3D"AT Translated Set 2 keyboard"
P: Phys=3Disa0060/serio0/input0
S: Sysfs=3D/devices/platform/i8042/serio0/input/input0
U: Uniq=3D
H: Handlers=3Dsysrq kbd event0 rfkill
B: PROP=3D0
B: EV=3D120013
B: KEY=3D10000 c0200 0 0 0 0 0 700f 2000003 3803078 f830f401 febfffdf f=
fefffff ffffffff fffffffe
B: MSC=3D10
B: LED=3D7


In fail case, rfkill didn't register to keyboard's Handlers. And, I als=
o
checked the rfkill-input's .connect didn't call by input when system
boot:

=46ail case:

[    7.144252] rfkill: rfkill_handler_init
[    7.144277] rfkill: rfkill_handler_init, start input_register_handle=
r


Success case:

[    7.580683] rfkill: rfkill_handler_init
[    7.580714] rfkill: rfkill_handler_init, start input_register_handle=
r
[    7.580737] rfkill: doing input_register_handle

> Since it is atkbd that is emitting KEY_BLUETOOTH and this key is not =
in
> the default keymap I think you must be loading Acer-specific keymap v=
ia
> udev or some other mechanism, and I guess stumbling upon a deficiency=
 in
> input layer: we do not re-match devices after changing keymap. So if
> rfkill-input was loaded before keymap was altered, then it will not b=
ind
> to the keyboard even if you add KE_BLUETOOTH at a later time. Fixing
> this is something that was on my TODO list for a while now...
>=20
> Thaks.
>=20

Yes,
this a race condition for rfkill-input register before udev set
Acer-specific keymap.=20

We didn't find it just because old acer-wmi driver hide the BIOS defaul=
t
devices states and always set bluetooth state to enabled when system
boot.


Thank's
Joey Lee

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

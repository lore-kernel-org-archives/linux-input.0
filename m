From: =?windows-1250?q?Old=F8ich_Jedli=E8ka?= <oldium.pro@seznam.cz>
Subject: Re: acer-wmi: rfkill and bluetooth enabling doesn't work as in 2.6.37
Date: Thu, 31 Mar 2011 07:23:33 +0200
Message-ID: <201103310723.33728.oldium.pro@seznam.cz>
References: <4D79E5230200002300029ADA@novprvlin0050.provo.novell.com> <4D8DB372020000230002A653@novprvlin0050.provo.novell.com> <20110327170928.GB30244@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=windows-1250
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20110327170928.GB30244@core.coreip.homeip.net>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Joey Lee <jlee@novell.com>, davem@davemloft.net, marcel@holtmann.org, Al Cho <ACho@novell.com>, Gary Lin <GLin@novell.com>, johannes@sipsolutions.net, mjg59@srcf.ucam.org, linux-acpi@vger.kernel.org, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

On Sunday 27 March 2011 19:09:29 Dmitry Torokhov wrote:
> On Fri, Mar 25, 2011 at 04:35:46PM -0600, Joey Lee wrote:
> > Thank's for your information, I will look at it.
> >=20
> > Finally,
> > I borrow a Acer Aspire one ZG8 from Gary, it can reproduce your
> > situation.
> >=20
> > The BAD thing is you are right,
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
> > Hi, Dmitry
> >=20
> > Appreciate if you can give us any good suggestions!
> > Why keyboard emit KEY_BLUETOOTH, but rfkill-input, registered input
> > handler, can't capture it?
> >=20
> > *** 06:32:42.972: lshal: device_condition,
> > udi=3D/org/freedesktop/Hal/devices/platform_i8042_i8042_KBD_port_lo=
gicaldev
> > _input
> >=20
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

Verified - I tried to compile rfkill as module as you recommended (on p=
ersonal=20
e-mail). I had to reload rfkill after startup to have rfkill listening.=
 So=20
this part looks clear on what happens.

@Joey Lee: There are other strange situations when I have rfkill as a m=
odule=20
and don't have acer-wmi loaded (every second try hci0 rfkill is blocked=
, the=20
other try it is unblocked) and more strange situation is when acer-wmi =
gets=20
loaded (accidentally I've tried it when the BT hci0 was up and running)=
 - the=20
BT switch brings hci0 to light after the second press (no action on the=
 first=20
one), next press switched it off. I was able to reproduce both "problem=
s"=20
several times with no randomness in it.

Cheers,
Old=F8ich.

>=20
> Thaks.

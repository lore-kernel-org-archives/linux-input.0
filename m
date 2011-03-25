From: "Joey Lee" <jlee@novell.com>
Subject: Re: acer-wmi: rfkill and bluetooth enabling doesn't work as in
 2.6.37
Date: Fri, 25 Mar 2011 16:35:46 -0600
Message-ID: <4D8DB372020000230002A653@novprvlin0050.provo.novell.com>
References: <4D79E5230200002300029ADA@novprvlin0050.provo.novell.com>
 <201103242234.03598.oldium.pro@seznam.cz>
 <4D8CE950020000230002A5DA@novprvlin0050.provo.novell.com>
 <201103252022.26766.oldium.pro@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <201103252022.26766.oldium.pro@seznam.cz>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, oldium.pro@seznam.cz
Cc: davem@davemloft.net, marcel@holtmann.org, Al Cho <ACho@novell.com>, Gary Lin <GLin@novell.com>, johannes@sipsolutions.net, mjg59@srcf.ucam.org, linux-acpi@vger.kernel.org, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org

Removed bluetooth kernel mail for this issue not actually related to
bluetooth.
Added Dmitry Torokhov and linux-input@vger.kernel.org

Hi Old=C5=99ich,

=E6=96=BC =E4=BA=94=EF=BC=8C2011-03-25 =E6=96=BC 20:22 +0100=EF=BC=8COl=
d=C5=99ich Jedli=C4=8Dka =E6=8F=90=E5=88=B0=EF=BC=9A
> Hi Joey Lee,
>=20
> On Friday 25 March 2011 09:13:20 Joey Lee wrote:
> > Hi Old=C5=99ich,
> >=20
> > Per our log.
> > It's a interesting and weird situation.
> >=20
> > Your log subvert my assumption, the BT HW key only emit one
> > KEY_BLUETOOTH from ec but not from acer-wmi.
> >=20
> > =E6=96=BC =E5=9B=9B=EF=BC=8C2011-03-24 =E6=96=BC 22:34 +0100=EF=BC=8C=
Old=C5=99ich Jedli=C4=8Dka =E6=8F=90=E5=88=B0=EF=BC=9A
> >=20
> > > Hi Joey Lee,
> > >=20
> > > I've done some experiments, here are the results.
> > >=20
> > > On Thursday 24 March 2011 14:13:29 Joey Lee wrote:
> > > > Hi Old=C5=99ich,
> > > >=20
> > > > Sorry bother you again, but after discuss with Johannes, he rem=
ind me
> > > > one import thing: maybe your BT HW key emit scancode and wmi ev=
ent at
> > > > the same time.
> > > >=20
> > > > =E6=96=BC =E5=9B=9B=EF=BC=8C2011-03-24 =E6=96=BC 09:36 +0100=EF=
=BC=8CJohannes Berg =E6=8F=90=E5=88=B0=EF=BC=9A
> > > >=20
> > > > > Hi Old=C5=99ich,
> > > > >=20
> > > > > > > Ah. So I guess when hci0 gets registered, the acer rfkill=
 state
> > > > > > > hasn't been updated yet, hence registering hci0 as blocke=
d.
> > > > > >=20
> > > > > > No, that is not the case. I can play with `rfkill list` imm=
ediately
> > > > > > after I press the HW bluetooth switch and show that hci0 is=
 not
> > > > > > there (still unregistered) while acer-bluetooth is already
> > > > > > "unblocked" - I've tried to run `rfkill list` repeatedly ma=
nually
> > > > > > from console immediately after I pressed the HW BT switch a=
nd
> > > > > > acer-bluetooth was "unblocked" several runs while the hci0 =
wasn't
> > > > > > there. When hci0 appeared, it was "blocked".
> > > > > >=20
> > > > > > As I wrote, I didn't find anything changing the global stat=
e, which
> > > > > > is actually used to "block" the newly appearing hci0 (in th=
e
> > > > > > rfkill_sync_work method). It looks like the global state is=
 just
> > > > > > "blocked" forever - and it is "blocked" as a side-effect of=
 the
> > > > > > call to rfkill_init_sw_state (changes permanent=3Dtrue) and=
 then
> > > > > > call to rfkill_register from the acer-wmi driver. I can ver=
ify
> > > > > > this in the following days (that the global state stays the=
 same
> > > > > > all the time).
> > > > >=20
> > > > > Well the global state would be changed by the KEY_BLUETOOTH i=
nput
> > > > > event.
> > > > >=20
> > > > > But like I said, it's tricky in this case because multiple ev=
ents
> > > > > come from the same event source and race against each other.
> > > > >=20
> > > > > johannes
> > > >=20
> > > > My Acer TravelMate 8572 is commercial notebook, it only emit wm=
i event
> > > > when press wifi key. But, as I remember, there have some acer c=
onsumer
> > > > notebook emit both scancode and wmi event.
> > > >=20
> > > > New acer-wmi driver will transfer wmi event to keycode (e.g.
> > > > KEY_BLUETOOTH), if EC also emit KEY_BLUETOOTH, the rfkill-input=
 will
> > > >=20
> > > > receive the key events twice, that means:
> > > > 	global BT block (when system boot) -> BT unblock (from EC scan=
code)=20
> ->
> > > > 	BT
> > > >=20
> > > > block (from acer-wmi)
> > > >=20
> > > > Could you please help me to check?
> > > >=20
> > > > 	- If your distro still have HAL, please run:
> > > > 		+ lshal -l -m
> > > > 		+ press BT HW key 1 time
> > > > 		then check does HAL receive KEY_BLUETOOTH twice?
> > >=20
> > > I didn't uninstall hal yet, so the output of `lshal -l -m` (only =
the
> > > monitoring part) when I press once BT HW key is attached. I've al=
so
> > > patched the kernel to have more debug logging (see the attached d=
iff and
> > > log) and the result is that the handler method from rfkill/input.=
c is
> > > not called, the global state is once set to "blocked" and it keep=
s like
> > > that. I don't know why the rfkill_event isn't called when I press=
 the HW
> > > BT switch, it could be part of my investigations in the following=
 days.
> > >=20
> > > I've attached .config too, if you want to check that I missed som=
ething
> > > that is needed by Acer WMI.
> > >=20
> > > Cheers,
> > > Old=C5=99ich.
> >=20
> > Per your lshal log, looks like HAL only receive the key event from =
EC
> > but didn't have key event from acer-wmi:
> >=20
> > *** 22:21:01.310: lshal: device_condition,
> > udi=3D/org/freedesktop/Hal/devices/platform_i8042_i8042_KBD_port_lo=
gicaldev_i
> > nput condition_name=3DButtonPressed
> >            condition_details=3Dbluetooth			//it's from standard=20
> input
> >=20
> > *** 22:21:02.076: lshal: property_modified,
> > udi=3D/org/freedesktop/Hal/devices/platform_acer_wmi_rfkill_acer_bl=
uetooth_bl
> > uetooth, key=3Dkillswitch.state is_removed=3Dfalse, is_added=3Dfals=
e
> > *** new value: 1 (0x1)  (int)				//UNBLOCK when you press BT HW=20
> key
> >=20
> >=20
> > So, there have only one KEY_BLUETOOTH from ec, acer-wmi didn't emit=
 it. I
> > thought your machine didn't support Acer ACPI event GUIDs. Please d=
ump the
> > dsdt to me, thank's: acpidump > acpidump.dat
> >=20
> > Then, if there only have one KEY_BLUETOOTH, why the global BT state=
 didn't
> > change by rfill-input? Technically, rfkill-input must receive this =
key
> > then change global state:
> >=20
> > your situation:
> > 		initial		press HW key
> > acer-wmi	BLOCK		UNBLOCK (changed by acer-wmi polling)
> > global		BLOCK		 BLOCK (why didn't changed by rfkill-input?)
> > hci0		none		 BLOCK (replicate from global)
> >=20
> > Like you said, the odd thing is:
> > 	"Why rfkill-input didn't receive KEY_BLUEOOTH from ec on your mach=
ine?"
> >=20
> > We need find out root cause, but I thought my last patch still work=
s to fix
> > your situation and it make sense for Acer BIOS didn't really persis=
tence
> > devices state.
> >=20
> > applied my patch:
> > 		initial		press HW key
> > acer-wmi	BLOCK		UNBLOCK (changed by acer-wmi polling)
> > global		UNBLOCK		UNBLOCK (didn't changed by rfkill-input?)
> > hci0		none		 UNBLOCK (replicate from global)
> >=20
> >=20
> > Conclusion...
> > please kindly help to provide the following information:
> >=20
> >  - Please provide DSDT to me
> >  	+ I want to double check your BIOS didn't support acer wmi event.
> >=20
> >  - Why rfkill-input didn't call by BT HW key?
> > 	+ please remember disable urfkill daemon, it might disabled rfkill=
-input!
> > 	+ please provide dmesg and messages log to me
>=20
> Here you are (dmesg, /var/log/messages, acpidump):
>=20
>   http://others-misc.oldium.net/dump.tar.gz
>=20
> I hope this finally helps to find something :-)
>=20
> Cheers,
> Old=C5=99ich.
>=20

Thank's for your information, I will look at it.

=46inally,
I borrow a Acer Aspire one ZG8 from Gary, it can reproduce your
situation.

The BAD thing is you are right,=20
I CAN REPRODUCE rfkill-input didn't receive any input, it not make sens=
e
because rfkill-input registered input handler.

The BT HW key still works because acer-wmi have polling to sync the
state with EC and killswitch, and EC also take care the BT device power
off job.

But, I also found SOMETIMES after system reboot, rfkill-input can
capture the key event.
We need find out why input handle didn't receive KEY_* event.


Hi, Dmitry=20

Appreciate if you can give us any good suggestions!
Why keyboard emit KEY_BLUETOOTH, but rfkill-input, registered input
handler, can't capture it?

*** 06:32:42.972: lshal: device_condition,
udi=3D/org/freedesktop/Hal/devices/platform_i8042_i8042_KBD_port_logica=
ldev_input
           condition_name=3DButtonPressed
           condition_details=3Dbluetooth

But, SOMETIMES after reboot system, rfkill-input can capture the key.
We are working on 2.6.38 kernel, and Acer notebook.


Thank's a lot!
Joey Lee

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

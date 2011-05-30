From: Pablo Cases <pablo.cases@flatfrog.com>
Subject: RE: g_hid and hid-multitouch compatibility?
Date: Mon, 30 May 2011 18:11:33 +0200
Message-ID: <8B252890F5150E47AD8B8AEC92FDBA2201118CAD79@fg-dc1>
References: <8B252890F5150E47AD8B8AEC92FDBA2201118CAC80@fg-dc1>
	<BANLkTin=OOGVbomx81SqHiSX4nmg5huhXA@mail.gmail.com>
	<8B252890F5150E47AD8B8AEC92FDBA2201118CAC8D@fg-dc1>
 <BANLkTikXgtpuuScarsSaT_1FvPKaqvfKMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hd5b91d02.k46641.sta.perspektivbredband.net ([213.185.29.2]:46274
	"EHLO fg-dc1.flatfrog.local" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752711Ab1E3QLg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 30 May 2011 12:11:36 -0400
In-Reply-To: <BANLkTikXgtpuuScarsSaT_1FvPKaqvfKMA@mail.gmail.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: =?iso-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Benjamin,

Now things seem to work a lot better thanks to your input :) I'm still =
on the 2.6.38 version of the multitouch code, but static registering wo=
rks after adding our faked USB VIP/PID to hid.ids.c, hid-core.c and hid=
-multitouch.c:

Digitizers.TipSwitch ---> Key.Touch
Digitizers.InRange ---> Sync.Report
Digitizers.ContactID ---> Sync.Report
GenericDesktop.X ---> Absolute.MTPositionX
GenericDesktop.Y ---> Absolute.MTPositionY
Digitizers.TipSwitch ---> Key.Touch
Digitizers.InRange ---> Sync.Report
Digitizers.ContactID ---> Sync.Report
GenericDesktop.X ---> Absolute.MTPositionX
GenericDesktop.Y ---> Absolute.MTPositionY
Digitizers.ContactCount ---> Sync.Report
Button.0001 ---> Key.LeftBtn
Button.0002 ---> Key.RightBtn
Button.0003 ---> Key.MiddleBtn
GenericDesktop.X ---> Absolute.MTPositionX
GenericDesktop.Y ---> Absolute.MTPositionY
GenericDesktop.Wheel ---> Relative.Wheel

Running some diagnostics:
workstation$ sudo python eviocg.py /dev/input/event3
the device '/dev/input/event3' is multitouch enabled with the protocol =
B.

An unmodified version of mtdiag now discovers our multitouch device, bu=
t I cannot get any valid touch output in the "drawing surface" of the a=
pplication. You mentioned that I could optimize things by using some of=
 the quirk defined, but is this necessary or optional? If I'm reporting=
 as the Windows 7 specification describes do I still need to use any of=
 the quirks? Specially I'm wondering about the quirks that relate to co=
ntact id/contact number and slots. Do I really need to think about slot=
s at all if I have valid ContactIDs in my reports?

Regards,
Pablo


> -----Original Message-----
> From: Benjamin Tissoires [mailto:benjamin.tissoires@gmail.com]
> Sent: den 28 maj 2011 00:42
> To: Pablo Cases
> Cc: St=E9phane Chatty; Henrik Rydberg; Jiri Kosina; linux-
> input@vger.kernel.org
> Subject: Re: g_hid and hid-multitouch compatibility?
>=20
> Hi Pablo
>=20
> On Sat, May 28, 2011 at 00:08, Pablo Cases <pablo.cases@flatfrog.com>
> wrote:
> > Hi Benjamin,
> >
> > Thanks for the response. It is my ignorance that should be excused =
as
> I have shown/will show that I am the novice with regards to USB HID a=
nd
> multitouch in this forum :)
> > I=B4ll continue interleaving additional comments below.
> >
> > -Pablo
> >
> >> -----Original Message-----
> >> From: Benjamin Tissoires [mailto:benjamin.tissoires@gmail.com]
> >> Sent: den 27 maj 2011 18:10
> >> To: Pablo Cases
> >> Cc: St=E9phane Chatty; Henrik Rydberg; Jiri Kosina; linux-
> >> input@vger.kernel.org
> >> Subject: Re: g_hid and hid-multitouch compatibility?
> >>
> >> Hi Pablo,
> >>
> >> Adding St=E9phane, Henrik and Jiri in CC.
> >>
> >> On Fri, May 27, 2011 at 17:33, Pablo Cases
> <pablo.cases@flatfrog.com>
> >> wrote:
> >> >
> >> > Hi all,
> >> >
> >> > I have searched the net and the archives of linux-input for
> >> information on how to use the Linux g_hid kernel module on a devic=
e
> and
> >> the hid-multitouch kernel module on a host to communicate multitou=
ch
> >> events. But unfortunately I can only get single touch working.
> >>
> >> Excuse my ignorance, I didn't know g_hid existed before your mail.
> If
> >> I understand it well enough, it's an hid emulation from user-space=
=2E
> >> Are you trying to inject events from a device in user-space to the
> >> kernel? If so, I think it would be easier to use uinput. And the
> funny
> >> think was that I'm currently writing a small lib to inject mulitou=
ch
> >> events in a uinput device in an easier way.
> >>
> >
> > Maybe I misunderstand your explanation above but we=B4re not runnin=
g
> g_hid and hid-multitouch on the same system. We have a separate
> hardware USB device running Linux with the g_hid kernel module loaded=
=2E
> On this device we then have (thanks to g_hid) a userspace file called
> /dev/hidg0 that we can write USB HID input reports to, which then wil=
l
> be sent through the device's gadget usb framework, through an physica=
l
> USB cable, to a separate PC host running hid-multitouch.
>=20
> Thanks for the explaination. I didn't knew that it was possible to do
> such things. Linux is really a wonderful world ;-)
>=20
> >
> >> >
> >> > Q: Has anyone successfully completed a g_hid <-> hid-multitouch
> >> setup? And is there a description somewhere of such setup?
> >>
> >> I don't think so, hid-multitouch is really new (since 2.6.38, and
> was
> >> not very generic at this time).
> >>
> >> > Q: Is the Windows 7 multitouch USB HID descriptor the correct on=
e
> to
> >> use also for Linux hid-multitouch? Or is some tweaking necessary?
> >>
> >> Normally, any valid Windows 7 multitouch USB HID descriptor can be
> >> handled by hid-multitouch.
> >> But it's more the events that are sent to hid-multitouch that will
> >> tell if your device is compatible or not.
> >>
> >> >
> >> > DETAILED DESCRIPTION BELOW
> >> > The device is a Linux device that uses g_hid (currently 2.6.37
> >> kernel) and a USB HID Report Descriptor for multitouch using two-
> touch
> >> parallel mode according to Microsoft document
> >> http://msdn.microsoft.com/en-us/windows/hardware/gg487437.
> >> >
> >> > On the host (ubuntu 11.04, 2.6.38 kernel) I register dynamically
> >> according to the description at http://lii-
> >> enac.fr/en/architecture/linux-input/multitouch-ubuntu-howto.html.
> Using
> >> the events/rdesc files in debugfs on Ubuntu 11.04 I have validated
> the
> >> parsing of the report descriptor and the input reports.
> >>
> >> This is really a bad idea to use these howto with ubuntu 11.04 ATM=
=2E
> I
> >> didn't found the time to update this stuff, and this branch can no=
t
> be
> >> used in ubuntu 11.04 (it contains code for 2.6.35 only, and there
> were
> >> changes in the hid layer after). If you only used the part "How to
> add
> >> your device to hid-multitouch from the user space" without updatin=
g
> >> your hid module, then it's as if you have'nt done anything (the
> >> generic hid module can not autodetect multitouch devices).
> >
> > Currently I am using the hid-multitouch code as existing in the
> source distribution of a 2.6.38 Ubuntu 11.04 fetched through apt-get.
> In the page referred to above I have only used the "How to add your
> device to hid-multitouch from the user space", and not the 2.6.35
> related parts.
>=20
> So there are no autodetection in your kernel.
>=20
> >
> > Ok, so for autodetection of multitouch devices to work I need to
> update the hid-multitouch module to a newer version (than was availab=
le
> in 2.6.38), preferably head on a git master branch somewhere? Another
> option is to add a static configuration field in hid-multitouch and
> hid-ids.h for my USB device's VID/PID. But then again, maybe it's
> better to do that on the latest available code as well?
>=20
> Autodetection is not available upstream too, sorry. The latest
> available code is on Jiri's tree. I'll try to maintain a bunch of
> patches to backport the work done on hid-multitouch since 2.6.35 on
> http://lii-enac.fr/en/architecture/linux-input/multitouch-
> howto.html#hid-multitouch
> but I'm a little late for the backports right now.
>=20
> Jiri's tree is at
> http://git.kernel.org/?p=3Dlinux/kernel/git/jikos/hid.git;a=3Dsummary
>=20
> >
> >> >
> >> > Example multitouch input report from
> >> /sys/kernel/debug/hid/0003:xxxx:yyyy.0002/events looks correct:
> >> > report (size 14) (numbered) =3D =A005 03 00 a5 12 32 0e 03 01 99=
 14 32
> 0e
> >> 02
> >> > Digitizers.TipSwitch =3D 1
> >> > Digitizers.InRange =3D 1
> >> > Digitizers.ContactID =3D 0
> >> > GenericDesktop.X =3D 4773
> >> > GenericDesktop.Y =3D 3634
> >> > Digitizers.TipSwitch =3D 1
> >> > Digitizers.InRange =3D 1
> >> > Digitizers.ContactID =3D 1
> >> > GenericDesktop.X =3D 5273
> >> > GenericDesktop.Y =3D 3634
> >> > Digitizers.ContactCount =3D 2
> >> >
> >>
> >> Most of the time, the problematic part comes from the releases. Bu=
t
> >> it's a good start.
> >
> > With "releases" I assume you mean the finger removal from the touch
> surface, like a "touch-up" event? I have not implemented that part ye=
t,
> but our Microsoft contact informed us that for Windows 7 compatibilit=
y
> it should be reported as a final touch report with
> > TipSwitch =3D 0
> > InRange =3D 1
> > Is this applicable to hid-multitouch too?
>=20
> Exactly, I meant touch-up. Your behavior is applicable to hid-
> multitouch.
>=20
> Once registering your device with hid-multitouch, you can choose a
> class that controls how optimized your driver will be. Normally, the
> MT_CLS_DEFAULT class will work with any Win 7 compliant device
> (crossing fingers).
>=20
> Then, you can optimize it by looking for the classes that have
> MT_QUIRK_VALID_IS_INRANGE (or adding a new one). In the same time, yo=
u
> can also optimize the way your device actually does the match between
> slots (from 0 to N-1 with N the maximum contact count of your device)
> and the tracking_id reported by the device (or the position in the hi=
d
> report).
> For dual touches only devices, the differences are not big, but we
> prefer to optimize things all the time ;-)
>=20
> >
> >> > The first touch in the report is correctly presented both on
> Windows
> >> and on Ubuntu 11.04 (using ENAC's mtdiag tool with a minor tweak t=
o
> >> display data from all devices not just multitouch ones). I can see
> in
> >> the debugfs files that the data for the second touch data is
> correctly
> >> transferred and interpreted (see above), but the mapping to the
> linux
> >> input system seems a bit strange though (see below). My guess is
> that I
> >> have not been correctly registered as a multitouch device. I'm
> assuming
> >> this also because I cannot see any activity from the hid-multitouc=
h
> >> module other than it being initialized when I connect my device
> >> (probably another reason for the needed tweak in mtdiag above).
> >> >
> >> > Example mapping from
> /sys/kernel/debug/hid/0003:xxxx:yyyy.0002/rdesc
> >> that does not look entirely correct for the second touch:
> >> > Digitizers.TipSwitch ---> Key.Touch
> >> > Digitizers.InRange ---> Key.ToolPen
> >> > Digitizers.ContactID ---> Absolute.Misc
> >> > GenericDesktop.X ---> Absolute.X
> >> > GenericDesktop.Y ---> Absolute.Y
> >> > Digitizers.TipSwitch ---> Key.Touch
> >> > Digitizers.InRange ---> Key.ToolRubber
> >> > Digitizers.ContactID ---> Absolute.?
> >> > GenericDesktop.X ---> Absolute.Z
> >> > GenericDesktop.Y ---> Absolute.Rx
> >>
> >> This means that your device is handled by the generic usbhid and n=
ot
> >> hid-multitouch.
> >
> > That is what troubles me. I can see in the host's dmesg that
> "generic-usb" seems to be the driver chosen for my device when it is
> connected to the host. And according to your comment above I might no=
t
> have correctly registered my device in hid-multitouch which would be
> the source of the problem...
> >
> > As a side note; I have sprinkled printk() here and there hid-
> multitouch.c and hid-core.c. While running the code I can only see th=
at
> mt_init() and mt_exit() are called during module loading/unloading;
> never do I see any evidence of that the probing or mapping functions =
in
> hid-multitouch are used, only the generic usb parts are used for
> parsing the report descriptors and input reports.
>=20
> Yep, hid-multitouch does not handle your device. There is currently n=
o
> user-space way to tell usbhid (the generic) not to handle a device.
> You'll have to add your VID-PID to the hid_have_special_driver list
> (in hid-core.c) to disable generic usb hid handling for your device.
> You can check the latest patches adding a specific device to
> hid-multitouch to have some examples.
>=20
> >
> > Could you point me to the location in the code where the decision i=
s
> taken to use the hid-multitouch driver for a hid-multitouch supported
> device? I'm guessing it is somewhere in hid-core.c but I have not bee=
n
> able to pinpoint the location exactly. I could use this location as a
> start point to backtrace why we're not considered as a hid-multitouch
> supported device.
>=20
> it's just above ;-) hid_have_special_driver in hid-core.c
>=20
> Cheers,
> Benjamin
>=20
> >
> >> If you are trying to inject events from the user space, I strongly
> >> recommend to use uinput instead. Let me know if you want to have m=
y
> >> little uinput-multitouch lib.
> >>
> >> Cheers,
> >> Benjamin
> >>
> >> > Digitizers.ContactCount ---> Absolute.?
> >> > Button.0001 ---> Key.LeftBtn
> >> > Button.0002 ---> Key.RightBtn
> >> > Button.0003 ---> Key.MiddleBtn
> >> > GenericDesktop.X ---> Relative.X
> >> > GenericDesktop.Y ---> Relative.Y
> >> > GenericDesktop.Wheel ---> Relative.Wheel
> >> >
> >> >
> >> > Regards,
> >> > Pablo Cases
> >> >
> >> > -------------------------
> >> > Pablo Cases, M.Sc.
> >> > Development Engineer Software
> >> > FlatFrog Laboratories AB
> >> > Magistratsv=E4gen 10
> >> > 22643 Lund
> >> > Sweden
> >> > Tel: +46 708 393816
> >> > Mail: pc@flatfrog.com
> >> > Web: www.flatfrog.com
> >> > --
> >> > To unsubscribe from this list: send the line "unsubscribe linux-
> >> input" in
> >> > the body of a message to majordomo@vger.kernel.org
> >> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.=
html
> >> >
> >
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

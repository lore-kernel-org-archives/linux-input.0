From: Pablo Cases <pablo.cases@flatfrog.com>
Subject: RE: g_hid and hid-multitouch compatibility?
Date: Tue, 31 May 2011 18:03:24 +0200
Message-ID: <8B252890F5150E47AD8B8AEC92FDBA2201118CAE62@fg-dc1>
References: <8B252890F5150E47AD8B8AEC92FDBA2201118CAC80@fg-dc1>
	<BANLkTin=OOGVbomx81SqHiSX4nmg5huhXA@mail.gmail.com>
	<8B252890F5150E47AD8B8AEC92FDBA2201118CAC8D@fg-dc1>
	<BANLkTikXgtpuuScarsSaT_1FvPKaqvfKMA@mail.gmail.com>
	<8B252890F5150E47AD8B8AEC92FDBA2201118CAD79@fg-dc1>
 <BANLkTikWiTXmymEmPhBp-bdCc10CDtTfzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_004_8B252890F5150E47AD8B8AEC92FDBA2201118CAE62fgdc1_"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hd5b91d02.k46641.sta.perspektivbredband.net ([213.185.29.2]:54208
	"EHLO fg-dc1.flatfrog.local" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751038Ab1EaQDZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 31 May 2011 12:03:25 -0400
In-Reply-To: <BANLkTikWiTXmymEmPhBp-bdCc10CDtTfzw@mail.gmail.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: =?iso-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

--_004_8B252890F5150E47AD8B8AEC92FDBA2201118CAE62fgdc1_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi Benjamin,

I've attached some logs (rdesc.txt, events.txt and evtest.txt) showing a si=
mulated 2-touch sequence spanning over four frames (last frame is a "untouc=
h" event). Looking at the logs I'd say that I have a problem with the MIN/M=
AX limit decoding as evtest says limits are -127/127 but that is not what w=
e're reporting according to rdesc.

While we're at it I have some more questions:
Q: Do we need to acknowledge the Device Configuration Feature Report sent f=
rom the host to the device (instructing the device to report "multi-touch" =
events)?
Q: Do we need to send the ContactCountMaximum Feature Report as described i=
n the Windows 7 specification? Because I can see that these values are hard=
coded (or just initialized?) in hid-multitouch for each supported device.

Regards,
Pablo


> -----Original Message-----
> From: Benjamin Tissoires [mailto:benjamin.tissoires@gmail.com]
> Sent: den 31 maj 2011 13:19
> To: Pablo Cases
> Cc: St=E9phane Chatty; Henrik Rydberg; Jiri Kosina; linux-
> input@vger.kernel.org
> Subject: Re: g_hid and hid-multitouch compatibility?
>
> Hi Pablo,
>
> On Mon, May 30, 2011 at 18:11, Pablo Cases <pablo.cases@flatfrog.com>
> wrote:
> > Hi Benjamin,
> >
> > Now things seem to work a lot better thanks to your input :) I'm
> still on the 2.6.38 version of the multitouch code, but static
> registering works after adding our faked USB VIP/PID to hid.ids.c, hid-
> core.c and hid-multitouch.c:
> >
> > Digitizers.TipSwitch ---> Key.Touch
> > Digitizers.InRange ---> Sync.Report
> > Digitizers.ContactID ---> Sync.Report
> > GenericDesktop.X ---> Absolute.MTPositionX
> > GenericDesktop.Y ---> Absolute.MTPositionY
> > Digitizers.TipSwitch ---> Key.Touch
> > Digitizers.InRange ---> Sync.Report
> > Digitizers.ContactID ---> Sync.Report
> > GenericDesktop.X ---> Absolute.MTPositionX
> > GenericDesktop.Y ---> Absolute.MTPositionY
> > Digitizers.ContactCount ---> Sync.Report
> > Button.0001 ---> Key.LeftBtn
> > Button.0002 ---> Key.RightBtn
> > Button.0003 ---> Key.MiddleBtn
> > GenericDesktop.X ---> Absolute.MTPositionX
> > GenericDesktop.Y ---> Absolute.MTPositionY
> > GenericDesktop.Wheel ---> Relative.Wheel
> >
> > Running some diagnostics:
> > workstation$ sudo python eviocg.py /dev/input/event3
> > the device '/dev/input/event3' is multitouch enabled with the
> protocol B.
>
> Can you send me the output of the command "evtest /dev/input/event3"
> while moving/releasing fingers? I'm particularly interested in the
> headers of this output (with the maximum of the ABS_MT_SLOTS).
>
> Can you also send the full reports descriptor from
> /sys/kernel/debug/hid/0003:xxxx:yyyy.0002/rdesc
>
> >
> > An unmodified version of mtdiag now discovers our multitouch device,
> but I cannot get any valid touch output in the "drawing surface" of the
> application. You mentioned that I could optimize things by using some
> of the quirk defined, but is this necessary or optional?
>
> purely optional. (normally)
>
> > If I'm reporting as the Windows 7 specification describes do I still
> need to use any of the quirks?
>
> the point is that many hardware makers interpreted differently this
> documentation (that's why we have those quirks). I'm not sure how
> Microsoft handles this mess, but it may be even more complicated than
> our hid-multitouch... So I can not guarantee that it will work out of
> the box.
> The big point lies in the understanding of the different
> significations of the fields during a touch life time.
>
> > Specially I'm wondering about the quirks that relate to contact
> id/contact number and slots. Do I really need to think about slots at
> all if I have valid ContactIDs in my reports?
>
> Well it's optimization, so it's optional (though I prefer, because it
> avoids finding elements in lists).
>
> Cheers,
> Benjamin
>
> >
> > Regards,
> > Pablo
> >
> >
> >> -----Original Message-----
> >> From: Benjamin Tissoires [mailto:benjamin.tissoires@gmail.com]
> >> Sent: den 28 maj 2011 00:42
> >> To: Pablo Cases
> >> Cc: St=E9phane Chatty; Henrik Rydberg; Jiri Kosina; linux-
> >> input@vger.kernel.org
> >> Subject: Re: g_hid and hid-multitouch compatibility?
> >>
> >> Hi Pablo
> >>
> >> On Sat, May 28, 2011 at 00:08, Pablo Cases
> <pablo.cases@flatfrog.com>
> >> wrote:
> >> > Hi Benjamin,
> >> >
> >> > Thanks for the response. It is my ignorance that should be excused
> as
> >> I have shown/will show that I am the novice with regards to USB HID
> and
> >> multitouch in this forum :)
> >> > I=B4ll continue interleaving additional comments below.
> >> >
> >> > -Pablo
> >> >
> >> >> -----Original Message-----
> >> >> From: Benjamin Tissoires [mailto:benjamin.tissoires@gmail.com]
> >> >> Sent: den 27 maj 2011 18:10
> >> >> To: Pablo Cases
> >> >> Cc: St=E9phane Chatty; Henrik Rydberg; Jiri Kosina; linux-
> >> >> input@vger.kernel.org
> >> >> Subject: Re: g_hid and hid-multitouch compatibility?
> >> >>
> >> >> Hi Pablo,
> >> >>
> >> >> Adding St=E9phane, Henrik and Jiri in CC.
> >> >>
> >> >> On Fri, May 27, 2011 at 17:33, Pablo Cases
> >> <pablo.cases@flatfrog.com>
> >> >> wrote:
> >> >> >
> >> >> > Hi all,
> >> >> >
> >> >> > I have searched the net and the archives of linux-input for
> >> >> information on how to use the Linux g_hid kernel module on a
> device
> >> and
> >> >> the hid-multitouch kernel module on a host to communicate
> multitouch
> >> >> events. But unfortunately I can only get single touch working.
> >> >>
> >> >> Excuse my ignorance, I didn't know g_hid existed before your
> mail.
> >> If
> >> >> I understand it well enough, it's an hid emulation from user-
> space.
> >> >> Are you trying to inject events from a device in user-space to
> the
> >> >> kernel? If so, I think it would be easier to use uinput. And the
> >> funny
> >> >> think was that I'm currently writing a small lib to inject
> mulitouch
> >> >> events in a uinput device in an easier way.
> >> >>
> >> >
> >> > Maybe I misunderstand your explanation above but we=B4re not running
> >> g_hid and hid-multitouch on the same system. We have a separate
> >> hardware USB device running Linux with the g_hid kernel module
> loaded.
> >> On this device we then have (thanks to g_hid) a userspace file
> called
> >> /dev/hidg0 that we can write USB HID input reports to, which then
> will
> >> be sent through the device's gadget usb framework, through an
> physical
> >> USB cable, to a separate PC host running hid-multitouch.
> >>
> >> Thanks for the explaination. I didn't knew that it was possible to
> do
> >> such things. Linux is really a wonderful world ;-)
> >>
> >> >
> >> >> >
> >> >> > Q: Has anyone successfully completed a g_hid <-> hid-multitouch
> >> >> setup? And is there a description somewhere of such setup?
> >> >>
> >> >> I don't think so, hid-multitouch is really new (since 2.6.38, and
> >> was
> >> >> not very generic at this time).
> >> >>
> >> >> > Q: Is the Windows 7 multitouch USB HID descriptor the correct
> one
> >> to
> >> >> use also for Linux hid-multitouch? Or is some tweaking necessary?
> >> >>
> >> >> Normally, any valid Windows 7 multitouch USB HID descriptor can
> be
> >> >> handled by hid-multitouch.
> >> >> But it's more the events that are sent to hid-multitouch that
> will
> >> >> tell if your device is compatible or not.
> >> >>
> >> >> >
> >> >> > DETAILED DESCRIPTION BELOW
> >> >> > The device is a Linux device that uses g_hid (currently 2.6.37
> >> >> kernel) and a USB HID Report Descriptor for multitouch using two-
> >> touch
> >> >> parallel mode according to Microsoft document
> >> >> http://msdn.microsoft.com/en-us/windows/hardware/gg487437.
> >> >> >
> >> >> > On the host (ubuntu 11.04, 2.6.38 kernel) I register
> dynamically
> >> >> according to the description at http://lii-
> >> >> enac.fr/en/architecture/linux-input/multitouch-ubuntu-howto.html.
> >> Using
> >> >> the events/rdesc files in debugfs on Ubuntu 11.04 I have
> validated
> >> the
> >> >> parsing of the report descriptor and the input reports.
> >> >>
> >> >> This is really a bad idea to use these howto with ubuntu 11.04
> ATM.
> >> I
> >> >> didn't found the time to update this stuff, and this branch can
> not
> >> be
> >> >> used in ubuntu 11.04 (it contains code for 2.6.35 only, and there
> >> were
> >> >> changes in the hid layer after). If you only used the part "How
> to
> >> add
> >> >> your device to hid-multitouch from the user space" without
> updating
> >> >> your hid module, then it's as if you have'nt done anything (the
> >> >> generic hid module can not autodetect multitouch devices).
> >> >
> >> > Currently I am using the hid-multitouch code as existing in the
> >> source distribution of a 2.6.38 Ubuntu 11.04 fetched through apt-
> get.
> >> In the page referred to above I have only used the "How to add your
> >> device to hid-multitouch from the user space", and not the 2.6.35
> >> related parts.
> >>
> >> So there are no autodetection in your kernel.
> >>
> >> >
> >> > Ok, so for autodetection of multitouch devices to work I need to
> >> update the hid-multitouch module to a newer version (than was
> available
> >> in 2.6.38), preferably head on a git master branch somewhere?
> Another
> >> option is to add a static configuration field in hid-multitouch and
> >> hid-ids.h for my USB device's VID/PID. But then again, maybe it's
> >> better to do that on the latest available code as well?
> >>
> >> Autodetection is not available upstream too, sorry. The latest
> >> available code is on Jiri's tree. I'll try to maintain a bunch of
> >> patches to backport the work done on hid-multitouch since 2.6.35 on
> >> http://lii-enac.fr/en/architecture/linux-input/multitouch-
> >> howto.html#hid-multitouch
> >> but I'm a little late for the backports right now.
> >>
> >> Jiri's tree is at
> >> http://git.kernel.org/?p=3Dlinux/kernel/git/jikos/hid.git;a=3Dsummary
> >>
> >> >
> >> >> >
> >> >> > Example multitouch input report from
> >> >> /sys/kernel/debug/hid/0003:xxxx:yyyy.0002/events looks correct:
> >> >> > report (size 14) (numbered) =3D  05 03 00 a5 12 32 0e 03 01 99 14
> 32
> >> 0e
> >> >> 02
> >> >> > Digitizers.TipSwitch =3D 1
> >> >> > Digitizers.InRange =3D 1
> >> >> > Digitizers.ContactID =3D 0
> >> >> > GenericDesktop.X =3D 4773
> >> >> > GenericDesktop.Y =3D 3634
> >> >> > Digitizers.TipSwitch =3D 1
> >> >> > Digitizers.InRange =3D 1
> >> >> > Digitizers.ContactID =3D 1
> >> >> > GenericDesktop.X =3D 5273
> >> >> > GenericDesktop.Y =3D 3634
> >> >> > Digitizers.ContactCount =3D 2
> >> >> >
> >> >>
> >> >> Most of the time, the problematic part comes from the releases.
> But
> >> >> it's a good start.
> >> >
> >> > With "releases" I assume you mean the finger removal from the
> touch
> >> surface, like a "touch-up" event? I have not implemented that part
> yet,
> >> but our Microsoft contact informed us that for Windows 7
> compatibility
> >> it should be reported as a final touch report with
> >> > TipSwitch =3D 0
> >> > InRange =3D 1
> >> > Is this applicable to hid-multitouch too?
> >>
> >> Exactly, I meant touch-up. Your behavior is applicable to hid-
> >> multitouch.
> >>
> >> Once registering your device with hid-multitouch, you can choose a
> >> class that controls how optimized your driver will be. Normally, the
> >> MT_CLS_DEFAULT class will work with any Win 7 compliant device
> >> (crossing fingers).
> >>
> >> Then, you can optimize it by looking for the classes that have
> >> MT_QUIRK_VALID_IS_INRANGE (or adding a new one). In the same time,
> you
> >> can also optimize the way your device actually does the match
> between
> >> slots (from 0 to N-1 with N the maximum contact count of your
> device)
> >> and the tracking_id reported by the device (or the position in the
> hid
> >> report).
> >> For dual touches only devices, the differences are not big, but we
> >> prefer to optimize things all the time ;-)
> >>
> >> >
> >> >> > The first touch in the report is correctly presented both on
> >> Windows
> >> >> and on Ubuntu 11.04 (using ENAC's mtdiag tool with a minor tweak
> to
> >> >> display data from all devices not just multitouch ones). I can
> see
> >> in
> >> >> the debugfs files that the data for the second touch data is
> >> correctly
> >> >> transferred and interpreted (see above), but the mapping to the
> >> linux
> >> >> input system seems a bit strange though (see below). My guess is
> >> that I
> >> >> have not been correctly registered as a multitouch device. I'm
> >> assuming
> >> >> this also because I cannot see any activity from the hid-
> multitouch
> >> >> module other than it being initialized when I connect my device
> >> >> (probably another reason for the needed tweak in mtdiag above).
> >> >> >
> >> >> > Example mapping from
> >> /sys/kernel/debug/hid/0003:xxxx:yyyy.0002/rdesc
> >> >> that does not look entirely correct for the second touch:
> >> >> > Digitizers.TipSwitch ---> Key.Touch
> >> >> > Digitizers.InRange ---> Key.ToolPen
> >> >> > Digitizers.ContactID ---> Absolute.Misc
> >> >> > GenericDesktop.X ---> Absolute.X
> >> >> > GenericDesktop.Y ---> Absolute.Y
> >> >> > Digitizers.TipSwitch ---> Key.Touch
> >> >> > Digitizers.InRange ---> Key.ToolRubber
> >> >> > Digitizers.ContactID ---> Absolute.?
> >> >> > GenericDesktop.X ---> Absolute.Z
> >> >> > GenericDesktop.Y ---> Absolute.Rx
> >> >>
> >> >> This means that your device is handled by the generic usbhid and
> not
> >> >> hid-multitouch.
> >> >
> >> > That is what troubles me. I can see in the host's dmesg that
> >> "generic-usb" seems to be the driver chosen for my device when it is
> >> connected to the host. And according to your comment above I might
> not
> >> have correctly registered my device in hid-multitouch which would be
> >> the source of the problem...
> >> >
> >> > As a side note; I have sprinkled printk() here and there hid-
> >> multitouch.c and hid-core.c. While running the code I can only see
> that
> >> mt_init() and mt_exit() are called during module loading/unloading;
> >> never do I see any evidence of that the probing or mapping functions
> in
> >> hid-multitouch are used, only the generic usb parts are used for
> >> parsing the report descriptors and input reports.
> >>
> >> Yep, hid-multitouch does not handle your device. There is currently
> no
> >> user-space way to tell usbhid (the generic) not to handle a device.
> >> You'll have to add your VID-PID to the hid_have_special_driver list
> >> (in hid-core.c) to disable generic usb hid handling for your device.
> >> You can check the latest patches adding a specific device to
> >> hid-multitouch to have some examples.
> >>
> >> >
> >> > Could you point me to the location in the code where the decision
> is
> >> taken to use the hid-multitouch driver for a hid-multitouch
> supported
> >> device? I'm guessing it is somewhere in hid-core.c but I have not
> been
> >> able to pinpoint the location exactly. I could use this location as
> a
> >> start point to backtrace why we're not considered as a hid-
> multitouch
> >> supported device.
> >>
> >> it's just above ;-) hid_have_special_driver in hid-core.c
> >>
> >> Cheers,
> >> Benjamin
> >>
> >> >
> >> >> If you are trying to inject events from the user space, I
> strongly
> >> >> recommend to use uinput instead. Let me know if you want to have
> my
> >> >> little uinput-multitouch lib.
> >> >>
> >> >> Cheers,
> >> >> Benjamin
> >> >>
> >> >> > Digitizers.ContactCount ---> Absolute.?
> >> >> > Button.0001 ---> Key.LeftBtn
> >> >> > Button.0002 ---> Key.RightBtn
> >> >> > Button.0003 ---> Key.MiddleBtn
> >> >> > GenericDesktop.X ---> Relative.X
> >> >> > GenericDesktop.Y ---> Relative.Y
> >> >> > GenericDesktop.Wheel ---> Relative.Wheel
> >> >> >
> >> >> >
> >> >> > Regards,
> >> >> > Pablo Cases
> >> >> >
> >> >> > -------------------------
> >> >> > Pablo Cases, M.Sc.
> >> >> > Development Engineer Software
> >> >> > FlatFrog Laboratories AB
> >> >> > Magistratsv=E4gen 10
> >> >> > 22643 Lund
> >> >> > Sweden
> >> >> > Tel: +46 708 393816
> >> >> > Mail: pc@flatfrog.com
> >> >> > Web: www.flatfrog.com
> >> >> > --
> >> >> > To unsubscribe from this list: send the line "unsubscribe
> linux-
> >> >> input" in
> >> >> > the body of a message to majordomo@vger.kernel.org
> >> >> > More majordomo info at  http://vger.kernel.org/majordomo-
> info.html
> >> >> >
> >> >
> >

--_004_8B252890F5150E47AD8B8AEC92FDBA2201118CAE62fgdc1_
Content-Type: text/plain; name="rdesc.txt"
Content-Description: rdesc.txt
Content-Disposition: attachment; filename="rdesc.txt"; size=5840;
	creation-date="Tue, 31 May 2011 14:57:32 GMT";
	modification-date="Tue, 31 May 2011 14:45:31 GMT"
Content-Transfer-Encoding: base64

MDUgMGQgMDkgMDQgYTEgMDEgODUgMDUgMDkgMjIgYTEgMDIgMTUgMDAgMjUgMDEgNzUgMDEgOTUg
MDEgMDkgNDIgODEgMDIgMDkgMzIgODEgMDIgOTUgMDYgODEgMDMgMjUgN2YgNzUgMDggOTUgMDEg
MDkgNTEgODEgMDIgMDUgMDEgNzUgMTAgNjUgZjEgNTUgMGYgMjYgYTYgMmIgMzUgMDAgNDYgNDgg
MWIgMDkgMzAgODEgMDIgMjYgOTAgMTggNDYgNTkgMGYgMDkgMzEgODEgMDIgYzAgMDUgMGQgMDkg
MjIgNjUgMDAgNTUgMDAgYTEgMDIgNDUgMDAgMDUgMGQgMTUgMDAgMjUgMDEgNzUgMDEgOTUgMDEg
MDkgNDIgODEgMDIgMDkgMzIgODEgMDIgOTUgMDYgODEgMDMgMjUgN2YgNzUgMDggOTUgMDEgMDkg
NTEgODEgMDIgMDUgMDEgNzUgMTAgNjUgZjEgNTUgMGYgMjYgYTYgMmIgMzUgMDAgNDYgNDggMWIg
MDkgMzAgODEgMDIgMjYgOTAgMTggNDYgNTkgMGYgMDkgMzEgODEgMDIgYzAgMDUgMGQgMDkgNTQg
NjUgMDAgNTUgMDAgOTUgMDEgNzUgMDggNDUgMDAgMTUgMDAgMjUgMDggODEgMDIgMDkgNTUgODUg
MDYgMjUgMGEgYjEgMDIgYzAgMDkgMGUgYTEgMDEgODUgMDMgMDkgMjMgYTEgMDIgMDkgNTIgMDkg
NTMgMTUgMDAgMjUgMGEgNzUgMDggOTUgMDIgYjEgMDIgYzAgYzAgMDUgMDEgMDkgMDIgYTEgMDEg
ODUgMDQgMDkgMDEgYTEgMDAgMDUgMDkgMTkgMDEgMjkgMDMgMTUgMDAgMjUgMDEgOTUgMDMgNzUg
MDEgODEgMDIgOTUgMDEgNzUgMDUgODEgMDEgMDUgMDEgMDkgMzAgMDkgMzEgMDkgMzggMTUgODEg
MjUgN2YgNzUgMDggOTUgMDMgODEgMDYgYzAgYzAgDQoNCiAgSU5QVVQoNSlbSU5QVVRdDQogICAg
RmllbGQoMCkNCiAgICAgIExvZ2ljYWwoRGlnaXRpemVycy5GaW5nZXIpDQogICAgICBVc2FnZSgx
KQ0KICAgICAgICBEaWdpdGl6ZXJzLlRpcFN3aXRjaA0KICAgICAgTG9naWNhbCBNaW5pbXVtKDAp
DQogICAgICBMb2dpY2FsIE1heGltdW0oMSkNCiAgICAgIFJlcG9ydCBTaXplKDEpDQogICAgICBS
ZXBvcnQgQ291bnQoMSkNCiAgICAgIFJlcG9ydCBPZmZzZXQoMCkNCiAgICAgIEZsYWdzKCBWYXJp
YWJsZSBBYnNvbHV0ZSApDQogICAgRmllbGQoMSkNCiAgICAgIExvZ2ljYWwoRGlnaXRpemVycy5G
aW5nZXIpDQogICAgICBVc2FnZSgxKQ0KICAgICAgICBEaWdpdGl6ZXJzLkluUmFuZ2UNCiAgICAg
IExvZ2ljYWwgTWluaW11bSgwKQ0KICAgICAgTG9naWNhbCBNYXhpbXVtKDEpDQogICAgICBSZXBv
cnQgU2l6ZSgxKQ0KICAgICAgUmVwb3J0IENvdW50KDEpDQogICAgICBSZXBvcnQgT2Zmc2V0KDEp
DQogICAgICBGbGFncyggVmFyaWFibGUgQWJzb2x1dGUgKQ0KICAgIEZpZWxkKDIpDQogICAgICBM
b2dpY2FsKERpZ2l0aXplcnMuRmluZ2VyKQ0KICAgICAgVXNhZ2UoMSkNCiAgICAgICAgRGlnaXRp
emVycy5Db250YWN0SUQNCiAgICAgIExvZ2ljYWwgTWluaW11bSgwKQ0KICAgICAgTG9naWNhbCBN
YXhpbXVtKDEyNykNCiAgICAgIFJlcG9ydCBTaXplKDgpDQogICAgICBSZXBvcnQgQ291bnQoMSkN
CiAgICAgIFJlcG9ydCBPZmZzZXQoOCkNCiAgICAgIEZsYWdzKCBWYXJpYWJsZSBBYnNvbHV0ZSAp
DQogICAgRmllbGQoMykNCiAgICAgIExvZ2ljYWwoRGlnaXRpemVycy5GaW5nZXIpDQogICAgICBV
c2FnZSgxKQ0KICAgICAgICBHZW5lcmljRGVza3RvcC5YDQogICAgICBMb2dpY2FsIE1pbmltdW0o
MCkNCiAgICAgIExvZ2ljYWwgTWF4aW11bSgxMTE3NCkNCiAgICAgIFBoeXNpY2FsIE1pbmltdW0o
MCkNCiAgICAgIFBoeXNpY2FsIE1heGltdW0oNjk4NCkNCiAgICAgIFVuaXQgRXhwb25lbnQoMTUp
DQogICAgICBVbml0KFNJIExpbmVhciA6IENlbnRpbWV0ZXJeLTEpDQogICAgICBSZXBvcnQgU2l6
ZSgxNikNCiAgICAgIFJlcG9ydCBDb3VudCgxKQ0KICAgICAgUmVwb3J0IE9mZnNldCgxNikNCiAg
ICAgIEZsYWdzKCBWYXJpYWJsZSBBYnNvbHV0ZSApDQogICAgRmllbGQoNCkNCiAgICAgIExvZ2lj
YWwoRGlnaXRpemVycy5GaW5nZXIpDQogICAgICBVc2FnZSgxKQ0KICAgICAgICBHZW5lcmljRGVz
a3RvcC5ZDQogICAgICBMb2dpY2FsIE1pbmltdW0oMCkNCiAgICAgIExvZ2ljYWwgTWF4aW11bSg2
Mjg4KQ0KICAgICAgUGh5c2ljYWwgTWluaW11bSgwKQ0KICAgICAgUGh5c2ljYWwgTWF4aW11bSgz
OTI5KQ0KICAgICAgVW5pdCBFeHBvbmVudCgxNSkNCiAgICAgIFVuaXQoU0kgTGluZWFyIDogQ2Vu
dGltZXRlcl4tMSkNCiAgICAgIFJlcG9ydCBTaXplKDE2KQ0KICAgICAgUmVwb3J0IENvdW50KDEp
DQogICAgICBSZXBvcnQgT2Zmc2V0KDMyKQ0KICAgICAgRmxhZ3MoIFZhcmlhYmxlIEFic29sdXRl
ICkNCiAgICBGaWVsZCg1KQ0KICAgICAgTG9naWNhbChEaWdpdGl6ZXJzLkZpbmdlcikNCiAgICAg
IFVzYWdlKDEpDQogICAgICAgIERpZ2l0aXplcnMuVGlwU3dpdGNoDQogICAgICBMb2dpY2FsIE1p
bmltdW0oMCkNCiAgICAgIExvZ2ljYWwgTWF4aW11bSgxKQ0KICAgICAgUmVwb3J0IFNpemUoMSkN
CiAgICAgIFJlcG9ydCBDb3VudCgxKQ0KICAgICAgUmVwb3J0IE9mZnNldCg0OCkNCiAgICAgIEZs
YWdzKCBWYXJpYWJsZSBBYnNvbHV0ZSApDQogICAgRmllbGQoNikNCiAgICAgIExvZ2ljYWwoRGln
aXRpemVycy5GaW5nZXIpDQogICAgICBVc2FnZSgxKQ0KICAgICAgICBEaWdpdGl6ZXJzLkluUmFu
Z2UNCiAgICAgIExvZ2ljYWwgTWluaW11bSgwKQ0KICAgICAgTG9naWNhbCBNYXhpbXVtKDEpDQog
ICAgICBSZXBvcnQgU2l6ZSgxKQ0KICAgICAgUmVwb3J0IENvdW50KDEpDQogICAgICBSZXBvcnQg
T2Zmc2V0KDQ5KQ0KICAgICAgRmxhZ3MoIFZhcmlhYmxlIEFic29sdXRlICkNCiAgICBGaWVsZCg3
KQ0KICAgICAgTG9naWNhbChEaWdpdGl6ZXJzLkZpbmdlcikNCiAgICAgIFVzYWdlKDEpDQogICAg
ICAgIERpZ2l0aXplcnMuQ29udGFjdElEDQogICAgICBMb2dpY2FsIE1pbmltdW0oMCkNCiAgICAg
IExvZ2ljYWwgTWF4aW11bSgxMjcpDQogICAgICBSZXBvcnQgU2l6ZSg4KQ0KICAgICAgUmVwb3J0
IENvdW50KDEpDQogICAgICBSZXBvcnQgT2Zmc2V0KDU2KQ0KICAgICAgRmxhZ3MoIFZhcmlhYmxl
IEFic29sdXRlICkNCiAgICBGaWVsZCg4KQ0KICAgICAgTG9naWNhbChEaWdpdGl6ZXJzLkZpbmdl
cikNCiAgICAgIFVzYWdlKDEpDQogICAgICAgIEdlbmVyaWNEZXNrdG9wLlgNCiAgICAgIExvZ2lj
YWwgTWluaW11bSgwKQ0KICAgICAgTG9naWNhbCBNYXhpbXVtKDExMTc0KQ0KICAgICAgUGh5c2lj
YWwgTWluaW11bSgwKQ0KICAgICAgUGh5c2ljYWwgTWF4aW11bSg2OTg0KQ0KICAgICAgVW5pdCBF
eHBvbmVudCgxNSkNCiAgICAgIFVuaXQoU0kgTGluZWFyIDogQ2VudGltZXRlcl4tMSkNCiAgICAg
IFJlcG9ydCBTaXplKDE2KQ0KICAgICAgUmVwb3J0IENvdW50KDEpDQogICAgICBSZXBvcnQgT2Zm
c2V0KDY0KQ0KICAgICAgRmxhZ3MoIFZhcmlhYmxlIEFic29sdXRlICkNCiAgICBGaWVsZCg5KQ0K
ICAgICAgTG9naWNhbChEaWdpdGl6ZXJzLkZpbmdlcikNCiAgICAgIFVzYWdlKDEpDQogICAgICAg
IEdlbmVyaWNEZXNrdG9wLlkNCiAgICAgIExvZ2ljYWwgTWluaW11bSgwKQ0KICAgICAgTG9naWNh
bCBNYXhpbXVtKDYyODgpDQogICAgICBQaHlzaWNhbCBNaW5pbXVtKDApDQogICAgICBQaHlzaWNh
bCBNYXhpbXVtKDM5MjkpDQogICAgICBVbml0IEV4cG9uZW50KDE1KQ0KICAgICAgVW5pdChTSSBM
aW5lYXIgOiBDZW50aW1ldGVyXi0xKQ0KICAgICAgUmVwb3J0IFNpemUoMTYpDQogICAgICBSZXBv
cnQgQ291bnQoMSkNCiAgICAgIFJlcG9ydCBPZmZzZXQoODApDQogICAgICBGbGFncyggVmFyaWFi
bGUgQWJzb2x1dGUgKQ0KICAgIEZpZWxkKDEwKQ0KICAgICAgVXNhZ2UoMSkNCiAgICAgICAgRGln
aXRpemVycy5Db250YWN0Q291bnQNCiAgICAgIExvZ2ljYWwgTWluaW11bSgwKQ0KICAgICAgTG9n
aWNhbCBNYXhpbXVtKDgpDQogICAgICBSZXBvcnQgU2l6ZSg4KQ0KICAgICAgUmVwb3J0IENvdW50
KDEpDQogICAgICBSZXBvcnQgT2Zmc2V0KDk2KQ0KICAgICAgRmxhZ3MoIFZhcmlhYmxlIEFic29s
dXRlICkNCiAgSU5QVVQoNClbSU5QVVRdDQogICAgRmllbGQoMCkNCiAgICAgIFBoeXNpY2FsKEdl
bmVyaWNEZXNrdG9wLlBvaW50ZXIpDQogICAgICBVc2FnZSgzKQ0KICAgICAgICBCdXR0b24uMDAw
MQ0KICAgICAgICBCdXR0b24uMDAwMg0KICAgICAgICBCdXR0b24uMDAwMw0KICAgICAgTG9naWNh
bCBNaW5pbXVtKDApDQogICAgICBMb2dpY2FsIE1heGltdW0oMSkNCiAgICAgIFJlcG9ydCBTaXpl
KDEpDQogICAgICBSZXBvcnQgQ291bnQoMykNCiAgICAgIFJlcG9ydCBPZmZzZXQoMCkNCiAgICAg
IEZsYWdzKCBWYXJpYWJsZSBBYnNvbHV0ZSApDQogICAgRmllbGQoMSkNCiAgICAgIFBoeXNpY2Fs
KEdlbmVyaWNEZXNrdG9wLlBvaW50ZXIpDQogICAgICBVc2FnZSgzKQ0KICAgICAgICBHZW5lcmlj
RGVza3RvcC5YDQogICAgICAgIEdlbmVyaWNEZXNrdG9wLlkNCiAgICAgICAgR2VuZXJpY0Rlc2t0
b3AuV2hlZWwNCiAgICAgIExvZ2ljYWwgTWluaW11bSgtMTI3KQ0KICAgICAgTG9naWNhbCBNYXhp
bXVtKDEyNykNCiAgICAgIFJlcG9ydCBTaXplKDgpDQogICAgICBSZXBvcnQgQ291bnQoMykNCiAg
ICAgIFJlcG9ydCBPZmZzZXQoOCkNCiAgICAgIEZsYWdzKCBWYXJpYWJsZSBSZWxhdGl2ZSApDQog
IEZFQVRVUkUoNilbRkVBVFVSRV0NCiAgICBGaWVsZCgwKQ0KICAgICAgVXNhZ2UoMSkNCiAgICAg
ICAgRGlnaXRpemVycy5Db250YWN0TWF4aW11bU51bWJlcg0KICAgICAgTG9naWNhbCBNaW5pbXVt
KDApDQogICAgICBMb2dpY2FsIE1heGltdW0oMTApDQogICAgICBSZXBvcnQgU2l6ZSg4KQ0KICAg
ICAgUmVwb3J0IENvdW50KDEpDQogICAgICBSZXBvcnQgT2Zmc2V0KDApDQogICAgICBGbGFncygg
VmFyaWFibGUgQWJzb2x1dGUgKQ0KICBGRUFUVVJFKDMpW0ZFQVRVUkVdDQogICAgRmllbGQoMCkN
CiAgICAgIExvZ2ljYWwoRGlnaXRpemVycy4wMDIzKQ0KICAgICAgVXNhZ2UoMikNCiAgICAgICAg
RGlnaXRpemVycy5JbnB1dE1vZGUNCiAgICAgICAgRGlnaXRpemVycy5EZXZpY2VJbmRleA0KICAg
ICAgTG9naWNhbCBNaW5pbXVtKDApDQogICAgICBMb2dpY2FsIE1heGltdW0oMTApDQogICAgICBS
ZXBvcnQgU2l6ZSg4KQ0KICAgICAgUmVwb3J0IENvdW50KDIpDQogICAgICBSZXBvcnQgT2Zmc2V0
KDApDQogICAgICBGbGFncyggVmFyaWFibGUgQWJzb2x1dGUgKQ0KDQpEaWdpdGl6ZXJzLlRpcFN3
aXRjaCAtLS0+IEtleS5Ub3VjaA0KRGlnaXRpemVycy5JblJhbmdlIC0tLT4gU3luYy5SZXBvcnQN
CkRpZ2l0aXplcnMuQ29udGFjdElEIC0tLT4gU3luYy5SZXBvcnQNCkdlbmVyaWNEZXNrdG9wLlgg
LS0tPiBBYnNvbHV0ZS5NVFBvc2l0aW9uWA0KR2VuZXJpY0Rlc2t0b3AuWSAtLS0+IEFic29sdXRl
Lk1UUG9zaXRpb25ZDQpEaWdpdGl6ZXJzLlRpcFN3aXRjaCAtLS0+IEtleS5Ub3VjaA0KRGlnaXRp
emVycy5JblJhbmdlIC0tLT4gU3luYy5SZXBvcnQNCkRpZ2l0aXplcnMuQ29udGFjdElEIC0tLT4g
U3luYy5SZXBvcnQNCkdlbmVyaWNEZXNrdG9wLlggLS0tPiBBYnNvbHV0ZS5NVFBvc2l0aW9uWA0K
R2VuZXJpY0Rlc2t0b3AuWSAtLS0+IEFic29sdXRlLk1UUG9zaXRpb25ZDQpEaWdpdGl6ZXJzLkNv
bnRhY3RDb3VudCAtLS0+IFN5bmMuUmVwb3J0DQpCdXR0b24uMDAwMSAtLS0+IEtleS5MZWZ0QnRu
DQpCdXR0b24uMDAwMiAtLS0+IEtleS5SaWdodEJ0bg0KQnV0dG9uLjAwMDMgLS0tPiBLZXkuTWlk
ZGxlQnRuDQpHZW5lcmljRGVza3RvcC5YIC0tLT4gQWJzb2x1dGUuTVRQb3NpdGlvblgNCkdlbmVy
aWNEZXNrdG9wLlkgLS0tPiBBYnNvbHV0ZS5NVFBvc2l0aW9uWQ0KR2VuZXJpY0Rlc2t0b3AuV2hl
ZWwgLS0tPiBSZWxhdGl2ZS5XaGVlbA0KDQo=

--_004_8B252890F5150E47AD8B8AEC92FDBA2201118CAE62fgdc1_
Content-Type: text/plain; name="events.txt.txt"
Content-Description: events.txt.txt
Content-Disposition: attachment; filename="events.txt.txt"; size=1414;
	creation-date="Tue, 31 May 2011 17:48:09 GMT";
	modification-date="Tue, 31 May 2011 17:47:21 GMT"
Content-Transfer-Encoding: base64

cmVwb3J0IChzaXplIDE0KSAobnVtYmVyZWQpID0gIDA1IDAzIDAwIDg4IDEzIGI4IDBiIDAzIDAx
IDdjIDE1IGI4IDBiIDAyDQpEaWdpdGl6ZXJzLlRpcFN3aXRjaCA9IDENCkRpZ2l0aXplcnMuSW5S
YW5nZSA9IDENCkRpZ2l0aXplcnMuQ29udGFjdElEID0gMA0KR2VuZXJpY0Rlc2t0b3AuWCA9IDUw
MDANCkdlbmVyaWNEZXNrdG9wLlkgPSAzMDAwDQpEaWdpdGl6ZXJzLlRpcFN3aXRjaCA9IDENCkRp
Z2l0aXplcnMuSW5SYW5nZSA9IDENCkRpZ2l0aXplcnMuQ29udGFjdElEID0gMQ0KR2VuZXJpY0Rl
c2t0b3AuWCA9IDU1MDANCkdlbmVyaWNEZXNrdG9wLlkgPSAzMDAwDQpEaWdpdGl6ZXJzLkNvbnRh
Y3RDb3VudCA9IDINCg0KcmVwb3J0IChzaXplIDE0KSAobnVtYmVyZWQpID0gIDA1IDAzIDAwIDg3
IDEzIGQwIDBiIDAzIDAxIDdiIDE1IGQwIDBiIDAyDQpEaWdpdGl6ZXJzLlRpcFN3aXRjaCA9IDEN
CkRpZ2l0aXplcnMuSW5SYW5nZSA9IDENCkRpZ2l0aXplcnMuQ29udGFjdElEID0gMA0KR2VuZXJp
Y0Rlc2t0b3AuWCA9IDQ5OTkNCkdlbmVyaWNEZXNrdG9wLlkgPSAzMDI0DQpEaWdpdGl6ZXJzLlRp
cFN3aXRjaCA9IDENCkRpZ2l0aXplcnMuSW5SYW5nZSA9IDENCkRpZ2l0aXplcnMuQ29udGFjdElE
ID0gMQ0KR2VuZXJpY0Rlc2t0b3AuWCA9IDU0OTkNCkdlbmVyaWNEZXNrdG9wLlkgPSAzMDI0DQpE
aWdpdGl6ZXJzLkNvbnRhY3RDb3VudCA9IDINCg0KcmVwb3J0IChzaXplIDE0KSAobnVtYmVyZWQp
ID0gIDA1IDAzIDAwIDg2IDEzIGU5IDBiIDAzIDAxIDdhIDE1IGU5IDBiIDAyDQpEaWdpdGl6ZXJz
LlRpcFN3aXRjaCA9IDENCkRpZ2l0aXplcnMuSW5SYW5nZSA9IDENCkRpZ2l0aXplcnMuQ29udGFj
dElEID0gMA0KR2VuZXJpY0Rlc2t0b3AuWCA9IDQ5OTgNCkdlbmVyaWNEZXNrdG9wLlkgPSAzMDQ5
DQpEaWdpdGl6ZXJzLlRpcFN3aXRjaCA9IDENCkRpZ2l0aXplcnMuSW5SYW5nZSA9IDENCkRpZ2l0
aXplcnMuQ29udGFjdElEID0gMQ0KR2VuZXJpY0Rlc2t0b3AuWCA9IDU0OTgNCkdlbmVyaWNEZXNr
dG9wLlkgPSAzMDQ5DQpEaWdpdGl6ZXJzLkNvbnRhY3RDb3VudCA9IDINCg0KcmVwb3J0IChzaXpl
IDE0KSAobnVtYmVyZWQpID0gIDA1IDAyIDAwIDAwIDAwIDAwIDAwIDAyIDAxIDAwIDAwIDAwIDAw
IDAyDQpEaWdpdGl6ZXJzLlRpcFN3aXRjaCA9IDANCkRpZ2l0aXplcnMuSW5SYW5nZSA9IDENCkRp
Z2l0aXplcnMuQ29udGFjdElEID0gMA0KR2VuZXJpY0Rlc2t0b3AuWCA9IDANCkdlbmVyaWNEZXNr
dG9wLlkgPSAwDQpEaWdpdGl6ZXJzLlRpcFN3aXRjaCA9IDANCkRpZ2l0aXplcnMuSW5SYW5nZSA9
IDENCkRpZ2l0aXplcnMuQ29udGFjdElEID0gMQ0KR2VuZXJpY0Rlc2t0b3AuWCA9IDANCkdlbmVy
aWNEZXNrdG9wLlkgPSAwDQpEaWdpdGl6ZXJzLkNvbnRhY3RDb3VudCA9IDINCg==

--_004_8B252890F5150E47AD8B8AEC92FDBA2201118CAE62fgdc1_
Content-Type: text/plain; name="evtest.txt.txt"
Content-Description: evtest.txt.txt
Content-Disposition: attachment; filename="evtest.txt.txt"; size=3409;
	creation-date="Tue, 31 May 2011 17:48:09 GMT";
	modification-date="Tue, 31 May 2011 17:47:53 GMT"
Content-Transfer-Encoding: base64

d29ya3N0YXRpb24+JCBzdWRvIGV2dGVzdCAvZGV2L2lucHV0L2V2ZW50Mw0KSW5wdXQgZHJpdmVy
IHZlcnNpb24gaXMgMS4wLjENCklucHV0IGRldmljZSBJRDogYnVzIDB4MyB2ZW5kb3IgMHhmZjAg
cHJvZHVjdCAweDEyMzQgdmVyc2lvbiAweDExMQ0KSW5wdXQgZGV2aWNlIG5hbWU6ICJGbGF0ZnJv
ZyBNdWx0aXRvdWNoIDMyMDAiDQpTdXBwb3J0ZWQgZXZlbnRzOg0KICBFdmVudCB0eXBlIDAgKFN5
bmMpDQogIEV2ZW50IHR5cGUgMSAoS2V5KQ0KICAgIEV2ZW50IGNvZGUgMzMwIChUb3VjaCkNCiAg
RXZlbnQgdHlwZSAzIChBYnNvbHV0ZSkNCiAgICBFdmVudCBjb2RlIDAgKFgpDQogICAgICBWYWx1
ZSAgICAgIDANCiAgICAgIE1pbiAgICAgLTEyNw0KICAgICAgTWF4ICAgICAgMTI3DQogICAgRXZl
bnQgY29kZSAxIChZKQ0KICAgICAgVmFsdWUgICAgICAwDQogICAgICBNaW4gICAgIC0xMjcNCiAg
ICAgIE1heCAgICAgIDEyNw0KICAgIEV2ZW50IGNvZGUgNDcgKD8pDQogICAgICBWYWx1ZSAgICAg
IDANCiAgICAgIE1pbiAgICAgICAgMA0KICAgICAgTWF4ICAgICAgICAxDQogICAgRXZlbnQgY29k
ZSA1MyAoPykNCiAgICAgIFZhbHVlICAgICAgMA0KICAgICAgTWluICAgICAtMTI3DQogICAgICBN
YXggICAgICAxMjcNCiAgICBFdmVudCBjb2RlIDU0ICg/KQ0KICAgICAgVmFsdWUgICAgICAwDQog
ICAgICBNaW4gICAgIC0xMjcNCiAgICAgIE1heCAgICAgIDEyNw0KICAgIEV2ZW50IGNvZGUgNTcg
KD8pDQogICAgICBWYWx1ZSAgICAgIDANCiAgICAgIE1pbiAgICAgICAgMA0KICAgICAgTWF4ICAg
IDY1NTM1DQpUZXN0aW5nIC4uLiAoaW50ZXJydXB0IHRvIGV4aXQpDQpFdmVudDogdGltZSAxMzA2
ODUyNzU2LjYyNDMyNSwgdHlwZSAzIChBYnNvbHV0ZSksIGNvZGUgNTcgKD8pLCB2YWx1ZSAwDQpF
dmVudDogdGltZSAxMzA2ODUyNzU2LjYyNDMzMSwgdHlwZSAzIChBYnNvbHV0ZSksIGNvZGUgNTMg
KD8pLCB2YWx1ZSA1MDAwDQpFdmVudDogdGltZSAxMzA2ODUyNzU2LjYyNDMzMiwgdHlwZSAzIChB
YnNvbHV0ZSksIGNvZGUgNTQgKD8pLCB2YWx1ZSAzMDAwDQpFdmVudDogdGltZSAxMzA2ODUyNzU2
LjYyNDMzMywgdHlwZSAzIChBYnNvbHV0ZSksIGNvZGUgNDcgKD8pLCB2YWx1ZSAxDQpFdmVudDog
dGltZSAxMzA2ODUyNzU2LjYyNDMzMywgdHlwZSAzIChBYnNvbHV0ZSksIGNvZGUgNTcgKD8pLCB2
YWx1ZSAxDQpFdmVudDogdGltZSAxMzA2ODUyNzU2LjYyNDMzNCwgdHlwZSAzIChBYnNvbHV0ZSks
IGNvZGUgNTMgKD8pLCB2YWx1ZSA1NTAwDQpFdmVudDogdGltZSAxMzA2ODUyNzU2LjYyNDMzNCwg
dHlwZSAzIChBYnNvbHV0ZSksIGNvZGUgNTQgKD8pLCB2YWx1ZSAzMDAwDQpFdmVudDogdGltZSAx
MzA2ODUyNzU2LjYyNDMzNiwgdHlwZSAxIChLZXkpLCBjb2RlIDMzMCAoVG91Y2gpLCB2YWx1ZSAx
DQpFdmVudDogdGltZSAxMzA2ODUyNzU2LjYyNDMzNywgdHlwZSAzIChBYnNvbHV0ZSksIGNvZGUg
MCAoWCksIHZhbHVlIDUwMDANCkV2ZW50OiB0aW1lIDEzMDY4NTI3NTYuNjI0MzM3LCB0eXBlIDMg
KEFic29sdXRlKSwgY29kZSAxIChZKSwgdmFsdWUgMzAwMA0KRXZlbnQ6IHRpbWUgMTMwNjg1Mjc1
Ni42MjQzMzgsIC0tLS0tLS0tLS0tLS0tIFJlcG9ydCBTeW5jIC0tLS0tLS0tLS0tLQ0KRXZlbnQ6
IHRpbWUgMTMwNjg1Mjc1Ni42Mjk0NzUsIHR5cGUgMyAoQWJzb2x1dGUpLCBjb2RlIDQ3ICg/KSwg
dmFsdWUgMA0KRXZlbnQ6IHRpbWUgMTMwNjg1Mjc1Ni42Mjk0NzcsIHR5cGUgMyAoQWJzb2x1dGUp
LCBjb2RlIDUzICg/KSwgdmFsdWUgNDk5OQ0KRXZlbnQ6IHRpbWUgMTMwNjg1Mjc1Ni42Mjk0Nzcs
IHR5cGUgMyAoQWJzb2x1dGUpLCBjb2RlIDU0ICg/KSwgdmFsdWUgMzAyNA0KRXZlbnQ6IHRpbWUg
MTMwNjg1Mjc1Ni42Mjk0NzgsIHR5cGUgMyAoQWJzb2x1dGUpLCBjb2RlIDQ3ICg/KSwgdmFsdWUg
MQ0KRXZlbnQ6IHRpbWUgMTMwNjg1Mjc1Ni42Mjk0NzksIHR5cGUgMyAoQWJzb2x1dGUpLCBjb2Rl
IDUzICg/KSwgdmFsdWUgNTQ5OQ0KRXZlbnQ6IHRpbWUgMTMwNjg1Mjc1Ni42Mjk0NzksIHR5cGUg
MyAoQWJzb2x1dGUpLCBjb2RlIDU0ICg/KSwgdmFsdWUgMzAyNA0KRXZlbnQ6IHRpbWUgMTMwNjg1
Mjc1Ni42Mjk0ODEsIHR5cGUgMyAoQWJzb2x1dGUpLCBjb2RlIDAgKFgpLCB2YWx1ZSA0OTk5DQpF
dmVudDogdGltZSAxMzA2ODUyNzU2LjYyOTQ4MiwgdHlwZSAzIChBYnNvbHV0ZSksIGNvZGUgMSAo
WSksIHZhbHVlIDMwMjQNCkV2ZW50OiB0aW1lIDEzMDY4NTI3NTYuNjI5NDgyLCAtLS0tLS0tLS0t
LS0tLSBSZXBvcnQgU3luYyAtLS0tLS0tLS0tLS0NCkV2ZW50OiB0aW1lIDEzMDY4NTI3NTYuNjMx
OTU0LCB0eXBlIDMgKEFic29sdXRlKSwgY29kZSA0NyAoPyksIHZhbHVlIDANCkV2ZW50OiB0aW1l
IDEzMDY4NTI3NTYuNjMxOTU2LCB0eXBlIDMgKEFic29sdXRlKSwgY29kZSA1MyAoPyksIHZhbHVl
IDQ5OTgNCkV2ZW50OiB0aW1lIDEzMDY4NTI3NTYuNjMxOTYwLCB0eXBlIDMgKEFic29sdXRlKSwg
Y29kZSA1NCAoPyksIHZhbHVlIDMwNDkNCkV2ZW50OiB0aW1lIDEzMDY4NTI3NTYuNjMxOTY5LCB0
eXBlIDMgKEFic29sdXRlKSwgY29kZSA0NyAoPyksIHZhbHVlIDENCkV2ZW50OiB0aW1lIDEzMDY4
NTI3NTYuNjMxOTcwLCB0eXBlIDMgKEFic29sdXRlKSwgY29kZSA1MyAoPyksIHZhbHVlIDU0OTgN
CkV2ZW50OiB0aW1lIDEzMDY4NTI3NTYuNjMxOTc0LCB0eXBlIDMgKEFic29sdXRlKSwgY29kZSA1
NCAoPyksIHZhbHVlIDMwNDkNCkV2ZW50OiB0aW1lIDEzMDY4NTI3NTYuNjMxOTg2LCB0eXBlIDMg
KEFic29sdXRlKSwgY29kZSAwIChYKSwgdmFsdWUgNDk5OA0KRXZlbnQ6IHRpbWUgMTMwNjg1Mjc1
Ni42MzE5OTAsIHR5cGUgMyAoQWJzb2x1dGUpLCBjb2RlIDEgKFkpLCB2YWx1ZSAzMDQ5DQpFdmVu
dDogdGltZSAxMzA2ODUyNzU2LjYzMTk5NCwgLS0tLS0tLS0tLS0tLS0gUmVwb3J0IFN5bmMgLS0t
LS0tLS0tLS0tDQpFdmVudDogdGltZSAxMzA2ODUyNzU2LjY0NDk0MywgdHlwZSAzIChBYnNvbHV0
ZSksIGNvZGUgNDcgKD8pLCB2YWx1ZSAwDQpFdmVudDogdGltZSAxMzA2ODUyNzU2LjY0NDk0OCwg
dHlwZSAzIChBYnNvbHV0ZSksIGNvZGUgNTcgKD8pLCB2YWx1ZSAtMQ0KRXZlbnQ6IHRpbWUgMTMw
Njg1Mjc1Ni42NDQ5NTgsIHR5cGUgMyAoQWJzb2x1dGUpLCBjb2RlIDQ3ICg/KSwgdmFsdWUgMQ0K
RXZlbnQ6IHRpbWUgMTMwNjg1Mjc1Ni42NDQ5NjEsIHR5cGUgMyAoQWJzb2x1dGUpLCBjb2RlIDU3
ICg/KSwgdmFsdWUgLTENCkV2ZW50OiB0aW1lIDEzMDY4NTI3NTYuNjQ0OTY4LCB0eXBlIDEgKEtl
eSksIGNvZGUgMzMwIChUb3VjaCksIHZhbHVlIDANCkV2ZW50OiB0aW1lIDEzMDY4NTI3NTYuNjQ0
OTcyLCAtLS0tLS0tLS0tLS0tLSBSZXBvcnQgU3luYyAtLS0tLS0tLS0tLS0NCg==

--_004_8B252890F5150E47AD8B8AEC92FDBA2201118CAE62fgdc1_--

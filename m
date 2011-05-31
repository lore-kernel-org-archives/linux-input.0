From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: g_hid and hid-multitouch compatibility?
Date: Tue, 31 May 2011 13:19:20 +0200
Message-ID: <BANLkTikWiTXmymEmPhBp-bdCc10CDtTfzw@mail.gmail.com>
References: <8B252890F5150E47AD8B8AEC92FDBA2201118CAC80@fg-dc1>
	<BANLkTin=OOGVbomx81SqHiSX4nmg5huhXA@mail.gmail.com>
	<8B252890F5150E47AD8B8AEC92FDBA2201118CAC8D@fg-dc1>
	<BANLkTikXgtpuuScarsSaT_1FvPKaqvfKMA@mail.gmail.com>
	<8B252890F5150E47AD8B8AEC92FDBA2201118CAD79@fg-dc1>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:43020 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087Ab1EaLTW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 31 May 2011 07:19:22 -0400
Received: by wwa36 with SMTP id 36so4751318wwa.1
        for <linux-input@vger.kernel.org>; Tue, 31 May 2011 04:19:20 -0700 (PDT)
In-Reply-To: <8B252890F5150E47AD8B8AEC92FDBA2201118CAD79@fg-dc1>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pablo Cases <pablo.cases@flatfrog.com>
Cc: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Pablo,

On Mon, May 30, 2011 at 18:11, Pablo Cases <pablo.cases@flatfrog.com> w=
rote:
> Hi Benjamin,
>
> Now things seem to work a lot better thanks to your input :) I'm stil=
l on the 2.6.38 version of the multitouch code, but static registering =
works after adding our faked USB VIP/PID to hid.ids.c, hid-core.c and h=
id-multitouch.c:
>
> Digitizers.TipSwitch ---> Key.Touch
> Digitizers.InRange ---> Sync.Report
> Digitizers.ContactID ---> Sync.Report
> GenericDesktop.X ---> Absolute.MTPositionX
> GenericDesktop.Y ---> Absolute.MTPositionY
> Digitizers.TipSwitch ---> Key.Touch
> Digitizers.InRange ---> Sync.Report
> Digitizers.ContactID ---> Sync.Report
> GenericDesktop.X ---> Absolute.MTPositionX
> GenericDesktop.Y ---> Absolute.MTPositionY
> Digitizers.ContactCount ---> Sync.Report
> Button.0001 ---> Key.LeftBtn
> Button.0002 ---> Key.RightBtn
> Button.0003 ---> Key.MiddleBtn
> GenericDesktop.X ---> Absolute.MTPositionX
> GenericDesktop.Y ---> Absolute.MTPositionY
> GenericDesktop.Wheel ---> Relative.Wheel
>
> Running some diagnostics:
> workstation$ sudo python eviocg.py /dev/input/event3
> the device '/dev/input/event3' is multitouch enabled with the protoco=
l B.

Can you send me the output of the command "evtest /dev/input/event3"
while moving/releasing fingers? I'm particularly interested in the
headers of this output (with the maximum of the ABS_MT_SLOTS).

Can you also send the full reports descriptor from
/sys/kernel/debug/hid/0003:xxxx:yyyy.0002/rdesc

>
> An unmodified version of mtdiag now discovers our multitouch device, =
but I cannot get any valid touch output in the "drawing surface" of the=
 application. You mentioned that I could optimize things by using some =
of the quirk defined, but is this necessary or optional?

purely optional. (normally)

> If I'm reporting as the Windows 7 specification describes do I still =
need to use any of the quirks?

the point is that many hardware makers interpreted differently this
documentation (that's why we have those quirks). I'm not sure how
Microsoft handles this mess, but it may be even more complicated than
our hid-multitouch... So I can not guarantee that it will work out of
the box.
The big point lies in the understanding of the different
significations of the fields during a touch life time.

> Specially I'm wondering about the quirks that relate to contact id/co=
ntact number and slots. Do I really need to think about slots at all if=
 I have valid ContactIDs in my reports?

Well it's optimization, so it's optional (though I prefer, because it
avoids finding elements in lists).

Cheers,
Benjamin

>
> Regards,
> Pablo
>
>
>> -----Original Message-----
>> From: Benjamin Tissoires [mailto:benjamin.tissoires@gmail.com]
>> Sent: den 28 maj 2011 00:42
>> To: Pablo Cases
>> Cc: St=E9phane Chatty; Henrik Rydberg; Jiri Kosina; linux-
>> input@vger.kernel.org
>> Subject: Re: g_hid and hid-multitouch compatibility?
>>
>> Hi Pablo
>>
>> On Sat, May 28, 2011 at 00:08, Pablo Cases <pablo.cases@flatfrog.com=
>
>> wrote:
>> > Hi Benjamin,
>> >
>> > Thanks for the response. It is my ignorance that should be excused=
 as
>> I have shown/will show that I am the novice with regards to USB HID =
and
>> multitouch in this forum :)
>> > I=B4ll continue interleaving additional comments below.
>> >
>> > -Pablo
>> >
>> >> -----Original Message-----
>> >> From: Benjamin Tissoires [mailto:benjamin.tissoires@gmail.com]
>> >> Sent: den 27 maj 2011 18:10
>> >> To: Pablo Cases
>> >> Cc: St=E9phane Chatty; Henrik Rydberg; Jiri Kosina; linux-
>> >> input@vger.kernel.org
>> >> Subject: Re: g_hid and hid-multitouch compatibility?
>> >>
>> >> Hi Pablo,
>> >>
>> >> Adding St=E9phane, Henrik and Jiri in CC.
>> >>
>> >> On Fri, May 27, 2011 at 17:33, Pablo Cases
>> <pablo.cases@flatfrog.com>
>> >> wrote:
>> >> >
>> >> > Hi all,
>> >> >
>> >> > I have searched the net and the archives of linux-input for
>> >> information on how to use the Linux g_hid kernel module on a devi=
ce
>> and
>> >> the hid-multitouch kernel module on a host to communicate multito=
uch
>> >> events. But unfortunately I can only get single touch working.
>> >>
>> >> Excuse my ignorance, I didn't know g_hid existed before your mail=
=2E
>> If
>> >> I understand it well enough, it's an hid emulation from user-spac=
e.
>> >> Are you trying to inject events from a device in user-space to th=
e
>> >> kernel? If so, I think it would be easier to use uinput. And the
>> funny
>> >> think was that I'm currently writing a small lib to inject mulito=
uch
>> >> events in a uinput device in an easier way.
>> >>
>> >
>> > Maybe I misunderstand your explanation above but we=B4re not runni=
ng
>> g_hid and hid-multitouch on the same system. We have a separate
>> hardware USB device running Linux with the g_hid kernel module loade=
d.
>> On this device we then have (thanks to g_hid) a userspace file calle=
d
>> /dev/hidg0 that we can write USB HID input reports to, which then wi=
ll
>> be sent through the device's gadget usb framework, through an physic=
al
>> USB cable, to a separate PC host running hid-multitouch.
>>
>> Thanks for the explaination. I didn't knew that it was possible to d=
o
>> such things. Linux is really a wonderful world ;-)
>>
>> >
>> >> >
>> >> > Q: Has anyone successfully completed a g_hid <-> hid-multitouch
>> >> setup? And is there a description somewhere of such setup?
>> >>
>> >> I don't think so, hid-multitouch is really new (since 2.6.38, and
>> was
>> >> not very generic at this time).
>> >>
>> >> > Q: Is the Windows 7 multitouch USB HID descriptor the correct o=
ne
>> to
>> >> use also for Linux hid-multitouch? Or is some tweaking necessary?
>> >>
>> >> Normally, any valid Windows 7 multitouch USB HID descriptor can b=
e
>> >> handled by hid-multitouch.
>> >> But it's more the events that are sent to hid-multitouch that wil=
l
>> >> tell if your device is compatible or not.
>> >>
>> >> >
>> >> > DETAILED DESCRIPTION BELOW
>> >> > The device is a Linux device that uses g_hid (currently 2.6.37
>> >> kernel) and a USB HID Report Descriptor for multitouch using two-
>> touch
>> >> parallel mode according to Microsoft document
>> >> http://msdn.microsoft.com/en-us/windows/hardware/gg487437.
>> >> >
>> >> > On the host (ubuntu 11.04, 2.6.38 kernel) I register dynamicall=
y
>> >> according to the description at http://lii-
>> >> enac.fr/en/architecture/linux-input/multitouch-ubuntu-howto.html.
>> Using
>> >> the events/rdesc files in debugfs on Ubuntu 11.04 I have validate=
d
>> the
>> >> parsing of the report descriptor and the input reports.
>> >>
>> >> This is really a bad idea to use these howto with ubuntu 11.04 AT=
M.
>> I
>> >> didn't found the time to update this stuff, and this branch can n=
ot
>> be
>> >> used in ubuntu 11.04 (it contains code for 2.6.35 only, and there
>> were
>> >> changes in the hid layer after). If you only used the part "How t=
o
>> add
>> >> your device to hid-multitouch from the user space" without updati=
ng
>> >> your hid module, then it's as if you have'nt done anything (the
>> >> generic hid module can not autodetect multitouch devices).
>> >
>> > Currently I am using the hid-multitouch code as existing in the
>> source distribution of a 2.6.38 Ubuntu 11.04 fetched through apt-get=
=2E
>> In the page referred to above I have only used the "How to add your
>> device to hid-multitouch from the user space", and not the 2.6.35
>> related parts.
>>
>> So there are no autodetection in your kernel.
>>
>> >
>> > Ok, so for autodetection of multitouch devices to work I need to
>> update the hid-multitouch module to a newer version (than was availa=
ble
>> in 2.6.38), preferably head on a git master branch somewhere? Anothe=
r
>> option is to add a static configuration field in hid-multitouch and
>> hid-ids.h for my USB device's VID/PID. But then again, maybe it's
>> better to do that on the latest available code as well?
>>
>> Autodetection is not available upstream too, sorry. The latest
>> available code is on Jiri's tree. I'll try to maintain a bunch of
>> patches to backport the work done on hid-multitouch since 2.6.35 on
>> http://lii-enac.fr/en/architecture/linux-input/multitouch-
>> howto.html#hid-multitouch
>> but I'm a little late for the backports right now.
>>
>> Jiri's tree is at
>> http://git.kernel.org/?p=3Dlinux/kernel/git/jikos/hid.git;a=3Dsummar=
y
>>
>> >
>> >> >
>> >> > Example multitouch input report from
>> >> /sys/kernel/debug/hid/0003:xxxx:yyyy.0002/events looks correct:
>> >> > report (size 14) (numbered) =3D =A005 03 00 a5 12 32 0e 03 01 9=
9 14 32
>> 0e
>> >> 02
>> >> > Digitizers.TipSwitch =3D 1
>> >> > Digitizers.InRange =3D 1
>> >> > Digitizers.ContactID =3D 0
>> >> > GenericDesktop.X =3D 4773
>> >> > GenericDesktop.Y =3D 3634
>> >> > Digitizers.TipSwitch =3D 1
>> >> > Digitizers.InRange =3D 1
>> >> > Digitizers.ContactID =3D 1
>> >> > GenericDesktop.X =3D 5273
>> >> > GenericDesktop.Y =3D 3634
>> >> > Digitizers.ContactCount =3D 2
>> >> >
>> >>
>> >> Most of the time, the problematic part comes from the releases. B=
ut
>> >> it's a good start.
>> >
>> > With "releases" I assume you mean the finger removal from the touc=
h
>> surface, like a "touch-up" event? I have not implemented that part y=
et,
>> but our Microsoft contact informed us that for Windows 7 compatibili=
ty
>> it should be reported as a final touch report with
>> > TipSwitch =3D 0
>> > InRange =3D 1
>> > Is this applicable to hid-multitouch too?
>>
>> Exactly, I meant touch-up. Your behavior is applicable to hid-
>> multitouch.
>>
>> Once registering your device with hid-multitouch, you can choose a
>> class that controls how optimized your driver will be. Normally, the
>> MT_CLS_DEFAULT class will work with any Win 7 compliant device
>> (crossing fingers).
>>
>> Then, you can optimize it by looking for the classes that have
>> MT_QUIRK_VALID_IS_INRANGE (or adding a new one). In the same time, y=
ou
>> can also optimize the way your device actually does the match betwee=
n
>> slots (from 0 to N-1 with N the maximum contact count of your device=
)
>> and the tracking_id reported by the device (or the position in the h=
id
>> report).
>> For dual touches only devices, the differences are not big, but we
>> prefer to optimize things all the time ;-)
>>
>> >
>> >> > The first touch in the report is correctly presented both on
>> Windows
>> >> and on Ubuntu 11.04 (using ENAC's mtdiag tool with a minor tweak =
to
>> >> display data from all devices not just multitouch ones). I can se=
e
>> in
>> >> the debugfs files that the data for the second touch data is
>> correctly
>> >> transferred and interpreted (see above), but the mapping to the
>> linux
>> >> input system seems a bit strange though (see below). My guess is
>> that I
>> >> have not been correctly registered as a multitouch device. I'm
>> assuming
>> >> this also because I cannot see any activity from the hid-multitou=
ch
>> >> module other than it being initialized when I connect my device
>> >> (probably another reason for the needed tweak in mtdiag above).
>> >> >
>> >> > Example mapping from
>> /sys/kernel/debug/hid/0003:xxxx:yyyy.0002/rdesc
>> >> that does not look entirely correct for the second touch:
>> >> > Digitizers.TipSwitch ---> Key.Touch
>> >> > Digitizers.InRange ---> Key.ToolPen
>> >> > Digitizers.ContactID ---> Absolute.Misc
>> >> > GenericDesktop.X ---> Absolute.X
>> >> > GenericDesktop.Y ---> Absolute.Y
>> >> > Digitizers.TipSwitch ---> Key.Touch
>> >> > Digitizers.InRange ---> Key.ToolRubber
>> >> > Digitizers.ContactID ---> Absolute.?
>> >> > GenericDesktop.X ---> Absolute.Z
>> >> > GenericDesktop.Y ---> Absolute.Rx
>> >>
>> >> This means that your device is handled by the generic usbhid and =
not
>> >> hid-multitouch.
>> >
>> > That is what troubles me. I can see in the host's dmesg that
>> "generic-usb" seems to be the driver chosen for my device when it is
>> connected to the host. And according to your comment above I might n=
ot
>> have correctly registered my device in hid-multitouch which would be
>> the source of the problem...
>> >
>> > As a side note; I have sprinkled printk() here and there hid-
>> multitouch.c and hid-core.c. While running the code I can only see t=
hat
>> mt_init() and mt_exit() are called during module loading/unloading;
>> never do I see any evidence of that the probing or mapping functions=
 in
>> hid-multitouch are used, only the generic usb parts are used for
>> parsing the report descriptors and input reports.
>>
>> Yep, hid-multitouch does not handle your device. There is currently =
no
>> user-space way to tell usbhid (the generic) not to handle a device.
>> You'll have to add your VID-PID to the hid_have_special_driver list
>> (in hid-core.c) to disable generic usb hid handling for your device.
>> You can check the latest patches adding a specific device to
>> hid-multitouch to have some examples.
>>
>> >
>> > Could you point me to the location in the code where the decision =
is
>> taken to use the hid-multitouch driver for a hid-multitouch supporte=
d
>> device? I'm guessing it is somewhere in hid-core.c but I have not be=
en
>> able to pinpoint the location exactly. I could use this location as =
a
>> start point to backtrace why we're not considered as a hid-multitouc=
h
>> supported device.
>>
>> it's just above ;-) hid_have_special_driver in hid-core.c
>>
>> Cheers,
>> Benjamin
>>
>> >
>> >> If you are trying to inject events from the user space, I strongl=
y
>> >> recommend to use uinput instead. Let me know if you want to have =
my
>> >> little uinput-multitouch lib.
>> >>
>> >> Cheers,
>> >> Benjamin
>> >>
>> >> > Digitizers.ContactCount ---> Absolute.?
>> >> > Button.0001 ---> Key.LeftBtn
>> >> > Button.0002 ---> Key.RightBtn
>> >> > Button.0003 ---> Key.MiddleBtn
>> >> > GenericDesktop.X ---> Relative.X
>> >> > GenericDesktop.Y ---> Relative.Y
>> >> > GenericDesktop.Wheel ---> Relative.Wheel
>> >> >
>> >> >
>> >> > Regards,
>> >> > Pablo Cases
>> >> >
>> >> > -------------------------
>> >> > Pablo Cases, M.Sc.
>> >> > Development Engineer Software
>> >> > FlatFrog Laboratories AB
>> >> > Magistratsv=E4gen 10
>> >> > 22643 Lund
>> >> > Sweden
>> >> > Tel: +46 708 393816
>> >> > Mail: pc@flatfrog.com
>> >> > Web: www.flatfrog.com
>> >> > --
>> >> > To unsubscribe from this list: send the line "unsubscribe linux=
-
>> >> input" in
>> >> > the body of a message to majordomo@vger.kernel.org
>> >> > More majordomo info at =A0http://vger.kernel.org/majordomo-info=
=2Ehtml
>> >> >
>> >
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

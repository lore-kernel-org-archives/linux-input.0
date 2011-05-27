From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: g_hid and hid-multitouch compatibility?
Date: Sat, 28 May 2011 00:41:43 +0200
Message-ID: <BANLkTikXgtpuuScarsSaT_1FvPKaqvfKMA@mail.gmail.com>
References: <8B252890F5150E47AD8B8AEC92FDBA2201118CAC80@fg-dc1>
	<BANLkTin=OOGVbomx81SqHiSX4nmg5huhXA@mail.gmail.com>
	<8B252890F5150E47AD8B8AEC92FDBA2201118CAC8D@fg-dc1>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45339 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753396Ab1E0Wlp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 May 2011 18:41:45 -0400
Received: by wya21 with SMTP id 21so1563037wya.19
        for <linux-input@vger.kernel.org>; Fri, 27 May 2011 15:41:43 -0700 (PDT)
In-Reply-To: <8B252890F5150E47AD8B8AEC92FDBA2201118CAC8D@fg-dc1>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pablo Cases <pablo.cases@flatfrog.com>
Cc: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Pablo

On Sat, May 28, 2011 at 00:08, Pablo Cases <pablo.cases@flatfrog.com> w=
rote:
> Hi Benjamin,
>
> Thanks for the response. It is my ignorance that should be excused as=
 I have shown/will show that I am the novice with regards to USB HID an=
d multitouch in this forum :)
> I=B4ll continue interleaving additional comments below.
>
> -Pablo
>
>> -----Original Message-----
>> From: Benjamin Tissoires [mailto:benjamin.tissoires@gmail.com]
>> Sent: den 27 maj 2011 18:10
>> To: Pablo Cases
>> Cc: St=E9phane Chatty; Henrik Rydberg; Jiri Kosina; linux-
>> input@vger.kernel.org
>> Subject: Re: g_hid and hid-multitouch compatibility?
>>
>> Hi Pablo,
>>
>> Adding St=E9phane, Henrik and Jiri in CC.
>>
>> On Fri, May 27, 2011 at 17:33, Pablo Cases <pablo.cases@flatfrog.com=
>
>> wrote:
>> >
>> > Hi all,
>> >
>> > I have searched the net and the archives of linux-input for
>> information on how to use the Linux g_hid kernel module on a device =
and
>> the hid-multitouch kernel module on a host to communicate multitouch
>> events. But unfortunately I can only get single touch working.
>>
>> Excuse my ignorance, I didn't know g_hid existed before your mail. I=
f
>> I understand it well enough, it's an hid emulation from user-space.
>> Are you trying to inject events from a device in user-space to the
>> kernel? If so, I think it would be easier to use uinput. And the fun=
ny
>> think was that I'm currently writing a small lib to inject mulitouch
>> events in a uinput device in an easier way.
>>
>
> Maybe I misunderstand your explanation above but we=B4re not running =
g_hid and hid-multitouch on the same system. We have a separate hardwar=
e USB device running Linux with the g_hid kernel module loaded. On this=
 device we then have (thanks to g_hid) a userspace file called /dev/hid=
g0 that we can write USB HID input reports to, which then will be sent =
through the device's gadget usb framework, through an physical USB cabl=
e, to a separate PC host running hid-multitouch.

Thanks for the explaination. I didn't knew that it was possible to do
such things. Linux is really a wonderful world ;-)

>
>> >
>> > Q: Has anyone successfully completed a g_hid <-> hid-multitouch
>> setup? And is there a description somewhere of such setup?
>>
>> I don't think so, hid-multitouch is really new (since 2.6.38, and wa=
s
>> not very generic at this time).
>>
>> > Q: Is the Windows 7 multitouch USB HID descriptor the correct one =
to
>> use also for Linux hid-multitouch? Or is some tweaking necessary?
>>
>> Normally, any valid Windows 7 multitouch USB HID descriptor can be
>> handled by hid-multitouch.
>> But it's more the events that are sent to hid-multitouch that will
>> tell if your device is compatible or not.
>>
>> >
>> > DETAILED DESCRIPTION BELOW
>> > The device is a Linux device that uses g_hid (currently 2.6.37
>> kernel) and a USB HID Report Descriptor for multitouch using two-tou=
ch
>> parallel mode according to Microsoft document
>> http://msdn.microsoft.com/en-us/windows/hardware/gg487437.
>> >
>> > On the host (ubuntu 11.04, 2.6.38 kernel) I register dynamically
>> according to the description at http://lii-
>> enac.fr/en/architecture/linux-input/multitouch-ubuntu-howto.html. Us=
ing
>> the events/rdesc files in debugfs on Ubuntu 11.04 I have validated t=
he
>> parsing of the report descriptor and the input reports.
>>
>> This is really a bad idea to use these howto with ubuntu 11.04 ATM. =
I
>> didn't found the time to update this stuff, and this branch can not =
be
>> used in ubuntu 11.04 (it contains code for 2.6.35 only, and there we=
re
>> changes in the hid layer after). If you only used the part "How to a=
dd
>> your device to hid-multitouch from the user space" without updating
>> your hid module, then it's as if you have'nt done anything (the
>> generic hid module can not autodetect multitouch devices).
>
> Currently I am using the hid-multitouch code as existing in the sourc=
e distribution of a 2.6.38 Ubuntu 11.04 fetched through apt-get. In the=
 page referred to above I have only used the "How to add your device to=
 hid-multitouch from the user space", and not the 2.6.35 related parts.

So there are no autodetection in your kernel.

>
> Ok, so for autodetection of multitouch devices to work I need to upda=
te the hid-multitouch module to a newer version (than was available in =
2.6.38), preferably head on a git master branch somewhere? Another opti=
on is to add a static configuration field in hid-multitouch and hid-ids=
=2Eh for my USB device's VID/PID. But then again, maybe it's better to =
do that on the latest available code as well?

Autodetection is not available upstream too, sorry. The latest
available code is on Jiri's tree. I'll try to maintain a bunch of
patches to backport the work done on hid-multitouch since 2.6.35 on
http://lii-enac.fr/en/architecture/linux-input/multitouch-howto.html#hi=
d-multitouch
but I'm a little late for the backports right now.

Jiri's tree is at
http://git.kernel.org/?p=3Dlinux/kernel/git/jikos/hid.git;a=3Dsummary

>
>> >
>> > Example multitouch input report from
>> /sys/kernel/debug/hid/0003:xxxx:yyyy.0002/events looks correct:
>> > report (size 14) (numbered) =3D =A005 03 00 a5 12 32 0e 03 01 99 1=
4 32 0e
>> 02
>> > Digitizers.TipSwitch =3D 1
>> > Digitizers.InRange =3D 1
>> > Digitizers.ContactID =3D 0
>> > GenericDesktop.X =3D 4773
>> > GenericDesktop.Y =3D 3634
>> > Digitizers.TipSwitch =3D 1
>> > Digitizers.InRange =3D 1
>> > Digitizers.ContactID =3D 1
>> > GenericDesktop.X =3D 5273
>> > GenericDesktop.Y =3D 3634
>> > Digitizers.ContactCount =3D 2
>> >
>>
>> Most of the time, the problematic part comes from the releases. But
>> it's a good start.
>
> With "releases" I assume you mean the finger removal from the touch s=
urface, like a "touch-up" event? I have not implemented that part yet, =
but our Microsoft contact informed us that for Windows 7 compatibility =
it should be reported as a final touch report with
> TipSwitch =3D 0
> InRange =3D 1
> Is this applicable to hid-multitouch too?

Exactly, I meant touch-up. Your behavior is applicable to hid-multitouc=
h.

Once registering your device with hid-multitouch, you can choose a
class that controls how optimized your driver will be. Normally, the
MT_CLS_DEFAULT class will work with any Win 7 compliant device
(crossing fingers).

Then, you can optimize it by looking for the classes that have
MT_QUIRK_VALID_IS_INRANGE (or adding a new one). In the same time, you
can also optimize the way your device actually does the match between
slots (from 0 to N-1 with N the maximum contact count of your device)
and the tracking_id reported by the device (or the position in the hid
report).
=46or dual touches only devices, the differences are not big, but we
prefer to optimize things all the time ;-)

>
>> > The first touch in the report is correctly presented both on Windo=
ws
>> and on Ubuntu 11.04 (using ENAC's mtdiag tool with a minor tweak to
>> display data from all devices not just multitouch ones). I can see i=
n
>> the debugfs files that the data for the second touch data is correct=
ly
>> transferred and interpreted (see above), but the mapping to the linu=
x
>> input system seems a bit strange though (see below). My guess is tha=
t I
>> have not been correctly registered as a multitouch device. I'm assum=
ing
>> this also because I cannot see any activity from the hid-multitouch
>> module other than it being initialized when I connect my device
>> (probably another reason for the needed tweak in mtdiag above).
>> >
>> > Example mapping from /sys/kernel/debug/hid/0003:xxxx:yyyy.0002/rde=
sc
>> that does not look entirely correct for the second touch:
>> > Digitizers.TipSwitch ---> Key.Touch
>> > Digitizers.InRange ---> Key.ToolPen
>> > Digitizers.ContactID ---> Absolute.Misc
>> > GenericDesktop.X ---> Absolute.X
>> > GenericDesktop.Y ---> Absolute.Y
>> > Digitizers.TipSwitch ---> Key.Touch
>> > Digitizers.InRange ---> Key.ToolRubber
>> > Digitizers.ContactID ---> Absolute.?
>> > GenericDesktop.X ---> Absolute.Z
>> > GenericDesktop.Y ---> Absolute.Rx
>>
>> This means that your device is handled by the generic usbhid and not
>> hid-multitouch.
>
> That is what troubles me. I can see in the host's dmesg that "generic=
-usb" seems to be the driver chosen for my device when it is connected =
to the host. And according to your comment above I might not have corre=
ctly registered my device in hid-multitouch which would be the source o=
f the problem...
>
> As a side note; I have sprinkled printk() here and there hid-multitou=
ch.c and hid-core.c. While running the code I can only see that mt_init=
() and mt_exit() are called during module loading/unloading; never do I=
 see any evidence of that the probing or mapping functions in hid-multi=
touch are used, only the generic usb parts are used for parsing the rep=
ort descriptors and input reports.

Yep, hid-multitouch does not handle your device. There is currently no
user-space way to tell usbhid (the generic) not to handle a device.
You'll have to add your VID-PID to the hid_have_special_driver list
(in hid-core.c) to disable generic usb hid handling for your device.
You can check the latest patches adding a specific device to
hid-multitouch to have some examples.

>
> Could you point me to the location in the code where the decision is =
taken to use the hid-multitouch driver for a hid-multitouch supported d=
evice? I'm guessing it is somewhere in hid-core.c but I have not been a=
ble to pinpoint the location exactly. I could use this location as a st=
art point to backtrace why we're not considered as a hid-multitouch sup=
ported device.

it's just above ;-) hid_have_special_driver in hid-core.c

Cheers,
Benjamin

>
>> If you are trying to inject events from the user space, I strongly
>> recommend to use uinput instead. Let me know if you want to have my
>> little uinput-multitouch lib.
>>
>> Cheers,
>> Benjamin
>>
>> > Digitizers.ContactCount ---> Absolute.?
>> > Button.0001 ---> Key.LeftBtn
>> > Button.0002 ---> Key.RightBtn
>> > Button.0003 ---> Key.MiddleBtn
>> > GenericDesktop.X ---> Relative.X
>> > GenericDesktop.Y ---> Relative.Y
>> > GenericDesktop.Wheel ---> Relative.Wheel
>> >
>> >
>> > Regards,
>> > Pablo Cases
>> >
>> > -------------------------
>> > Pablo Cases, M.Sc.
>> > Development Engineer Software
>> > FlatFrog Laboratories AB
>> > Magistratsv=E4gen 10
>> > 22643 Lund
>> > Sweden
>> > Tel: +46 708 393816
>> > Mail: pc@flatfrog.com
>> > Web: www.flatfrog.com
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe linux-
>> input" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.ht=
ml
>> >
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

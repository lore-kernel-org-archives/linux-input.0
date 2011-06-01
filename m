From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: g_hid and hid-multitouch compatibility?
Date: Wed, 1 Jun 2011 19:21:22 +0200
Message-ID: <BANLkTi=ip_nKTkHmFbmGKKdBNd1XmDp6vg@mail.gmail.com>
References: <8B252890F5150E47AD8B8AEC92FDBA2201118CAC80@fg-dc1>
	<BANLkTin=OOGVbomx81SqHiSX4nmg5huhXA@mail.gmail.com>
	<8B252890F5150E47AD8B8AEC92FDBA2201118CAC8D@fg-dc1>
	<BANLkTikXgtpuuScarsSaT_1FvPKaqvfKMA@mail.gmail.com>
	<8B252890F5150E47AD8B8AEC92FDBA2201118CAD79@fg-dc1>
	<BANLkTikWiTXmymEmPhBp-bdCc10CDtTfzw@mail.gmail.com>
	<8B252890F5150E47AD8B8AEC92FDBA2201118CAE62@fg-dc1>
	<BANLkTi=BRTw=JVeUHa4OQ+egZVxOJerTog@mail.gmail.com>
	<35E4813F-ADBF-4988-A80E-6D4DC254AE22@flatfrog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:47865 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758537Ab1FARVY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 1 Jun 2011 13:21:24 -0400
Received: by mail-ww0-f44.google.com with SMTP id 36so27821wwa.1
        for <linux-input@vger.kernel.org>; Wed, 01 Jun 2011 10:21:23 -0700 (PDT)
In-Reply-To: <35E4813F-ADBF-4988-A80E-6D4DC254AE22@flatfrog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pablo Cases <pablo.cases@flatfrog.com>
Cc: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Pablo,

On Tue, May 31, 2011 at 20:44, Pablo Cases <pablo.cases@flatfrog.com> w=
rote:
>
> On 31 maj 2011, at 18:55, "Benjamin Tissoires"
> <benjamin.tissoires@gmail.com> wrote:
>
> On Tue, May 31, 2011 at 18:03, Pablo Cases <pablo.cases@flatfrog.com>=
 wrote:
>
> Hi Benjamin,
>
> I've attached some logs (rdesc.txt, events.txt and evtest.txt) showin=
g a
> simulated 2-touch sequence spanning over four frames (last frame is a
> "untouch" event). Looking at the logs I'd say that I have a problem w=
ith the
> MIN/MAX limit decoding as evtest says limits are -127/127 but that is=
 not
> what we're reporting according to rdesc.
>
> Indeed, there are troubles with ranges of X and Y. The good point is
> that besides that, hid-multitouch seems to work well.
> However, what strikes me is that the values are not clamped by the in=
put
> layer.
>
> The problems comes from your mouse emulation, here:
>
> =A0INPUT(4)[INPUT]
> =A0=A0=A0Field(0)
> =A0=A0=A0=A0=A0....
> =A0=A0=A0Field(1)
> =A0=A0=A0=A0=A0Physical(GenericDesktop.Pointer)
> =A0=A0=A0=A0=A0Usage(3)
> =A0=A0=A0=A0=A0=A0=A0GenericDesktop.X
> =A0=A0=A0=A0=A0=A0=A0GenericDesktop.Y
> =A0=A0=A0=A0=A0=A0=A0GenericDesktop.Wheel
> =A0=A0=A0=A0=A0Logical Minimum(-127) =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
<---------
> =A0=A0=A0=A0=A0Logical Maximum(127) =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
<---------
> =A0=A0=A0=A0=A0Report Size(8)
> =A0=A0=A0=A0=A0Report Count(3)
> =A0=A0=A0=A0=A0Report Offset(8)
> =A0=A0=A0=A0=A0Flags( Variable Relative )
>
> the values are not coherent with the one reported above. Maybe we
> should patch hid-multitouch to ignore non mt inputs... ;-) but I
> really don"t have the time to do it right now.
> Maybe you don't need to introduce this mouse emulation at all in your
> device (it depends if your "firmware" will support it or not).
>
> Ok, we'll skip mouse reporting for now to avoid confusing the drivers=
=2E
> Anyway, my understanding from the win7 documentation is that mouse an=
d
> single-touch input modes are just backup modes for older Windows vers=
ions,
> and that win7 always defaults to multitiouch mode.

Yes, and so does hid-multitouch. It sends the value "2" on the input
mode to switch to multitouch mode. If you want to keep it, use a
touchscreen emulation (and not a mouse one) with the same ranges for X
and Y and no wheel.

>
> There is also a problem with the feature
> Digitizers.ContactMaximumNumber. Apparently, I would say that you put
> the initial value is at 2 instead of 10 as your maximum value
> suggests. If it's intentional, it's fine, but you won't be able to
> send more than two touches, even by changing this number later...
> (just saw the question after)
>
> This part of the communication I don't really understand completely.
> Q: Where/how am I initially reporting a limit of two touches?

The value of the feature countactMaximumNumber is at 2. I don't know
how this came out, but your ABS_MT_SLOT max shows that.

> Q: Is the driver using the logical_maximum value of the ContactCountM=
aximum
> in the Report Descriptor as the default value for my device? I though=
t these
> logical_max/min values were only used for data validation, like XSL s=
chemas
> validate XML data.

Nope, the driver use the value of the field and not the min/max. And
once we got that (while plugging the device), the driver can not send
more than this number of touches.
This choice is made in the function mt_feature_mapping. I did not
introduced logical_max as all the devices I saw were working with
that.

>
>
> While we're at it I have some more questions:
>
> Q: Do we need to acknowledge the Device Configuration Feature Report =
sent
> from the host to the device (instructing the device to report "multi-=
touch"
> events)?
>
> If you are talking about the "Digitizers.InputMode" setting, then, we
> just send the signal and we don't wait for an answer. My memory is
> quite confusing here, but again, if you don't intend to support mouse
> emulation, dropping this input in the reports will ease things.
>
> We'll drop this part also to test if it improves the situation :)

This is the switch that allows the driver to send either touchscreen
emulation or multitouch. So if you drop the touchscreen emulation,
drop the input mode, if not, then by default (1 I suppose) send
touchscreen emulation, and once you received 2 on the input mode, send
multitouch data.

Cheers,
Benjamin


>
> Q: Do we need to send the ContactCountMaximum Feature Report as descr=
ibed in
> the Windows 7 specification? Because I can see that these values are
> hardcoded (or just initialized?) in hid-multitouch for each supported
> device.
>
> So, the first implementation of hid-multitouch did not care about thi=
s
> feature. Now, I tried to use it for devices that send it correctly. A=
s
> I did not asked all the owners of the devices to redo the tests, some
> device still got .maxcontact
> I'd rather not have this thing hardcoded in order to be able to reuse
> the different classes with a lot of devices.
>
> Cheers,
> Benjamin
>
>
> Regards,
>
> Pablo
>
>
> -----Original Message-----
>
> From: Benjamin Tissoires [mailto:benjamin.tissoires@gmail.com]
>
> Sent: den 31 maj 2011 13:19
>
> To: Pablo Cases
>
> Cc: St=E9phane Chatty; Henrik Rydberg; Jiri Kosina; linux-
>
> input@vger.kernel.org
>
> Subject: Re: g_hid and hid-multitouch compatibility?
>
> Hi Pablo,
>
> On Mon, May 30, 2011 at 18:11, Pablo Cases <pablo.cases@flatfrog.com>
>
> wrote:
>
> Hi Benjamin,
>
> Now things seem to work a lot better thanks to your input :) I'm
>
> still on the 2.6.38 version of the multitouch code, but static
>
> registering works after adding our faked USB VIP/PID to hid.ids.c, hi=
d-
>
> core.c and hid-multitouch.c:
>
> Digitizers.TipSwitch ---> Key.Touch
>
> Digitizers.InRange ---> Sync.Report
>
> Digitizers.ContactID ---> Sync.Report
>
> GenericDesktop.X ---> Absolute.MTPositionX
>
> GenericDesktop.Y ---> Absolute.MTPositionY
>
> Digitizers.TipSwitch ---> Key.Touch
>
> Digitizers.InRange ---> Sync.Report
>
> Digitizers.ContactID ---> Sync.Report
>
> GenericDesktop.X ---> Absolute.MTPositionX
>
> GenericDesktop.Y ---> Absolute.MTPositionY
>
> Digitizers.ContactCount ---> Sync.Report
>
> Button.0001 ---> Key.LeftBtn
>
> Button.0002 ---> Key.RightBtn
>
> Button.0003 ---> Key.MiddleBtn
>
> GenericDesktop.X ---> Absolute.MTPositionX
>
> GenericDesktop.Y ---> Absolute.MTPositionY
>
> GenericDesktop.Wheel ---> Relative.Wheel
>
> Running some diagnostics:
>
> workstation$ sudo python eviocg.py /dev/input/event3
>
> the device '/dev/input/event3' is multitouch enabled with the
>
> protocol B.
>
> Can you send me the output of the command "evtest /dev/input/event3"
>
> while moving/releasing fingers? I'm particularly interested in the
>
> headers of this output (with the maximum of the ABS_MT_SLOTS).
>
> Can you also send the full reports descriptor from
>
> /sys/kernel/debug/hid/0003:xxxx:yyyy.0002/rdesc
>
>
> An unmodified version of mtdiag now discovers our multitouch device,
>
> but I cannot get any valid touch output in the "drawing surface" of t=
he
>
> application. You mentioned that I could optimize things by using some
>
> of the quirk defined, but is this necessary or optional?
>
> purely optional. (normally)
>
> If I'm reporting as the Windows 7 specification describes do I still
>
> need to use any of the quirks?
>
> the point is that many hardware makers interpreted differently this
>
> documentation (that's why we have those quirks). I'm not sure how
>
> Microsoft handles this mess, but it may be even more complicated than
>
> our hid-multitouch... So I can not guarantee that it will work out of
>
> the box.
>
> The big point lies in the understanding of the different
>
> significations of the fields during a touch life time.
>
> Specially I'm wondering about the quirks that relate to contact
>
> id/contact number and slots. Do I really need to think about slots at
>
> all if I have valid ContactIDs in my reports?
>
> Well it's optimization, so it's optional (though I prefer, because it
>
> avoids finding elements in lists).
>
> Cheers,
>
> Benjamin
>
>
> Regards,
>
> Pablo
>
>
> -----Original Message-----
>
> From: Benjamin Tissoires [mailto:benjamin.tissoires@gmail.com]
>
> Sent: den 28 maj 2011 00:42
>
> To: Pablo Cases
>
> Cc: St=E9phane Chatty; Henrik Rydberg; Jiri Kosina; linux-
>
> input@vger.kernel.org
>
> Subject: Re: g_hid and hid-multitouch compatibility?
>
> Hi Pablo
>
> On Sat, May 28, 2011 at 00:08, Pablo Cases
>
> <pablo.cases@flatfrog.com>
>
> wrote:
>
> Hi Benjamin,
>
> Thanks for the response. It is my ignorance that should be excused
>
> as
>
> I have shown/will show that I am the novice with regards to USB HID
>
> and
>
> multitouch in this forum :)
>
> I=B4ll continue interleaving additional comments below.
>
> -Pablo
>
> -----Original Message-----
>
> From: Benjamin Tissoires [mailto:benjamin.tissoires@gmail.com]
>
> Sent: den 27 maj 2011 18:10
>
> To: Pablo Cases
>
> Cc: St=E9phane Chatty; Henrik Rydberg; Jiri Kosina; linux-
>
> input@vger.kernel.org
>
> Subject: Re: g_hid and hid-multitouch compatibility?
>
> Hi Pablo,
>
> Adding St=E9phane, Henrik and Jiri in CC.
>
> On Fri, May 27, 2011 at 17:33, Pablo Cases
>
> <pablo.cases@flatfrog.com>
>
> wrote:
>
> Hi all,
>
> I have searched the net and the archives of linux-input for
>
> information on how to use the Linux g_hid kernel module on a
>
> device
>
> and
>
> the hid-multitouch kernel module on a host to communicate
>
> multitouch
>
> events. But unfortunately I can only get single touch working.
>
> Excuse my ignorance, I didn't know g_hid existed before your
>
> mail.
>
> If
>
> I understand it well enough, it's an hid emulation from user-
>
> space.
>
> Are you trying to inject events from a device in user-space to
>
> the
>
> kernel? If so, I think it would be easier to use uinput. And the
>
> funny
>
> think was that I'm currently writing a small lib to inject
>
> mulitouch
>
> events in a uinput device in an easier way.
>
>
> Maybe I misunderstand your explanation above but we=B4re not running
>
> g_hid and hid-multitouch on the same system. We have a separate
>
> hardware USB device running Linux with the g_hid kernel module
>
> loaded.
>
> On this device we then have (thanks to g_hid) a userspace file
>
> called
>
> /dev/hidg0 that we can write USB HID input reports to, which then
>
> will
>
> be sent through the device's gadget usb framework, through an
>
> physical
>
> USB cable, to a separate PC host running hid-multitouch.
>
> Thanks for the explaination. I didn't knew that it was possible to
>
> do
>
> such things. Linux is really a wonderful world ;-)
>
>
>
> Q: Has anyone successfully completed a g_hid <-> hid-multitouch
>
> setup? And is there a description somewhere of such setup?
>
> I don't think so, hid-multitouch is really new (since 2.6.38, and
>
> was
>
> not very generic at this time).
>
> Q: Is the Windows 7 multitouch USB HID descriptor the correct
>
> one
>
> to
>
> use also for Linux hid-multitouch? Or is some tweaking necessary?
>
> Normally, any valid Windows 7 multitouch USB HID descriptor can
>
> be
>
> handled by hid-multitouch.
>
> But it's more the events that are sent to hid-multitouch that
>
> will
>
> tell if your device is compatible or not.
>
>
> DETAILED DESCRIPTION BELOW
>
> The device is a Linux device that uses g_hid (currently 2.6.37
>
> kernel) and a USB HID Report Descriptor for multitouch using two-
>
> touch
>
> parallel mode according to Microsoft document
>
> http://msdn.microsoft.com/en-us/windows/hardware/gg487437.
>
> On the host (ubuntu 11.04, 2.6.38 kernel) I register
>
> dynamically
>
> according to the description at http://lii-
>
> enac.fr/en/architecture/linux-input/multitouch-ubuntu-howto.html.
>
> Using
>
> the events/rdesc files in debugfs on Ubuntu 11.04 I have
>
> validated
>
> the
>
> parsing of the report descriptor and the input reports.
>
> This is really a bad idea to use these howto with ubuntu 11.04
>
> ATM.
>
> I
>
> didn't found the time to update this stuff, and this branch can
>
> not
>
> be
>
> used in ubuntu 11.04 (it contains code for 2.6.35 only, and there
>
> were
>
> changes in the hid layer after). If you only used the part "How
>
> to
>
> add
>
> your device to hid-multitouch from the user space" without
>
> updating
>
> your hid module, then it's as if you have'nt done anything (the
>
> generic hid module can not autodetect multitouch devices).
>
> Currently I am using the hid-multitouch code as existing in the
>
> source distribution of a 2.6.38 Ubuntu 11.04 fetched through apt-
>
> get.
>
> In the page referred to above I have only used the "How to add your
>
> device to hid-multitouch from the user space", and not the 2.6.35
>
> related parts.
>
> So there are no autodetection in your kernel.
>
>
> Ok, so for autodetection of multitouch devices to work I need to
>
> update the hid-multitouch module to a newer version (than was
>
> available
>
> in 2.6.38), preferably head on a git master branch somewhere?
>
> Another
>
> option is to add a static configuration field in hid-multitouch and
>
> hid-ids.h for my USB device's VID/PID. But then again, maybe it's
>
> better to do that on the latest available code as well?
>
> Autodetection is not available upstream too, sorry. The latest
>
> available code is on Jiri's tree. I'll try to maintain a bunch of
>
> patches to backport the work done on hid-multitouch since 2.6.35 on
>
> http://lii-enac.fr/en/architecture/linux-input/multitouch-
>
> howto.html#hid-multitouch
>
> but I'm a little late for the backports right now.
>
> Jiri's tree is at
>
> http://git.kernel.org/?p=3Dlinux/kernel/git/jikos/hid.git;a=3Dsummary
>
>
>
> Example multitouch input report from
>
> /sys/kernel/debug/hid/0003:xxxx:yyyy.0002/events looks correct:
>
> report (size 14) (numbered) =3D =A005 03 00 a5 12 32 0e 03 01 99 14
>
> 32
>
> 0e
>
> 02
>
> Digitizers.TipSwitch =3D 1
>
> Digitizers.InRange =3D 1
>
> Digitizers.ContactID =3D 0
>
> GenericDesktop.X =3D 4773
>
> GenericDesktop.Y =3D 3634
>
> Digitizers.TipSwitch =3D 1
>
> Digitizers.InRange =3D 1
>
> Digitizers.ContactID =3D 1
>
> GenericDesktop.X =3D 5273
>
> GenericDesktop.Y =3D 3634
>
> Digitizers.ContactCount =3D 2
>
>
> Most of the time, the problematic part comes from the releases.
>
> But
>
> it's a good start.
>
> With "releases" I assume you mean the finger removal from the
>
> touch
>
> surface, like a "touch-up" event? I have not implemented that part
>
> yet,
>
> but our Microsoft contact informed us that for Windows 7
>
> compatibility
>
> it should be reported as a final touch report with
>
> TipSwitch =3D 0
>
> InRange =3D 1
>
> Is this applicable to hid-multitouch too?
>
> Exactly, I meant touch-up. Your behavior is applicable to hid-
>
> multitouch.
>
> Once registering your device with hid-multitouch, you can choose a
>
> class that controls how optimized your driver will be. Normally, the
>
> MT_CLS_DEFAULT class will work with any Win 7 compliant device
>
> (crossing fingers).
>
> Then, you can optimize it by looking for the classes that have
>
> MT_QUIRK_VALID_IS_INRANGE (or adding a new one). In the same time,
>
> you
>
> can also optimize the way your device actually does the match
>
> between
>
> slots (from 0 to N-1 with N the maximum contact count of your
>
> device)
>
> and the tracking_id reported by the device (or the position in the
>
> hid
>
> report).
>
> For dual touches only devices, the differences are not big, but we
>
> prefer to optimize things all the time ;-)
>
>
> The first touch in the report is correctly presented both on
>
> Windows
>
> and on Ubuntu 11.04 (using ENAC's mtdiag tool with a minor tweak
>
> to
>
> display data from all devices not just multitouch ones). I can
>
> see
>
> in
>
> the debugfs files that the data for the second touch data is
>
> correctly
>
> transferred and interpreted (see above), but the mapping to the
>
> linux
>
> input system seems a bit strange though (see below). My guess is
>
> that I
>
> have not been correctly registered as a multitouch device. I'm
>
> assuming
>
> this also because I cannot see any activity from the hid-
>
> multitouch
>
> module other than it being initialized when I connect my device
>
> (probably another reason for the needed tweak in mtdiag above).
>
> Example mapping from
>
> /sys/kernel/debug/hid/0003:xxxx:yyyy.0002/rdesc
>
> that does not look entirely correct for the second touch:
>
> Digitizers.TipSwitch ---> Key.Touch
>
> Digitizers.InRange ---> Key.ToolPen
>
> Digitizers.ContactID ---> Absolute.Misc
>
> GenericDesktop.X ---> Absolute.X
>
> GenericDesktop.Y ---> Absolute.Y
>
> Digitizers.TipSwitch ---> Key.Touch
>
> Digitizers.InRange ---> Key.ToolRubber
>
> Digitizers.ContactID ---> Absolute.?
>
> GenericDesktop.X ---> Absolute.Z
>
> GenericDesktop.Y ---> Absolute.Rx
>
> This means that your device is handled by the generic usbhid and
>
> not
>
> hid-multitouch.
>
> That is what troubles me. I can see in the host's dmesg that
>
> "generic-usb" seems to be the driver chosen for my device when it is
>
> connected to the host. And according to your comment above I might
>
> not
>
> have correctly registered my device in hid-multitouch which would be
>
> the source of the problem...
>
> As a side note; I have sprinkled printk() here and there hid-
>
> multitouch.c and hid-core.c. While running the code I can only see
>
> that
>
> mt_init() and mt_exit() are called during module loading/unloading;
>
> never do I see any evidence of that the probing or mapping functions
>
> in
>
> hid-multitouch are used, only the generic usb parts are used for
>
> parsing the report descriptors and input reports.
>
> Yep, hid-multitouch does not handle your device. There is currently
>
> no
>
> user-space way to tell usbhid (the generic) not to handle a device.
>
> You'll have to add your VID-PID to the hid_have_special_driver list
>
> (in hid-core.c) to disable generic usb hid handling for your device.
>
> You can check the latest patches adding a specific device to
>
> hid-multitouch to have some examples.
>
>
> Could you point me to the location in the code where the decision
>
> is
>
> taken to use the hid-multitouch driver for a hid-multitouch
>
> supported
>
> device? I'm guessing it is somewhere in hid-core.c but I have not
>
> been
>
> able to pinpoint the location exactly. I could use this location as
>
> a
>
> start point to backtrace why we're not considered as a hid-
>
> multitouch
>
> supported device.
>
> it's just above ;-) hid_have_special_driver in hid-core.c
>
> Cheers,
>
> Benjamin
>
>
> If you are trying to inject events from the user space, I
>
> strongly
>
> recommend to use uinput instead. Let me know if you want to have
>
> my
>
> little uinput-multitouch lib.
>
> Cheers,
>
> Benjamin
>
> Digitizers.ContactCount ---> Absolute.?
>
> Button.0001 ---> Key.LeftBtn
>
> Button.0002 ---> Key.RightBtn
>
> Button.0003 ---> Key.MiddleBtn
>
> GenericDesktop.X ---> Relative.X
>
> GenericDesktop.Y ---> Relative.Y
>
> GenericDesktop.Wheel ---> Relative.Wheel
>
>
> Regards,
>
> Pablo Cases
>
> -------------------------
>
> Pablo Cases, M.Sc.
>
> Development Engineer Software
>
> FlatFrog Laboratories AB
>
> Magistratsv=E4gen 10
>
> 22643 Lund
>
> Sweden
>
> Tel: +46 708 393816
>
> Mail: pc@flatfrog.com
>
> Web: www.flatfrog.com
>
> --
>
> To unsubscribe from this list: send the line "unsubscribe
>
> linux-
>
> input" in
>
> the body of a message to majordomo@vger.kernel.org
>
> More majordomo info at =A0http://vger.kernel.org/majordomo-
>
> info.html
>
>
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

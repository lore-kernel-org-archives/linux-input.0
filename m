From: Derya <derya.kiran@yahoo.de>
Subject: Re: [PATCH 0/2 ] Surface Pro 2 HID sensor, wacom, keyboard/multitouch
 composite device
Date: Fri, 07 Mar 2014 18:50:52 +0100
Message-ID: <531A06FC.4030906@yahoo.de>
References: <5319EB7C.5070209@yahoo.de> <CAN+gG=GdRwOkZsNWT9H1tRtjTy9bMDkKv1KiMe0tEcThOAvEQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nm5-vm4.bullet.mail.ir2.yahoo.com ([212.82.96.111]:20165 "EHLO
	nm5-vm4.bullet.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751978AbaCGR4o (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 7 Mar 2014 12:56:44 -0500
In-Reply-To: <CAN+gG=GdRwOkZsNWT9H1tRtjTy9bMDkKv1KiMe0tEcThOAvEQA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>


Am 07.03.2014 17:51, schrieb Benjamin Tissoires:
> Hi Derya,
>
> On Fri, Mar 7, 2014 at 10:53 AM, Derya <derya.kiran@yahoo.de> wrote:
>> The MS Surface Pro 2 has a very annoying USB composite device on por=
t 2.3.
>> It has 3 interfaces:
>> - Interface 0 is the sensor-hub
>> - Interface 1 is the wacom digitizer=C2=B2 (it's one without finger =
input, there
>> is an atmel digitizer on port 2.4 for finger input)
>> - Interface 2 is the keyboard, if a keyboard cover is attached.
> Oh... yes, indeed, it's gona be tricky :)
>
>> This USB composite device changes it product id depending if and whi=
ch
>> keyboard cover is attached.
>> Each of this hid devices contains several collections, this complica=
ted
>> everything.
>> I have uploaded a lsusb output to: http://pastebin.com/Jun5sa2t
> Thanks
>
>> I have to say, that I'm neither a developer nor a programmer, this m=
eans
>> this things are beyond my ken, please excuse if my remarks aren't ac=
curate.
> But you still made the patches, so you are a programmer :)
>
>> The Touch and Type Covers (2) didn't work out of the box. Someone on=
e the
>> ubuntuforums made a patch which adds them to the microsoft special d=
river,
>> but this leads to loading that driver for all the 3 interfaces and p=
revents
>> loading of hid-sensor-hub for interface 0, if a keyboard cover is at=
tached.
>> Sadly this patch is submitted to the upstream kernel source.
> Well, if it breaks things, it's still time to revert it.
>
>> Without that patch the keyboard covers are loading hid-multitouch in=
stead of
>> hid-generic. This misbehaviour is a result of the fancy hid collecti=
ons,
>> that the keyboards have. With hid-multitouch neither the keyboard no=
r the
>> touchpad of the cover works=C2=B2. I added an if clause to hid_scan_=
input_usage
>> to prevent loading of hid-multitouch for the keyboards. With hid-gen=
eric
>> keyboard and touchpad are working (they come up as one input)
> More comment on that in the patch

I will follow your comments and update the patch.
>
>> We also need the HID_QUIRK_NOGET for this usb composite device, with=
out it
>> hid-sensor-hub fails with a submit urb failure evertime a keyboard c=
over is
>> (de)attached and it takes some seconds until the keyboard and wacom
>> digitizer responds.
> Can you test if HID_QUIRK_NO_INIT_INPUT_REPORTS works. It's a little
> bit less a hammer than NO_GET, and I am pretty sure that this is what
> Windows does by default.
>

Sure, I can give it a try :-)
>> The second patch adds HID_SENSOR_HUB_ENUM_QUIRK for the Surface Pro =
2's
>> sensor-hub. There is still a bug with the sensors and the Surface Pr=
o 2, but
>> I didn't dig into it yet (hid-sensor-magn-3d fails to setup attribut=
es)
>>
>> Regards,
>>
>> Derya
>>
>>
>>
>> 1 I'm also working to get the wacom driver working. At the moment th=
e stylus
>> works with hid-generic(if my patch is applied, without it use
>> hid-microsoft). I got it working with wacom driver without disturbin=
g the
>> other interfaces, but the wacom interface contains also some fancy
>> collection. The wacom driver doesn't care of them, this leads to los=
ing the
>> on device volume and left meta keys. With hid-generic they work, but=
 the
>> input events get distorted after the use of the eraser. But, this is=
 another
>> story...
> For the record, I am tempted (and some people at wacom too) to switch
> the Wacom devices to use hid-wacom instead of wacom.ko. This may solv=
e
> your problems here.
I've looked into hid-wacom and thought, it would be better to use it=20
instead of wacom.ko, but then I saw it contains only wireless device. I=
t=20
seemed to be the wrong place. The other thing is, if I use hid-wacom,=20
then I have to add that USB composite device again to the special drive=
r=20
list, like with hid-microsoft, and this leads us to the same problem. I=
t=20
would load hid-wacom for all 3 interfaces. Or am I wrong? With wacom.ko=
=20
I'm using the macro USB_DEVICE_INTERFACE_NUMBER (instead of USB_DEVICE=20
and USB_DEVICE_AND_INTERFACE_INFO, which are used for other wacon=20
devices) to applied the driver only to the wacom interface without=20
disturbing the other ones.
I will try to use hid-wacom, but this will take some time.

>> 2 @Benjamin Tissoires
>> I have tried your patches for fancy collection in hid-multitouch. It=
 seems
>> to be the right way to solve the problem with the keyboard (better t=
han my
>> approach to exclude this devices in hid_scan_input_usage), but it ha=
s the
>> some drawbacks at the moment. It splits the input into 5 pieces. 2 s=
eperate
>> keyboard inputs that leads into losing the caps lock led. The touchp=
ad is
>> mapped as a mouse. There is also a consumer device, which gives me n=
o input
>> and an unkown device, but no multitouch device. There is a HID_DG_IN=
PUTMODE
>> out of range error in dmesg. Please, contact me, if you need some lo=
gs.
> With the lsusb output I should be able to conduct more tests. But I
> may not have time to do them.
> Did you used the latest patch applied this week by Jiri?

I tried it with this=20
http://www.spinics.net/lists/linux-input/msg30018.html patch set.
>
> Cheers,
> Benjamin
>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-inpu=
t" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 0/2 ] Surface Pro 2 HID sensor, wacom, keyboard/multitouch
 composite device
Date: Fri, 7 Mar 2014 12:56:11 -0500
Message-ID: <CAN+gG=HvxZfKc=ONWDUxzzuSM=XRWEg8HxO3R6dVs=eLAqMrmA@mail.gmail.com>
References: <5319EB7C.5070209@yahoo.de>
	<CAN+gG=GdRwOkZsNWT9H1tRtjTy9bMDkKv1KiMe0tEcThOAvEQA@mail.gmail.com>
	<531A06FC.4030906@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:63046 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453AbaCGR4N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Mar 2014 12:56:13 -0500
Received: by mail-la0-f49.google.com with SMTP id mc6so2982814lab.22
        for <linux-input@vger.kernel.org>; Fri, 07 Mar 2014 09:56:11 -0800 (PST)
In-Reply-To: <531A06FC.4030906@yahoo.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Derya <derya.kiran@yahoo.de>
Cc: linux-input <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>

On Fri, Mar 7, 2014 at 12:50 PM, Derya <derya.kiran@yahoo.de> wrote:
>
> Am 07.03.2014 17:51, schrieb Benjamin Tissoires:
>
>> Hi Derya,
>>
>> On Fri, Mar 7, 2014 at 10:53 AM, Derya <derya.kiran@yahoo.de> wrote:
>>>
>>> The MS Surface Pro 2 has a very annoying USB composite device on po=
rt
>>> 2.3.
>>> It has 3 interfaces:
>>> - Interface 0 is the sensor-hub
>>> - Interface 1 is the wacom digitizer=C2=B2 (it's one without finger=
 input,
>>> there
>>> is an atmel digitizer on port 2.4 for finger input)
>>> - Interface 2 is the keyboard, if a keyboard cover is attached.
>>
>> Oh... yes, indeed, it's gona be tricky :)
>>
>>> This USB composite device changes it product id depending if and wh=
ich
>>> keyboard cover is attached.
>>> Each of this hid devices contains several collections, this complic=
ated
>>> everything.
>>> I have uploaded a lsusb output to: http://pastebin.com/Jun5sa2t
>>
>> Thanks
>>
>>> I have to say, that I'm neither a developer nor a programmer, this =
means
>>> this things are beyond my ken, please excuse if my remarks aren't
>>> accurate.
>>
>> But you still made the patches, so you are a programmer :)
>>
>>> The Touch and Type Covers (2) didn't work out of the box. Someone o=
ne the
>>> ubuntuforums made a patch which adds them to the microsoft special
>>> driver,
>>> but this leads to loading that driver for all the 3 interfaces and
>>> prevents
>>> loading of hid-sensor-hub for interface 0, if a keyboard cover is
>>> attached.
>>> Sadly this patch is submitted to the upstream kernel source.
>>
>> Well, if it breaks things, it's still time to revert it.
>>
>>> Without that patch the keyboard covers are loading hid-multitouch i=
nstead
>>> of
>>> hid-generic. This misbehaviour is a result of the fancy hid collect=
ions,
>>> that the keyboards have. With hid-multitouch neither the keyboard n=
or the
>>> touchpad of the cover works=C2=B2. I added an if clause to
>>> hid_scan_input_usage
>>> to prevent loading of hid-multitouch for the keyboards. With hid-ge=
neric
>>> keyboard and touchpad are working (they come up as one input)
>>
>> More comment on that in the patch
>
>
> I will follow your comments and update the patch.
>
>>
>>> We also need the HID_QUIRK_NOGET for this usb composite device, wit=
hout
>>> it
>>> hid-sensor-hub fails with a submit urb failure evertime a keyboard =
cover
>>> is
>>> (de)attached and it takes some seconds until the keyboard and wacom
>>> digitizer responds.
>>
>> Can you test if HID_QUIRK_NO_INIT_INPUT_REPORTS works. It's a little
>> bit less a hammer than NO_GET, and I am pretty sure that this is wha=
t
>> Windows does by default.
>>
>
> Sure, I can give it a try :-)
>
>>> The second patch adds HID_SENSOR_HUB_ENUM_QUIRK for the Surface Pro=
 2's
>>> sensor-hub. There is still a bug with the sensors and the Surface P=
ro 2,
>>> but
>>> I didn't dig into it yet (hid-sensor-magn-3d fails to setup attribu=
tes)
>>>
>>> Regards,
>>>
>>> Derya
>>>
>>>
>>>
>>> 1 I'm also working to get the wacom driver working. At the moment t=
he
>>> stylus
>>> works with hid-generic(if my patch is applied, without it use
>>> hid-microsoft). I got it working with wacom driver without disturbi=
ng the
>>> other interfaces, but the wacom interface contains also some fancy
>>> collection. The wacom driver doesn't care of them, this leads to lo=
sing
>>> the
>>> on device volume and left meta keys. With hid-generic they work, bu=
t the
>>> input events get distorted after the use of the eraser. But, this i=
s
>>> another
>>> story...
>>
>> For the record, I am tempted (and some people at wacom too) to switc=
h
>> the Wacom devices to use hid-wacom instead of wacom.ko. This may sol=
ve
>> your problems here.
>
> I've looked into hid-wacom and thought, it would be better to use it =
instead
> of wacom.ko, but then I saw it contains only wireless device. It seem=
ed to
> be the wrong place. The other thing is, if I use hid-wacom, then I ha=
ve to
> add that USB composite device again to the special driver list, like =
with
> hid-microsoft, and this leads us to the same problem. It would load
> hid-wacom for all 3 interfaces. Or am I wrong? With wacom.ko I'm usin=
g the
> macro USB_DEVICE_INTERFACE_NUMBER (instead of USB_DEVICE and
> USB_DEVICE_AND_INTERFACE_INFO, which are used for other wacon devices=
) to
> applied the driver only to the wacom interface without disturbing the=
 other
> ones.
> I will try to use hid-wacom, but this will take some time.
>

You can, but you will loose your time I think. I just mentioned that
because I mainly wanted to warn Jiri and others on the list that some
people are thinking of it.
But As you said there is not the thing you need currently for this
device, so if you can manage to use wacom.ko, that's fine.

>
>>> 2 @Benjamin Tissoires
>>> I have tried your patches for fancy collection in hid-multitouch. I=
t
>>> seems
>>> to be the right way to solve the problem with the keyboard (better =
than
>>> my
>>> approach to exclude this devices in hid_scan_input_usage), but it h=
as the
>>> some drawbacks at the moment. It splits the input into 5 pieces. 2
>>> seperate
>>> keyboard inputs that leads into losing the caps lock led. The touch=
pad is
>>> mapped as a mouse. There is also a consumer device, which gives me =
no
>>> input
>>> and an unkown device, but no multitouch device. There is a
>>> HID_DG_INPUTMODE
>>> out of range error in dmesg. Please, contact me, if you need some l=
ogs.
>>
>> With the lsusb output I should be able to conduct more tests. But I
>> may not have time to do them.
>> Did you used the latest patch applied this week by Jiri?
>
>
> I tried it with this http://www.spinics.net/lists/linux-input/msg3001=
8.html
> patch set.

Alright, this is the last one which has been applied by Jiri.
I'll definitively have to check this out them :(

Cheers,
Benjamin

>
>>
>> Cheers,
>> Benjamin
>>
>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-inp=
ut" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

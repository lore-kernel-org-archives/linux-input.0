From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH] input: Add support for the Bamboo Touch trackpad
Date: Wed, 1 Sep 2010 03:48:23 -0700
Message-ID: <AANLkTimCxMpy3B9Cz9_HDGNvXGykCAN3yTc+6KVyVHkp@mail.gmail.com>
References: <1282486241-8855-1-git-send-email-rydberg@euromail.se>
	<AANLkTikvQdxzRm_rWHHz=m4=fpRSTZbMJhVUji2KVmKA@mail.gmail.com>
	<4C7B7595.6060904@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:45275 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155Ab0IAKsY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 1 Sep 2010 06:48:24 -0400
Received: by ewy23 with SMTP id 23so4191494ewy.19
        for <linux-input@vger.kernel.org>; Wed, 01 Sep 2010 03:48:23 -0700 (PDT)
In-Reply-To: <4C7B7595.6060904@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Chris Bagwell <chris@cnpbagwell.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ping Cheng <pingc@wacom.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Monday, August 30, 2010, Henrik Rydberg <rydberg@euromail.se> wrote:
> Hi Chris,
>
>>> 1) It uses the MT slot protocol
>>> 2) It creates two input devices, but only one is useful
>>
>> No biggy to userspace. =A0I'm assuming for unused input device that
>> hardware is still reporting a HID_USAGE_STYLUS and probably you coul=
d
>> catch that and not register that input device.
>
>
> The initial idea was to only use the trackpad usb endnode, but the de=
vice does
> not work at all after boot unless the silent endnode is somehow taken=
 into
> account. I am not sure what your statement refers to.
>
>>> 3) It works well with the synaptics and multitouch X drivers
>>> 4) It does not work well with the wacom X driver (!)
>>
>> Once we finalize input events sent, I'm sure we could get
>> xf86-input-wacom to play nice with this synaptic-style input events.
>> The harder part is to develop userspace rules to assign this "wacom"
>> input device to something other than xf86-input-wacom; especially in
>> case were tablet has pen and touch input devices.
>
>
> Using udev rules, the pen device is picked up by the wacom X driver a=
nd the
> touch device is picked up by the synaptics X driver. It does not seem=
 anything
> extra is needed here.
>
> [...]
>
>> +static int wacom_bbt_irq(struct wacom_wac *wacom, size_t len)
>
>>
>> We need a generic name to represent this family of devices since thi=
s
>> code will eventually be extended for those as well. =A0You've chosen
>> BBTOUCH. =A0There are some devices in family that support pen-only a=
s
>> well as pen&touch.
>
>>
>> I'm personally fine with bbt/BBTOUCH/BAMBO_TOUCH but some may prefer
>
>> BBPT/BBPTOUCH/BAMBOO_PT to show super-set of features in family.
>>
>> This is a generic comment that I'll not mention any more below.
>
>
> All irq handlers seem pretty codified, anyways.
>
>
> [...]
>
>>> +
>
>>> + =A0 =A0 =A0 input_report_key(input, BTN_TOUCH, count > 0);
>>> + =A0 =A0 =A0 input_report_key(input, BTN_TOOL_FINGER, count =3D=3D=
 1);
>>> + =A0 =A0 =A0 input_report_key(input, BTN_TOOL_DOUBLETAP, count =3D=
=3D 2);
>>> +
>>> + =A0 =A0 =A0 input_report_abs(input, ABS_PRESSURE, sp);
>>> + =A0 =A0 =A0 input_report_abs(input, ABS_X, sx);
>>> + =A0 =A0 =A0 input_report_abs(input, ABS_Y, sy);
>>> +
>>> + =A0 =A0 =A0 input_report_key(input, BTN_LEFT, (data[1] & 0x08) !=3D=
 0);
>>
>> This is hardest part were xf86-input-wacom will not want to play nic=
e
>> (reporting button presses and touch events together).
>
>
> I am not sure what you are referring to here. I know of no confusion =
between the
> touch events and actually clicking a button.
>
> [...]
>
>>> + =A0 =A0 =A0 input_report_key(input, BTN_MIDDLE, (data[1] & 0x06) =
!=3D 0);
>>> + =A0 =A0 =A0 input_report_key(input, BTN_RIGHT, (data[1] & 0x01) !=
=3D 0);
>>
>> There are 4 buttons on your tablet, right? =A0Why did you map middle=
 2
>> buttons to =A0single BTN_MIDDLE? =A0Thats better for userspace I thi=
nk.
>
>
> Because of the similarity with a three-button mouse. Clicking the "I =
am a
> leftie" option will also revert the buttons properly.
>
>> If we wanted to be close to windows mappings then probably
>> BTN_RIGHT=3D0x1, BTN_LEFT=3D0x2, BTN_MIDDLE=3D0x4, BTN_4=3D0x8.... o=
r
>> something like that. =A0The 2 button split layout makes it awkward f=
or
>> user to guess what button order is though so not sure windows defaul=
t
>> layout is required.
>
>
> Right.
>
>>> @@ -1213,11 +1279,19 @@ static const struct wacom_features wacom_fe=
atures_0xE3 =3D
>>> =A0 =A0 =A0 =A0{ "Wacom ISDv4 E3", =A0 =A0 =A0 WACOM_PKGLEN_TPC2FG,=
 =A0 =A026202, 16325, =A0255, =A00, TABLETPC2FG };
>>> =A0static const struct wacom_features wacom_features_0x47 =3D
>>> =A0 =A0 =A0 =A0{ "Wacom Intuos2 6x8", =A0 =A0WACOM_PKGLEN_INTUOS, =A0=
 =A020320, 16240, 1023, 31, INTUOS };
>>> +static const struct wacom_features wacom_features_0xD0_0 =3D
>>> + =A0 =A0 =A0 { "Wacom Bamboo Touch", =A0 WACOM_PKGLEN_BBTOUCH, =A0=
 480, =A0320, 255, 0, BAMBOO_TOUCH };
>>> +static const struct wacom_features wacom_features_0xD0_2 =3D
>>> + =A0 =A0 =A0 { "Wacom Bamboo Boot", =A0 WACOM_PKGLEN_BBFUN, =A0 =A0=
 480, =A0320, 255, 0, BAMBOO_BOOT };
>>
>> I'm curious why your breaking these out into 2 lines (not that its a
>> bad idea, I'm just curious)? =A0Other wacom devices with similar iss=
ue
>> would just define it a single time still.
>
>
> In the hope that it would work to register only the active endnode, p=
lus getting
> a natural definition of every endnode of the usb device.

We always get two logical ports for the pen and touch devices, which
are created by udev (or something in the kernel that I am not so
sure). The Wacom driver can not do much about it. I guess the firmware
of your touch-only Bamboo added the pen interface to the protocol.
That's why you see two ports (I can not access the device to test my
idea before next month).

> Since Ping had issues
> with this too, I will change it to the read-and-modify-later approach=
 used in
> the rest of the driver.

Thank you for your consideration. Please use the existing approach so
we can maintain an unified interface. There should not be too much
confusion with the existing approach since pen and touch will not be
on the same logical port anyway.

>> Also, what does BOOT mean? =A0In Bamboo Pen&Touch device, this would=
 be
>> the pen input. =A0So at minimum BAMBOO_PEN is more accurate name.
>
>
> For the Bamboo Touch, pen is not accurate. Boot comes from the HID sp=
ecification
> (boot interface, mouse protocol), but no name seems appropriate since=
 the node
> should not even be there.

Right now, we just tell users to ignore pen or touch if their device
does not support pen or touch (running an X server older than 1.4). In
the X Wacom driver for servers newer than 1.4, we check the valid
tools supported by the device before adding them. End users should not
need to worry about those details, at least in theory.

Maybe we can add this "tool type check method" into the evdev and/or
synaptics X driver as well?

Ping
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

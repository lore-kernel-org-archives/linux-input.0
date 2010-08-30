From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH] input: Add support for the Bamboo Touch trackpad
Date: Mon, 30 Aug 2010 11:19:49 -0500
Message-ID: <AANLkTikh6r+-aeiqT7nq3Z4jL+WZK22G4zVeUwQFLfr1@mail.gmail.com>
References: <1282486241-8855-1-git-send-email-rydberg@euromail.se>
	<AANLkTikvQdxzRm_rWHHz=m4=fpRSTZbMJhVUji2KVmKA@mail.gmail.com>
	<4C7B7595.6060904@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:43467 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755826Ab0H3QTv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Aug 2010 12:19:51 -0400
Received: by gwj17 with SMTP id 17so2024979gwj.19
        for <linux-input@vger.kernel.org>; Mon, 30 Aug 2010 09:19:50 -0700 (PDT)
In-Reply-To: <4C7B7595.6060904@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ping Cheng <pingc@wacom.com>, linux-input@vger.kernel.org

Hi Henrik,

On Mon, Aug 30, 2010 at 4:10 AM, Henrik Rydberg <rydberg@euromail.se> w=
rote:
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

You mean your wacom touch device are being directed to synaptics X
driver without modifications to udev or similar rules?  On my
unmodified Fedora box, they both go to wacom X driver.

Not that it would be a difficult modification... I'd just need to make
those and work with distributions to also align.

[...]

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

If you remap the bamboo touchpad device to xf86-input-wacom, the
reason it doesn't play nice is because it expects only 1 "tool" to be
sent per EV_SYN.

It considers the touchpad buttons as one tool and uses BTN_TOOL_FINGER
to indicate when one or more buttons are pressed.  It considers the
fingers and their X/Y/pressure/etc to be another tool and uses one of
BTN_TOUCH/BTN_TOOL_DOUBLETAP/BTN_TOOL_TRIPLETAP to indicate one or
more fingers pressed.

In your patch, button presses do not get separated out with a
BTN_TOOL_FINGER and EV_SYN.  Since the intent is for this touchpad
device to go to synaptics X driver, no real issue with your patch.
I'll work with wacom X driver side so that if a synaptics-like input
device gets mapped to it by a generic "*wacom*" pattern, it handles it
gracefully.

[...]

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

I constantly switch between left and right handed input devices so
understand well that would be nice.  But the loss of that 4th button
will be a problem for end users.  Wacom tablet people seem to love
their buttons and custom assignments (often mapped to keystrokes
rather than button presses).

Userspace can simulate same above behavior for subset of times when
its useful by remapping the 2nd middle button to same as 1st middle
button and then toggling liftie option will work well.

[...]

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
> a natural definition of every endnode of the usb device. Since Ping h=
ad issues
> with this too, I will change it to the read-and-modify-later approach=
 used in
> the rest of the driver.

There are some possible benefits to splitting it but hiding an endnode
is not one.

My comment about HID_USAGE_STYLUS can be better said like this:  I'd
assume in wacom_probe() you can add an "if (!BAMBOO_BOOT)" around the
call to input_register_device() to hide the unneeded input device to
user.   If you switch to read-and-modify approach then
HID_USAGE_STYLUS maps to modify trigger and how to detect the useless
input device for Bamboo Touch's.

>
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

Ah, OK.  I understand BOOT now.

There are 3 main tablets in this family and your code should
eventually be extended to include all three.  1) Touch-only, 2) Pen
and Touch, 3) Pen-only.

It seems wacom uses same USB controller in all cases but in #1 and #3
just do not report data for unused feature.  So BAMBOO_TOUCH is
meaningless in #3 case but name has good meaning for #1 and #2.
Similar, I think BAMBOO_PEN is good for #2 and #3 even though for #1
its meaningless.

But BAMBOO_BOOT is also fine in place of BAMBOO_PEN as long as we
comment that we are talking USB terms and not hardware features.

Chris

>
> Henrik
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

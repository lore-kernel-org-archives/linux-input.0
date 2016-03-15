From: Roderick Colenbrander <thunderbird2k@gmail.com>
Subject: Re: Handling of non-positional data through evdev
Date: Tue, 15 Mar 2016 14:09:21 -0700
Message-ID: <CAEc3jaBQJNmYwxZzXn7qeuO_9KgD=jhihPZ04h-+V+vY_o_3aQ@mail.gmail.com>
References: <CAEc3jaB2KOUoymz3BL6Bc7_vv3bTHadBqGM9YLHyt_GeVkOtng@mail.gmail.com>
	<CAN+gG=EELgs8n7Cbf4akP-sYpBxoX07JX76R9RfR8HTY69xkfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36349 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926AbcCOVJW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Mar 2016 17:09:22 -0400
Received: by mail-pf0-f181.google.com with SMTP id u190so44007748pfb.3
        for <linux-input@vger.kernel.org>; Tue, 15 Mar 2016 14:09:22 -0700 (PDT)
In-Reply-To: <CAN+gG=EELgs8n7Cbf4akP-sYpBxoX07JX76R9RfR8HTY69xkfw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>, David Herrmann <dh.herrmann@gmail.com>

Hi Benjamin,

Thanks for your reply so far. I wasn't aware of hwdb, but it could be
interesting for us for some situations.

My device is more like a joystick with many directional axes in
addition to the accelerometer and gyro functionality. I can easily
remap the sensor axes to be reported using REL_* constants, but the
main issue for me are the units. The device has many keys, axes and
the only way to only solution is to hard code the data type in the
application on whether to interpret relative axis data as e.g. units
per rad/s, units per G or units per mm.

Ideally I'm looking for a way to solve the unit problem, but I'm not
sure yet how (new axis type or new ioctl...)

Thanks,
Roderick

On Tue, Mar 15, 2016 at 1:07 PM, Benjamin Tissoires
<benjamin.tissoires@gmail.com> wrote:
> HI Roderick,
>
> [adding some people in the discussion]
>
> On Tue, Mar 15, 2016 at 8:26 PM, Roderick Colenbrander
> <thunderbird2k@gmail.com> wrote:
>> Hi all,
>>
>> I'm working on a device driver for an input device, which has both
>> directional axes in addition to sensors (accelerometer and gyro). I'm
>> trying to figure out how to map these axes properly, but I'm stumbling
>> on some road blocks. Directional axes should be mapped to e.g.
>> ABS_X/_Y/_Z, while relative axes make most sense for sensors. The main
>> issue I'm seeing is that there is no way to determine using evdev what
>> type of data is exposed on an axis.
>
> I am not entirely sure of what you mean by "relative axes". In the
> evdev world, relative axes are given through REL_* and there is a
> clear separation between relative (think mice) and absolute (think
> touchscreen).
>
>>
>> Based on definitions in input.h, it seems traditionally ABS_X/_Y/_Z
>> had a resolution of 'units per millimeter', while ABS_RX/_RY/_RZ where
>> meant for rotational axes in 'units per radian'. Over the years
>> handling of these axes evolved, where gamepads often use
>> ABS_RX/_RY/_RZ for the right stick, which is 'units per millimeter'.
>
> According to our API, ABS_X/Y/Z are positional axis, and are reported
> no matter what as "unit per mm" as you mentioned.
> ABS_RX/RY/RZ are "rotation X/Y/Z" and are indeed reported as "unit per radian".
>
> This is also what the HID specification says in the HID usage table,
> page 29, section 4.2
> (http://www.usb.org/developers/hidpage/Hut1_12v2.pdf).
>
> The problem you are seeing is either a bug in the specific driver of
> the gamepad, or the fact that the HID report descriptor is not well
> understood by us, and we end up using ABs_X|Y for the left stick and
> then use the next available ones for the right one: ABS_Z/ABS_RX. This
> is ugly, but given that this is how things work for a long time, we
> can't fix those without a lot of bandaids for backward compatibility.
>
>>
>> In a similar way some drivers are currently reporting acceleration
>> through absolute axes (e.g. wii driver). The application has to know
>> it is dealing with the wii gamepad to be able to really understand the
>> data. Then there is also a special flag 'INPUT_PROP_ACCELEROMETER'
>> which some drivers use to report acceleration data through absolute /
>> relative axes provided the device doesn't report any directional axes
>> on that same node.
>
> Yes, this is now the prefer way. We can report acceleration through
> ABS_X/Y/Z, but the driver needs to set the property you mentioned. If
> it is not set, ask the driver maintainer to set it.
>
>>
>> As I have shown, handling of non-positional data is sort of handled
>> now on a case by case basis. As an application developer you pretty
>> much have to check the product/vendor IDs to really be able to handle
>> a device. You can't just rely on detecting the type of axes. Moving
>> forward I would like to determine what the best way of handling
>> non-positional data is through evdev.
>
> The best way would actually not handling this in the final
> application, but at the system level. udev already tries to tag
> devices (JOYSTICK, ACCELEROMETER, TABLET, etc...). And any per VID/PID
> configuration can easily be solved by adding a hwdb entry. Udev
> already have a heuristic to determine which device is which, and it is
> best to not duplicate this in each and every application.
>
>>
>> In my opinion the main problem of the current API is that there is no
>> way to determine what 'unit' is reported on an axes. Is it positional
>> data, is it (angular) velocity, is it acceleration, something else?
>> Ideally I think there should have been some 'type' field in
>> 'input_absinfo', which allowed someone to determine the data type and
>> e.g. map a resolution of '1024' units to 1G of acceleration or a
>> certain number of radians per second. Unfortunately user space can't
>> be broken, but potentially a new ioctl could be invented to add such
>> information (if that's the way forward) returning e.g.
>> 'input_relinfo'. Another option is to add a new axis type.
>
> Again, for relative, we have REL_* events. I concede that the evdev
> protocol might lack some information (the low level HID protocol is
> much more flexible in term of units, resolution, and extendability),
> but so far we hae been able to circumvent most of the limitations.
>
>>
>> What are your thoughts on this matter? Ideally I would like to find a
>> nice solution if possible.
>
> My solution would be:
> - check and rely only on the udev properties. This is already what
> libinput does. Also this has the good benefit of being able to say to
> your users: "if it doesn't work, add the following hwdb entry, reload
> the hwdb, and you will be fixed". And if the axis are wrong, you can
> already use the ioctl to remap the axis to something more sensible
> (can't remember if udev as a builtin that does that). You can also
> extend the udev properties attached to the devices you are working
> with (this is what we do in libinput and libratbag) if you want to
> classify the devices (crappy-device-with-abs-rx, very-good-one). You
> can ship those rules with your application and only you will use them.
> - but also report as many misconfigured devices as possible upstream
> to their maintainers (here on this list, and ideally add the right
> person by looking at the driver code).
>
> Cheers,
> Benjamin
>
>>
>> Thanks,
>> Roderick
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-input" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

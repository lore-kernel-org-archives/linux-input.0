From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH 0/6] HID: sony: More Sony controller fixes and improvements.
Date: Sun, 2 Mar 2014 18:21:30 +0100
Message-ID: <CANq1E4SksnfqLxMnX-_C_DCtHSMCKn7Juyxguv9zmRMN+4zbcw@mail.gmail.com>
References: <1393646341-16947-1-git-send-email-frank.praznik@oh.rr.com>
	<20140301145346.d1b3305ba0b186d452a34beb@ao2.it>
	<53135BA6.9090501@oh.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:45133 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685AbaCBRVb (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 2 Mar 2014 12:21:31 -0500
Received: by mail-ig0-f182.google.com with SMTP id uy17so5759940igb.3
        for <linux-input@vger.kernel.org>; Sun, 02 Mar 2014 09:21:31 -0800 (PST)
In-Reply-To: <53135BA6.9090501@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@oh.rr.com>
Cc: Antonio Ospite <ao2@ao2.it>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

Hi

On Sun, Mar 2, 2014 at 5:26 PM, Frank Praznik <frank.praznik@oh.rr.com> wrote:
> On 3/1/2014 08:53, Antonio Ospite wrote:
>>
>> Hi Frank,
>>
>> On Fri, 28 Feb 2014 22:58:55 -0500
>> Frank Praznik <frank.praznik@oh.rr.com> wrote:
>>
>>> This set consists of one bugfix, two mostly cosmetic changes and three
>>> larger
>>> patches for the LED subsystem.
>>>
>>> Patch #4 adds hardware blink support to the controller LEDs.  Values from
>>> 0 to
>>> 2.5 seconds are supported by the hardware.  The Sixaxis can set all of
>>> the LEDs
>>> individually, but the DualShock 4 only has one global setting for the
>>> entire
>>> light bar so only the value from the most recently set LED is used.
>>>
>> Adding this is OK, as it adds access to something supported by the
>> hardware.
>>
>>> Patch #5 adds an LED trigger that reports the controller battery status
>>> via the
>>> registered LEDs.  The LEDs will flash if the controller is charging or if
>>> the
>>> battery is low, and remain solid otherwise.
>>>
>> This kind of logic _may_ belong to userspace. More comments in the
>> actual patch.
>
> Functionally this trigger is no different from the ones registered by the
> power supply system when a battery is registered, aside from the specific
> conditions under which the LED blinks.  I can understand the reservations
> about setting it as the default, but at the same time it's a trigger which
> can be easily disabled on the controller LEDs or be used to control other
> LED devices if the user desires it.
>
> If this is something best kept out of kernel code though, that's fine.
>
>>
>>> Patch #6 initializes the LEDs to a default value of LED 1 on the Sixaxis
>>> and
>>> blue on the DualShock 4 so there is some indication that the controller
>>> is
>>> powered on and connected in the case of Bluetooth.  The code can be used
>>> to set
>>> the LEDs based on the device number, but I'm not sure how to actually
>>> retrieve
>>> the controller number from the system.  I saw the xpad patches posted a
>>> few
>>> weeks ago where the minor number of the joydev device was used, but I'm
>>> under
>>> the impression that doing that is not ideal.  Any suggestions?
>>
>> Setting the controller number is done by the bluez sixaxis plugin[1]
>> (in bluez 5.x) following the X in /dev/input/jsX, this covers the
>> case of a mixed-joypad scenario, IMHO it makes sense that the
>> controller number matches the joystick device number.
>> Imagine js0->Sixaxis1, js1->wiimote, js2->Sixaxis2, I think it make
>> sense to have the LEDs on Sixaxis2 say "controller 3", not 2.
>>
>> This has been done in userspace with libudev for 2 reasons:
>>    1. the hid drivers should not have knowledge of the joystick layer;
>>    2. kernel drivers should be as simple as possible, and try to just
>>       exposing hardware functionalities but with as less "business logic"
>>       as possible in them.
>>
>> The current implementation in the bluez plugin uses hidraw, but support
>> for the sysfs led class could be added in order to avoid conflicts with
>> the rumble; IIRC, currently, setting rumble values could override the
>> LED settings done via hidraw, because the LEDs state is not tracked in
>> the latter case.
>>
>> Ciao,
>>     Antonio
>>
>> [1]
>> http://git.kernel.org/cgit/bluetooth/bluez.git/tree/plugins/sixaxis.c
>>
> This can be done in the driver. See
> https://www.mail-archive.com/linux-input@vger.kernel.org/msg08103.html
>
> It seems that the main problem with that patch is that modern systems
> shouldn't be relying on joydev for this functionality.  I'd like to know
> what David Herrmann and Greg Kroah-Hartman came up with regarding the
> solution mentioned in the reply as it would be nice to be able to set the
> LEDs to the proper default values in the driver without needing to rely on
> an external daemon. Setting the defaults in the driver doesn't interfere
> with setting custom values after the device is initialized, so there are no
> issues if the user wants to use a custom LED daemon.

The application using the controllers should do this. It allows to set
coherent values across different devices and buses. So you can have
one BT device, one USB device and one whatever device, but assign
sequential numbers to them from the application. We cannot do that in
the kernel, as we don't know which policy to follow. However, we can
provide a sane default. joydev is the *wrong* way to do that, though.
Instead, you should just use an ida/idr in your driver and assign
numbers properly. You can also use usb-interface-ids or similar if
they make sense. But please don't try to access input-handlers like
evdev or joydev. They're one layer atop, not below your driver!

Thanks
David

From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 2/2] input - leds: fix input_led_disconnect path
Date: Wed, 20 Dec 2017 19:42:50 +0100
Message-ID: <CAO-hwJ+u=MtRKK7dCb1wdH0Ljw+adzjbAXZXeGDSxh90HOLC8Q@mail.gmail.com>
References: <20171214132522.20346-1-benjamin.tissoires@redhat.com>
 <20171214132522.20346-3-benjamin.tissoires@redhat.com> <20171216004846.3blocf4u45adwalh@dtor-ws>
 <CAO-hwJK1j6Kx=dT1uYi0DicuuU3qSLg7buoyGq2mqZStFG6Qkg@mail.gmail.com> <CAKdAkRS40XySAWRakx27prKu11dfirA+V=C2ksDfiOcJzRee+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:39113 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755774AbdLTSmv (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 20 Dec 2017 13:42:51 -0500
Received: by mail-qk0-f196.google.com with SMTP id u184so27908456qkd.6
        for <linux-input@vger.kernel.org>; Wed, 20 Dec 2017 10:42:51 -0800 (PST)
In-Reply-To: <CAKdAkRS40XySAWRakx27prKu11dfirA+V=C2ksDfiOcJzRee+A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Peter Hutterer <peter.hutterer@who-t.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, "3.8+" <stable@vger.kernel.org>

On Wed, Dec 20, 2017 at 7:20 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Wed, Dec 20, 2017 at 9:11 AM, Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
>> On Sat, Dec 16, 2017 at 1:48 AM, Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>>> Hi Benjamin,
>>>
>>> On Thu, Dec 14, 2017 at 02:25:22PM +0100, Benjamin Tissoires wrote:
>>>> Before unregistering the led classes, we have to be sure there is no
>>>> more events in the input pipeline.
>>>> Closing the input node before removing the led classes flushes the
>>>> pipeline and this prevents segfaults.
>>>
>>> I do not think this actually the issue. input_leds_event() is an empty
>>> stub, it does not really do anything with events it receives form input
>>> core, and it does not reference the led structures. The way input leds
>>
>> Right. Actually, we could simply drop the stub as input_to_handler()
>> checks for the validity of .event().
>>
>>> work is that input driver owns the hardware led and is responsible for
>>> communicating with it. The LED subsystem is a secondary interface,
>>> requests coming from /sys/class/led/... are being forwarded to the input
>>> core and then to the input hardware driver by the way of:
>>>
>>> input_leds_brightness_set() ->
>>>         input_inject_event() ->
>>>                 input_handle_event()->
>>>                         disposition & INPUT_PASS_TO_DEVICE
>>>                                 dev->event() (in atkbd or hid-input)
>>>                                         actual control of LED
>>>
>>> I do not see how stopping event flow from input core to input-leds would
>>> help here.
>>
>> I wonder if this solution in this patch is not just masking the race
>> condition by forcing the sync.
>>
>> After further researches, I realized that the patch is actually not
>> needed. In the upstream repo of Peter, the code inject events and
>> closes the device ASAP, triggering races with udev.
>> Adding the proper udev stubs seem to solve the issues.
>> I still have other random crashes, but I can't seem to reproduce the
>> error of https://bugzilla.kernel.org/show_bug.cgi?id=197679 now.
>>
>> Anyway, I can't explain the backtrace of the kernel bug, it is as if
>> we are calling the unregister function without having properly
>> registered the device. But this can not happen because of the mutexes
>> in place.
>> The race seems to be udev and probably the led class accesses...
>
> I wonder if the crash was observed only with your first patch adding
> the delay in initializing the leds?

Nah, the bug was initially found by Peter on a plain Fedora system
without my crap :)

>
>>
>> BTW, if the handler doesn't use the events coming in from the input
>> subsystem, is there any benefits of opening the device from the
>> handler?
>> I tried without, and it seemed to be working fine, but I wonder if
>> there is no hidden dependency I haven't see.
>
> You want to open the device as it is what essentially powers it up, so
> that it can react to input_inject_event() sent via LED subsystem. In
> case of atkbd input_open_device() will result in call to serio_open()
> which enables the KBD port of i8042. You probably do not see any
> difference because the VT subsystem already attached the keyboard
> handler to the device and it already "opened" the device in question.
>

Right. So I guess there is not much to do then :)

Cheers,
Benjamin

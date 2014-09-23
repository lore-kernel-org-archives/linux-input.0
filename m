From: Andrew de los Reyes <andrew-vger@gizmolabs.org>
Subject: Re: How to indicate hover touch when exact distance unknown?
Date: Tue, 23 Sep 2014 09:46:43 -0700
Message-ID: <CAG_cf+fuugk4QK_1BtWnJWzunWT4QeSus_2cuPpYH_8UCUjMOQ@mail.gmail.com>
References: <CAG_cf+dJfiqW_V1k4MfGMBNUK9Kgc4=9BPAuum7dbs6rkmAgrQ@mail.gmail.com>
 <20140923145916.GA3110@mail.corp.redhat.com> <20140923162811.GB40700@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yh0-f41.google.com ([209.85.213.41]:63748 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755502AbaIWQrF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Sep 2014 12:47:05 -0400
Received: by mail-yh0-f41.google.com with SMTP id b6so2857728yha.14
        for <linux-input@vger.kernel.org>; Tue, 23 Sep 2014 09:47:03 -0700 (PDT)
In-Reply-To: <20140923162811.GB40700@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, hdegoede@redhat.com, rydberg@euromail.se, jikos@jikos.cz, David Herrmann <dh.herrmann@gmail.com>, peter.hutterer@who-t.net, Linux Input <linux-input@vger.kernel.org>

On Tue, Sep 23, 2014 at 9:28 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Benjamin,
>
> On Tue, Sep 23, 2014 at 10:59:16AM -0400, Benjamin Tissoires wrote:
>> Hi Andrew,
>>
>> On Sep 23 2014 or thereabouts, Andrew de los Reyes wrote:
>> > Hi folks,
>> >
>> > More and more we're seeing touch input devices that support detection of
>> > fingers that are above the surface and not touching. We were thinking of
>> > writing a kernel patch for one such device. Normally we would indicate
>> > distance with ABS_MT_DISTANCE, but we ran into the problem that sometimes
>> > the hardware will not be able to report a distance (or will stop reporting
>> > a distance when it's too great a number), and we had the (bad) idea to
>> > simply report a value or 1 or 255 or something like that when distance is
>> > unknown.
>>
>> FWIW, hid-multitouch already support those devices.
>> ABS_MT_DISTANCE is set with a min/max of 0/1 when we detect win8
>> certified panels with hovering capability. By default the spec does not
>> provide the distance IIRC, and you only have one byte: InRange.
>
> Hmm, I missed that and this is unfortunate. The ABS capabilities
> advertised by the devices should match their real capabilities. If
> device can't properly report distance it should not be using
> ABS_MT_DISTANCE/ABS_DISTANCE...
>
>>
>> I think Xorg can deal with that (the touch emulation discards the
>> ABS_MT_DISTANCE, but the xorg-evdev driver should be smart enough to not
>> take BTN_TOUCH into account).
>>
>> >
>> > Dmitry warned that a similar thing happened with PRESSURE a while ago, and
>> > it was a mess as different drivers did different things.
>>
>> As I said, IIRC, xorg-evdev is fine with that. For generic desktop, we
>> have to make sure libinput is aware, and then you only have to handle
>> your own xorg chromebook driver. This is not something which scares me
>> that much, especially given that this is what hid-multitouch reports
>> since the v3.9 kernel.
>> libinput is based on a per slot device information, so it is really easy
>> to implement if it is not already in place. xorg-Synaptics and xorg-Wacom
>> should not be ported to wayland from what I understood, so the mess with
>> several implementations can be solved easily.
>>
>> >
>> > We are now wondering if we should come up with a standard way to indicate
>> > hover with or without distance (or with distance being optional). Dmitry
>> > had the idea for a new tool type, HOVER; FINGER would be for touches that
>> > are actually touching.
>>
>> The tool is still the finger.
>
> Do we reliably know that it is a finger and not a pen or eraser or some
> other tool? If we do then obviously introducing new tool will not fly.

On a capacitive sensor, I think we do know, at least for finger vs
active stylus. To be fair, I do not spend much time working with
styluses, so I may not have the most info.

>
>> So I am not very happy with having a new
>> tool. In the end, it may also disturb older clients which will not know
>> what to do with HOVER.
>> And the ABS_MT_DISTANCE approach used to be fully retro-compatible
>> (assuming that the hovering distance is small enough for the user not to
>> detect it).
>
> Except that if we start getting devices that can actually tell the
> distance we'd need special casing 0/1 handling, no?
>
> Thanks.
>
> --
> Dmitry
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

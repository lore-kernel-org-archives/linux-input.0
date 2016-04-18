From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: Re: [hid-sony] sony_controller_battery led triggers not working
Date: Mon, 18 Apr 2016 11:46:43 -0400
Message-ID: <CAH+9E3oVgpnoH0CPy-vLbM3g+B-dmD8K+FTusU7J-4R36M=BXA@mail.gmail.com>
References: <20160417172716.b9ba5813cab5d26a6a3bb8ca@gmx.com>
	<909A6235-AA45-4531-9792-82385AEB6A29@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:32876 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053AbcDRPqo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Apr 2016 11:46:44 -0400
Received: by mail-io0-f180.google.com with SMTP id o126so198678769iod.0
        for <linux-input@vger.kernel.org>; Mon, 18 Apr 2016 08:46:44 -0700 (PDT)
In-Reply-To: <909A6235-AA45-4531-9792-82385AEB6A29@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lauri Kasanen <cand@gmx.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Antonio Ospite <ao2@ao2.it>, Frank Praznik <frank.praznik@oh.rr.com>

On Sun, Apr 17, 2016 at 1:40 PM, Frank Praznik <frank.praznik@gmail.com=
> wrote:
>
>> On Apr 17, 2016, at 10:27, Lauri Kasanen <cand@gmx.com> wrote:
>>
>> Hi,
>>
>> The battery triggers aren't working for some reason, trying to write
>> them comes back with -EINVAL. I'm on somewhat old kernel, 3.17, but =
the
>> relevant parts haven't changed from the commit Frank made in 2014
>> adding the MAC address to the name.
>>
>> # cat trigger
>> none timer heartbeat backlight [default-on]
>> sony_controller_battery_00:26:5c:31:a2:c8-charging-or-full
>> sony_controller_battery_00:26:5c:31:a2:c8-charging
>> sony_controller_battery_00:26:5c:31:a2:c8-full
>> sony_controller_battery_00:26:5c:31:a2:c8-charging-blink-full-solid
>>
>> # echo sony_controller_battery_00:26:5c:31:a2:c8-charging-blink-full=
-solid > trigger
>> bash: echo: write error: Invalid argument
>>
>> The shorter triggers do work. Is it something caused by the long nam=
e,
>> or the colons? Do they work for others?
>>
>> My controller is the Gasia one:
>> sony 0003:054C:0268.0005: input: USB HID v1.11 Joystick [Gasia Co.,L=
td
>> PS(R) Gamepad] on usb-0000:00:12.2-2.3/input0
>>
>> - Lauri
>
> Hi Lauri,
>
> Those trigger names are automatically created by the battery subsyste=
m.  The problem is that in leds.h TRIG_NAME_MAX is only 50 characters a=
nd these trigger names are exceeding that by quite a bit, so they are b=
eing truncated when passed to the function led_trigger_store() in led_t=
riggers.c.
>
> Either the battery names must be shortened significantly or the max a=
llowed trigger name length has to be increased.  A 50 character limit d=
oes seem a bit low when a suffix such as "charging-blink-full-solid=E2=80=
=9D can use half of the character budget by itself.
>
> Regards,
> Frank

It looks like there was a commit to the LED system last month that
should fix this bug.

https://git.kernel.org/cgit/linux/kernel/git/j.anaszewski/linux-leds.gi=
t/commit/?h=3Ddevel&id=3D9e91f65984796c94cd05faba5885c86e349f2aa5
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: hidraw with exclusive access ?
Date: Tue, 17 Mar 2015 18:41:49 -0400
Message-ID: <CAN+gG=HVTBEyiYQr=36Mn+zyB1-ncFPAkqT1bsyVFRVX8Wcr+A@mail.gmail.com>
References: <20150313083758.076c8dfb@vostro>
	<CAN+gG=GdNpqDTazZD6_4r8AmWqbZg-_w8M2-6PDdvKjwdFfFWw@mail.gmail.com>
	<20150316203912.75b32686@vostro>
	<CAN+gG=FXY9m8ygQ+e_JCt=7m3+mRHCYiDLmwggpHQbSDD6etvA@mail.gmail.com>
	<20150316221733.158c4943@vostro>
	<CAN+gG=Hsbf1WyBNmt=m+MHyiKVJBmzY+-MGD4qf9PSOab0U7PQ@mail.gmail.com>
	<20150317085157.1a2f30ad@vostro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:34648 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932554AbbCQWlu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Mar 2015 18:41:50 -0400
Received: by qgh62 with SMTP id 62so22666116qgh.1
        for <linux-input@vger.kernel.org>; Tue, 17 Mar 2015 15:41:49 -0700 (PDT)
In-Reply-To: <20150317085157.1a2f30ad@vostro>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Timo Teras <timo.teras@iki.fi>
Cc: linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>

On Tue, Mar 17, 2015 at 2:51 AM, Timo Teras <timo.teras@iki.fi> wrote:
> On Mon, 16 Mar 2015 16:44:37 -0400
> Benjamin Tissoires <benjamin.tissoires@gmail.com> wrote:
>
>> On Mon, Mar 16, 2015 at 4:17 PM, Timo Teras <timo.teras@iki.fi> wrote:
>> > They are complicated and configurable devices. They can work in the
>> > macro mode, and I believe the device can send a sequence of
>> > keypresses
>> > - at least some of them, but not all. Additionally some of the
>> > devices appear as multiple HID devices. E.g. the joystick models
>> > show up as three HID devices: their "SPLAT" interface, one keyboard
>> > and one joystick (or mouse) device.
>> >
>> > It might make sense to allow the Joystick to show up as regular
>> > joystick by default. But to make the SPLAT interface work properly,
>> > also the other HID events need to be processed. So currently I have
>> > code that reads all three related hidraw devices, but acts only
>> > based on the SPLAT one.
>>
>> IMO, none of this seems to be valid reasons to not look into a kernel
>> solution. you can have cross hid interface knowledge in the driver
>> (that's what wacom does) and you can fine control what you want to
>> forward from within the driver.
>
> Well, in perfect world the someone would have written the driver

No, in a perfect world, you would still have to write the kernel
driver. Most of the upstream developers don't have usage for it (or
were not told by their employer to work on that), so nobody took care
of it.
In an even better perfect world, the hardware maker would have
submitted patches and contributed, but that's impossible to ask
apparently.

> already. I'd be happy to use it. Unfortunately, I don't currently have
> time to write a kernel driver (it's not too complicated or even that
> big project - but still, doing the hidraw implementation is still
> simpler and faster for my immediate needs).

Just to make my point. This really feels like: "can someone please do
my job?". You might not meant it that way, but insisting of the fact
that you don't have the time to do it does not motivate us to
implement it for you.

>
> I should probably fire up the windows drivers for the keyboard. Maybe I
> can remap it to not give regular keyboard/mouse events at all.
>
>> > I found it simpler to implement the protocol in my app, instead of
>> > writing a kernel interface for it. Doing the kernel driver would
>> > make
>>
>> But this way, only your application can make use of the device. Others
>> will have to duplicate it or reinvent the logic if they want to use an
>> other environment You made reference at one point of a program in
>> python, and I guess people might not want to have python daemon
>> running in the background. Even if your driver is written in C or any
>> other language, people won't have a generic access to it.
>>
>> > more sense if there was a way to map LEDs to keys already. Otherwise
>> > I'm just inventing an abstraction that just makes me write more
>> > code... and will probably eventually be replaced by something else.
>>
>> I doubt that this will be so much of a pain. You just have to port
>> your code in the kernel and have a small char sysfs interface to
>> design. And even if something else is more powerful that your custom
>> made interface, for legacy purposes, we will have to keep it in the
>> kernel.
>
> Agreed.
>
> Though if someone was to write this driver. Where should this keys be
> mapped to? I don't see any consecutive area of 128 keys that do not
> have specific meaning. KEY_F1...KEY_F24 sound appropriate, as well as
> KEY_FN_F1... But the largest one is still 128 keys.

No. I was thinking at a custom made one:
Something like:
# echo remap 1 29 46 > /sys/bus/hid/driver/your_driver/macro_keys

where:
- 1 is the key you want to remap
- 29 is the keycode for KEY_LEFTCTRL
- 46 is the keycode for KEY_C

You could allow several keys to be pressed at once this way.

You can also think at a way of passing several bindings through one
call. "remap" could also be omitted.

>
> Any suggestion on the sysfs interface controlling the backlighting of
> each individual key (each key has both blue and red LED underneath it -
> they all can be controlled individually). There's also two generic leds
> which could be mapped also to the regular input's led system.

Let the generic ones be handled by hid, and you can adapt the above to
set the color of the LEDs:

# echo 2 blue > /sys/bus/hid/driver/your_driver/led_color
# echo 2 15 > /sys/bus/hid/driver/your_driver/led_brightness

>
>> > I'd like to have a generic in-tree solution. For my immediate needs,
>> > I'd be happy using hidraw as long as I have some mechanism to
>> > exclude feeding that HID device to regular input system.
>>
>> Looks like you already made up your mind. I think I'll need more
>> arguments in favor of a EVIOCGRAB for the hidraw node. For now, I can
>> not see a benefit beside your use case, which I am not very found of
>> (you must have noticed :-P ).
>> You can still try to write one patch for it, I don't know if Jiri will
>> take it though (I can try to restrain myself to NACK it).
>
> I do have most of the hidraw code ready. I would be happy to use kernel
> input driver if it existed. But as said, I don't currently have time to
> do it. Perhaps later on I'll clean it up and do it like that. But it
> would not be anytime soon.
>
> I still find using hidraw like this be the better option. The
> manufacturer's Linux example uses libusb to detach kernel drivers, claim
> the whole device, and implement the HID stuff in userland:
> https://github.com/piengineering/xkeys/
> http://xkeys.com/PISupport/DeveloperLinuxSDK.php
>
>> If all you need is a way to switch off the input reporting, how about
>> you add a simple hid driver that binds to your devices and has a
>> parameter (or a sysfs file) which returns -1 in .input_event() when
>> the flag is set. This way the device won't send events to the
>> userspace but will keep forwarding hidraw events.
>
> Well - I thought this functionality would be useful to others, so I
> was hoping a generic way to do it. Not something specific to my
> devices. But apparently your argument is "people will misuse it and I
> don't want to allow it in general".

yep. Everything we add in the kernel is here for life. Adding an ioctl
is not something we take easily, and if it is a security problem, it's
even worse.
I think you should not look for something generic at this point, but
something which works for these specific devices first.

>
> I'd be ok with the hid-rawonly driver as long as it's made non-device
> spefic and could be upstreamed. Perhaps ship the list of VIDs/PIDs as
> boot option. Or could the existing quirks system be used for this?

None of the existing quirks will work for your use case. So if you
want to go this way, you'll have to submit the corresponding patch.

Cheers,
Benjamin

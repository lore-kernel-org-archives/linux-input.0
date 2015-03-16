From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: hidraw with exclusive access ?
Date: Mon, 16 Mar 2015 16:44:37 -0400
Message-ID: <CAN+gG=Hsbf1WyBNmt=m+MHyiKVJBmzY+-MGD4qf9PSOab0U7PQ@mail.gmail.com>
References: <20150313083758.076c8dfb@vostro>
	<CAN+gG=GdNpqDTazZD6_4r8AmWqbZg-_w8M2-6PDdvKjwdFfFWw@mail.gmail.com>
	<20150316203912.75b32686@vostro>
	<CAN+gG=FXY9m8ygQ+e_JCt=7m3+mRHCYiDLmwggpHQbSDD6etvA@mail.gmail.com>
	<20150316221733.158c4943@vostro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47]:33383 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933043AbbCPUoh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Mar 2015 16:44:37 -0400
Received: by qgfa8 with SMTP id a8so51731317qgf.0
        for <linux-input@vger.kernel.org>; Mon, 16 Mar 2015 13:44:37 -0700 (PDT)
In-Reply-To: <20150316221733.158c4943@vostro>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Timo Teras <timo.teras@iki.fi>
Cc: linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>

On Mon, Mar 16, 2015 at 4:17 PM, Timo Teras <timo.teras@iki.fi> wrote:
> On Mon, 16 Mar 2015 15:15:33 -0400
> Benjamin Tissoires <benjamin.tissoires@gmail.com> wrote:
>
>> On Mon, Mar 16, 2015 at 2:39 PM, Timo Teras <timo.teras@iki.fi> wrote:
>> > On Mon, 16 Mar 2015 11:29:10 -0400
>> > Benjamin Tissoires <benjamin.tissoires@gmail.com> wrote:
>> >
>> >> On Fri, Mar 13, 2015 at 2:37 AM, Timo Teras <timo.teras@iki.fi>
>> >> wrote:
>> >> > As an alternative I think we could have hid-rawonly driver, that
>> >> > would by default bind to nothing. And when bound, would connect
>> >> > to the hid device with HID_CONNECT_HIDRAW flag only. I could
>> >> > then in userland rebind the device from hid-generic to
>> >> > hid-rawonly.
>> >>
>> >> That could work (make a special driver and use HID_CONNECT_HIDRAW),
>> >> but that's a terrible idea and will be refused I guess.
>> >> Users expects their keyboard to be working everywhere, even at boot
>> >> and in the console. By doing so, you will just break existing
>> >> keyboards.
>> >
>> > No. The whole point was to have driver that is not automatically
>> > bound to anything. So we would not break anything existing. You'd
>> > get that driver only by manual rebinding via sysfs.
>>
>> Hmm, still not convinced by the manual re-binding through sysfs. If
>> the keyboard does not work directly with the generic hid protocol or
>> send garbage that users can not deal with, then why not simply bind it
>> to the hidraw driver only?
>
> They are complicated and configurable devices. They can work in the
> macro mode, and I believe the device can send a sequence of keypresses
> - at least some of them, but not all. Additionally some of the devices
> appear as multiple HID devices. E.g. the joystick models show up as
> three HID devices: their "SPLAT" interface, one keyboard and one
> joystick (or mouse) device.
>
> It might make sense to allow the Joystick to show up as regular
> joystick by default. But to make the SPLAT interface work properly,
> also the other HID events need to be processed. So currently I have
> code that reads all three related hidraw devices, but acts only based
> on the SPLAT one.

IMO, none of this seems to be valid reasons to not look into a kernel
solution. you can have cross hid interface knowledge in the driver
(that's what wacom does) and you can fine control what you want to
forward from within the driver.

>
> It also depends on the device model whether or not it generates
> "conflicting" input events that I'd like to suppress.
>
> In any case, the simplest way for me to was to use hidraw devices.. As
> I'm using dedicated machine, there's no real harm by the conflicting
> input events (as no X is running currently). The only annoyance is the
> dmesg errors about bad input events. But if I ever build boxes running
> also X, it'll be a problem. That's why'd appreciate a way to grab the
> hidraw device.
>
>> >> > Or finally, to implement a full kernel side driver it. But I'd
>> >> > rather not go there. Especially since the device has multiple
>> >> > leds, and the input system allows only limited leds. (The leds
>> >> > could be exported as led devices, but then I'd need more
>> >> > userland logic to figure out which led devices map to which
>> >> > input device.)
>> >>
>> >> No, that's not true. If you have LEDs, then use the LED class and
>> >> then user space deal with the LEDs. If the LEDs are not standard,
>> >> then you will need userspace tools to access them so I don't think
>> >> it is a problem. Standard LEDs will be handled properly through
>> >> the input node (CAPS Lock, Ver Num, etc...).
>> >
>> > There's individial LEDs per each key. Namely I'm looking at the
>> > devices at: http://xkeys.com/XkeysKeyboards/index.php
>> >
>> > The protocol they run is published at:
>> > http://xkeys.com/PISupport/DeveloperHIDDataReports.php
>> >
>> > And as mentioned - it'd be lot of work to combine which LED is for
>> > which key.
>>
>> Then in that case, why not exporting your own sysfs interface to
>> illuminate the LEDs and set the macro?
>>
>> We do that for the OLED of the wacom device, and that's fine (I
>> guess).
>
> I found it simpler to implement the protocol in my app, instead of
> writing a kernel interface for it. Doing the kernel driver would make

But this way, only your application can make use of the device. Others
will have to duplicate it or reinvent the logic if they want to use an
other environment You made reference at one point of a program in
python, and I guess people might not want to have python daemon
running in the background. Even if your driver is written in C or any
other language, people won't have a generic access to it.

> more sense if there was a way to map LEDs to keys already. Otherwise
> I'm just inventing an abstraction that just makes me write more code...
> and will probably eventually be replaced by something else.

I doubt that this will be so much of a pain. You just have to port
your code in the kernel and have a small char sysfs interface to
design. And even if something else is more powerful that your custom
made interface, for legacy purposes, we will have to keep it in the
kernel.

>
>> >> The good side of having your driver in the kernel is also less
>> >> maintenance, and less pain for the users. Once it hits mainline,
>> >> users will have a functional keyboard without having to rely on
>> >> anything else. For you, if some interface change, you will have
>> >> less head aches.
>> >>
>> >> If you *really* don't want to work in the kernel, you should simply
>> >> ignore the generic keys in your driver and work only on the special
>> >> keys macros that you want to support.
>> >
>> > It's not possible. Few of the generic keys default to mouse buttons.
>> > Those I'd like to ignore.
>> >
>> > In fact, there's already some code out there that use hidraw and
>> > feed the application from it. The code also opens the corresponding
>> > input device with grab to make sure the events do not leak out to
>> > x11. So I'm not the only one wanting to do this.
>>
>> So, IMO you can approach the problem through 2 ways:
>> - make a short out-of-the-tree driver for the X-keys that bind only to
>> hidraw, when you launch the user-space driver, unbind hid-generic and
>> bind the device to your small driver and then deal with the keyboard
>> in userspace.
>> - keep the kernel input node, reimplement the .raw_event() in the
>> kernel driver, and provide a control API through sysfs.
>>
>> The second way allows you to have a UI/config tool which is not a
>> daemon and which just controls what the kernel does.
>
> I'd like to have a generic in-tree solution. For my immediate needs,
> I'd be happy using hidraw as long as I have some mechanism to exclude
> feeding that HID device to regular input system.

Looks like you already made up your mind. I think I'll need more
arguments in favor of a EVIOCGRAB for the hidraw node. For now, I can
not see a benefit beside your use case, which I am not very found of
(you must have noticed :-P ).
You can still try to write one patch for it, I don't know if Jiri will
take it though (I can try to restrain myself to NACK it).

If all you need is a way to switch off the input reporting, how about
you add a simple hid driver that binds to your devices and has a
parameter (or a sysfs file) which returns -1 in .input_event() when
the flag is set. This way the device won't send events to the
userspace but will keep forwarding hidraw events.

>
>> BTW, I guessed that the macros are not stored in the keyboard but
>> rather in your user-space program. If the macros are actually stored
>> and generated by the device itself, then I think fixing the kernel to
>> handle them would be a better path, and you need hidraw only to
>> configure the device.
>
> As said, depends likely on the device, and the way it is configured.
> But to make the backlighting control work usage of the SPLAT interface
> is required.
>
> Btw. one example of code trying to accomplish something similar is:
> https://github.com/chrippa/ds4drv/blob/master/ds4drv/backends/hidraw.py
> it uses and parses the hidraw stuff, but also opens the corresponding
> input device just to grab it for exclusive access.
>


Cheers,
Benjamin
